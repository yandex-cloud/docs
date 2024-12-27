---
title: Ingress controller for {{ managed-k8s-full-name }}
description: '{{ alb-name }} provides the Ingress controller, a tool for creating and managing load balancers in {{ managed-k8s-full-name }} clusters.'
---

# Ingress controller for {{ managed-k8s-name }}


{{ alb-name }} provides the {{ alb-name }} Ingress controller — a tool you can use to create and manage load balancers in [{{ managed-k8s-full-name }} clusters](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

The Ingress controller installed in the cluster will automatically deploy [L7 load balancers](../../concepts/application-load-balancer.md) with all the required {{ alb-name }} resources based on the configuration of the [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) resources you created.

For full configuration of the resources for the {{ alb-name }} Ingress controller, see the following sections:

* [Ingress](../../k8s-ref/ingress.md): Backend traffic distribution and Ingress controller configuration rules.
* [HttpBackendGroup](../../k8s-ref/http-backend-group.md) and [GrpcBackendGroup](../../k8s-ref/grpc-backend-group.md): Combining backends into groups.
* [IngressClass](../../k8s-ref/ingress-class.md): Managing multiple Ingress controllers in a {{ k8s }} cluster.
* [Service](../../k8s-ref/service-for-ingress.md): Description of {{ k8s }} services used as backends.

## Sample configuration {#example}

Below is an abbreviated configuration example for the `Ingress` resource. It will be used to create a load balancer to receive HTTPS traffic and to distribute it to two services based on the URI request path.

{% cut "Example" %}

```yaml
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: alb-demo-tls
spec:
  tls:
    - hosts:
        - <domain_name>
      secretName: yc-certmgr-cert-id-<certificate_ID>
  rules:
    - host: <domain_name>
      http:
        paths:
          - path: /app1
            pathType: Prefix
            backend:
              service:
                name: alb-demo-1
                port:
                  number: 80
          - path: /app2
            pathType: Prefix
            backend:
              service:
                name: alb-demo-2
                port:
                  number: 80
          - pathType: Prefix
            path: "/"
            backend:
              service:
                name: alb-demo-2
                port:
                  name: http
```

Where `secretName` is the ID of the certificate from {{ certificate-manager-full-name }}.

{% endcut %}

If this `Ingress` resource configuration is used in [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) version 0.2.0 and later, the [backend groups](principles.md) are mapped to the `backend.service` parameter. Versions 0.1.x use other parameters: `host`, `http.paths.path`, and `http.paths.pathType`. As a result, collisions may occur when updating the ALB Ingress Controller. To avoid them, [find out whether upgrade restrictions apply](../../operations/k8s-ingress-controller-upgrade.md) to your infrastructure.

## Installation and requirements {#install}

To install the {{ alb-name }} Ingress controller, you need:

* {{ managed-k8s-name }} cluster.
* Cluster node group.
* Cluster namespace to store the [service account](service-account.md) key.

To learn how to install the Ingress controller, see [this guide](../../operations/k8s-ingress-controller-install.md).

## Logging settings {#log-options}

To set up logging for an L7 load balancer created using the {{ alb-name }} Ingress controller in a {{ managed-k8s-name }} cluster, add the `ingress.alb.yc.io/group-settings-name` annotation with a name for the Ingress resource group settings and specify the settings in the additional `IngressGroupSettings` resource. For more information, see [Ingress resource annotations](../../k8s-ref/ingress.md#annotations).

## Integration with {{ sws-full-name }} {#smart-web-security}

In the Ingress controller, you can enable support for [{{ sws-full-name }}](../../../smartwebsecurity/concepts/index.md) that allows you to get protected against DDoS attacks and bots, as well as use a [WAF](../../../smartwebsecurity/concepts/waf.md) and [reduce the load](../../../smartwebsecurity/concepts/arl.md) on the resource being protected.

{% include [annot-description](../../../_includes/managed-kubernetes/alb-ref/annot-security-profile-id.md) %}

## Traffic routing using multiple Ingress controllers {#ingress-class}

For a single application, you can use multiple Ingress controllers, such as {{ alb-name }} and NGINX. To correctly route traffic in such infrastructure, create an [IngressClass](../../../application-load-balancer/k8s-ref/ingress-class.md) resource for each Ingress controller. In the `Ingress` resource, under `spec.ingressClassName`, specify which `IngressClass` the `Ingress` resource belongs to. On GitHub, you can find an [example](https://github.com/yandex-cloud-examples/yc-mk8s-with-ingress-class) of how to configure `Ingress` resources and route traffic using multiple Ingress controllers.

#### See also {#see-also}

* [Controller operating principles](principles.md).
* [Security group configuration](security-groups.md) for a {{ k8s }} cluster and a load balancer.
* [Service account](service-account.md) to support controller operation.
* [ALB Ingress Controller in {{ marketplace-full-name }}]({{ link-cloud-marketplace }}/products/yc/alb-ingress-controller).
