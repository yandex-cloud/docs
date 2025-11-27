```mermaid
flowchart BT
    baremetal.editor --> baremetal.admin
    baremetal.viewer --> baremetal.operator
    baremetal.operator --> baremetal.editor
    baremetal.auditor --> baremetal.viewer
```