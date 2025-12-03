```mermaid
flowchart BT
    yds.editor ~~~ yds.admin
    ydb.editor --> yds.editor
    yds.viewer --> yds.editor
    yds.auditor ~~~ yds.viewer
    ydb.admin --> yds.admin
    ydb.editor --> ydb.admin
    yds.writer --> yds.editor
    ydb.viewer --> yds.viewer
    ydb.auditor --> yds.auditor
    ydb.viewer --> ydb.editor
    ydb.auditor --> ydb.viewer
```