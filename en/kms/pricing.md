---
editable: false
---

# Pricing for {{ kms-full-name }}

{% if product == "cloud-il" %}

{% note info %}

The prices listed below will take effect on November 14, 2022, when {{ kms-name }} [becomes public](../overview/concepts/launch-stages.md). Until then, the service can be used free of charge.

{% endnote %}

{% endif %}

The cost of {{ kms-name }} usage is based on:
* The number of active key versions used: versions with the `Active` and `Scheduled For Destruction` statuses.

   {% note alert %}

   After a key is deleted, all of its versions continue to be charged for 3 days [pursuant to the deletion procedure](operations/key.md#delete).

   {% endnote %}

* The number of cryptographic operations performed ([encrypt](api-ref/SymmetricCrypto/encrypt), [decrypt](api-ref/SymmetricCrypto/decrypt), [reEncrypt](api-ref/SymmetricCrypto/reEncrypt), [generateDataKey](api-ref/SymmetricCrypto/generateDataKey)).

## Pricing {% if product == "cloud-il" %}starting November 14, 2022{% endif %} {#prices}

{% if product == "yandex-cloud" %}

{% if region == "ru"%}

{% include [rub.md](../_pricing/kms/rub.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/kms/kzt.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/kms/usd.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils.md](../_pricing/kms/ils.md) %}

{% endif %}