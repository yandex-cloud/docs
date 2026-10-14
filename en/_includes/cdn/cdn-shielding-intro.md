_Origin shielding_ is a {{ cdn-name }} feature that helps reduce the load on [content origins](../../cdn/concepts/origins.md) from CDN servers. 

If shielding is enabled for a [resource](../../cdn/concepts/resource.md), CDN servers request files from an intermediate _shielding server_ rather than from an origin directly. This server deduplicates the requests received: a file requested more than once is downloaded from an origin once and cached.

The shielding servers are located in different geographical locations:

| Provider | Location ID | Location name |
| --- | --- | --- |
| {{ cdn-full-name }} | 1 | Russia / Moscow / msk |

{% note warning %}

Origin shielding is a paid feature. You will be charged for a full month on the day you enable [origin shielding](../../cdn/pricing.md). Thereafter, you will be charged on the first day of every next month.

{% endnote %}
