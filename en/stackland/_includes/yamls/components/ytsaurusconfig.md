```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: YTsaurusConfig
metadata:
  name: main  # Required; the resource name must be `main`
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
        size: "5Gi"
      resources:
        cpu: "300m"
        memory: "512Mi"

    httpProxies:
      instanceCount: 1
      resources:
        cpu: "300m"
        memory: "512Mi"

    dataNodes:
      - name: ssd
        instanceCount: 3
        storage:
          size: "20Gi"
        resources:
          cpu: "200m"
          memory: "512Mi"

    execNodes:
      - name: default
        instanceCount: 1
        storage:
          size: "10Gi"
        resources:
          cpu: "3000m"
          memory: "3Gi"

    schedulers:
      instanceCount: 1
      resources:
        cpu: "200m"
        memory: "256Mi"

    controllerAgents:
      instanceCount: 1
      resources:
        cpu: "200m"
        memory: "256Mi"

    bundleController:
      enabled: true

    queryTrackers:
      instanceCount: 1
      resources:
        cpu: "100m"
        memory: "256Mi"

    queueAgents:
      instanceCount: 1
      resources:
        cpu: "100m"
        memory: "256Mi"

    rpcProxies:
      instanceCount: 1
      resources:
        cpu: "100m"
        memory: "256Mi"

    strawberry:
      enabled: true
      resources:
        cpu: "100m"
        memory: "256Mi"

    tabletNodes:
      - name: default
        instanceCount: 1
        resources:
          cpu: "500m"
          memory: "1Gi"

    yqlAgents:
      instanceCount: 1
      resources:
        cpu: "200m"
        memory: "1Gi"

    ui:
      enabled: true
      ingressEnabled: true
      resources:
        cpu: "100m"
        memory: "256Mi"
```
