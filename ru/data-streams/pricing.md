# Правила тарификации для {{ yds-full-name }}

## Из чего складывается стоимость использования {{ yds-name }} {#rules}

В рамках сервиса {{ yds-name }} тарифицируется количество единиц записываемых данных и ресурсы, выделенные для обслуживания потоков данных.

При тарификации выделенных ресурсов учитывается лимит предоставленной пропускной способности сегмента, а также время хранения или объем хранения.

{% include [not-charged-streams.md](../_includes/pricing/price-formula/not-charged-streams.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Примеры расчета стоимости {#price-example}

В поток данных, состоящий из одного сегмента, поступают 2 сообщения в секунду размером 50 КБ. Время хранения сообщений — 12 часов.

Расчет стоимости обработки данных за месяц (при числе дней в месяце 31):
>&lceil; 50 / 40 &rceil; = 2

Где:
* 50 — размер одного сообщения в КБ.
* 40 — [размер единиц](#event) записываемых данных в КБ.
* 2 — количество единиц записываемых данных в одном сообщении.

При расчетах количество единиц записываемых данных округляется до целого в большую сторону, в этом примере количество округляется до 2.

>2 × 2 = 4

Где:
* 2 — количество сообщений в секунду.
* 2 — количество единиц записываемых данных в одном сообщении.
* 4 — количество единиц записываемых данных в секунду.

>4 × 60 × 60 × 24 × 31 = 10&nbsp;713&nbsp;600

Где:
* 4 — количество единиц записываемых данных в секунду.
* 60 × 60 × 24 × 31 — количество секунд в месяце.
* 10&nbsp;713&nbsp;600 — количество единиц записываемых данных в месяц.

{% if region == "ru"%}

{% include [rub.md](../_pricing/data-streams/rub-example.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/data-streams/kzt-example.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/data-streams/usd-example.md) %}

{% endif %}

## Цены {#prices}

### Цена единицы записываемых данных {#event}

Каждый месяц не тарифицируются первые 2 000 000 единиц записываемых данных.

{% if region == "ru"%}

{% include [rub.md](../_pricing/data-streams/rub-event.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/data-streams/kzt-event.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/data-streams/usd-event.md) %}

{% endif %}

### Цена выделенных ресурсов {#resources}

#### Тарификация по времени хранения {#time-limit}

Цена указывается за 1 час использования выделенных ресурсов.

{% if region == "ru"%}

{% include [rub.md](../_pricing/data-streams/rub-resources.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/data-streams/kzt-resources.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/data-streams/usd-resources.md) %}

{% endif %}

#### Тарификация по объему хранения {#storage-limit}

Данные хранятся до 7 дней.

{% if region == "ru"%}

{% include [rub.md](../_pricing/data-streams/rub-resources-storage-limit.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/data-streams/kzt-resources-storage-limit.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/data-streams/usd-resources-storage-limit.md) %}

{% endif %}
