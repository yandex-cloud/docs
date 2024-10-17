---
title: How to check domain rights in {{ certificate-manager-full-name }}
description: This guide describes how you can check domain rights.
---

# Checking domain rights

To [check domain rights](../../concepts/challenges.md):

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you added the [certificate](../../concepts/managed-certificate.md).
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
   1. Select the certificate to check from the list and click it.
   1. In the window that opens, you can find the details you need to pass the domain rights check under **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}**.
   1. When you pass the domain rights check, the domain check status under **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}** will change to `Valid`.
   1. After the check status for all the domains changes to `Valid`, the certificate will be issued and its status will change to `Issued`.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the command:

      ```bash
      yc certificate-manager certificate get --help
      ```

   1. Run this command:

      ```bash
      yc certificate-manager certificate get \
        --id fpq6gvvm6piu******** \
        --full
      ```

      Where:

      * `--id`: [Certificate](../../concepts/managed-certificate.md) ID.
      * `--full`: Show a list of active checks for domain rights.

      Result:

      ```text
      id: fpq6gvvm6piu********
      folder_id: b1g7gvsi89m3********
      created_at: "2020-09-15T08:49:11.533771Z"
      name: mymanagedcert
      type: MANAGED
      domains:
      - example.com
      status: VALIDATING
      updated_at: "2020-09-15T08:49:11.533771Z"
      challenges:
      - domain: example.com
        type: HTTP
        created_at: "2020-09-15T08:49:11.533771Z"
        updated_at: "2020-09-15T08:51:44.991065Z"
        status: PENDING
        message: Create a file in your web server's base directory.
        http_challenge:
          url: http://example.com/.well-known/acme-challenge/3LiH-nrTC7GdMbRgVqttEvdTODeNeaD0TtX********
             content: 3LiH-nrTC7GdMbRgVqttEvdTODeNeaD0TtXteWgtAH8.ZHCju15sJiKBwT8G5FTl7UtfmJWp1gKNYYP********
      ```

   1. The information required for passing the rights check for a domain can be found under `http_challenge`.
   1. When you pass the domain rights check, the check status will change to `Valid`:

      ```bash
      yc certificate-manager certificate get \
        --id fpq6gvvm6piu******** \
        --full
      ```

      Result:

      ```text
      ...
      domains:
      - example.com
      status: VALID
      ...
      ```

   1. After the check status for all the domains changes to `Valid`, the certificate will be issued and its status will change to `Issued`:

      ```bash
      yc certificate-manager certificate get \
        --id fpq6gvvm6piu******** \
        --full
      ```

      Result:

      ```text
      ...
      domains:
      - example.com
      status: ISSUED
      ...
      ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   With {{ TF }}, you can create a [DNS record](../../../dns/concepts/resource-record.md) required to check your rights to a domain. To do this:
   1. In the {{ TF }} configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_cm_certificate" "le-certificate" {
        name    = "<certificate_name>"
        domains = ["<domain>"]

        managed {
        challenge_type = "DNS_CNAME"
        }
      }

      resource "yandex_dns_recordset" "validation-record" {
        zone_id = "<zone_ID>"
        name    = yandex_cm_certificate.le-certificate.challenges[0].dns_name
        type    = yandex_cm_certificate.le-certificate.challenges[0].dns_type
        data    = [yandex_cm_certificate.le-certificate.challenges[0].dns_value]
        ttl     = <record_time_to_live_in_seconds>
      }

      data "yandex_cm_certificate" "example" {
        depends_on      = [yandex_dns_recordset.validation-record]
        certificate_id  = yandex_cm_certificate.le-certificate.id
        wait_validation = true
      }

      # Use data.yandex_cm_certificate.example.id to get a valid certificate.

      output "cert-id" {
        description = "Certificate ID"
        value       = data.yandex_cm_certificate.example.id
      }
      ```

      Where:

      * The `yandex_cm_certificate` resource parameters are as follows:

         * `domains`: Domain to create a certificate for.
         * `challenge_type`: Domain owner verification method. The possible values include:
            * `DNS_CNAME`: Create a DNS record in [CNAME](../../../dns/concepts/resource-record.md#cname-cname) format with the specified value. This method is recommended for automatic certificate renewal.
            * `DNS_TXT`: Create a DNS record in [TXT](../../../dns/concepts/resource-record.md#txt) format with the specified value.
      * The `yandex_dns_recordset` resource parameters are as follows:

         * `zone_id`: ID of the DNS zone where the record for owner verification will be located.
         * `name`: Record name.
         * `type`: DNS record type.
         * `data`: Record value.
         * `ttl`: Record time to live (TTL) in seconds before updating the record value.

      * The `yandex_dns_recordset` data source parameters are as follows:
         * `depends_on`: Indicates dependence on another {{ TF }} resource.
         * `certificate_id`: Certificate ID.
         * `wait_validation`: Certificate validation wait flag. If `true`, the operation will not complete while the certificate status is `VALIDATING`. The default value is `false`.

      For more information about the resource parameters, see the [{{ TF }} provider documentation]({{ tf-provider-link }}).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

   This will create a certificate and DNS record in the specified [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder). You can check the new certificate and its configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

   ```bash
   yc certificate-manager certificate get <certificate_name> --full
   ```

- API {#api}

   To get the information required to pass the rights check for a domain, use the [get](../../api-ref/Certificate/get.md) REST API method for the [Certificate](../../api-ref/Certificate/) resource or the [CertificateService/Get](../../api-ref/grpc/Certificate/get.md) gRPC API call with the `view=FULL` flag.

{% endlist %}

{% note info %}

{% include [checking-domain-rights-cname](../../../_includes/certificate-manager/checking-domain-rights-cname.md) %}

{% endnote %}