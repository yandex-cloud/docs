# Configuring access to a registry

You can set up policies for accessing a [registry](../../concepts/registry.md) from specific [IP addresses](../../../vpc/concepts/address.md).

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the registry was created.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Select the registry to configure access to.
  1. In the left-hand panel, click ![IP-access](../../../_assets/container-registry/ip-access.svg) **{{ ui-key.yacloud.cr.registry.label_ip-permissions }}**.
  1. Click **{{ ui-key.yacloud.cr.registry.button_update-ip-permissions }}**.
  1. Enter the IP and specify an action: PULL to allow pulling and PUSH to allow pushing Docker images to the registry.
  1. To configure access for multiple IPs, click **{{ ui-key.yacloud.common.add }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI

  1. View the list of available registries, their names and IDs:

     ```bash
     yc container registry list
     ```

     Result:

     ```bash
     +-----------------+-------------------+---------------+
     |        ID       |    NAME           |   FOLDER ID   |
     +-----------------+-------------------+---------------+
     |  <registry_ID>  |  <registry_name>  |  <folder_ID>  |
     +-----------------+-------------------+---------------+
     ```

  1. Specify registry access settings.

     ```bash
     yc container registry set-ip-permissions <registry_name> \
       --pull <IP address> \
       --push <IP address>
     ```

     Where:
     * `--pull`: Flag that allows pulling [Docker images](../../concepts/docker-image.md) from the registry.
     * `--push`: Flag that allows pushing Docker images to the registry.

     To learn more about the command, see the [CLI reference](../../../cli/cli-ref/managed-services/container/registry/set-ip-permissions).

     As a result of executing this command, all the permissions set for IP addresses will be deleted. To continue, type `yes` and press **Enter**.

     Result:

     ```text
     WARN: All current ip permissions will be deleted. Are you sure?[y/N]
     ```

  1. Check the current permissions:

     ```bash
     yc container registry list-ip-permissions <registry_name>
     ```

     Result:

     ```bash
     +--------+--------------+
     | ACTION |      IP      |
     +--------+--------------+
     | PULL   | <IP address> |
     | PUSH   | <IP address> |
     +--------+--------------+
     ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. Specify registry access settings in the {{ TF }} configuration file.

      ```hcl
      resource "yandex_container_registry_ip_permission" "my_ip_permission" {
        registry_id = <registry_ID>
        push        = [ "<IP address>", "<IP address>" ]
        pull        = [ "<IP address>", "<IP address>" ]
      }
      ```

      Where:

      * `my_registry`: Registry ID. If the configuration already contains the [yandex_container_registry]({{ tf-provider-resources-link }}/container_registry) resource, you can specify it, e.g., `yandex_container_registry.my_registry.id`.
      * `pull`: IP addresses that can be used to pull Docker images from the registry. This is an optional parameter.
      * `push`: IP addresses that can be used to push Docker images to the registry. This is an optional parameter.

      For more information about the `yandex_container_registry_ip_permission` parameters in Terraform, see the [provider documentation]({{ tf-provider-resources-link }}/container_registry_ip_permission).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc container registry list-ip-permissions <registry_name>
      ```

{% endlist %}
