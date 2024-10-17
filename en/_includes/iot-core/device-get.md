{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the device is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Select the registry where the device is located.
   1. Go to the **{{ ui-key.yacloud.iot.label_devices }}** tab.
   1. Select the device.
   1. The **{{ ui-key.yacloud.common.overview }}** page will show the device details.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}
  1. View the description of the CLI command to get information about a device:

      ```bash
      yc iot device get --help
      ```

  1. Get detailed information about a device by specifying its name or ID:

      ```bash
      yc iot device get <device_name>
      ```

      Result:

      ```text
      id: b9135goeh1uc********
      registry_id: b91ki3851hab********
      created_at: "2019-05-28T16:08:30.938Z"
      name: my-device
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To get detailed information about a device using {{ TF }}:
  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

     ```hcl
     data "yandex_iot_core_device" "my_device" {
       device_id = "<device_ID>"
     }

     output "device_params" {
       value = data.yandex_iot_core_device.my_device.registry_id
     }
     ```

     Where:
     * `data "yandex_iot_core_device"`: Description of the device as a data source:
       * `device_id`: Device ID.
     * `output "device_params"`: Output variable containing information about the registry the device belongs to:
       * `value`: Returned value.

     You can replace `registry_id` with any other parameter to get the information you need. For more information about the `yandex_iot_core_device` data source parameters, see the [provider documentation]({{ tf-provider-datasources-link }}/datasource_iot_core_device).
  1. Create resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

     ```bash
     terraform output
     ```

     Result:

     ```text
     device_params = "are7ajlrf493********"
     ```

- API {#api}

  To get detailed information about a device, use the [get](../../iot-core/api-ref/Device/get.md) REST API method for the [Device](../../iot-core/api-ref/Device/index.md) resource or the [DeviceService/Get](../../iot-core/api-ref/grpc/Device/get.md) gRPC API call.

{% endlist %}
