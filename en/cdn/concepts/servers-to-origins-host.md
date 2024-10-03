---
title: Host header in CDN server requests to origins in {{ cdn-full-name }}
description: This tutorial describes what Host headers are used for in CDN server requests to origins and how to configure them properly.
---

# Host header in CDN server requests to origins

To make sure that CDN servers send correct requests to [origins](origins.md), configure the `Host` HTTP header value for these requests:

* **{{ ui-key.yacloud.cdn.value_host-header-default }}**: First [domain name for content distribution](resource.md#hostnames) specified in the CDN resource settings.
* **{{ ui-key.yacloud.cdn.value_host-header-custom }}**: Arbitrary domain name.
* **{{ ui-key.yacloud.cdn.value_protocol-match }}**: Same value as that of the `Host` header in the client request to the CDN.

The `Host` header value is selected when creating a resource. You can change it afterwards along with other basic resource settings. For more information, see these guides:

* [{#T}](../operations/resources/create-resource.md)
* [{#T}](../operations/resources/configure-basics.md)

## How to set up the header properly {#best-practices}

Choosing the right setting for the `Host` header depends on the origins you use in your resource:

{% list tabs %}

- A single origin

   If the origin is a bucket, select the `{{ ui-key.yacloud.cdn.value_host-header-custom }}` option and specify the `<bucket_name>.{{ s3-storage-host }}` (or `<bucket_name>.{{ s3-web-host }}` if the bucket is configured for [static website hosting](../../storage/concepts/hosting.md)).

   In other cases, the setting depends on what requests the origin accepts.

   > For example, in [blue-green and canary deployment scenarios](../tutorials/blue-green-canary-deployment.md), the L7 load balancer is configured to accept requests with two values of the `Host` header. For the CDN resource, the `{{ ui-key.yacloud.cdn.value_protocol-match }}` option is selected.

   To check that the origin accepts requests with the selected `Host` header value correctly, run the following command:

   ```bash
   curl -Ik -H "Host: <header_value>" <server_or_L7_load_balancer_address>
   ```

- Origin group

   If there is one bucket in the group:

   1. Select the `{{ ui-key.yacloud.cdn.value_host-header-custom }}` option and specify the `<bucket_name>.{{ s3-storage-host }}` (or `<bucket_name>.{{ s3-web-host }}` if the bucket is configured for [static website hosting](../../storage/concepts/hosting.md)).
   1. Configure other origins (servers and L7 load balancers) so that they accept requests with the specified header value.

   If there are multiple buckets in the group, we recommend using the L7 load balancer with buckets that act as backends instead (see the configuration example for [blue-green and canary deployment](../tutorials/blue-green-canary-deployment.md)).

   In other cases, the setting depends on what requests the origins accept. To check that the origin accepts requests with the selected `Host` header value correctly, run the following command:

   ```bash
   curl -Ik -H "Host: <header_value>" <server_or_L7_load_balancer_address>
   ```

{% endlist %}
