# Enabling a software-accelerated network

You can enable a [software-accelerated network](../../vpc/concepts/software-accelerated-network.md) when creating or updating a VM.

{% include [functional-agreement-required](../functional-agreement-required.md) %}

To enable a software-accelerated network on an existing VM:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder this VM belongs to.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** and select the VM.
  1. On the top panel, click ![image](../../_assets/console-icons/stop.svg) **{{ ui-key.yacloud.common.stop }}** and confirm stopping the VM.
  1. Wait for the VM status to change to `Stopped` and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** on the top panel.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, select **{{ ui-key.yacloud.component.compute.resources.field_sw-accelerated-net }}**.
  1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.
  1. On the top panel, click ![image](../../_assets/console-icons/stop.svg) **{{ ui-key.yacloud.common.stop }}** and confirm starting the VM.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the CLI command for updating VM parameters:

      ```bash
      yc compute instance update --help
      ```

  1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../compute/_includes_service/compute-instance-list.md) %}

  1. Select the `ID` or `NAME` of the relevant VM and stop it. For example, to stop a VM named `first-instance`, run this command:

      ```bash
      yc compute instance stop first-instance
      ```

  1. Enable a software-accelerated network:

      1. Run this command:

          ```bash
          yc compute instance update first-instance \
            --network-settings type=software-accelerated
          ```

          Where `--network-settings` is the parameter that switches the network type.

          Result:

          ```text
          id: fhm0b28lgfp4********
          folder_id: b1gbnv36zqf5********
          created_at: "2023-05-24T09:28:11Z"
          name: first-instance
          zone_id: {{ region-id }}-a
          platform_id: standard-v3
          resources:
            memory: "2147483648"
            cores: "2"
            core_fraction: "100"
          status: STOPPED
          ...
          network_settings:
            type: SOFTWARE_ACCELERATED
          placement_policy: {}
          ```

      1. Run the VM:

          ```bash
          yc compute instance start first-instance
          ```

  To disable a software-accelerated network, stop the VM and run this command:

    ```bash
    yc compute instance update first-instance \
      --network-settings type=standard
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../terraform-install.md) %}

  To enable a software accelerated network for a VM:

  1. In the configuration file, add the `network_acceleration_type` parameter to the `yandex_compute_instance` resource description:

     ```hcl
     resource "yandex_compute_instance" "example" {
       ...
       network_acceleration_type = "software_accelerated"
       ...
     }
     ```

     Where `network_acceleration_type` is the network acceleration type. The possible values are:

     * `software_accelerated`: Software-accelerated network.
     * `standard`: Standard network. Specify this value to disable software accelerated network.

     For more information about `yandex_compute_instance` properties, see [this provider guide]({{ tf-provider-resources-link }}/compute_instance).

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

    Use the [update](../../compute/api-ref/Instance/update.md) REST API method for the [Instance](../../compute/api-ref/Instance/index.md) resource or the [InstanceService/Update](../../compute/api-ref/grpc/Instance/update.md) gRPC API call.

    To enable software accelerated network, in the request body, set `networkSettings.type` to `SOFTWARE_ACCELERATED`; to disable, set to `STANDARD`.

{% endlist %}
