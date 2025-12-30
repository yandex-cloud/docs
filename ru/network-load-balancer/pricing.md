---
title: Правила тарификации для {{ network-load-balancer-full-name }}
description: В статье содержатся правила тарификации сервиса {{ network-load-balancer-name }}.
editable: false
---

# Правила тарификации для {{ network-load-balancer-name }}

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

В рамках {{ network-load-balancer-full-name }} оплачиваются объем входящего и исходящего трафика, обработанного балансировщиком, и количество сетевых балансировщиков.

Для сетевого балансировщика с публичным IP-адресом исходящий трафик в интернете дополнительно тарифицируется аналогично другим сервисам [{{ yandex-cloud }}](../vpc/pricing.md#prices-traffic). В состав исходящего трафика также включается трафик ответов целевых ресурсов на проверки состояния.


## Цены для региона Россия {#prices}




{% include [prices-nds-note](../_includes/prices-nds-note.md) %}


{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

Тарифицируется трафик, поступающий на пару из IP-адреса и порта, указанную в качестве обработчика сетевого балансировщика. Остальной трафик, поступающий на балансировщик, не принимается и не тарифицируется.

Сетевые балансировщики нагрузки тарифицируются, если у них есть обработчик и подключенная непустая целевая группа.

Если у сетевого балансировщика нет подключенных целевых групп, но есть обработчик, то публичный IP-адрес обработчика тарифицируется как [неактивный публичный IP-адрес](../vpc/pricing.md#prices-public-ip).


<MDX>
  <PriceList
    serviceIds={['{{ pcs|nlb }}']}
    excludeSkuIds={['{{ pc|nlb.vip_bytes.egress.internal }}', '{{ pc|nlb.vip_bytes.ingress.internal }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>




