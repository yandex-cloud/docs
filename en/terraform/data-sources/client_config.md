---
subcategory: Client Config
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/client_config.md
---

# yandex_client_config (DataSource)

Get attributes used by provider to configure client connection.

## Example usage

```terraform
//
// Example of using Yandex Cloud client configuration
//
data "yandex_client_config" "client" {}

data "yandex_kubernetes_cluster" "kubernetes" {
  name = "kubernetes"
}

provider "kubernetes" {
  load_config_file = false

  host                   = data.yandex_kubernetes_cluster.kubernetes.master.0.external_v4_endpoint
  cluster_ca_certificate = data.yandex_kubernetes_cluster.kubernetes.master.0.cluster_ca_certificate
  token                  = data.yandex_client_config.client.iam_token
}
```

## Arguments & Attributes Reference

- `cloud_id` (*Read-Only*) (String). The ID of the cloud that the provider is connecting to.
- `folder_id` (*Read-Only*) (String). The ID of the folder in which we operate.
- `iam_token` (*Read-Only*) (String). A short-lived token that can be used for authentication in a Kubernetes cluster.
- `id` (String). 
- `zone` (*Read-Only*) (String). The default availability zone.


