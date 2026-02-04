1. [Get your cloud ready](#before-you-begin).
1. [Add a certificate to {{ certificate-manager-name }}](#add-certificate).
1. [Create a bucket in {{ objstorage-name }} and upload your website files to it](#create-bucket).
1. [Set up static website hosting](#hosting).
1. [Create a CDN resource](#create-cdn-resource).
1. [Configure DNS for the CDN resource](#configure-dns).
1. [Test the CDN](#check-cdn).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/cdn-hosting/paid-resources.md) %}


## Add a certificate to {{ certificate-manager-name }} {#add-certificate}

{% include [add-certificate](../_tutorials_includes/cdn-hosting/add-certificate.md) %}


## Create a bucket in {{ objstorage-name }} and upload your website files to it {#create-bucket}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. At the top right, click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter a name for the bucket, e.g., `example.com`.
  1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.
  1. {% include [create-index-page](../_tutorials_includes/cdn-hosting/create-index-page.md) %}
  1. On the bucket page, click ![image](../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.storage.bucket.button_upload }}** and select `index.html`.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Create a bucket in the default folder:

      ```bash
      yc storage bucket create --name <bucket_name> \
        --public-read \
        --public-list
      ```

      Where:
      * `--name`: Bucket name, e.g., `example.com`. This is a required parameter. For more information, see [Bucket naming rules](../../storage/concepts/bucket.md#naming).
      * `--public-read`: Enables public read access to bucket objects.
      * `--public-list`: Enables public view access to the list of bucket objects.

      Result:

      ```text
      name: example.com
      folder_id: b1geoelk7fld********
      anonymous_access_flags:
        read: true
        list: true
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      created_at: "2025-10-26T17:38:54.635027Z"
      resource_id: e3ef9cmb253k********
      ```

  1. {% include [create-index-page](../_tutorials_includes/cdn-hosting/create-index-page.md) %}

  1. Upload the main page file to the bucket:

      ```bash
      yc storage s3api put-object \
        --body <local_file_path> \
        --bucket <bucket_name> \
        --key <object_path>
      ```

      Where:

      * `--body`: Path to the file you need to upload to the bucket, e.g., `index.html`.
      * `--bucket`: Bucket name, e.g., `example.com`.
      * `--key`: [Key](../../storage/concepts/object.md#key) by which to store the object in the bucket, e.g., `index.html`.

      Result:
      ```text
      etag: '"b810d087812333c7dd9cfa80********"'
      request_id: 8e8714b8********
      ```

- API {#api}

  1. To create a bucket, use the [create](../../storage/api-ref/Bucket/create.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/index.md) resource, the [BucketService/Create](../../storage/api-ref/grpc/Bucket/create.md) gRPC API call, or the [create](../../storage/s3/api-ref/bucket/create.md) S3 API method.

  1. {% include [create-index-page](../_tutorials_includes/cdn-hosting/create-index-page.md) %}

  1. To upload the home page of the website, use the [upload](../../storage/s3/api-ref/object/upload.md) S3 API method.

{% endlist %}


## Set up static website hosting {#hosting}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you want to configure hosting for.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Navigate to the **{{ ui-key.yacloud.storage.bucket.switch_general-settings }}** tab.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** and **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** fields, select `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`.
  1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.
  1. Select the **{{ ui-key.yacloud.storage.bucket.switch_website }}** tab.
  1. Under **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}**, in the **{{ ui-key.yacloud.storage.bucket.website.field_index }}** field, specify the absolute path to the file in the bucket for the website home page, e.g., `index.html`.
  1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

  Use the link in **{{ ui-key.yacloud.storage.bucket.website.field_link }}** to check the hosting.

- {{ yandex-cloud }} CLI {#cli}

  1. Set the hosting parameters for the bucket:

      ```bash
      yc storage bucket update --name <bucket_name> \
        --website-settings '{"index":"index.html"}'
      ```
      
      Where `--name` is the bucket name.

      Result:

      ```text
      name: example.com
      folder_id: b1geoelk7fld********
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      acl: {}
      created_at: "2025-10-26T17:38:54.635027Z"
      website_settings:
        index: index.html
        redirect_all_requests: {}
      resource_id: e3ef9cmb253k********
      ```

- API {#api}

  To set up hosting for a static website, use the [update](../../storage/api-ref/Bucket/update.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/index.md) resource, the [BucketService/Update](../../storage/api-ref/grpc/Bucket/update.md) gRPC API call, or the [upload](../../storage/s3/api-ref/hosting/upload.md) S3 API method.

{% endlist %}


## Create a CDN resource {#create-cdn-resource}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Click **{{ ui-key.yacloud.cdn.button_resource-create }}**.
  1. Configure the basic CDN resource settings:
      * Under **{{ ui-key.yacloud.cdn.label_section-content }}**:
        * Enable **{{ ui-key.yacloud.cdn.label_access }}**.
        * In the **{{ ui-key.yacloud.cdn.label_content-query-type }}** field, select `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}`.
        * In the **{{ ui-key.yacloud.cdn.label_source-type }}** field, select `{{ ui-key.yacloud.cdn.value_source-type-bucket }}`.
        * In the **{{ ui-key.yacloud.cdn.label_bucket }}** field, select the bucket you need from the list.
        * Enable **{{ ui-key.yacloud.cdn.label_use-bucket-site }}**.
        * In the **{{ ui-key.yacloud.cdn.label_protocol }}** field, select `{{ ui-key.yacloud.common.label_http }}`.
        * In the **{{ ui-key.yacloud.cdn.label_personal-domain }}** field, enter the domain name, e.g., `cdn.yandexcloud.example`.

          {% note alert %}

          The `cdn.yandexcloud.example` domain name will become the primary one, and you will not be able to edit it after you create a CDN resource.

          {% endnote %}

      * Under **{{ ui-key.yacloud.cdn.label_section-additional }}**:
        * In the **{{ ui-key.yacloud.cdn.label_redirect }}** field, select `{{ ui-key.yacloud.cdn.value_redirect-http-to-https }}`.
        * In the **{{ ui-key.yacloud.cdn.label_certificate-type }}** field, specify `{{ ui-key.yacloud.cdn.value_certificate-custom }}` and select a [certificate](#add-certificate) for the `cdn.yandexcloud.example` domain name.
        * In the **{{ ui-key.yacloud.cdn.label_host-header }}** field, select `{{ ui-key.yacloud.cdn.value_host-header-custom }}` and, in **{{ ui-key.yacloud.cdn.label_custom-host-header }}**, specify the origin domain name in `<name_of_bucket_with_files>.{{ s3-web-host }}` format for the source bucket to respond to CDN server requests correctly.
  1. Click **{{ ui-key.yacloud.common.continue }}**.
  1. Keep the default settings for **{{ ui-key.yacloud.cdn.label_resource-cache }}**, **{{ ui-key.yacloud.cdn.label_resource-http-headers }}**, and **{{ ui-key.yacloud.cdn.label_section-additional }}** and click **{{ ui-key.yacloud.cdn.button_wizard-create }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Create an origin group:

      ```bash
      yc cdn origin-group create \
        --name <origin_group_name> \
        --origin source=<name_of_bucket_with_files>.{{ s3-web-host }},enabled=true
      ```

      Where:
      * `--name`: Origin group name.
      * `--origin source`: Origin domain name in `<name_of_bucket_with_files>.{{ s3-web-host }}` format, e.g., `example.com.{{ s3-web-host }}`.

      Result:

      ```text
      folder_id: b1geoelk7fld********
      name: mys3-origin
      use_next: true
      origins:
        - id: "27904"
          origin_group_id: "42742158888********"
          source: example.com.{{ s3-web-host }}
          enabled: true
          provider_type: ourcdn
      provider_type: ourcdn
     ```

  1. Create a CDN resource:

      ```bash
      yc cdn resource create \
        --cname <cdn_domain_name> \
        --origin-group-id <origin_group_ID> \
        --origin-protocol http \
        --cert-manager-ssl-cert-id <TLS_certificate_ID> \
        --host-header <name_of_bucket_with_files>.{{ s3-web-host }}
      ```

      Where:
      * `--cname`: CDN resource domain name, e.g., `cdn.example.com`.
      * `--origin-group-id`: ID of the origin group for CDN created in the previous step.
      * `--origin-protocol`: Protocol the CDN resource will use to communicate with the origin, specify `http`.
      * `--cert-manager-ssl-cert-id`: TLS certificate ID that you saved earlier when creating the certificate.
      * `--host-header`: The Host header value. For the source bucket to respond to CDN server requests correctly, specify the origin domain name in `<name_of_bucket_with_files>.{{ s3-web-host }}` format, e.g., `example.com.{{ s3-web-host }}`.

      {% cut "Result" %}

      ```text
      id: bc8r4l7awapj********
      folder_id: b1geoelk7fld********
      cname: cdn.example.com
      created_at: "2025-10-26T17:45:08.171948Z"
      updated_at: "2025-10-26T17:45:08.171948Z"
      active: true
      options:
        edge_cache_settings:
          enabled: true
          default_value: "86400"
        browser_cache_settings: {}
        query_params_options:
          ignore_query_string:
            enabled: true
            value: true
        slice: {}
        host_options:
          host:
            enabled: true
            value: example.com.{{ s3-web-host }}
        static_headers:
          enabled: true
        stale: {}
        allowed_http_methods:
          enabled: true
          value:
            - GET
            - HEAD
            - OPTIONS
        proxy_cache_methods_set:
          enabled: true
        disable_proxy_force_ranges:
          enabled: true
          value: true
        static_request_headers:
          enabled: true
        custom_server_name: {}
        ignore_cookie:
          enabled: true
          value: true
        secure_key:
          type: DISABLE_IP_SIGNING
      origin_group_id: "42742158888********"
      origin_group_name: mys3-origin
      origin_protocol: HTTP
      ssl_certificate:
        type: CM
        status: READY
        data:
          cm:
            id: fpq4nl8g1c4h********
      provider_type: ourcdn
      provider_cname: b5384481********.a.yccdn.cloud.yandex.net
      ```

      {% endcut %}

- API {#api}

  To create a CDN resource, use the [create](../../cdn/api-ref/Resource/create.md) REST API method for the [Resource](../../cdn/api-ref/Resource/index.md) resource or the [ResourceService/Create](../../cdn/api-ref/grpc/Resource/create.md) gRPC API call.

{% endlist %}

{% include [start-warn](../_tutorials_includes/cdn-hosting/start-warn.md) %}


## Configure DNS for the CDN resource {#configure-dns}

The `cdn.yandexcloud.example` domain name must be mapped to the CDN using DNS records.

To set up DNS for a CDN resource:

1. Get the {{ cdn-name }} provider domain name:

   {% list tabs group=instructions %}
   
   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
     1. From the list of CDN resources, select the one with `cdn.yandexcloud.example` as its primary domain name.
     1. From **{{ ui-key.yacloud.cdn.label_dns-settings_title }}** at the bottom of the page, copy the domain name in `{{ cname-example-yc }}` format.

   {% endlist %}

1. On the website of your DNS hosting provider, navigate to the DNS settings.
1. Create or edit a CNAME record for `cdn.yandexcloud.example` so that it points to the domain name you copied:

   ```text
   cdn CNAME {{ cname-example-yc }}
   ```

   {% include [note-dns-aname](../../_includes/cdn/note-dns-aname.md) %}

   If you use {{ dns-name }}, follow this guide to configure the record:
   
   {% cut "Configuring DNS records for {{ dns-name }}" %}
   
   {% list tabs group=instructions %}
   
   - Management console {#console}
   
     1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
     1. If you do not have a public DNS zone, create one:

        1. Click **{{ ui-key.yacloud.dns.button_zone-create }}**.
        1. In the **{{ ui-key.yacloud.dns.label_zone }}** field, enter the website domain name with a trailing dot: `yandexcloud.example.`.
        1. In the **{{ ui-key.yacloud.common.type }}** field, select `{{ ui-key.yacloud.dns.label_public }}`.
        1. In the **{{ ui-key.yacloud.common.name }}** field, specify `example-dns-zone`.
        1. Click **{{ ui-key.yacloud.common.create }}**.
      
     1. Create a CNAME record for `cdn.yandexcloud.example` in the zone:

        1. Select `example-dns-zone`.
        1. Click **{{ ui-key.yacloud.dns.button_record-set-create }}**.
        1. In the **{{ ui-key.yacloud.common.name }}** field, specify `cdn`.
        1. In the **{{ ui-key.yacloud.common.type }}** field, specify `CNAME`.
        1. In the **{{ ui-key.yacloud.dns.label_records }}** field, paste the copied value in `{{ cname-example-yc }}.` format with a trailing dot.
        1. Click **{{ ui-key.yacloud.common.create }}**.

   {% endlist %}

   {% endcut %}


## Test the CDN {#check-cdn}

{% include [check-cdn](../_tutorials_includes/cdn-hosting/check-cdn.md) %}


## How to delete the resources you created {#clear-out}

To shut down the infrastructure and stop paying for the resources you created:

1. [Delete](../../dns/operations/zone-delete.md) the DNS zone named `example-dns-zone` if you created it in {{ dns-name }}.
1. Delete the CDN resource with `cdn.yandexcloud.example` as its primary domain name.
1. [Delete](../../storage/operations/objects/delete.md) all objects from the bucket.
1. [Delete](../../storage/operations/buckets/delete.md) the bucket.