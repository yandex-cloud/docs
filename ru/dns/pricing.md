---
editable: false
---

# Правила тарификации для {{ dns-name }}

## Публичные DNS-запросы {#public-dns-requests}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub-public-dns-requests.md](../_pricing/dns/rub-public-dns-requests.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-public-dns-requests.md](../_pricing/dns/kzt-public-dns-requests.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-public-dns-requests.md](../_pricing/dns/usd-public-dns-requests.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-public-dns-requests.md](../_pricing/dns/ils-public-dns-requests.md) %}

{% endif %}

Тарифицируются:
* Авторитетные запросы — любые запросы DNS-записей в [публичных зонах](concepts/dns-zone.md#public-zones) пользователя из интернета или из {{ yandex-cloud }}.
* Рекурсивные запросы — запросы внешних доменных имен в интернете из виртуальных машин {{ yandex-cloud }}.

  {% note tip %}

  Рекомендуем использовать [кеширующие резолверы](tutorials/local-dns-cache.md), например, `systemd-resolved`, `dnsmasq`, `unbound`. С их помощью можно снизить количество запросов внешних доменных имен, таким образом уменьшить расходы.

  {% endnote %}

Не тарифицируются:
* Запросы из ВМ во [внутренние](concepts/dns-zone.md#private-zones) и [сервисные](concepts/dns-zone.md#service-zones) зоны.

{% if product == "yandex-cloud" %}**С 6 декабря 2021 года не тарифицируются**:{% endif %}
* Каждый месяц — первый миллион (1 000 000) рекурсивных запросов из ВМ.

  После того как вы израсходуете этот нетарифицируемый объем, начнет взиматься плата в соответствии с тарифом.

  Если вы не израсходовали нетарифицируемый объем услуг до конца календарного месяца, остаток обнуляется.
* Запросы доменных имен сервисов {{ yandex-cloud }} (например, `{{ api-host }}`){% if product == "yandex-cloud" %}и Яндекса (например, `mail.yandex.ru`){% endif %} — как из ВМ, так и из интернета.

Стоимость публичных DNS-запросов рассчитывается пропорционально потреблению.

Например, стоимость 50 тыс. авторитетных запросов к вашей публичной DNS-зоне за месяц составит:

{% if product == "yandex-cloud" %}

> {% if region == "ru" %}(50 000 / 1 000 000) × 32 ₽ = 0,05 × 32 ₽ = 1,60 ₽{% endif %}
> {% if region == "kz" %}(50 000 / 1 000 000) × 160 ₸ = 0,05 × 160 ₸ = 8 ₸{% endif %}
> {% if region == "int" %}(50 000 / 1 000 000) × 0,256410 $ = 0,05 × 0,256410 $ = 0,0128205 ${% endif %}
> 
> Итого: {% if region == "ru" %}1,60 ₽{% endif %}{% if region == "kz" %}8 ₸{% endif %}{% if region == "int" %}0,0128205 ${% endif %}

{% endif %}

{% if product == "cloud-il" %}

> (50 000 / 1 000 000) × 1,6249 ₪ = 0,05 × 1,6249 ₪ = 0,081245 ₪
>
> Итого: 0,081245 ₪

{% endif %}

Где:

* (50 000 / 1 000 000) — количество миллионов выполненных запросов.
* {% if product == "yandex-cloud" %}{% if region == "ru" %}32 ₽{% endif %}{% if region == "kz" %}160 ₸{% endif %}{% if region == "int" %}0,256410 ${% endif %}{% endif %}{% if product == "cloud-il" %}1,6249 ₪{% endif %} — цена за 1 млн запросов в месяц.

Например, стоимость 1,2 млн рекурсивных запросов внешних имен, выполненных с 6 по 31 декабря с ваших ВМ, за месяц составит:

{% if product == "yandex-cloud" %}

> {% if region == "ru" %}(1,2 − 1,0) × 32 ₽ = 0,2 × 32 ₽ = 6,4000 ₽{% endif %}
> {% if region == "kz" %}(1,2 − 1,0) × 160 ₸ = 0,2 × 160 ₸ = 32 ₸{% endif %}
> {% if region == "int" %}(1,2 − 1,0) × 0,256410 $ = 0,2 × 0,256410 $ = 0,051282 ${% endif %}
> 
> Итого: {% if region == "ru" %}6,4000 ₽{% endif %}{% if region == "kz" %}32 ₸{% endif %}{% if region == "int" %}0,051282 ${% endif %}

{% endif %}

{% if product == "cloud-il" %}

> (1,2 − 1,0) × 1,6249 ₪ = 0,2 × 1,6249 ₪ = 0,32498 ₪
>
> Итого: 0,32498 ₪

{% endif %}

Где:

* (1,2 − 1,0) — количество миллионов выполненных запросов. Первый миллион рекурсивных запросов не тарифицируется{% if product == "yandex-cloud" %} начиная с 6 декабря 2021{% endif %}.
* {% if product == "yandex-cloud" %}{% if region == "ru" %}32 ₽{% endif %}{% if region == "kz" %}160 ₸{% endif %}{% if region == "int" %}0,256410 ${% endif %}{% endif %}{% if product == "cloud-il" %}1,6249 ₪{% endif %} — цена за 1 млн рекурсивных запросов в месяц.

## DNS-зоны {#dns-zones}

Тарифицируются [публичные](concepts/dns-zone.md#public-zones) или [внутренние](concepts/dns-zone.md#private-zones) DNS-зоны, созданные пользователем.

[Сервисные зоны](concepts/dns-zone.md#service-zones) не тарифицируются.

Тарификация посекундная. Стоимость рассчитывается пропорционально потреблению.

{% if product == "yandex-cloud" %}

> Например, стоимость владения 2 DNS-зонами в течение 360 часов будет такой же, как стоимость владения 1 DNS-зоной в течение 720 часов.

{% endif %}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub-public-dns-zones.md](../_pricing/dns/rub-dns-zones.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-public-dns-zones.md](../_pricing/dns/kzt-dns-zones.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-public-dns-zones.md](../_pricing/dns/usd-dns-zones.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-public-dns-zones.md](../_pricing/dns/ils-dns-zones.md) %}

{% endif %}
