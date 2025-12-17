```mermaid
flowchart BT
    vpc.publicAdmin ~~~ mdb.admin
    mdb.viewer --> mdb.admin
    mdb.auditor --> mdb.viewer
    mdb.viewer --> mdb.restorer
    managed-mongodb.restorer --> mdb.restorer
    managed-mongodb.admin --> mdb.admin
    managed-mongodb.viewer --> mdb.viewer
    managed-mongodb.auditor --> mdb.auditor
    managed-mongodb.editor --> managed-mongodb.admin
    managed-mongodb.viewer --> managed-mongodb.restorer
    managed-mongodb.restorer --> managed-mongodb.editor
    managed-mongodb.auditor --> managed-mongodb.viewer
```