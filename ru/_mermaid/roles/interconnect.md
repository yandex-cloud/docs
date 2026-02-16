```mermaid
flowchart BT
    cic.auditor --> cic.viewer
    cic.viewer --> cic.editor
    cic.editor --> cic.admin
    cic.secretViewer --> cic.secretEditor
```