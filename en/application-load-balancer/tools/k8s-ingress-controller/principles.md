# {{ alb-name }} Ingress controller operating principles

A [{{ alb-name }} Ingress controller for {{ managed-k8s-name }}](index.md) owns two [pods](../../../managed-kubernetes/concepts/index.md#pod):

* The primary `yc-alb-ingress-controller-*` pod handles {{ alb-name }} resource creation and updates. You can track communication with resources through this pod's logs.
* A [status check](../../concepts/backend-group.md#health-checks) pod called `yc-alb-ingress-controller-hc-*` deploys containers on backend nodes to accept test requests on TCP port 10501.

{% note warning %}

Do not manually update {{ alb-name }} resources created by the controller's primary pod. Any changes you make will be rolled back automatically. Use the standard {{ managed-k8s-name }} cluster control methods instead.

{% endnote %}

The primary pod manages the {{ alb-name }} resource architecture using the following principles:

* Load balancers and HTTP routers to accept and distribute traffic to backend groups are created based on `Ingress` resources. All the `Ingress` fields utilized by the controller are described in the [reference](../../k8s-ref/ingress.md).

   If several `Ingress` resources have the same `ingress.alb.yc.io/group-name` annotation values, they are combined in a single load balancer.

   * For a load balancer to be able to accept HTTPS traffic, the `spec.tls` field in the `Ingress` description must contain the domain names and the certificate IDs from {{ certificate-manager-name }}:

      ```yaml
      spec:
        tls:
          - hosts:
              - <domain name>
            secretName: yc-certmgr-cert-id-<certificate ID from {{ certificate-manager-name }}>
      ```

      This will create two types of listeners for the load balancer: one will accept HTTPS traffic on port 443 while the other will redirect HTTP requests (port 80) to HTTPS with the `301 Moved Permanently` status code. The traffic distribution rules for the same domain names that are explicitly specified in other `Ingress` resources lacking the `spec.tls` field, will be given priority with respect to HTTP-to-HTTPS redirects.

      {% include [k8s-ingress-controller-secret-name](../../../_includes/application-load-balancer/k8s-ingress-controller-secret-name.md) %}

   * If an `Ingress` description lacks the `spec.tls` field, a load balancer will only have listeners to receive HTTP traffic on port 80.

* You can create backend groups to process incoming traffic:

   * Based on {{ k8s }} services referenced in `Ingress` rules directly (`spec.rules[*].http.paths[*].backend.service`). This method is useful if you need to bind a simple backend group consisting of a single service to a route.
   * Based on `HttpBackendGroup` resources that support explicit backend group descriptions. These are [custom resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) from the API `alb.yc.io` group exposed by an Ingress controller. All the `HttpBackendGroup` fields are described in the [reference](../../k8s-ref/http-backend-group.md).

      You need to refer to `HttpBackendGroup`in `Ingress` rules same as to services (`spec.rules[*].http.paths[*].backend.resource`).

      {% include [k8s-ingress-controller-backend-group-features](../../../_includes/application-load-balancer/k8s-ingress-controller-backend-group-features.md) %}

* Services referenced in `Ingress` or in `HttpBackendGroup` are deployed to backends. These can be configured using `Service` resources. All the `Service` fields utilized by the controller are described in the [reference](../../k8s-ref/service.md).

   {% include [k8s-ingress-controller-nodeport-note](../../../_includes/application-load-balancer/k8s-ingress-controller-nodeport-note.md) %}

## Mapping between {{ alb-name }} and {{ k8s }} resources {#mapping}

| {{ alb-name }} | {{ k8s }} |
| ----- | ----- |
| [Load balancer](../../concepts/application-load-balancer.md) | `Ingress` resource collection ([reference](../../k8s-ref/ingress.md)) with identical `ingress.alb.yc.io/group-name` annotation values |
| HTTP router [virtual hosts](../../concepts/http-router.md#virtual-host) | `Ingress.spec.rules` |
| Virtual host [routes](../../concepts/http-router.md#routes) | `Ingress.spec.rules[*].http.paths` |
| [Backend group](../../concepts/backend-group.md) | `HttpBackendGroup` ([reference](../../k8s-ref/http-backend-group.md)) or [service](../../../managed-kubernetes/concepts/index.md#service) collection ([reference](../../k8s-ref/service.md)) |
| [Target group](../../concepts/target-group.md) | Cluster [node group](../../../managed-kubernetes/concepts/index.md#node-group) |

