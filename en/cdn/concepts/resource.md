# CDN resource

A _resource_ is the main logical entity in {{ cdn-full-name }} that lets you configure and manage content distribution from [origins](origins.md) over a CDN.

To start distributing content over a CDN, create a resource by following the [instructions](../operations/resources/create-resource.md) and specify the following in it:

* The origin or origin group that hosts your content.
* [Domain names for content distribution](#hostnames).
* Basic settings for exchanging data [between clients and the CDN](clients-to-servers.md) and between [the CDN and origins](servers-to-origins.md).

After creating a resource, you can also configure for it:

* [Caching](caching.md).
* HTTP headers and methods (see the [instructions](../operations/resources/configure-http.md)).
* Processing of [cross-domain queries (CORS)](cors.md).
* [Compression](compression.md) and [segmentation](slicing.md) of content.

Resource settings [apply a short while after](#delay) you create or update the resource.

## Domain names for content distribution {#hostnames}

_Domain names for content distribution_ are used in client requests to CDN servers. For example, to make the file `styles/common.css` available at `cdn.example.com/styles/common.css`, you need to enter `cdn.example.com` as a domain name.

{{ cdn-name }} supports any domain names, including [IDN](https://en.wikipedia.org/wiki/Internationalized_domain_name) with local non-ASCII characters, for example, Cyrillic. Now you can specify the name in the original form (`пример.рф`) or transform them to [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode) with the `xn--` (`xn--e1afmkfd.xn--p1ai`) prefixes added. In the [management console]({{ link-console-main }}), resource details show IDNs in the original form with no transformation to Punycode.

When creating a resource, you must enter at least one domain name. The first name you enter is the primary domain name, and you can't change it after you create a resource.

For the resource to run properly, you must have:

* Rights to all the domain names you entered.
* Access to DNS settings for domain names.

   For each name, in the settings of your DNS hosting, create a CNAME record linking this name with the domain name of the CDN load balancer, in the `cl-<random characters>.edgecdn.ru` format. It is displayed when creating a resource, as well as in the management console (on the page of an existing resource). This is a sample record for the `cdn.example.com` domain name:

   ```
   cdn.example.com. CNAME cl-4sne12sd.edgecdn.ru
   ```


## Time needed for the settings to apply {#delay}

A CDN resource start working correctly in a while after you create or update it.

* {% include [after-creation-tip](../../_includes/cdn/after-creation-tip.md) %}
* {% include [after-changes-tip](../../_includes/cdn/after-changes-tip.md) %}


## Resource statuses {#status}

A {{ cdn-name }} resource can have one of the following statuses:

* `Active` if the content is available to everyone (or will be available to everyone [once the settings apply](#delay)).
* `Not active` if the content is not available to anyone.

The **End-user access to content** option in the basic resource settings is used to switch between them.

If no user requests have been sent to the resource for 90 days, its status changes to `Not active`.

## Resource usage statistics {#stats}

{{ cdn-name }} provides resource usage metrics for the last 30 days:

* **Upstream from origins**: The volume of traffic streamed by CDN servers from origins.
* **Sent**: The volume of traffic sent from CDN servers to clients.
* **All traffic**: The sum of the metrics **Upstream from origins** and **Sent**.
* **Requests**: The number of client requests to the CDN.
* **Responses hit**: The number of client requests that were responded by CDN servers with [cached](caching.md) copies of files without requesting them from origins (if caching is enabled for CDN servers).
* **Response miss**: The number of client requests that were not responded by CDN servers with cached copies of files (for example, because caching was disabled, the file hasn't been cached by the server yet, or the [cache lifetime](caching.md#server-side-cache-age) expired) and CDN servers had to access origins to load files.
* **Cache hit ratio**: The ratio of traffic sent from CDN servers to clients without accessing origins. It's calculated using the formula `(1 − (Upstream from origins / Sent)) × 100%`.
* **Uploaded by shielding server**: Amount of traffic uploaded by shielding server from origins (if [shielding](origins-shielding.md) is enabled).
* **Responses with 2xx codes**, **3xx codes**, **4xx codes**, **5xx codes**: The number of responses with those HTTP status codes sent by CDN servers to clients.

You can view statistics on the resource page in the [management console]({{ link-console-main }}).

#### See also {#see-also}

* [Instructions for operations with resources](../operations/index.md#resources).
* [Instructions for operations with the basic resource settings](../operations/resources/configure-basics.md).