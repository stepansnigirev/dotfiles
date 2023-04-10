"""
Runs `offlineimap` and then counts number of unread threads in account/inbox/new/

If error encountered during syncing - writes errorcode to ~/mail/errors file.
If new mail exists - writes numbers to ~/mail/unread file.

This is then parsed by starship.rs custom widget (see config/starship.conf file)

Currently accounts are hardcoded, because I'm lazy.
"""
import os
import subprocess

DIRNAME = os.path.expanduser("~/mail")
UNREAD_FILE = os.path.join(DIRNAME, "unread")
ERRORS_FILE = os.path.join(DIRNAME, "errors")
ACCOUNTS = ["personal", "planqc", "swan"]

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

def main():
    result = subprocess.run(['offlineimap'], capture_output=True)
    if result.returncode != 0:
        with open(ERRORS_FILE, "w") as f:
            f.write(f"errorcode {result.returncode}")
    else:
        res = [
            check_unread(os.path.join(DIRNAME, acc))[0]
            for acc in ACCOUNTS
        ]
        with open(ERRORS_FILE, "w") as f:
            pass
        with open(UNREAD_FILE, "w") as f:
            if sum(res) > 0:
                f.write("/".join([str(u) for u in res]))

if __name__ == "__main__":
    main()
