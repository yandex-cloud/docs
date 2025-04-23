---
title: Правила тарификации для {{ objstorage-full-name }}
description: В статье содержатся правила тарификации сервиса {{ objstorage-name }}.
editable: false
---


# Правила тарификации для {{ objstorage-name }}

{% note tip %}


Чтобы рассчитать стоимость использования сервиса, воспользуйтесь [калькулятором](https://yandex.cloud/ru/prices?state=7d6b2f413dcf#calculator) на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.





{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


## Из чего складывается стоимость использования {{ objstorage-short-name }} {#rules}

Расчет стоимости использования {{ objstorage-name }} учитывает:

* [Класс хранилища](concepts/storage-class.md).
* Объем хранилища, занятый данными.
* Количество операций с данными.
* Объем исходящего трафика.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

{% include [not-charged-storage.md](../_includes/pricing/price-formula/not-charged-storage.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}


### Использование хранилища {#rules-storage}

Использование хранилища измеряется в ГБ в месяц. Объемом хранимых в течение месяца данных считается среднее значение за месяц, согласно данным, гранулированным посекундно. Минимальная единица тарификации — **час хранения 1 МБ данных**.


### Выполнение операций с данными {#rules-operations}

Выполнение операций с данными тарифицируется по правилам:
* Минимальная единица тарификации для операций PUT, POST, PATCH, LIST, TRANSITION — 10.
* Минимальная единица тарификации для операций GET, HEAD, OPTIONS — 100.
* Удаление данных (операция DELETE) не тарифицируется.



## Цены для региона Россия {#prices}


{% note warning %}

С 1 мая 2025 года увеличатся цены на ресурсы {{ objstorage-full-name }} в регионе Россия. Новые цены можно посмотреть на сайте:

* [Цены в рублях](https://yandex.cloud/ru/price-list?installationCode=ru&currency=RUB&services=dn2li5qddoc5cad2n6br)
* [Цены в тенге](https://yandex.cloud/ru/price-list?installationCode=ru&currency=KZT&services=dn2li5qddoc5cad2n6br)

{% endnote %}





{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



### Хранение данных {#prices-storage}

Цены за ГБ в месяц фиксированы и не зависят от количества дней в месяце.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/storage/rub-used_space.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/storage/kzt-used_space.md) %}

{% endlist %}




^1^ Стоимость услуги хранения в день рассчитывается как `Цена_за_ГБ_в_месяц / кол-во_дней_в_месяце`. Для более коротких месяцев цена за день будет выше, для более длинных — ниже.

Пример пропорционального расчета: пусть пользователь хранит 15 ГБ в течение 11 часов и 30 минут в месяце длиной 30 календарных дней. Общую цену хранения можно рассчитать по формуле:

```text
Цена_хранения = Цена_за_ГБ_в_месяц × 15 × 12 / 24 / 30
```

^2^ Каждый месяц первый 1 ГБ хранения данных в стандартном хранилище не тарифицируется.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-used-space-standard](../_pricing_examples/storage/rub-used-space-standard.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-used-space-standard](../_pricing_examples/storage/kzt-used-space-standard.md) %}

{% endlist %}




^3^ Минимальное тарифицируемое время хранения объекта в ледяном хранилище — 12 месяцев. Если вы удалите объект, хранившийся меньше 12 месяцев, после удаления будет списан остаток стоимости хранения.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-used-space-ice](../_pricing_examples/storage/rub-used-space-ice.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-used-space-ice](../_pricing_examples/storage/kzt-used-space-ice.md) %}

{% endlist %}





### Операции с данными {#prices-operations}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/storage/rub-operations.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/storage/kzt-operations.md) %}

{% endlist %}




{% note info %}

Операции GET, HEAD, OPTIONS, PATCH, POST и PUT, закончившиеся с ошибками 403 или 404, тарифицируются. При расчете стоимости применяются тарифы для стандартного хранилища.

{% endnote %}

Каждый месяц первые 10 000 операций PUT, POST, PATCH и LIST, а также первые 100 000 операций GET, HEAD, OPTIONS в стандартном хранилище не тарифицируются.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-operations](../_pricing_examples/storage/rub-operations.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-operations](../_pricing_examples/storage/kzt-operations.md) %}

{% endlist %}





### Исходящий трафик {#prices-traffic}

При использовании сервиса оплачивается исходящий трафик из {{ yandex-cloud }} в интернет. Передача трафика между сервисами {{ yandex-cloud }}, как и входящий трафик из интернета, не тарифицируется.

Минимальная единица тарификации — 1 МБ. Период тарификации — календарный месяц.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/storage/rub-egress.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/storage/kzt-egress.md) %}

{% endlist %}




Каждый месяц первые 100 ГБ исходящего трафика для {{ objstorage-name }} не тарифицируются.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-egress](../_pricing_examples/storage/rub-egress.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-egress](../_pricing_examples/storage/kzt-egress.md) %}

{% endlist %}



