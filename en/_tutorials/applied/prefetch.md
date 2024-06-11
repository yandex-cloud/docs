# Publishing game updates using {{ cdn-full-name }}


Create and configure a {{ cdn-name }} [CDN resource](../../cdn/concepts/resource.md) to host content that is expected to handle a large number of requests over a short period of time, such as game update files (patches, [DLC](https://en.wikipedia.org/wiki/Downloadable_content), etc.). To prevent CDN servers from increasing the workload on the content origins during this period, files will be [preloaded](../../cdn/concepts/caching.md#prefetch) to the server cache once.

Let's assume a patch is a single file named `ycgame-update-v1.1.exe`. It will be uploaded to a [{{ objstorage-full-name }}](../../storage/) [bucket](../../storage/concepts/bucket.md).

{% note info %}

We do not recommend preloading files smaller than 200 MB or larger than 5 GB.

{% endnote %}

To create a CDN infrastructure:
1. [Get things ready](#before-you-begin).
1. [Add a certificate to {{ certificate-manager-name }}](#add-certificate)
1. [Create buckets in {{ objstorage-name }}](#create-buckets).
1. [Enable logging for the bucket with files](#enable-logging).
1. [Upload a file to the bucket](#upload-object).
1. [Create a CDN resource and enable caching](#create-cdn-resource).
1. [Set up DNS for your domain](#dns-setup).
1. [Preload content to the cache of CDN servers](#prefetch-content).
1. [Test the CDN](#check-cdn-working).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Make sure you have a domain name and can access the DNS settings on the website of your DNS hosting provider. This is usually the company that registered your domain.


### Required paid resources {#paid-resources}

The cost of supporting the CDN infrastructure includes:
* Fee for outgoing traffic from CDN servers (see [{{ cdn-name }} pricing](../../cdn/pricing.md)).
* Fee for data storage in {{ objstorage-name }}, operations with data, and outgoing traffic (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* Fee for public DNS queries and [DNS zones](../../dns/concepts/dns-zone.md) if using [{{ dns-full-name }}](../../dns/) (see [{{ dns-name }} pricing](../../dns/pricing.md)).

## Add a certificate to {{ certificate-manager-name }} {#add-certificate}

{% include [certificate-usage](../../_includes/cdn/certificate-usage.md) %}

For a Let's Encrypt® certificate, have your [rights checked](../../certificate-manager/operations/managed/cert-validate.md) for the domain specified in the certificate.


## Create buckets in {{ objstorage-name }} {#create-buckets}

Create two buckets: one will store files and the other will store request logs for the first one.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. Create a bucket for files:
      1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
      1. Enter a **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** for the bucket.
      1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** and **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** fields, select `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`.
      1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.
   1. Create a bucket for logs:
      1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
      1. Enter a **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** for the bucket.
      1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- AWS CLI {#cli}

   1. Create a bucket for files:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }} \
        s3api create-bucket \
        --bucket <name_of_bucket_with_files> \
        --acl public-read
      ```

      Result:

      ```json
      {
        "Location": "/<name_of_bucket_with_files>"
      }
      ```

   1. Create a bucket for logs:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }} \
        s3api create-bucket \
        --bucket <name_of_bucket_with_logs>
      ```

      Result:

      ```json
      {
        "Location": "/<name_of_bucket_with_logs>"
      }
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   Before you start, obtain [static access keys](../../iam/operations/sa/create-access-key.md), i.e., a [secret key and key ID](../../iam/concepts/authorization/access-key.md) used for authentication in {{ objstorage-name }}.
   1. In the configuration file, describe the bucket parameters:
      * `access_key`: ID of the static access key.
      * `secret_key`: Secret access key value.
      * `bucket`: Name of the bucket you are creating.

      Here is an example of the configuration file structure:

      
      ```hcl
      provider "yandex" {
        token     = "<OAuth_token>"
        cloud_id  = "<cloud_ID>"
        folder_id = "<folder_ID>"
        zone      = "{{ region-id }}-a"
      }

      resource "yandex_storage_bucket" "storage" {
        access_key = "<static_key_ID>"
        secret_key = "<secret_key>"
        bucket     = "<name_of_bucket_with_files>"
        acl        = "public-read"
      }

      resource "yandex_storage_bucket" "logs" {
        access_key = "<static_key_ID>"
        secret_key = "<secret_key>"
        bucket     = "<name_of_bucket_with_logs>"
      }
      ```



   1. Make sure that the configuration files are correct:
      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display the parameters of the bucket being created. If the configuration contains any errors, {{ TF }} will point them out.
   1. Deploy the bucket:
      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the bucket.

- API {#api}

   Use the API [create](../../storage/s3/api-ref/bucket/create.md) method.

{% endlist %}

## Enable logging for the bucket with files {#enable-logging}

Make sure that, when a user sends a request, files are downloaded from the CDN server cache rather than directly from the bucket. To do this, enable bucket logging.

{% list tabs group=instructions %}

- AWS CLI {#cli}

   1. Create a file with logging settings in JSON format. Here is an example:

      ```json
      {
        "LoggingEnabled": {
            "TargetBucket": "<name_of_bucket_with_logs>",
            "TargetPrefix": "<key_prefix>"
        }
      }
      ```

      Where:

      * `TargetBucket`: Name of the target bucket for the logs.
      * `TargetPrefix`: [Prefix of the key](../../storage/concepts/server-logs.md#key-prefix) used for log objects, e.g., `logs/`.

   1. Enable logging in the bucket:

      ```bash
      aws s3api put-bucket-logging \
        --bucket <name_of_bucket_with_files> \
        --endpoint-url https://{{ s3-storage-host }} \
        --bucket-logging-status file://<path_to_settings_file>
      ```

      Where:

      * `--bucket`: Name of the source bucket to enable action logging for.
      * `--bucket-logging-status`: Path to the logging settings file.

- API {#api}

   Use the [putBucketLogging](../../storage/s3/api-ref/bucket/putBucketLogging.md) API method for the bucket with files. HTTP request body:

   ```xml
   <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01">
     <LoggingEnabled>
       <TargetBucket>name of bucket with logs</TargetBucket>
       <TargetPrefix>key prefix</TargetPrefix>
     </LoggingEnabled>
   </BucketLoggingStatus>
   ```

   Where:

   * `TargetBucket`: Name of the bucket for the logs.
   * `TargetPrefix`: [Prefix of the key](../../storage/concepts/server-logs.md#key-prefix) used for log objects, e.g., `logs/`.

{% endlist %}

## Upload a file to the bucket {#upload-object}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. Select the bucket with files.
   1. Click **{{ ui-key.yacloud.storage.bucket.button_upload }}**.
   1. In the window that opens, select the `ycgame-update-v1.1.exe` patch file and click **{{ ui-key.yacloud.common.open }}**.
   1. Click **{{ ui-key.yacloud.storage.button_upload }}**.

- AWS CLI {#cli}

   Run this command:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
     s3 cp \
     <path_to_ycgame-update-v1.1.exe> \
     s3://<name_of_bucket_with_files>/ycgame-update-v1.1.exe
   ```

   Result:

   ```text
   upload: <ycgame-update-v1.1.exe_file_path> to s3://<name_of_bucket_with_files>/ycgame-update-v1.1.exe
   ```

- {{ TF }} {#tf}

   1. Add the parameters of the [object](../../storage/concepts/object.md) to upload to the configuration file you created in the [bucket creation step](#create-buckets):
      * `bucket`: Name of the bucket to add the object to.
      * `key`: Name of the object in the bucket (`ycgame-update-v1.1.exe`). This is a required parameter.
      * `source`: Relative or absolute path to the file that you upload as an object.

      Here is an example of the configuration file structure:

      ```hcl
      ...
      resource "yandex_storage_object" "patch-v1-1" {
        access_key = "<static_key_ID>"
        secret_key = "<private_key>"
        bucket = "<name_of_bucket_with_files>"
        key    = "ycgame-update-v1.1.exe"
        source = "<path_to_file>/ycgame-update-v1.1.exe"
      }
      ```

   1. Make sure the configuration files are correct.
      1. In the command line, go to the directory with the configuration file.
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

      1. Confirm that you want to create the object.

- API {#api}

   Use the API [upload](../../storage/s3/api-ref/object/upload.md) method.

{% endlist %}

## Create a CDN resource and enable caching {#create-cdn-resource}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
   1. {% include [activate-provider](../../_includes/cdn/activate-provider.md) %}

   1. Create a CDN resource:
      1. In the ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.cdn.label_resources-list }}** tab, click **{{ ui-key.yacloud.cdn.button_resource-create }}**.
      1. Set up the main parameters of the CDN resource as follows:
         * **{{ ui-key.yacloud.cdn.label_content-query-type }}**: `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}`.
         * **{{ ui-key.yacloud.cdn.label_source-type }}**: `{{ ui-key.yacloud.cdn.value_source-type-bucket }}`.
         * **{{ ui-key.yacloud.cdn.label_bucket }}**: `<Name_of_bucket_with_files>`.
         * **{{ ui-key.yacloud.cdn.label_section-domain }}**: Primary domain name you will use to publish patches, e.g., `cdn.ycprojectblue.example`.

            {% note alert %}

            You cannot change the primary domain name used for content distribution after creating a CDN resource.

            {% endnote %}

         * Under **{{ ui-key.yacloud.cdn.label_section-additional }}**:
            * In the **{{ ui-key.yacloud.cdn.label_protocol }}** field, select `{{ ui-key.yacloud.common.label_https }}`.
            * In the **{{ ui-key.yacloud.cdn.label_redirect }}** field, select `{{ ui-key.yacloud.cdn.value_do-not-use }}`.
            * Select **{{ ui-key.yacloud.cdn.field_access }}**.
            * In the **{{ ui-key.yacloud.cdn.label_certificate-type }}** field, specify `{{ ui-key.yacloud.cdn.value_certificate-custom }}` and select a [certificate](#add-certificate) for the `cdn.ycprojectblue.example` domain name.
            * In the **{{ ui-key.yacloud.cdn.label_host-header }}** field, select `{{ ui-key.yacloud.cdn.value_host-header-custom }}`. In the **{{ ui-key.yacloud.cdn.label_custom-host-header }}** field, specify the origin domain name, `<name_of_bucket_with_files>.{{ s3-storage-host }}`, so that the source bucket responds to CDN server requests correctly.
      1. Click **{{ ui-key.yacloud.common.create }}**.

   1. Enable a client redirect from HTTP to HTTPS:
      1. In the ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.cdn.label_resources-list }}** tab, select the previously created resource.
      1. Make sure the certificate status under **{{ ui-key.yacloud.cdn.label_section-additional }}** changes to `{{ ui-key.yacloud.cdn.value_certificate-status-ready }}`.
      1. At the top right, click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
      1. Under **{{ ui-key.yacloud.cdn.label_section-additional }}**, select `{{ ui-key.yacloud.cdn.value_redirect-http-to-https }}` in the **{{ ui-key.yacloud.cdn.label_redirect }}** field.
      1. Click **{{ ui-key.yacloud.common.save }}**.
   1. Enable [caching](../../cdn/concepts/caching.md) on CDN servers for the resource:
      1. In the ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.cdn.label_resources-list }}** tab, select the previously created resource.
      1. Go to **{{ ui-key.yacloud.cdn.label_resource-cache }}**.
      1. At the top right, click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
      1. Enable **{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache-enabled }}**.
      1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. If the CDN provider is not activated yet, run this command:

      ```bash
      yc cdn provider activate --folder-id <folder_ID> --type gcore
      ```

   1. Create a CDN resource:

      ```bash
      yc cdn resource create \
        --cname cdn.ycprojectblue.example \
        --origin-bucket-source <name_of_bucket_with_files>.{{ s3-storage-host }} \
        --origin-bucket-name <name_of_bucket_with_files> \
        --origin-protocol https \
        --cert-manager-ssl-cert-id <certificate_ID> \
        --host-header <name_of_bucket_with_files>.{{ s3-storage-host }}
      ```

      Result:

      ```text
      id: bc8e3l7s4dha********
      folder_id: b1g86q4m5vej********
      cname: cdn.ycprojectblue.example
      ...
      active: true
      ...
      ```

      For more information about the `yc cdn resource create` command, see the [CLI reference](../../cli/cli-ref/managed-services/cdn/resource/create.md).
   1. Enable a client redirect for a resource:

      ```bash
      yc cdn resource update <resource_ID> --redirect-http-to-https
      ```

- {{ TF }} {#tf}

   1. Add parameters of the CDN resources to the configuration file:

      ```hcl
      ...
      resource "yandex_cdn_origin_group" "my_group" {
        name     = "updates-origin-group"
        use_next = true
        origin {
          source = "<name_of_bucket_with_files>.{{ s3-storage-host }}"
        }
      }

      resource "yandex_cdn_resource" "my_resource" {
        cname               = "cdn.ycprojectblue.example"
        active              = true
        origin_protocol     = "https"
        origin_group_id     = yandex_cdn_origin_group.my_group.id
        options {
          custom_host_header     = "<name_of_bucket_with_files>.{{ s3-storage-host }}"
        }
        ssl_certificate {
          type                   = "certificate_manager"
          certificate_manager_id = "<certificate_ID>"
        }
      }
      ```

      For more information, see the descriptions of the [yandex_cdn_origin_group]({{ tf-provider-resources-link }}/cdn_origin_group) and [yandex_cdn_resource]({{ tf-provider-resources-link }}/cdn_resource) resources in the {{ TF }} provider documentation.
   1. Make sure the configuration files are correct.
      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. This is a test step; no resources will be created. If the configuration contains any errors, {{ TF }} will point them out.
   1. Apply the configuration changes:
      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

      All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).
   1. Enable client redirect for a resource. Add the following field at the beginning of the `options` section for a CDN resource:

      ```hcl
      ...
      options {
        redirect_https_to_http = true
      ...
      ```

   1. Run a check using this command:

      ```bash
      terraform plan
      ```

      If the configuration is described correctly, the terminal will display a list of updated resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.
   1. If there are no errors, run this command:

      ```bash
      terraform apply
      ```

   1. Confirm the resource update: type `yes` in the terminal and press **Enter**.

   This enables a redirect for the resource.

- API {#api}

   Use the gRPC API [ResourceService/Create](../../cdn/api-ref/grpc/resource_service.md#Create) call or the REST API [create](../../cdn/api-ref/Resource/create.md) method. To enable [caching](../../cdn/concepts/caching.md) on CDN servers, add the `edge_cache_settings` field to the request body.

{% endlist %}

## Set up DNS for your domain {#dns-setup}

1. Get a domain name generated for the created CDN resource on the `.edgecdn.ru` domain:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
      1. Select the created CDN resource (the list of resources will contain its primary domain name: `cdn.ycprojectblue.example`).
      1. In the **{{ ui-key.yacloud.common.overview }}** tab, under **{{ ui-key.yacloud.cdn.label_dns-settings_title }}**, copy the name generated on the `.edgecdn.ru` domain to the clipboard.

   {% endlist %}

1. Go to your domain's DNS settings on the site of your DNS hosting provider.
1. Edit the [CNAME record](../../dns/concepts/resource-record.md#cname) for `cdn` so that it points to the previously copied URL on the `.edgecdn.ru` domain. For example:

   ```http
   cdn CNAME cl-********.edgecdn.ru.
   ```

   {% include [note-dns-aname](../../_includes/cdn/note-dns-aname.md) %}

   If you use {{ dns-name }}, follow this guide to configure the record:

   {% cut "Configuring DNS records for {{ dns-name }}" %}

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
      1. If you do not have a public DNS zone, create one:
         1. Click **{{ ui-key.yacloud.dns.button_zone-create }}**.
         1. Enter `cdn-dns-a` as a **{{ ui-key.yacloud.common.name }}** for the zone.
         1. In the **{{ ui-key.yacloud.dns.label_zone }}** field, specify your domain with a period at the end: `ycprojectblue.example.`
         1. Select a **{{ ui-key.yacloud.common.type }}** of the zone: `{{ ui-key.yacloud.dns.label_public }}`.
         1. Click **{{ ui-key.yacloud.common.create }}**.
      1. Create a [record](../../dns/concepts/resource-record.md) in the zone:
         1. In the list of zones, click `cdn-dns-a`.
         1. Click **{{ ui-key.yacloud.dns.button_record-set-create }}**.
         1. In the **{{ ui-key.yacloud.common.name }}** field, specify `cdn` to make the record match the `cdn.ycprojectblue.example` domain name.
         1. Select a **{{ ui-key.yacloud.common.type }}** for the record: `CNAME`.
         1. In the **{{ ui-key.yacloud.dns.label_records }}** field, paste the URL you copied on the `.edgecdn.ru` domain with a dot at the end.
         1. Click **{{ ui-key.yacloud.common.create }}**.

   - CLI {#cli}

      1. If you do not have a public DNS zone, create one:

         ```bash
         yc dns zone create --name cdn-dns-a --zone ycprojectblue.example. --public-visibility
         ```

         Where:
         * `--name`: Zone name
         * `--zone`: Domain zone (your domain with a dot at the end)
         * `--public-visibility`: Zone public visibility option

         Result:

         ```bash
         id: aetuvdw77q61********
         folder_id: aoewzf73jwdl********
         created_at: "2021-09-28T10:33:31.917Z"
         name: cdn-zone-a
         zone: ycprojectblue.example.
         public_visibility: {}
         ```

      1. Create a [record](../../dns/concepts/resource-record.md) in the zone:

         ```bash
         yc dns zone add-records --name cdn-dns-a --record "cdn CNAME cl-********.edgecdn.ru."
         ```

         Where:
         * `--name`: Zone name
         * `--record`: Resource record
      1. Check that the record was created:

         ```bash
         yc dns zone list-records --name cdn-dns-a
         ```

         Result:

         ```text
         +----------------------------+------+-------+------------------------------+
         |            NAME            | TTL  | TYPE  |             DATA             |
         +----------------------------+------+-------+------------------------------+
         | ycprojectblue.example.     | 3600 | NS    | ns1.{{ dns-ns-host-sld }}.         |
         |                            |      |       | ns2.{{ dns-ns-host-sld }}.         |
         | ycprojectblue.example.     | 3600 | SOA   | ns1.{{ dns-ns-host-sld }}.         |
         |                            |      |       | {{ dns-mx-host }}. 1 10800 |
         |                            |      |       | 900 604800 86400             |
         | cdn.ycprojectblue.example. |  600 | CNAME | cl-********.edgecdn.ru.      |
         +----------------------------+------+-------+------------------------------+
         ```

         The list should contain the `cdn.ycprojectblue.example.` record.

   - API {#api}

      1. If you do not have a public DNS zone, create one using a gRPC API call to [DnsZoneService/Create](../../dns/api-ref/grpc/dns_zone_service.md#Create) or the REST API [create](../../dns/api-ref/DnsZone/create.md) method. To make the zone public, add the `public_visibility` (gRPC) or `publicVisibility` (REST) field to the request body.
      1. In the zone, create a [record](../../dns/concepts/resource-record.md) named `cdn CNAME cl-********.edgecdn.ru.` using a gRPC API [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/dns_zone_service.md#UpdateRecordSets) call or the REST API [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md) method.

   {% endlist %}

   {% endcut %}

## Preload content to the cache of CDN servers {#prefetch-content}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
   1. Select the created CDN resource (the list of resources will contain its primary domain name: `cdn.ycprojectblue.example`).
   1. Go to the **{{ ui-key.yacloud.cdn.label_resource-content }}** tab.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.cdn.button_resource-content-prefetch-cache }}**.
   1. In the **{{ ui-key.yacloud.cdn.label_resource-content-prefetch-cache-paths }}** field, specify the path to the file stored in the origin, omitting the domain name:

      ```text
      /ycgame-update-v1.1.exe
      ```

   1. Click **{{ ui-key.yacloud.cdn.button_resource-content-prefetch-cache }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Specify the path to the file to pre-fetch:

   ```bash
   yc cdn cache prefetch --resource-id <resource_ID> \
     --path /ycgame-update-v1.1.exe
   ```

   For more information about the `yc cdn cache prefetch` command, see the [CLI reference](../../cli/cli-ref/managed-services/cdn/cache/prefetch.md).

- API {#api}

   Use the gRPC API [CacheService/Prefetch](../../cdn/api-ref/grpc/cache_service.md#Prefetch) call or the [prefetch](../../cdn/api-ref/Cache/prefetch.md) REST API method.

{% endlist %}

## Test the CDN {#check-cdn-working}

1. Wait until the DNS records are updated (this may take a few hours) and the file is prefetched to the CDN servers.
1. Download the file at the new URL:

   ```http request
   https://cdn.ycprojectblue.example/ycgame-update-v1.1.exe
   ```

1. Get the logs of requests to the bucket with files:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
      1. Select the bucket with the logs.
      1. Click the name of the object corresponding to the `ycgame-update-v1.1.exe` download time.
      1. Click ![image](../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.storage.file.button_download }}**.

   - AWS CLI {#cli}

      1. Get a list of objects with logs:

         ```bash
         aws --endpoint-url=https://{{ s3-storage-host }} \
           s3 ls s3://<name_of_bucket_with_logs>
         ```

         Result:

         ```text
         2021-10-01 08:37:53         10 2021-10-01-08-37-53-631E0FC3B732AEDD
         2021-10-01 09:38:05         62 2021-10-01-09-38-05-436E6CDC832A20EF
         2021-10-01 10:38:01         23 2021-10-01-10-38-01-7F65EF1A6366FB18
         2021-10-01 11:37:57         41 2021-10-01-11-37-57-6F31613427A7DB9A
         2021-10-01 12:38:02         58 2021-10-01-12-38-02-AB893E6148AFDC55
         2021-10-01 13:38:02         73 2021-10-01-13-38-02-E69EAEC1C9083756
         ```

      1. In the resulting list, find the object with the log saved after downloading `ycgame-update-v1.1.exe` and download it:

         ```bash
         aws --endpoint-url=https://{{ s3-storage-host }} \
           s3 cp s3://<name_of_bucket_with_logs>/2021-10-01-13-38-02-E69EAEC1C9083756 \
           2021-10-01-13-38-02-E69EAEC1C9083756
         ```

         Result:

         ```text
         download: s3://<name_of_bucket_with_logs>/2021-10-01-13-38-02-E69EAEC1C9083756 to 2021-10-01-13-38-02-E69EAEC1C9083756
         ```

   - API {#api}

      1. Get a list of objects in the bucket with logs using the [listObjects](../../storage/s3/api-ref/bucket/listobjects.md) API method.
      1. In the resulting list, find the object whose log was saved after downloading `ycgame-update-v1.1.exe` and download it using the API [get](../../storage/s3/api-ref/object/get.md) method.

   {% endlist %}

1. Check the logs of requests to the source bucket to make sure that the CDN servers did not download the file from the origin after your request. For more information about log contents, see the [{#T}](../../storage/concepts/server-logs.md#object-format) section of the {{ objstorage-name }} documentation.

## How to delete the resources you created {#clear-out}

To shut down your CDN resource and stop paying for the created resources:
1. [Disable](../../cdn/operations/resources/disable-resource.md) the created resource.
1. [Delete](../../storage/operations/objects/delete.md) the `ycgame-update-v1.1.exe` object from the bucket with files.
1. [Delete](../../storage/operations/buckets/delete.md) the bucket with files.
1. [Delete](../../storage/operations/objects/delete.md) all objects from the bucket with logs.
1. [Delete](../../storage/operations/buckets/delete.md) the bucket with logs.
1. [Delete](../../dns/operations/zone-delete.md) the DNS zone if you used it during [DNS setup](#dns-setup).