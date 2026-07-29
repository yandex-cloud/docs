---
title: Правила тарификации для {{ baremetal-full-name }}
description: В статье содержатся правила тарификации сервиса {{ baremetal-name }}.
editable: false
---

# Правила тарификации для {{ baremetal-full-name }}

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      sm: 4
    children:
      - type: basic-card
        title: Калькулятор цен
        text: Рассчитайте стоимость использования сервиса, исходя из ваших потребностей
        icon: _assets/icons/calculator.svg
        urlTitle: Калькулятор цен
        url: https://yandex.cloud/ru/prices?state=19a1a419e01b#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Прайс-лист
        text: Актуальные тарифы на все наши услуги
        icon: _assets/icons/circle-ruble.svg
        urlTitle: Прайс-лист
        url: https://yandex.cloud/ru/price-list?services=dn2jfbheag6vvls7oplt
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Акции и free tier
        text: Гранты, специальные условия и программы поддержки
        icon: _assets/icons/flame.svg
        urlTitle: Акции и free tier
        url: https://yandex.cloud/ru/all-offers
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::





{% include [vat](../_includes/vat.md) %}

В сервисе {{ baremetal-name }} оплачивается срок аренды сервера [определенной конфигурации](concepts/server-configurations.md). Арендованный сервер тарифицируется в течение всего периода аренды, независимо от того, включен он или выключен.

{% note warning %}

Прервать аренду сервера в течение выбранного периода аренды нельзя. Сервер тарифицируется за весь оплаченный период независимо от способа оплаты и порядка списания средств. Вы можете [отказаться](../baremetal/operations/servers/server-lease-cancel.md) от автоматического продления аренды — в этом случае сервер проработает до конца оплаченного периода, а затем будет удален.

{% endnote %}

Доступное количество серверов определенной конфигурации указано в [калькуляторе](https://yandex.cloud/ru/prices) на сайте {{ yandex-cloud }} и в [консоли управления]({{ link-console-main }}) при выборе сервера.

## Цены для региона Россия {#prices}

Все цены указаны за 1 месяц.

### Стоимость готовых конфигураций серверов {#standard}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

Стоимость может зависеть от [периода аренды](../baremetal/concepts/servers.md#server-lease).

Порядок списания средств зависит от способа оплаты:

* Если к платежному аккаунту привязана банковская карта, списания происходят **ежедневно** независимо от периода аренды. Общая сумма за месяц равна стоимости выбранного периода аренды.
* Для юридических лиц, работающих с оплатой по счету, счет формируется **раз в месяц** независимо от периода аренды.


<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}', '{{ pcs|baremetal_lite }}']}
    excludeSkuIds={[
      '{{ pc|baremetal.server.bms-publicannounce-pi-prefix-any.1-month }}',
      '{{ pc|baremetal.data.data-100tb.1sec }}',
      '{{ pc|baremetal.public-network.ip-address }}',
      '{{ pc|baremetal.server.bf261-i502.1-day }}',
      '{{ pc|baremetal.server.bf261-i502.1-month }}',
      '{{ pc|baremetal.server.bf261-i502.3-month }}',
      '{{ pc|baremetal.server.bf261-i502.6-month }}',
      '{{ pc|baremetal.server.bf261-i502.12-month }}',
      '{{ pc|baremetal.server.bf261-i203.1-day }}',
      '{{ pc|baremetal.server.bf261-i203.1-month }}',
      '{{ pc|baremetal.server.bf261-i203.3-month }}',
      '{{ pc|baremetal.server.bf261-i203.6-month }}',
      '{{ pc|baremetal.server.bf261-i203.12-month }}',
      '{{ pc|baremetal.server.bf261-i206.1-day }}',
      '{{ pc|baremetal.server.bf261-i206.1-month }}',
      '{{ pc|baremetal.server.bf261-i206.3-month }}',
      '{{ pc|baremetal.server.bf261-i206.6-month }}',
      '{{ pc|baremetal.server.bf261-i206.12-month }}',
      '{{ pc|baremetal.server.bf261-i208.1-day }}',
      '{{ pc|baremetal.server.bf261-i208.1-month }}',
      '{{ pc|baremetal.server.bf261-i208.3-month }}',
      '{{ pc|baremetal.server.bf261-i208.6-month }}',
      '{{ pc|baremetal.server.bf261-i208.12-month }}',
      '{{ pc|baremetal.server.bf261-i302.1-day }}',
      '{{ pc|baremetal.server.bf261-i302.1-month }}',
      '{{ pc|baremetal.server.bf261-i302.3-month }}',
      '{{ pc|baremetal.server.bf261-i302.6-month }}',
      '{{ pc|baremetal.server.bf261-i302.12-month }}',
      '{{ pc|baremetal.server.bf261-i216.1-day }}',
      '{{ pc|baremetal.server.bf261-i216.1-month }}',
      '{{ pc|baremetal.server.bf261-i216.3-month }}',
      '{{ pc|baremetal.server.bf261-i216.6-month }}',
      '{{ pc|baremetal.server.bf261-i216.12-month }}',
      '{{ pc|baremetal.server.bf261-i215.1-day }}',
      '{{ pc|baremetal.server.bf261-i215.1-month }}',
      '{{ pc|baremetal.server.bf261-i215.3-month }}',
      '{{ pc|baremetal.server.bf261-i215.6-month }}',
      '{{ pc|baremetal.server.bf261-i215.12-month }}',
      '{{ pc|baremetal.server.bf261-i209.1-day }}',
      '{{ pc|baremetal.server.bf261-i209.1-month }}',
      '{{ pc|baremetal.server.bf261-i209.3-month }}',
      '{{ pc|baremetal.server.bf261-i209.6-month }}',
      '{{ pc|baremetal.server.bf261-i209.12-month }}',
      '{{ pc|baremetal.server.bf25-i201-h.1-day }}',
      '{{ pc|baremetal.server.bf25-i201-h.1-month }}',
      '{{ pc|baremetal.server.bf25-i201-h.3-month }}',
      '{{ pc|baremetal.server.bf25-i201-h.6-month }}',
      '{{ pc|baremetal.server.bf25-i201-h.12-month }}',
      '{{ pc|baremetal.server.bf25-i202-s.1-day }}',
      '{{ pc|baremetal.server.bf25-i202-s.1-month }}',
      '{{ pc|baremetal.server.bf25-i202-s.3-month }}',
      '{{ pc|baremetal.server.bf25-i202-s.6-month }}',
      '{{ pc|baremetal.server.bf25-i202-s.12-month }}',
      '{{ pc|baremetal.server.bf25-i204-s.1-day }}',
      '{{ pc|baremetal.server.bf25-i204-s.1-month }}',
      '{{ pc|baremetal.server.bf25-i204-s.3-month }}',
      '{{ pc|baremetal.server.bf25-i204-s.6-month }}',
      '{{ pc|baremetal.server.bf25-i204-s.12-month }}',
      '{{ pc|baremetal.server.bf25-i205-s.1-day }}',
      '{{ pc|baremetal.server.bf25-i205-s.1-month }}',
      '{{ pc|baremetal.server.bf25-i205-s.3-month }}',
      '{{ pc|baremetal.server.bf25-i205-s.6-month }}',
      '{{ pc|baremetal.server.bf25-i205-s.12-month }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.1-day }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.1-month }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.3-month }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.6-month }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.12-month }}',
      '{{ pc|baremetal.public-network.subnet-31 }}',
      '{{ pc|baremetal.public-network.subnet-29 }}',
      '{{ pc|baremetal.public-network.subnet-28 }}',
      '{{ pc|baremetal.public-network.subnet-27 }}',
      '{{ pc|baremetal.public-network.subnet-26 }}',
      '{{ pc|baremetal.public-network.subnet-25 }}',
      '{{ pc|baremetal.public-network.subnet-24 }}'
    ]}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



### Стоимость своих конфигураций серверов {#custom}

Итоговая стоимость своей конфигурации зависит от выбранных компонентов сервера.

{% cut "Цены на компоненты" %}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal_custom }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



{% endcut %}

#### Конфигурации серверов по сниженным ценам {#promo}

##### Сниженные цены с 09.03.2026 до 30.04.2026 {#09-03-17-04-2026}

Арендовать данные конфигурации можно до 30.04.2026 или пока они есть в наличии. Цена действительна с момента приобретения на весь срок использования. Вы можете использовать арендованные по сниженной цене серверы до тех пор, пока самостоятельно не отмените их аренду. Получить повторно сервер по сниженной цене нельзя.


<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}']}
    skuIds={[
      '{{ pc|baremetal.server.bf261-i502.1-day }}',
      '{{ pc|baremetal.server.bf261-i502.1-month }}',
      '{{ pc|baremetal.server.bf261-i502.3-month }}',
      '{{ pc|baremetal.server.bf261-i502.6-month }}',
      '{{ pc|baremetal.server.bf261-i502.12-month }}',
      '{{ pc|baremetal.server.bf261-i203.1-day }}',
      '{{ pc|baremetal.server.bf261-i203.1-month }}',
      '{{ pc|baremetal.server.bf261-i203.3-month }}',
      '{{ pc|baremetal.server.bf261-i203.6-month }}',
      '{{ pc|baremetal.server.bf261-i203.12-month }}',
      '{{ pc|baremetal.server.bf261-i206.1-day }}',
      '{{ pc|baremetal.server.bf261-i206.1-month }}',
      '{{ pc|baremetal.server.bf261-i206.3-month }}',
      '{{ pc|baremetal.server.bf261-i206.6-month }}',
      '{{ pc|baremetal.server.bf261-i206.12-month }}',
      '{{ pc|baremetal.server.bf261-i208.1-day }}',
      '{{ pc|baremetal.server.bf261-i208.1-month }}',
      '{{ pc|baremetal.server.bf261-i208.3-month }}',
      '{{ pc|baremetal.server.bf261-i208.6-month }}',
      '{{ pc|baremetal.server.bf261-i208.12-month }}',
      '{{ pc|baremetal.server.bf261-i302.1-day }}',
      '{{ pc|baremetal.server.bf261-i302.1-month }}',
      '{{ pc|baremetal.server.bf261-i302.3-month }}',
      '{{ pc|baremetal.server.bf261-i302.6-month }}',
      '{{ pc|baremetal.server.bf261-i302.12-month }}',
      '{{ pc|baremetal.server.bf261-i216.1-day }}',
      '{{ pc|baremetal.server.bf261-i216.1-month }}',
      '{{ pc|baremetal.server.bf261-i216.3-month }}',
      '{{ pc|baremetal.server.bf261-i216.6-month }}',
      '{{ pc|baremetal.server.bf261-i216.12-month }}',
      '{{ pc|baremetal.server.bf261-i215.1-day }}',
      '{{ pc|baremetal.server.bf261-i215.1-month }}',
      '{{ pc|baremetal.server.bf261-i215.3-month }}',
      '{{ pc|baremetal.server.bf261-i215.6-month }}',
      '{{ pc|baremetal.server.bf261-i215.12-month }}',
      '{{ pc|baremetal.server.bf261-i209.1-day }}',
      '{{ pc|baremetal.server.bf261-i209.1-month }}',
      '{{ pc|baremetal.server.bf261-i209.3-month }}',
      '{{ pc|baremetal.server.bf261-i209.6-month }}',
      '{{ pc|baremetal.server.bf261-i209.12-month }}'
    ]}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



##### Сниженные цены с 27.11.2025 до 29.12.2025 {#27-11-19-12-2025}

Арендовать данные конфигурации можно до 29.12.2025 или пока они есть в наличии. Цена действительна с момента приобретения на весь срок использования. Вы можете использовать арендованные по сниженной цене серверы до тех пор, пока самостоятельно не отмените их аренду. Получить повторно сервер по сниженной цене нельзя.


<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}']}
    skuIds={[
      '{{ pc|baremetal.server.bf25-i201-h.1-day }}',
      '{{ pc|baremetal.server.bf25-i201-h.1-month }}',
      '{{ pc|baremetal.server.bf25-i201-h.3-month }}',
      '{{ pc|baremetal.server.bf25-i201-h.6-month }}',
      '{{ pc|baremetal.server.bf25-i201-h.12-month }}',
      '{{ pc|baremetal.server.bf25-i202-s.1-day }}',
      '{{ pc|baremetal.server.bf25-i202-s.1-month }}',
      '{{ pc|baremetal.server.bf25-i202-s.3-month }}',
      '{{ pc|baremetal.server.bf25-i202-s.6-month }}',
      '{{ pc|baremetal.server.bf25-i202-s.12-month }}',
      '{{ pc|baremetal.server.bf25-i204-s.1-day }}',
      '{{ pc|baremetal.server.bf25-i204-s.1-month }}',
      '{{ pc|baremetal.server.bf25-i204-s.3-month }}',
      '{{ pc|baremetal.server.bf25-i204-s.6-month }}',
      '{{ pc|baremetal.server.bf25-i204-s.12-month }}',
      '{{ pc|baremetal.server.bf25-i205-s.1-day }}',
      '{{ pc|baremetal.server.bf25-i205-s.1-month }}',
      '{{ pc|baremetal.server.bf25-i205-s.3-month }}',
      '{{ pc|baremetal.server.bf25-i205-s.6-month }}',
      '{{ pc|baremetal.server.bf25-i205-s.12-month }}'
    ]}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



##### Сниженные цены с 24.09.2025 по 24.10.2025 по промокодам в рамках Yandex Scale 2025 {#scale2025}

Цена действительна с момента приобретения до 23:59 31.12.2025.


<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}']}
    skuIds={[
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.1-day }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.1-month }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.3-month }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.6-month }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.12-month }}'
    ]}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



### Выделенные публичные подсети {#public-subnets}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}']}
    skuIds={[
      '{{ pc|baremetal.public-network.subnet-31 }}',
      '{{ pc|baremetal.public-network.subnet-29 }}',
      '{{ pc|baremetal.public-network.subnet-28 }}',
      '{{ pc|baremetal.public-network.subnet-27 }}',
      '{{ pc|baremetal.public-network.subnet-26 }}',
      '{{ pc|baremetal.public-network.subnet-25 }}',
      '{{ pc|baremetal.public-network.subnet-24 }}'
    ]}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



### Подключение пакета трафика для публичной сети {#bandwidth-package}

_Объем данных_ — это единица тарификации услуги, которая равна объему трафика, передаваемого в течение суток. Цены за сутки использования формируются из расчета 24 часов.

{% include [public-net-bandwidth-restrictions](../_includes/baremetal/public-net-bandwidth-restrictions.md) %}

{% note info %}

Чтобы запросить пакет данных на 100 ТБ, обратитесь в [техническую поддержку]({{ link-console-support }}).

{% endnote %}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}']}
    skuIds={[
      '{{ pc|baremetal.data.data-100tb.1sec }}'
    ]}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



### Анонсирование префикса PI (BYOIP) {#byoip}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}']}
    skuIds={[
      '{{ pc|baremetal.server.bms-publicannounce-pi-prefix-any.1-month }}'
    ]}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



### Особенности тарификации сетевого трафика в {{ baremetal-full-name }} при взаимодействии с другими сервисами {{ yandex-cloud }} {#traffic-pricing-pecs}

#### {{ vpc-full-name }} {#vpc-traffic}

{% include [bms-vpc-traffic](../_includes/baremetal/bms-vpc-traffic.md) %}

#### {{ objstorage-full-name }} {#storage-traffic}

{% include [bms-s3-free-traffic](../_includes/baremetal/bms-s3-free-traffic.md) %}

#### {{ backup-full-name }} {#backup-traffic}

{% include [bms-backup-free-traffic](../_includes/baremetal/bms-backup-free-traffic.md) %}






