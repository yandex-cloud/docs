# {{ TF }} data sources

[{{ TF }} data sources](https://developer.hashicorp.com/terraform/language/data-sources) allow you to get up-to-date information about the existing cloud resources and use this data in your infrastructure configuration.

With the [{{ yandex-cloud }} {{ TF }} provider]({{ tf-docs-link }}), you can get information about various cloud resources, including [VMs](../../compute/concepts/vm.md), [disks](../../compute/concepts/disk.md), [cloud networks](../../vpc/concepts/network.md), etc.

Data sources are available as read only, which prevents any changes to external resources.

Let's use {{ TF }} data sources to get an [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts) image ID from {{ marketplace-name }}.

To get an `Ubuntu 22.04 LTS` image ID using {{ TF }}:

1. [Get your cloud ready](#before-you-begin).
1. [Install and configure {{ TF }}](#prepare-terraform).
1. [Describe the data source](#prepare-plan).
1. [Check the result](#check).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

## Install and configure {{ TF }} {#prepare-terraform}

{% include notitle [terraform-prepare.md](../../_tutorials/infrastructure/terraform-prepare.md) %}

## Describe a data source {#prepare-plan}

{% note tip %}

In the {{ TF }} code, data sources are defined using the `data` block.

{% endnote %}

1. In the configuration file, paste this code after the provider settings:

    ```hcl
    data "yandex_compute_image" "my_image" {
      family = "ubuntu-2204-lts"
    }

    output "my_image_id" {
      value = data.yandex_compute_image.my_image.id
    }
    ```

    Where:

    * `data "yandex_compute_image"`: Disk image description as a data source:
        * `family`: [Image family](../../compute/concepts/image.md#family).
    * `output "resource_active"`: Output variable with information about the current image ID for the specified family:
        * `value`: Return value.

    For more information about the `yandex_compute_image` data source parameters, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/compute_image).

1. Create the resources:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

    {{ TF }} will create the required resources and display their output variables.

## Check the result {#check}

To check the results, run this command:

```bash
terraform output
```

Result:

```text
my_image_id = "fd8li2lvvfc6bdj4c787"
```

Then you can use this ID to [create a VM](../../compute/operations/images-with-pre-installed-software/create.md), e.g.:

```hcl
resource "yandex_compute_disk" "boot-disk" {
  name     = "<disk_name>"
  type     = "<disk_type>"
  zone     = "<availability_zone>"
  size     = "<disk_size>"
  image_id = data.yandex_compute_image.my_image.id
}

...
```

## See also {#see-also}

* [Getting started with {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [Uploading {{ TF }} states to {{ objstorage-name }}](../../tutorials/infrastructure-management/terraform-state-storage.md).
* [Locking {{ TF }} states using {{ ydb-name }}](../../tutorials/infrastructure-management/terraform-state-lock.md).
* [Using {{ yandex-cloud }} modules in {{ TF }}](../../tutorials/infrastructure-management/terraform-modules.md).