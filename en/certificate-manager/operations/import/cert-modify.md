# Edit a user certificate

After creating a certificate, you can change its name or description. To edit a certificate:

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), select the folder where the certificate was created.
    1. In the list of services, select **{{ certificate-manager-name }}**.
    1. Select the certificate you need to change from the list.
    1. In the window that opens, click **Edit**.
    1. Change the name or description of the certificate.
    1. Click **Save**.

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
        | fpqmg47avvimp7rvmp30 | mycert | example.com | 2021-09-15 08:12:57 | IMPORTED | ISSUED |
        +----------------------+--------+-------------+---------------------+----------+--------+
        ```

    1. Run the command:

        ```bash
        yc certificate-manager certificates update \
          --id fpqmg47avvimp7rvmp30 \
          --new-name myupdatedcert \
          --description "description of myupdatedcert"
        ```

        Where:
          - `--id`: Certificate ID.
          - `--new-name`: New name for the certificate.
          - `--description`: Certificate description.

        Result:

        ```bash
        id: fpqmg47avvimp7rvmp30
        folder_id: b1g7gvsi89m34qmcm3ke
        created_at: "2020-09-15T06:54:44.916Z"
        name: myupdatedcert
        description: description of myupdatedcert
        type: IMPORTED
        domains:
        - example.com
        status: ISSUED
        issuer: CN=example.com
        subject: CN=example.com
        serial: 3df79e43df7c3868397b78bfc15a431fa942a135
        updated_at: "2020-09-15T08:37:20.746757Z"
        issued_at: "2020-09-15T08:23:50.147Z"
        not_after: "2021-09-15T08:12:57Z"
        not_before: "2020-09-15T08:12:57Z"
        ```

- API

    To update the certificate, use the [update](../../api-ref/Certificate/update.md) method for the [Certificate](../../api-ref/Certificate/) resource.

{% endlist %}

