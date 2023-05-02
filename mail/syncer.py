"""
Runs `offlineimap` concurrently for the accounts
and then counts number of unread threads in account/inbox/new/

If error encountered during syncing - writes errorcode to ~/mail/errors file.
If new mail exists - writes numbers to ~/mail/unread file.

This is then parsed by starship.rs custom widget (see config/starship.conf file)

Currently accounts are hardcoded, because I'm lazy.

Also plays sound on error or on new emails using mpv.
"""
import os
import asyncio
from typing import Optional, List, Tuple

DIRNAME = os.path.abspath(os.path.expanduser("~/mail"))
UNREAD_FILE = os.path.join(DIRNAME, "unread")
ERRORS_FILE = os.path.join(DIRNAME, "errors")
NOTIFICATIONS_FILE = os.path.join(DIRNAME, "notifications")
ACCOUNTS = ["personal", "planqc", "swan"]

async def run_command(command: str) -> Tuple[int, bytes, bytes]:
    process = await asyncio.create_subprocess_shell(
        command,
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.PIPE
    )
    stdout, stderr = await process.communicate()
    print(f"{command} done: returncode: {process.returncode}")
    print("stdout:", stdout.decode())
    print("stderr:", stderr.decode())
    return process.returncode, stdout, stderr


async def sync_account(account: Optional[str] = None) -> Tuple[int, bytes, bytes]:
    """Syncs one account, returns a tuple (returncode, stdout, stderr)"""
    command = "offlineimap"
    if account:
        command = f"offlineimap -a {account}"
    print(f"syncing {account}...")
    return await run_command(command)


async def sync_all(accounts: List[str] = ACCOUNTS):
    tasks = [
        asyncio.create_task(sync_account(account))
        for account in accounts
    ]
    results = await asyncio.gather(*tasks)
    # filter out successful runs
    errors = [r for r in results if r[0] != 0]
    return errors


def check_unread(dir_path = DIRNAME):
    threads = set()
    unread = 0
    for root, dirs, files in os.walk(dir_path):
        if 'new' in dirs and "inbox" in root.lower():
            new_folder_path = os.path.join(root, 'new')
            delta = 0
            for filename in os.listdir(new_folder_path):
                threads.add(filename.split("_")[0])
                delta += 1
            unread += delta
    return len(threads), unread

async def main():
    sync_errors = await sync_all(ACCOUNTS)
    if sync_errors:
        with open(ERRORS_FILE, "wb") as f:
            for returncode, stdout, stderr in sync_errors:
                f.write(f"errorcode {returncode}\n".encode())
                f.write(stdout)
                f.write(stderr)
    else:
        res = [
            check_unread(os.path.join(DIRNAME, acc))[0]
            for acc in ACCOUNTS
        ]
        with open(ERRORS_FILE, "w") as f:
            f.write("")
        with open(UNREAD_FILE, "r") as f:
            prev = f.read()
        with open(UNREAD_FILE, "w") as f:
            f.write("")
            if sum(res) > 0:
                f.write("/".join([str(u) for u in res]))
        prevres = 0
        if prev:
            prevres = sum([int(v) for v in prev.split("/")])
        if prevres < sum(res):
            # notify zmux
            new_emails = sum(res)-prevres
            with open(NOTIFICATIONS_FILE, "w") as f:
                f.write(f"{new_emails} new emails!") 

if __name__ == '__main__':
    asyncio.run(main())
