# Creating a registry

The new [registry](../../concepts/registry.md) can be used by all users and [service accounts](../../../iam/concepts/users/service-accounts.md) with access permissions for the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder). 

You can create a secure registry with autoscanning using a [vulnerability scanner](../../concepts/vulnerability-scanner.md).

{% note info %}

Scanning Docker images for vulnerabilities is [charged](../../pricing.md#scanner).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a registry.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Click **{{ ui-key.yacloud.cr.overview.button_create }}**.
  1. Specify a name for the registry. The naming requirements are as follows:

     {% include [name-format](../../../_includes/name-format.md) %}

  1. Optionally, under **{{ ui-key.yacloud.cr.overview.popup-create_field_auto_scan }}**:


      * Disable **{{ ui-key.yacloud.cr.overview.popup-create_scan_push_text }}** to skip scanning of Docker images at their upload to the repository.
      * Disable **{{ ui-key.yacloud.cr.overview.popup-create_scan_period_enabled }}** or set the scanning frequency.

        {% include [safe-registry](../../../_includes/container-registry/safe-registry.md) %}

  1. Optionally, add labels.
  1. Click **{{ ui-key.yacloud.cr.overview.popup-create_button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Make sure that a registry has not been created in the folder yet:

     ```bash
     yc container registry list
     ```

     Result:

     ```text
     +----+------+-----------+
     | ID | NAME | FOLDER ID |
     +----+------+-----------+
     +----+------+-----------+
     ```

     If the folder already contains a registry, see [{#T}](registry-update.md) for info on how you can update it.
  1. Create a registry:

      * With automated vulnerability scanning:


         ```bash
         yc container registry create --name my-reg --secure
         ```
 
        {% include [safe-registry](../../../_includes/container-registry/safe-registry.md) %}

      * Without automated vulnerability scanning:

         ```bash
         yc container registry create --name my-reg
         ```

     Result:

     ```text
     done
     id: crpd50616s9a********
     folder_id: b1g88tflru0e********
     name: my-reg
     status: ACTIVE
     created_at: "2019-01-09T14:34:06.601Z"
     ```

     Follow these registry naming requirements:

     {% include [name-format](../../../_includes/name-format.md) %}

     The `--name` parameter is optional. You can create a registry without a name and use its ID to access it. The `name` field is user-defined. It is used when listing in the {{ yandex-cloud }} CLI and **not used** in the Docker CLI.
  1. Make sure the registry was created:

     ```bash
     yc container registry list
     ```

     Result:

     ```text
     +----------------------+--------+----------------------+
     |          ID          |  NAME  |      FOLDER ID       |
     +----------------------+--------+----------------------+
     | crpd50616s9a******** | my-reg | b1g88tflru0e******** |
     +----------------------+--------+----------------------+
     ```

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

  To create a registry, use the [create](../../api-ref/Registry/create.md) method for the [Registry](../../api-ref/Registry/) resource.

{% endlist %}
