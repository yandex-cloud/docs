```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: AgentAtelierConfig
metadata:
  name: main
spec:
  enabled: true
  settings:
    storageClass: stackland-other
    codeInterpreter:
      enabled: true
      sessionIdleTTL: 2h
      sessionHardTTL: 24h
```
