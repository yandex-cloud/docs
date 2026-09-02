---
title: Правила тарификации для {{ mos-full-name }}
description: В статье содержатся правила тарификации сервиса {{ mos-name }}.
editable: false
---

# Правила тарификации для {{ mos-name }}

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      md: 6
    indent:
      top: '0'
      bottom: '0'
    children:
      - type: basic-card
        title: Калькулятор цен
        text: Рассчитайте стоимость использования сервиса, исходя из ваших потребностей
        gravityIcon: Calculator
        iconPosition: left
        urlTitle: Калькулятор цен
        url: https://yandex.cloud/ru/prices?state=85da325d39e8#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Прайс-лист
        text: Актуальные тарифы на все наши услуги
        gravityIcon: CircleRuble
        iconPosition: left
        urlTitle: Прайс-лист
        url: https://yandex.cloud/ru/price-list?services=dn2hjd8fhbb14l7vkp2c
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::


В этом разделе описаны [правила](#rules), по которым тарифицируется использование сервиса {{ mos-name }}, и представлены [актуальные цены](#prices) на предоставляемые им ресурсы.


{% include [vat](../_includes/vat.md) %}

## Статус кластера {#running-stopped}

В зависимости от статуса кластера тарифы применяются различным образом:

* Для запущенного кластера (`Running`) тарифицируются как вычислительные ресурсы, так и объем хранилища.
* Для остановленного кластера (`Stopped`) тарифицируется только объем хранилища.

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## Из чего складывается стоимость использования {{ mos-short-name }} {#rules}

Расчет стоимости использования {{ mos-name }} учитывает:

* вычислительные ресурсы, выделенные хостам кластера (в том числе хостам с ролью `MANAGER`);

* тип дисков и объем дискового пространства;

* объем исходящего трафика из {{ yandex-cloud }} в интернет.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование хостов кластера {#rules-hosts-uptime}

Стоимость работы хоста зависит от выделенных для него вычислительных ресурсов. Поддерживаемые конфигурации ресурсов приведены в разделе [Классы хостов](concepts/instance-types.md), цены за использование vCPU и RAM — в разделе [Цены](#prices).

Вы можете выбрать класс хостов как для хостов с ролью `DATA`, так и для хостов с ролью `MANAGER` и `DASHBOARDS`.

Стоимость начисляется за каждый час работы хоста. Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост {{ OS }} не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Объем хранилища, выделенный для кластеров.

{% include [pricing-backup-general](../_includes/mdb/pricing-backup-ch-os-gp.md) %} 

Подробнее в разделе [Резервные копии в {{ mos-name }}](concepts/backup.md).

Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

### Пример расчета стоимости кластера {#example}

Стоимость использования кластера со следующими параметрами в течение 30 дней:

* **Хосты {{ OS }}**: 3 хоста класса `s3-c2-m8`: Intel Ice Lake, 2 × 100% vCPU, 8 ГБ RAM.
* **{{ ui-key.yacloud.mdb.forms.section_storage }}**: 100 ГБ на сетевых HDD-дисках.

Расчет стоимости для хостов {{ OS }}:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-opensearch-host](../_pricing_examples/managed-opensearch/rub-host.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-opensearch-host](../_pricing_examples/managed-opensearch/kzt-host.md) %}

{% endlist %}






Расчет стоимости хранилища и итоговой стоимости:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-opensearch-storage](../_pricing_examples/managed-opensearch/rub-storage.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-opensearch-storage](../_pricing_examples/managed-opensearch/kzt-storage.md) %}

{% endlist %}






## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

Сервис {{ mos-name }} предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены](#prices) стоят прочерки. Размер хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}


## Цены для региона Россия {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}


{% include [Доступ к Compute Optimized по запросу](../_includes/mdb/note-compute-optimized-request.md) %}

{% include [local-ssd for Intel Ice Lake only on request](../_includes/ice-lake-local-ssd-note.md) %}



<MDX>
  <PriceList
    serviceIds={['{{ pcs|mdb.opensearch }}']}
    excludeSkuIds={['{{ pc|mdb.software_accelerated_network.opensearch.highfreq-v4a.cores }}', '{{ pc|mdb.software_accelerated_network.opensearch.highfreq-v3.cores }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>






{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
