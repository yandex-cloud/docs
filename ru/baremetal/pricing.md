---
title: Правила тарификации для {{ baremetal-full-name }}
description: В статье содержатся правила тарификации сервиса {{ baremetal-name }}.
editable: false
---

# Правила тарификации для {{ baremetal-full-name }}




{% include [vat](../_includes/vat.md) %}

В сервисе {{ baremetal-name }} оплачивается срок аренды сервера [определенной конфигурации](concepts/server-configurations.md). Арендованный сервер тарифицируется в течение всего периода аренды, независимо от того, включен он или выключен.

Цены за месяц использования формируются из расчета 720 часов в месяц.

{% include [public-net-bandwidth-restrictions](../_includes/baremetal/public-net-bandwidth-restrictions.md) %}

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


Все цены указаны за 1 месяц.

{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-servers.md](../_pricing/baremetal/rub-servers.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-servers.md](../_pricing/baremetal/kzt-servers.md) %}

{% endlist %}




#### Цены на промо-конфигурации {#promo}

{% note info %}

Цены на промо-конфигурации действуют с 00:00 19.09.2025 по 23:59 31.12.2025.

{% endnote %}


Все цены указаны за 1 месяц.

{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-servers.md](../_pricing/baremetal/rub-servers-promo.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-servers.md](../_pricing/baremetal/kzt-servers-promo.md) %}

{% endlist %}



{% note info %}

Серверы, находящиеся на [карантине](./concepts/servers.md#quarantine), не тарифицируются. При этом, если в течение срока карантина сервер будет восстановлен для дальнейшего использования, то период времени, в течение которого этот сервер находился на карантине, будет включен в оплачиваемый срок аренды.

{% endnote %}

### Выделенные публичные подсети {#public-subnets}

{% note info %}

Цены на выделенные публичные подсети действуют с 15 мая 2025 года.

{% endnote %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-subnets](../_pricing/baremetal/rub-subnets.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-subnets](../_pricing/baremetal/kzt-subnets.md) %}

{% endlist %}



^1^ Цена за месяц приводится только для справки. Из расчета 720 часов (30 дней) в месяце. Сервис {{ billing-name }} при расчетах использует цену за час.



### Подключение пакета трафика для публичной сети {#bandwidth-package}

{% note info %}

Чтобы запросить пакет данных на 100 ТБ, обратитесь в [техническую поддержку]({{ link-console-support }}).

{% endnote %}

_Объем данных_ — это единица тарификации услуги, которая равна объему трафика, передаваемого в течение суток. Цены за сутки использования формируются из расчета 24 часов.

Доступно для подключения:



{% list tabs group=pricing %}

- Цены в рублях {#prices-bandwidth-rub}
  
  {% include [rub-bandwidth-restrictions](../_pricing/baremetal/rub-bandwidth.md) %}

- Цены в тенге {#prices-bandwidth-kzt}

  {% include [kzt-bandwidth-restrictions](../_pricing/baremetal/kzt-bandwidth.md) %}

{% endlist %}



### Особенности тарификации сетевого трафика в {{ baremetal-full-name }} при взаимодействии с другими сервисами {{ yandex-cloud }} {#traffic-pricing-pecs}

#### {{ vpc-full-name }} {#vpc-traffic}

{% include [bms-vpc-traffic](../_includes/baremetal/bms-vpc-traffic.md) %}

#### {{ objstorage-full-name }} {#storage-traffic}

{% include [bms-s3-free-traffic](../_includes/baremetal/bms-s3-free-traffic.md) %}

#### {{ backup-full-name }} {#backup-traffic}

{% include [bms-backup-free-traffic](../_includes/baremetal/bms-backup-free-traffic.md) %}