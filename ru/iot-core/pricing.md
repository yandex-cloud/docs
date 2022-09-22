---
editable: false
---

# Правила тарификации для {{ iot-name }}

## Из чего складывается стоимость использования {{ iot-name }} {#rules}

В рамках сервиса {{ iot-name }} тарифицируется количество сообщений. Количество сообщений считается c округлением в большую сторону по формуле: 

```
количество сообщений = размер команды / 1 КБ 
```

{% note info %}

[Брокер](concepts/index.md#broker) находится на стадии [Preview](../overview/concepts/launch-stages.md). Сообщения, отправленные через него, не тарифицируются.

{% endnote %}

Например:
* Если размер команды равен 800 Б, то это одно сообщение.
* Если размер команды равен 2800 Б (2,73 КБ), то это три сообщения.

{% include [not-charged-iot.md](../_includes/pricing/price-formula/not-charged-iot.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

## Тарифицируемые команды {#mqtt-commands}

### MQTT {#mqtt}

Список команд, которые тарифицируются в сервисе {{ iot-name }}: 
* `CONNECT` — соединение клиента (устройства или реестра) с MQTT-сервером сервиса.
* `PUBLISH` — отправка сообщения от клиента (устройства или реестра) к MQTT-серверу сервиса.
* `SUBSCRIBE` — подписка клиента (устройством или реестром) на сообщения от MQTT-сервера сервиса.
* `PUBLISH` — отправка сообщения от MQTT-сервера сервиса к клиенту (устройства или реестра).
* `PINGREQ` — проверка соединения от клиента (устройства или реестра) к MQTT-серверу сервиса.

## Цены {#prices}

### Объем данных {#volumes}

{% if region == "ru" %}
   
{% include [rub.md](../_pricing/iot-core/rub.md) %}
   
{% endif %}
   
{% if region == "kz" %}
   
{% include [kzt.md](../_pricing/iot-core/kzt.md) %}
   
{% endif %}
   
{% if region == "int" %}
   
{% include [usd.md](../_pricing/iot-core/usd.md) %}
   
{% endif %}