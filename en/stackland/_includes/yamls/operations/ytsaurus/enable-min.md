```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: YTsaurusConfig
metadata:
  name: main
spec:
  enabled: true
  clusterName: cluster
  cluster:
    discovery:
      instanceCount: 1
    primaryMasters:
      instanceCount: 1
      storage:
        size: "5Gi"
    httpProxies:
      instanceCount: 1
    dataNodes:
      - name: ssd
        instanceCount: 3
        storage:
          size: "20Gi"
    execNodes:
      - name: default
        instanceCount: 1
        storage:
          size: "10Gi"
    schedulers:
      instanceCount: 1
    controllerAgents:
      instanceCount: 1
    bundleController:
      enabled: true
    queryTrackers:
      instanceCount: 1
    queueAgents:
      instanceCount: 1
    rpcProxies:
      instanceCount: 1
    strawberry:
      enabled: true
    yqlAgents:
      instanceCount: 1
    ui:
      enabled: true
      ingressEnabled: true
```
