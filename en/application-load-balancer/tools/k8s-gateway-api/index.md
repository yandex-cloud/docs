---
title: Gateway API for {{ managed-k8s-full-name }}
description: '{{ alb-name }} provides the Gateway API tool for creating and managing load balancers in {{ managed-k8s-full-name }} clusters.'
---

# Gateway API for {{ managed-k8s-name }}

{{ alb-name }} provides the Gateway API tool for creating and managing load balancers in [{{ managed-k8s-full-name }} clusters](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster). To learn more about the Gateway API project, visit its official [website](https://gateway-api.sigs.k8s.io/).

Once you install the Gateway API, you can use it to create a `Gateway` and its associated `HTTPRoute` resources:
* The `Gateway` resource is managed by the cluster operator. It configures incoming traffic reception and route selection rules, i.e., `HTTPRoute` resources. The system creates an [L7 load balancer](../../concepts/application-load-balancer.md) to handle traffic for the `Gateway`. The load balancer uses [HTTP routers](../../concepts/http-router.md) to route incoming traffic.
* The `HTTPRoute` resources are managed by {{ k8s }} service developers and describe routes for the incoming traffic that can be routed to a {{ k8s }} backend service or redirected to another URI. With `HTTPRoute` you can create virtual hosts and routes in HTTP routers and [backend groups](../../concepts/backend-group.md).

For more detials about configuring resources via Gateway API, see the following sections:

* [Gateway](../../k8s-ref/gateway.md): Rules for receiving and routing incoming traffic using `HTTPRoute` resources.
* [HTTPRoute](../../k8s-ref/http-route.md): Traffic routing and redirection rules.
* [Service](../../k8s-ref/service-for-gateway.md): {{ k8s }} backend service description.

## Route order in virtual hosts {#route-order}

Route order in virtual hosts is determined by the [Gateway API](https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io%2Fv1.HTTPRouteRule) algorithm sorting routes by the level of precision with which their match conditions align with the incoming HTTP request.

Match conditions in descending priority order:

1. Exact path match.
1. Longest path prefix match.
1. Method match.
1. Most matching headers.
1. Most matching query parameters.

Routes from different `HTTPRoute` resources with equal precedence are prioritized first by creation timestamp (older routes first), then by name in `{namespace}/{name}` format.

If there remain routes with equal precedence in the same `HTTPRoute` resource, the system will select the first matching route from the list.

For requests matching none of the rules associated with the current parent element, the system will return `404` error.

The route order determines the request processing logic.

## Sample configuration {#example}

Below you can see a sample `Gateway` and `HTTPRoute` resource configuration describing a load balancer that receives HTTPS requests and routes them to one of two service backends based on their URI paths.

{% cut "Example" %}

```yaml
---
apiVersion: gateway.networking.k8s.io/v1
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
apiVersion: gateway.networking.k8s.io/v1
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
* Cluster namespace to store your [service account](../k8s-ingress-controller/service-account.md) key.

To learn how to install the Gateway API, see [this guide](../../operations/k8s-gateway-api-install.md).

#### See also {#see-also}

* [Security group configuration](../k8s-ingress-controller/security-groups.md) for a {{ k8s }} cluster and a load balancer.
* [Service account](../k8s-ingress-controller/service-account.md) to support controller operation.
* [Gateway API in {{ marketplace-full-name }}]({{ link-cloud-marketplace }}/products/yc/gateway-api).
