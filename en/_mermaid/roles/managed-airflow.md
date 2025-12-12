```mermaid
flowchart BT
    managed-airflow.auditor --> managed-airflow.viewer 
    managed-airflow.viewer --> managed-airflow.user 
    managed-airflow.user --> managed-airflow.editor
    managed-airflow.editor --> managed-airflow.admin
    managed-airflow.integrationProvider["`managed-airflow.
    integrationProvider`"] 
```