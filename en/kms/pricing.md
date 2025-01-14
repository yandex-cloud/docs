---
title: '{{ kms-full-name }} pricing policy'
description: This article provides the {{ kms-name }} pricing policy.
editable: false
---

# {{ kms-name }} pricing policy


{% note tip %}




To see the cost of [asymmetric](https://yandex.cloud/en/prices?state=a1fc9c751190#calculator) and [symmetric](https://yandex.cloud/en/prices?state=d5480838c2c3#calculator) encryption, as well as [asymmetric signature](https://yandex.cloud/en/prices?state=0b13e46af929#calculator), use our calculator on the Yandex Cloud website or see the pricing in this section.


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

