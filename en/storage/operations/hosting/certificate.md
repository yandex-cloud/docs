# Configuring HTTPS

If you are using a bucket to [host a static website](../../concepts/hosting.md), then to access the website via [HTTPS](https://en.wikipedia.org/wiki/HTTPS), you will need to upload your own security certificate and a corresponding secret key.

{{ objstorage-name }} only supports [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded certificates.

{% note info %}

Access to the bucket over HTTPS is granted within thirty minutes of uploading the certificate.

{% endnote %}

## Upload your own security certificate {#own}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ objstorage-name }}**.
   1. Click the name of the desired bucket.
   1. Go to the **HTTPS** tab.
   1. In the panel that opens on the right, click **Configure**.
   1. In the **Source** field, select **Your certificate**.
   1. Add the certificate and secret key.
   1. Click **Save**.

{% endlist %}

## Select a certificate from {{ certificate-manager-name }} {#cert-manager}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ objstorage-name }}**.
   1. Click the name of the desired bucket.
   1. Go to the **HTTPS** tab.
   1. In the panel that opens on the right, click **Configure**.
   1. In the **Source** field, select **Go to {{ certificate-manager-name }}**.
   1. In the **Certificate** field, select the certificate from the list that opens.

      {% note info %}

      If you don't have a certificate in {{ certificate-manager-full-name }}, Click **Go to {{ certificate-manager-name }}** and follow the [instructions](../../../certificate-manager/quickstart/index.md) to create your first certificate.

      {% endnote %}

   1. Click **Save**.

{% endlist %}