# Origins and origin groups

CDN servers retrieve the content requested by clients from _origins_.

As origins, you can use:

* A server with a domain name linked to it. For example, if the server's domain name is `files.example.com`, to get the `/static/common.css` file, CDN servers will try to access `files.example.com/static/common.css` on the server.
* [A bucket](../../storage/concepts/bucket.md) from {{ objstorage-full-name }}, for example, configured as a [static site hosting](../../storage/concepts/hosting.md).
* [L7 network load balancer](../../application-load-balancer/concepts/application-load-balancer.md) from {{ alb-full-name }}. CDN servers will access the load balancer at one of its IP addresses that must be selected in the origin settings.

An origin must respond to the CDN server's request within 5 seconds. If no response was received during this time, the CDN server responds to the client with the `504 Gateway Timeout` HTTP status code.

When creating a resource, an origin or an [origin group](#groups) is specified for it. After creating a resource, in the resource settings, you can replace an origin with another origin or a resource group with another resource group.

## Origin groups {#groups}

To distribute the load between origins hosting the same content, you can combine them into an _origin group_.

Origins in the group can be active or backup. Requests from CDN servers are distributed among active origins in a circular manner.

> For example, if an origin group includes two active origins, the first content request will be sent to the first origin, the second request ‒ to the second origin, the third request ‒ to the first origin again, and so on.

If the active origin responded to the CDN server with HTTP status code 5xx, the request is sent to one of the backup origins. If there are no backup origins in the origin group or the response includes code 5xx again, the CDN server sends the response with code 5xx to the client.

