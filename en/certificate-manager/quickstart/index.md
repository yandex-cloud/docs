# Getting started with {{ certificate-manager-name }}

By following this guide, you will add your first [Let's Encrypt certificate](../concepts/managed-certificate.md) to {{ certificate-manager-name }} and use it to [set up HTTPS access](../../storage/operations/hosting/certificate.md) to a static website hosted in {{ objstorage-full-name }}.

## Getting started {#before-you-begin}

To get started with {{ certificate-manager-name }}, you need:

1. A folder in {{ yandex-cloud }}. If you don't have a folder, create one:

   {% include [create-folder](../../_includes/create-folder.md) %}

1. A third-level (or higher) domain that the Let's Encrypt certificate is issued for.

   {% note info %}

   To pass the domain rights check, you must have control of the domain.

   {% endnote %}

1. A public bucket in Object Storage with exactly the same name as the domain. If that bucket doesn't exist, create it:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [bucket](../../storage/concepts/bucket.md).
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
      1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
      1. Enter exactly the same name for the bucket as the domain name.
      1. Select the `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}` [access](../../storage/concepts/bucket.md#bucket-access) type.
      1. Select the default [storage class](../../storage/concepts/storage-class.md).
      1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}** to complete the operation.

   {% endlist %}

1. Set up [hosting](../../storage/operations/hosting/setup.md) in your bucket:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
      1. In the **{{ ui-key.yacloud.storage.switch_buckets }}** tab, click the bucket with the same name as the domain.
      1. In the left-hand panel, select **{{ ui-key.yacloud.storage.bucket.switch_website }}**.
      1. Select **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}** and specify your website home page.
      1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}** to complete the operation.

   {% endlist %}

1. Set up an [alias](../../storage/operations/hosting/own-domain.md) for the bucket through your DNS provider or on your own DNS server.

   For instance, for the `www.example.com` domain, add the following record:

   ```
   www.example.com CNAME www.example.com.{{ s3-web-host }}
   ```
1. Install and configure the AWS CLI by following our [instructions](../../storage/tools/aws-cli.md#before-you-begin).

## Create a request for a Let's Encrypt certificate {#request-certificate}

{% list tabs %}

- Management console

   1. Go to the [management console]({{ link-console-main }}).
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
   1. Click **{{ ui-key.yacloud.certificate-manager.button_add }}**.
   1. In the menu that opens, select **{{ ui-key.yacloud.certificate-manager.action_request }}**.
   1. In the window that opens, enter a name for the certificate.
   1. (Optional) Add a description for the certificate.
   1. In the **{{ ui-key.yacloud.certificate-manager.request.field_domains }}** field, specify the domains you want to issue the certificate for.
   1. Select the [rights check type](../concepts/challenges.md) for the `{{ ui-key.yacloud.certificate-manager.request.challenge-type_label_http }}` domain.
   1. Click **{{ ui-key.yacloud.certificate-manager.request.button_request }}**.

{% endlist %}

## Passing the domain rights check {#validate}

1. Create a file for the check:
   1. Go to the [management console]({{ link-console-main }}).
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
   1. Select a certificate with the `Validating` status in the list and click it.
   1. Under **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}**:
      1. Copy the URL from the **{{ ui-key.yacloud.certificate-manager.overview.challenge_label_http-url }}** field:
         * The part of the link like `http://example.com/.well-known/acme-challenge/` is the path to host your file at.
         * The second part of the link, `rG1Mm1bJ...`, is the file name that you should use.
      1. Copy the contents of the file from the **{{ ui-key.yacloud.certificate-manager.overview.challenge_label_http-content }}** field.
1. Upload the created file to the bucket so that it resides in the `.well-known/acme-challenge` directory:

   {% list tabs %}

   - AWS CLI

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }} \
         s3 cp <file name> s3://<bucket name>/.well-known/acme-challenge/<file name>
      ```

   {% endlist %}

1. Wait until the certificate status changes to `Issued`.
1. Delete the file you created from the bucket:

   {% list tabs %}

   - AWS CLI

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }} \
         s3 rm s3://<bucket name>/.well-known/acme-challenge/<file name>
      ```

   {% endlist %}


{% note warning %}

To renew a certificate, you have to perform certain actions. Keep track of the lifecycle of your certificates to renew them on time. For more information, see [Renew a certificate](../concepts/managed-certificate.md#renew).

{% endnote %}

## Set up static website access over HTTPS {#hosting-certificate}

{% list tabs %}

- Management console

   1. Log in to the [management console]({{ link-console-main }}).
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. In the **{{ ui-key.yacloud.storage.switch_buckets }}** tab, click the bucket with the same name as the domain.
   1. Go to the **{{ ui-key.yacloud.storage.bucket.switch_https }}** tab.
   1. In the right-hand panel that opens, click **{{ ui-key.yacloud.storage.bucket.https.button_action-configure }}**.
   1. In the **{{ ui-key.yacloud.storage.bucket.https.field_source }}** field, select `{{ ui-key.yacloud.storage.bucket.https.value_method-certificate-manager }}`.
   1. In the **{{ ui-key.yacloud.storage.bucket.https.field_certificate-manager }}** field, select the certificate from the list that opens.
   1. Click **{{ ui-key.yacloud.storage.bucket.https.button_save }}**.

{% endlist %}


#### See also {#see-also}

- [{#T}](../concepts/managed-certificate.md)
- [{#T}](../concepts/challenges.md)
- [Set up HTTPS in a bucket](../../storage/operations/hosting/certificate.md)
