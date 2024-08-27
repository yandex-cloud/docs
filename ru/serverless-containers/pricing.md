---
editable: false
---

# Правила тарификации для {{ serverless-containers-name }}



## Из чего складывается стоимость использования {{ serverless-containers-name }} {#rules}

В рамках сервиса {{ serverless-containers-name }} тарифицируется количество вызовов контейнеров, вычислительные ресурсы, выделенные для выполнения приложения, время простоя [подготовленных экземпляров](concepts/container.md#provisioned-instances) и исходящий трафик.

При тарификации вычислительных ресурсов учитывается количество ядер процессора (vCPU), [уровень производительности ядра](../compute/concepts/performance-levels.md), объем памяти, выделенный для приложения, и время выполнения приложения:

* Количество ядер, указанное при создании ревизии, измеряется в vCPU и является положительным вещественным числом.
* Уровень производительности ядра, указанный при создании ревизии, измеряется в процентах.
* Объем памяти, указанный при создании ревизии, измеряется в ГБ.
* Суммарное время работы контейнера измеряется в часах, и округляется в большую сторону до ближайшего значения, кратного 100 мс.

{% note warning %}

Тарифицируются только вызовы контейнера, которые привели к запуску приложения.

{% endnote %}

### Формула расчета стоимости {#formula}


{% list tabs group=pricing %}

- Стоимость в рублях {#prices-rub}

  {% include [rub-formula](../_pricing_examples/serverless-containers/rub-formula.md) %}

- Стоимость в тенге {#prices-kzt}

  {% include [kzt-formula](../_pricing_examples/serverless-containers/kzt-formula.md) %}

{% endlist %}



{% include [not-charged-sc.md](../_includes/pricing/price-formula/not-charged-serverless-containers.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Примеры расчета стоимости {#example}

Пример расчета стоимости контейнера, у которого:

* **Объем памяти, указанный при создании ревизии**: 2 ГБ.
* **Количество ядер**: 20% vCPU.
* **Количество вызовов контейнера**: 3 000 000.
* **Время выполнения при каждом вызове**: 150 мс.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-example-20pct](../_pricing_examples/serverless-containers/rub-example-20pct.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-example-20pct](../_pricing_examples/serverless-containers/kzt-example-20pct.md) %}

{% endlist %}



Пример расчета стоимости контейнера, у которого:

* **Объем памяти, указанный при создании ревизии**: 2 ГБ.
* **Количество ядер**: 100% vCPU.
* **Количество вызовов контейнера**: 3 000 000.
* **Время выполнения при каждом вызове**: 150 мс.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-example-100pct](../_pricing_examples/serverless-containers/rub-example-100pct.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-example-100pct](../_pricing_examples/serverless-containers/kzt-example-100pct.md) %}

{% endlist %}



## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Вызов контейнера {#prices-invoking}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub-invocation.md](../_pricing/serverless-containers/rub-invocations.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt-invocation.md](../_pricing/serverless-containers/kzt-invocations.md) %}

{% endlist %}



### Время использования RAM при обработке запросов {#prices-ram}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub-ram.md](../_pricing/serverless-containers/rub-ram.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt-ram.md](../_pricing/serverless-containers/kzt-ram.md) %}

{% endlist %}



### Время использования CPU при обработке запросов {#prices-cpu}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub-cpu.md](../_pricing/serverless-containers/rub-cpu.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt-cpu.md](../_pricing/serverless-containers/kzt-cpu.md) %}

{% endlist %}



### Подготовленные экземпляры {#provisioned-instances}

#### Время использования RAM {#prices-ram-provisioned-instances}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub-ram-provisioned-instances.md](../_pricing/serverless-containers/rub-ram-provisioned-instances.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt-ram-provisioned-instances.md](../_pricing/serverless-containers/kzt-ram-provisioned-instances.md) %}

{% endlist %}



#### Время использования CPU {#prices-cpu-provisioned-instances}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub-cpu-provisioned-instances.md](../_pricing/serverless-containers/rub-cpu-provisioned-instances.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt-cpu-provisioned-instances.md](../_pricing/serverless-containers/kzt-cpu-provisioned-instances.md) %}

{% endlist %}



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
