```mermaid
flowchart BT
    certificate-manager.editor --> certificate-manager.admin
    certificate-manager.certificates.downloader ----> certificate-manager.admin
    certificate-manager.viewer --> certificate-manager.editor
    certificate-manager.auditor --> certificate-manager.viewer
```