---
editable: false
---

# Правила тарификации для {{ kms-full-name }}

{% if product == "cloud-il" %}

На стадии [Preview](../overview/concepts/launch-stages.md) использование сервиса {{ kms-name }} не тарифицируется.

{% endif %}

{% if product == "yandex-cloud" %}

Расчет стоимости использования {{ kms-name }} складывается из:
* Количества активных версий ключа — версий в статусе `Active` и `Scheduled For Destruction`.

  {% note alert %}

  После удаления ключа все его версии продолжают тарифицироваться в течение 3 дней [согласно процедуре удаления](operations/key.md#delete).

  {% endnote %}

* Числа выполненных криптографических операций ([encrypt](api-ref/SymmetricCrypto/encrypt), [decrypt](api-ref/SymmetricCrypto/decrypt), [reEncrypt](api-ref/SymmetricCrypto/reEncrypt), [generateDataKey](api-ref/SymmetricCrypto/generateDataKey)).

## Цены {#prices}

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