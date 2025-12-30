---
title: Правила тарификации для {{ at-full-name }}
description: В статье содержатся правила тарификации сервиса {{ at-name }}.
editable: false
---

# Правила тарификации для {{ at-full-name }}

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

Тарифицируются доставленные события [уровня сервисов](./concepts/events-data-plane.md).

События [уровня конфигурации](./concepts/events.md) в настоящий момент не тарифицируются.


## Цены для региона Россия {#prices}



{% include [prices-nds-note](../_includes/prices-nds-note.md) %}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|audit-trails }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>





### Формула расчета стоимости {#price-formula}

{% include [prices-difference](../_includes/prices-difference.md) %}

Стоимость доставленных событий уровня сервисов рассчитывается пропорционально их количеству.

Например, стоимость доставки 17&nbsp;000 событий составит:


{% list tabs group=pricing %}

- Стоимость в рублях {#prices-rub}

  {% include [rub-formula](../_pricing_examples/audit-trails/rub-formula.md) %}

- Стоимость в тенге {#prices-kzt}

  {% include [kzt-formula](../_pricing_examples/audit-trails/kzt-formula.md) %}

{% endlist %}






### Примеры расчета стоимости {#price-example}

##### Пример 1

  Расчет стоимости доставки событий получения содержимого секрета {{ lockbox-full-name }}, зашифрованного ключом шифрования {{ kms-full-name }}:
  * При каждом обращении к секрету доставляются два события: событие [доступа к содержимому секрета](./concepts/events-data-plane.md#lockbox) {{ lockbox-short-name }} и событие [расшифрования](./concepts/events-data-plane.md#kms) содержимого секрета с помощью ключа {{ kms-short-name }}.
  * Количество обращений к секрету: 7 000.

  
  {% list tabs group=pricing %}

  - Расчет в рублях {#prices-rub}

    {% include [rub-lockbox](../_pricing_examples/audit-trails/rub-lockbox.md) %}

  - Расчет в тенге {#prices-kzt}

    {% include [kzt-lockbox](../_pricing_examples/audit-trails/kzt-lockbox.md) %}

  {% endlist %}






##### Пример 2

  Расчет стоимости доставки событий при работе с бакетами {{ objstorage-full-name }}.

  Общее количество доставленных событий: 25 000. Из них:
  * Количество событий [уровня конфигурации](./concepts/events.md#objstorage), переданных при работе с бакетами: 1 000.
      В это число вошли события по созданию и удалению бакетов, изменению политик доступа, настроек ACL и шифрования.

  * Количество событий [уровня сервисов](./concepts/events-data-plane.md#objstorage), переданных при работе с бакетами: 24 000.
      В это число вошли события по созданию объектов в бакетах и изменению тегов объектов.

  
  {% list tabs group=pricing %}

  - Расчет в рублях {#prices-rub}

    {% include [rub-storage](../_pricing_examples/audit-trails/rub-storage.md) %}

  - Расчет в тенге {#prices-kzt}

    {% include [kzt-storage](../_pricing_examples/audit-trails/kzt-storage.md) %}

  {% endlist %}





