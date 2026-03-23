```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: my-public-cert
  namespace: default
spec:
  secretName: my-public-tls      # секрет, в котором будет сохранен сгенерированный приватный ключ
  issuerRef:
    name: stackland-letsencrypt  # или stackland-default
    kind: ClusterIssuer
  dnsNames:
  - app.example.com              # домен, для которого выписывается сертификат
```
