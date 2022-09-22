---
editable: false
---

# Правила тарификации для {{ serverless-containers-name }}

## Из чего складывается стоимость использования {{ serverless-containers-name }} {#rules}

В рамках сервиса {{ serverless-containers-name }} тарифицируется количество вызовов контейнеров, вычислительные ресурсы, выделенные для выполнения приложения, время простоя [подготовленных экземпляров](concepts/container.md#provisioned-instances) и исходящий трафик.

При тарификации вычислительных ресурсов учитывается количество ядер (vCPU), объем памяти, выделенный для приложения, и время выполнения приложения:
* Количество ядер, указанное при создании ревизии, измеряется в vCPU и является положительным вещественным числом.
* Объем памяти, указанный при создании ревизии, измеряется в ГБ.
* Суммарное время работы контейнера измеряется в часах, и округляется в большую сторону до ближайшего значения, кратного 100 мс.

{% note warning %}

Тарифицируются все вызовы контейнера, которые привели к запуску приложения.

{% endnote %}

## Цены {#prices}

### Вызов контейнера {#prices-invoking}

{% if region == "ru" %}

{% include notitle [rub-invocation.md](../_pricing/serverless-containers/rub-invocations.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-invocation.md](../_pricing/serverless-containers/kzt-invocations.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-invocation.md](../_pricing/serverless-containers/usd-invocations.md) %}

{% endif %}

### Время использования RAM при обработке запросов {#prices-ram}

{% if region == "ru" %}

{% include notitle [rub-ram.md](../_pricing/serverless-containers/rub-ram.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-ram.md](../_pricing/serverless-containers/kzt-ram.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-ram.md](../_pricing/serverless-containers/usd-ram.md) %}

{% endif %}

### Время использования CPU при обработке запросов {#prices-cpu}

{% if region == "ru" %}

{% include notitle [rub-cpu.md](../_pricing/serverless-containers/rub-cpu.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-cpu.md](../_pricing/serverless-containers/kzt-cpu.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-cpu.md](../_pricing/serverless-containers/usd-cpu.md) %}

{% endif %}

### Подготовленные экземпляры {#provisioned-instances}

{% note info %}

Цены действуют с 17 октября 2022 года.

{% endnote %}

#### Время использования RAM {#prices-ram-provisioned-instances}

{% if region == "ru" %}

{% include notitle [rub-ram-provisioned-instances.md](../_pricing/serverless-containers/rub-ram-provisioned-instances.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-ram-provisioned-instances.md](../_pricing/serverless-containers/kzt-ram-provisioned-instances.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-ram-provisioned-instances.md](../_pricing/serverless-containers/usd-ram-provisioned-instances.md) %}

{% endif %}

#### Время использования CPU {#prices-cpu-provisioned-instances}

{% if region == "ru" %}

{% include notitle [rub-cpu-provisioned-instances.md](../_pricing/serverless-containers/rub-cpu-provisioned-instances.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-cpu-provisioned-instances.md](../_pricing/serverless-containers/kzt-cpu-provisioned-instances.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-cpu-provisioned-instances.md](../_pricing/serverless-containers/usd-cpu-provisioned-instances.md) %}

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
