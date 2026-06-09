# Правила тарификации для {{ postbox-name }}


{% note tip %}


Чтобы рассчитать стоимость использования сервиса, воспользуйтесь [калькулятором](https://yandex.cloud/ru/prices?state=fdaa4b020385#calculator) на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.




{% endnote %}




Стоимость использования сервиса {{ postbox-name }} зависит от количества отправленных писем в месяц. Тарифицируются все письма, принятые для отправления, независимо от того, будут они фактически доставлены или нет. Если одно письмо отправляется нескольким получателям, количество исходящих писем считается по количеству получателей.

{% note info %}

По умолчанию в сервисе действуют квоты (например, на количество отправляемых писем), которые можно увеличить по запросу в техническую поддержку. Подробнее см. [{#T}](concepts/limits.md).

{% endnote %}


Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.

Каждый месяц не тарифицируются первые 2 000 исходящих писем.

После того как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с тарифами. Если вы не израсходовали нетарифицируемый объем услуг до конца календарного месяца, остаток обнуляется.

## Пример расчета стоимости {#price-example}

Расчет стоимости 65 500 писем в месяц:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  * первые 2 000 писем — бесплатно;
  * с 2 001 по 10 000 письмо (всего 8 000 писем) — по {{ sku|RUB|postbox.email.count.v1|pricingRate.2|string }} за каждую 1 000 писем;
  * с 10 001 по 50 000 письмо (всего 40 000 писем) — по {{ sku|RUB|postbox.email.count.v1|pricingRate.10|string }} за каждую 1 000 писем;
  * с 50 001 по 65 500 письмо (всего 15 500 писем) — по {{ sku|RUB|postbox.email.count.v1|pricingRate.50|string }} за каждую 1 000 писем.
  
  Сумма оплаты за 65 500 писем в месяц составит:
  
  > (8 × {{ sku|RUB|postbox.email.count.v1|pricingRate.2|string }}) + (40 × {{ sku|RUB|postbox.email.count.v1|pricingRate.10|string }}) + (15,5 × {{ sku|RUB|postbox.email.count.v1|pricingRate.50|string }}) = {% calc [currency=RUB] (8 × {{ sku|RUB|postbox.email.count.v1|pricingRate.2|number }}) + (40 × {{ sku|RUB|postbox.email.count.v1|pricingRate.10|number }}) + (15,5 × {{ sku|RUB|postbox.email.count.v1|pricingRate.50|number }}) %}

- Расчет в тенге {#prices-kzt}

  * первые 2 000 писем — бесплатно;
  * с 2 001 по 10 000 письмо (всего 8 000 писем) — по {{ sku|KZT|postbox.email.count.v1|pricingRate.2|string }} за каждую 1 000 писем;
  * с 10 001 по 50 000 письмо (всего 40 000 писем) — по {{ sku|KZT|postbox.email.count.v1|pricingRate.10|string }} за каждую 1 000 писем;
  * с 50 001 по 65 500 письмо (всего 15 500 писем) — по {{ sku|KZT|postbox.email.count.v1|pricingRate.50|string }} за каждую 1 000 писем.
  
  Сумма оплаты за 65 500 писем в месяц составит:
  
  > (8 × {{ sku|KZT|postbox.email.count.v1|pricingRate.2|string }}) + (40 × {{ sku|KZT|postbox.email.count.v1|pricingRate.10|string }}) + (15,5 × {{ sku|KZT|postbox.email.count.v1|pricingRate.50|string }}) = {% calc [currency=KZT] (8 × {{ sku|KZT|postbox.email.count.v1|pricingRate.2|number }}) + (40 × {{ sku|KZT|postbox.email.count.v1|pricingRate.10|number }}) + (15,5 × {{ sku|KZT|postbox.email.count.v1|pricingRate.50|number }}) %}

{% endlist %}



## Цены для региона Россия {#prices}

{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../billing/quickstart/index.md).

{% endnote %}


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |




{% note info %}

Если вы хотите отправлять более 100 000 000 писем в месяц, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру, чтобы обсудить индивидуальные условия сотрудничества.

{% endnote %}