```mermaid
flowchart BT
    managed-spark.auditor --> managed-spark.viewer
    managed-spark.viewer --> managed-spark.user
    managed-spark.user --> managed-spark.editor
    managed-spark.editor --> managed-spark.admin
    managed-spark.integrationProvider["`managed-spark.
    integrationProvider`"]
```