```mermaid
%%{init: {"flowchart": {'defaultRenderer': 'elk'}} }%%
flowchart BT
resource-manager.auditor --> resource-manager.viewer --> resource-manager.editor --> resource-manager.admin --> resource-manager.clouds.owner
resource-manager.clouds.member --> resource-manager.clouds.owner
```
