# Edit a certificate

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
        +----------------------+---------------+-------------+-----------+---------+------------+
        |          ID          |     NAME      |   DOMAINS   | NOT AFTER |  TYPE   |   STATUS   |
        +----------------------+---------------+-------------+-----------+---------+------------+
        | fpq6gvvm6piuegbb2nol | mymanagedcert | example.com |           | MANAGED | VALIDATING |
        +----------------------+---------------+-------------+-----------+---------+------------+
        ```

    1. Run the command:

        ```bash
        yc certificate-manager certificates update \
          --id fpq6gvvm6piuegbb2nol \
          --new-name myupdatedmanagedcert \
          --description "description of myupdatedmanagedcert"
        ```

        Command parameters:
          - `--id`: Certificate ID.
          - `--new-name`: New name for the certificate.
          - `--description`: Certificate description.

        Command results:

        ```bash
        id: fpq6gvvm6piuegbb2nol
        folder_id: b1g7gvsi89m34qmcm3ke
        created_at: "2020-09-15T08:49:11.533Z"
        name: myupdatedmanagedcert
        description: description of myupdatedmanagedcert
        type: MANAGED
        domains:
        - example.com
        status: VALIDATING
        updated_at: "2020-09-15T09:10:06.981875Z"
        ```

- API

    To update the certificate, use the [update](../../api-ref/Certificate/update.md) method for the [Certificate](../../api-ref/Certificate/) resource.

{% endlist %}

