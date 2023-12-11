---
title: "{{ alb-full-name }} tool reference for {{ managed-k8s-full-name }}"
description: "This page contains a reference of {{ alb-name }} tools for {{ managed-k8s-name }}."
---

# {{ alb-name }} tool reference for {{ managed-k8s-name }}


{{ alb-name }} provides tools for deploying L7 load balancers in {{ managed-k8s-full-name }} clusters: [Ingress controller](../tools/k8s-ingress-controller/index.md) and [Gateway API](../tools/k8s-gateway-api/index.md). This reference describes {{ k8s }} resource configurations used by the Ingress controller and Gateway API to deploy an infrastructure.





## Ingress controller resources {#ingress}

* [Ingress](ingress.md): Backend traffic distribution rules.
* [HttpBackendGroup](http-backend-group.md): Combining backends into groups.


## Gateway API resources {#gateway-api}

* [Gateway](gateway.md): Rules for receiving incoming traffic and selecting routes (`HTTPRoute`) for the traffic.
* [HTTPRoute](http-route.md): Rules for routing traffic across backends or redirecting it.


## Common resources {#common}

* [Service](service.md): Description of {{ k8s }} services used as backends.


