```mermaid
flowchart BT
    vpc.publicAdmin ~~~ mdb.admin
    mdb.viewer --> mdb.admin
    mdb.auditor --> mdb.viewer
    mdb.viewer --> mdb.restorer
    managed-redis.auditor --> mdb.auditor
    managed-redis.viewer --> mdb.viewer
    managed-redis.restorer --> mdb.restorer
    managed-redis.admin --> mdb.admin
    managed-redis.editor --> managed-redis.admin
    managed-redis.viewer --> managed-redis.restorer
    managed-redis.restorer --> managed-redis.editor
    managed-redis.auditor --> managed-redis.viewer
```