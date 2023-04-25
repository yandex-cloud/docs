# Configuring CORS

{{ objstorage-name }} lets you manage [CORS configurations](../../concepts/cors.md) in the bucket.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the bucket you want to configure CORS for.
   1. In the left-hand panel, select **{{ ui-key.yacloud.storage.bucket.cors.label_title }}**.
   1. Click **{{ ui-key.yacloud.storage.bucket.cors.button_cors_empty-create }}**.
   1. This will open a page where you can add, delete, and edit configuration rules. For a detailed description of the configuration fields, see [{#T}](../../s3/api-ref/cors/xml-config.md).

- {{ yandex-cloud }} CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to update a bucket:

      ```bash
      yc storage bucket update --help
      ```

   1. Get a list of buckets in the default folder:

      ```bash
      yc storage bucket list
      ```

      Result:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6cv2mhjmo | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

   1. Save the name of the bucket using the `NAME` column to set up the CORS configuration in.
   1. Run the following command:

      ```bash
      yc storage bucket update
        --name <bucket_name> \
        --cors <CORS_parameter>=<value>,<CORS_parameter>=<value>,...
      ```

      Where:
      * `--name`: Name of the bucket to set up the CORS configuration in.
      * `--cors`: CORS parameters:
         * `allowed-methods`: List of methods. Possible values: `method-get`, `method-put`, `method-post`, `method-delete`, and `method-head`. This parameter is required.
         * `allowed-origins`: List of websites that allow sending cross-domain requests to a bucket. This parameter is required.
         * `allowed-headers`: List of allowed headers. This is an optional parameter.
         * `expose-headers`: List of headers that can be displayed in a JavaScript app in the browser. This is an optional parameter.
         * `max-age-seconds`: Time in seconds during which the results of requests to an object are cached by the browser. This is an optional parameter.

         The lists are enclosed in square brackets, their items are comma-separated with no spaces, e.g., `allowed-methods=[method-get,method-head],allowed-origins=[example.com]`.

         Permissions specified in the command override the current CORS settings of the bucket. You can retrieve the current permissions using the `yc storage bucket get <bucket_name> --full` command.

         Result:

         ```yaml
         name: first-bucket
         folder_id: b1gmit33ngp6cv2mhjmo
         default_storage_class: STANDARD
         versioning: VERSIONING_DISABLED
         max_size: "53687091200"
         acl: {}
         created_at: "2022-11-25T11:48:42.024638Z"
         ```

   To remove the CORS configuration, run this command:

   ```bash
   yc storage bucket update \
     --name <bucket_name> \
     --remove-cors
   ```

- AWS CLI

   To upload a configuration via the [AWS CLI](../../tools/aws-cli.md):

   1. Describe the CORS object configurations in JSON format. For example:

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

   Retrieve [static access keys](../../../iam/operations/sa/create-access-key.md): a static key and a key ID used to authenticate in {{ objstorage-short-name }}.

   1. In the configuration file, describe the parameters of the resources you want to create:

      
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



      Where:

      * `access_key`: ID of the static access key.
      * `secret_key`: Value of the secret access key.
      * `bucket`: Bucket name. This parameter is required.
      * `acl`: Applied ACL policy. This is an optional parameter.

      `CORS` parameters:
      * `allowed_headers`: Headers allowed. This is an optional parameter.
      * `allowed_methods`: Methods allowed. Possible values: `GET`, `PUT`, `POST`, `DELETE`, or `HEAD`. This parameter is required.
      * `allowed_origins`: Website that allows sending cross-domain requests to a bucket. This parameter is required.
      * `expose_headers`: Header that can be displayed in a JavaScript app in the browser. This is an optional parameter.
      * `max_age_seconds`: Time in seconds during which the results of requests to an object are cached by the browser. This is an optional parameter.
      * `server_side_encryption_configuration`: Bucket encryption settings on the server side. This is an optional parameter.

      For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Make sure the configuration files are valid.
      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.
      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

      Once you are done, all the resources you need will be created in the specified folder. You can check that the resources are there and their settings are correct using the [management console]({{ link-console-main }}).

- API

   To manage CORS configurations for buckets, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update) gRPC API call, or the [upload](../../s3/api-ref/cors/upload.md) S3 API method.

{% endlist %}
