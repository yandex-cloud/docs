---
title: Following request redirects
description: This section describes a CDN resource feature that allows following request redirects received from content origins.
---

# Following request redirects

By default, when a [source](origins.md) returns the `3xx` redirect code, {{ cdn-name }} caches this response and returns it to the client. Using the redirects feature, you can enable the CDN resource to follow redirects from the source. With this feature on, {{ cdn-name }} send a request to the address specified in the response and then returns the content from the target address to the client.

This feature uses one redirection level only: if after the first redirect the `3xx` code is returned again, it will be forwarded to the client and cached on the CDN.

{% note info %}

The option works only if the [origin shielding](origins-shielding.md) function is on.

{% endnote %}

You may need to follow redirects in the following scenarios:

* Content migration: when moving files to a different domain or server.
* Load balancing: when distributing requests between multiple origins.
* A/B testing: when switching traffic between different content versions.


#### See also {#see-also}

* [{#T}](../operations/resources/setup-follow-redirects.md)
* [{#T}](../operations/resources/enable-shielding.md)