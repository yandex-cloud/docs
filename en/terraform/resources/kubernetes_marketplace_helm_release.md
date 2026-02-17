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
resource "yandex_kubernetes_marketplace_helm_release" "gatekeeper_helm_release" {
  cluster_id = yandex_kubernetes_cluster.cluster_resource_name.id

  product_version = "f2ecif2vt62k2637tgus" // Gatekeeper 3.12.0

  name      = "gatekeeper"
  namespace = kubernetes_namespace.namespace_resource_name.name

  user_values = {
    auditInterval             = "90"
    constraintViolationsLimit = "30"
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
- `user_values` (Map Of String). Values to be passed for the installation of the product. The block consists of attributes that accept string values. The exact structure depends on the particular product and may differ for different versions of the same product. Depending on the product, some values may be required, and the installation may fail if they are not provided.
{% note warning %}

`applicationName` and `namespace`, if provided in this block, override `name` and `namespace` arguments, respectively.

{% endnote %}


## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_kubernetes_marketpalce_helm_release.<resource Name> <resource Id>
terraform import yandex_kubernetes_marketpalce_helm_release.default ...
```
