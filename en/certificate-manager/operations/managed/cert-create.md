# Create a Let's Encrypt<sup>®</sup> certificate

To create a new Let's Encrypt certificate:

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), select the folder to create your certificate in.
    1. In the list of services, select **{{ certificate-manager-name }}**.
    1. Click **Add certificate**.
    1. In the menu that opens, select **Let's Encrypt certificate**.
    1. In the window that opens, enter the name of the certificate in the **Name** field.
    1. (optional) In the **Description** field, enter a description for the certificate.
    1. In the **Domains** field, enter the list of domains to create a certificate for.
    1. Select the [type of domain rights check:](../../concepts/challenges) `HTTP` or `DNS`.
    1. Click **Create**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. View a description of the command:

        ```bash
        yc certificate-manager certificate request --help
        ```

    1. Run the command:

        ```bash
        yc certificate-manager certificate request \
          --name mymanagedcert \
          --domains example.com
        ```

        Command parameters:
          - `--name`: Certificate name.
          - `--domains`: Certificate domains.

        Command results:

        ```bash
        id: fpq6gvvm6piuegbb2nol
        folder_id: b1g7gvsi89m34qmcm3ke
        created_at: "2020-09-15T08:49:11.533771Z"
        name: mymanagedcert
        type: MANAGED
        domains:
        - example.com
        status: VALIDATING
        updated_at: "2020-09-15T08:49:11.533771Z"
        ```

- API

    To create a certificate, use the [requestNew](../../api-ref/Certificate/requestNew.md) method for the [Certificate](../../api-ref/Certificate/) resource.

{% endlist %}

The new certificate now appears in the certificate list with the `Validating` status. This status means that a Let's Encrypt certificate was requested and you need to pass the [domain rights check](cert-validate.md) to process it.

