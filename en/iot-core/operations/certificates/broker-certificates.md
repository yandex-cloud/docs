# Managing broker certificates

{% include [note-pp](../../../_includes/iot-core/note-pp.md) %}

To start exchanging messages between broker clients, you must [log in](../../concepts/authorization.md). This section describes how to manage broker certificates for the relevant authorization method.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

- [Viewing a list of broker certificates](broker-certificates.md#list-cert)
- [Adding a certificate to a broker](broker-certificates.md#add-cert)
- [Deleting a broker certificate](broker-certificates.md#delete-cert)

To access a [broker](../../concepts/index.md#broker), use its unique ID or name. For information on retrieving the unique broker ID or name, see [{#T}](../broker/broker-list.md).

## Getting a list of broker certificates {#broker-certificates-list}

{% include [broker-certificates-list](../../../_includes/iot-core/broker-certificates-list.md) %}

## Adding a certificate {#add-cert}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to add the broker certificate to.
   1. Select **{{ iot-short-name }}**.
   1. Select the broker.
   1. On the **Overview** page, go to the **Certificates** section and click **Add certificate**.

      - To add a file:

         1. Choose the **File** method.
         1. Click **Select file**.
         1. Select the certificate file on your computer and click **Open**.
         1. Click **Add**.

      - To add text:

         1. Choose the **Text** method.
         1. Insert the certificate body in the **Contents** field.
         1. Click **Add**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Add a certificate to the broker:

   ```
   yc iot broker certificate add \
     --broker-name my-broker \
     --certificate-file broker-cert.pem
   ```

   Where:
   * `--broker-name`: Broker name.
   * `--certificate-file`: Path to the public part of the certificate.

   Result:
   ```
   broker_id: b91ki3851h**********
   fingerprint: 589ce1605...
   certificate_data: |
     -----BEGIN CERTIFICATE-----
     MIIE/jCCAuagAw...
     -----END CERTIFICATE-----
   created_at: "2019-05-29T16:40:48.230Z"
   ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To add a certificate to a broker created using {{ TF }}:

   1. In the configuration file, describe the parameters of resources that you want to create:

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

      For more information about the `yandex_iot_core_broker` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iot_core_broker).
   1. In the command line, change to the folder where you edited the configuration file.
   1. Make sure the configuration file is correct using the command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      You can verify broker certificates in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot broker certificate list --broker-name <broker_name>
      ```

- API

   You can add a certificate to a broker using the API [addCertificate](../../broker/api-ref/Broker/addCertificate.md) method.

{% endlist %}

## Deleting a certificate {#delete-cert}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to delete the broker certificate from.
   1. Select **{{ iot-short-name }}**.
   1. Select the broker.
   1. On the **Overview** page, go to the **Certificates** section.
   1. In the row with the certificate you need, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Delete** from the drop-down list.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Delete a broker certificate:

      ```
      yc iot broker certificate delete --broker-name my-broker --fingerprint 0f...
      ```

   1. Make sure the certificate was deleted:

      ```
      yc iot broker certificate list --broker-name my-broker
      ```

      Result:

      ```
      +-------------+------------+
      | FINGERPRINT | CREATED AT |
      +-------------+------------+
      +-------------+------------+
      ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

      For more information about the `yandex_iot_core_broker` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iot_core_broker).
   1. In the command line, change to the folder where you edited the configuration file.
   1. Make sure the configuration file is correct using the command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      You can verify broker certificates in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot broker certificate list --broker-name <broker_name>
      ```

- API

   You can delete a broker certificate using the API [deleteCertificate](../../broker/api-ref/Broker/deleteCertificate.md) method.

{% endlist %}