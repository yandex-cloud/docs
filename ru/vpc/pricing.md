---
editable: false
---

# Правила тарификации для {{ vpc-name }}

{% if product == "cloud-il" %}

На стадии [Preview](../overview/concepts/launch-stages.md) использование сервиса {{ vpc-name }} не тарифицируется.

{% endif %}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## Из чего складывается стоимость использования {{ vpc-short-name }} {#rules}

В рамках {{ vpc-short-name }} оплачивается почасовое использование публичных IP-адресов.

{% include [not-charged-vpc.md](../_includes/pricing/price-formula/not-charged-vpc.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

## Цены {#prices}

### Публичные IP-адреса {#prices-public-ip}

Публичный IP-адрес может находиться в двух состояниях:

1. **Активном** — когда _динамический_ или _статический_ публичный IP-адрес привязан к запущенному облачному ресурсу.
1. **Неактивном** — когда _статический_ публичный IP-адрес не привязан к облачному ресурсу или привязан к остановленному ресурсу. Цена неактивного публичного статического адреса складывается из стоимости публичного IP-адреса и стоимости резервирования неактивного публичного статического IP-адреса. 

{% if region == "ru" %}
   
   Например, при стоимости часа использования публичного IP-адреса, равной 0,1524 ₽, и стоимости часа резервирования неактивного публичного статического IP-адреса, равной 0,1980 ₽, цена неактивного публичного статического адреса составит:
   
   >0,1524 + 0,1980 = 0,3504 ₽ за час, вкл. НДС

{% endif %}

{% if region == "ru" %}

{% include [rub-ip.md](../_pricing/vpc/rub-ip.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-ip.md](../_pricing/vpc/kzt-ip.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-ip.md](../_pricing/vpc/usd-ip.md) %}

{% endif %}


{% if product == "yandex-cloud" %}

### Защита от DDoS-атак {#prices-ddos-protection}

{% if region == "ru"%}

{% include [rub-ddos.md](../_pricing/vpc/rub-ddos.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-ddos.md](../_pricing/vpc/kzt-ddos.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-ddos.md](../_pricing/vpc/usd-ddos.md) %}

{% endif %}

Полезный трафик — это входящий трафик, который система фильтрации DDoS Protection допускает к облачным ресурсам пользователя. Тарифицируется только полезный трафик.

Например, на виртуальную машину пользователя была проведена типовая DDoS-атака в 10 Гбит/с, которая сгенерировала 75 ГБ входящего трафика. Во время атаки пользователь загрузил из интернета на виртуальную машину 2 ГБ полезных файлов. Когда атака закончилась, пользователь загрузил еще 2 ГБ полезных файлов. 

В этом случае тарифицируются только 4 ГБ полезного трафика: 2 ГБ, который система DDoS Protection допустила к облачным ресурсам во время атаки, и 2 ГБ, которые были загружены, когда атака не велась. Вредоносный трафик отфильтровывается и не тарифицируется.

{% endif %}


### Использование групп безопасности {#prices-security-groups}

Функциональность [групп безопасности](concepts/security-groups.md) находится на стадии [Preview](../overview/concepts/launch-stages.md) и ее использование не тарифицируется.

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

{% endif %}