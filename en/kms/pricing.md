---
title: '{{ kms-full-name }} pricing policy'
description: This article provides the {{ kms-name }} pricing policy.
editable: false
---

# {{ kms-name }} pricing policy


{% note tip %}




To calculate the cost of [symmetric](https://yandex.cloud/en/prices?state=58d53a138d2f#calculator), [asymmetric](https://yandex.cloud/en/prices?state=0f25db3ff729#calculator) encryption and [asymmetric signature](https://yandex.cloud/en/prices?state=b0cf7fa8b77f#calculator), use the calculator on the {{ yandex-cloud }} website or see the pricing data in this section.


{% endnote %}



{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

The cost of using {{ kms-name }} is based on:

* Number of active key versions: versions with the `Active` and `Scheduled For Destruction` statuses.

  {% note alert %}

  After a key is deleted, all of its versions continue to be charged for 3 days [pursuant to the deletion procedure](operations/key.md#delete).

  {% endnote %}

* Number of performed cryptographic operations ([encrypt](api-ref/SymmetricCrypto/encrypt), [decrypt](api-ref/SymmetricCrypto/decrypt), [reEncrypt](api-ref/SymmetricCrypto/reEncrypt), [generateDataKey](api-ref/SymmetricCrypto/generateDataKey)).


## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


Billed hourly. The price per month is provided for reference based on 720 hours per month. The value is rounded.

### Symmetric encryption {#symmetric}




{% include [usd.md](../_pricing/kms/usd-symmetric.md) %}

{% include [usd-symmetric](../_pricing_examples/kms/usd-symmetric.md) %}


### Asymmetric encryption {#asymmetric}




{% include [usd.md](../_pricing/kms/usd-asymmetric.md) %}

{% include [usd-asymmetric](../_pricing_examples/kms/usd-asymmetric.md) %}

