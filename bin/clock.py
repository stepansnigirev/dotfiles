#!/usr/bin/env python3

import curses
import time
from datetime import datetime


def fit_text(stdscr, text):
    h, w = stdscr.getmaxyx()

    # Leave ~30% padding overall

    usable_w = int(w * 0.7)
    usable_h = int(h * 0.7)

    # Basic scalable ASCII digits
    font = {
        "0": [
            "███████",
            "██   ██",
            "██   ██",
            "██   ██",
            "███████",
        ],
        "1": [
            " ████  ",
            "   ██  ",
            "   ██  ",
            "   ██  ",
            " ██████",
        ],
        "2": [
            "███████",
            "     ██",
            "███████",
            "██     ",
            "███████",
        ],
        "3": [
            "███████",
            "     ██",
            "███████",
            "     ██",
            "███████",
        ],
        "4": [
            "██   ██",
            "██   ██",
            "███████",
            "     ██",
            "     ██",
        ],
        "5": [
            "███████",
            "██     ",
            "███████",
            "     ██",
            "███████",
        ],
        "6": [
            "███████",
            "██     ",
            "███████",
            "██   ██",
            "███████",
        ],
        "7": [
            "███████",
            "     ██",
            "     ██",
            "     ██",
            "     ██",
        ],
        "8": [
            "███████",
            "██   ██",
            "███████",
            "██   ██",
            "███████",
        ],
        "9": [
            "███████",
            "██   ██",
            "███████",
            "     ██",
            "███████",
        ],

        ":": [
            "  ",
            "██",
            "  ",
            "██",
            "  ",
        ],
    }

    base_height = 5
    base_width = sum(len(font[c][0]) + 1 for c in text)


    scale_x = max(1, usable_w // base_width)
    scale_y = max(1, usable_h // base_height)

    scale = min(scale_x, scale_y)

    rendered = []

    for row in range(base_height):
        line = ""

        for ch in text:
            glyph = font[ch][row]

            for c in glyph:
                line += c * scale

            line += "  " * scale

        # vertical scaling
        for _ in range(scale):
            rendered.append(line)

    return rendered


def draw_centered(stdscr, lines):
    h, w = stdscr.getmaxyx()

    total_h = len(lines)
    total_w = max(len(line) for line in lines)

    y0 = max(0, (h - total_h) // 2)
    x0 = max(0, (w - total_w) // 2)

    for i, line in enumerate(lines):
        if y0 + i >= h:
            break

        try:
            stdscr.addstr(y0 + i, x0, line[:w - 1])
        except curses.error:
            pass


def main(stdscr):
    curses.curs_set(0)
    stdscr.nodelay(True)

    while True:
        stdscr.erase()
        now = datetime.now().strftime("%H:%M:%S")

        lines = fit_text(stdscr, now)
        draw_centered(stdscr, lines)

        stdscr.refresh()

        key = stdscr.getch()
        if key in (ord("q"), 27):
            break

        time.sleep(0.1)


if __name__ == "__main__":
    curses.wrapper(main)
