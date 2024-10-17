---
title: How to delete custom certificates in {{ certificate-manager-full-name }}
description: Follow this guide to delete a custom certificate.
---

# Deleting a custom certificate

To delete a [custom certificate](../../concepts/imported-certificate.md):

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the certificate was added to.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
   1. Find the certificate to be deleted in the list.
   1. Click ![image](../../../_assets/console-icons/ellipsis.svg).
   1. In the menu that opens, click **{{ ui-key.yacloud.common.delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the command:

      ```bash
      yc certificate-manager certificates delete --help
      ```

   1. View the list of certificates:

      ```bash
      yc certificate-manager certificate list
      ```

      Result:

      ```text
      +----------------------+---------------+-------------+---------------------+----------+--------+
      |          ID          |     NAME      |   DOMAINS   |      NOT AFTER      |   TYPE   | STATUS |
      +----------------------+---------------+-------------+---------------------+----------+--------+
      | fpqmg47avvim******** | myupdatedcert | example.com | 2021-09-15 08:12:57 | IMPORTED | ISSUED |
      +----------------------+---------------+-------------+---------------------+----------+--------+
      ```

   1. Run this command:

      ```bash
      yc certificate-manager certificates delete \
        --id fpqmg47avvim********
      ```

      Where `--id`: Certificate ID.

      Result:

      ```text
      id: fpqmg47avvim********
      folder_id: b1g7gvsi89m3********
      created_at: "2020-09-15T06:54:44.916Z"
      ...
      issued_at: "2020-09-15T08:23:50.147Z"
      not_after: "2021-09-15T08:12:57Z"
      not_before: "2020-09-15T08:12:57Z"
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. Open the {{ TF }} configuration file and delete the fragment with the certificate description:

      {% cut "Sample certificate description in the {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_cm_certificate" "imported-certificate" {
        name    = "my-certificate"

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

   You can check the certificate deletion using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

   ```bash
   yc certificate-manager certificate list
   ```

- API {#api}

   To delete a certificate, use the [delete](../../api-ref/Certificate/delete.md) REST API method for the [Certificate](../../api-ref/Certificate/) resource or the [CertificateService/Delete](../../api-ref/grpc/Certificate/delete.md) gRPC API call.

{% endlist %}