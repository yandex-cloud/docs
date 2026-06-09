# Правила тарификации для {{ lockbox-name }}

Чтобы рассчитать стоимость использования сервиса, ознакомьтесь с тарифами в этом разделе.

Цены на продукты сервиса также доступны в [Прайс-листе](https://yandex.cloud/ru/price-list).


Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.

Расчет стоимости использования {{ lockbox-name }} складывается из:

* Количества версий секретов.
* Числа выполненных операций [get](api-ref/Payload/get.md) с секретом.

Использование секретов, созданных с помощью сервиса {{ connection-manager-name }}, не тарифицируется.


## Цены для региона Россия {#prices}



{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../billing/quickstart/index.md).

{% endnote %}


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |





### Пример расчета стоимости {#price-example}

Пример расчета стоимости использования {{ lockbox-name }} в месяц для следующей конфигурации:

* количество секретов: 3, у каждого секрета 5 версий;
* количество операций `get` со всеми секретами: 20 000.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  > 3 × 5 × 720 × {{ sku|RUB|lockbox.storage.v1.active_secrets|string }} = {% calc [currency=RUB] 3 × 5 × 720 × {{ sku|RUB|lockbox.storage.v1.active_secrets|number }} %}
  > 20 000 / 10 000 × {{ sku|RUB|lockbox.api.v1.get|string }} = {% calc [currency=RUB] 20000 / 10000 × {{ sku|RUB|lockbox.api.v1.get|number }} %}
  
  > Итого: {% calc [currency=RUB] 3 × 5 × 720 × {{ sku|RUB|lockbox.storage.v1.active_secrets|number }} %} + {% calc [currency=RUB] 20000 / 10000 × {{ sku|RUB|lockbox.api.v1.get|number }} %} = {% calc [currency=RUB] (3 × 5 × 720 × {{ sku|RUB|lockbox.storage.v1.active_secrets|number }}) + (20000 / 10000 × {{ sku|RUB|lockbox.api.v1.get|number }}) %} — стоимость использования {{ lockbox-name }} за один месяц, вкл. НДС.
  
  Где:
  * 3 × 5 — количество версий всех секретов.
  * 720 × {{ sku|RUB|lockbox.storage.v1.active_secrets|string }} — цена за хранение одной версии секрета в месяц (вкл. НДС). 720 — количество часов в месяц, зафиксированное для удобства расчетов.
  * 20 000 — количество операций `get`.
  * {{ sku|RUB|lockbox.api.v1.get|string }} — цена за 10 000 операций `get`, вкл. НДС.

- Расчет в тенге {#prices-kzt}

  > 3 × 5 × 720 × {{ sku|KZT|lockbox.storage.v1.active_secrets|string }} = {% calc [currency=KZT] 3 × 5 × 720 × {{ sku|KZT|lockbox.storage.v1.active_secrets|number }} %}
  > 20 000 / 10 000 × {{ sku|KZT|lockbox.api.v1.get|string }} = {% calc [currency=KZT] 20000 / 10000 × {{ sku|KZT|lockbox.api.v1.get|number }} %}
  
  > Итого: {% calc [currency=KZT] 3 × 5 × 720 × {{ sku|KZT|lockbox.storage.v1.active_secrets|number }} %} + {% calc [currency=KZT] 20000 / 10000 × {{ sku|KZT|lockbox.api.v1.get|number }} %} = {% calc [currency=KZT] (3 × 5 × 720 × {{ sku|KZT|lockbox.storage.v1.active_secrets|number }}) + (20000 / 10000 × {{ sku|KZT|lockbox.api.v1.get|number }}) %} — стоимость использования {{ lockbox-name }} за один месяц, вкл. НДС.
  
  Где:
  * 3 × 5 — количество версий всех секретов.
  * 720 × {{ sku|KZT|lockbox.storage.v1.active_secrets|string }} — цена за хранение одной версии секрета в месяц (вкл. НДС). 720 — количество часов в месяц, зафиксированное для удобства расчетов.
  * 20 000 — количество операций `get`.
  * {{ sku|KZT|lockbox.api.v1.get|string }} — цена за 10 000 операций `get`, вкл. НДС.

{% endlist %}