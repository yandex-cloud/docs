You can save a [certificate](../../certificate-manager/concepts/index.md) chain and a private key to use on your own, e.g., when configuring a web server on a [VM](../../compute/concepts/vm.md).

To get the contents of a certificate:

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where the certificate is located.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
    1. Next to the certificate, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.certificate-manager.overview.certificate_content_export }}**.

       You can only export certificates with the `Issued` status.
    1. Select one of the export options. The `certificate.pem` file will contain the following data in Base64 encoded text format:
       * **{{ ui-key.yacloud.certificate-manager.overview.certificate_content_select_full }}**: Certificate chain (root and target certificate) and private key with standard framing:
          ```text
          -----BEGIN CERTIFICATE-----
          MIIE5zCCA8+gAwI...
          -----END CERTIFICATE-----
          -----BEGIN CERTIFICATE-----
          MIIFFjCCAv6gAwIBAg...
          -----END CERTIFICATE-----
          -----BEGIN PRIVATE KEY-----
          MIIEvgIBADANBgk...
          -----END PRIVATE KEY-----
          ```

       * **{{ ui-key.yacloud.certificate-manager.overview.certificate_content_select_no_private_key }}**: Certificate chain (root and target certificate):
         ```text
          -----BEGIN CERTIFICATE-----
          MIIE5zCCA8+gAwI...
          -----END CERTIFICATE-----
          -----BEGIN CERTIFICATE-----
          MIIFFjCCAv6gAwIBAg...
          -----END CERTIFICATE-----
          ```

       * **{{ ui-key.yacloud.certificate-manager.overview.certificate_content_select_leaf_only }}**:
           ```text
          -----BEGIN CERTIFICATE-----
          MIIFFjCCAv6gAwIBAg...
          -----END CERTIFICATE-----`
          ```
       * **{{ ui-key.yacloud.certificate-manager.overview.certificate_content_select_private_key_only }}**:
          ```text
          -----BEGIN PRIVATE KEY-----
          MIIEvgIBADANBgk...
          -----END PRIVATE KEY-----`
          ```

    1. Click **{{ ui-key.yacloud.certificate-manager.overview.certificate_content_download }}**.

- CLI {#cli}

  The command will display a certificate chain and a private key and save their contents to the `--chain` and `--key` files, respectively.
  * `--id`: Certificate ID; make sure you set either the `--id` or `--name` flag.
  * `--name`: Certificate name; make sure you set either the `--id` or `--name` flag.
  * `--chain`: (Optional) File to save the certificate chain to in PEM format.
  * `--key`: (Optional) File to save the private key to, in PEM format.

  ```bash
  yc certificate-manager certificate content \
    --id fpqcsmn76v82******** \
    --chain certificate_full_chain.pem \
    --key private_key.pem
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To get the contents of a custom certificate using {{ TF }}:
  1. In the {{ TF }} configuration file, describe the parameters of the resources you want to create:

     
     ```hcl
     data "yandex_cm_certificate_content" "cert_by_id" {
       certificate_id = "<certificate_ID>"
     }

     output "certificate_chain" {
       value = data.yandex_cm_certificate_content.cert_by_id.certificates
     }

     output "certificate_key" {
       value     = data.yandex_cm_certificate_content.cert_by_id.private_key
       sensitive = true
     }
     ```


     Where:
     * `data "yandex_cm_certificate_content"`: Description of the data source for the certificate contents:
       * `certificate_id`: Certificate ID.
     * `output` sections: `certificate_chain` output variables with a certificate chain and a `certificate_key` private key:
       * `value`: Returned value.
       * `sensitive`: Label data as sensitive.

     For more information about the `yandex_cm_certificate_content` data source parameters, see the [provider documentation]({{ tf-provider-datasources-link }}/datasource_cm_certificate_content).
  1. Create resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. To check the results, run these commands:
     * Get a certificate chain:

       ```bash
       terraform output certificate_chain
       ```

     * Get the private key value:

       ```bash
       terraform output -raw certificate_key
       ```

- API {#api}

  To get the certificate contents, use the [get](../../certificate-manager/api-ref/CertificateContent/get.md) REST API method for the [CertificateContent](../../certificate-manager/api-ref/CertificateContent/) resource or the [CertificateContentService/Get](../../certificate-manager/api-ref/grpc/certificate_content_service.md#Get) gRPC API call.

{% endlist %}

{% note info %}

To view the certificate contents, assign the `certificate-manager.certificates.downloader` [role](../../iam/concepts/access-control/roles.md) to the service account.

{% endnote %}