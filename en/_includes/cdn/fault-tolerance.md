# Configuring {{ cdn-full-name }} when the origin is unavailable

To ensure your [CDN resource](../../cdn/concepts/resource.md) continues delivering content when the primary [origin](../../cdn/concepts/origins.md) is unavailable, enable [caching](../../cdn/concepts/caching.md), configure [origin shielding](../../cdn/concepts/origins-shielding.md), and connect a standby origin in advance. If your application supports older file versions, you can also allow serving stale content from the cache.

## How {{ cdn-full-name }} handles origin unavailability

CDN servers located at various [points of presence](../../cdn/concepts/points-of-presence.md) deliver content directly to users. An outage at the origin data center does not automatically stop content delivery through the CDN.

If your CDN resource only has one origin that becomes unavailable, the outcome depends on the current state of the cache:

#|
|| **File state** | **Expected behavior** ||
|| The file exists in the CDN server cache, and the cache TTL has not expired. | {{ cdn-name }} continues to deliver the file. ||
|| The file is not in the cache. | {{ cdn-name }} must retrieve the file from the origin, or from the shielding server if origin shielding is enabled. ||
|| The cache TTL has expired. | {{ cdn-name }} must refresh the file from the origin. ||
|| The cache TTL has expired, and delivery of outdated content is enabled. | If the `stale` conditions are met, {{ cdn-name }} delivers the cached copy.  ||
|| File caching is disabled. | To get the file, each user request requires an available origin. ||
|#

If there is a cache miss and the origin is unavailable, the user will get an error. In case of a timeout, this may be `504 Gateway Timeout`. On other failures, the error code may vary.

{% note info %}

Each point of presence has its separate cache. A file cached on one CDN server may not exist at other points of presence. For details, see [Content caching](../../cdn/concepts/caching.md).

{% endnote %}

To improve resource fault tolerance:
1. [Enable caching on the resource](#enable-caching).
1. [Enable origin shielding](#enable-shielding).
1. [Prepare a standby origin](#prepare-backup-origin).
1. [Add the second origin to the origin group](#configure-origin-group).
1. [Allow delivery of outdated content, if applicable](#serve-stale-content).
1. [Complete the setup before an outage occurs](#configure-in-advance).
1. [Test the standby origin](#test-backup-origin).

## Enable caching on the resource {#enable-caching}

1. In the [management console]({{ link-console-main }}), select the folder where your resource is located and navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
1. Click the resource name.
1. Navigate to the **{{ ui-key.yacloud.cdn.label_resource-cache }}** tab and click **{{ ui-key.yacloud.common.edit }}**.
1. Under **{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache }}**, enable **{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache-enabled }}**.
1. Select the setting type: **{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache-settings-type-source-settings }}** or **{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache-settings-type-custom-settings }}**. Set the cache lifetime.
1. Click **{{ ui-key.yacloud.common.save }}**.

For a step-by-step guide, see [Configuring caching](../../cdn/operations/resources/configure-caching.md).

{% note tip %}

Make sure your files are cached correctly. Check the `Cache-Status` response header returned by {{ cdn-name }}: the `HIT` value indicates the file was delivered from the cache.

{% endnote %}

Caching behavior depends on the resource settings and origin response headers. [Browser caching](../../cdn/concepts/caching.md#client-side) is configured separately and does not replace CDN server caching.

If caching is disabled or a file is excluded from caching, {{ cdn-name }} will access the origin each time the file is requested. Set your [cache TTL](../../cdn/concepts/caching.md#server-side-cache-age) based on how frequently your content updates.

## Enable origin shielding {#enable-shielding}

Origin shielding adds an intermediate caching layer between the CDN servers and origins. If a file is not in the CDN server's cache, the request goes to the _shielding server_ first. If a valid cached copy exists there, no requests are sent to the origin.

The shielding server also consolidates duplicate requests for a single file. This reduces redundant content downloads from the origin and lowers its load.

Origin shielding can significantly improve caching efficiency, especially when users request the same files through different points of presence. The result depends on request patterns and cache settings. For details, see [Origin shielding](../../cdn/concepts/origins-shielding.md).

To enable shielding:

1. Open the resource in {{ cdn-name }}.
1. Navigate to the **{{ ui-key.yacloud.cdn.label_shielding }}** tab.
1. Click **{{ ui-key.yacloud.cdn.button_activate-shielding }}**, select an available location, and confirm.
1. Make sure the status has changed to `Active`.

It may take up to 15 minutes to apply the settings.

{% note warning %}

Origin shielding is [billed separately](../../cdn/pricing.md). A full monthly fee is charged on the day the feature is enabled.

{% endnote %}

Learn more in [this guide on enabling shielding](../../cdn/operations/resources/enable-shielding.md).

Use origin shielding in addition to origin redundancy. If a file is missing from both the CDN server cache and the shielding server, the CDN must fetch it from an available origin.

## Prepare a standby origin {#prepare-backup-origin}

To retrieve files when the primary origin is down, you need a secondary origin containing a copy of your content.

For [VMs](../../compute/concepts/vm.md), you can use a different [availability zone](../../overview/concepts/geo-scope.md). To protect against a full cloud platform outage, host your standby origin in another cloud or independent infrastructure. 

{% note info %}

A duplicate Object Storage bucket cannot serve as an independent backup for service-wide outages.

{% endnote %}

Before adding a standby origin, confirm the following:

* The files are accessible at the same paths as on the primary origin.
* All file copies are up-to-date.
* The origin is accessible to {{ cdn-name }}, considering network restrictions and access permissions. Use an [up-to-date list of {{ cdn-name }} networks](../../security/ip-list.md#cloud-cdn). If origin shielding is enabled, [contact support]({{ link-console-support }}) to get the list of the shielding servers’ networks.
* Protocol [configurations](../../cdn/concepts/servers-to-origins.md) and the setting of HTTPS TLS certificates and [`Host` headers](../../cdn/concepts/servers-to-origins-host.md) are compatible with both origins.
* The standby origin can handle the load if the primary origin fails.

{% note tip %}

When using different buckets, make sure to check the `Host` header. A value supported by one of the buckets may be incompatible with the other. For details on how to implement this setup, see the [Host header](../../cdn/concepts/servers-to-origins-host.md) section.

{% endnote %}

## Add the second origin to the origin group {#configure-origin-group}

In the [management console]({{ link-console-main }}), go to the {{ cdn-name }} page and open the **{{ ui-key.yacloud.cdn.label_origins-groups-list }}** tab. [Create a new group](../../cdn/operations/origin-groups/create-group.md) or [update an existing one](../../cdn/operations/origin-groups/edit-group.md). Add both origins, enable them, and set their priorities.

The following options are available:

#|
|| **Priorities** | **Behavior** ||
|| Primary and primary | Requests are distributed using the round-robin method. Both origins handle requests. ||
|| Primary and standby | {{ cdn-name }} sends a request to the primary origin first. If a retryable error occurs, the request fails over to the standby origin. ||
|#

In round-robin mode, individual requests are balanced across the origins. A single file is never fetched from two origins at the same time. For more information, see [Origins and origin groups](../../cdn/concepts/origins.md#groups).

{% note info %}

Failover takes place only during connection errors, timeouts, and responses with HTTP codes `500`, `502`, `503`, and `504`. Responses with `403` and `404` codes do not trigger a failover. For example, if a file is missing from the primary origin, {{ cdn-name }} will not automatically look for it on the backup origin.

{% endnote %}

Once configured, [add the group to the CDN resource](../../cdn/operations/origin-groups/bind-group-to-resource.md).

It may take up to 15 minutes for settings to apply to the CDN servers. Wait for them to propagate, then [test the standby origin](#test-backup-origin). During failover, response times may increase while waiting for the primary origin to time out.

## Allow delivery of outdated content, if applicable {#serve-stale-content}

For some types of content, delivering an outdated file version is often better than returning an error. In this scenario, you can allow {{ cdn-name }} to deliver a cached copy after its TTL expires if the origin is unavailable.

When using the API, you can configure this behavior through the `options.stale` CDN resource parameter. Here is a configuration snippet example:

```json
{
  "options": {
    "stale": {
      "enabled": true,
      "value": [
        "error",
        "timeout",
        "http_500",
        "http_502",
        "http_503",
        "http_504"
      ]
    }
  }
}
```

This example allows the CDN to deliver stale content during network errors, timeouts, and the specified HTTP status codes.

For a new resource, use the [create](../../cdn/api-ref/Resource/create.md) REST API method for the [Resource](../../cdn/api-ref/Resource/index.md) resource or the [ResourceService/Create](../../cdn/api-ref/grpc/Resource/create.md) gRPC API call. For existing resources, use the [update](../../cdn/api-ref/Resource/update.md) REST API method for the [Resource](../../cdn/api-ref/Resource/index.md) resource or the [ResourceService/Update](../../cdn/api-ref/grpc/Resource/update.md) gRPC API call.

{% cut "Example of modifying a CDN resource using curl" %}

```bash
export IAM_TOKEN=$(yc iam create-token)
curl \
  --request PATCH \
  --header "Authorization: Bearer $IAM_TOKEN" \
  --header "Content-Type: application/json" \
  --url 'https://cdn.{{ api-host }}/cdn/v1/resources/<resource_ID>' \
  --data '{
    "options": {
      "stale": {
        "enabled": true,
        "value": [
          "error",
          "timeout",
          "http_500",
          "http_502",
          "http_503",
          "http_504"
        ]
      }
    }
  }'
```

For information on the IAM token and CDN resource ID, see the following pages:
* [{#T}](../../cdn/operations/resources/get-resources-info.md)
* [{#T}](../../cdn/api-ref/authentication.md)

{% endcut %}

{% note info %}

Delivery of outdated content is only possible if a cached copy exists. If the file was never cached or has been removed, an available origin is required.

The conditions for outdated content delivery and origin failover are configured independently. Adding an error code to `stale` does not automatically enable origin failover for that code.

{% endnote %}

## Complete the setup before an outage occurs {#configure-in-advance}

During an outage, management operations for {{ cdn-name }} may be unavailable along with your origins. This includes viewing resources, updating configurations, cache [purging](../../cdn/operations/resources/purge-cache.md) or [pre-fetching](../../cdn/operations/resources/prefetch-files.md).

Add your standby origin in advance and wait for the settings to apply. This enables {{ cdn-name }} to automatically route traffic to the standby origin if the primary one goes down. You will not need to modify settings If the management console or API become unavailable.

{% note warning %}

Do not purge the cache when origins are unavailable unless absolutely necessary. Purging deletes all cached copies, and {{ cdn-name }} may be unable to retrieve them again.

{% endnote %}

## Test the standby origin {#test-backup-origin}

For testing, use a separate, dedicated test CDN resource. You can create it by [copying the configuration](../../cdn/operations/resources/copy-resource.md) of your production resource. Copying is restricted to a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). Make sure this new test resource has its own [domain name](../../cdn/concepts/resource.md#hostnames) and a [CNAME record](../../dns/concepts/resource-record.md#cname).

1. Place identical test files on both the primary and standby origins.
1. In the test resource, set the production standby origin as its sole primary origin. Use a separate origin group to avoid modifying your production resource group.
1. Wait for the settings to apply.
1. Send the exact same request through the test CDN resource as you would through production: use the same file path, [query parameters](../../cdn/concepts/caching.md#cookie-and-query), HTTP method, and required headers. Change only the CDN resource domain name to the test domain. Before testing, make sure the response is not fetched from a pre-populated cache of the test resource or shielding server.
1. Compare the HTTP status code, content, and key response headers with those of the production resource.
1. Check the standby origin logs to confirm request delivery.

This test confirms the backup origin is accessible to {{ cdn-name }} and delivers content correctly.

To further test automatic failover, create a separate group with two test origins of the _primary_ and _standby_ priorities. Connect this group to your test CDN resource and wait for the settings to apply. Simulate a [failover](#configure-origin-group) error, e.g., a `503` response, on the primary test origin. Request a file that is yet uncached by both the CDN and shielding servers. Check your standby origin’s logs to confirm it received the request. Restore the primary origin after testing.

#### Useful links {#see-also}

* [{#T}](../../architecture/fault-tolerance.md)
* [{#T}](../../cdn/concepts/index.md)
