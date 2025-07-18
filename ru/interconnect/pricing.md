---
title: Правила тарификации для {{ interconnect-full-name }}
description: В статье содержатся правила тарификации сервиса {{ interconnect-name }}.
editable: false
---

# Правила тарификации для {{ interconnect-name }}

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

Услуга предоставляется при наличии технической возможности.

## Из чего складывается стоимость использования {#rules}

При организации `приватного` или `публичного` **соединения** расчет стоимости учитывает:
* [Стоимость физических портов](#other-services) для [транкового подключения](concepts/trunk.md).
* [Стоимость объема данных](#data) передаваемых через [транковое подключение](concepts/trunk.md).
* [Стоимость количества приватных и публичных соединений в транковом подключении](#other-services).

**Расчет стоимости для транкового подключения с одним физическим портом 10GBASE-LR, объемом данных 300 ТБ и двумя приватными соединениями к двум виртуальным сетям VPC**:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-trunk-10g300tb-prc2](../_pricing_examples/interconnect/rub-trunk10g300tb-prc2.md) %}

{% endlist %}


## Начало тарификации {#billing} 

Моментом начала автоматической тарификации по услуге считается одно из двух событий, которое произошло ранее:
* Переход [BGP-сессии](./concepts/priv-con.md#bgp-peering) любого из [приватных соединений](./concepts/priv-con.md) в транковом подключении в состояние `Active`.
* Прошло 90 дней с момента создания [транкового подключения](./concepts/trunk.md) (резервирование порта) на оборудовании {{ yandex-cloud }}. Состояние физического порта (портов) транкового подключения при этом значения не имеет.

## Объем данных {#data}


{% list tabs group=pricing %}

- Стоимость в рублях {#prices-rub}

  {% include [rub-data](../_pricing/interconnect/rub-data.md) %}

- Стоимость в тенге {#prices-kzt}

  {% include [kzt-data](../_pricing/interconnect/kzt-data.md) %}

{% endlist %}




## Прочие услуги {#other-services}


{% list tabs group=pricing %}

- Стоимость в рублях {#prices-rub}

  {% include [rub-other-services](../_pricing/interconnect/rub-other-services.md) %}

- Стоимость в тенге {#prices-kzt}

  {% include [kzt-other-services](../_pricing/interconnect/kzt-other-services.md) %}

{% endlist %}





