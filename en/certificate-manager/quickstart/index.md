# Getting started with {{ certificate-manager-name }}

By following these instructions, you'll create your first [Let's Encrypt<sup>®</sup>](../concepts/managed-certificate) certificate and use it to [set up HTTPS access](../../storage/operations/hosting/certificate.md) to your static website hosted in {{ objstorage-full-name }}.

## Before you start {#before-you-begin}

To get started with {{ certificate-manager-name }}, you need:

1. A folder in {{ yandex-cloud }}. If you don't have a folder, create one:

    {% include [create-folder](../../_includes/create-folder.md) %}

1. A third level (or higher) domain that the Let's Encrypt<sup>®</sup> certificate is issued for.

    {% note info %}

    To pass the domain rights check, you must have control of the domain.

    {% endnote %}

1. A public bucket in Object Storage with exactly the same name as the domain. If that bucket doesn't exist, create it:

    {% list tabs %}

    - Management console
        1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [bucket](../../storage/concepts/bucket.md).
        1. Select **{{ objstorage-name }}**.
        1. Click **Create bucket**.
        1. Enter exactly the same name for the bucket as the domain name.
        1. Selected the type of [access](../../storage/concepts/bucket.md#bucket-access) **Public**.
        1. Select the default [storage class](../../storage/concepts/storage-class.md).
        1. Click **Create bucket** to complete the operation.

    {% endlist %}

1. Set up [hosting](../../storage/operations/hosting/setup.md) in the bucket:

    {% list tabs %}

    - Management console
        1. In the [management console]({{ link-console-main }}), select **{{ objstorage-name }}**.
        1. In the **Buckets** tab, click the bucket with the same name as the domain.
        1. In the left pane, select **Website**.
        1. Select **Hosting** and enter your website home page.
        1. Click **Save** to complete the operation.

    {% endlist %}

1. Configure the [alias](../../storage/operations/hosting/own-domain.md) for your bucket at your provider's DNS or on your own DNS server.

    For instance, for the `www.example.com` domain, add the following record:

    ```
    www.example.com CNAME www.example.com.{{ s3-web-host }}
    ```

1. Install and configure the AWS CLI by following our [instructions](../../storage/tools/aws-cli.md#before-you-begin).

## Create a request for a Let's Encrypt certificate {#request-certificate}

{% list tabs %}

- Management console
    1. Go to the [management console]({{ link-console-main }}).
    1. Select **{{ certificate-manager-name }}**.
    1. Click **Add certificate**.
    1. In the menu that opens, select **Let's Encrypt certificate**.
    1. In the window that opens, enter a name for the certificate.
    1. (Optional) Add a description for the certificate.
    1. In the **Domains** field, specify the domains you want to issue the certificate for.
    1. For the [Check type](../concepts/challenges.md) of the domain rights check, select: `HTTP`.
    1. Click **Create**.

{% endlist %}

## Passing the domain rights check {#validate}

1. Create a file for the check:
    1. Go to the [management console]({{ link-console-main }}).
    1. Select **{{ certificate-manager-name }}**.
    1. Select a certificate with the `Validating` status in the list and click it.
    1. Under **Check rights for domains**:
        1. Copy the link from the **Link for hosting file** field:
            * The part of the link that looks like `http://example.com/.well-known/acme-challenge/` is the path to host the file at.
            * The second part of the link, `rG1Mm1bJ...`, is the file name that you should use.
        1. Copy the contents of the file from the **Contents** field.

1. Upload the created file to the bucket so that it's hosted in the directory `.well-known/acme-challenge`:

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
    1. Select **{{ objstorage-name }}**.
    1. In the **Buckets** tab, click the bucket with the same name as the domain.
    1. Go to the **HTTPS** tab.
    1. In the panel that opens on the right, click **Configure**.
    1. Under **Source**, select **{{ certificate-manager-name }}**.
    1. In the **Certificate** field, select the certificate from the list that opens.
    1. Click **Save**.

{% endlist %}

#### See also {#see-also}

- [Let's Encrypt<sup>®</sup> certificate](../concepts/managed-certificate.md)
- [Check rights for domain](../concepts/challenges.md)
- [Set up HTTPS in a bucket](../../storage/operations/hosting/certificate.md)

