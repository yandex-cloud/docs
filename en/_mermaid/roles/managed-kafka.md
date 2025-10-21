```mermaid
flowchart BT
    vpc.publicAdmin ~~~ mdb.admin
    mdb.viewer --> mdb.admin
    managed-kafka.admin --> mdb.admin
    managed-kafka.editor --> managed-kafka.admin
    mdb.auditor --> mdb.viewer
    managed-kafka.viewer --> mdb.viewer
    managed-kafka.viewer --> managed-kafka.editor
    managed-kafka.interfaceUser --> managed-kafka.editor
    managed-kafka.auditor --> managed-kafka.viewer
    managed-kafka.auditor --> mdb.auditor
```