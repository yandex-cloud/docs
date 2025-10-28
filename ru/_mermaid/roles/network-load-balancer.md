```mermaid
flowchart BT
    load-balancer.auditor --> load-balancer.viewer
    load-balancer.viewer --> load-balancer.privateAdmin
    load-balancer.privateAdmin --> load-balancer.editor
    load-balancer.editor --> load-balancer.admin

    vpc.viewer --> load-balancer.privateAdmin
```