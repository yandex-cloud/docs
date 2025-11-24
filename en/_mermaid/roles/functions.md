```mermaid
flowchart BT
    functions.editor --> functions.admin
    functions.mdbProxiesUser --> functions.editor
    functions.viewer --> functions.editor
    functions.functionInvoker --> functions.editor
    functions.auditor --> functions.viewer
```