### QA Web Application Forensics

## 1. What is Digital Forensics?
Digital Forensics is the process of identifying, preserving, analyzing, and presenting digital evidence in a structured way. It is used in cases of cybercrime, fraud, hacking, or legal disputes where digital proof is needed. Investigators create exact copies of data to avoid altering the original. The ultimate goal is to reconstruct events and provide reliable evidence in court.

## 2. What are the core concepts of Web Application Forensics?
Web Application Forensics focuses on analyzing websites, servers, and online services after an attack. It studies elements like logs, user sessions, cookies, tokens, and database interactions. Typical attacks include SQL Injection, Cross-Site Scripting (XSS), and Cross-Site Request Forgery (CSRF). The investigator’s task is to connect traces left in the system and build a timeline of the attack.

#  3. How to analyze Web Application Logs?
Logs record all requests and errors that occur on a web server or application. Access logs show who visited, when, and from where, while error logs highlight failed attempts or crashes. Investigators analyze these to spot unusual activity, such as repeated login failures or suspicious queries. By correlating logs with user actions, it becomes possible to identify compromised accounts or intrusion attempts.

## 4. How can Log Files and Access Logs trace the origin of an attack?
Log files are like footprints of every action on a web server. They reveal IP addresses, timestamps, requested pages, and user agents, which can link back to an attacker. By following these traces, investigators can reconstruct the attacker’s path step by step. Even if attackers hide behind VPNs or proxies, log correlation often reveals patterns connecting different attacks.

## 5. How to use Wireshark and Burp Suite in investigations?
Wireshark is a network analysis tool that captures and inspects packets, helping detect suspicious data transfers or malicious traffic. Burp Suite, on the other hand, is designed for web applications, allowing interception and modification of HTTP requests. In forensic work, these tools help reproduce the attacker’s actions and understand exploited vulnerabilities. They are not for attacking, but for reconstructing what has already happened.

## 6. What are the Legal Frameworks and Best Practices?
Forensic investigations must respect legal boundaries so that evidence is admissible in court. The chain of custody must be maintained: every action on the evidence must be documented. Privacy laws (like GDPR in Europe) also regulate what investigators can or cannot analyze. Best practices include working on copies, documenting all steps, and using validated forensic tools.

