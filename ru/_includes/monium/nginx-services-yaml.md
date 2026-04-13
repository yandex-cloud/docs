```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-web
  namespace: nginx-demo
  labels:
    app: nginx
spec:
  externalTrafficPolicy: Local
  type: LoadBalancer
  selector:
    app: nginx
  ports:
    - name: http
      port: 80
      targetPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-metrics
  namespace: nginx-demo
  labels:
    app: nginx
spec:
  selector:
    app: nginx
  ports:
    - name: metrics
      port: 9113
      targetPort: metrics
```