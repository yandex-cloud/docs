```mermaid
flowchart BT
    dns.auditor --> dns.viewer
    dns.auditor --> dns.firewallUser
    dns.firewallUser --> dns.firewallEditor
    dns.firewallEditor --> dns.admin
    dns.viewer --> dns.editor
    dns.editor --> dns.admin
```