---
title: How to update a Let's Encrypt certificate in {{ certificate-manager-full-name }}
description: Follow this guide to update a Let's Encrypt certificate.
---

# Editing a Let's Encrypt certificate

After issuing a [Let's Encrypt certificate](../../concepts/managed-certificate.md) and adding it to {{ certificate-manager-name }}, you can change its name or description. To edit a certificate:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the certificate was added to.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
  1. Select the certificate you need to change from the list.
  1. In the window that opens, click **{{ ui-key.yacloud.certificate-manager.overview.action_edit-meta }}**.
  1. Change the name or description of the certificate.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

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

     Result:

     ```text
     +----------------------+---------------+-------------+-----------+---------+------------+
     |          ID          |     NAME      |   DOMAINS   | NOT AFTER |  TYPE   |   STATUS   |
     +----------------------+---------------+-------------+-----------+---------+------------+
     | fpq6gvvm6piu******** | mymanagedcert | example.com |           | MANAGED | VALIDATING |
     +----------------------+---------------+-------------+-----------+---------+------------+
     ```

  1. Run this command:

     ```bash
     yc certificate-manager certificates update \
       --id fpq6gvvm6piu******** \
       --new-name myupdatedmanagedcert \
       --description "description of myupdatedmanagedcert"
     ```

     Where:
     * `--id`: Certificate ID.
     * `--new-name`: New name for the certificate.
     * `--description`: Certificate description.

     Result:

     ```text
     id: fpq6gvvm6piu********
     folder_id: b1g7gvsi89m3********
     created_at: "2020-09-15T08:49:11.533Z"
     ...
     - example.com
     status: VALIDATING
     updated_at: "2020-09-15T09:10:06.981875Z"
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and edit the fragment with the certificate description:

     {% cut "Sample certificate description" %}

     ```hcl
     ...
     resource "yandex_cm_certificate" "le-certificate" {
       name        = "managed-certificate-for-dns"
       description = "this is a certificate for tls"
       domains     = ["my-domain.ru"]

       managed {
       challenge_type = "DNS_CNAME"
       }
     }
     ...
     ```

     {% endcut %}

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the certificate's update and configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

  ```bash
  yc certificate-manager certificate get <certificate_name>
  ```

- API {#api}

  To edit a certificate, use the [update](../../api-ref/Certificate/update.md) REST API method for the [Certificate](../../api-ref/Certificate/) resource or the [CertificateService/Update](../../api-ref/grpc/Certificate/update.md) gRPC API call.

{% endlist %}