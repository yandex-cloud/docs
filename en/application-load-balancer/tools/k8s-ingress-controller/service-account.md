---
title: Service account for {{ alb-full-name }} tools for {{ managed-k8s-full-name }}
description: In this tutorial, you will learn which roles a service account requires to use {{ alb-name }} tools for {{ managed-k8s-name }}.
---

# Service account for {{ alb-name }} tools for {{ managed-k8s-name }}


The {{ alb-name }} tools for {{ managed-k8s-name }}, i.e., [Ingress controller](index.md) and [Gateway API](../k8s-gateway-api/index.md), deploy the infrastructure on behalf of a [service account](../../../iam/concepts/users/service-accounts.md). This account requires the following permissions:


{% list tabs %}

- Ingress controller


  | Service | Type of permission required | Minimum role |
  | ----- | ----- | ----- |
  | {{ alb-name }}<br/>([roles](../../security/index.md)) | Manage service resources | `alb.editor` |
  | {{ vpc-name }}<br/>([roles](../../../vpc/security/index.md)) | Manage internal or external connectivity depending on load balancer type | `vpc.publicAdmin` (external)<br/>`vpc.privateAdmin` (internal) |
  | {{ certificate-manager-name }}<br/>([roles](../../../certificate-manager/security/index.md)) | Obtain certificates (for HTTPS load balancers) | `certificate-manager.certificates.downloader` |
  | {{ compute-name }}<br/>([roles](../../../compute/security/index.md)) | Get information on virtual machines created as {{ managed-k8s-name }} cluster nodes | `compute.viewer` |


- Gateway API

   | Service | Type of permission required | Minimum role |
   | ----- | ----- | ----- |
   | {{ alb-name }}<br/>([roles](../../security/index.md)) | Manage service resources | `alb.editor` |
   | {{ vpc-name }}<br/>([roles](../../../vpc/security/index.md)) | Manage internal or external connectivity depending on load balancer type | `vpc.publicAdmin` (external)<br/>`vpc.privateAdmin` (internal) |
   | {{ certificate-manager-name }}<br/>([roles](../../../certificate-manager/security/index.md)) | Manage certificates (for HTTPS load balancers) | `certificate-manager.certificates.admin` |
   | {{ compute-name }}<br/>([roles](../../../compute/security/index.md)) | Get information on virtual machines created as {{ managed-k8s-name }} cluster nodes | `compute.viewer` |

{% endlist %}


An [authorized key](../../../iam/concepts/authorization/key.md) is used to authenticate the service account. The key must be specified in the `saKeySecretKey` value when installing a Helm chart with an Ingress controller or Gateway API. For instance, if you created the key via the [`yc iam key create` CLI command](../../../cli/cli-ref/managed-services/iam/key/create.md) and saved it to `sa-key.json`, the chart installation command may look like this:

```bash
helm install \
  --namespace yc-alb \
  --set-file saKeySecretKey=sa-key.json \
  ...
```

The key will be stored in the `yc-alb-ingress-controller-sa-key` or `yc-alb-gateway-api-controller-sa-key` secret in the namespace specified when installing the chart (`yc-alb` in the above example).
