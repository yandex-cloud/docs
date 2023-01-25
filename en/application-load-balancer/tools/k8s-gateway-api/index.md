# Gateway API for {{ managed-k8s-name }}

{% note info %}

Gateway API is in the Preview stage.

{% endnote %}

{{ alb-name }} provides the Gateway API as a tool to create and manage load balancers in [{{ managed-k8s-full-name }} clusters](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster). For more information about the Gateway API project, visit its [website](https://gateway-api.sigs.k8s.io/).

Once you install the Gateway API, you can use it to create a resource named `Gateway` and associated `HTTPRoute` resources:
* The `Gateway` resource is managed by the cluster operator. This resource describes how incoming traffic is received and the rules for selecting routes for the traffic (`HTTPRoute` resources). To receive traffic through `Gateway`, an [L7 load balancer](../../concepts/application-load-balancer.md) is created. To route the traffic, [HTTP routers](../../concepts/http-router.md) are linked to the load balancer.
* The `HTTPRoute` resources are managed by the developers of applications — {{ k8s }} services. `HTTPRoute` is a description of the route for the incoming traffic received. Based on this description, the traffic can be routed to {{ k8s }} that serves as a backend or redirected to another URI. The `HTTPRoute` is used to create virtual hosts and routes in HTTP routers and [backend groups](../../concepts/backend-group.md).

## Sample configuration {#example}

Below is a sample configuration of `Gateway` and `HTTPRoute` resources. It will be used to create a load balancer to receive HTTPS traffic and to distribute it to two services based on the URI request path.

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
* A cluster namespace to store the [service account](../k8s-ingress-controller/service-account.md) key.

You can install the Gateway API:
* As a [{{ marketplace-full-name }} product](/marketplace/products/yc/gateway-api) using the management console.
* As a chart using the [Helm]{% if lang == "ru" %}(https://helm.sh/ru/){% else %}(https://helm.sh/){% endif %} package manager, version {{ alb-ingress-helm-version }} or higher with [OCI support enabled](https://helm.sh/docs/topics/registries/). To download and install a chart, run:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/gateway-api/gateway-api-helm/gateway-api \
     --version {{ alb-gateway-api-version }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --set folderId=<folder_ID> \
     --set networkId=<network_ID> \
     --set subnetId=<subnet_ID> \
     --set-file saKeySecretKey=<path_to_file_with_service_account_key> \
     yc-alb-gateway-api ./yc-alb-gateway-api-chart/
   ```

For more information about each option, please see the [complete installation instructions](../../operations/k8s-gateway-api-install.md).

#### See also {#see-also}

* [Security group configuration](../k8s-ingress-controller/security-groups.md) for a {{ k8s }} cluster and a load balancer.
* [Service account](../k8s-ingress-controller/service-account.md) to support controller operation.