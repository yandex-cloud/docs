# Create a user certificate

To create a user certificate:

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), select the folder to create your certificate in.
    1. In the list of services, select **{{ certificate-manager-name }}**.
    1. Click **Add certificate**.
    1. In the menu that opens, select **User certificate**.
    1. In the window that opens, enter the name of the certificate in the **Name** field.
    1. (optional) In the **Description** field, enter a description for the certificate.
    1. In the **Certificate** field, click **Add certificate**.
        1. Select how to add your certificate: **File** or **Text**.
        1. Click **Add**.
    1. In the **Intermediate certificate chain** field, click **Add chain**.
        1. Select how to add your certificate: **File** or **Text**.
        1. Click **Add**.
    1. In the **Private key** field, click **Add private key**.
        1. Select how to add your certificate: **File** or **Text**.
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

          - `--name`: Certificate name.
          - `--chain`: Path to the certificate chain file.
          - `--key`: Path to the file of the certificate private key.

        Result:

        ```bash
        id: fpqmg47avvimp7rvmp30
        folder_id: b1g7gvsi89m34qmcm3ke
        created_at: "2020-09-15T06:54:44.916325Z"
        name: mycert
        type: IMPORTED
        domains:
        - example.com
        status: ISSUED
        issuer: CN=example.com
        subject: CN=example.com
        serial: c32fd55592a376635fa53d9aea677caae6bf08f
        updated_at: "2020-09-15T06:54:44.916325Z"
        issued_at: "2020-09-15T06:54:44.916325Z"
        not_after: "2021-09-15T06:48:26Z"
        not_before: "2020-09-15T06:48:26Z"
        ```

- API

    To create a certificate, use the [create](../../api-ref/Certificate/create.md) method for the [Certificate](../../api-ref/Certificate/) resource.

{% endlist %}

A new certificate with the `Issued` status appears in the certificate list.

