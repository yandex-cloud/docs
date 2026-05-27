If CDN server caching is enabled for a resource, files are copied from [origins](../../cdn/concepts/origins.md) to the server cache in the following cases:

* File the user has requested from [the CDN resource](../../cdn/concepts/resource.md) is not yet cached on the responding sever.
* [Lifetime](../../cdn/concepts/caching.md#server-side-cache-age) of the file’s copy cached on the CDN server has expired, and the file stored on the origin has changed (otherwise, the lifetime is prolonged for the same duration).
* You [prefetched](../../cdn/concepts/caching.md#prefetch) files from origins to the CDN server cache in the CDN resource settings.