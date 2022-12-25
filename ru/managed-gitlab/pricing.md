---
editable: false
---

# Правила тарификации для {{ mgl-full-name }}

## Из чего складывается стоимость использования {{ mgl-name }} {#rules}

При работе {{ mgl-name }} вы оплачиваете:
* Вычислительные ресурсы инстанса (виртуальной машины).
* Объем хранилища (диск) данных инстанса.

Дополнительно оплачиваются следующие потребляемые ресурсы:
* Место, занятое в сервисе {{ objstorage-full-name }}, для хранения резервных копий.
* Объем исходящего трафика из {{ yandex-cloud }} в интернет.

Во всех расчетах 1 ГБ = 2<sup>10</sup> МБ = 2<sup>20</sup> КБ = 2<sup>30</sup> байт.

### Использование вычислительных ресурсов {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы ВМ.

Минимальная единица тарификации — час (например, стоимость 1,5 часов работы ВМ равна стоимости 2 часов).

### Использование дискового пространства {#rules-storage}

Оплачивается:
* Объем хранилища, выделенный для хранения данных инстанса.
* Объем резервных копий, которые хранятся в {{ objstorage-name }}.

Цена указывается за 1 месяц использования. Минимальная единица тарификации — 1 ГБ в час (например, стоимость хранения 1 ГБ в течение 1,5 часов равна стоимости хранения в течение 2 часов).

## Цены {#prices}

### Вычислительные ресурсы инстансов {#prices-instance}

{% if region == "ru" %}

{% include [rub-instance-resources.md](../_pricing/managed-gitlab/rub-instance-resources.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-instance-resources.md](../_pricing/managed-gitlab/kzt-instance-resources.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-instance-resources.md](../_pricing/managed-gitlab/usd-instance-resources.md) %}

{% endif %}

### Хранилище и резервные копии {#prices-storage}

{% if region == "ru" %}

{% include [rub-storage.md](../_pricing/managed-gitlab/rub-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-storage.md](../_pricing/managed-gitlab/kzt-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-storage.md](../_pricing/managed-gitlab/usd-storage.md) %}

{% endif %}

### Исходящий трафик {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}

## Лицензии {#license}

По умолчанию {{ mgl-name }} использует Community Edition версию {{ GL }}. Если у вас есть оплаченная [лицензия](https://about.gitlab.com/pricing/) {{ GL }} (`Premium` или `Ultimate`) — обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру, чтобы воспользоваться ею в {{ mgl-name }}.