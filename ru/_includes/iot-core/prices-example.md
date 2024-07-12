
Расчет стоимости использования {{ iot-name }}, если в месяц:
* отправили 2 000 000 команд;
* размер каждой команды — 1500 Б.

> (1500 / 1024) × 2 000 000
>
>Итого: 4 000 000 — количество отправленных сообщений.

{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-iot-core](../../_pricing_examples/iot-core/rub-iot-core.md) %}
  
- Расчет в тенге {#prices-kzt}

  {% include [kzt-iot-core](../../_pricing_examples/iot-core/kzt-iot-core.md) %}

{% endlist %}


