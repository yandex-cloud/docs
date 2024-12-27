---
title: '{{ alb-full-name }} tool reference for {{ managed-k8s-full-name }}'
description: This page provides a {{ alb-name }} tool reference for {{ managed-k8s-name }}.
noIndex: true
---

# {{ alb-name }} tool reference for {{ managed-k8s-name }}


{{ alb-name }} provides tools for deploying L7 load balancers in {{ managed-k8s-full-name }} clusters: [Ingress controller](../../application-load-balancer/tools/k8s-ingress-controller/index.md) and [Gateway API](../../application-load-balancer/tools/k8s-gateway-api/index.md). This reference describes {{ k8s }} resource configurations used by the Ingress controller and Gateway API to deploy an infrastructure.

## Ingress controller resources {#ingress}

* [Ingress](ingress.md): Backend traffic distribution rules.
* [HttpBackendGroup](http-backend-group.md), [GrpcBackendGroup](grpc-backend-group.md): Combining backends into groups.
* [IngressClass](ingress-class.md): Managing multiple Ingress controllers in a {{ k8s }} cluster.
* [Service](service-for-ingress.md): Description of [{{ k8s }} services](../concepts/index.md#service) used as backends. It is different from the `Service` resource for Gateway API: the Ingress controller services support annotations.

## Gateway API resources {#gateway-api}

* [Gateway](gateway.md): Rules for receiving incoming traffic and selecting routes (`HTTPRoute` and `TLSRoute`) for this traffic.
* [HTTPRoute](http-route.md): Rules for redirecting or routing HTTP, HTTPS, and gRPC traffic between backends.
* [TLSRoute](./tls-route.md): Rules for routing TLS traffic between backends.
* [Service](service-for-gateway.md): Description of {{ k8s }} services used as backends.
