---
title: How to manage broker certificates in {{ iot-full-name }}
description: In this guide, you will learn how to get a list of broker certificates and add or delete a broker certificate in {{ iot-full-name }}.
---

# Managing broker certificates

{% include [iot-sunset-warning](../../../_includes/iot-core/sunset-warning.md) %}

{% include [note-pp](../../../_includes/iot-core/note-pp.md) %}

To start exchanging messages between broker clients, you need to [authenticate](../../concepts/authorization.md). This section describes how to manage broker certificates for the relevant authentication method.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

* [Viewing a list of broker certificates](broker-certificates.md#list-cert)
* [Adding a certificate to a broker](broker-certificates.md#add-cert)
* [Deleting a broker certificate](broker-certificates.md#delete-cert)

To access a [broker](../../concepts/index.md#broker), use its unique ID or name. For info on how to get a unique broker ID or name, see [{#T}](../broker/broker-list.md).

## Getting a list of broker certificates {#broker-certificates-list}

{% include [broker-certificates-list](../../../_includes/iot-core/broker-certificates-list.md) %}

## Adding a certificate {#add-cert}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to add a broker certificate.
   1. [Navigate]({{ link-console-main }}/link/iot-core) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/gear-branches.svg) **{{ ui-key.yacloud.iot.label_brokers }}** and then select the broker.
   1. On the **{{ ui-key.yacloud.common.overview }}** tab, navigate to the **{{ ui-key.yacloud.iot.label_certificates }}** section and click **{{ ui-key.yacloud.component.certificates.button_empty-add }}**.

      * To add a file:

         1. Select the `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` method.
         1. Click **{{ ui-key.yacloud_components.fileinput.button_attach-file }}**.
         1. Select the certificate file on your computer and click **Open**.
         1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

      * To add text:

         1. Select the `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}` method.
         1. Paste the certificate body into the **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** field.
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

  To add a certificate to a broker created with {{ TF }}:

  1. In the configuration file, specify the properties of the resources you want to create:

     * `yandex_iot_core_broker`: Broker settings:
     
       * `name`: Broker name.
       * `description`: Broker description.
       * `certificates`: List of broker certificates for [certificate](../../concepts/authorization.md#certs)-based authentication.

      Here is an example of a broker description in the {{ TF }} configuration:

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

      For more on the properties of the `yandex_iot_core_broker` resource, see [this provider guide]({{ tf-provider-resources-link }}/iot_core_broker).
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

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can check broker certificates using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot broker certificate list --broker-name <broker_name>
      ```

- API {#api}

  To add a certificate to a broker, use the [addCertificate](../../broker/api-ref/Broker/addCertificate.md) REST API method for the [Broker](../../broker/api-ref/Broker/index.md) resource or the [BrokerService/AddCertificate](../../broker/api-ref/grpc/Broker/addCertificate.md) gRPC API call.

{% endlist %}

## Deleting a certificate {#delete-cert}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to delete a broker certificate.
   1. [Navigate]({{ link-console-main }}/link/iot-core) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/gear-branches.svg) **{{ ui-key.yacloud.iot.label_brokers }}** and then select the broker.
   1. On the **{{ ui-key.yacloud.common.overview }}** tab, go to **{{ ui-key.yacloud.iot.label_certificates }}**.
   1. To the right of the certificate you want to delete, click ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.common.delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.component.certificates.popup-confirm_button_delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}
    
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Delete a broker certificate:

      ```bash
      yc iot broker certificate delete --broker-name my-broker --fingerprint 0f...
      ```

  1. Make sure the certificate has been deleted:

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

  To delete a broker certificate created with {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the certificate value from the `certificates` section in the broker description. To remove all certificates, delete the entire `certificates` section.

      Here is an example of a broker description in the {{ TF }} configuration:

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

      For more on the properties of the `yandex_iot_core_broker` resource, see [this provider guide]({{ tf-provider-resources-link }}/iot_core_broker).
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

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can check broker certificates using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot broker certificate list --broker-name <broker_name>
      ```

- API {#api}

  To delete a broker certificate, use the [deleteCertificate](../../broker/api-ref/Broker/deleteCertificate.md) REST API method for the [Broker](../../broker/api-ref/Broker/index.md) resource or the [BrokerService/DeleteCertificate](../../broker/api-ref/grpc/Broker/deleteCertificate.md) gRPC API call.

{% endlist %}
