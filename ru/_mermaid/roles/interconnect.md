```mermaid
flowchart BT
    cic.auditor --> cic.viewer
    cic.viewer --> cic.editor
    cic.viewer --> cic.secretViewer
    cic.secretViewer --> cic.secretEditor
```