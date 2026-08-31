# Content caching

In the CDN resource settings, you can enable _content caching_ to temporarily store the file copies loaded from origins. There are two types of caching:
* On CDN servers located at the [points of presence](points-of-presence.md).
* In client browsers.

## Caching on CDN servers {#server-side}

{% include [cdn-content-caching-prgrph](../../_includes/cdn/cdn-content-caching-prgrph.md) %}

{% note info %}

{{ cdn-name }} does not guarantee any particular percentage of cached requests hitting the cache (cache hits). If the CDN server cannot respond to a request from the cache, it requests the content from the origin. Depending on caching settings, the frequency of publishing new content, and the nature of user requests, the amount of traffic to the origin can be comparable to the outgoing traffic of the CDN.

Take this traffic into account when assessing the origin's acceptable load and operating costs. For more information, see [{#T}](../troubleshooting.md#origin-load-growth).

{% endnote %}

### Cache lifetime {#server-side-cache-age}

Until the cache lifetime expires, the CDN server returns a cached copy of the file to the clients without accessing origins.

{% note info %}

If end users do not request content for 36 hours, it is deleted from the CDN server cache regardless of the option settings.

{% endnote %}

You can choose one of two modes to define the cache lifetime:

| Mode | Description |
| ----- | ----- |
| Same as origin | The file is cached for the period specified in the origin's response to the request. The origin must add to the response the `Cache-Control` HTTP header with the `max-age` (specifies the cache lifetime in seconds) and `public` (allows file caching at any level) directives.<br/>If the origin responded with the `200`, `201`, `204`, `206`, `301`, `302`, `303`, `304`, `307`, or `308` HTTP status code but the response includes no header meeting the above conditions, the file is cached for the period specified in the resource settings. Files from responses with other status codes are not cached if the header is missing. |
| Custom | The default cache lifetime is specified in the resource settings. It applies to all the origin responses with the `200`, `206`, `301`, and `302` HTTP status codes. For any status code (regardless of whether it's listed above or not), you can separately specify the cache lifetime that takes precedence over the default time.<br/>If a status code is not included in the list and no cache lifetime is specified for it separately, a file from the response with such a code is not cached. |

## Caching in browsers {#client-side}

If caching in browsers is enabled for a resource, CDN servers will add the `Cache-Control` header with the `max-age` (indicates the cache lifetime in seconds) and `public` (allows file caching at any level) directives to responses with the `200`, `201`, `204`, `206`, `301`, `302`, `303`, `304`, `307`, and `308` HTTP status codes. The cache lifetime is specified in the resource settings.

Files from responses with other status codes are not cached.

## Cookies and query parameters {#cookie-and-query}

Requests to the CDN server may contain the same path in the URI but different cookies (the `Cookie` HTTP header) and/or different query parameters.

Query parameters that are considered during caching form part of the _cache object key_. Requests with different values for these parameters correspond to different cache objects. Parameters ignored during caching do not form part of the key: requests that differ in these parameters only correspond to the same object.

You can select one of the following query parameter caching modes in the resource settings:

#|
|| Mode | How to treat query parameters in cache key ||
|| `{{ ui-key.yacloud.cdn.resources.QueryParamsOptions.option_do-not-cache_4J3Bg }}` | Ignore all query parameters. For requests with the same path, a single file copy is saved, regardless of the parameter values. ||
|| `{{ ui-key.yacloud.cdn.resources.QueryParamsOptions.option_cache-all_4pexC }}` | Consider all query parameters. A separate file copy is saved for each unique set of parameters. ||
|| `{{ ui-key.yacloud.cdn.resources.QueryParamsOptions.option_cache-all-except_vEGRW }}` | Ignore specified query parameters, consider the others. ||
|| `{{ ui-key.yacloud.cdn.resources.QueryParamsOptions.option_cache-only_uJKZC }}` | Consider only specified query parameters, ignore the others. ||
|#

For example, if you select `{{ ui-key.yacloud.cdn.resources.QueryParamsOptions.option_cache-only_uJKZC }}` and specify the `segment` parameter, the same cache object will correspond to the `/file.m3u8?expires=1&segment=1` and `/file.m3u8?expires=2&segment=1` requests. And another object will correspond to `/file.m3u8?expires=1&segment=2`.

Caching of responses to requests with cookie files is configured separately using the **{{ ui-key.yacloud.cdn.label_ignore }}** option. If this option is off, responses to requests with the `Cookie` header are not cached, and the files get re-requested from the origin. If this option is on, responses get cached, and the CDN server can return files from the cache.

## Cache prefetching {#prefetch}

You can forcibly (manually) [fetch](../operations/resources/prefetch-files.md) individual files from sources into the CDN server cache before they are requested by clients. We recommend prefetching large files of 200 MB or more.

{% include [purge-before-prefetch-notice](../../_includes/cdn/purge-before-prefetch-notice.md) %}

There are technical [limits](limits.md) on cache prefetching.

## Purging cache {#purge}

You can delete cached file copies from CDN servers by _purging the cache_. This lets you quickly update in the CDN the content that has changed in the origins.

You can [purge](../operations/resources/purge-cache.md) cache either fully or partially. Partial purge is recommended: if you delete copies of all files from the cache, CDN servers will significantly increase the load on the origins, having to access them at every file request.

{% include [wildcard-paths-purging-specifics](../../_includes/cdn/wildcard-paths-purging-specifics.md) %}

Examples of paths:

{% list tabs group=cdn_provider %}

- {{ cdn-full-name }} {#yc}

  * `/image/foobar.png`: An individual file.
  * `/image/foo*`: All files in the `/image/` folder with names starting with `foo`.
  * `/static/*`: All files in the `/static/` folder.

{% endlist %}

If the file is cached with all or some [query parameters](#cookie-and-query) duly considered, all copies of the file get deleted by default. To delete only specific copies, explicitly state the values of query parameters included in the cache key. Here is an example: `/image/foo.png?id=12345`.

{% note warning %}

{% include [the-vary-headers-purge-warning](../../_includes/cdn/the-vary-headers-purge-warning.md) %}

{% endnote %}

## Use cases {#examples}

* [{#T}](../tutorials/blue-green-canary-deployment.md)
* [{#T}](../tutorials/prefetch.md)


#### Useful links {#see-also}

* [Caching setup guide](../operations/resources/configure-caching.md)
* [Cache prefetching guide](../operations/resources/prefetch-files.md)
* [Cache purging guide](../operations/resources/purge-cache.md)
