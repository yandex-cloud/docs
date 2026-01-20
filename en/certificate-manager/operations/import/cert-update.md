# Renewing a custom certificate

{{ certificate-manager-name }} does not manage [custom certificates](../../concepts/imported-certificate.md). To make your certificate continuously available to your resources, be sure to renew it on time.

To get a new version of a user certificate:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the certificate was added to.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
  1. In the list, select the certificate you need to update.
  1. In the window that opens, click **{{ ui-key.yacloud.certificate-manager.overview.action_reimport }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.certificate-manager.import.button_add-certificate }}** in the **{{ ui-key.yacloud.certificate-manager.import.field_certificate }}** field.
     1. Choose how to add it: `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` or `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}`.
     1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
  1. In the **{{ ui-key.yacloud.certificate-manager.import.field_chain }}** field, click **{{ ui-key.yacloud.certificate-manager.import.button_add-chain }}**.
     1. Choose how to add it: `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` or `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}`.
     1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
  1. In the **{{ ui-key.yacloud.certificate-manager.import.field_privateKey }}** field, click **{{ ui-key.yacloud.certificate-manager.import.button_add-privateKey }}**.
     1. Choose how to add it: `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` or `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}`.
     1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
  1. Click **{{ ui-key.yacloud.common.button_update }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the command description:

     ```bash
     yc certificate-manager certificate update --help
     ```

  1. View the list of certificates:

     ```bash
     yc certificate-manager certificate list
     ```

     Result:

     ```text
     +----------------------+--------+-------------+---------------------+----------+--------+
     |          ID          |  NAME  |   DOMAINS   |      NOT AFTER      |   TYPE   | STATUS |
     +----------------------+--------+-------------+---------------------+----------+--------+
     | fpqmg47avvim******** | mycert | example.com | 2021-09-15 06:48:26 | IMPORTED | ISSUED |
     +----------------------+--------+-------------+---------------------+----------+--------+
     ```

  1. Run this command:

     ```bash
     yc certificate-manager certificate update \
       --id fpqmg47avvim******** \
       --chain myupdatedcert.pem \
       --key myupdatedkey.pem
     ```

     Where:
     * `--id`: ID of the certificate you need to update.
     * `--chain`: Path to the new certificate chain file.
     * `--key`: Path to the certificate's new private key file.

     Result:

     ```text
     id: fpqmg47avvim********
     folder_id: b1g7gvsi89m3********
     created_at: "2020-09-15T06:54:44.916Z"
     ...
     issued_at: "2020-09-15T08:23:50.147668Z"
     not_after: "2021-09-15T08:12:57Z"
     not_before: "2020-09-15T08:12:57Z"
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and edit the `certificate` and `private_key` certificate parameters:

     {% cut "Sample certificate description in the {{ TF }} configuration" %}

     ```hcl
     ...
     resource "yandex_cm_certificate" "imported-certificate" {
       name        = "my-certificate"
       description = "this is a test certificate"

       self_managed {
         certificate = <<-EOT
                       -----BEGIN CERTIFICATE-----
                       MIIF...
                       -----END CERTIFICATE-----
                       EOT
         private_key = <<-EOT
                       -----BEGIN PRIVATE KEY-----
                       MIIJ...
                       -----END PRIVATE KEY-----
                       EOT
       }
     }
     ...
     ```

     {% endcut %}

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the certificate update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

  ```bash
  yc certificate-manager certificate get <certificate_name>
  ```

- API {#api}

  To renew a certificate, use the [update](../../api-ref/Certificate/update.md) REST API method for the [Certificate](../../api-ref/Certificate/) resource or the [CertificateService/Update](../../api-ref/grpc/Certificate/update.md) gRPC API call.

{% endlist %}