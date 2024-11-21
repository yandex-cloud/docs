---
title: Configuring cross-domain requests (CORS) to objects in the {{ objstorage-full-name }} bucket
description: Follow this guide to configure cross-domain requests (CORS) to objects in the {{ objstorage-name }} bucket.
---

# Configuring CORS

{{ objstorage-name }} allows you to manage [CORS configurations](../../concepts/cors.md) in the bucket.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you want to configure CORS for.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
  1. Select the **{{ ui-key.yacloud.storage.bucket.switch_cors }}** tab.
  1. Click **{{ ui-key.yacloud.storage.bucket.cors.button_cors_empty-create }}**.
  1. Fill out the form that opens. You can add, delete, and edit configuration rules.
     
     {% include [storage-cors-create-rule](../../_includes_service/storage-cors-create-rule.md) %}
  
     For a detailed description of the configuration fields, see [{#T}](../../s3/api-ref/cors/xml-config.md).

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to update a bucket:

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
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

  1. Using the `NAME` column, save the name of the bucket to set up the CORS configuration in.
  1. Run this command:

      ```bash
      yc storage bucket update \
        --name <bucket_name> \
        --cors <CORS_parameter>='[<set_of_values>]',<CORS_parameter>='[<set_of_values>]',...
      ```

      Where:
      * `--name`: Name of the bucket to set up the CORS configuration in.
      * `--cors`: CORS parameters:
        * `allowed-methods`: List of methods. Possible values: `method-get`, `method-put`, `method-post`, `method-delete`, and `method-head`. This is a required parameter.
        * `allowed-origins`: List of websites that allow sending cross-domain requests to a bucket. This is a required parameter.
        * `allowed-headers`: List of allowed headers. This is an optional parameter.
        * `expose-headers`: List of headers that can be displayed in a JavaScript app in the browser. This is an optional parameter.
        * `max-age-seconds`: Time in seconds during which the browser caches the results of requests to an object. This is an optional parameter.

        Parameter values are specified in quotes and square brackets. List items in values are separated by commas with no spaces. For example, `--cors allowed-methods='[method-get,method-head]',allowed-origins='[example.com]'`.

        Permissions specified in the command override the current CORS settings of the bucket. You can retrieve the current permissions using the `yc storage bucket get <bucket_name> --full` command.

        Result:

        ```text
        name: first-bucket
        folder_id: b1gmit33ngp6********
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

- AWS CLI {#aws-cli}

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

     When ready, you can save your configuration into a file, e.g., `cors.json`.

  1. Upload the configuration to the bucket, e.g., `shared-bucket`:

     ```bash
     aws s3api put-bucket-cors \
       --bucket shared-bucket \
       --cors-configuration file://cors.json \
       --endpoint-url=https://{{ s3-storage-host }}
     ```

- {{ TF }} {#tf}

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Retrieve [static access keys](../../../iam/operations/sa/create-access-key.md): a static key and a key ID used to authenticate in {{ objstorage-short-name }}.

  1. In the configuration file, describe the parameters of the resources you want to create:


     ```hcl
     provider "yandex" {
       cloud_id  = "<cloud_ID>"
       folder_id = "<folder_ID>"
       zone      = "<availability_zone>"
       token     = "<OAuth_token>"
       }

     resource "yandex_iam_service_account" "sa" {
       name = "<service_account_name>"
     }

     // Assigning a role to a service account
     resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
       folder_id = "<folder_ID>"
       role      = "storage.admin"
       member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
     }

     // Creating a static access key
     resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
       service_account_id = yandex_iam_service_account.sa.id
       description        = "static access key for object storage"
     }

     resource "yandex_storage_bucket" "b" {
       bucket = "s3-website-test.hashicorp.com"
       acl    = "public-read"

       access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
       secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key

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

     * `access_key`: Static access key ID.
     * `secret_key`: Secret access key value.
     * `bucket`: Bucket name. This is a required parameter.
     * `acl`: Applied ACL policy. This is an optional parameter.

     `CORS` parameters:
     * `allowed_headers`: Allowed headers. This is an optional parameter.
     * `allowed_methods`: Allowed methods. The possible values are `GET`, `PUT`, `POST`, `DELETE` or `HEAD`. This is a required parameter.
     * `allowed_origins`: Website that allows sending cross-domain requests to a bucket. This is a required parameter.
     * `expose_headers`: Header that can be displayed in a JavaScript app in the browser. This is an optional parameter. 
     * `max_age_seconds`: Time in seconds during which the browser caches the results of requests to an object. This is an optional parameter.
     * `server_side_encryption_configuration`: Bucket encryption settings on the server side. This is an optional parameter.

     For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

  1. Make sure the configuration files are correct.
     1. In the command line, go to the folder where you created the configuration file.
     1. Run a check using this command:

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

     All the resources you need will then be created in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

- API {#api}

  To manage CORS configurations for buckets, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../api-ref/grpc/Bucket/update.md) gRPC API call, or the [upload](../../s3/api-ref/cors/upload.md) S3 API method.

{% endlist %}
