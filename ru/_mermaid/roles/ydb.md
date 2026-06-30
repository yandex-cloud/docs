```mermaid
%%{init: {"flowchart": {'defaultRenderer': 'elk'}} }%%
flowchart BT
    ydb.editor --> ydb.admin
    ydb.viewer --> ydb.editor
    ydb.auditor --> ydb.viewer
    ydb.kafkaApi.client
```
