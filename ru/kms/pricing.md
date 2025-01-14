---
title: Правила тарификации для {{ kms-full-name }}
description: В статье содержатся правила тарификации сервиса {{ kms-name }}.
editable: false
---

# Правила тарификации для {{ kms-name }}


{% note tip %}


Чтобы рассчитать стоимость [симметричного](https://yandex.cloud/ru/prices?state=c217a2de7c35#calculator), [ассиметричного](https://yandex.cloud/ru/prices?state=552d16ce07df#calculator) шифрования и [ассиметричной подписи](https://yandex.cloud/ru/prices?state=3b03fab9e1c3#calculator), воспользуйтесь калькулятором на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.




{% endnote %}



{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

Стоимость использования {{ kms-name }} складывается из:

* Количества активных версий ключа — версий в статусе `Active` и `Scheduled For Destruction`.

  {% note alert %}

  После удаления ключа все его версии продолжают тарифицироваться в течение 3 дней [согласно процедуре удаления](operations/key.md#delete).

  {% endnote %}

* Числа выполненных криптографических операций ([encrypt](api-ref/SymmetricCrypto/encrypt), [decrypt](api-ref/SymmetricCrypto/decrypt), [reEncrypt](api-ref/SymmetricCrypto/reEncrypt), [generateDataKey](api-ref/SymmetricCrypto/generateDataKey)).


## Цены для региона Россия {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


Тарификация почасовая. Цена за месяц использования указывается для справки из расчета 720 часов в месяц. Значение округлено.

### Симметричное шифрование {#symmetric}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-symmetric](../_pricing/kms/rub-symmetric.md) %}

  {% include [rub-symmetric](../_pricing_examples/kms/rub-symmetric.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-symmetric](../_pricing/kms/kzt-symmetric.md) %}

  {% include [kzt-symmetric](../_pricing_examples/kms/kzt-symmetric.md) %}

{% endlist %}




### Асимметричное шифрование {#asymmetric}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-asymmetric](../_pricing/kms/rub-asymmetric.md) %}

  {% include [rub-asymmetric](../_pricing_examples/kms/rub-asymmetric.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-asymmetric](../_pricing/kms/kzt-asymmetric.md) %}

  {% include [kzt-asymmetric](../_pricing_examples/kms/kzt-asymmetric.md) %}

{% endlist %}



