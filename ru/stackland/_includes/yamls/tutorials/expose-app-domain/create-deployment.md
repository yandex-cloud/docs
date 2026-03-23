```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: test-stackland
  namespace: <название проекта>
spec:
  replicas: 1
  selector:
    matchLabels:
      app: test-stackland-service
  template:
    metadata:
      labels:
        app: test-stackland-service
    spec:
      containers:
      - image: nginx:alpine
        name: nginx
        ports:
        - containerPort: 80
        volumeMounts:
        - mountPath: /usr/share/nginx/html
          name: html
      volumes:
      - configMap:
          name: test-stackland-html
        name: html
```
