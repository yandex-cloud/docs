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

      If you don't have a certificate in {{ certificate-manager-full-name }}, Click **Go to {{ certificate-manager-name }}** and follow the {% if audience != "internal" %}[instructions](../../../certificate-manager/quickstart/index.md){% else %}instructions{% endif %} to create your first certificate.

      {% endnote %}

   1. Click **Save**.

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   {% if audience != "internal" %}

   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% endif %}

   To select a certificate from {{ certificate-manager-name }}:

   1. Open the {{ TF }} configuration file and add the `https` section to the bucket description:

      ```hcl
      ...
      resource "yandex_storage_bucket" "b" {
        bucket = "my-policy-bucket"
      
        https {
          certificate_id = "<certificate_ID>"
        }
      }
      ...
      ```

      Where:
      * `certificate_id` is the ID of the certificate in {{ certificate-manager-name }} to be used for the bucket.

      For more information about the `yandex_storage_bucket` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/storage_bucket#bucket-https-certificate).

   1. Check the configuration using the command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contain errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can use the [management console]({{ link-console-main }}) to check the selected certificate.

{% endlist %}
