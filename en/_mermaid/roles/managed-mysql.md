```mermaid
flowchart BT
    managed-mysql.clusters.connector["`managed-mysql.
    clusters.connector`"] ~~~ mdb.auditor
    vpc.publicAdmin ~~~ mdb.admin
    mdb.viewer --> mdb.admin
    mdb.auditor --> mdb.viewer
    mdb.viewer --> mdb.restorer
    managed-mysql.auditor --> mdb.auditor
    managed-mysql.viewer --> mdb.viewer
    managed-mysql.restorer --> mdb.restorer
    managed-mysql.admin --> mdb.admin
    managed-mysql.auditor --> managed-mysql.viewer
    managed-mysql.restorer --> managed-mysql.editor
    managed-mysql.viewer --> managed-mysql.restorer
    managed-mysql.switcher --> managed-mysql.editor
    managed-mysql.viewer --> managed-mysql.switcher
    managed-mysql.maintenanceTask.editor --> managed-mysql.editor
    managed-mysql.maintenanceTask.viewer --> managed-mysql.maintenanceTask.editor["`managed-mysql.
    maintenanceTask.editor`"]
    managed-mysql.maintenanceTask.viewer --> managed-mysql.viewer
    managed-mysql.auditor --> managed-mysql.maintenanceTask.viewer["`managed-mysql.
    maintenanceTask.viewer`"]
    managed-mysql.user --> managed-mysql.editor
    managed-mysql.editor --> managed-mysql.admin
```