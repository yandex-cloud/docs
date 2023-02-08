# Creating a custom certificate

Let's look at creating a custom certificate using a self-signed certificate as an example. Custom certificate requirements are shown on the [{#T}](../../concepts/imported-certificate.md) page.

## Creating a self-signed certificate file {#create-file}

To create a self-signed certificate using the `OpenSSL` library, run the command below:

{% list tabs %}

- Bash

   ```bash
   openssl req -x509 -newkey rsa:4096 -nodes \
     -keyout key.pem \
     -out cert.pem \
     -days 365 \
     -subj '/CN=example.com'
   ```

- PowerShell

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
* `-out`: Certificate file name.
* `-days`: Certificate validity period.
* `-subj`: Certificate owner's Common Name value.

The `req` command launched with the above parameters will issue a self-signed certificate and generate the associated private key.

## Creating a self-signed user certificate {#create-certificate}

To create a user certificate:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create a user certificate in.
   1. In the list of services, select **{{ certificate-manager-name }}**.
   1. Click **Add certificate**.
   1. In the menu that opens, select **User certificate**.
   1. In the resulting window, use the **Name** field to enter a user certificate name.
   1. (optional) Enter a certificate description in the **Description** field.
   1. In the **Certificate** field, click **Add certificate**.
      1. Select **File** as the adding method.
      1. Click **Select file**.
         1. In the resulting window, select the `cert.pem` self-signed certificate file.
      1. Click **Add**.
   1. In the **Private key** field, click **Add private key**.
      1. Select **File** as the adding method.
      1. Click **Select file**.
         1. In the resulting window, select the `key.pem` private key file.
      1. Click **Add**.
   1. Click **Create**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the command:

      ```bash
      yc certificate-manager certificate create --help
      ```

   1. Run the command:

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

      Command result:

      ```bash
      id: fpqmg47avvimp7rvmp30
      folder_id: b1g7gvsi89m34qmcm3ke
      created_at: "2020-09-15T06:54:44.916325Z"
      ...
      issued_at: "2020-09-15T06:54:44.916325Z"
      not_after: "2021-09-15T06:48:26Z"
      not_before: "2020-09-15T06:48:26Z"
      ```

- API

   To create a certificate, use the [create](../../api-ref/Certificate/create.md) method for the [Certificate](../../api-ref/Certificate/) resource.

{% endlist %}

A new certificate with the `Issued` status appears in the certificate list.