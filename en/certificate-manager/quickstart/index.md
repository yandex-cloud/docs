# Getting started with {{ certificate-manager-name }}

Follow this guide to add your first [Let's Encrypt certificate](../concepts/managed-certificate.md) to {{ certificate-manager-name }} and use it to [set up HTTPS access](../../storage/operations/hosting/certificate.md) to a static website hosted in {{ objstorage-full-name }}.

## Getting started {#before-you-begin}

To get started with {{ certificate-manager-name }}, you need:

{% list tabs group=instructions %}

- Management console {#console}

    1. Folder in {{ yandex-cloud }}. If there is no folder yet, create one:

         {% include [create-folder](../../_includes/create-folder.md) %}

    1. Third-level (or higher) domain for which a Let's Encrypt certificate will be issued.

         {% note info %}

         To pass a domain rights check, you must have the management access to the domain.

         {% endnote %}

    1. Public bucket in Object Storage named exactly as the domain. If you do not have a bucket yet, create one:

        1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [bucket](../../storage/concepts/bucket.md).
        1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
        1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
        1. Enter exactly the same name for the bucket as the domain name.
        1. Select the `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}` [access](../../storage/concepts/bucket.md#bucket-access) type.
        1. Select the default [storage class](../../storage/concepts/storage-class.md).
        1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}** to complete the operation.

    1. Set up [hosting](../../storage/operations/hosting/setup.md) in your bucket:

        1. In the [management console]({{ link-console-main }}), select the folder with the bucket.
        1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
        1. On the ![box](../../_assets/console-icons/box.svg) **{{ ui-key.yacloud.storage.switch_buckets }}** tab, click the bucket with the domain name.
        1. In the left-hand panel, select ![wrench](../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
        1. Open the **{{ ui-key.yacloud.storage.bucket.switch_website }}** tab.
        1. Select `{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}` and specify the website's home page.
        1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}** to complete the operation.

    1. Set up an [alias](../../storage/operations/hosting/own-domain.md) for the bucket through your DNS provider or on your own DNS server.

        For instance, for the `www.example.com` domain, add the following record:

        ```text
        www.example.com CNAME www.example.com.{{ s3-web-host }}
        ```

{% endlist %}

## Creating a request for a Let's Encrypt certificate {#request-certificate}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [management console]({{ link-console-main }}).
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
    1. Click **{{ ui-key.yacloud.certificate-manager.button_empty-action }}**.
    1. In the menu that opens, select **{{ ui-key.yacloud.certificate-manager.action_request }}**.
    1. In the window that opens, enter a name for the certificate.
    1. Optionally, add a description for the certificate.
    1. In the **{{ ui-key.yacloud.certificate-manager.request.field_domains }}** field, specify the domains you want to issue the certificate for.
    1. Select the [domain rights check type](../concepts/challenges.md): `{{ ui-key.yacloud.certificate-manager.request.challenge-type_label_http }}`. 
    1. Click **{{ ui-key.yacloud.certificate-manager.request.button_request }}**.

{% endlist %}

## Passing a domain rights check {#validate}

### Creating a file for the check {#create-file}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [management console]({{ link-console-main }}).
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
  1. Select a certificate in the `Validating` status in the list and click it.
  1. Under **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}**:
      1. Copy the URL from the **{{ ui-key.yacloud.certificate-manager.overview.challenge_label_http-url }}** field:
          * The `http://example.com/.well-known/acme-challenge/` part of the link is the file path.
          * The second part, `rG1Mm1bJ...`, is the file name you should use.
      1. Copy and paste the **{{ ui-key.yacloud.certificate-manager.overview.challenge_label_http-content }}** field to the file.

{% endlist %}

### Uploading the file and performing the check {#upload-and-check}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [management console]({{ link-console-main }}).
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. On the ![box](../../_assets/console-icons/box.svg) **{{ ui-key.yacloud.storage.switch_buckets }}** tab, click the bucket with the domain name.
  1. At the top right, click ![folder](../../_assets/console-icons/folder.svg) **{{ ui-key.yacloud.storage.bucket.button_create }}** and create a folder named `.well-known`.
  1. Under `.well-known`, create a folder named `acme-challenge`.
  1. Under `acme-challenge`, click ![arrow](../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.storage.button_upload }}**.
  1. In the window that opens, select the file with a record and click **Open**.
  1. Click **{{ ui-key.yacloud.storage.button_upload }}**.
  1. Wait until the certificate's status changes to `Issued`.
     
     For more information on the status, see the certificate page. To do this, next to the **ui-key.yacloud.certificate-manager.overview.general_label_validation** field, click ![receipt](../../_assets/console-icons/receipt.svg) **ui-key.yacloud.certificate-manager.overview.button_validation_show-logs**. 
  1. Go to the `acme-challenge` folder.
  1. Click ![image](../../_assets/options.svg) to the right of the file and select ![trash](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

- AWS CLI {#cli}

  1. Install and configure the AWS CLI by following [this tutorial](../../storage/tools/aws-cli.md#before-you-begin).
  1. Upload your file to the bucket so that it resides in the `.well-known/acme-challenge` folder:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }} \
        s3 cp <file_name> s3://<bucket_name>/.well-known/acme-challenge/<file_name>
      ```

  1. Wait until the certificate's status changes to `Issued`.
  1. Delete the file you created from the bucket:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }} \
         s3 rm s3://<bucket_name>/.well-known/acme-challenge/<file_name>
      ```

{% endlist %}

{% note warning %}

Certificates are not renewed automatically. Keep track of the lifecycle of your certificates to renew them on time. For more information, see [Renewing a certificate](../concepts/managed-certificate.md#renew).

{% endnote %}

## Setting up static website access over HTTPS {#hosting-certificate}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [management console]({{ link-console-main }}).
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
    1. On the ![box](../../_assets/console-icons/box.svg) **{{ ui-key.yacloud.storage.switch_buckets }}** tab, click the bucket with the domain name.
    1. In the left-hand panel, select ![persons-lock](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
    1. Navigate to the **{{ ui-key.yacloud.storage.bucket.switch_https }}** tab.
    1. Click **{{ ui-key.yacloud.storage.bucket.https.button_action-configure }}** at the top right.
    1. In the **{{ ui-key.yacloud.storage.bucket.https.field_source }}** field, select `{{ ui-key.yacloud.storage.bucket.https.value_method-certificate-manager }}`.
    1. In the **{{ ui-key.yacloud.storage.bucket.https.field_certificate-manager }}** field, select the certificate from the list that opens.
    1. Click **{{ ui-key.yacloud.storage.bucket.https.button_save }}**.

{% endlist %}


#### See also {#see-also}

- [{#T}](../concepts/managed-certificate.md)
- [{#T}](../concepts/challenges.md)
- [Configuring HTTPS in a bucket](../../storage/operations/hosting/certificate.md)
