# Renew a user certificate

{{ certificate-manager-name }} doesn't manage user certificates. To make your certificate continuously available to your resources, be sure to renew it on time.

To get a new version of a user certificate:

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), select the folder where the certificate was created.
    1. In the list of services, select **{{ certificate-manager-name }}**.
    1. Select the certificate you want to renew in the list.
    1. In the window that opens, click **Renew certificate**.
    1. In the window that opens, click **Add certificate**  in the **Certificate** field.
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
        yc certificate-manager certificate update --help
        ```

    1. View the list of certificates:

        ```bash
        yc certificate-manager certificate list
        +----------------------+--------+-------------+---------------------+----------+--------+
        |          ID          |  NAME  |   DOMAINS   |      NOT AFTER      |   TYPE   | STATUS |
        +----------------------+--------+-------------+---------------------+----------+--------+
        | fpqmg47avvimp7rvmp30 | mycert | example.com | 2021-09-15 06:48:26 | IMPORTED | ISSUED |
        +----------------------+--------+-------------+---------------------+----------+--------+
        ```

    1. Run the command:

        ```bash
        yc certificate-manager certificate update \
          --id fpqmg47avvimp7rvmp30 \
          --chain myupdatedcert.pem \
          --key myupdatedkey.pem
        ```

        Where:

          - `--id`: ID of the certificate to renew.
          - `--chain`: Path to the new certificate chain file.
          - `--key`: Path to the file of the new certificate private key.

        Result:

        ```bash
        id: fpqmg47avvimp7rvmp30
        folder_id: b1g7gvsi89m34qmcm3ke
        created_at: "2020-09-15T06:54:44.916Z"
        name: mycert
        type: IMPORTED
        domains:
        - example.com
        status: ISSUED
        issuer: CN=example.com
        subject: CN=example.com
        serial: 3df79e43df7c3868397b78bfc15a431fa942a135
        updated_at: "2020-09-15T08:23:50.147668Z"
        issued_at: "2020-09-15T08:23:50.147668Z"
        not_after: "2021-09-15T08:12:57Z"
        not_before: "2020-09-15T08:12:57Z"
        ```

- API

    To update the certificate, use the [update](../../api-ref/Certificate/update.md) method for the [Certificate](../../api-ref/Certificate/) resource.

{% endlist %}

