```yaml
apiVersion: airflow.stackland.yandex.cloud/v1alpha1
kind: AirflowCluster
metadata:
  name: airflow-demo
spec:
  version: "3.1.8"
  dags:
    source: s3
    s3:
      type: stackland-storage
      stacklandStorage:
        subPath: dags/
  taskLogs:
    type: stackland-storage
    stacklandStorage:
      subPath: logs/
  publicAccess: true
  deletionProtection: true
```
