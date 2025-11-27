```mermaid
flowchart BT
    dataproc.auditor --> dataproc.viewer
    dataproc.viewer --> dataproc.user
    mdb.viewer --> dataproc.user
    mdb.viewer --> mdb.admin
    mdb.auditor --> mdb.viewer
    dataproc.provisioner ~~~ dataproc.agent
    dataproc.user --> dataproc.editor
    dataproc.editor --> dataproc.admin
    dataproc.viewer --> mdb.viewer
    dataproc.admin --> mdb.admin 
```