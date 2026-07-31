```mermaid
%%{init: {"flowchart": {'defaultRenderer': 'elk'}} }%%
flowchart BT
    yds.writer --> yds.editor
    ydb.editor --> yds.editor
    yds.viewer --> yds.editor
    ydb.admin --> yds.admin
    ydb.editor --> ydb.admin
    ydb.viewer --> yds.viewer
    ydb.auditor --> yds.auditor
    ydb.viewer --> ydb.editor
    ydb.auditor --> ydb.viewer
```
