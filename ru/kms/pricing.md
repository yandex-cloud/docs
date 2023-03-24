---
editable: false
---

# Правила тарификации для {{ kms-name }}

Расчет стоимости использования {{ kms-name }} складывается из:
* Количества активных версий ключа — версий в статусе `Active` и `Scheduled For Destruction`.

  {% note alert %}

  После удаления ключа все его версии продолжают тарифицироваться в течение 3 дней [согласно процедуре удаления](operations/key.md#delete).

  {% endnote %}

* Числа выполненных криптографических операций ([encrypt](api-ref/SymmetricCrypto/encrypt), [decrypt](api-ref/SymmetricCrypto/decrypt), [reEncrypt](api-ref/SymmetricCrypto/reEncrypt), [generateDataKey](api-ref/SymmetricCrypto/generateDataKey)).

## Цены {#prices}

Тарификация почасовая. Цена за месяц приводится только для справки. Из расчета 720 часов (30 дней) в месяце. Значение округлено.



{% include [rub.md](../_pricing/kms/rub.md) %}





