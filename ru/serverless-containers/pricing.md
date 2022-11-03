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


{% include notitle [rub-invocation.md](../_pricing/serverless-containers/rub-invocations.md) %}




### Время использования RAM при обработке запросов {#prices-ram}


{% include notitle [rub-ram.md](../_pricing/serverless-containers/rub-ram.md) %}




### Время использования CPU при обработке запросов {#prices-cpu}


{% include notitle [rub-cpu.md](../_pricing/serverless-containers/rub-cpu.md) %}




### Подготовленные экземпляры {#provisioned-instances}

{% note info %}

Цены действуют с 17 октября 2022 года.

{% endnote %}

#### Время использования RAM {#prices-ram-provisioned-instances}


{% include notitle [rub-ram-provisioned-instances.md](../_pricing/serverless-containers/rub-ram-provisioned-instances.md) %}




#### Время использования CPU {#prices-cpu-provisioned-instances}


{% include notitle [rub-cpu-provisioned-instances.md](../_pricing/serverless-containers/rub-cpu-provisioned-instances.md) %}




### Исходящий трафик {#prices-traffic}


{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}



