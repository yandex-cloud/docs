# Configuring HTTPS

If a bucket is used for [hosting a static website](../../hosting/index.md), then to access the site via [HTTPS](https://en.wikipedia.org/wiki/HTTPS), you must upload your own security certificate and the applicable secret key.

{{ objstorage-name }} only supports [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded certificates.

{% note info %}

Access to the bucket over HTTPS is granted within thirty minutes of uploading the certificate.

{% endnote %}

{% list tabs %}

- Management console
    1. Select a folder.
    1. Select **Object Storage**.
    1. Click the name of the desired bucket.
    1. Go to the **HTTPS** tab.
    1. In the panel that opens on the right, click **Configure**.
    1. Add the certificate and secret key.
    1. Click **Save**.

{% endlist %}

