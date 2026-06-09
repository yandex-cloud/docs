# Правила тарификации для {{ objstorage-name }}

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      sm: 4
    children:
      - type: basic-card
        title: Калькулятор цен
        text: Рассчитайте стоимость использования сервиса, исходя из ваших потребностей
        icon: _assets/icons/calculator.svg
        urlTitle: Калькулятор цен
        url: https://yandex.cloud/ru/prices?state=83e1258e152c#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Прайс-лист
        text: Актуальные тарифы на все наши услуги
        icon: _assets/icons/circle-ruble.svg
        urlTitle: Прайс-лист
        url: https://yandex.cloud/ru/price-list?services=dn2li5qddoc5cad2n6br
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Акции и free tier
        text: Гранты, специальные условия и программы поддержки
        icon: _assets/icons/flame.svg
        urlTitle: Акции и free tier
        url: https://yandex.cloud/ru/all-offers
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::



Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.


## Из чего складывается стоимость использования {{ objstorage-short-name }} {#rules}

Расчет стоимости использования {{ objstorage-name }} учитывает:

* [Класс хранилища](concepts/storage-class.md).
* Объем хранилища, занятый данными.
* Количество операций с данными.
* Объем исходящего трафика.

Во всех расчетах 1 ГБ = 2<sup>30</sup> байт, 1 МБ = 2<sup>20</sup> байт.

Каждый месяц не тарифицируются ресурсы стандартного хранилища:
* первый 1 ГБ в месяц хранения;
* первые 10 000 операций PUT, POST, PATCH, LIST;
* первые 100 000 операций GET, HEAD, OPTIONS.

После того как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с тарифами. Если вы не израсходовали нетарифицируемый объем услуг до конца календарного месяца, остаток обнуляется.


### Использование хранилища {#rules-storage}

Использование хранилища измеряется в ГБ в месяц. Объемом хранимых в течение месяца данных считается среднее значение за месяц, согласно данным, гранулированным посекундно. Минимальная единица тарификации — **час хранения 1 МБ данных**.


### Выполнение операций с данными {#rules-operations}

Оплачивается фактическое количество операций.

Удаление данных (операция DELETE) не тарифицируется.

{% note warning %}

Если в [ледяном хранилище](concepts/storage-class.md) вы удалите объект, хранившийся меньше 12 месяцев, после удаления [будет списан остаток стоимости хранения](#ice-storage).

{% endnote %}



## Цены для региона Россия {#prices}



{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../billing/quickstart/index.md).

{% endnote %}


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |




## Примеры расчета стоимости {#price-example}

### Хранение данных {#prices-storage}

#### Стандартное хранилище {#standard-storage}

Стоимость услуги хранения в день рассчитывается как `Цена_за_ГБ_в_месяц / кол-во_дней_в_месяце`. Для более коротких месяцев цена за день будет выше, для более длинных — ниже.

Пример пропорционального расчета: пусть пользователь хранит 15 ГБ в течение 11 часов и 30 минут в месяце длиной 30 календарных дней. Общую цену хранения можно рассчитать по формуле:

```text
Цена_хранения = Цена_за_ГБ_в_месяц × 15 × 12 / 24 / 30
```

Каждый месяц первый 1 ГБ хранения данных в стандартном хранилище не тарифицируется.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Например, если цена за хранение 1&nbsp;ГБ данных в стандартном хранилище в месяц составляет {{ sku|RUB|storage.bucket.used_space.standard|pricingRate.720|month|string }}, а объем хранимых данных за месяц — 23&nbsp;ГБ, то стоимость хранения за месяц составит:
  
  > (23 − 1) × {{ sku|RUB|storage.bucket.used_space.standard|pricingRate.720|month|string }} = 22 × {{ sku|RUB|storage.bucket.used_space.standard|pricingRate.720|month|string }} = {% calc [currency=RUB] 22 × {{ sku|RUB|storage.bucket.used_space.standard|pricingRate.720|month|number }} %}

- Расчет в тенге {#prices-kzt}

  Например, если цена за хранение 1&nbsp;ГБ данных в стандартном хранилище в месяц составляет {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|string }}, а объем хранимых данных за месяц — 23&nbsp;ГБ, то стоимость хранения за месяц составит:
  
  > (23 − 1) × {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|string }} = 22 × {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|string }} = {% calc [currency=KZT] round(22 × {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|number }} × 100) / 100  %}

{% endlist %}




#### Ледяное хранилище {#ice-storage}

Минимальное тарифицируемое время хранения объекта в ледяном хранилище — 12 месяцев. Если вы удалите объект, хранившийся меньше 12 месяцев, после удаления будет списан остаток стоимости хранения.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Например, если цена за хранение 1&nbsp;ГБ данных в ледяном хранилище в месяц составляет {{ sku|RUB|storage.bucket.used_space.ice|month|string }}, а объект размером 3&nbsp;ГБ хранился в ледяном хранилище с 1 января по 20 сентября (8 месяцев и 20 дней), то его хранение тарифицируется следующим образом:
  
  > С 1 января по 20 сентября суммарно
  >
  > : _A_ = 3 × (8 + (20 / 30)) × {{ sku|RUB|storage.bucket.used_space.ice|month|string }} = (3 × 260 / 30) × {{ sku|RUB|storage.bucket.used_space.ice|month|string }} = {% calc [currency=RUB] (3 × 260 / 30) × {{ sku|RUB|storage.bucket.used_space.ice|month|number }} %}
  >
  > 20 сентября, при удалении объекта
  >
  > : _B_ = (3 × 12 × {{ sku|RUB|storage.bucket.used_space.ice|month|string }}) − _A_ = {% calc [currency=RUB] 3 × 12 × {{ sku|RUB|storage.bucket.used_space.ice|month|number }} %} − {% calc [currency=RUB] (3 × 260 / 30) × {{ sku|RUB|storage.bucket.used_space.ice|month|number }} %} = {% calc [currency=RUB] (3 × 12 × {{ sku|RUB|storage.bucket.used_space.ice|month|number }}) - ((3 × 260 / 30) {{ sku|RUB|storage.bucket.used_space.ice|month|number }}) %}
  >
  > Итого
  >
  > : _A_ + _B_ = {% calc [currency=RUB] ((3 × 260 / 30) × {{ sku|RUB|storage.bucket.used_space.ice|month|number }}) + ((3 × 12 × {{ sku|RUB|storage.bucket.used_space.ice|month|number }}) - ((3 × 260 / 30) {{ sku|RUB|storage.bucket.used_space.ice|month|number }})) %}

- Расчет в тенге {#prices-kzt}

  Например, если цена за хранение 1&nbsp;ГБ данных в ледяном хранилище в месяц составляет {{ sku|KZT|storage.bucket.used_space.ice|month|string }} , а объект размером 3&nbsp;ГБ хранился в ледяном хранилище с 1 января по 20 сентября (8 месяцев и 20 дней), то его хранение тарифицируется следующим образом:
  
  > С 1 января по 20 сентября суммарно
  >
  > : _A_ = 3 × (8 + (20 / 30)) × {{ sku|KZT|storage.bucket.used_space.ice|month|string }} = (3 × 260 / 30) × {{ sku|KZT|storage.bucket.used_space.ice|month|string }} = {% calc [currency=KZT] (3 × 260 / 30) × {{ sku|KZT|storage.bucket.used_space.ice|month|number }} %}
  >
  > 20 сентября, при удалении объекта
  >
  > : _B_ = (3 × 12 × {{ sku|KZT|storage.bucket.used_space.ice|month|string}}) − _A_ = {% calc [currency=KZT] 3 × 12 × {{ sku|KZT|storage.bucket.used_space.ice|month|number }} %} − {% calc [currency=KZT] (3 × 260 / 30) × {{ sku|KZT|storage.bucket.used_space.ice|month|number }} %} = {% calc [currency=KZT] (3 × 12 × {{ sku|KZT|storage.bucket.used_space.ice|month|number }}) - ((3 × 260 / 30) × {{ sku|KZT|storage.bucket.used_space.ice|month|number }}) %}
  >
  > Итого
  >
  > : _A_ + _B_ = {% calc [currency=KZT] ((3 × 260 / 30) × {{ sku|KZT|storage.bucket.used_space.ice|month|number }}) + ((3 × 12 × {{ sku|KZT|storage.bucket.used_space.ice|month|number }}) - ((3 × 260 / 30) × {{ sku|KZT|storage.bucket.used_space.ice|month|number }})) %}

{% endlist %}





### Операции с данными {#prices-operations}

{% note info %}

Операции GET, HEAD, OPTIONS, PATCH, POST и PUT, закончившиеся с ошибками 403 или 404, тарифицируются. При расчете стоимости применяются тарифы для стандартного хранилища.

{% endnote %}

Каждый месяц первые 10 000 операций PUT, POST, PATCH и LIST, а также первые 100 000 операций GET, HEAD, OPTIONS в стандартном хранилище не тарифицируются.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Например, если цена за 10&nbsp;000 операций GET в стандартном хранилище в месяц составляет {{ sku|RUB|storage.api.get.standard|pricingRate.10|string }}, количество операций GET за месяц — 245&nbsp;000, то суммарная стоимость операций с данными за месяц составит:
  
  > ((245&nbsp;000 − 100&nbsp;000) / 10 000) × {{ sku|RUB|storage.api.get.standard|pricingRate.10|string }} = (145&nbsp;000 / 10&nbsp;000) × {{ sku|RUB|storage.api.get.standard|pricingRate.10|string }} = {% calc [currency=RUB] round(((145000 / 10000) × {{ sku|RUB|storage.api.get.standard|pricingRate.10|number }}) × 100) / 100 %}

- Расчет в тенге {#prices-kzt}

  Например, если цена за 10&nbsp;000 операций GET в стандартном хранилище в месяц составляет {{ sku|KZT|storage.api.get.standard|pricingRate.10|string }}, количество операций GET за месяц — 245&nbsp;000, то суммарная стоимость операций с данными за месяц составит:
  
  > ((245&nbsp;000 − 100&nbsp;000) / 10&nbsp;000) × {{ sku|KZT|storage.api.get.standard|pricingRate.10|string }} = (145&nbsp;000 / 10&nbsp;000) × {{ sku|KZT|storage.api.get.standard|pricingRate.10|string }} = {% calc [currency=KZT] round(((145000 / 10000) × {{ sku|KZT|storage.api.get.standard|pricingRate.10|number }}) × 100) / 100 %}

{% endlist %}





### Исходящий трафик {#prices-traffic}

При использовании сервиса оплачивается исходящий трафик из {{ yandex-cloud }} в интернет. Передача трафика между сервисами {{ yandex-cloud }}, как и входящий трафик из интернета, не тарифицируется.

Минимальная единица тарификации — 1 МБ. Период тарификации — календарный месяц.

Каждый месяц первые 100 ГБ исходящего трафика для {{ objstorage-name }} не тарифицируются.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  Например, если цена за 1&nbsp;ГБ исходящего трафика сверх 100&nbsp;ГБ до 1&nbsp;ТБ в месяц составляет {{ sku|RUB|storage.api.network.inet.egress|pricingRate.100|string }}, а за месяц было передано 283&nbsp;ГБ исходящего трафика, то стоимость за месяц составит:
  
  > (283 − 100) × {{ sku|RUB|storage.api.network.inet.egress|pricingRate.100|string }} = 183 × {{ sku|RUB|storage.api.network.inet.egress|pricingRate.100|string }} = {% calc [currency=RUB] round(183 × {{ sku|RUB|storage.api.network.inet.egress|pricingRate.100|number }} × 100) / 100 %}

- Расчет в тенге {#prices-kzt}

  Например, если цена за 1&nbsp;ГБ исходящего трафика сверх 100&nbsp;ГБ до 1&nbsp;ТБ в месяц составляет {{ sku|KZT|storage.api.network.inet.egress|pricingRate.100|string }}, а за месяц было передано 283&nbsp;ГБ исходящего трафика, то стоимость за месяц составит:
  
  > (283 − 100) × {{ sku|KZT|storage.api.network.inet.egress|pricingRate.100|string }} = 183 × {{ sku|KZT|storage.api.network.inet.egress|pricingRate.100|string }} = {% calc [currency=KZT] round((183 × {{ sku|KZT|storage.api.network.inet.egress|pricingRate.100|number }}) × 100) / 100 %}

{% endlist %}






## Примеры сравнения стоимости использования классов хранилищ {#comparison-examples}

**Пример 1**

Сравним стоимость хранения и доступа для сайта объемом 3 ГБ и средней посещаемостью 200 пользователей в день. Один пользователь загружает примерно 20 объектов (HTML, CSS, JS и изображения). Это 4 000 запросов в день или около 120 000 в месяц.

Для стандартного хранилища не тарифицируются хранение первого гигабайта данных (1 ГБ) и 10 000 операций PUT в месяц.


{% list tabs group=pricing %}

- Сравнение в рублях {#prices-rub}

  Класс хранилища | Стоимость хранения<br>в месяц, вкл. НДС | Стоимость запросов<br>в месяц, вкл. НДС | Итого<br>в месяц, вкл. НДС
  --- | --- | --- | ---
  `STANDARD` | {% calc [currency=RUB] 2 × {{ sku|RUB|storage.bucket.used_space.standard|pricingRate.720|month|number }} %} | {% calc [currency=RUB] (120000 - 10000) × {{ sku|RUB|storage.api.put.standard|pricingRate.10|number }} / 1000 %} | {% calc [currency=RUB] (2 × {{ sku|RUB|storage.bucket.used_space.standard|pricingRate.720|month|number }}) + ((120000 - 10000) × {{ sku|RUB|storage.api.put.standard|pricingRate.10|number }} / 1000) %}
  `COLD` | {% calc [currency=RUB] 3 × {{ sku|RUB|storage.bucket.used_space.cold|month|number }} %} | {% calc [currency=RUB] 120000 × {{ sku|RUB|storage.api.put.cold|number }} / 1000 %} | {% calc [currency=RUB] (3 × {{ sku|RUB|storage.bucket.used_space.cold|month|number }}) + (120000 × {{ sku|RUB|storage.api.put.cold|number }} / 1000) %}
  `ICE` | {% calc [currency=RUB] 3 × {{ sku|RUB|storage.bucket.used_space.ice|month|number }} %} | {% calc [currency=RUB] 120000 × {{ sku|RUB|storage.api.put.ice|number }} / 1000 %} | {% calc [currency=RUB] (3 × {{ sku|RUB|storage.bucket.used_space.ice|month|number }}) + (120000 × {{ sku|RUB|storage.api.put.ice|number }} / 1000) %}

- Сравнение в тенге {#prices-kzt}

  Класс хранилища | Стоимость хранения<br>в месяц, вкл. НДС | Стоимость запросов<br>в месяц, вкл. НДС | Итого<br>в месяц, вкл. НДС
  --- | --- | --- | ---
  `STANDARD` | {% calc [currency=KZT] 2 × {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|number }} %} | {% calc [currency=KZT] (120000 - 10000) × {{ sku|KZT|storage.api.put.standard|pricingRate.10|number }} / 1000 %} | {% calc [currency=KZT] (2 × {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|number }}) + ((120000 - 10000) × {{ sku|KZT|storage.api.put.standard|pricingRate.10|number }} / 1000) %}
  `COLD` | {% calc [currency=KZT] 3 × {{ sku|KZT|storage.bucket.used_space.cold|month|number }} %} | {% calc [currency=KZT] 120000 × {{ sku|KZT|storage.api.put.cold|number }} / 1000 %} | {% calc [currency=KZT] (3 × {{ sku|KZT|storage.bucket.used_space.cold|month|number }}) + (120000 × {{ sku|KZT|storage.api.put.cold|number }} / 1000) %}
  `ICE` | {% calc [currency=KZT] 3 × {{ sku|KZT|storage.bucket.used_space.ice|month|number }} %} | {% calc [currency=KZT] 120000 × {{ sku|KZT|storage.api.put.ice|number }} / 1000 %} | {% calc [currency=KZT] (3 × {{ sku|KZT|storage.bucket.used_space.ice|month|number }}) + (120000 × {{ sku|KZT|storage.api.put.ice|number }} / 1000) %}

{% endlist %}





**Пример 2**

Сравним стоимость хранения и доступа для репозитория объемом 20 ГБ. В месяц к репозиторию происходит около 150 000 запросов на чтение данных.

Для стандартного хранилища не тарифицируются хранение первого гигабайта данных (1 ГБ) и 100 000 операций GET в месяц.


{% list tabs group=pricing %}

- Сравнение в рублях {#prices-rub}

  Класс хранилища | Стоимость хранения<br>в месяц, вкл. НДС | Стоимость запросов<br>в месяц, вкл. НДС | Итого<br>в месяц, вкл. НДС
  --- | --- | --- | ---
  `STANDARD` | {% calc [currency=RUB] 19 × {{ sku|RUB|storage.bucket.used_space.standard|pricingRate.720|month|number }} %} | {% calc [currency=RUB] (150000 - 100000) × {{ sku|RUB|storage.api.get.standard|pricingRate.10|number }} / 10000 %} | {% calc [currency=RUB] (19 × {{ sku|RUB|storage.bucket.used_space.standard|pricingRate.720|month|number }}) + ((150000 - 100000) × {{ sku|RUB|storage.api.get.standard|pricingRate.10|number }} / 10000) %}
  `COLD` | {% calc [currency=RUB] 20 × {{ sku|RUB|storage.bucket.used_space.cold|month|number }} %} | {% calc [currency=RUB] 150000 × {{ sku|RUB|storage.api.get.cold|number }} / 10000 %} | {% calc [currency=RUB] (20 × {{ sku|RUB|storage.bucket.used_space.cold|month|number }}) + (150000  × {{ sku|RUB|storage.api.get.cold|number }} / 10000) %}
  `ICE` | {% calc [currency=RUB] 20 × {{ sku|RUB|storage.bucket.used_space.ice|month|number }} %} | {% calc [currency=RUB] 150000 × {{ sku|RUB|storage.api.get.ice|number }} / 10000 %} | {% calc [currency=RUB] (20 × {{ sku|RUB|storage.bucket.used_space.ice|month|number }}) + (150000 × {{ sku|RUB|storage.api.get.ice|number }} / 10000) %}

- Сравнение в тенге {#prices-kzt}

  Класс хранилища | Стоимость хранения<br>в месяц, вкл. НДС | Стоимость запросов<br>в месяц, вкл. НДС | Итого<br>в месяц, вкл. НДС
  --- | --- | --- | ---
  `STANDARD` | {% calc [currency=KZT] 19 × {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|number }} %} | {% calc [currency=KZT] (150000 - 100000) × {{ sku|KZT|storage.api.get.standard|pricingRate.10|number }} / 10000 %} | {% calc [currency=KZT] (19 × {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|number }}) + ((150000 - 100000) × {{ sku|KZT|storage.api.get.standard|pricingRate.10|number }} / 10000) %}
  `COLD` | {% calc [currency=KZT] 20 × {{ sku|KZT|storage.bucket.used_space.cold|month|number }} %} | {% calc [currency=KZT] 150000 × {{ sku|KZT|storage.api.get.cold|number }} / 10000 %} | {% calc [currency=KZT] (20 × {{ sku|KZT|storage.bucket.used_space.cold|month|number }}) + (150000  × {{ sku|KZT|storage.api.get.cold|number }} / 10000) %}
  `ICE` | {% calc [currency=KZT] 20 × {{ sku|KZT|storage.bucket.used_space.ice|month|number }} %} | {% calc [currency=KZT] 150000 × {{ sku|KZT|storage.api.get.ice|number }} / 10000 %} | {% calc [currency=KZT] (20 × {{ sku|KZT|storage.bucket.used_space.ice|month|number }}) + (150000 × {{ sku|KZT|storage.api.get.ice|number }} / 10000) %}

{% endlist %}





**Пример 3**

Сравним стоимость хранения и доступа для пополняемого архива данных объемом 100 ГБ. В месяц к архиву происходит 10 000 запросов на чтение данных и 1 000 запросов на запись.

Для стандартного хранилища не тарифицируются хранение первого гигабайта данных (1 ГБ), 10 000 операций PUT и 100 000 операций GET в месяц.


{% list tabs group=pricing %}

- Сравнение в рублях {#prices-rub}

  Класс хранилища | Стоимость хранения<br>в месяц, вкл. НДС | Стоимость запросов PUT<br>в месяц, вкл. НДС | Стоимость запросов GET<br>в месяц, вкл. НДС | Итого<br>в месяц, вкл. НДС
  --- | --- | --- | --- | ---
  `STANDARD` | {% calc [currency=RUB] 99 × {{ sku|RUB|storage.bucket.used_space.standard|pricingRate.720|month|number }} %} | {% calc [currency=RUB] 0 × {{ sku|RUB|storage.api.put.standard|pricingRate.10|number }} / 1000 %} | {% calc [currency=RUB] 0 × {{ sku|RUB|storage.api.get.standard|pricingRate.10|number }} / 10000 %} | {% calc [currency=RUB] (99 × {{ sku|RUB|storage.bucket.used_space.standard|pricingRate.720|month|number }}) + (0 × {{ sku|RUB|storage.api.put.standard|pricingRate.10|number }} / 1000) + (0 × {{ sku|RUB|storage.api.get.standard|pricingRate.10|number }} / 10000) %}
  `COLD` | {% calc [currency=RUB] 100 × {{ sku|RUB|storage.bucket.used_space.cold|month|number }} %} | {% calc [currency=RUB] 1000 × {{ sku|RUB|storage.api.put.cold|number }} / 1000 %} | {% calc [currency=RUB] 10000 × {{ sku|RUB|storage.api.get.cold|number }} / 10000 %} | {% calc [currency=RUB] (100 × {{ sku|RUB|storage.bucket.used_space.cold|month|number }}) + (1000 × {{ sku|RUB|storage.api.put.cold|number }} / 1000) + (10000 × {{ sku|RUB|storage.api.get.cold|number }} / 10000) %}
  `ICE` | {% calc [currency=RUB] 100 × {{ sku|RUB|storage.bucket.used_space.ice|month|number }} %} | {% calc [currency=RUB] 1000 × {{ sku|RUB|storage.api.put.ice|number }} / 1000 %} | {% calc [currency=RUB] 10000 × {{ sku|RUB|storage.api.get.ice|number }} / 10000 %} | {% calc [currency=RUB] (100 × {{ sku|RUB|storage.bucket.used_space.ice|month|number }}) + (1000 × {{ sku|RUB|storage.api.put.ice|number }} / 1000) + (10000 × {{ sku|RUB|storage.api.get.ice|number }} / 10000) %}

- Сравнение в тенге {#prices-kzt}

  Класс хранилища | Стоимость хранения<br>в месяц, вкл. НДС | Стоимость запросов PUT<br>в месяц, вкл. НДС | Стоимость запросов GET<br>в месяц, вкл. НДС | Итого<br>в месяц, вкл. НДС
  --- | --- | --- | --- | ---
  `STANDARD` | {% calc [currency=KZT] 99 × {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|number }} %} | {% calc [currency=KZT] 0 × {{ sku|KZT|storage.api.put.standard|pricingRate.10|number }} / 1000 %} | {% calc [currency=KZT] 0 × {{ sku|KZT|storage.api.get.standard|pricingRate.10|number }} / 10000 %} | {% calc [currency=KZT] (99 × {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|number }}) + (0 × {{ sku|KZT|storage.api.put.standard|pricingRate.10|number }} / 1000) + (0 × {{ sku|KZT|storage.api.get.standard|pricingRate.10|number }} / 10000) %}
  `COLD` | {% calc [currency=KZT] 100 × {{ sku|KZT|storage.bucket.used_space.cold|month|number }} %} | {% calc [currency=KZT] 1000 × {{ sku|KZT|storage.api.put.cold|number }} / 1000 %} | {% calc [currency=KZT] 10000 × {{ sku|KZT|storage.api.get.cold|number }} / 10000 %} | {% calc [currency=KZT] (100 × {{ sku|KZT|storage.bucket.used_space.cold|month|number }}) + (1000 × {{ sku|KZT|storage.api.put.cold|number }} / 1000) + (10000 × {{ sku|KZT|storage.api.get.cold|number }} / 10000) %}
  `ICE` | {% calc [currency=KZT] 100 × {{ sku|KZT|storage.bucket.used_space.ice|month|number }} %} | {% calc [currency=KZT] 1000 × {{ sku|KZT|storage.api.put.ice|number }} / 1000 %} | {% calc [currency=KZT] 10000 × {{ sku|KZT|storage.api.get.ice|number }} / 10000 %} | {% calc [currency=KZT] (100 × {{ sku|KZT|storage.bucket.used_space.ice|month|number }}) + (1000 × {{ sku|KZT|storage.api.put.ice|number }} / 1000) + (10000 × {{ sku|KZT|storage.api.get.ice|number }} / 10000) %}

{% endlist %}




### См. также {#see-also}

[{#T}](concepts/limits.md)