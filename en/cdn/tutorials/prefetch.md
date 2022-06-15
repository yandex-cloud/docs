# Publishing game updates using {{ cdn-full-name }}

This use case describes how to create and configure a {{ cdn-full-name }} [CDN resource](../concepts/resource.md) that you can place content in. This resource is expected to receive a large number of requests in a short period of time, such as files with game updates (patches, DLC, and more). To prevent CDN servers from increasing the workload on the content origins during this period, files will be [preloaded](../concepts/caching.md#prefetch) to the server cache once.

As an example, the use case assumes that a patch consists of a single file named `ycgame-update-v1.1.exe`. We'll upload it to the {{ objstorage-full-name }} bucket.

{% note info %}

We don't recommend preloading files smaller than 200 MB or larger than 5 GB.

{% endnote %}

To create a CDN infrastructure:

1. [{#T}](#before-you-begin).
1. [{#T}](#create-buckets).
1. [{#T}](#enable-logging).
1. [{#T}](#upload-object).
1. [{#T}](#create-cdn-resource).
1. [{#T}](#dns-setup).
1. [{#T}](#prefetch-content).
1. [{#T}](#check-cdn-working).

If you no longer need the created resources, [delete them](#clear-out).

## Before you start {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

Make sure that you have a domain name and can access the DNS settings on the site of the company that provides DNS hosting to you. This is usually the company that registered your domain.

### Required paid resources {#paid-resources}

The cost of supporting the CDN infrastructure includes:

* A fee for outgoing traffic from CDN servers (see [{{ cdn-name }} pricing](../pricing.md)).
* A fee for data storage in {{ objstorage-name }}, operations with data, and outgoing traffic (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* A fee for public DNS queries and DNS zones if you use {{ dns-full-name }} (see [{{ dns-name }} pricing](../../dns/pricing.md)).

## Create buckets in {{ objstorage-name }} {#create-buckets}

Two buckets will be created in the use case: the first, `ycprojektblue-storage`, will store files, and the second, `ycprojektblue-logs`, will store logs of requests to the first one.

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), open **{{ objstorage-name }}**.

  1. Create a bucket for files:

     1. Click **Create bucket**.
     1. Enter the bucket **Name**: `ycprojektblue-storage`.
     1. In the **Object read access** and **Object listing access** fields, select **Public**.
     1. Click **Create bucket**.

  1. Create a bucket for logs:

     1. Click **Create bucket**.
     1. Enter the bucket **Name**: `ycprojektblue-logs`.
     1. Click **Create bucket**.

- AWS CLI

  1. Create a bucket for files:

     ```bash
     aws --endpoint-url=https://storage.yandexcloud.net \
       s3api create-bucket \
       --bucket ycprojektblue-storage \
       --acl public-read
     ```

     Command output:

     ```json
     {
         "Location": "/ycprojektblue-storage"
     }
     ```

  1. Create a bucket for logs:

     ```bash
     aws --endpoint-url=https://storage.yandexcloud.net \
       s3api create-bucket \
       --bucket ycprojektblue-logs
     ```

     Command output:

     ```json
     {
         "Location": "/ycprojektblue-logs"
     }
     ```

- Terraform

  Before you start, get [static access keys](../../iam/operations/sa/create-access-key.md): private key and key ID used for authentication in {{ objstorage-short-name }}.

  1. In the configuration file, describe the bucket parameters:

     * `access_key`: The ID of the static access key.
     * `secret_key`: The value of the private access key.
     * `bucket`: The name of the created bucket (`ycprojektblue-storage`).

     {% if product == "yandex-cloud" %}

     ```
     provider "yandex" {
       token     = "<OAuth>"
       cloud_id  = "<cloud ID>"
       folder_id = "<folder ID>"
       zone      = "ru-central1-a"
     }
     
     resource "yandex_storage_bucket" "storage" {
       access_key = "<static key identifier>"
       secret_key = "<secret key>"
       bucket     = "ycprojektblue-storage"
       acl        = "public-read"
     }
     
     resource "yandex_storage_bucket" "logs" {
       access_key = "<static key identifier>"
       secret_key = "<secret key>"
       bucket     = "ycprojektblue-logs"
     }
     ```

     {% endif %}

     {% if product == "cloud-il" %}

     ```
     provider "yandex" {
       endpoint  = "{{ api-host }}:443"
       token     = "<static key of the service account>"
       cloud_id  = "<cloud ID>"
       folder_id = "<folder ID>"
       zone      = "{{ region-id }}-a"
     }
  
     resource "yandex_storage_bucket" "storage" {
       access_key = "<static key identifier>"
       secret_key = "<secret key>"
       bucket     = "ycprojektblue-storage"
       acl        = "public-read"
     }
     
     resource "yandex_storage_bucket" "logs" {
       access_key = "<static key identifier>"
       secret_key = "<secret key>"
       bucket     = "ycprojektblue-logs"
     }
     ```

     {% endif %}

  1. Make sure that the configuration files are correct:

     1. In the command line, go to the directory where you created the configuration file.
     1. Run the check using the command:

        ```
        terraform plan
        ```

     If the configuration is described correctly, the terminal displays the parameters of the bucket being created. If there are errors in the configuration, Terraform points them out.

  1. Deploy the bucket:

     1. If the configuration doesn't contain any errors, run the command:

        ```
        terraform apply
        ```

     1. Confirm that you want to create the bucket.

- API

  Use the [create](../../storage/s3/api-ref/bucket/create.md) API method.

{% endlist %}

## Enable logging for the bucket with files {#enable-logging}

At the end of the use case, you need to check that, when user requests are made, files are downloaded from the CDN server cache rather than directly from the bucket. To do this, enable bucket logging.

{% list tabs %}

- API

  Use the [putBucketLogging](../../storage/s3/api-ref/bucket/putBucketLogging.md) API method for the `ycprojektblue-storage` bucket. HTTP request body:

  ```xml
  <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01">
    <LoggingEnabled>
      <TargetBucket>ycprojektblue-logs</TargetBucket>
    </LoggingEnabled>
  </BucketLoggingStatus>
  ```

  * `TargetBucket`: The name of the bucket to write logs to (`ycprojektblue-logs`).

{% endlist %}

## Upload a file to the bucket {#upload-object}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), open **{{ objstorage-name }}**.
  1. Select `ycprojektblue-storage`.
  1. Click **Upload**.
  1. In the window that opens, select the `ycgame-update-v1.1.exe` patch file and click **Open**.
  1. Click **Upload**.

- AWS CLI

  Run the command:

  ```bash
  aws --endpoint-url=https://storage.yandexcloud.net \
    s3 cp \
    <path to ycgame-update-v1.1.exe> \ 
    s3://ycprojektblue-storage/ycgame-update-v1.1.exe
  ```

  Command output:

  ```
  upload: <path to ycgame-update-v1.1.exe> to s3://ycprojektblue-storage/ycgame-update-v1.1.exe
  ```

- Terraform

  1. Add the parameters of the object to upload to the configuration file from the [bucket creation step](#create-buckets):

     * `bucket`: The name of the bucket to add the object to (`ycprojektblue-storage`).
     * `key`: The name of the object in the bucket (`ycgame-update-v1.1.exe`). Required parameter.
     * `source`: A relative or absolute path to the file that you upload as an object.

     ```
     ...
     
     resource "yandex_storage_object" "patch-v1-1" {
       access_key = "<static key identifier>"
       secret_key = "<secret key>"
       bucket = "ycprojektblue-storage"
       key    = "ycgame-update-v1.1.exe"
       source = "<file path>/ycgame-update-v1.1.exe"
     }
     ```

  1. Make sure that the configuration files are correct.

     1. In the command line, go to the directory with the configuration file.
     1. Run the check using the command:

        ```
        terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.

  1. Deploy the cloud resources.

     1. If the configuration doesn't contain any errors, run the command:

     ```
     terraform apply
     ```

     1. Confirm that you want to create the object.

- API

  Use the [upload](../../storage/s3/api-ref/object/upload.md) API method.

{% endlist %}

## Create a CDN resource and enable caching {#create-cdn-resource}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), open **{{ cdn-name }}**.
  1. If the CDN provider hasn't been activated yet, click **Activate provider**.
  1. Create a CDN resource:

     1. On the **CDN resources** tab, click **Create resource**.
     1. Set up the main parameters of the CDN resource as follows:

        * **Content query**: **From one origin**.
        * **Origin type**: **Bucket**.
        * **Bucket**: `ycprojektblue-storage`.
        * **Domain names for content distribution**: The primary domain name that you'll use to publish patches, such as `cdn.ycprojectblue.example`.

          {% note alert %}

          You can't change the primary domain name used for content distribution after you create a CDN resource.

          {% endnote %}

        * In the **Advanced** section:

          * In the **Origin request protocol** field, select **HTTPS**.
          * In the **Redirect clients** field, select **HTTP to HTTPS**.
          * Enable **End-user access to content**.
          * In the **Certificate type** field, select **Let's Encrypt®** to automatically issue a certificate for the `cdn.ycprojektblue.example` domain name after creating your CDN resource.
          * In the **Host header** field, select **Custom**. In the **Header value** field, specify the origin domain name, `ycprojektblue-storage.storage.yandexcloud.net`, so that the source bucket responds correctly to CDN server requests.

     1. Click **Create**.

  1. Enable caching on CDN servers for the resource:

     1. Select the created CDN resource (the list of resources will contain its primary domain name: `cdn.ycprojektblue.example`).
     1. Go to the **Caching** tab.
     1. Click **Edit**.
     1. Enable **CDN caching**.
     1. Click **Save**.

- API

  Use the gRPC API [ResourceService/Create](../api-ref/grpc/resource_service.md#Create) call or the [create](../api-ref/Resource/create.md) REST API method. To enable caching on CDN servers, add the `edge_cache_settings` field to the request body.

{% endlist %}

## Set up DNS for your domain {#dns-setup}

1. Get a domain name generated for the created CDN resource on the `.gcdn.co` domain:

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), open **{{ cdn-name }}**.
     1. Select the created CDN resource (the list of resources will contain its primary domain name: `cdn.ycprojektblue.example`).
     1. On the **Overview** tab, under **DNS settings**, copy the name generated on the `.gcdn.co` domain to the clipboard.

   {% endlist %}

1. Go to your domain's DNS settings on the site of your DNS hosting provider.
1. Edit the CNAME record for `cdn` so that it points to the previously copied URL on the `.gcdn.co` domain, for example:

   ```http
   cdn CNAME cl-.....6bb.gcdn.co.
   ```

   If you use {{ dns-name }}, follow these instructions to configure the record:

   {% cut "Instructions for configuring DNS records for {{ dns-name }}" %}

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), open **{{ dns-name }}**.
     1. If you don't have a public DNS zone, create one:

        1. Click **Create zone**.
        1. **Name** the zone: `cdn-dns-a`.
        1. In the **Zone** field, specify your domain with a dot at the end: `ycprojektblue.example.`
        1. Select the zone **Type**: **Public**.
        1. Click **Create**.

     1. Create a record in the zone:

        1. In the list of zones, click `cdn-dns-a`.
        1. Click **Create record**.
        1. In the **Name** field, specify `cdn` to make the record match the `cdn.ycprojektblue.example` domain name.
        1. Select the record **Type**: **CNAME**.
        1. In the **Value** field, paste the URL you copied on the `.gcdn.co` domain with a dot at the end.
        1. Click **Create**.

   - CLI

     1. If you don't have a public DNS zone, create one:

        ```bash
        yc dns zone create --name cdn-dns-a --zone ycprojektblue.example. --public-visibility
        ```

        * `--name`: Zone name.
        * `--zone`: Domain zone (your domain with a dot at the end).
        * `--public-visibility`: Zone visibility (indicates if it's public).

        Command output:

        ```bash
        id: aetuvdw77q61dwbl1z2d
        folder_id: aoewzf73jwdlm1xtp4dd
        created_at: "2021-09-28T10:33:31.917Z"
        name: cdn-zone-a
        zone: ycprojektblue.example.
        public_visibility: {}
        ```

     1. Create a record in the zone:

        ```bash
        yc dns zone add-records --name cdn-dns-a --record "cdn CNAME cl-.....6bb.gcdn.co."
        ```

        * `--name`: Zone name.
        * `--record`: Resource record.

     1. Check that the record was created:

        ```bash
        yc dns zone list-records --name cdn-dns-a
        ```

        Command output:

        ```bash
        +----------------------------+------+-------+--------------------------------+
        |            NAME            | TTL  | TYPE  |              DATA              |
        +----------------------------+------+-------+--------------------------------+
        | ycprojektblue.example.     | 3600 | NS    | ns1.yandexcloud.net.           |
        |                            |      |       | ns2.yandexcloud.net.           |
        | ycprojektblue.example.     | 3600 | SOA   | ns1.yandexcloud.net.           |
        |                            |      |       | mx.cloud.yandex.net. 1 10800   |
        |                            |      |       | 900 604800 86400               |
        | cdn.ycprojektblue.example. |  600 | CNAME | cl-.....6bb.gcdn.co.           |
        +----------------------------+------+-------+--------------------------------+
        ```

        The list should contain a record named `cdn.ycprojektblue.example.`

   - API

     1. If you don't have a public DNS zone, create one using the gRPC API [DnsZoneService/Create](../../dns/api-ref/grpc/dns_zone_service.md#Create) call or the [create](../../dns/api-ref/DnsZone/create.md) REST API method. To make the zone public, add the `public_visibility` (gRPC) or `publicVisibility` (REST) field to the request body.
     1. In the zone, create a record named `cdn CNAME cl-.....6bb.gcdn.co.` using the [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/dns_zone_service.md#UpdateRecordSets) gRPC API call or the [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md) REST API method.

   {% endlist %}

   {% endcut %}

## Preload content to the cache of CDN servers {#prefetch-content}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), open **{{ cdn-name }}**.
  1. Select the created CDN resource (the list of resources will contain its primary domain name: `cdn.ycprojektblue.example`).
  1. Go to the **Content** tab.
  1. Click **Preload content**.
  1. In the **File path** field, specify the path to the file stored in the origin, omitting the domain name:

     ```text
     /ycgame-update-v1.1.exe
     ```

  1. Click **Preload content**.

- API

  Use the gRPC API [CacheService/Prefetch](../api-ref/grpc/cache_service.md#Prefetch) call or the [prefetch](../api-ref/Cache/prefetch.md) REST API method.

{% endlist %}

## Test the CDN {#check-cdn-working}

1. Wait for the DNS records to be updated and the file to be preloaded to CDN servers.
1. Download the file at the new URL:

   ```
   https://cdn.ycprojektblue.example/ycgame-update-v1.1.exe
   ```

1. Get the logs of requests to the `ycprojektblue-storage` bucket:

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), open **{{ objstorage-name }}**.
     1. Select `ycprojektblue-logs`.
     1. Click on the name of the object corresponding to the `ycgame-update-v1.1.exe` download time.
     1. Click **Download**.

   - AWS CLI

     1. Get a list of objects with logs:

        ```bash
        aws --endpoint-url=https://storage.yandexcloud.net \
          s3 ls s3://ycprojektblue-logs
        ```

        Operation output:

        ```
        2021-10-01 08:37:53         10 2021-10-01-08-37-53-631E0FC3B732AEDD
        2021-10-01 09:38:05         62 2021-10-01-09-38-05-436E6CDC832A20EF
        2021-10-01 10:38:01         23 2021-10-01-10-38-01-7F65EF1A6366FB18
        2021-10-01 11:37:57         41 2021-10-01-11-37-57-6F31613427A7DB9A
        2021-10-01 12:38:02         58 2021-10-01-12-38-02-AB893E6148AFDC55
        2021-10-01 13:38:02         73 2021-10-01-13-38-02-E69EAEC1C9083756
        ```

     1. In the resulting list, find the object with the log saved after downloading `ycgame-update-v1.1.exe` and download it:

        ```bash
        aws --endpoint-url=https://storage.yandexcloud.net \
          s3 cp s3://ycprojektblue-logs/2021-10-01-13-38-02-E69EAEC1C9083756 \
          2021-10-01-13-38-02-E69EAEC1C9083756
        ```

        Command output:

        ```
        download: s3://ycprojektblue-logs/2021-10-01-13-38-02-E69EAEC1C9083756 to 2021-10-01-13-38-02-E69EAEC1C9083756 
        ```

   - API

     1. Get a list of objects with logs in the `ycprojektblue-logs` bucket using the [listObjects](../../storage/s3/api-ref/bucket/listobjects.md) API method.

     1. In the resulting list, find the object with the log saved after downloading `ycgame-update-v1.1.exe` and download it using the [get](../../storage/s3/api-ref/object/get.md) API method.

   {% endlist %}

1. Check the logs of requests to the source bucket to make sure that the CDN servers did not download the file from the origin after your request. For more information about the log contents, see [{#T}](../../storage/concepts/server-logs.md#object-format) in the {{ objstorage-name }} documentation.

## Delete the resources created {#clear-out}

To shut down your CDN resource and stop paying for the created resources:

1. [Disable](../operations/resources/disable-resource.md) the created resource.
1. [Delete](../../storage/operations/objects/delete.md) the `ycgame-update-v1.1.exe` object from the `ycprojektblue-storage` bucket.
1. [Delete](../../storage/operations/buckets/delete.md) the `ycprojektblue-storage` bucket.
1. [Delete](../../storage/operations/objects/delete.md) all objects from the `ycprojektblue-logs` bucket.
1. [Delete](../../storage/operations/buckets/delete.md) the `ycprojektblue-logs` bucket.
1. [Delete](../../dns/operations/zone-delete.md) the DNS zone if you used it when [setting up DNS](#dns-setup).
