# Service account for {{ alb-name }} ingress controller

A [{{ alb-name }} ingress controller for {{ managed-k8s-name }}](index.md) deploys infrastructure on behalf of a [service account](../../../iam/concepts/users/service-accounts.md). This account requires the following permissions:

| Service | Type of permission required | Minimum role |
| ----- | ----- | ----- |
| {{ alb-name }}<br/>([roles](../../security/index.md)) | Manage service resources | `alb.editor` |
| {{ vpc-name }}<br/>([roles](../../../vpc/security/index.md)) | Manage internal or external connectivity depending on load balancer type | `vpc.publicAdmin` (external)<br/>`vpc.privateAdmin` (internal) |
| {{ certificate-manager-name }}<br/>([roles](../../../certificate-manager/security/index.md)) | Obtain certificates (for HTTPS load balancers) | `certificate-manager.certificates.downloader` |
| {{ compute-name }}<br/>([roles](../../../compute/security/index.md)) | Get information on virtual machines created as {{ managed-k8s-name }} cluster nodes | `compute.viewer` |

An [authorized key](../../../iam/concepts/authorization/key.md) is used to authenticate the service account. The key must be specified in the `saKeySecretKey` value when installing a Helm chart with an ingress controller. For instance, if you created the key via the [`yc iam key create` CLI command](../../../cli/cli-ref/managed-services/iam/key/create.md) and saved it to `sa-key.json`, the chart install command could look like this:

```bash
helm install \
  --namespace yc-alb-ingress \
  --set-file saKeySecretKey=sa-key.json \
  ...
```

The key will be stored in the `yc-alb-ingress-controller-sa-key` secret in the namespace entered when installing the chart (`yc-alb-ingress` in the above example).