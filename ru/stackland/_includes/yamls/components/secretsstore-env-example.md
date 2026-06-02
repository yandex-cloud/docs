```yaml
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
        secrets.stackland.yandex.cloud/role: "myapp"
    spec:
      serviceAccountName: myapp-sa
      containers:
        - name: app
          image: myapp:latest
          # В Env mode задайте command или args с исполняемым файлом первым элементом.
          command:
            - /app/myapp
          args:
            - --config=/config/app.yaml
          resources:
            requests:
              cpu: "100m"
              memory: "128Mi"
            limits:
              cpu: "500m"
              memory: "256Mi"
          env:
            - name: DB_PASSWORD
              value: "secrets:secret/data/myapp/database#password"
            - name: API_KEY
              value: "secrets:secret/data/myapp/api#key"
```
