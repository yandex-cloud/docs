```mermaid
---
config:
  flowchart:
    defaultRenderer: elk
---
flowchart BT
    alb.auditor --> alb.viewer
    alb.viewer --> alb.user
    alb.user --> alb.editor
    alb.editor --> alb.admin
```
