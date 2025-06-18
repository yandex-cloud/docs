# Creating a registry

Any users and [service accounts](../../../iam/concepts/users/service-accounts.md) with [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) access rights can use the created [registry](../../concepts/registry.md). 

You can create a secure registry with autoscanning using a [vulnerability scanner](../../concepts/vulnerability-scanner.md).

{% note info %}

Scanning Docker images for vulnerabilities is [charged](../../pricing.md#scanner).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [create-registry-console](../../../_includes/container-registry/create-registry-console.md) %}

- CLI {#cli}

  {% include [create-registry-cli](../../../_includes/container-registry/create-registry-cli.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}
  1. Include the parameters of the registry you want to create in the configuration file, e.g., a file named `example.tf` in the `~/cloud-terraform` directory:

     ```hcl
     resource "yandex_container_registry" "my-reg" {
       name = "my-registry"
       folder_id = "<folder_ID>"
       labels = {
         my-label = "my-label-value"
       }
     }
     ```

     Where:
     * `name`: Registry name.
     * `folder_id`: Folder ID.
     * `labels`: [Labels](../../../resource-manager/concepts/labels.md) used.

     For more information about resources you can create with {{ TF }}, see [this provider reference]({{ tf-provider-link }}/).
  1. Check that the configuration file is correct.
     1. Use the command line to go to the directory where you saved the configuration file:

        ```bash
        cd /Users/<username>/cloud-terraform
        ```

     1. Run a check using this command:

        ```bash
        terraform plan
        ```

        Result:

        ```text
        Refreshing Terraform state in-memory prior to plan...
        The refreshed state will be used to calculate this plan, but will not be
        persisted to local or remote state storage.
        ...
        Note: You did not specify an "-out" parameter to save this plan, so Terraform
        cannot guarantee that exactly these actions will be performed if
        "terraform apply" is subsequently run.
        ```

  1. Create a registry.
     1. Run this command:

        ```bash
        terraform apply
        ```

        Result:

        ```text
        An execution plan has been generated and is shown below.
        Resource actions are indicated with the following symbols:
          + create
        ...
          Terraform will perform the actions described above.
          Only 'yes' will be accepted to approve.

          Enter a value:
        ```

     1. Confirm creation of the registry. To do this, type `yes` and press **Enter**:

        ```bash
        Enter a value: yes
        ```

        Result:

        ```text
        yandex_container_registry.default: Creating...
        yandex_container_registry.default: Creation complete after 4s [id=crpuljdfqoj3********]

        Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
        ```

        This will create a registry named `my-registry` in the folder.
     1. Check the resources and their settings in the [management console]({{ link-console-main }}).

- API {#api}

  {% include [create-registry-api](../../../_includes/container-registry/create-registry-api.md) %}

{% endlist %}
