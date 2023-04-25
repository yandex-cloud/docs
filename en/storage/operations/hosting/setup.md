# Hosting setup

{{ objstorage-name }} allows you to configure a bucket:

* For [static website hosting](#hosting).
* To [redirect all requests](#redirects).
* For [conditionally redirecting requests](#redirects-on-conditions).

## Static website hosting {#hosting}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the bucket you want to configure hosting for.
   1. Make sure public access is allowed to the bucket. If not, follow the instructions in [{#T}](../buckets/bucket-availability.md).
   1. In the left-hand panel, select **{{ ui-key.yacloud.storage.bucket.switch_website }}**.
   1. Under **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}**, specify:
      * Website home page.
      * Page to display to the user in the event of 4xx errors. This is optional.
   1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

- {{ yandex-cloud }} CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to set up static website hosting in a bucket:

      ```bash
      yc storage bucket update --help
      ```

   1. Create a hosting configuration file in JSON format. For example:

      ```json
      {
        "index": "index.html",
        "error": "error404.html"
      }
      ```

      Where:
      * `index`: Absolute path to the file of the website home page.
      * `error`: Absolute path to the file to display to the user in the event of 4xx errors.

   1. Run the following command:

      ```bash
      yc storage bucket update --name <bucket_name> \
        --website-settings-from-file <hosting_configuration_file_path>
      ```

      Where:
      * `--name`: Bucket name.
      * `--website-settings-from-file`: Path to the hosting configuration file.

      Result:

      ```text
      name: my-bucket
      folder_id: b1gjs8dck8bvb10chmjf
      default_storage_class: STANDARD
      versioning: VERSIONING_SUSPENDED
      max_size: "10737418240"
      acl: {}
      created_at: "2022-12-14T08:42:16.273717Z"
      ```

   To make sure the bucket description now contains the hosting settings, run this command:

   ```bash
   yc storage --name <bucket_name> bucket get --full
   ```

   Result:

   ```text
   website_settings:
     index: index.html
     error: error404.html
     redirect_all_requests: {}
   ```

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   Before you start, retrieve the [static access keys](../../../iam/operations/sa/create-access-key.md): a secret key and a key ID used for authentication in {{ objstorage-short-name }}.

   1. In the configuration file, describe the parameters of the resources you want to create:

      
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
        bucket     = "<bucket name>"
        acl        = "public-read"

        website {
          index_document = "index.html"
          error_document = "error.html"
        }

      }
      ```



      Where:

      * `access_key`: ID of the static access key.
      * `secret_key`: Value of the secret access key.
      * `bucket`: Bucket name.
      * `acl`: Parameters for [ACL](../../concepts/acl.md#predefined-acls).
      * `website`: Website parameters:
         * `index_document`: Absolute path to the file of the website home page. This parameter is required.
         * `error_document`: Absolute path to the file to be displayed to the user in the event of `4xx` errors. This is an optional parameter.

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

      ```
      terraform apply
      ```

      1. Confirm that you want to create the resources.

      Once you are done, all the resources you need will be created in the specified folder. You can check that the resources are there and their settings are correct using the [management console]({{ link-console-main }}).

- API

   To set up hosting for a static website, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update) gRPC API call, or the [upload](../../s3/api-ref/hosting/upload.md) S3 API method.

{% endlist %}

## Redirect all requests {#redirects}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the bucket you wish to configure redirection for.
   1. Make sure public access is allowed to the bucket. If not, follow the instructions in [{#T}](../buckets/bucket-availability.md).
   1. In the left-hand panel, select **{{ ui-key.yacloud.storage.bucket.switch_website }}**.
   1. Under **{{ ui-key.yacloud.storage.bucket.website.switch_redirect }}**, specify:
      * Domain name of the host to act as the redirect target for all requests to the current bucket.
      * Protocol if the specified host accepts requests only over a specific protocol.

- {{ yandex-cloud }} CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to set up a redirect for all requests:

      ```bash
      yc storage bucket update --help
      ```

   1. Create a file with redirect settings in JSON format. For example:

      ```json
      {
        "redirectAllRequests": {
          "protocol": "PROTOCOL_HTTP",
          "hostname": "example.com"
        }
      }
      ```

      Where:
      * `protocol`: Data transfer protocol (`PROTOCOL_HTTP` or `PROTOCOL_HTTPS`). By default, the original request's protocol is used.
      * `hostname`: Domain name of the host to act as the redirect target for all requests to the current bucket.

   1. Run the following command:

      ```bash
      yc storage bucket update --name <bucket_name> \
        --website-settings-from-file <redirect_configuration_file_path>
      ```

      Where:
      * `--name`: Bucket name.
      * `--website-settings-from-file`: Path to the redirect configuration file.

      Result:

      ```text
      name: my-bucket
      folder_id: b1gjs8dck8bvb10chmjf
      default_storage_class: STANDARD
      versioning: VERSIONING_SUSPENDED
      max_size: "10737418240"
      acl: {}
      created_at: "2022-12-14T08:42:16.273717Z"
      ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   
   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


   To set up a redirect for all requests:

   1. Open the {{ TF }} configuration file and add the `redirect_all_requests_to` parameter to the `yandex_storage_bucket` resource description.

      ```hcl
      ...
      resource "yandex_storage_bucket" "test" {
        access_key = "<static_key_ID>"
        secret_key = "<secret_key>"
        bucket     = "<bucket_name>"
        acl        = "public-read"

        website {
          index_document = "<absolute_path_to_website_homepage_file>"
          error_document = "<absolute_path_to_error_file>"
      	 redirect_all_requests_to = "<host_name>"
        }
      }
      ...
      ```

      Where:
      * `access_key`: ID of the static access key.
      * `secret_key`: Value of the secret access key.
      * `bucket`: Bucket name.
      * `acl`: Parameters for [ACL](../../concepts/acl.md#predefined-acls).
      * `website`: Website parameters:
         * `index_document`: Absolute path to the file of the website's homepage. This parameter is required.
         * `error_document`: Absolute path to the file to be displayed to the user in the event of `4xx` errors. This is an optional parameter.
         * `redirect_all_requests_to`: Domain name of the host to act as the redirect target for all requests to the current bucket. You can set a protocol prefix (`http://` or `https://`). By default, the original request's protocol is used.

      For more information about the `yandex_storage_bucket` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}//storage_bucket#static-website-hosting).

   1. Check the configuration using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can use the [management console]({{ link-console-main }}) to check the request redirect settings.

- API

   To set up a redirect for all bucket requests, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update) gRPC API call, or the [upload](../../s3/api-ref/hosting/upload.md) S3 API method.

{% endlist %}

## Conditional request redirection {#redirects-on-conditions}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the bucket you wish to configure conditional request redirects for.
   1. Make sure public access is allowed to the bucket. If not, follow the instructions in [{#T}](../buckets/bucket-availability.md).
   1. In the left-hand panel, select **{{ ui-key.yacloud.storage.bucket.switch_website }}**.
   1. Under **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}**, add a redirect rule with the redirect condition and the new address.
      * Condition. For example, you can do a redirect when you receive a specified response code or if the beginning of the object key in a request matches the specified key.
      * Redirection:
         * Domain name of the host where the requests satisfying the condition should be redirected.
         * The protocol to use to send redirected requests.
         * Response code to determine the redirect type.
         * Replace the entire key specified in the condition or its initial sequence only.

- {{ yandex-cloud }} CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to set up a conditional redirect of requests:

      ```bash
      yc storage bucket update --help
      ```

   1. Create a file with conditional redirect settings in JSON format. For example:

      ```json
      {
        "routingRules": [
          {
            "condition": {
              "httpErrorCodeReturnedEquals": "404",
              "keyPrefixEquals": "key"
            },
            "redirect": {
              "hostname": "example.com",
              "httpRedirectCode": "301",
              "protocol": "PROTOCOL_HTTP",
              "replaceKeyPrefixWith": "prefix",
              "replaceKeyWith": "key"
            }
          }
        ]
      }
      ```

      Where:
      * `condition`: Condition to trigger a redirect:

         * `httpErrorCodeReturnedEquals`: HTTP response code.
         * `keyPrefixEquals`: Object key prefix.

      * `redirect`: Redirect settings:

         * `hostname`: Domain name of the host to act as the redirect target for all requests to the current bucket.
         * `httpRedirectCode`: New HTTP response code.
         * `protocol`: New data transfer protocol (`PROTOCOL_HTTP` or `PROTOCOL_HTTPS`). By default, the original request's protocol is used.
         * `replaceKeyPrefixWith`: New object key prefix.
         * `replaceKeyWith`: New object key.

   1. Run the following command:

      ```bash
      yc storage bucket update --name <bucket_name> \
        --website-settings-from-file <conditional_redirect_configuration_file_path>
      ```

      Where:
      * `--name`: Bucket name.
      * `--website-settings-from-file`: Path to the conditional redirect configuration file.

      Result:

      ```text
      name: my-bucket
      folder_id: b1gjs8dck8bvb10chmjf
      default_storage_class: STANDARD
      versioning: VERSIONING_SUSPENDED
      max_size: "10737418240"
      acl: {}
      created_at: "2022-12-14T08:42:16.273717Z"
      ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   
   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


   To set up a conditional redirect of requests:

   1. Open the {{ TF }} configuration file and add the `routing_rules` parameter to the bucket description:

      ```hcl
      ...
      resource "yandex_storage_bucket" "test" {
        access_key = "<static_key_ID>"
        secret_key = "<secret_key>"
        bucket     = "<bucket_name>"
        acl        = "public-read"

        website {
          index_document = "<absolute_path_to_website_homepage_file>"
          error_document = "<absolute_path_to_error_file>"
      	 routing_rules            = <<EOF
          [
            {
              "Condition": {
                "KeyPrefixEquals": "<object_key_prefix>",
                "HttpErrorCodeReturnedEquals": "<HTTP_response_code>"
              },
              "Redirect": {
                "Protocol": "<new_schema>",
                "HostName": "<new_domain_name>",
                "ReplaceKeyPrefixWith": "<new_object_key_prefix>",
                "ReplaceKeyWith": "<new_object_key>",
                "HttpRedirectCode": "<new_HTTP_response_code>"
              }
            },
          ...
          ]
          EOF
        }
      }
      ...
      ```

      Where:
      * `access_key`: ID of the static access key.
      * `secret_key`: Value of the secret access key.
      * `bucket`: Bucket name.
      * `acl`: Parameters for [ACL](../../concepts/acl.md#predefined-acls).
      * `website`: Website parameters:
         * `index_document`: Absolute path to the file of the website's homepage. This parameter is required.
         * `error_document`: Absolute path to the file to be displayed to the user in the event of `4xx` errors. This is an optional parameter.
         * `routing_rules`: Rules for redirecting requests in JSON format. Each rule's `Condition` and `Redirect` fields must contain at least one <q>key-value</q> pair. For more information about the supported fields, see the [data schema](../../s3/api-ref/hosting/upload.md#request-scheme) of the respective API method (the **For conditionally redirecting requests** tab).

      For more information about the `yandex_storage_bucket` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}//storage_bucket#static-website-hosting).

   1. Check the configuration using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can use the [management console]({{ link-console-main }}) to check the settings for conditionally redirecting requests.

- API

   To set up a conditional redirect of bucket requests, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update) gRPC API call, or the [upload](../../s3/api-ref/hosting/upload.md) S3 API method.

{% endlist %}
