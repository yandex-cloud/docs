```yaml
apiVersion: airflow.stackland.yandex.cloud/v1alpha1
kind: AirflowCluster
metadata:
  name: airflow-demo
spec:
  version: "3.1.8"
  dags:
    source: git
    git:
      repo: https://github.com/example/airflow-dags.git
      ref: main
  publicAccess: true
  deletionProtection: true
```
