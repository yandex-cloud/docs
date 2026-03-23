```yaml
apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
kind: ClickhouseCluster
metadata:
  labels:
    app.kubernetes.io/name: ch-stackland-operator
    app.kubernetes.io/managed-by: kustomize
  name: ch-sample-full
spec:
  clickhouse:
    version: "25.3"
    enableSuperuserAccess: true
    superuserSecretRef:
      name: "ch-sample-superuser"
    recovery:
      fullRecovery:
        backup:
          name: your_backup_full_name  # kubectl get ClickhouseBackup -n <namespace>
  backup:
    storage:
      type: stackland-storage
    schedule: "0 0 * * * *"
    deltaMaxSteps: 5
---
apiVersion: v1
kind: Secret
metadata:
  name: ch-sample-superuser
type: Opaque
stringData:
  password: "your_password"
  username: "your_username"
```
