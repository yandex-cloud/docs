---
title: Setting up hosting in {{ objstorage-full-name }}
description: Follow this guide to set up static website hosting in {{ objstorage-name }}.
---

# Setting up hosting


{% include [static-site-information](../../../_includes/storage/static-site-information.md) %}

{{ objstorage-name }} buckets support:

* [Static website hosting](#hosting).
* [Redirects for all requests](#redirects).
* [Conditional request redirects](#redirects-on-conditions).

## Static website hosting {#hosting}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [hosting-setup-console](../../../_includes/storage/hosting-setup-console.md) %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for setting up static website hosting in a bucket:

     ```bash
     yc storage bucket update --help
     ```
     
  1. Create a hosting configuration file in JSON format. Here is an example:
     
     ```json
     {
       "index": "index.html",
       "error": "error404.html"
     }
     ```

     Where:

     * `index`: Absolute path to the website home page file.

       {% include [static-site-index-restriction](../../../_includes/storage/static-site-index-restriction.md) %}

     * `error`: Absolute path to the file the user will see in case of 4xx errors.
  
  1. Run this command:

     ```bash
     yc storage bucket update --name <bucket_name> \
       --website-settings-from-file <path_to_file>
     ```
     
     Where:
     * `--name`: Bucket name.
     * `--website-settings-from-file`: Path to the hosting configuration file.

     Result:

     ```text
     name: my-bucket
     folder_id: b1gjs8dck8bv********
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

- {{ TF }} {#tf}

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Before you start, retrieve the [static access keys](../../../iam/operations/authentication/manage-access-keys.md#create-access-key): a secret key and key ID used for {{ objstorage-short-name }} authentication.

  {% include [terraform-iamtoken-note](../../../_includes/storage/terraform-iamtoken-note.md) %}

  1. In the configuration file, describe the parameters of resources you want to create:

     ```hcl
     provider "yandex" {
       token     = "<OAuth>"
       cloud_id  = "<cloud_ID>"
       folder_id = "<folder_ID>"
       zone      = "{{ region-id }}-a"
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

     resource "yandex_storage_bucket" "test" {
       access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
       secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
       bucket     = "<bucket_name>"
       acl        = "public-read"
     
       website {
         index_document = "index.html"
         error_document = "error.html"
       }
     
     }
     ```

     Where:

     * `access_key`: Static access key ID.
     * `secret_key`: Secret access key value.
     * `bucket`: Bucket name.
     * `acl`: [ACL](../../concepts/acl.md#predefined-acls) access management parameters.
     * `website`: Website parameters:
       * `index_document`: Absolute path to the website home page file. This is a required parameter.

         {% include [static-site-index-restriction](../../../_includes/storage/static-site-index-restriction.md) %}

       * `error_document`: Absolute path to the file the user will see in case of 4xx errors. This is an optional parameter.

  1. Make sure the configuration files are correct.

     1. In the command line, navigate to the directory where you created the configuration file.
     1. Run a check using this command:

        ```
        terraform plan
        ```

     If the configuration description is correct, the terminal will display a list of the resources being created and their settings. If the configuration contains any errors, {{ TF }} will point them out. 

  1. Deploy the cloud resources.

     1. If the configuration does not contain any errors, run this command:

     ```
     terraform apply
     ```
   
     1. Confirm creating the resources.

     This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

- API {#api}

  To set up static website hosting, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../api-ref/grpc/Bucket/update.md) gRPC API call, or the [upload](../../s3/api-ref/hosting/upload.md) S3 API method.

{% endlist %}

## Redirects for all requests {#redirects}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you want to configure request redirects for.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Select the **{{ ui-key.yacloud.storage.bucket.switch_website }}** tab.
  1. Under **{{ ui-key.yacloud.storage.bucket.website.switch_redirect }}**, specify:
      * **{{ ui-key.yacloud.storage.bucket.website.field_hostname }}** of the host to act as the redirect target for all requests to the bucket.
      * Optionally, **{{ ui-key.yacloud.storage.bucket.website.field_protocol }}** if the specified host accepts requests only over a specific protocol.
  1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for setting up redirects for all requests:

     ```bash
     yc storage bucket update --help
     ```
     
  1. Create a redirect configuration file in JSON format. For example:
     
     ```json
     {
       "redirectAllRequests": {
         "protocol": "PROTOCOL_HTTP",
         "hostname": "example.com"
       }
     }
     ```

     Where:
     * `protocol`: Data transfer protocol, `PROTOCOL_HTTP` or `PROTOCOL_HTTPS`. By default, the original request protocol is used.
     * `hostname`: Domain name of the host to act as the redirect target for all requests to the current bucket.
  
  1. Run this command:

     ```bash
     yc storage bucket update --name <bucket_name> \
       --website-settings-from-file <path_to_file>
     ```

     Where:
     * `--name`: Bucket name.
     * `--website-settings-from-file`: Path to the redirect configuration file.

     Result:

     ```text
     name: my-bucket
     folder_id: b1gjs8dck8bv********
     default_storage_class: STANDARD
     versioning: VERSIONING_SUSPENDED
     max_size: "10737418240"
     acl: {}
     created_at: "2022-12-14T08:42:16.273717Z"
     ```

- {{ TF }} {#tf}
 
  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}


  To set up a redirect for all requests:

  1. Open the {{ TF }} configuration file and add the `redirect_all_requests_to` property to the `yandex_storage_bucket` description:

     ```hcl
     ...
     resource "yandex_storage_bucket" "test" {
       access_key = "<static_key_ID>"
       secret_key = "<secret_key>"
       bucket     = "<bucket_name>"
       acl        = "public-read"
     
       website {
         index_document = "<absolute_path_to_website_home_page_file>"
         error_document = "<absolute_path_to_error_file>"
		 redirect_all_requests_to = "<host_name>"
       }
     }
     ...
     ```

     Where:
     * `access_key`: Static access key ID.

        {% include [terraform-iamtoken-note](../../../_includes/storage/terraform-iamtoken-note.md) %}

     * `secret_key`: Secret access key value.
     * `bucket`: Bucket name.
     * `acl`: [ACL](../../concepts/acl.md#predefined-acls) access management parameters.
     * `website`: Website parameters:
       * `index_document`: Absolute path to the website home page file. This is a required parameter.
       * `error_document`: Absolute path to the file the user will see in case of 4xx errors. This is an optional parameter.
       * `redirect_all_requests_to`: Domain name of the host to act as the redirect target for all requests to the current bucket. You can specify a protocol prefix (`http://` or `https://`). By default, the original request protocol is used.

     For more information about the `yandex_storage_bucket` resource parameters in {{ TF }}, see [this TF provider article]({{ tf-provider-resources-link }}/storage_bucket#static-website-hosting).

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
  
     You will see a detailed list of resources. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will show them.

  1. Apply the changes:

     ```bash
     terraform apply
     ```
     
  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     You can use the [management console]({{ link-console-main }}) to check the request redirect settings.

- API {#api}

  To set up redirects for all requests to a bucket, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../api-ref/grpc/Bucket/update.md) gRPC API call, or the [upload](../../s3/api-ref/hosting/upload.md) S3 API method.

{% endlist %}

{% include [redirect-https](../../../_includes/storage/redirect-https.md) %}

## Conditional request redirects {#redirects-on-conditions}

With routing rules, you can redirect requests based on the object name prefixes or HTTP response codes. This enables you to redirect object requests to different web pages (if the object was removed) or redirect the requests that return errors.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you want to configure conditional request redirects for.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Select the **{{ ui-key.yacloud.storage.bucket.switch_website }}** tab.
  1. In **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}**, under **{{ ui-key.yacloud.storage.bucket.website.title_redirect }}**, click **{{ ui-key.yacloud.storage.bucket.website.button_add-routing-rule }}**.
  1. Under **{{ ui-key.yacloud.storage.bucket.website.label_routing-condition }}**, specify at least one condition for redirects:
      * **{{ ui-key.yacloud.storage.bucket.website.field_http-redirect-code }}**: HTTP code that {{ objstorage-name }} would have returned for the request without a redirect.
      * **{{ ui-key.yacloud.storage.bucket.website.select_condition_prefix }}**: Object key prefix in the request. You can learn more about keys and how static websites work [here](#static-site-information).
  1. Under **{{ ui-key.yacloud.storage.bucket.website.label_routing-redirect }}**, set the following redirect parameters:
      * **{{ ui-key.yacloud.storage.bucket.website.field_protocol }}** to use for sending redirected requests.
      * **{{ ui-key.yacloud.storage.bucket.website.field_host-name }}** of the host to which all requests meeting the specified condition will be redirected.
      * **{{ ui-key.yacloud.storage.bucket.website.field_http-redirect-code }}** to determine the redirect type.
      * **{{ ui-key.yacloud.storage.bucket.website.field_redirect_change }}**: **{{ ui-key.yacloud.storage.bucket.website.select_redirect_none }}**, **{{ ui-key.yacloud.storage.bucket.website.select_redirect_key }}**, or **{{ ui-key.yacloud.storage.bucket.website.select_redirect_prefix }}**, specified in the condition.
  1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.
  
- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for setting up conditional request redirects:

     ```bash
     yc storage bucket update --help
     ```
     
  1. Create a conditional redirect configuration file in JSON format. Here is an example:
     
     ```json
     {
       "index": "index.html",
       "error": "error404.html",
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
     * `index`: Absolute path to the website home page file. This is a required parameter.

         {% note info %}

         You need to provide the absolute path to the homepage file with conditional redirection settings, even if this parameter is already set for the bucket.

         {% endnote %}

     * `error`: Absolute path to the file the user will see in case of 4xx errors. This is an optional parameter.
     * `condition`: Condition to trigger a redirect:
     
       * `httpErrorCodeReturnedEquals`: HTTP response code.
       * `keyPrefixEquals`: Object key prefix.
       
     * `redirect`: Redirect settings:
     
       * `hostname`: Domain name of the host to act as the redirect target for all requests to the current bucket.
       * `httpRedirectCode`: New HTTP response code.
       * `protocol`: New data transfer protocol, `PROTOCOL_HTTP` or `PROTOCOL_HTTPS`. By default, the original request protocol is used. 
       * `replaceKeyPrefixWith`: New object key prefix.
       * `replaceKeyWith`: New object key.
  
  1. Run this command:

     ```bash
     yc storage bucket update --name <bucket_name> \
       --website-settings-from-file <path_to_file>
     ```

     Where:
     * `--name`: Bucket name.
     * `--website-settings-from-file`: Path to the conditional redirect configuration file.

     Result:

     ```text
     name: my-bucket
     folder_id: b1gjs8dck8bv********
     default_storage_class: STANDARD
     versioning: VERSIONING_SUSPENDED
     max_size: "10737418240"
     acl: {}
     created_at: "2022-12-14T08:42:16.273717Z"
     ```

- {{ TF }} {#tf}
 
  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    
  {% include [terraform-install](../../../_includes/terraform-install.md) %}


  To set up conditional request redirects:

  1. Open the {{ TF }} configuration file and add the `routing_rules` parameter to the bucket description:

     ```hcl
     ...
     resource "yandex_storage_bucket" "test" {
       access_key = "<static_key_ID>"
       secret_key = "<secret_key>"
       bucket     = "<bucket_name>"
       acl        = "public-read"
     
       website {
         index_document = "<absolute_path_to_website_home_page_file>"
         error_document = "<absolute_path_to_error_file>"
         routing_rules  = <<EOF
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
     * `access_key`: Static access key ID.

        {% include [terraform-iamtoken-note](../../../_includes/storage/terraform-iamtoken-note.md) %}

     * `secret_key`: Secret access key value.
     * `bucket`: Bucket name.
     * `acl`: [ACL](../../concepts/acl.md#predefined-acls) access management parameters.
     * `website`: Website parameters:
       * `index_document`: Absolute path to the website home page file. This is a required parameter.
       * `error_document`: Absolute path to the file the user will see in case of 4xx errors. This is an optional parameter.
       * `routing_rules`: Rules for redirecting requests in JSON format. Each rule's `Condition` and `Redirect` fields must contain at least one <q>key-value</q> pair. For more information about the supported fields, see the [data schema](../../s3/api-ref/hosting/upload.md#request-scheme) of the relevant API method (the **For conditionally redirecting requests** tab).

     For more information about the `yandex_storage_bucket` resource parameters in {{ TF }}, see [this TF provider article]({{ tf-provider-resources-link }}/storage_bucket#static-website-hosting).

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
  
     You will see a detailed list of resources. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will show them.

  1. Apply the changes:

     ```bash
     terraform apply
     ```
     
  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     You can use the [management console]({{ link-console-main }}) to check the settings for conditionally redirecting requests.
        
- API {#api}

  To set up conditional redirects for bucket requests, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../api-ref/grpc/Bucket/update.md) gRPC API call, or the [upload](../../s3/api-ref/hosting/upload.md) S3 API method.

{% endlist %}

{% include [redirect-https](../../../_includes/storage/redirect-https.md) %}

#### See also {#see-also}

* [{#T}](own-domain.md)
* [{#T}](multiple-domains.md)
* [{#T}](certificate.md)