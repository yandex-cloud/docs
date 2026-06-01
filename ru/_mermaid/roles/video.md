```mermaid
%%{init: {"flowchart": {'defaultRenderer': 'elk'}} }%%
flowchart BT
    video.auditor --> video.viewer
    video.viewer --> video.editor
    video.editor --> video.admin
```
