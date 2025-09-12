QA SSRF Server-Side Request Forgery

1. What is SSRF?
SSRF is a vulnerability where an attacker tricks a server into making requests to internal or external resources. It targets the server rather than the client.
2. How Does SSRF Work?
It occurs when a server fetches URLs or endpoints provided by users. If not validated, attackers can supply malicious or internal URLs, causing the server to perform unintended requests.
3. What is an SSRF Attack and How Does it Work?
Attackers exploit SSRF to access internal systems, sensitive data, or cloud metadata. The server acts as a proxy, and the attacker can receive data or trigger actions indirectly.
4. Types of SSRF Attacks
- Basic SSRF: attacker sees server responses directly.
- Blind SSRF: no direct response, effects observed indirectly.
 Variants include attacks on internal ports, cloud metadata, or non-HTTP protocols.

5. Impact of SSRF Attacks
Can lead to data theft, internal network access, server compromise, and pivoting to other systems. Combined with other vulnerabilities, it can fully compromise the server.
6. Risks of SSRF
Exposure of internal/confidential data
Service compromise (APIs, admin panels)
Reputation and financial damage from data leaks or misused services

7. Common SSRF Attack Scenarios
Accessing cloud metadata (AWS/GCP/Azure)
Scanning internal networks
Exfiltrating local files (/etc/passwd)
Bypassing firewalls to attack protected systems

8. How to Protect Against SSRF Attacks
Whitelist domains and protocols
Block internal/private IP ranges
Restrict outgoing requests to necessary services only
Disable DNS resolution for internal addresses
Monitor and log outgoing requests for anomalies

9. Preventing SSRF – Key Points
Validation, network restrictions, protocol limitations, and logging are essential. Always assume untrusted input could lead to internal or sensitive resource exposure.
