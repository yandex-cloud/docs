# {{ cdn-full-name }} overview

{{ cdn-full-name }} provides web service developers with a _Content Delivery Network_ (CDN) functionality. The _CDN servers_ located all over the world get content from your _origins_, cache the content, and deliver it to end clients on their request. This lets you decrease the load on origins and decrease content waiting time for the end user.

### How CDN works

1. You host your content in [origins](origins.md). As an origin, you can use your server with a domain name, a [{{ objstorage-name }} bucket](../../storage/concepts/bucket.md) or [{{ alb-name }} L7 load balancer](../../application-load-balancer/concepts/application-load-balancer.md).
1. In {{ cdn-name }}, you create a [_resource_](resource.md) and specify in its settings the origins, domain names for content distribution, and other CDN settings.
1. {{ cdn-name }} deploys CDN servers in many regions of the world and provides you with a domain name of the _CDN Load Balancer_ that accepts requests and passes them to the servers. You must link this name to the domain names that you use for content distribution using the CNAME type of DNS records.
1. When the client requests a file using the domain name specified in the settings:

   1. Depending on where the client is located on the web, the CDN load balancer determines the CDN server that can deliver the content the fastest, and sends a request to this server.

   1. If the requested file is already cached on the selected CDN server, it's returned to the client right away. If the file is not cached, it is requested from one of the origins, cached (if [caching on CDN servers](caching.md#server-side) is enabled), and also returned to the client.

### Service concepts {#service-concepts}

{{ cdn-name }} uses the following concepts:

| Concept | Description |
| --- | --- |
| [Resource](resource.md) | The main entity in the service that lets you configure and control content distribution from origins over the CDN. |
| [Origins and origin groups](origins.md) | The servers that are origins of content. CDN servers access them to load files. |
| [Exchanging data between clients and the CDN](clients-to-servers.md) | Receiving client requests by the CDN load balancer and sending response data from CDN servers. |
| [TLS certificates](clients-to-servers-tls.md) | Certificates used for HTTPS connections between clients and the CDN load balancer. |
| [CORS](cors.md) | Cross-domain client requests to the CDN (cross-origin resource sharing). |
| [Content compression](compression.md) | Sending GZIP files to clients. |
| [Exchanging data between the CDN and origins](servers-to-origins.md) | CDN server requests for files from origins and responses to them. |
| [`Host` header](servers-to-origins-host.md) | `Host` HTTP header in CDN server requests to origins. |
| [Content segmentation](slicing.md) | Storing large files on CDN servers in parts. |
| [Origin shielding](origins-shielding.md) | Using a shield server between CDN servers and origins to reduce origin load. |
| [Content caching](caching.md) | Creating copies of files and storing them temporarily on CDN servers and/or at the client side. |
| [Exporting logs](logs.md) | Exporting CDN and shielding server request logs to object storage. |
| [Quotas and limits](limits.md) | Service use restrictions. |

See also the {{ yandex-cloud }} [general resource hierarchy](../../resource-manager/concepts/resources-hierarchy.md).
