# Правила тарификации для {{ interconnect-name }}

Чтобы рассчитать стоимость использования сервиса, ознакомьтесь с тарифами в этом разделе.

Цены на продукты сервиса также доступны в [Прайс-листе](https://yandex.cloud/ru/price-list).


Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.

{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../billing/quickstart/index.md).

{% endnote %}

Услуга предоставляется при наличии технической возможности.

## Из чего складывается стоимость использования {#rules}

При организации `приватного` или `публичного` **соединения** расчет стоимости учитывает:
* [Стоимость физических портов](#other-services) для [транкового подключения](concepts/trunk.md).
* [Стоимость объема данных](#data) передаваемых через [транковое подключение](concepts/trunk.md).
* [Стоимость количества приватных и публичных соединений в транковом подключении](#other-services).

**Расчет стоимости для транкового подключения с одним физическим портом 10GBASE-LR, объемом данных 300 ТБ и двумя приватными соединениями к двум виртуальным сетям VPC**:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  > 1 × {{ sku|RUB|interconnect.trunk.physical_port.10gbase_lr.monthly_usage.v1|string }} + {{ sku|RUB|interconnect.trunk.direct.1gbps.unmetered.monthly_usage.v1|string }} + 2 × {{ sku|RUB|interconnect.trunk.hosted_connections.v1|string }} = {% calc [currency=RUB] 1 × {{ sku|RUB|interconnect.trunk.physical_port.10gbase_lr.monthly_usage.v1|number }} + {{ sku|RUB|interconnect.trunk.direct.1gbps.unmetered.monthly_usage.v1|number }} + 2 × {{ sku|RUB|interconnect.trunk.hosted_connections.v1|number }} %}
  >
  > Итого: {% calc [currency=RUB] {{ sku|RUB|interconnect.trunk.physical_port.10gbase_lr.monthly_usage.v1|number }} + {{ sku|RUB|interconnect.trunk.direct.1gbps.unmetered.monthly_usage.v1|number }} + 2 × {{ sku|RUB|interconnect.trunk.hosted_connections.v1|number }} %} - стоимость использования транкового подключения с одним физическим портом **10GBASE-LR**, объёмом трафика **300 ТБ** и **двумя** приватными соединениями.
  
  Где:
  * 1 — количество физических портов **10GBASE-LR** в транковом подключении.
  * {{ sku|RUB|interconnect.trunk.physical_port.10gbase_lr.monthly_usage.v1|string }} — стоимость использования физических портов **10GBASE-LR** в транковом подключении за месяц.
  * {{ sku|RUB|interconnect.trunk.direct.1gbps.unmetered.monthly_usage.v1|string }} — стоимость объема данных **300 ТБ** в транковом подключении за месяц.
  * 2 — количество приватных соедиенией в транковом подключении.
  * {{ sku|RUB|interconnect.trunk.hosted_connections.v1|string }} — стоимость использования одного приватного или публичного соединения за месяц.

{% endlist %}


## Начало тарификации {#billing} 

Моментом начала автоматической тарификации по услуге считается одно из двух событий, которое произошло ранее:
* Переход [BGP-сессии](concepts/priv-con.md#bgp-peering) любого из [приватных соединений](concepts/priv-con.md) в транковом подключении в состояние `Active`.
* Прошло 90 дней с момента создания [транкового подключения](concepts/trunk.md) (резервирование порта) на оборудовании {{ yandex-cloud }}. Состояние физического порта (портов) транкового подключения при этом значения не имеет.


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |