```mermaid
flowchart BT
    search-api.auditor --> search-api.viewer
    search-api.webSearch.user --> search-api.editor
    search-api.viewer --> search-api.editor
    search-api.executor --> search-api.editor
    search-api.editor --> search-api.admin
```