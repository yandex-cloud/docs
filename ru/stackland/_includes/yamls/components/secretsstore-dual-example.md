```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: myapp-namespace
data:
  app.yaml: |
    db_host: postgres.example.com
    db_password: secrets:secret/data/myapp/database#password
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
  namespace: myapp-namespace
spec:
  replicas: 1
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
      annotations:
        secrets.stackland.yandex.cloud/render-env: "true"
        secrets.stackland.yandex.cloud/render-configmap: "true"
        secrets.stackland.yandex.cloud/role: "myapp"
    spec:
      serviceAccountName: myapp-sa
      containers:
        - name: app
          image: myapp:latest
          # В Env mode задайте command или args с исполняемым файлом первым элементом.
          command:
            - /app/myapp
          resources:
            requests:
              cpu: "100m"
              memory: "128Mi"
            limits:
              cpu: "500m"
              memory: "256Mi"
          env:
            - name: API_KEY
              value: "secrets:secret/data/myapp/api#key"
          volumeMounts:
            - name: app-config
              mountPath: /config
      volumes:
        - name: app-config
          configMap:
            name: app-config
```
