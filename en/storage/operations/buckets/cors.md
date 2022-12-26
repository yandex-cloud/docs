# Configuring CORS

{{ objstorage-name }} lets you manage [CORS configurations](../../concepts/cors.md) in buckets.

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), go to the bucket you want to configure CORS for.
  1. In the left pane, select **CORS**.
  1. Click **Configure**.
  1. A page opens where you can add, delete, and edit configuration rules. For a detailed description of the configuration fields, see [{#T}](../../s3/api-ref/cors/xml-config.md).

- AWS CLI

  To upload a configuration via the AWS CLI:

  1. Describe the CORS configuration of objects in JSON format. For example:

     ```json
     {
       "CORSRules": [
         {
           "AllowedHeaders": ["*"],
           "AllowedMethods": ["GET", "HEAD", "PUT", "DELETE"],
           "MaxAgeSeconds": 3000,
           "AllowedOrigins": ["*"]
         }
       ]
     }
     ```

     When you're done, you can save your configuration as a file, for example, `cors.json`.

  1. Upload the configuration to a bucket, for example, `shared-bucket`:

     ```bash
     aws s3api put-bucket-cors \
       --bucket shared-bucket \
       --cors-configuration file://cors.json \
       --endpoint-url=https://{{ s3-storage-host }}
     ```

- {{ TF }}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Get {% if audience != "internal" %}[static access keys](../../../iam/operations/sa/create-access-key.md){% else %}static access keys{% endif %}: a private key and key ID used for authentication in {{ objstorage-short-name }}.

  1. In the configuration file, describe the parameters of resources that you want to create:

     {% if product == "yandex-cloud" %}

     ```hcl
     provider "yandex" {
       cloud_id  = "<cloud ID>"
       folder_id = "<folder ID>"
       zone      = "<availability zone>"
       token     = "<OAuth token>"
       }
     
     resource "yandex_storage_bucket" "b" {
       bucket = "s3-website-test.hashicorp.com"
       acl    = "public-read"
     
       access_key = "<key ID>"
       secret_key = "<secret key>"
     
       cors_rule {
         allowed_headers = ["*"]
         allowed_methods = ["PUT", "POST"]
         allowed_origins = ["https://s3-website-test.hashicorp.com"]
         expose_headers  = ["ETag"]
         max_age_seconds = 3000
       }
     }
     ```

     {% endif %}

     {% if product == "cloud-il" %}

     ```hcl
     provider "yandex" {
       cloud_id  = "<cloud ID>"
       folder_id = "<folder ID>"
       zone      = "<availability zone>"
       endpoint  = "{{ api-host }}:443"
       token     = "<static key of the service account>"
       }
     
     resource "yandex_storage_bucket" "b" {
       bucket = "s3-website-test.hashicorp.com"
       acl    = "public-read"
     
       access_key = "<key ID>"
       secret_key = "<secret key>"

       cors_rule {
         allowed_headers = ["*"]
         allowed_methods = ["PUT", "POST"]
         allowed_origins = ["https://s3-website-test.hashicorp.com"]
         expose_headers  = ["ETag"]
         max_age_seconds = 3000
       }
     }
     ```

     {% endif %}

     Where:

     * `access_key`: The ID of the static access key.
     * `secret_key`: The value of the private access key.
     * `bucket`: Bucket name. Required parameter.
     * `acl`: The ACL policy applied. Optional.

     `CORS` parameters:
     * `allowed_headers`: Headers allowed. Optional.
     * `allowed_methods`: Methods allowed. Possible values: `GET`, `PUT`, `POST`, `DELETE`, or `HEAD`. Required parameter.
     * `allowed_origins`: Website that allows sending cross-domain requests to a bucket. Required parameter.
     * `expose_headers`: Header that can be displayed in a JavaScript app in the browser. Optional.
     * `max_age_seconds`: Time in seconds during which the results of requests to an object are cached by the browser. Optional.
     * `server_side_encryption_configuration`: Bucket encryption settings on the server side. Optional.

     For more information about the resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}).

  1. Make sure that the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.

     1. Run the check using the command:

        ```bash
        terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

  1. Deploy the cloud resources.

     1. If the configuration doesn't contain any errors, run the command:

        ```bash
        terraform apply
        ```

     1. Confirm that you want to create the resources.

     Afterwards, all the necessary resources are created in the specified folder. You can check resource availability and their settings in the [management console]({{ link-console-main }}).

{% endlist %}

