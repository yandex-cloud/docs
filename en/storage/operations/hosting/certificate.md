# Configuring HTTPS

If you are using a bucket to [host a static website](../../concepts/hosting.md), then to access the website via HTTPS, you will need to upload your own security certificate and a corresponding secret key.

{{ objstorage-name }} only supports [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded certificates.

{% note info %}

Access to the bucket over HTTPS is granted within thirty minutes of uploading the certificate.

{% include [redirect-https](../../../_includes/storage/redirect-https.md) %}

{% endnote %}

## Select a certificate from {{ certificate-manager-name }} {#cert-manager}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ objstorage-name }}**.
   1. Click the name of the bucket you need.
   1. Go to the **{{ ui-key.yacloud.storage.bucket.switch_https }}** tab.
   1. In the right-hand panel that opens, click **{{ ui-key.yacloud.storage.bucket.https.button_empty-action }}**.
   1. In the **{{ ui-key.yacloud.storage.bucket.https.field_source }}** field, select **{{ ui-key.yacloud.storage.bucket.https.value_method-certificate-manager }}**.
   1. In the **{{ ui-key.yacloud.storage.bucket.https.field_certificate }}** field, select the certificate from the list that opens.

      {% note info %}

      If you do not have a certificate in {{ certificate-manager-full-name }}, click **Go to {{ certificate-manager-name }}** and follow the [guide](../../../certificate-manager/quickstart/index.md) on how to create your first certificate.

      {% endnote %}

   1. Click **{{ ui-key.yacloud.storage.bucket.https.button_save }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to edit a bucket ACL:

     ```bash
     yc storage bucket update --help
     ```

  1. Run the following command:

     ```bash
     yc storage bucket set-https --name <bucket_name> --certificate-id <certificate_ID>
     ```

     Where:
     * `--name`: Name of the bucket to configure HTTPS for.
     * `--certificate-id`: Certificate ID in {{ certificate-manager-name }}.

     Result:

     ```text
     source_type: SOURCE_TYPE_MANAGED_BY_CERTIFICATE_MANAGER
     certificate_id: fpqe2g0hfr0e********
     ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   
   {% include [terraform-install](../../../_includes/terraform-install.md) %}


   To select a certificate from {{ certificate-manager-name }}:

   1. Open the {{ TF }} configuration file and add the `https` section to the bucket description:

      ```hcl
      ...
      resource "yandex_storage_bucket" "b" {
        bucket = "my-policy-bucket"

        https {
          certificate_id = "<certificate_ID>"
        }
      }
      ...
      ```

      Where:
      * `certificate_id` is the ID of the certificate in {{ certificate-manager-name }} to be used for the bucket.

      For more information about the `yandex_storage_bucket` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/storage_bucket#bucket-https-certificate).

   1. Check the configuration using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can use the [management console]({{ link-console-main }}) to check the selected certificate.

- API

   To select a certificate from {{ certificate-manager-name }}, use the [setHTTPSConfig](../../api-ref/Bucket/setHTTPSConfig.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource or the [BucketService/SetHTTPSConfig](../../api-ref/grpc/bucket_service.md#SetHTTPSConfig) gRPC API call.

{% endlist %}

## Upload your own security certificate {#own}

To [upload](../../../certificate-manager/operations/import/cert-create.md) a custom certificate, use {{ certificate-manager-name }}.

When you are uploading a chain of certificates, it should start with the domain certificate and end with the root certificate. You can create a chain file using the following command:

```bash
cat domain.pem intermediate.pem rootca.pem > bundle.pem
```

Where `domain.pem` is the domain certificate, `intermediate.pem` is the intermediate certificate, `rootca.pem` is the root certificate, and `bundle.pem` is the resulting chain.

To upload a certificate:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. Click the name of the bucket you need.
   1. Go to the **{{ ui-key.yacloud.storage.bucket.switch_https }}** tab.
   1. In the right-hand panel that opens, click **{{ ui-key.yacloud.storage.bucket.https.button_action-configure }}**.
   1. In the **{{ ui-key.yacloud.storage.bucket.https.field_source }}** field, select `{{ ui-key.yacloud.storage.bucket.https.value_method-custom }}`.
   1. Add the certificate and secret key.
   1. Click **{{ ui-key.yacloud.storage.bucket.https.button_save }}**.

- API

   To upload your own security certificate, use the [setHTTPSConfig](../../api-ref/Bucket/setHTTPSConfig.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource or the [BucketService/SetHTTPSConfig](../../api-ref/grpc/bucket_service.md#SetHTTPSConfig) gRPC API call.

{% endlist %}

{% note info %}

{% include [public-link](../../../_includes/storage/public-link.md) %}

{% endnote %}