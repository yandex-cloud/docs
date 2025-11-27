---
title: How to set up multiple domain name support for a website using the management console, CLI, or API
description: Follow this guide to set up multiple domain name support for a website using the {{ yandex-cloud }} management console, CLI, or API.
---

# Support for multiple domain names using the management console, CLI, or API

To create an infrastructure to support [multiple website domain names](index.md) using the {{ yandex-cloud }} management console, CLI, or API:
1. [Create buckets](#buckets).
1. [Set up a static website for your main domain](#common).
1. [Set up a redirect for an additional domain](#xtra).
1. [Check the performance of several domains](#test).


## Create buckets {#buckets}

Create buckets and name them according to the domain names, e.g., `example.com` and `example2.com`.

1. Create a bucket for the main `example.com` domain name:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
      1. Select **{{ objstorage-name }}**.
      1. In the top panel, click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
      1. On the bucket creation page:

          1. Enter a name for the bucket according to the main domain name of the website, e.g., `example.com`.

              {% note info %}

              Bucket names must match domain names. 

              {% endnote %}

          1. Set the maximum bucket size.

          1. Enable `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`: Access for any users.

          1. Select the default [storage class](../../../concepts/storage-class.md): `{{ ui-key.yacloud.storage.bucket.settings.class_value_standard }}`.

          1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}** to complete the operation.

    - {{ yandex-cloud }} CLI {#cli}

      {% include [cli-install](../../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

      1. View the description of the CLI command to create a bucket:

          ```bash
          yc storage bucket create --help
          ```

      1. Create a bucket in the default folder:

          ```bash
          yc storage bucket create --name <bucket_name> \
            --public-read \
            --public-list
          ```

          Where: 
          * `--name`: Bucket name according to the main domain name of the website, e.g., `example.com`.

              {% note info %}

              Bucket names must match domain names. 

              {% endnote %}

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
          created_at: "2025-08-08T09:12:45.743187Z"
          resource_id: e3etgi7l43gs********
          ```

    - API {#api}

      To create a bucket, use the [create](../../../api-ref/Bucket/create.md) REST API method for the [Bucket](../../../api-ref/Bucket/index.md) resource, the [BucketService/Create](../../../api-ref/grpc/Bucket/create.md) gRPC API call, or the [create](../../../s3/api-ref/bucket/create.md) S3 API method.

    {% endlist %}

1. Create a bucket for the additional `example2.com` domain name by repeating the steps above.

## Set up a static website for your main domain {#common}

Set up a static website for the bucket and link it to your main `example.com` domain name:

1. Set up the `example.com` bucket to host your static website.

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you want to configure hosting for.
      1. In the left-hand panel, select ![image](../../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
      1. Select the **{{ ui-key.yacloud.storage.bucket.switch_website }}** tab.
      1. Under **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}**:
          * In the **{{ ui-key.yacloud.storage.bucket.website.field_index }}** field, specify the absolute path to the file in the bucket for the website home page, e.g., `index.html`.
      
            {% include [static-site-index-restriction](../../../../_includes/storage/static-site-index-restriction.md) %}
      
          * Optionally, in the **{{ ui-key.yacloud.storage.bucket.website.field_error }}** field, specify the absolute path to the file in the bucket to show for `4xx` errors, e.g., `pages/error404.html`. By default, {{ objstorage-name }} returns its own page.
      1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

      Use the link in **{{ ui-key.yacloud.storage.bucket.website.field_link }}** to check the hosting.

    - {{ yandex-cloud }} CLI {#cli}

      {% include [hosting-setup-cli](../../../../_includes/storage/hosting-setup-cli.md) %}

    - API {#api}

      To set up hosting for a static website, use the [update](../../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../../api-ref/grpc/Bucket/update.md) gRPC API call, or the [upload](../../../s3/api-ref/hosting/upload.md) S3 API method.

    {% endlist %}

1. Link the `example.com` domain name and the relevant bucket.

    1. On the DNS sever, create a public DNS zone and a resource record which links your domain name to the bucket:

        {% list tabs group=instructions %}

        - {{ dns-full-name }} {#dns}

          {% note warning %}

          {{ dns-name }} usage is chargeable; for more information, see [{#T}](../../../../dns/pricing.md).

          {% endnote %}

          1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you want to use your custom domain for.
          1. In the left-hand panel, select ![image](../../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}** and go to the **{{ ui-key.yacloud.storage.bucket.switch_website }}** tab.
          1. In **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}**, under **{{ ui-key.yacloud.storage.bucket.website.title_connected-domains }}**, click **{{ ui-key.yacloud.component.dns-integration.button_add-domain }}**.

              {% note info %}

              Under **{{ ui-key.yacloud.storage.bucket.website.title_connected-domains }}** in the **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}** section, you can only see those domains that were created directly through this interface. Records created in [{{ dns-name }}](../../../../dns/quickstart.md) will not be shown.

              {% endnote %}

          1. In the window that opens, click **{{ ui-key.yacloud.dns.button_zone-create }}** and select the domain zone that matches the bucket name, e.g., `example.com`. Click **{{ ui-key.yacloud.common.create }}**.
          1. Expand **{{ ui-key.yacloud.dns.label_additional-settings }}**.
          1. In the **{{ ui-key.yacloud.dns.label_form-ttl }}** field, specify the resource record time to live or select a value from the list.
          1. Click **{{ ui-key.yacloud.common.create }}**.
          1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.
          
          To gain access to public zone domain names, delegate the domain by specifying the `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}` server addresses in your domain registrar account.

          Delegating a domain and updating resource records may take a while.

          You can also use {{ dns-name }} to create a [DNS zone](../../../../dns/operations/zone-create-public.md) and [resource record](../../../../dns/operations/resource-record-create).
          
          {% cut "Example of DNS zone and resource record parameters" %}

          DNS zone parameters:
          * Zone: `example.com`
          * Type: `Public`

          Resource record parameters:

          | Name          | Type   | TTL | Value                      |
          |--------------|-------|-----|-------------------------------|
          | example.com. | ANAME | 600 | example.com.{{ s3-web-host }} |

          [ANAME](../../../../dns/concepts/resource-record.md#aname) records enable using second-level domains for hosting. Unlike [CNAME](../../../../dns/concepts/resource-record.md#cname) records, they do not restrict the use of other record types in the same zone. 

          {% endcut %}

        - Third-party DNS server {#third-party-dns-server}

          Here is an example of DNS zone parameters:
          * Zone: `example.com`
          * Type: `Public`
          
          An example of a [CNAME](../../../../dns/concepts/resource-record.md#cname) resource record looks like this: 

          ```text
          example.com CNAME example.com.{{ s3-web-host }}
          ```

          To use a CNAME resource record, make sure your domain name belongs to at least a third-level domain. This restriction is due to the way CNAME records are handled on DNS hosting platforms. For more information, see [RFC 1912](https://www.ietf.org/rfc/rfc1912.txt), section 2.4.

          Updating resource records may take a while.

        {% endlist %}

        As a result, the static website will be available at `example.com`.

1. {% include [add-cert.md](../../../../_includes/storage/add-cert.md) %}

    {% note info %}

    You can use one certificate for both your main and additional domains or multiple certificates for each domain.

    {% endnote %}

    {% include [redirect-https](../../../../_includes/storage/redirect-https.md) %}

As a result, the static website will be available at `example.com` using HTTPS.


## Set up a redirect for an additional domain {#extra}

For the bucket with the additional `example2.com` domain name:

1. Set up the `example2.com` bucket to redirect all requests to the main `example.com` domain and use HTTPS.

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you want to configure request redirects for.
      1. In the left-hand panel, select ![image](../../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
      1. Select the **{{ ui-key.yacloud.storage.bucket.switch_website }}** tab.
      1. Under **{{ ui-key.yacloud.storage.bucket.website.switch_redirect }}**, specify:
          * **{{ ui-key.yacloud.storage.bucket.website.field_hostname }}**: Domain name to which all requests will be redirected, e.g., `example.com`.
          * **{{ ui-key.yacloud.storage.bucket.website.field_protocol }}**: **{{ ui-key.yacloud.common.label_https }}**.
      1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

    - {{ yandex-cloud }} CLI {#cli}

      1. See the description of the CLI command for setting up redirects for all requests:

          ```bash
          yc storage bucket update --help
          ```
     
      1. Create a redirect configuration file in JSON format. For example:
     
          ```json
          {
            "redirectAllRequests": {
              "protocol": "PROTOCOL_HTTPS",
              "hostname": "example.com"
            }
          }
          ```

          Where:
          * `protocol`: Data transfer protocol.
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
          name: example2.com
          folder_id: b1gjs8dck8bv********
          default_storage_class: STANDARD
          versioning: VERSIONING_SUSPENDED
          max_size: "10737418240"
          acl: {}
          created_at: "2022-12-14T08:42:16.273717Z"
          ```

    - API {#api}

      To set up redirects for all requests to a bucket, use the [update](../../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../../api-ref/grpc/Bucket/update.md) gRPC API call, or the [upload](../../../s3/api-ref/hosting/upload.md) S3 API method.

    {% endlist %}

1. {% include [add-cert.md](../../../../_includes/storage/add-cert.md) %}

    {% include [redirect-https](../../../../_includes/storage/redirect-https.md) %}

1. [Link](../own-domain.md) the `example2.com` domain name and the relevant bucket.


## Check the performance of several domains {#test}

{% include [website-multiple-domain-test](../../../../_includes/storage/website-multiple-domain-test.md) %}


#### See also {#see-also}

* [{#T}](terraform.md)