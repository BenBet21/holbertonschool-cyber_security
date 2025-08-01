#!/usr/bin/env python3
"""
Module read_write_heap

This script locates a given ASCII string in the heap of a running process,
and replaces it with another ASCII string of equal or lesser length.

Usage: read_write_heap.py pid search_string replace_string
"""

import sys
import os


def error_exit(message):
    """
    Print an error message to stdout and exit with status code 1.

    Args:
        message (str): Error message to display.
    """
    print(message)
    sys.exit(1)


def read_write_heap(pid, search_string, replace_string):
    """Find and replace a string in the heap of a process."""
    try:
        pid = int(pid)
    except ValueError:
        error_exit("PID must be a valid integer.")

    maps_path = f"/proc/{pid}/maps"
    mem_path = f"/proc/{pid}/mem"

    try:
        with open(maps_path, "r") as maps_file:
            heap = None
            for line in maps_file:
                if "[heap]" in line:
                    heap = line
                    break

            if not heap:
                error_exit("Heap segment not found.")

            heap_start, heap_end = [int(x, 16) for x in
                                    heap.split()[0].split("-")]

        with open(mem_path, "r+b") as mem_file:
            mem_file.seek(heap_start)
            heap_data = mem_file.read(heap_end - heap_start)

            search_bytes = search_string.encode()
            replace_bytes = replace_string.encode()

            if len(replace_bytes) > len(search_bytes):
                error_exit("replace_string must not be longer than "
                           "search_string.")

            offset = heap_data.find(search_bytes)
            if offset == -1:
                error_exit("String not found in heap.")

            mem_file.seek(heap_start + offset)
            mem_file.write(replace_bytes.ljust(len(search_bytes), b'\x00'))

            print(f"Replaced '{search_string}' with '{replace_string}' "
                  f"at address {hex(heap_start + offset)}")

    except PermissionError:
        error_exit("Permission denied. Try running with sudo.")
    except FileNotFoundError:
        error_exit("Process not found.")
    except Exception as e:
        error_exit(f"Memory access error: {e}")


def main():
    """
    Main function: Parses arguments and triggers
    the search and replace in heap.
    """
    if len(sys.argv) != 4:
        error_exit("Usage: read_write_heap.py pid "
                   "search_string replace_string")

    pid = sys.argv[1]
    search_str = sys.argv[2]
    replace_str = sys.argv[3]

    if not search_str.isascii() or not replace_str.isascii():
        error_exit("Both strings must be ASCII.")

    read_write_heap(pid, search_str, replace_str)


if __name__ == "__main__":
    main()
