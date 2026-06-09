# Правила тарификации для {{ kms-name }}

{% note tip %}


Чтобы рассчитать стоимость [симметричного](https://yandex.cloud/ru/prices?state=143214c6d306#calculator), [ассиметричного](https://yandex.cloud/ru/prices?state=f4147c7925d1#calculator) шифрования и [ассиметричной подписи](https://yandex.cloud/ru/prices?state=80d5cab43182#calculator), воспользуйтесь калькулятором на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.





{% endnote %}

Цены на продукты сервиса также доступны в [Прайс-листе](https://yandex.cloud/ru/price-list).


Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.

Стоимость использования {{ kms-name }} складывается из:

* Количества активных версий ключа — версий в статусе `Active` и `Scheduled For Destruction`.

  {% note alert %}

  После удаления ключа все его версии продолжают тарифицироваться в течение 3 дней [согласно процедуре удаления](operations/key.md#delete).

  {% endnote %}

* Числа выполненных криптографических операций ([encrypt](api-ref/SymmetricCrypto/encrypt.md), [decrypt](api-ref/SymmetricCrypto/decrypt.md), [reEncrypt](api-ref/SymmetricCrypto/reEncrypt.md), [generateDataKey](api-ref/SymmetricCrypto/generateDataKey.md)).


## Цены для региона Россия {#prices}



{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../billing/quickstart/index.md).

{% endnote %}




| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |




## Примеры расчета стоимости

В приведенных примерах цена за месяц использования указывается для справки из расчета 720 часов в месяц. 

### Симметричное шифрование {#symmetric}


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Например, если c одной версией симметричного ключа выполнено 10&nbsp;000 операций, а с другой — 20&nbsp;000, стоимость за месяц (720 часов) составит:
  
  > 720 × {{ sku|RUB|kms.storage.v1.software|string }}&nbsp;×&nbsp;2 + ({{ sku|RUB|kms.api.v1.encryptdecrypt|string }}&nbsp;×&nbsp;10&nbsp;000&nbsp;/&nbsp;10&nbsp;000) + ({{ sku|RUB|kms.api.v1.encryptdecrypt|string }}&nbsp;×&nbsp;20&nbsp;000&nbsp;/&nbsp;10&nbsp;000) = {% calc [currency=RUB] 720 × {{ sku|RUB|kms.storage.v1.software|number }} × 2 + ({{ sku|RUB|kms.api.v1.encryptdecrypt|number }} × 10000 / 10000) + ({{ sku|RUB|kms.api.v1.encryptdecrypt|number }} × 20000 / 10000) %}

- Расчет в тенге {#prices-kzt}

  Например, если c одной версией симметричного ключа выполнено 10&nbsp;000 операций, а с другой — 20&nbsp;000, стоимость за месяц (720 часов) составит:
  
  > 720 × {{ sku|KZT|kms.storage.v1.software|string }}&nbsp;×&nbsp;2 + ({{ sku|KZT|kms.api.v1.encryptdecrypt|string }}&nbsp;×&nbsp;10&nbsp;000&nbsp;/&nbsp;10&nbsp;000) + ({{ sku|KZT|kms.api.v1.encryptdecrypt|string }}&nbsp;×&nbsp;20&nbsp;000&nbsp;/&nbsp;10&nbsp;000) = {% calc [currency=KZT] 720 × {{ sku|KZT|kms.storage.v1.software|number }} × 2 + ({{ sku|KZT|kms.api.v1.encryptdecrypt|number }} × 10000 / 10000) + ({{ sku|KZT|kms.api.v1.encryptdecrypt|number }} × 20000 / 10000) %}

{% endlist %}




### Асимметричное шифрование {#asymmetric}


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Например, если c одной версией асимметричного ключа выполнено 40&nbsp;000 операций для алгоритма ECDSA, а с другой — 30&nbsp;000 для алгоритма RSA3072, стоимость за месяц составит:
  
  > {{ sku|RUB|kms.storage.asymmetric.v1|string }}&nbsp;×&nbsp;2 + ({{ sku|RUB|kms.api.asymmetric.v1|string }}&nbsp;×&nbsp;40&nbsp;000&nbsp;/&nbsp;10&nbsp;000) + ({{ sku|RUB|kms.api.asymmetric.heavy.v1|string }}&nbsp;×&nbsp;30&nbsp;000&nbsp;/&nbsp;10&nbsp;000) = {% calc [currency=RUB] {{ sku|RUB|kms.storage.asymmetric.v1|number }} × 2 + ({{ sku|RUB|kms.api.asymmetric.v1|number }} × 40000 / 10000) + ({{ sku|RUB|kms.api.asymmetric.heavy.v1|number }} × 30000 / 10000) %}

- Расчет в тенге {#prices-kzt}

  Например, если c одной версией асимметричного ключа выполнено 40&nbsp;000 операций для алгоритма ECDSA, а с другой — 30&nbsp;000 для алгоритма RSA3072, стоимость за месяц составит:
  
  > {{ sku|KZT|kms.storage.asymmetric.v1|string }}&nbsp;×&nbsp;2 + ({{ sku|KZT|kms.api.asymmetric.v1|string }}&nbsp;×&nbsp;40&nbsp;000&nbsp;/&nbsp;10&nbsp;000) + ({{ sku|KZT|kms.api.asymmetric.heavy.v1|string }}&nbsp;×&nbsp;30&nbsp;000&nbsp;/&nbsp;10&nbsp;000) = {% calc [currency=KZT] {{ sku|KZT|kms.storage.asymmetric.v1|number }} × 2 + ({{ sku|KZT|kms.api.asymmetric.v1|number }} × 40000 / 10000) + ({{ sku|KZT|kms.api.asymmetric.heavy.v1|number }} × 30000 / 10000) %}

{% endlist %}