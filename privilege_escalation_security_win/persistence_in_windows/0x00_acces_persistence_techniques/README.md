# Access Persistence Techniques

This folder documents my practical work on Windows persistence mechanisms, completed as part of my cybersecurity specialization at Holberton School.

Persistence is one of the core stages of an attack lifecycle — once an attacker gains initial access, the priority is to survive reboots, session closures, and basic remediation attempts. Understanding how persistence is established is a prerequisite for detecting and dismantling it in a SOC environment.

The labs covered here explore the main persistence vectors on Windows systems: Startup folders, registry Run keys, scheduled tasks, DLL hijacking, WMI event subscriptions, and BITS job abuse. Each exercise was completed on an isolated lab machine, combining manual investigation with PowerShell-based forensic analysis.

This work directly supports my role as a SOC analyst apprentice, where identifying persistence indicators in SIEM alerts (SEKOIA) is a day-to-day responsibility.
