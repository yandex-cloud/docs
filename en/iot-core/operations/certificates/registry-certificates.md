# Managing registry certificates

{% include [iot-sunset-warning](../../../_includes/iot-core/sunset-warning.md) %}

To start exchanging data and commands between devices and registries, you need to [authenticate](../../concepts/authorization.md). This section describes how to manage registry certificates for the relevant authentication method.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

- [Viewing a list of registry certificates](registry-certificates.md#list-cert)
- [Adding a certificate to a registry](registry-certificates.md#add-cert)
- [Deleting a registry certificate](registry-certificates.md#delete-cert)

To access a [registry](../../concepts/index.md#registry), use its unique ID or name. For information on how to get the unique ID or name of a registry, see [{#T}](../registry/registry-list.md).

## Getting a list of registry certificates {#registry-certificates-list}

{% include [registry-certificates-list](../../../_includes/iot-core/registry-certificates-list.md) %}

## Adding a certificate {#add-cert}

{% list tabs group=instructions %}

- Management console {#console}

   To add a registry certificate:

   1. In the [management console]({{ link-console-main }}), select the folder where you want to add a registry certificate.
   1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Select the registry from the list.
   1. On the **{{ ui-key.yacloud.common.overview }}** page, navigate to **{{ ui-key.yacloud.iot.label_certificates }}** and click **{{ ui-key.yacloud.component.certificates.button_empty-add }}**.

      - To add a file:

         1. Select the `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` method.
         1. Click **Attach file**.
         1. Specify the certificate file on your computer and click **Open**.
         1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

      - To add text:

         1. Select the `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}` method.
         1. Paste the certificate body into the **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** field.
         1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Add a certificate to the registry:

  ```
  yc iot registry certificate add \
    --registry-name my-registry \ # Registry name.
    --certificate-file registry-cert.pem # Path to the public part of the certificate.
  ```
  
  Result:
  ```
  registry_id: b91ki3851hab********
  fingerprint: 589ce1605...
  certificate_data: |
    -----BEGIN CERTIFICATE-----
    MIIE/jCCAuagAw...
    -----END CERTIFICATE-----
  created_at: "2019-05-29T16:40:48.230Z"
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To add a certificate to a registry created with {{ TF }}:

  1. In the configuration file, specify the properties of the resources you want to create:

     * `yandex_iot_core_registry`: Registry settings:
       * `name`: Registry name.
       * `description`: Registry description.
       * `certificates`: List of registry certificates for [certificate](../../concepts/authorization.md#certs)-based authentication.

      Here is an example of a registry description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
      ...
        certificates = [
          file("<path_to_first_certificate_file>"),
          file("<path_to_second_certificate_file>")
        ]
      ...
      }
      ```

      For more information about `yandex_iot_core_registry` properties in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/iot_core_registry).
  1. In the terminal, navigate to the directory where you edited the configuration file.
  1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```
     
      If the configuration is valid, you will get this message:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Run this command:

      ```bash
      terraform plan
      ```
  
      You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors detected in the configuration.
  1. Apply the configuration changes:

      ```bash
      terraform apply
      ```
     
  1. Type `yes` and press **Enter** to confirm the changes.

      You can check registry certificates using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot registry certificate list --registry-name <registry_name>
      ```

- API {#api}

  To add a certificate to a registry, use the [addCertificate](../../api-ref/Registry/addCertificate.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/AddCertificate](../../api-ref/grpc/Registry/addCertificate.md) gRPC API call.

{% endlist %}

## Deleting a certificate {#delete-cert}

{% list tabs group=instructions %}

- Management console {#console}

   To delete a registry certificate:

   1. In the [management console]({{ link-console-main }}), select the folder where you want to delete a registry certificate.
   1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Select the registry from the list.
   1. On the **{{ ui-key.yacloud.common.overview }}** page, go to the **{{ ui-key.yacloud.iot.label_certificates }}** section.
   1. In the row with the certificate, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}** from the drop-down list.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Delete a registry certificate:

      ```
      yc iot registry certificate delete --registry-name my-registry --fingerprint 0f...
      ```

  1. Make sure the certificate has been deleted:

      ```
      yc iot registry certificate list --registry-name my-registry
	    ```
	  
	    Result:
	  
	    ```
      +-------------+------------+
      | FINGERPRINT | CREATED AT |
      +-------------+------------+
      +-------------+------------+
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To delete a certificate of a registry created with {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the certificate value from the `certificates` section in the registry description. To remove all certificates, delete the entire `certificates` section.

      Here is an example of a registry description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
      ...
        certificates = [
          file("<path_to_first_certificate_file>"),
          file("<path_to_second_certificate_file>")
        ]
      ...
      }
      ```

      For more information about `yandex_iot_core_registry` properties in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/iot_core_registry).
  1. In the terminal, navigate to the directory where you edited the configuration file.
  1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```
     
      If the configuration is valid, you will get this message:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Run this command:

      ```bash
      terraform plan
      ```
  
      You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors detected in the configuration.
  1. Apply the configuration changes:

      ```bash
      terraform apply
      ```
     
  1. Type `yes` and press **Enter** to confirm the changes.

      You can check registry certificates using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot registry certificate list --registry-name <registry_name>
      ```

- API {#api}

  To delete a registry certificate, use the [deleteCertificate](../../api-ref/Registry/deleteCertificate.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/DeleteCertificate](../../api-ref/grpc/Registry/deleteCertificate.md) gRPC API call.

{% endlist %}