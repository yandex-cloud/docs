#### Quotas {#cdn-quotas}

#|
|| Type of limit | Value ||
|| Number of [CDN resources](../../cdn/concepts/resource.md) per cloud 
`cdn.resources.count` | 20 ||
|#


#### Limits {#cdn-limits}

| Type of limit | Value |
| ----- | ----- |
| Number of [cache purging](../../cdn/concepts/caching.md#purge) requests per minute | 1 |
| Number of file paths per cache purging request | 10 |
| Number of [forced file caching](../../cdn/concepts/caching.md#prefetch) requests per minute | 1 |
| Number of paths to files forcibly loaded into the cache per request | 100 |
| Number of IP addresses (subnet prefixes) in the IP-based access policy [list](../../cdn/concepts/ip-address-acl.md#ip-list) | 100 |
| Number of [dedicated IP addresses](../../cdn/concepts/dedicated-ip-addressing.md) for CDN resources per [billing account](../../billing/concepts/billing-account.md) | 1 |