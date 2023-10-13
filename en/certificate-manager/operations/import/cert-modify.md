# Editing a custom certificate

After adding a [custom certificate](../../concepts/imported-certificate.md) to {{ certificate-manager-name }}, you can change its name or description. To edit a certificate:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the certificate was added to.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
   1. Select the certificate you need to change from the list.
   1. In the window that opens, click **{{ ui-key.yacloud.certificate-manager.overview.action_edit-meta }}**.
   1. Change the name or description of the certificate.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the command:

      ```bash
      yc certificate-manager certificate update --help
      ```

   1. View the list of certificates:

      ```bash
      yc certificate-manager certificate list
      ```

      Command result:

      ```bash
      +----------------------+--------+-------------+---------------------+----------+--------+
      |          ID          |  NAME  |   DOMAINS   |      NOT AFTER      |   TYPE   | STATUS |
      +----------------------+--------+-------------+---------------------+----------+--------+
      | fpqmg47avvim******** | mycert | example.com | 2021-09-15 08:12:57 | IMPORTED | ISSUED |
      +----------------------+--------+-------------+---------------------+----------+--------+
      ```

   1. Run this command:

      ```bash
      yc certificate-manager certificates update \
        --id fpqmg47avvim******** \
        --new-name myupdatedcert \
        --description "description of myupdatedcert"
      ```

      Where:
      * `--id`: Certificate ID.
      * `--new-name`: New name for the certificate.
      * `--description`: Certificate description.

      Command result:

      ```bash
      id: fpqmg47avvim********
      folder_id: b1g7gvsi89m3********
      created_at: "2020-09-15T06:54:44.916Z"
      ...
      issued_at: "2020-09-15T08:23:50.147Z"
      not_after: "2021-09-15T08:12:57Z"
      not_before: "2020-09-15T08:12:57Z"
      ```

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Open the {{ TF }} configuration file and change the certificate name or description:

      {% cut "Sample certificate description in the {{ TF }} configuration" %}

      ```
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

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

   You can check the certificate update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

   ```bash
   yc certificate-manager certificate get <certificate_name>
   ```

- API

   To edit a certificate, use the [update](../../api-ref/Certificate/update.md) REST API method for the [Certificate](../../api-ref/Certificate/) resource or the [CertificateService/Update](../../api-ref/grpc/certificate_service.md#Update) gRPC API call.

{% endlist %}