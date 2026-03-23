```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    cert-manager.io/cluster-issuer: stackland-default
  name: test-stackland-ingress
  namespace: <название проекта>
spec:
  ingressClassName: stackland-default
  rules:
  - host: <внешняя ссылка>
    http:
      paths:
      - backend:
          service:
            name: test-stackland-service
            port:
              number: 5556
        path: /
        pathType: Prefix
  tls:
  - hosts:
    - <внешняя ссылка>
    secretName: test-stackland-tls
```
