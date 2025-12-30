---
title: Правила тарификации для {{ iot-full-name }}
description: В статье содержатся правила тарификации сервиса {{ iot-name }}.
editable: false
---

# Правила тарификации для {{ iot-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

## Из чего складывается стоимость использования {{ iot-name }} {#rules}

В рамках сервиса {{ iot-name }} тарифицируется количество сообщений. Количество сообщений считается c округлением в большую сторону по формуле: 

```text
количество сообщений = размер команды / 1 КБ
```

Например:
* Если размер команды равен 800 Б, то это одно сообщение.
* Если размер команды равен 2800 Б (2,73 КБ), то это три сообщения.

{% note info %}

[Брокер](concepts/index.md#broker) находится на стадии [Preview](../overview/concepts/launch-stages.md). Сообщения, отправленные через него, не тарифицируются.

{% endnote %}

{% include [not-charged-iot.md](../_includes/pricing/price-formula/not-charged-iot.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Пример расчета стоимости {#price-example}

{% include [prices-difference](../_includes/prices-difference.md) %}

{% include [prices-example](../_includes/iot-core/prices-example.md) %}

## Тарифицируемые команды {#mqtt-commands}

### MQTT {#mqtt}

Список команд, которые тарифицируются в сервисе {{ iot-name }}: 
* `CONNECT` — соединение клиента (устройства или реестра) с [MQTT-сервером](../glossary/mqtt-server.md) сервиса.
* `PUBLISH` — отправка сообщения от клиента (устройства или реестра) к MQTT-серверу сервиса.
* `SUBSCRIBE` — подписка клиента (устройством или реестром) на сообщения от MQTT-сервера сервиса.
* `PUBLISH` — отправка сообщения от MQTT-сервера сервиса к клиенту (устройства или реестра).
* `PINGREQ` — проверка соединения от клиента (устройства или реестра) к MQTT-серверу сервиса.

## Цены для региона Россия {#prices}

{% include [prices-nds-note](../_includes/prices-nds-note.md) %}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|iot }}']}
    excludeSkuIds={['{{ pc|iot.mqtt.basic_ingest }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



