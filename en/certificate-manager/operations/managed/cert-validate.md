# Checking domain rights

To check rights for domains:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the certificate was added to.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
   1. Select the certificate to check from the list and click it.
   1. In the window that opens, you can find the details you need to pass the domain rights check under **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}**. For more information, see [{#T}](../../concepts/challenges.md).
   1. When the domain rights check is passed, the domain check status under **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}** will change to `Valid`.
   1. After the rights check status for all your domains changes to `Valid`, the certificate is issued and its status becomes `Issued`.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the command:

      ```bash
      yc certificate-manager certificate get --help
      ```

   1. Run the following command:

      ```bash
      yc certificate-manager certificate get \
        --id fpq6gvvm6piu******** \
        --full
      ```

      Where:

      - `--id`: Certificate ID.
      - `--full`: Show a list of active checks for domain rights.

      Result:

      ```bash
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
          url: http://example.com/.well-known/acme-challenge/3LiH-nrTC7GdMbRgVqttEvdTODeNeaD0TtXteWgtAH8
          content: 3LiH-nrTC7GdMbRgVqttEvdTODeNeaD0TtXteWgtAH8.ZHCju15sJiKBwT8G5FTl7UtfmJWp1gKNYYPLcVtVL44
      ```

   1. The information required for passing the rights check for a domain can be found under `http_challenge`. For more information, see [{#T}](../../concepts/challenges.md).

   1. When the rights check for a domain is passed, the domain check status changes to `Valid`:

      ```bash
      yc certificate-manager certificate get --id fpq6gvvm6piu******** --full
      ...
      domains:
      - example.com
      status: VALID
      ...
      ```

   1. After the rights check status for all your domains changes to `Valid`, the certificate is issued and its status becomes `Issued`:

      ```bash
      yc certificate-manager certificate get --id fpq6gvvm6piu******** --full
      ...
      domains:
      - example.com
      status: ISSUED
      ...
      ```

- {{ TF }}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   With {{ TF }}, you can create a DNS record required to pass a check for domain rights. To do this:

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
        ttl     = <record_lifetime_in_seconds>
      }

      data "yandex_cm_certificate" "example" {
        depends_on      = [yandex_dns_recordset.validation-record]
        certificate_id  = yandex_cm_certificate.le-certificate.id
        wait_validation = true
      }

      # Use data.yandex_cm_certificate.example.id to get validated certificate

      output "cert-id" {
        description = "Certificate ID"
        value       = data.yandex_cm_certificate.example.id
      }
      ```

      Where:

      * The `yandex_cm_certificate` resource parameters are as follows:

         * `domains`: Domain to create a certificate for.
         * `challenge_type`: Domain owner verification method. The possible values include:

            * `DNS_CNAME`: Create a DNS record in CNAME format with the specified value. This method is recommended for automatic certificate renewal.
            * `DNS_TXT`: Create a DNS record in TXT format with the specified value.

      * The `yandex_dns_recordset` resource parameters are as follows:

         * `zone_id`: ID of the DNS zone where the record for owner verification will be located.
         * `name`: Record name.
         * `type`: DNS record type.
         * `data`: Record value.
         * `ttl`: Record time to live (TTL) in seconds before updating the record value.

      * The `yandex_dns_recordset` data source parameters are as follows:
         * `depends_on`: Indicates dependence on another {{ TF }} resource.
         * `certificate_id`: Certificate ID.
         * `wait_validation`: Certificate validation wait flag. If `true`, the operation will not be completed while the certificate status is `VALIDATING`. The default value is `false`.

      For more information about the resource parameters, see the [{{ TF }} provider documentation]({{ tf-provider-link }}).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

   This will create a certificate and DNS record in the specified folder. You can check the new certificate and its configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

   ```bash
   yc certificate-manager certificate get <certificate_name> --full
   ```

- API

   To get the information required to pass the rights check for a domain, use the [get](../../api-ref/Certificate/get.md) REST API method for the [Certificate](../../api-ref/Certificate/) resource or the [CertificateService/Get](../../api-ref/grpc/certificate_service.md#Get) gRPC API call with the `view=FULL` flag.

{% endlist %}

{% note info %}

{% include [checking-domain-rights-cname](../../../_includes/certificate-manager/checking-domain-rights-cname.md) %}

{% endnote %}
