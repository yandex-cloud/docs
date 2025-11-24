```mermaid
flowchart BT
    load-balancer.privateAdmin ~~~~ vpc.publicAdmin
    alb.auditor --> alb.viewer
    alb.viewer --> alb.user
    alb.user --> alb.editor
    vpc.user --> alb.editor
    load-balancer.privateAdmin --> alb.editor
    alb.editor --> alb.admin
```