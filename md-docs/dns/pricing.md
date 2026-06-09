# Правила тарификации для {{ dns-name }}

Чтобы рассчитать стоимость использования сервиса, ознакомьтесь с тарифами в этом разделе.

Цены на продукты сервиса также доступны в [Прайс-листе](https://yandex.cloud/ru/price-list).


Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.


## Цены для региона Россия {#prices}



{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../billing/quickstart/index.md).

{% endnote %}


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |





Тарифицируются:
* [Публичные](concepts/dns-zone.md#public-zones) или [внутренние](concepts/dns-zone.md#private-zones) DNS-зоны, созданные пользователем.

    Тарификация посекундная. Стоимость рассчитывается пропорционально потреблению. Например, стоимость владения 2 DNS-зонами в течение 360 часов будет такой же, как стоимость владения 1 DNS-зоной в течение 720 часов.

* Авторитетные запросы — любые запросы DNS-записей в [публичных зонах](concepts/dns-zone.md#public-zones) пользователя из интернета или из {{ yandex-cloud }}.
* Рекурсивные запросы — запросы внешних доменных имен в интернете из виртуальных машин {{ yandex-cloud }}.

  {% note tip %}

  Рекомендуем использовать [кеширующие резолверы](tutorials/local-dns-cache.md), например, `systemd-resolved`, `dnsmasq`, `unbound`. С их помощью можно снизить количество запросов внешних доменных имен, таким образом уменьшить расходы.

  {% endnote %}

Не тарифицируются:
* Запросы из ВМ во [внутренние](concepts/dns-zone.md#private-zones) и [сервисные](concepts/dns-zone.md#service-zones) зоны.
* [Сервисные зоны](concepts/dns-zone.md#service-zones).

**С 6 декабря 2021 года не тарифицируются**:
* Каждый месяц — первый миллион (1 000 000) рекурсивных запросов из ВМ.

  После того как вы израсходуете этот нетарифицируемый объем, начнет взиматься плата в соответствии с тарифом.

  Если вы не израсходовали нетарифицируемый объем услуг до конца календарного месяца, остаток обнуляется.
* Запросы доменных имен сервисов {{ yandex-cloud }} (например, `{{ api-host }}`) и Яндекса (например, `mail.yandex.ru`) — как из ВМ, так и из интернета.

Стоимость публичных DNS-запросов рассчитывается пропорционально потреблению.

Например, стоимость 50 тыс. авторитетных запросов к вашей публичной DNS-зоне за месяц составит:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  > (50&nbsp;000 / 1&nbsp;000&nbsp;000) × {{ sku|RUB|dns.requests.public.authoritative.v1|string }} = 0,05 × {{ sku|RUB|dns.requests.public.authoritative.v1|string }} = {% calc [currency=RUB] (50000 / 1000000) × {{ sku|RUB|dns.requests.public.authoritative.v1|number }} %}
  > 
  > Итого: {% calc [currency=RUB] (50000 / 1000000) × {{ sku|RUB|dns.requests.public.authoritative.v1|number }} %}
  
  Где:
  
  * (50&nbsp;000 / 1&nbsp;000&nbsp;000) — количество миллионов выполненных запросов.
  * {{ sku|RUB|dns.requests.public.authoritative.v1|string }} — цена за 1 млн запросов в месяц.
  
  Например, стоимость 1,2 млн рекурсивных запросов внешних имен, выполненных с 6 по 31 декабря с ваших ВМ, за месяц составит:
  
  > (1,2 − 1,0) × {{ sku|RUB|dns.requests.public.recursive.v1|pricingRate.1|string }} = 0,2 × {{ sku|RUB|dns.requests.public.recursive.v1|pricingRate.1|string }} = {% calc [currency=RUB] (1,2 - 1,0) × {{ sku|RUB|dns.requests.public.recursive.v1|pricingRate.1|number }} %}
  > 
  > Итого: {% calc [currency=RUB] (1,2 - 1,0) × {{ sku|RUB|dns.requests.public.recursive.v1|pricingRate.1|number }} %}
  
  Где:
  
  * (1,2 − 1,0) — количество миллионов выполненных запросов. Первый миллион рекурсивных запросов не тарифицируется начиная с 6 декабря 2021.
  * {{ sku|RUB|dns.requests.public.recursive.v1|pricingRate.1|string }} — цена за 1 млн рекурсивных запросов в месяц.

- Расчет в тенге {#prices-kzt}

  > (50&nbsp;000 / 1&nbsp;000&nbsp;000) × {{ sku|KZT|dns.requests.public.authoritative.v1|string }} = 0,05 × {{ sku|KZT|dns.requests.public.authoritative.v1|string }} = {% calc [currency=KZT] (50000 / 1000000) × {{ sku|KZT|dns.requests.public.authoritative.v1|number }} %}
  > 
  > Итого: {% calc [currency=KZT] (50000 / 1000000) × {{ sku|KZT|dns.requests.public.authoritative.v1|number }} %}
  
  Где:
  
  * (50&nbsp;000 / 1&nbsp;000&nbsp;000) — количество миллионов выполненных запросов.
  * {{ sku|KZT|dns.requests.public.authoritative.v1|string }} — цена за 1 млн запросов в месяц.
  
  Например, стоимость 1,2 млн рекурсивных запросов внешних имен, выполненных с 6 по 31 декабря с ваших ВМ, за месяц составит:
  
  > (1,2 − 1,0) × {{ sku|KZT|dns.requests.public.recursive.v1|pricingRate.1|string }} = 0,2 × {{ sku|KZT|dns.requests.public.recursive.v1|pricingRate.1|string }} = {% calc [currency=KZT] (1,2 - 1,0) × {{ sku|KZT|dns.requests.public.recursive.v1|pricingRate.1|number }} %}
  > 
  > Итого: {% calc [currency=KZT] (1,2 - 1,0) × {{ sku|KZT|dns.requests.public.recursive.v1|pricingRate.1|number }} %}
  
  Где:
  
  * (1,2 − 1,0) — количество миллионов выполненных запросов. Первый миллион рекурсивных запросов не тарифицируется начиная с 6 декабря 2021.
  * {{ sku|KZT|dns.requests.public.recursive.v1|pricingRate.1|string }} — цена за 1 млн рекурсивных запросов в месяц.

{% endlist %}