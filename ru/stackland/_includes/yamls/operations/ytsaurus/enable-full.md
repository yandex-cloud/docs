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
      resources:
        cpu: "100m"
        memory: "256Mi"

    primaryMasters:
      instanceCount: 1
      storage:
        storageClass: stackland-ssd
        size: "10Gi"
      resources:
        cpu: "500m"
        memory: "1Gi"

    httpProxies:
      instanceCount: 2
      resources:
        cpu: "500m"
        memory: "1Gi"

    dataNodes:
      - name: ssd
        instanceCount: 3
        storage:
          storageClass: stackland-ssd
          size: "50Gi"
        resources:
          cpu: "500m"
          memory: "1Gi"

    execNodes:
      - name: default
        instanceCount: 2
        storage:
          storageClass: stackland-ssd
          size: "20Gi"
        resources:
          cpu: "4000m"
          memory: "4Gi"

    schedulers:
      instanceCount: 1
      resources:
        cpu: "500m"
        memory: "512Mi"

    controllerAgents:
      instanceCount: 1
      resources:
        cpu: "500m"
        memory: "512Mi"

    bundleController:
      enabled: true

    queryTrackers:
      instanceCount: 1
      resources:
        cpu: "200m"
        memory: "512Mi"

    queueAgents:
      instanceCount: 1
      resources:
        cpu: "200m"
        memory: "512Mi"

    rpcProxies:
      instanceCount: 2
      resources:
        cpu: "200m"
        memory: "512Mi"

    strawberry:
      enabled: true
      resources:
        cpu: "200m"
        memory: "512Mi"

    tabletNodes:
      - name: default
        instanceCount: 2
        resources:
          cpu: "1000m"
          memory: "2Gi"

    yqlAgents:
      instanceCount: 1
      resources:
        cpu: "500m"
        memory: "1Gi"

    ui:
      enabled: true
      ingressEnabled: true
      resources:
        cpu: "200m"
        memory: "512Mi"

    cron:
      clear_tmp:
        enabled: true

    taskProxy:
      enabled: true
      instanceCount: 1

    spyt:
      enabled: true

    chyt:
      enabled: true

    tutorial:
      enabled: false

    odin:
      enabled: false
```
