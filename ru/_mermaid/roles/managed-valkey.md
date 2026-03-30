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
    managed-redis.switcher --> managed-redis.editor
    managed-redis.viewer --> managed-redis.switcher
    managed-redis.maintenanceTask.editor --> managed-redis.editor
    managed-redis.maintenanceTask.viewer --> managed-redis.viewer
    managed-redis.user --> managed-redis.editor
    managed-redis.auditor --> managed-redis.viewer
    managed-redis.auditor --> managed-redis.maintenanceTask.viewer["`managed-redis.
    maintenanceTask.viewer`"]
    managed-redis.maintenanceTask.viewer --> managed-redis.maintenanceTask.editor["`managed-redis.
    maintenanceTask.editor`"]
```