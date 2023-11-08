# Origins and origin groups

CDN servers retrieve the content requested by clients from _origins_.

When creating a resource, an origin or an [origin group](#groups) is specified for it. After creating a resource, in the resource settings, you can replace an origin with another origin or a resource group with another resource group.


## Origin type {#types}

As origins, you can use:

* [Bucket](../../storage/concepts/bucket.md) from {{ objstorage-full-name }}, for example, configured as a [static site hosting](../../storage/concepts/hosting.md).
* [L7 network load balancer](../../application-load-balancer/concepts/application-load-balancer.md) from {{ alb-full-name }}. CDN servers will access the load balancer at one of its IP addresses that must be selected in the origin settings.
* Your own server or another resource available by domain name. For example, if the origin is a server with the `files.example.com` domain name, to get the `/static/common.css` file, CDN servers will try to access `files.example.com/static/common.css` on the server.


## Static website hosting in a source bucket {#bucket-website-hosting}

You can publish your static website through {{ cdn-name }} if its files are stored in a bucket in {{ objstorage-name }}.

To make sure your website is displayed correctly, e.g., so that when entering `https://<domain_name>/`, the website homepage would open rather than the list of objects, configure your bucket in {{ objstorage-name }} and the origin in {{ cdn-name }} as follows:

1. Create your website homepage, such as `index.html`, and [upload it](../../storage/operations/objects/upload.md) to the bucket.
1. [Configure static website hosting](../../storage/operations/hosting/setup.md#hosting) in your bucket. In the settings, specify the homepage you uploaded in the previous step.
1. [Configure the origin](#instructions) in the CDN resource or in an origin group by specifying the bucket and enabling its use as your static website hosting. After that, the CDN server will try to access the bucket by the `<bucket_name>.{{ s3-web-host }}` domain name.


## Origin response time {#timeout}

{% include [ipv4-note](../../_includes/cdn/ipv4-note.md) %}

An origin must respond to the CDN server's request within 5 seconds. If no response was received during this time, the CDN server responds to the client with the `504 Gateway Timeout` HTTP status code.

To reduce both the load of CDN servers on origins and the response time, you can enable [origin shielding](origins-shielding.md) for a resource.


## Origin groups {#groups}

To distribute the load between origins hosting the same content, you can combine them into an origin _group_.

Origins in the group can be active or backup. Requests from CDN servers are distributed among active origins in a circular manner.

> For example, if an origin group includes two active origins, the first content request will be sent to the first origin, the second request ‒ to the second origin, the third request ‒ to the first origin again, and so on.

If the active origin responded to the CDN server with HTTP status code 5xx, the request is sent to one of the backup origins. If there are no backup origins in the origin group or the response includes code 5xx again, the CDN server sends the response with code 5xx to the client.

{% note tip %}

If you publish content in two or more buckets, combine them into a group of L7 load balancer backends and use the load balancer as an origin as shown in the [blue-green and canary deployment](../tutorials/blue-green-canary-deployment.md) scenario. Otherwise, you'll need to support in the service sending requests to the CDN with different [`Host` header](servers-to-origins-host.md) values corresponding to different buckets.

{% endnote %}

## How to configure origins {#instructions}

See these guides:

* Configuring an origin or origin group while [creating a resource](../operations/resources/create-resource.md).
* [Editing the basic settings of a resource](../operations/resources/configure-basics.md), including changing an origin or origin group to a different one.
* [Managing origin groups](../operations/index.md#origin-groups): creating, updating, connecting them to a resource, and deleting them.
