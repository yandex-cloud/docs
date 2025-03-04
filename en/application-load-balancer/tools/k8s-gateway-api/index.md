---
title: Gateway API for {{ managed-k8s-full-name }}
description: '{{ alb-name }} provides the Gateway API as a tool to create and manage load balancers in {{ managed-k8s-full-name }} clusters.'
---

# Gateway API for {{ managed-k8s-name }}

{{ alb-name }} provides the Gateway API as a tool to create and manage load balancers in [{{ managed-k8s-full-name }} clusters](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster). For more information about the Gateway API project, visit its [website](https://gateway-api.sigs.k8s.io/).

Once you install the Gateway API, you can use it to create a resource named `Gateway` and associated `HTTPRoute` resources:
* The `Gateway` resource is managed by the cluster operator. This resource describes how incoming traffic is received and the rules for selecting routes for this traffic (`HTTPRoute` resources). To receive traffic through `Gateway`, an [L7 load balancer](../../concepts/application-load-balancer.md) is created. To route the traffic, [HTTP routers](../../concepts/http-router.md) are linked to the load balancer.
* The `HTTPRoute` resources are managed by developers of applications ({{ k8s }} services). `HTTPRoute` describes the route for the received incoming traffic. Based on this description, the traffic can be routed to a {{ k8s }} service acting as a backend or redirected to another URI. The `HTTPRoute` is used to create virtual hosts and routes in HTTP routers and [backend groups](../../concepts/backend-group.md).

For full configuration of the resources for Gateway API, see the following sections:

* [Gateway](../../k8s-ref/gateway.md): Rules for receiving incoming traffic and selecting routes (`HTTPRoute`) for this traffic.
* [HTTPRoute](../../k8s-ref/http-route.md): Rules for routing traffic across backends or redirecting it.
* [Service](../../k8s-ref/service-for-gateway.md): Description of {{ k8s }} services used as backends.

## Route order in virtual hosts {#route-order}

Route order in virtual hosts is defined by the algorithm described in the [Gateway API](https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io%2Fv1.HTTPRouteRule) specification. This algorithm sorts routes based on how closely route parameters match those of an incoming HTTP request.

Match conditions (in order of decreasing priority):

1. Exact path match.
1. Path prefix match with the largest number of characters.
1. Method match.
1. Highest number of header matches.
1. Highest number of request parameter matches.

If, after applying these conditions, there are still routes with equal priority from different resources, older routes get higher priority first, followed by the remaining routes in alphabetical order according to the `{namespace}/{name}` format.

In the case of equal priority routes within a single HTTPRoute, the first matching rule is selected in the order they are listed, while also taking the above criteria into account.

If a request does not match any of the rules linked to the current parent element, the `404` code is returned.

The order of routes can affect the logic of request processing.

## Sample configuration {#example}

Below is a sample configuration of the `Gateway` and `HTTPRoute` resources. It will be used to create a load balancer to receive HTTPS traffic and to distribute it to two services based on the URI request path.

{% cut "Example" %}

```yaml
---
apiVersion: gateway.networking.k8s.io/v1alpha2
kind: Gateway
metadata:
  name: alb-gwapi-gw
spec:
  gatewayClassName: yc-df-class
  listeners:
    - name: alb-gwapi-listener
      protocol: HTTPS
      port: 443
      hostname: <domain_name>
      allowedRoutes:
        namespaces:
          from: Selector
          selector:
            matchLabels:
              gatewayName: alb-gwapi-gw
      tls:
        certificateRefs:
          - kind: Secret
            group: ""
            name: alb-gwapi-cert
            namespace: alb-gwapi-ns
```

```yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: alb-gwapi-apps-ns
  labels:
    gatewayName: alb-gwapi-gw

---
apiVersion: gateway.networking.k8s.io/v1alpha2
kind: HTTPRoute
metadata:
  name: alb-gwapi-route
  namespace: alb-gwapi-apps-ns
spec:
  hostnames:
    - "<domain_name>"
  parentRefs:
    - name: alb-gwapi-gw
      namespace: default
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /app1
      backendRefs:
        - name: alb-demo-1
          port: 80
    - matches:
        - path:
            type: PathPrefix
            value: /app2
      backendRefs:
        - name: alb-demo-2
          port: 80
    - backendRefs: # Default match (implicit "/" path prefix)
        - name: alb-demo-2
          port: 80
```

{% endcut %}

## Installation and requirements {#install}

To install the Gateway API, you need:

* {{ managed-k8s-name }} cluster.
* Cluster node group.
* Cluster namespace to store the [service account](../k8s-ingress-controller/service-account.md) key.

To learn how to install the Gateway API, see [this guide](../../operations/k8s-gateway-api-install.md).

#### See also {#see-also}

* [Security group configuration](../k8s-ingress-controller/security-groups.md) for a {{ k8s }} cluster and a load balancer.
* [Service account](../k8s-ingress-controller/service-account.md) to support controller operation.
* [Gateway API in {{ marketplace-full-name }}]({{ link-cloud-marketplace }}/products/yc/gateway-api).
