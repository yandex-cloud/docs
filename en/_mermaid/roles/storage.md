```mermaid
flowchart BT
    storage.editor --> storage.admin
    storage.configurer --> storage.admin
    storage.configviewer --> storage.admin
    storage.uploader --> storage.editor
    storage.viewer --> storage.uploader 
```