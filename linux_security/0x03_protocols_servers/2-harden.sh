#!/bin/bash
find / -xdev -type d -perm -0002 -exec chmod 0-w {}
