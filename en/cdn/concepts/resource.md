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

{% include [edge-center-features-note](../../_includes/cdn/edge-center-features-note.md) %}

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

{% note info %}

You cannot have both a CDN resource and a mail server on the same second-level domain. We recommend creating two domains:

* For content distributed over a CDN. Please note that you should only use {{ cdn-name }} with [CNAME](../../dns/concepts/resource-record.md#cname) resource records, because if using an [ANAME](../../dns/concepts/resource-record.md#aname) record, the end users will get a response unrelated to their geolocation. For more information about CNAME records and their [limitations](https://www.rfc-editor.org/rfc/rfc1912#section-2.4), see [RFC-1035](https://www.ietf.org/rfc/rfc1035.html#section-3.3.1).
* For lightweight content and your mail server. In this case, you can use ANAME and [MX](../../dns/concepts/resource-record.md#mx) resource records.

{% endnote %}

## Time needed for the settings to apply {#delay}

A CDN resource start working correctly in a while after you create or update it.

* {% include [after-creation-tip](../../_includes/cdn/after-creation-tip.md) %}
* {% include [after-changes-tip](../../_includes/cdn/after-changes-tip.md) %}


## Resource statuses {#status}

A {{ cdn-name }} resource can have one of the following statuses:

* `Active` if the content is available to everyone (or will be available to everyone [once the settings apply](#delay)).
* `Not active` if the content is not available to anyone.

To switch between them, use the **{{ ui-key.yacloud.cdn.field_access }}** option in the basic resource settings.

If no user requests have been sent to the resource for 90 days, its status changes to `Not active`.

## Resource usage statistics {#stats}

{{ cdn-name }} provides resource usage metrics for the last 30 days:

* **{{ ui-key.yacloud.cdn.label_metrics-upstream-bytes }}**: Amount of traffic loaded by CDN servers from origins.
* **{{ ui-key.yacloud.cdn.label_metrics-send-bytes }}**: Amount of traffic sent from CDN servers to clients.
* **{{ ui-key.yacloud.cdn.label_metrics-total-bytes }}**: Sum of **{{ ui-key.yacloud.cdn.label_metrics-upstream-bytes }}** and **{{ ui-key.yacloud.cdn.label_metrics-send-bytes }}** metrics.
* **{{ ui-key.yacloud.cdn.label_metrics-requests }}**: Number of client requests to the CDN.
* **{{ ui-key.yacloud.cdn.label_responses-hit }}**: Number of client requests to which CDN servers responded by sending [cached](caching.md) copies of files without requesting them from origins (if caching is enabled for CDN servers).
* **{{ ui-key.yacloud.cdn.label_responses-miss }}**: Number of client requests to which CDN servers failed to respond by sending cached copies of files (e.g., caching disabled, file not yet cached by the server, or [cache lifetime](caching.md#server-side-cache-age) expired) and had to access origins to load files.
* **{{ ui-key.yacloud.cdn.label_cache-hit-ratio }}**: Ratio of traffic sent from CDN servers to clients without accessing origins. It is calculated using this formula: `(1 − ({{ ui-key.yacloud.cdn.label_metrics-upstream-bytes }} / {{ ui-key.yacloud.cdn.label_metrics-send-bytes }})) × 100%`.
* **{{ ui-key.yacloud.cdn.label_metrics-shield-bytes }}**: Amount of traffic loaded from origins by the shielding server (if [shielding](origins-shielding.md) is enabled).
* **{{ ui-key.yacloud.cdn.label_responses2xx }}**, **3xx**, **4xx**, and **5xx**: Number of responses with the respective HTTP status codes sent by CDN servers to clients.

You can view statistics on the resource page in the [management console]({{ link-console-main }}).

#### See also {#see-also}

* [Guides on using resources](../operations/index.md#resources).
* [Guide on using the basic resource settings](../operations/resources/configure-basics.md).