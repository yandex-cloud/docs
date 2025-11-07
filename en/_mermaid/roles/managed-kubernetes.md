```mermaid
flowchart BT
    k8s.cluster-api.editor ~~~ k8s.cluster-api.cluster-admin
    k8s.cluster-api.viewer ~~~ k8s.cluster-api.editor
    k8s.editor --> k8s.admin
    k8s.viewer --> k8s.editor
    k8s.tunnelClusters.agent --> k8s.clusters.agent
    k8s.viewer --> k8s.tunnelClusters.agent
```