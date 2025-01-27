# Adding a custom certificate

As an example, let's look at how to add a custom certificate using a self-signed certificate. You can look up the custom certificate requirements on the [{#T}](../../concepts/imported-certificate.md) page.

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
* `-x509`: The command will output a certificate file.
* `-newkey`: A new private key file will be created.
* `rsa:4096`: Algorithm and key length.
* `-nodes`: Do not encrypt the private key file.
* `-keyout`: Name of the file the private key is saved to.
* `-out`: Certificate file name.
* `-days`: Certificate validity period.
* `-subj`: Certificate owner's Common Name value.

Executed with the above parameters, the `req` command will issue a self-signed certificate and generate the associated private key.

## Adding a self-signed custom certificate {#create-certificate}

To add a custom certificate to {{ certificate-manager-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to add a custom certificate to.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
  1. Click **{{ ui-key.yacloud.certificate-manager.button_empty-action }}**.
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
     * `--name`: Certificate name
     * `--chain`: Path to the certificate chain file.
     * `--key`: Path to the certificate private key file.

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

  1. In the configuration file, define the parameters of the resources you want to create:

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
                       <contents_of_certificate_private_key>
                       -----END PRIVATE KEY-----
                       EOT
       }
     }
     ```

     Where:
     * `name`: Certificate name
     * `certificate`: [Certificate](../../concepts/imported-certificate.md) file contents.
     * `private_key`: Private key file contents.

     For more information about the `yandex_cm_certificate` resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/cm_certificate).
  1. Create resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  The certificate will then be added to the specified folder. You can check the new certificate and its settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

    ```bash
     yc certificate-manager certificate get <certificate_name>
    ```

- API {#api}

  To add a certificate, use the [create](../../api-ref/Certificate/create.md) REST API method for the [Certificate](../../api-ref/Certificate/) resource or the [CertificateService/Create](../../api-ref/grpc/Certificate/create.md) gRPC API call.

{% endlist %}

A new certificate with the `Issued` status will appear in the certificate list.

## Storing a certificate's private key in {{ lockbox-full-name }} {#create-lockbox}

To avoid storing a private key of the user certificate as plain text in the {{ TF }} configuration file, write it to [{{ lockbox-name }}](../../../lockbox/):

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. [Create a secret](../../../lockbox/operations/secret-create.md) and write the private key to it.
  1. In the configuration file, define the parameters of the resources you want to create:

     ```hcl
     resource "yandex_cm_certificate" "example-lockbox" {
       name = "<secret_name>"

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
     * `certificate`: Certificate file contents.
     * `id`: ID of the {{ lockbox-name }} secret the private key is located in.
     * `key`: Key of the {{ lockbox-name }} secret the private key is located in.

     For more information about the `yandex_cm_certificate` resource parameters, see the [relevant provider documentation]({{ tf-provider-resources-link }}/cm_certificate).
  1. Create resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  The certificate will then be added to the specified [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder). You can check the new certificate and its settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

  ```bash
  yc certificate-manager certificate get <certificate_name>
  ```

{% endlist %}

A new certificate with the `Issued` status will appear in the certificate list.