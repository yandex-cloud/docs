---
title: Service account for {{ managed-k8s-full-name }} {{ alb-full-name }} tools
description: In this tutorial, you will learn about the service account roles required to use {{ managed-k8s-name }} {{ alb-name }} tools.
---

# Service account for {{ managed-k8s-name }} {{ alb-name }} tools

{{ managed-k8s-name }} {{ alb-name }} tools, e.g., [ingress controller](index.md) and [Gateway API](../k8s-gateway-api/index.md), use a [service account](../../../iam/concepts/users/service-accounts.md) to deploy infrastructure. This account requires the following permissions:

{% list tabs %}

- Ingress controller

  | Service | Type of permission required | Minimum required permissions |
  | ----- | ----- | ----- |
  | {{ alb-name }}<br/>([roles](../../security/index.md)) | Service resource management | `alb.editor` |
  | {{ vpc-name }}<br/>([roles](../../../vpc/security/index.md)) | Managing internal or external connectivity based on the load balancer type | `vpc.publicAdmin` (external)<br/>`vpc.privateAdmin` (internal) |
  | {{ certificate-manager-name }}<br/>([roles](../../../certificate-manager/security/index.md)) | Obtaining HTTPS load balancer certificates | `certificate-manager.certificates.downloader` |
  | {{ compute-name }}<br/>([roles](../../../compute/security/index.md)) | Getting information about {{ managed-k8s-name }} cluster node VMs | `compute.viewer` |

- Gateway API

  | Service | Type of permission required | Minimum required permissions |
  | ----- | ----- | ----- |
  | {{ alb-name }}<br/>([roles](../../security/index.md)) | Service resource management | `alb.editor` |
  | {{ vpc-name }}<br/>([roles](../../../vpc/security/index.md)) | Managing internal or external connectivity based on the load balancer type | `vpc.publicAdmin` (external)<br/>`vpc.privateAdmin` (internal) |
  | {{ certificate-manager-name }}<br/>([roles](../../../certificate-manager/security/index.md)) | Managing HTTPS load balancer certificates | `certificate-manager.certificates.admin` |
  | {{ compute-name }}<br/>([roles](../../../compute/security/index.md)) | Getting information about {{ managed-k8s-name }} cluster node VMs | `compute.viewer` |
  
{% endlist %}

The service account authenticates using an [authorized key](../../../iam/concepts/authorization/key.md). You must specify this key in the `saKeySecretKey` field when deploying a Helm chart with an ingress controller or Gateway API. For example, if you created your authorized key using the [`yc iam key create`](../../../cli/cli-ref/iam/cli-ref/key/create.md) CLI command and stored it to `sa-key.json`, the Helm chart installation command may look like this:

```bash
helm install \
  --namespace yc-alb \
  --set-file saKeySecretKey=sa-key.json \
  ...
```

The system will store the authorized key as either Secret `yc-alb-ingress-controller-sa-key` or Secret `yc-alb-gateway-api-controller-sa-key` in the namespace specified during Helm chart deployment, e.g.,`yc-alb`.
