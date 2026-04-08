```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-app
  annotations:
    cert-manager.io/cluster-issuer: stackland-letsencrypt  # or `stackland-default`
spec:
  tls:
  - hosts:
    - app.example.com       # the domain for which the certificate is issued
    secretName: my-app-tls  # the secret where the generated private key will be stored
  rules:
  - host: app.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-app
            port:
              number: 80
```
