```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: SpeechsenseConfig
metadata:
  name: default
spec:
  enabled: true
  settings:
    s3: # Optional. Add data if you need an external storage
      endpoint: "<object_storage_address>"
      accessKeyID: "<key_ID>"
      secretAccessKey: "<secret_key>"
```
