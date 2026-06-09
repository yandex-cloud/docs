# Правила тарификации для {{ at-full-name }}

Чтобы рассчитать стоимость использования сервиса, ознакомьтесь с тарифами в этом разделе.

Цены на продукты сервиса также доступны в [Прайс-листе](https://yandex.cloud/ru/price-list).


Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.

Тарифицируются доставленные события [уровня сервисов](concepts/events-data-plane.md).

События [уровня конфигурации](concepts/events.md) в настоящий момент не тарифицируются.


## Цены для региона Россия {#prices}



{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../billing/quickstart/index.md).

{% endnote %}


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |





### Формула расчета стоимости {#price-formula}

Стоимость доставленных событий уровня сервисов рассчитывается пропорционально их количеству.

Например, стоимость доставки 17&nbsp;000 событий составит:


{% list tabs group=pricing %}

- Стоимость в рублях {#prices-rub}

  > (17&nbsp;000 / 100&nbsp;000) × {{ sku|RUB|audit-trails.events.data_plane.v1|string }} = 0,17 × {{ sku|RUB|audit-trails.events.data_plane.v1|string }} = {% calc [currency=RUB] 0,17 × {{ sku|RUB|audit-trails.events.data_plane.v1|number }} %}
  >
  > Итого: {% calc [currency=RUB] 0,17 × {{ sku|RUB|audit-trails.events.data_plane.v1|number }} %}

- Стоимость в тенге {#prices-kzt}

  > (17&nbsp;000 / 100&nbsp;000) × {{ sku|KZT|audit-trails.events.data_plane.v1|string }} = 0,17 × {{ sku|KZT|audit-trails.events.data_plane.v1|string }} = {% calc [currency=KZT] 0,17 × {{ sku|KZT|audit-trails.events.data_plane.v1|number }} %}
  > 
  > Итого: {% calc [currency=KZT] 0,17 × {{ sku|KZT|audit-trails.events.data_plane.v1|number }} %}

{% endlist %}






### Примеры расчета стоимости {#price-example}

##### Пример 1

  Расчет стоимости доставки событий получения содержимого секрета {{ lockbox-full-name }}, зашифрованного ключом шифрования {{ kms-full-name }}:
  * При каждом обращении к секрету доставляются два события: событие [доступа к содержимому секрета](concepts/events-data-plane.md#lockbox) {{ lockbox-short-name }} и событие [расшифрования](concepts/events-data-plane.md#kms) содержимого секрета с помощью ключа {{ kms-short-name }}.
  * Количество обращений к секрету: 7 000.

  
  {% list tabs group=pricing %}

  - Расчет в рублях {#prices-rub}

    > (2 × 7&nbsp;000 / 100&nbsp;000) × {{ sku|RUB|audit-trails.events.data_plane.v1|string }} = 0,14 × {{ sku|RUB|audit-trails.events.data_plane.v1|string }} = {% calc [currency=RUB] 0,14 × {{ sku|RUB|audit-trails.events.data_plane.v1|number }} %}
    >
    > Итого: {% calc [currency=RUB] 0,14 × {{ sku|RUB|audit-trails.events.data_plane.v1|number }} %}
    
    Где:
    
    * 2 — количество доставляемых событий при одном обращении к секрету.
    * 7&nbsp;000 — количество обращений к секрету.
    * {{ sku|RUB|audit-trails.events.data_plane.v1|string }} — цена за доставку 100&nbsp;000 событий.
    * 100&nbsp;000 — делим, чтобы привести количество событий к единице тарификации.

  - Расчет в тенге {#prices-kzt}

    > (2 × 7&nbsp;000 / 100&nbsp;000) × {{ sku|KZT|audit-trails.events.data_plane.v1|string }} = 0,14 × {{ sku|KZT|audit-trails.events.data_plane.v1|string }} = {% calc [currency=KZT] 0,14 × {{ sku|KZT|audit-trails.events.data_plane.v1|number }} %}
    >
    > Итого: {% calc [currency=KZT] 0,14 × {{ sku|KZT|audit-trails.events.data_plane.v1|number }} %}
    
    Где:
    
    * 2 — количество доставляемых событий при одном обращении к секрету.
    * 7&nbsp;000 — количество обращений к секрету.
    * {{ sku|KZT|audit-trails.events.data_plane.v1|string }} — цена за доставку 100&nbsp;000 событий.
    * 100&nbsp;000 — делим, чтобы привести количество событий к единице тарификации.

  {% endlist %}






##### Пример 2

  Расчет стоимости доставки событий при работе с бакетами {{ objstorage-full-name }}.

  Общее количество доставленных событий: 25 000. Из них:
  * Количество событий [уровня конфигурации](concepts/events.md#objstorage), переданных при работе с бакетами: 1 000.
      В это число вошли события по созданию и удалению бакетов, изменению политик доступа, настроек ACL и шифрования.

  * Количество событий [уровня сервисов](concepts/events-data-plane.md#objstorage), переданных при работе с бакетами: 24 000.
      В это число вошли события по созданию объектов в бакетах и изменению тегов объектов.

  
  {% list tabs group=pricing %}

  - Расчет в рублях {#prices-rub}

    > ((25&nbsp;000 - 1&nbsp;000) / 100&nbsp;000) × {{ sku|RUB|audit-trails.events.data_plane.v1|string }} = 0,24 × {{ sku|RUB|audit-trails.events.data_plane.v1|string }} = {% calc [currency=RUB] 0,24 × {{ sku|RUB|audit-trails.events.data_plane.v1|number }} %}
    >
    > Итого: {% calc [currency=RUB] 0,24 × {{ sku|RUB|audit-trails.events.data_plane.v1|number }} %}
    
    Где:
    
    * 25&nbsp;000 — общее количество доставленных событий {{ objstorage-name }}.
    * 1&nbsp;000 — количество доставленных событий уровня конфигурации, которые не тарифицируются.
    * {{ sku|RUB|audit-trails.events.data_plane.v1|string }} — цена за доставку 100&nbsp;000 событий.
    * 100&nbsp;000 — делим, чтобы привести количество событий к единице тарификации.

  - Расчет в тенге {#prices-kzt}

    > ((25&nbsp;000 - 1&nbsp;000) / 100&nbsp;000) × {{ sku|KZT|audit-trails.events.data_plane.v1|string }} = 0,24 × {{ sku|KZT|audit-trails.events.data_plane.v1|string }} = {% calc [currency=KZT] 0,24 × {{ sku|KZT|audit-trails.events.data_plane.v1|number }} %}
    >
    > Итого: {% calc [currency=KZT] 0,24 × {{ sku|KZT|audit-trails.events.data_plane.v1|number }} %}
    
    Где:
    
    * 25&nbsp;000 — общее количество доставленных событий {{ objstorage-name }}.
    * 1&nbsp;000 — количество доставленных событий уровня конфигурации, которые не тарифицируются.
    * {{ sku|KZT|audit-trails.events.data_plane.v1|string }} — цена за доставку 100&nbsp;000 событий.
    * 100&nbsp;000 — делим, чтобы привести количество событий к единице тарификации.

  {% endlist %}