# Adding a custom certificate

As an example, let's look at how to add a custom certificate using a self-signed certificate. You can see the custom certificate requirements on the [{#T}](../../concepts/imported-certificate.md) page.

## Creating a self-signed certificate file {#create-file}

To create a self-signed certificate using the `OpenSSL` library, run the command below:

{% list tabs group=programming_language %}

- Bash {#bash}

   ```bash
   openssl req -x509 -newkey rsa:4096 -nodes \
     -keyout key.pem \
     -out cert.pem \
     -days 365 \
     -subj '/CN=example.com'
   ```

- PowerShell {#powershell}

   ```PowerShell
   openssl req -x509 -newkey rsa:4096 -nodes `
     -keyout key.pem `
     -out cert.pem `
     -days 365 `
     -subj '/CN=example.com'
   ```

{% endlist %}

Where:
* `-x509`: Command will output a certificate file.
* `-newkey`: New private key file will be created.
* `rsa:4096`: Algorithm and key length.
* `-nodes`: Do not encrypt the private key file.
* `-keyout`: Name of the file the private key is saved to.
* `-out`: Certificate file name.
* `-days`: Certificate validity period.
* `-subj`: Certificate owner's Common Name value.

The `req` command launched with the above parameters will issue a self-signed certificate and generate the associated private key.

## Adding a self-signed custom certificate {#create-certificate}

To add a custom certificate to {{ certificate-manager-name }}:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to add a custom certificate.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
   1. Click **{{ ui-key.yacloud.certificate-manager.button_add }}**.
   1. In the menu that opens, select **{{ ui-key.yacloud.certificate-manager.action_import }}**.
   1. In the window that opens, in the **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** field, enter a custom certificate name.
   1. (Optional) Enter your custom certificate description in the **Description** field.
   1. In the **{{ ui-key.yacloud.certificate-manager.import.field_certificate }}** field, click **{{ ui-key.yacloud.certificate-manager.import.button_add-certificate }}**.
      1. Choose how to add a certificate: `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}`.
      1. Click **Attach file**.
         1. In the window that opens, select the `cert.pem` self-signed certificate file.
      1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
   1. In the **{{ ui-key.yacloud.certificate-manager.import.field_privateKey }}** field, click **{{ ui-key.yacloud.certificate-manager.import.button_add-privateKey }}**.
      1. Choose how to add a certificate: `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}`.
      1. Click **Attach file**.
         1. In the window that opens, select the `key.pem` private key file.
      1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the command:

      ```bash
      yc certificate-manager certificate create --help
      ```

   1. Run this command:

      ```bash
      yc certificate-manager certificate create \
        --name mycert \
        --chain mycert.pem \
        --key mykey.pem
      ```

      Where:
      * `--name`: Certificate name.
      * `--chain`: Path to the certificate chain file.
      * `--key`: Path to the file of the certificate private key.

      Result:

      ```text
      id: fpqmg47avvim********
      folder_id: b1g7gvsi89m3********
      created_at: "2020-09-15T06:54:44.916325Z"
      ...
      issued_at: "2020-09-15T06:54:44.916325Z"
      not_after: "2021-09-15T06:48:26Z"
      not_before: "2020-09-15T06:48:26Z"
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_cm_certificate" "user-certificate" {
        name    = "<certificate_name>"

        self_managed {
          certificate = <<-EOT
                        -----BEGIN CERTIFICATE-----
                        <certificate_contents>
                        -----END CERTIFICATE-----
                        EOT
          private_key = <<-EOT
                        -----BEGIN PRIVATE KEY-----
                        <certificate_private_key_contents>
                        -----END PRIVATE KEY-----
                        EOT
        }
      }
      ```

      Where:

      * `name`: Certificate name.
      * `certificate`: Contents of the [certificate](../../concepts/imported-certificate.md) file.
      * `private_key`: Contents of the private key file.

      For more information about the `yandex_cm_certificate` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/cm_certificate).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

   This will add the certificate to the specified folder. You can check the new certificate and its configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

   ```bash
   yc certificate-manager certificate get <certificate_name>
   ```

- API {#api}

   To add a certificate, use the [create](../../api-ref/Certificate/create.md) REST API method for the [Certificate](../../api-ref/Certificate/) resource or the [CertificateService/Create](../../api-ref/grpc/certificate_service.md#Create) gRPC API call.

{% endlist %}

The new certificate with the `Issued` status will appear in the certificate list.

## Storing a certificate's public part in {{ lockbox-full-name }} {#create-lockbox}

You can store a {{ certificate-manager-name }} user certificate's public part in [{{ lockbox-name }}](../../../lockbox/). To add a certificate:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the parameters of the resources you want to create:

      ```hcl
        resource "yandex_cm_certificate" "example-lockbox" {
        name    = "<secret_name>"

      self_managed {
          certificate = <<-EOT
                        -----BEGIN CERTIFICATE-----
                        <certificate_contents>
                        -----END CERTIFICATE-----
                        EOT
          private_key_lockbox_secret {
            id  = "<secret_ID>"
            key = "<secret_key>"
          }
        }
      }
      ```

      Where:

      * `name`: {{ lockbox-name }} [secret](../../../lockbox/concepts/secret.md) name.
      * `certificate`: Contents of the certificate file.
      * `id`: {{ lockbox-name }} secret ID.
      * `key`: {{ lockbox-name }} secret key whose value is contained in the certificate private key.

      For more information about the `yandex_cm_certificate` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/cm_certificate).
   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

   The certificate will then be added to the specified [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder). You can check the new certificate and its configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

   ```bash
   yc certificate-manager certificate get <certificate_name>
   ```

{% endlist %}

The new certificate with the `Issued` status will appear in the certificate list.