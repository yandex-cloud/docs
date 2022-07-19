# Hosting setup

{{ objstorage-name }} lets you configure a bucket:

* For [static website hosting](#hosting).
* To [redirect all requests](#redirects).
* For [conditionally redirecting requests](#redirects-on-conditions).

## Static website hosting {#hosting}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the bucket you want to configure hosting for.
   1. Make sure public access is allowed to the bucket. If not, follow the instructions in [{#T}](../buckets/bucket-availability.md).
   1. In the left panel, select **Website**.
   1. Under **Hosting**, specify:
      * The website homepage.
      * The page to be displayed to the user in the event of 4xx errors. Optional.
   1. Click **Save**.

- {{ TF }}

   If you do not have {{ TF }} yet, {% if audience != "internal" %}[install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}install it and configure the {{ yandex-cloud }} provider{% endif %}.

   Before you start, retrieve the {% if audience != "internal" %}[static access keys](../../../iam/operations/sa/create-access-key.md){% else %}static access keys{% endif %}: a secret key and a key ID used for authentication in {{ objstorage-short-name }}.

   1. In the configuration file, describe the parameters of resources that you want to create:

      {% if product == "yandex-cloud" %}

      ```hcl
      provider "yandex" {
        token     = "<OAuth>"
        cloud_id  = "<cloud ID>"
        folder_id = "<folder ID>"
        zone      = "{{ region-id }}-a"
      }

      resource "yandex_storage_bucket" "test" {
        access_key = "<static key ID>"
        secret_key = "<secret key>"
        bucket = "<bucket name>"
        acl    = "public-read"
      
        website {
          index_document = "index.html"
          error_document = "error.html"
        }
      
      }
      ```

      {% endif %}

      {% if product == "cloud-il" %}


      ```hcl
      provider "yandex" {
        endpoint  = "{{ api-host }}:443"
        token     = "<static key of the service account>"
        cloud_id  = "<cloud ID>"
        folder_id = "<folder ID>"
        zone      = "{{ region-id }}-a"
      }

      resource "yandex_storage_bucket" "test" {
        access_key = "<static key ID>"
        secret_key = "<secret key>"
        bucket = "<bucket name>"
        acl    = "public-read"

        website {
          index_document = "index.html"
          error_document = "error.html"
        }

      }
      ```

      {% endif %}

      Where:

      * `access_key`: The ID of the static access key.
      * `secret_key`: The value of the secret access key.
      * `bucket`: Bucket name.
      * `acl`: Parameters for [ACL](../../concepts/acl.md#predefined-acls).
      * `website`: Website parameters:

         * `index_document`: Absolute path to the file of the website's homepage. Required parameter.
         * `error_document`: Absolute path to the file to be displayed to the user in the event of `4xx` errors. Optional.

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

      ```
      terraform apply
      ```

      1. Confirm that you want to create the resources.

      Afterwards, all the necessary resources are created in the specified folder. You can check that the resources are there with the correct settings using the [management console]({{ link-console-main }}).

{% endlist %}

## Redirect all requests {#redirects}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the bucket you wish to configure redirection for.
   1. Make sure public access is allowed to the bucket. If not, follow the instructions in [{#T}](../buckets/bucket-availability.md).
   1. In the left panel, select **Website**.
   1. Under **Redirect**, specify:
      * The domain name of the host to act as the redirect target for all requests to the current bucket.
      * The protocol if the specified host accepts requests strictly over a specific protocol.

{% endlist %}

## Conditional request redirection {#redirects-on-conditions}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the bucket you wish to configure conditional request redirects for.
   1. Make sure public access is allowed to the bucket. If not, follow the instructions in [{#T}](../buckets/bucket-availability.md).
   1. In the left panel, select **Website**.
   1. Under **Hosting**, add a redirect rule with the redirect condition and the new address.
      * Condition. For example, you can do a redirect when you receive a specified response code or if the beginning of the object key in a request matches the specified key.
      * Redirection:
         * The domain name of the host where requests that satisfy the condition should redirect.
         * The protocol to use to send redirected requests.
         * Response code to determine the redirect type.
         * Replace the entire key specified in the condition or its initial sequence only.

{% endlist %}
