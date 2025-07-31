#!/usr/bin/env python3
import sys
import os

def error_exit(msg):
    print(msg)
    exit(1)

if len(sys.argv) != 4:
    error_exit("Usage: read_write_heap.py pid search_string replace_string")

pid = sys.argv[1]
search = sys.argv[2].encode()       # En binaire
replace = sys.argv[3].encode()

if len(replace) > len(search):
    error_exit("Error: replace_string must not be longer than search_string")

# 1. Trouver la région HEAP dans /proc/PID/maps
try:
    with open(f"/proc/{pid}/maps", "r") as maps_file:
        heap_start = None
        heap_end = None
        for line in maps_file:
            if "[heap]" in line:
                parts = line.split()
                addr = parts[0]
                heap_start, heap_end = [int(x, 16) for x in addr.split("-")]
                break
        if heap_start is None:
            error_exit("Heap not found.")
except FileNotFoundError:
    error_exit(f"Process {pid} does not exist.")

# 2. Lire la mémoire dans /proc/PID/mem entre heap_start et heap_end
try:
    mem_path = f"/proc/{pid}/mem"
    with open(mem_path, "r+b") as mem_file:
        mem_file.seek(heap_start)
        heap_data = mem_file.read(heap_end - heap_start)

        # 3. Chercher la chaîne
        offset = heap_data.find(search)
        if offset == -1:
            error_exit("String not found in heap.")

        # 4. Aller à la bonne adresse et écrire le remplacement
        mem_file.seek(heap_start + offset)
        mem_file.write(replace + b'\x00' * (len(search) - len(replace)))  # Pad si remplacement plus court

        print(f"Replaced '{search.decode()}' with '{replace.decode()}' at address {hex(heap_start + offset)}")
except PermissionError:
    error_exit("Permission denied. Try running with sudo.")
