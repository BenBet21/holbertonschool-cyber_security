#!/bin/bash
grep -v -E '^\s*#|^\s*$' /etc/ssh/sshd_config
