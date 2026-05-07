{% include [Gwin-with-preset](../../application-load-balancer/ingress-to-gwin-tip-with-preset.md) %}

The ingress controller is an {{ alb-name }} tool for creating and managing load balancers in [{{ managed-k8s-full-name }} clusters](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

Once you install an ingress controller in your cluster, it will automatically deploy [L7 load balancers](../../../application-load-balancer/concepts/application-load-balancer.md) with all required {{ alb-name }} components configured according to your [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) resource specifications.

For full configuration of the resources for the {{ alb-name }} ingress controller, see the following sections:

* [Ingress]({{ configuration-local-link }}/ingress.md): Traffic routing and controller configuration.
* [HttpBackendGroup]({{ configuration-local-link }}/http-backend-group.md) and [GrpcBackendGroup]({{ configuration-local-link }}/grpc-backend-group.md): Combining backends into groups.
* [IngressClass]({{ configuration-local-link }}/ingress-class.md): Managing multiple ingress controllers in a {{ k8s }} cluster.
* [Service]({{ configuration-local-link }}/service-for-ingress.md): Description of {{ k8s }} services used as backends.

## Configuration example {#example}

Below you can see an abbreviated `Ingress` resource configuration example describing a load balancer that receives HTTPS requests and routes them to one of two service backends based on their URI paths.

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

Where `secretName` is the {{ certificate-manager-full-name }} certificate ID.

{% endcut %}

In [ALB ingress controllers](/marketplace/products/yc/alb-ingress-controller) v0.2.0+, this `Ingress` configuration maps [backend groups](../../../application-load-balancer/concepts/backend-group.md) to the `backend.service` specification, while in versions 0.1.x, backend groups are defined through field combinations: `host`, `http.paths.path`, and `http.paths.pathType`. It may result in collisions during the ALB ingress controller upgrade. To avoid them, check the [upgrade restrictions]({{ ingress-upgrade-local-link }}) for your infrastructure.

## Installation and requirements {#install}

To install the {{ alb-name }} ingress controller, you need:

* {{ managed-k8s-name }} cluster.
* Cluster node group.
* Cluster namespace to store your [service account]({{ alb-local-link }}/service-account.md) key.

To learn how to install the ingress controller, see [this guide]({{ ingress-install-local-link }}).

## Logging settings {#log-options}

To set up logging for an L7 load balancer created via the {{ alb-name }} ingress controller in a {{ managed-k8s-name }} cluster, configure its ingress group settings in the `IngressGroupSettings` resource, specifying their name in the new `ingress.alb.yc.io/group-settings-name` annotation. For more information, see [Ingress resource annotations]({{ configuration-local-link }}/ingress.md#annotations).

## {{ sws-full-name }} integration {#smart-web-security}

In the ingress controller, you can enable [{{ sws-full-name }}](../../../smartwebsecurity/concepts/index.md), including DDoS protection, [WAF](../../../smartwebsecurity/concepts/waf.md), and [resource overload protection](../../../smartwebsecurity/concepts/arl.md).

{% include [annot-description](../../managed-kubernetes/alb-ref/annot-security-profile-id.md) %}

## Traffic routing using multiple ingress controllers {#ingress-class}

You can deploy multiple ingress controllers, e.g., {{ alb-name }} and NGINX, for a single application. For proper traffic routing isolation, define a dedicated [IngressClass]({{ configuration-local-link }}/ingress-class.md) resource for each ingress controller. Specify the `Ingress` resource’s `IngressClass` in its `spec.ingressClassName` field. Check out a GitHub [example](https://github.com/yandex-cloud-examples/yc-mk8s-with-ingress-class) for configuring `Ingress` resources and routing traffic with multiple ingress controllers.

#### See also {#see-also}

* [Controller operating principles]({{ ingress-local-link }}/principles.md)
* [Security group configuration]({{ alb-local-link }}/security-groups.md) for a {{ k8s }} cluster and a load balancer
* [Service account]({{ alb-local-link }}/service-account.md) to support controller operation
* [ALB ingress Controller in {{ marketplace-full-name }}]({{ link-cloud-marketplace }}/products/yc/alb-ingress-controller)
