```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: my-public-cert
  namespace: default
spec:
  secretName: my-public-tls      # the secret where the generated private key will be stored
  issuerRef:
    name: stackland-letsencrypt  # or stackland-default
    kind: ClusterIssuer
  dnsNames:
  - app.example.com              # the domain for which the certificate is issued
```
