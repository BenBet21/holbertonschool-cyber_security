#!/usr/bin/env python3
"""
Module read_write_heap

This script locates a given ASCII string in the heap of a running process,
and replaces it with another ASCII string of equal or lesser length.

Usage: read_write_heap.py pid search_string replace_string
"""

import sys


def error_exit(message):
    """
    Print an error message to stdout and exit with status code 1.
    """
    print(message)
    sys.exit(1)


def get_heap_bounds(pid):
    """
    Parse /proc/[pid]/maps to find the heap segment start and end addresses.

    Args:
        pid (str): Process ID

    Returns:
        tuple: (start_address, end_address) as integers

    Raises:
        SystemExit: if the heap segment is not found
    """
    try:
        with open(f"/proc/{pid}/maps", "r") as maps_file:
            for line in maps_file:
                if "[heap]" in line:
                    parts = line.split()
                    addr_range = parts[0]
                    start_str, end_str = addr_range.split("-")
                    return int(start_str, 16), int(end_str, 16)
    except FileNotFoundError:
        error_exit(f"Process with PID {pid} not found.")
    except Exception as e:
        error_exit(f"Error reading memory maps: {e}")

    error_exit("Heap segment not found.")


def search_and_replace(pid, search_bytes, replace_bytes, heap_start, heap_end):
    """
    Search for a byte string in the heap memory and replace it.

    Args:
        pid (str): Process ID
        search_bytes (bytes): Byte sequence to find
        replace_bytes (bytes): Byte sequence to replace with
        heap_start (int): Start address of the heap
        heap_end (int): End address of the heap

    Raises:
        SystemExit: if permission is denied or string not found
    """
    try:
        with open(f"/proc/{pid}/mem", "r+b") as mem_file:
            mem_file.seek(heap_start)
            heap_data = mem_file.read(heap_end - heap_start)

            offset = heap_data.find(search_bytes)
            if offset == -1:
                error_exit("String not found in heap.")

            mem_file.seek(heap_start + offset)
            padded_replace = replace_bytes + b'\x00' * (len(search_bytes) - len(replace_bytes))
            mem_file.write(padded_replace)

            print(f"Replaced '{search_bytes.decode()}' with '{replace_bytes.decode()}' "
                  f"at address {hex(heap_start + offset)}")

    except PermissionError:
        error_exit("Permission denied. Try running with sudo.")
    except Exception as e:
        error_exit(f"Memory access error: {e}")


def main():
    """
    Main function: Parses arguments and triggers the search and replace in heap.
    """
    if len(sys.argv) != 4:
        error_exit("Usage: read_write_heap.py pid search_string replace_string")

    pid = sys.argv[1]
    search_str = sys.argv[2]
    replace_str = sys.argv[3]

    if not search_str.isascii() or not replace_str.isascii():
        error_exit("Both strings must be ASCII.")

    if len(replace_str) > len(search_str):
        error_exit("replace_string must not be longer than search_string.")

    search_bytes = search_str.encode()
    replace_bytes = replace_str.encode()

    heap_start, heap_end = get_heap_bounds(pid)
    search_and_replace(pid, search_bytes, replace_bytes, heap_start, heap_end)


if __name__ == "__main__":
    main()
