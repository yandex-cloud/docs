---
title: Gateway API for {{ managed-k8s-full-name }}
description: '{{ alb-name }} provides the Gateway API tool for creating and managing load balancers in {{ managed-k8s-full-name }} clusters.'
---

# Gateway API for {{ managed-k8s-name }}

{{ alb-name }} provides the Gateway API tool for creating and managing load balancers in [{{ managed-k8s-full-name }} clusters](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster). To learn more about the Gateway API project, visit its official [website](https://gateway-api.sigs.k8s.io/).

Once you install the Gateway API, you can use it to create the `Gateway` resource as well as the linked `HTTPRoute` and `GRPCRoute` resources:
* The `Gateway` resource is managed by the cluster operator. The resource describes the incoming traffic reception and routing (`HTTPRoute` and `GRPCRoute`) rules. The system creates an [L7 load balancer](../../concepts/application-load-balancer.md) to handle traffic for the `Gateway`. The load balancer uses [HTTP routers](../../concepts/http-router.md) to route incoming traffic.
* Managed by developers of {{ k8s }} service apps, the `HTTPRoute` and `GRPCRoute` resources describe the route for received incoming traffic. According to this description, traffic can be routed to the {{ k8s }} service operating as a backend or redirected to another URI. With `HTTPRoute` and `GRPCRoute` you create virtual hosts and routes in HTTP routers and [backend groups](../../concepts/backend-group.md).

See the full configuration of Gateway API resources in the following sections:

* [Gateway](../../k8s-ref/gateway.md): Incoming traffic reception and routing (`HTTPRoute`) rules.
* [GatewayPolicy](../../k8s-ref/gateway-policy.md): `Gateway` resource policy, incoming traffic processing configuration.
* [YCCertificate](../../k8s-ref/yc-certificate.md): {{ certificate-manager-name }} certificate parameters for setting up TLS connections in the `Gateway` resource.
* [HTTPRoute](../../k8s-ref/http-route.md) and [GRPCRoute](../../k8s-ref/grpc-route.md): Rules for traffic routing between backends or redirection.
* [RoutePolicy](../../k8s-ref/route-policy.md): `HTTPRoute` resource policy and backend access rule configuration.
* [YCStorageBucket](../../k8s-ref/yc-storage-bucket.md): {{ objstorage-name }} bucket parameters for setting up a backend in the `HTTPRoute` resource.
* [Service](../../k8s-ref/service-for-gateway.md): {{ k8s }} backend service description.

## Route order in virtual hosts {#route-order}

The order of routes in virtual hosts is as per the algorithms described in the Gateway API specification. These algorithms are different for HTTP requests and gRPC calls.

{% list tabs %}

- HTTP requests

  The [algorithm](https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io%2Fv1.HTTPRouteRule) sorts routes by how well their parameters match those of the incoming HTTP request.

  Match conditions in descending order of priority:

  1. Exact path match.
  1. Longest path prefix match.
  1. Method match.
  1. Greatest number of matching headers.
  1. Greatest number of matching request parameters.

  For requests matching none of the rules associated with the current parent element, code `404` will be returned.

- gRPC calls

  The [algorithm](https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io%2Fv1.GRPCRouteRule) sorts routes by the number of characters in the parameters of the route and the incoming gRPC call. Matches are counted only based on headers.

  Comparison conditions in descending order of priority:

  1. Greatest number of characters in domain name without asterisks `*`.
  1. Greatest number of characters in domain name.
  1. Greatest number of characters in service name.
  1. Greatest number of characters in method name.
  1. Greatest number of matching headers.

{% endlist %}

If these conditions still leave routes of equal precedence from different resources, such routes will first be prioritized based on their timestamp (older routes first), then alphabetically by name in `{namespace}/{name}` format.

If there are still routes of equal precedence within the same HTTPRoute/GRPCRoute, the system will select the first suitable one listed based on the foregoing criteria.

The route order may have an impact on the request/call processing logic.

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
