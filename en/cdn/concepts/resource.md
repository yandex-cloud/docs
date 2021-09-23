# CDN resource

_A resource_ is the main logical entity in {{ cdn-full-name }} that lets you configure and manage content distribution from [origins](origins.md) over a CDN.

To start distributing content over a CDN, create a resource and specify in it:

* The origin or origin group that hosts your content.
* [The domain names for content distribution](#hostnames).
* The basic [settings for HTTP requests to origins](#http).

After creating a resource, you can also configure for it:

* [Caching](caching.md).
* [HTTP headers and methods](#http).
* Processing of [cross-domain queries (CORS)](cors.md).
* [Compression](compression.md) and [segmentation](slicing.md) of content.

It may take up to 15 minutes for the new resource settings to apply to CDN servers.

## Domain names for content distribution {#hostnames}

_Domain names for content distribution_ are used in client requests to CDN servers. For example, to make the file `styles/common.css` available at `cdn.example.com/styles/common.css`, you need to enter `cdn.example.com` as a domain name.

When creating a resource, you must enter at least one domain name. The first name you enter is the primary domain name, and you can't change it after you create a resource.

For the resource to run properly, you must have:

* Rights to all the domain names you entered.
* Access to DNS settings for domain names.

  For each name, in the settings of your DNS hosting, you must create a CNAME record linking this name with the domain name of the CDN load balancer, in the format `cl-<random characters>.gcdn.co`. It's displayed when creating a resource and also in the management console (on the page of an existing resource). This is a sample record for the `cdn.example.com` domain name:

  ```
  cdn.example.com. CNAME cl-4sne12sd.gcdn.co
  ```

## Data exchange via HTTP {#http}

Clients, CDN servers, and origins exchange data over the HTTP and HTTPS (HTTP over TLS) protocols.

### Configuring of data exchange between clients and CDN servers {#http-clients-cdn}

The communication protocol between clients and CDN servers depends on the URI scheme of your files, for example: `http://cdn.example.com/styles/common.css` or `https://cdn.example.com/styles/common.css`.

To make your files accessible over HTTPS, you need to configure your [domain names](#hostnames) (for example, issue TLS certificates for them). For instance, you can use {{ certificate-manager-full-name}}: [issue a certificate from Let's Encrypt<sup>®</sup>](../../certificate-manager/operations/managed/cert-create.md) and [get its contents](../../certificate-manager/operations/managed/cert-get-content.md).

For a resource, you can configure:

* HTTP headers in CDN server responses to clients.
* [CORS processing of cross-domain requests](cors.md).
* HTTP methods that clients are allowed to use in their CDN requests.
* [Sending of compressed content](compression.md) using the `Content-Encoding: gzip` HTTP header.

### Configuring of data exchange between CDN servers and origins {#http-cdn-origins}

You can select a protocol for communication between CDN servers and origins: always HTTP, always HTTPS, or the protocol used by the CDN server to communicate with the client.

You can issue a TLS certificate from Let's Encrypt<sup>®</sup> for HTTPS directly in {{ cdn-name }}. The certificate is issued automatically after you save the resource settings: it takes up to 30 minutes.

For a resource, you can also configure:

* The value of the HTTP `Host` header for the requests of CDN servers to origins: the primary [domain name used for content distribution](#hostnames), echoing the value from the client's request, or some arbitrary value.
* Other HTTP headers in CDN server requests to origins.
* Receiving of files by CDN servers from origins in parts: [content segmentation](slicing.md).

Your resource and origins must be configured so that requests from CDN servers are allowed, processed correctly, and not redirected.

> For example, if origins redirect requests from a URI with the `http` scheme to a URI with the `https` scheme, you must select the HTTPS protocol for the resource, and vice versa.

## Resource usage statistics {#stats}

{{ cdn-name }} provides resource usage metrics for the last 30 days:

* **Upstream from origins**: The volume of traffic streamed by CDN servers from origins.
* **Sent**: The volume of traffic sent from CDN servers to clients.
* **All traffic**: The sum of the metrics **Upstream from origins** and **Sent**.
* **Requests**: The number of client requests to the CDN.
* **Responses hit**: The number of client requests that were responded by CDN servers with [cached](caching.md) copies of files without requesting them from origins (if caching is enabled for CDN servers).
* **Response miss**: The number of client requests that were not responded by CDN servers with cached copies of files (for example, because caching was disabled, the file hasn't been cached by the server yet, or the [cache lifetime](caching.md#server-side-cache-age) expired) and CDN servers had to access origins to load files.
* **Cache hit ratio**: The ratio of traffic sent from CDN servers to clients without accessing origins. It's calculated using the formula `(1 − (Upstream from origins / Sent)) × 100%`.
* **Responses with 2xx codes**, **3xx codes**, **4xx codes**, **5xx codes**: The number of responses with those HTTP status codes sent by CDN servers to clients.
