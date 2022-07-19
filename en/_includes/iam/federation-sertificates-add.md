{% list tabs %}

- Management console

  To add a certificate to a federation:
  1. Open the folder page in the [management console]({{ link-console-main }}).
  1. Select the **Federations** tab in the left menu.
  1. Click the name of the federation you want to add a certificate to.
  1. Click **Add certificate** at the bottom of the page.
  1. Choose how to add the certificate:
      * To add a certificate as a file, click **Choose a file** and specify the path to it.
      * To paste the contents of a copied certificate, select the **Text** method and paste the contents.

- CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. View a description of the add certificate command:

      ```
      yc iam certificate create --help
      ```

  1. Add a federation certificate by specifying the certificate file path:

      ```
      yc iam certificate create --federation-name my-federation \
        --name "my-certificate" \
        --certificate-file test.pem
      ```

- API

  To add the certificate, use the [create](../../iam/api-ref/Certificate/create.md) method for the [Certificate](../../iam/api-ref/Certificate/index.md) resource:

  1. Create a request body by specifying the contents of the certificate's `data` property:

      ```json
      {
        "federationId": "<federation ID>",
        "name": "my-certificate",
        "data": "MII...=="
      }
      ```

  2. Send the add certificate request:

      ```bash
      export IAM_TOKEN=CggaATEVAgA...
      curl -X POST \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d '@body.json' \
          "https://iam.{{ api-host }}/iam/v1/saml/certificates"
      ```

{% endlist %}

