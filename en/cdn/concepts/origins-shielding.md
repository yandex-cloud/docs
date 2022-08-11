# Origin shielding

_Origin shielding_ is a {{ cdn-name }} feature that helps reduce the load on [content origins](origins.md) from CDN servers.

If shielding is enabled for a [resource](resource.md), CDN servers request files from an intermediate _shielding server_ rather than from an origin directly. This server deduplicates the requests received: a file requested more than once is downloaded from an origin once and cached.

The shielding servers are located in different geographical locations. You can select a suitable location when enabling or configuring shielding.

Origin shielding is a paid function. See [{#T}](../pricing.md) for rates.

#### See also {#see-also}

* [Instructions for enabling shielding](../operations/resources/enable-shielding.md).
