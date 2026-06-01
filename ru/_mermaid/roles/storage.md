```mermaid
%%{init: {"flowchart": {'defaultRenderer': 'elk'}} }%%
flowchart BT
    storage.editor --> storage.admin
    storage.configurer --> storage.admin
    storage.configViewer --> storage.admin
    storage.uploader --> storage.editor
    storage.viewer --> storage.uploader 
```
