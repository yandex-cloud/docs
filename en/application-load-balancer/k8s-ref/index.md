# {{ alb-name }} tool reference for {{ managed-k8s-name }}

{{ alb-name }} provides tools for deploying L7 load balancers in {{ managed-k8s-full-name }} clusters: [Ingress controller](../tools/k8s-ingress-controller/index.md) and [Gateway API](../tools/k8s-gateway-api/index.md). The reference describes {{ k8s }} resource configurations used by the Ingress controller and Gateway API to deploy an infrastructure.


## Ingress controller resources {#ingress}

* [Ingress](ingress.md): Backend traffic distribution rules.
* [HttpBackendGroup](http-backend-group.md): Combining backends into groups.


## Gateway API resources {#gateway-api}

* [Gateway](gateway.md)
* [HTTPRoute](http-route.md)


## Common resources {#common}

* [Service](service.md): Description of {{ k8s }} services used as backends.