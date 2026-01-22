# Content caching

In the CDN resource settings, you can enable _content caching_ to temporarily store the file copies loaded from origins. There are two types of caching:
* On CDN servers located at the [points of presence](points-of-presence.md).
* In client browsers.

## Caching on CDN servers {#server-side}

If caching on CDN servers is enabled for a resource, files are copied from origins to servers when the following events occur:

* The client requested from the CDN a file that hadn't been cached by the server yet.
* The [lifetime](#server-side-cache-age) of the file copy on the server expired, and the file changed on the origin since that time (otherwise, the lifetime is extended for the same period).
* You [preloaded](#prefetch) files from origins in the resource settings.

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

Requests to the CDN server may contain the same path in the URI but different cookies (the `Set-Cookie` HTTP header) and/or different query parameters. In the resource settings, you can specify how to cache files corresponding to such requests: save one file copy for all requests (that is, ignore cookies and/or query parameters) or consider them different and cache the file separately for each request.

## Preloading content {#prefetch}

Individual files can be _preloaded_ from origins, that is, cached manually, without waiting for requests from clients. We recommend that you preload large files (with a size of 200 MB or higher).

You can only preload content that's not on the servers yet. To update the already cached files, [purge the cache](#purge) before preloading.

There are technical [limits](limits.md) for preloading.

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

If the file is cached based on the [query parameters](#cookie-and-query) (that is, for each request with new parameters, a separate copy was saved), all copies of the file are deleted by default. To delete only specific copies, you need to explicitly specify their query parameters, e.g., `/image/foo.png?id=12345`.

{% note warning %}

{% include [the-vary-headers-purge-warning](../../_includes/cdn/the-vary-headers-purge-warning.md) %}

{% endnote %}

There are technical [limits](limits.md) for cache purging.

## Use cases {#examples}

* [{#T}](../tutorials/blue-green-canary-deployment.md)
* [{#T}](../tutorials/prefetch.md)


#### See also {#see-also}

* [Caching setup guide](../operations/resources/configure-caching.md).
* [Instructions for preloading content](../operations/resources/prefetch-files.md).
* [Instructions for purging the cache](../operations/resources/purge-cache.md).