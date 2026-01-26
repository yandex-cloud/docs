---
title: '{{ kms-full-name }} pricing policy'
description: This article covers the {{ kms-name }} pricing policy.
editable: false
---

# {{ kms-name }} pricing policy

{% note tip %}




To calculate the cost of [symmetric](https://yandex.cloud/en/prices?state=58d53a138d2f#calculator) and [asymmetric](https://yandex.cloud/en/prices?state=0f25db3ff729#calculator) encryption and [asymmetric signature](https://yandex.cloud/en/prices?state=b0cf7fa8b77f#calculator), use our calculator on the {{ yandex-cloud }} website or see the pricing info below.



{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

The cost of using {{ kms-name }} is based on:

* Number of active key versions: versions with the `Active` and `Scheduled For Destruction` statuses.

  {% note alert %}

  After a key is deleted, all its versions are still charged for three days, [as per the deletion process](operations/key.md#delete).

  {% endnote %}

* Number of performed cryptographic operations ([encrypt](api-ref/SymmetricCrypto/encrypt), [decrypt](api-ref/SymmetricCrypto/decrypt), [reEncrypt](api-ref/SymmetricCrypto/reEncrypt), and [generateDataKey](api-ref/SymmetricCrypto/generateDataKey)).


## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

Billing occurs on an hourly basis. The price per month is provided for reference based on 720 hours per month. The value is rounded.




<MDX>
  <PriceList
    serviceIds={['{{ pcs|kms }}']}
    excludeSkuIds={['{{ pc|kms.api.v1.generatedatakey }}', '{{ pc|kms.api.v1.hsm.encryptdecrypt }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>


## Cost calculation example {#price-example}

### Symmetric encryption {#symmetric}




{% include [usd-symmetric](../_pricing_examples/kms/usd-symmetric.md) %}


### Asymmetric encryption {#asymmetric}




{% include [usd-asymmetric](../_pricing_examples/kms/usd-asymmetric.md) %}


