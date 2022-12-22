# Ingress controller for {{ managed-k8s-name }}

{{ alb-name }} provides the {{ alb-name }} Ingress controller as a tool to create and manage load balancers in [{{ managed-k8s-full-name }} clusters](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

After installing the controller, you will be able to use it to create an [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) resource to handle incoming traffic. Based on the `Ingress` configuration, an [L7 load balancer](../../concepts/application-load-balancer.md) will be deployed automatically with all the requisite {{ alb-name }} resources.

## Sample configuration {#example}

Below is an abbreviated sample configuration for an `Ingress` resource. It will be used to create a load balancer to receive HTTPS traffic and to distribute it to two services based on the URI request path.

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
        - <domain name>
      secretName: yc-certmgr-cert-id-<certificate ID from {{ certificate-manager-full-name }}>
  rules:
    - host: <domain name>
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

{% endcut %}

## Installation and requirements {#install}

A {{ alb-name }} Ingress controller is provided as a Helm chart. Its installation requires:
* The [Helm](https://helm.sh/) package manager, version {{ alb-ingress-helm-version }} or higher with [OCI support enabled](https://helm.sh/docs/topics/registries/).
* A {{ managed-k8s-name }} cluster.
* A cluster node group.
* A cluster namespace to store the [service account](service-account.md) key.

You can download and install the chart using the commands below:

```bash
export HELM_EXPERIMENTAL_OCI=1
helm pull \
  --version v{{ alb-ingress-version }} \
  oci://{{ registry }}/yc/yc-alb-ingress-controller-chart
helm install \
  --namespace <namespace name> \
  --set folderId=<folder ID> \
  --set clusterId=<cluster ID> \
  --set-file saKeySecretKey=<path to file with service account key> \
  yc-alb-ingress-controller ./yc-alb-ingress-controller-chart-{{ alb-ingress-version }}.tgz
```

For more detail, please see the [complete installation instructions](../../operations/k8s-ingress-controller-install.md).

#### See also {#see-also}

* [Controller operating principles](principles.md).
* [Security group configuration](security-groups.md) for a {{ k8s }} cluster and a load balancer.
* [Service account](service-account.md) to support controller operation.