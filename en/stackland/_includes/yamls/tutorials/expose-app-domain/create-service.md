```yaml
apiVersion: v1
kind: Service
metadata:
  name: test-stackland-service
  namespace: <project name>
spec:
  ports:
  - port: 5556
    targetPort: 80
  selector:
    app: test-stackland-service
```
