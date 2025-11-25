```mermaid
flowchart BT
    vpc.publicAdmin ~~~ mdb.admin
    mdb.viewer --> mdb.admin
    mdb.auditor --> mdb.viewer
    mdb.viewer --> mdb.restorer
    managed-spqr.restorer --> mdb.restorer
    managed-spqr.admin --> mdb.admin
    managed-spqr.viewer --> mdb.viewer
    managed-spqr.auditor --> mdb.auditor    
    managed-spqr.editor --> managed-spqr.admin
    managed-spqr.viewer --> managed-spqr.restorer
    managed-spqr.restorer --> managed-spqr.editor
    managed-spqr.auditor --> managed-spqr.viewer
```