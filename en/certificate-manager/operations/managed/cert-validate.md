# Checking domain rights

To check rights for domains:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the certificate was added to.
   1. In the list of services, select **{{ certificate-manager-name }}**.
   1. Select the certificate to check from the list and click it.
   1. In the window that opens, the details you need to pass the domain rights check can be found under **Check rights for domains**. For more information, see [{#T}](../../concepts/challenges.md).
   1. When the domain rights check is passed, the domain check status under **Check rights for domain** changes to `Valid`.
   1. After the rights check status for all your domains changes to `Valid`, the certificate is issued and its status becomes `Issued`.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the command:

      ```bash
      yc certificate-manager certificate get --help
      ```

   1. Run the following command:

      ```bash
      yc certificate-manager certificate get \
        --id fpq6gvvm6piuegbb2nol \
        --full
      ```

      Where:

      - `--id`: Certificate ID.
      - `--full`: Show a list of active checks for domain rights.

      Result:

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
      challenges:
      - domain: example.com
        type: HTTP
        created_at: "2020-09-15T08:49:11.533771Z"
        updated_at: "2020-09-15T08:51:44.991065Z"
        status: PENDING
        message: Create a file in your web server's base directory.
        http_challenge:
          url: http://example.com/.well-known/acme-challenge/3LiH-nrTC7GdMbRgVqttEvdTODeNeaD0TtXteWgtAH8
          content: 3LiH-nrTC7GdMbRgVqttEvdTODeNeaD0TtXteWgtAH8.ZHCju15sJiKBwT8G5FTl7UtfmJWp1gKNYYPLcVtVL44
      ```

   1. The information required for passing the rights check for a domain can be found under `http_challenge`. For more information, see [{#T}](../../concepts/challenges.md).

   1. When the rights check for a domain is passed, the domain check status changes to `Valid`:

      ```bash
      yc certificate-manager certificate get --id fpq6gvvm6piuegbb2nol --full
      ...
      domains:
      - example.com
      status: VALID
      ...
      ```

   1. After the rights check status for all your domains changes to `Valid`, the certificate is issued and its status becomes `Issued`:

      ```bash
      yc certificate-manager certificate get --id fpq6gvvm6piuegbb2nol --full
      ...
      domains:
      - example.com
      status: ISSUED
      ...
      ```

- API

   To get the information required to pass the rights check for a domain, use the [get](../../api-ref/Certificate/get.md) REST API method for the [Certificate](../../api-ref/Certificate/) resource or the [CertificateService/Get](../../api-ref/grpc/certificate_service.md#Get) gRPC API call with the `view=FULL` flag.

{% endlist %}
