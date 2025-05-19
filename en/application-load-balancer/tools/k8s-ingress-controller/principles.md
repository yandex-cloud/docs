---
title: How the {{ alb-full-name }} ingress controller works
description: In this tutorial, you will learn about the {{ alb-name }} ingress controller and {{ alb-name }}-to-{{ k8s }} resource mapping.
---

# How the {{ alb-name }} ingress controller works

An [{{ alb-name }} ingress controller for {{ managed-k8s-name }}](index.md) is running two [pods](../../../managed-kubernetes/concepts/index.md#pod):

* The leader pod, i.e., `yc-alb-ingress-controller-*`, manages {{ alb-name }} resource creation and updates. You can use its logs to monitor resource operations.
* The [health check](../../concepts/backend-group.md#health-checks) pod, i.e., `yc-alb-ingress-controller-hc-*`, runs a container listening on TCP port `10501` for L7 load balancer health check requests and performing health checks on [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/) pods across all cluster nodes. Given that kube-proxy is healthy, the process is as follows: if an application does not respond in a particular pod, {{ k8s }} redirects traffic to a different pod or node.

  This is the default health check workflow used by the {{ alb-name }} ingress controller. You can [configure custom health checks](../../../managed-kubernetes/tutorials/custom-health-checks.md) to monitor your applications across all pods.

{% note warning %}

Do not manually update {{ alb-name }} resources created by the controller's leader pod. The system will automatically revert any manual modifications. Use the standard {{ managed-k8s-name }} cluster management methods instead.

{% endnote %}

The leader pod manages the {{ alb-name }} resource architecture according to these rules:

* Based on [Ingress](../../k8s-ref/ingress.md) configurations, the system creates load balancers and HTTP routers receving and distributing incoming traffic across backend groups. 
  
  `Ingress` resources with the same `ingress.alb.yc.io/group-name` annotations are consolidated into one load balancer.

  * To enable HTTPS traffic on the load balancer, specify your service domain names and {{ certificate-manager-name }} certificate IDs in the `Ingress` `spec.tls` field:

    ```yaml
    spec:
      tls:
        - hosts:
            - <domain_name>
          secretName: yc-certmgr-cert-id-<certificate_ID>
    ```

    Where `secretName` refers to the {{ certificate-manager-full-name }} certificate.

    When this field is configured, the system will create two types of load balancer listeners: HTTPS listeners to serve encrypted traffic on port `443`, and HTTP listeners responding to requests on port `80` with a `301 Moved Permanently` status code redirecting clients to the HTTPS endpoint. If multiple `Ingress` rules apply to the same domain, rules without `spec.tls`, i.e., HTTP-only, will take priority over HTTP-to-HTTPS redirects.

    {% include [k8s-ingress-controller-secret-name](../../../_includes/application-load-balancer/k8s-ingress-controller-secret-name.md) %}
    
  * If the `spec.tls` field is omitted in the `Ingress` description, the system will only create HTTP listeners processing unencrypted traffic on port `80`.

  * If no traffic distribution rules are specified in the `Ingress` description, incoming requests will be routed to the [default backend](../../k8s-ref/ingress.md#default-backend).

* To process incoming traffic, you can create backend groups using the following methods:

  * Specify relevant {{ k8s }} services directly in `Ingress` [rules](../../../application-load-balancer/k8s-ref/ingress.md#rule). Use this method for routing traffic to backend groups containing only one service.

    Pre-0.2.0 [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) versions map each backend group to a distinct combination of `host`, `http.paths.path`, and `http.paths.pathType` values specified in an `Ingress` rule. ALB Ingress Controllers version 0.2.0 and later map backend groups directly to the `backend.service` configuration. This may cause collisions when upgrading the ALB Ingress Controller. To avoid them, check the [upgrade restrictions](../../operations/k8s-ingress-controller-upgrade.md) for your infrastructure.

  * Describe your backend groups using [HttpBackendGroup](../../k8s-ref/http-backend-group.md) resources. These [custom resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) are defined in the `alb.yc.io` API group provided by an ingress controller.

    The same as services, you must specify your `HttpBackendGroup` resources in the `Ingress` rules, i.e., `spec.rules[*].http.paths[*].backend.resource`. 

    {% include [k8s-ingress-controller-backend-group-features](../../../_includes/application-load-balancer/k8s-ingress-controller-backend-group-features.md) %}

  * Describe your backend groups using [GrpcBackendGroup](../../k8s-ref/grpc-backend-group.md) resources. These [custom resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) are defined in the `alb.yc.io` API group provided by an ingress controller.

    The same as services, you must specify your `GrpcBackendGroup` resources in the `Ingress` rules, i.e., `spec.rules[*].http.paths[*].backend.resource`.  

* The system will deploy backend services specified in the `Ingress` or `HttpBackendGroup`/`GrpcBackendGroup` resources. You can configure them through [Service](../../k8s-ref/service-for-ingress.md) resources.

  {% include [k8s-ingress-controller-nodeport-note](../../../_includes/application-load-balancer/k8s-ingress-controller-nodeport-note.md) %}

## {{ alb-name }}-to-{{ k8s }} resource mapping {#mapping}

| {{ alb-name }} | {{ k8s }} |
| ----- | ----- |
| [Load balancer](../../concepts/application-load-balancer.md) | [Ingress](../../k8s-ref/ingress.md) resources with the same `ingress.alb.yc.io/group-name` annotations |
| HTTP router [virtual hosts](../../concepts/http-router.md#virtual-host) | `Ingress.spec.rules` |
| Virtual host [routes](../../concepts/http-router.md#routes) | `Ingress.spec.rules[*].http.paths` |
| [Backend group](../../concepts/backend-group.md) | [HttpBackendGroup](../../k8s-ref/http-backend-group.md)/[GrpcBackendGroup](../../k8s-ref/grpc-backend-group.md) or [services](../../k8s-ref/service-for-ingress.md) |
| [Target group](../../concepts/target-group.md) | Cluster [node group](../../../managed-kubernetes/concepts/index.md#node-group) |

## Load balancer resource IDs within a {{ k8s }} cluster {#alb-ids}

For an {{ alb-name }} load balancer deployed according to the `Ingress` configuration, its resource IDs are specified in the custom {{ managed-k8s-name }} cluster resource, `IngressGroupStatus`. To see them, do the following:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your {{ managed-k8s-name }} cluster.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the {{ managed-k8s-name }} cluster whose `Ingress` configuration was used to create the load balancer.
  1. On the {{ managed-k8s-name }} cluster page, navigate to the ![shapes-3](../../../_assets/console-icons/shapes-3.svg) **{{ ui-key.yacloud.k8s.cluster.switch_custom-resources }}** tab.
  1. Select `ingressgroupstatuses.alb.yc.io` and navigate to the **{{ ui-key.yacloud.k8s.custom-resources.label_tab-resources }}** tab.
  1. Select a resource that has its `Ingress` resource group name specified in the `ingress.alb.yc.io/group-name` annotation and navigate to the **{{ ui-key.yacloud.k8s.workloads.label_tab-yaml }}** tab.

- kubectl CLI {#kubectl}

  1. {% include [kubectl-install-links](../../../_includes/managed-kubernetes/kubectl-install.md) %}
  1. Run this command:

      ```bash
      kubectl describe IngressGroupStatus
      ```

{% endlist %}