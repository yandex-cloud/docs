---
title: Hiding of origin headers
description: This section describes the CDN resource option of hiding from end clients the HTTP headers received from the content origin.
---

# Hiding of origin headers

By default, {{ cdn-name }} provides all HTTP headers received from the [origin](origins.md) to the client. With the header hiding option, you can [configure](../operations/resources/hiding-headers.md) your CDN resource in a way that the client gets only particular origin headers.

This option works as a whitelist. All origin headers not mentioned in the setting will be screened and hidden.

You may want to hide headers in some of the following situations:

* Protecting sensitive information.
* Enforcement of requirements prohibiting the transmission of certain headers to clients.
* Downsizing the response.


## Recommendations {#recommendations}

We recommend whitelisting the following headers:

* `Content-Type`: Required for the browser to display content correctly.
* `Content-Length`: Informs about the size of the response.
* `Cache-Control`: Manages client-side caching.
* `ETag`: Used to check content for relevance.
* `Last-Modified`: Date of last content modification.

We recommend to hide the following headers for increased security:

* `Server`: Server software info.
* `X-Powered-By`: Technology info, e.g., PHP, ASP.NET.
* `X-AspNet-Version`: ASP.NET version.
* `X-Generator`: CMS or website generator info.
* `X-Debug-Info`: Debugging info.
* `X-Internal-*`: Any internal headers.


#### See also {#see-also}

* [{#T}](../operations/resources/hiding-headers.md)