---
editable: false
---

# Pricing for {{ kms-full-name }}

The cost for using {{ kms-name }} is based on:
* The number of active key versions used: versions with the `Active` and `Scheduled For Destruction` statuses.

  {% note alert %}

  After a key is deleted, all its versions continue to be charged for 3 days [according to the deletion procedure](operations/key.md#delete).

  {% endnote %}

* The number of cryptographic operations performed ([encrypt](api-ref/SymmetricCrypto/encrypt), [decrypt](api-ref/SymmetricCrypto/decrypt), [reEncrypt](api-ref/SymmetricCrypto/reEncrypt), [generateDataKey](api-ref/SymmetricCrypto/generateDataKey)).

## Pricing {#prices}

{% if region == "ru"%}

{% include [rub.md](../_pricing/kms/rub.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/kms/kzt.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/kms/usd.md) %}

{% endif %}