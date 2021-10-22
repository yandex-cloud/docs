# Ingress Controller for {{ managed-k8s-name }}

{{ alb-name }} provides a tool for creating and managing load balancers in [{{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) clusters: {{ alb-name }} Ingress Controller.

After installing the controller, you can use it to create an [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) object that will be responsible for receiving incoming traffic. Based on the Ingress configuration, an [L7 load balancer](../concepts/application-load-balancer.md) is deployed automatically with the necessary [target groups](../concepts/target-group.md), [backend groups](../concepts/backend-group.md), [HTTP routers](../concepts/http-router.md), and [listeners](../concepts/application-load-balancer.md#listener).

> Sample configuration:
> 
> ```yaml
> ---
> apiVersion: networking.k8s.io/v1
> kind: Ingress
> metadata:
>   name: alb-demo-tls
> spec:
>   tls:
>     - hosts:
>         - <domain name>
>       secretName: yc-certmgr-cert-id-<certificate ID from the {{ certificate-manager-name }}>
>   rules:
>     - host: <domain name>
>       http:
>         paths:
>           - path: /app1
>             pathType: Prefix
>             backend:
>               service:
>                 name: alb-demo-1
>                 port:
>                   number: 80
>           - path: /app2
>             pathType: Prefix
>             backend:
>               service:
>                 name: alb-demo-2
>                 port:
>                   number: 80
>           - pathType: Prefix
>             path: "/"
>             backend:
>               service:
>                 name: alb-demo-2
>                 port:
>                   number: 80
> ```
> 
> Using this configuration, the controller creates a load balancer with three listeners that receive traffic on port 80. Since the configuration specifies the domain name and [certificate from the {{ certificate-manager-name }}](../../certificate-manager/concepts/index.md#types), HTTP routers redirect traffic to port 443. A listener is selected based on the path specified in the request URI and passes traffic to the assigned [service](../../managed-kubernetes/concepts/index.md#service): `alb-demo-1` or `alb-demo-2`. For each service, its own backend group is created according to its configuration.

For more information about installing and using the controller, see the [{#T}](../../managed-kubernetes/solutions/alb-ingress-controller.md) use case in the {{ managed-k8s-name }} documentation.

