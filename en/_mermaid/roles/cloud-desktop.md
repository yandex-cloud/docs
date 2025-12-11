```mermaid
flowchart BT
    vdi.desktopGroups.maintainer --> vdi.admin
    vdi.editor --> vdi.admin
    vdi.viewer --> vdi.editor
    vdi.desktopGroups.user --> vdi.editor
    vdi.desktopGroups.user --> vdi.desktopGroups.maintainer
    vdi.auditor --> vdi.viewer
```