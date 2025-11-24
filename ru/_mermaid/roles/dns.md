```mermaid
flowchart BT
    dns.auditor --> dns.viewer
    dns.viewer --> dns.editor
    dns.editor --> dns.admin
```