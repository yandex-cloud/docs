---
subcategory: Kubernetes Marketplace
---

# yandex_kubernetes_marketplace_helm_release (Resource)

Allows management of Kubernetes product installed from Yandex Cloud Marketplace.
For more information, see [official documentation](https://yandex.cloud/marketplace?type=K8S).

## Example usage

```terraform
//
// Create a new Kubernetes Marketplace Helm Release.
//
resource "yandex_kubernetes_marketplace_helm_release" "gwin_helm_release" {
  cluster_id = yandex_kubernetes_cluster.cluster_resource_name.id

  product_version = "f2e04077v04sobds7gkt" // Gwin v1.1.0

  name      = "gwin"
  namespace = kubernetes_namespace.namespace_resource_name.metadata[0].name

  user_values = {
    "controller.folderId" = yandex_resourcemanager_folder.folder_resource_name.id
    "controller.ycServiceAccount.workloadIdentityFederation.serviceAccountID" = yandex_iam_service_account.service_account_resource_name.id
    "controller.defaultBalancerSubnets" = yamlencode([
      yandex_vpc_subnet.subnet_resource_name_1.id,
      yandex_vpc_subnet.subnet_resource_name_2.id
    ])
  }
}
```

## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). The ID of the Kubernetes cluster where the product will be installed.
- `created_at` (*Read-Only*) (String). The Helm Release creation (first installation) timestamp.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The name of the deployment.
- `namespace` (**Required**)(String). The Kubernetes namespace where the product will be installed.
- `product_id` (*Read-Only*) (String). The ID of the Marketplace product.
- `product_name` (*Read-Only*) (String). The name of the Marketplace product.
- `product_version` (**Required**)(String). The ID of the product version to be installed.
- `status` (*Read-Only*) (String). Status of the deployment.
- `user_values` (Map Of String). Values to be passed for the installation of the product. The block consists of attributes that accept string values. For complex objects and lists, use `yamlencode()` function to properly encode the values (see example above with `defaultBalancerSubnets`). The exact structure depends on the particular product and may differ for different versions of the same product. Depending on the product, some values may be required, and the installation may fail if they are not provided.
{% note warning %}

`applicationName` and `namespace`, if provided in this block, override `name` and `namespace` arguments, respectively.

{% endnote %}


- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_kubernetes_marketplace_helm_release.<resource Name> <resource Id>
terraform import yandex_kubernetes_marketplace_helm_release.default ...
```
