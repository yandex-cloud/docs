---
title: Правила тарификации для {{ baremetal-full-name }}
description: В статье содержатся правила тарификации сервиса {{ baremetal-name }}.
editable: false
---

# Правила тарификации для {{ baremetal-full-name }}



{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

В сервисе {{ baremetal-name }} оплачивается срок аренды сервера [определенной конфигурации](concepts/server-configurations.md). Арендованный сервер тарифицируется в течение всего периода аренды, независимо от того, включен он или выключен.

Доступное количество серверов определенной конфигурации указано в [калькуляторе](https://yandex.cloud/ru/prices) на сайте {{ yandex-cloud }} и в [консоли управления]({{ link-console-main }}) при выборе сервера.

Цены за месяц использования формируются из расчета 720 часов в месяц.

## Цены для региона Россия {#prices}

{% include [prices-nds-note](../_includes/prices-nds-note.md) %}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

Стоимость может зависеть от [периода аренды](../baremetal/concepts/servers.md#server-lease).

Списание средств происходит **ежемесячно**, независимо от периода аренды.

Все цены указаны за 1 месяц.

### Стоимость готовых конфигураций серверов {#standard}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-servers.md](../_pricing/baremetal/rub-servers.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-servers.md](../_pricing/baremetal/kzt-servers.md) %}

{% endlist %}



#### Конфигурации серверов по сниженным ценам {#promo}

##### Сниженные цены с 27.11.2025 до 29.12.2025 {#27-11-19-12-2025}

Арендовать данные конфигурации можно до 29.12.2025 или пока они есть в наличии. Цена действительна с момента приобретения на весь срок использования. Вы можете использовать арендованные по сниженной цене серверы до тех пор, пока самостоятельно не отмените их аренду. Получить повторно сервер по сниженной цене нельзя.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-servers.md](../_pricing/baremetal/promo/2025-black-friday/rub-servers-promo.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-servers.md](../_pricing/baremetal/promo/2025-black-friday/kzt-servers-promo.md) %}

{% endlist %}



##### Сниженные цены с 24.09.2025 по 24.10.2025 по промокодам в рамках Yandex Scale 2025 {#scale2025}

Цена действительна с момента приобретения до 23:59 31.12.2025.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-servers.md](../_pricing/baremetal/promo/2025-yandex-scale/rub-servers-promo.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-servers.md](../_pricing/baremetal/promo/2025-yandex-scale/kzt-servers-promo.md) %}

{% endlist %}



### Стоимость своих конфигураций серверов {#custom}

Итоговая стоимость своей конфигурации зависит от выбранных компонентов сервера.

{% cut "Цены на компоненты" %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-custom-servers](../_pricing/baremetal/rub-custom-servers.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-custom-servers](../_pricing/baremetal/kzt-custom-servers.md) %}

{% endlist %}



{% endcut %}

### Выделенные публичные подсети {#public-subnets}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-subnets](../_pricing/baremetal/rub-subnets.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-subnets](../_pricing/baremetal/kzt-subnets.md) %}

{% endlist %}



^1^ Цена за месяц приводится только для справки. Из расчета 720 часов (30 дней) в месяце. Сервис {{ billing-name }} при расчетах использует цену за час.



### Подключение пакета трафика для публичной сети {#bandwidth-package}

_Объем данных_ — это единица тарификации услуги, которая равна объему трафика, передаваемого в течение суток. Цены за сутки использования формируются из расчета 24 часов.

{% include [public-net-bandwidth-restrictions](../_includes/baremetal/public-net-bandwidth-restrictions.md) %}

{% note info %}

Чтобы запросить пакет данных на 100 ТБ, обратитесь в [техническую поддержку]({{ link-console-support }}).

{% endnote %}

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