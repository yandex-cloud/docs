```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: SpeechsenseConfig
metadata:
  name: default
spec:
  enabled: true
  settings:
    s3: # Опционально. Заполните, если нужно использовать внешнее хранилище
      endpoint: "<адрес_объектного_хранилища>"
      accessKeyID: "<идентификатор_ключа>"
      secretAccessKey: "<секретный_ключ>"
```
