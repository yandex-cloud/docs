---
title: How to work with broker certificates in {{ iot-full-name }}
description: In this tutorial, you will learn how to get a list of broker certificates and add or delete a broker certificate in {{ iot-full-name }}.
---

# Managing broker certificates

{% include [note-pp](../../../_includes/iot-core/note-pp.md) %}

To start exchanging messages between broker clients, you must [log in](../../concepts/authorization.md). This section describes how to manage broker certificates for the relevant authorization method.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

- [Viewing a list of broker certificates](broker-certificates.md#list-cert)
- [Adding a certificate to a broker](broker-certificates.md#add-cert)
- [Deleting a broker certificate](broker-certificates.md#delete-cert)

To access a [broker](../../concepts/index.md#broker), use its unique ID or name. For info on how to get the unique broker ID or name, see [{#T}](../broker/broker-list.md).

## Getting a list of broker certificates {#broker-certificates-list}

{% include [broker-certificates-list](../../../_includes/iot-core/broker-certificates-list.md) %}

## Adding a certificate {#add-cert}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder to add the broker certificate to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. In the left-hand panel, select **{{ ui-key.yacloud.iot.label_brokers }}**.
   1. Select the appropriate broker from the list.
   1. On the **{{ ui-key.yacloud.common.overview }}** page, go to the **{{ ui-key.yacloud.iot.label_certificates }}** section and click **{{ ui-key.yacloud.component.certificates.button_empty-add }}**.

      - To add a file:

         1. Choose the `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` method.
         1. Click **Attach file**.
         1. Select the certificate file on your computer and click **Open**.
         1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

      - To add text:

         1. Choose the `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}` method.
         1. Insert the certificate body in the **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** field.
         1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}
    
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Add a certificate to the broker:

  ```bash
  yc iot broker certificate add \
    --broker-name my-broker \
    --certificate-file broker-cert.pem
  ```

  Where:
  * `--broker-name`: Broker name.
  * `--certificate-file`: Path to the public part of the certificate.
  
  Result:
  ```text
  broker_id: b91ki3851h**********
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

  To add a certificate to a broker created using {{ TF }}:

  1. In the configuration file, describe the parameters of the resources you want to create:

     * `yandex_iot_core_broker`: Broker parameters:
       * `name`: Broker name.
       * `description`: Broker description.
       * `certificates`: List of broker certificates for authorization using [certificates](../../concepts/authorization.md#certs).

      Example broker description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
      ...
        certificates = [
          file("<path_to_first_certificate_file>"),
          file("<path_to_second_certificate_file>")
        ]
      ...
      }
      ```

      For more information about the `yandex_iot_core_broker` parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/iot_core_broker).
  1. In the command line, change to the folder where you edited the configuration file.
  1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
  1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

  1. Confirm the changes: type `yes` into the terminal and click **Enter**.

      You can verify broker certificates in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot broker certificate list --broker-name <broker_name>
      ```

- API {#api}

  To add a certificate to a broker, use the [addCertificate](../../broker/api-ref/Broker/addCertificate.md) REST API method for the [Broker](../../broker/api-ref/Broker/index.md) resource or the [BrokerService/AddCertificate](../../broker/api-ref/grpc/broker_service.md#AddCertificate) gRPC API call.

{% endlist %}

## Deleting a certificate {#delete-cert}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder to delete the broker certificate from.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. In the left-hand panel, select **{{ ui-key.yacloud.iot.label_brokers }}**.
   1. Select the appropriate broker from the list.
   1. On the **{{ ui-key.yacloud.common.overview }}** page, go to the **{{ ui-key.yacloud.iot.label_certificates }}** section.
   1. In the line with the certificate you need, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}** from the drop-down list.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}
    
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Delete a broker certificate:

      ```bash
      yc iot broker certificate delete --broker-name my-broker --fingerprint 0f...
      ```

  1. Make sure the certificate was deleted:

      ```bash
      yc iot broker certificate list --broker-name my-broker
	    ```

	    Result:
	  
	    ```text
      +-------------+------------+
      | FINGERPRINT | CREATED AT |
      +-------------+------------+
      +-------------+------------+
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To delete a broker certificate created using {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the value of the certificate in the `certificates` block, in the fragment with the broker description. To remove all certificates, delete the entire `certificates` block.

      Example broker description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
      ...
        certificates = [
          file("<path_to_first_certificate_file>"),
          file("<path_to_second_certificate_file>")
        ]
      ...
      }
      ```

      For more information about the `yandex_iot_core_broker` parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/iot_core_broker).
  1. In the command line, change to the folder where you edited the configuration file.
  1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
  1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

  1. Confirm the changes: type `yes` into the terminal and click **Enter**.

      You can verify broker certificates in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot broker certificate list --broker-name <broker_name>
      ```

- API {#api}

  To delete a broker certificate, use the [deleteCertificate](../../broker/api-ref/Broker/deleteCertificate.md) REST API method for the [Broker](../../broker/api-ref/Broker/index.md) resource or the [BrokerService/DeleteCertificate](../../broker/api-ref/grpc/broker_service.md#DeleteCertificate) gRPC API call.

{% endlist %}