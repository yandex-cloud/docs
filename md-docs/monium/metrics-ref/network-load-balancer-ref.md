[Документация Yandex Cloud](../../index.md) > [Monium](../index.md) > [Метрики](../metrics/overview.md) > [Справочник метрик](index.md) > Network Load Balancer

# Метрики Yandex Network Load Balancer

В этом разделе описаны метрики сервиса [Network Load Balancer](../../network-load-balancer/index.md), поставляемые в Monium Metrics.

Метрики сервиса Network Load Balancer автоматически передаются в [Monium](../metrics/overview.md) в [проект каталога](*monium-folder-project), в котором находится балансировщик.

Если вы просматриваете метрики в интерфейсе сервиса или переходите к графику из [сервисного дашборда](../operations/dashboard/service-dashboards.md), значение метки `service` используется без подчеркиваний.

Если вы вводите запрос в Monium в [разделе метрик](../metrics/metric-explorer.md#add-graph) или при создании алерта, укажите проект каталога с ресурсом (`project = folder__<идентификатор_каталога>`), `cluster = default` и `service = __<идентификатор_сервиса>__`.

Имя метрики пишется в метку `name`.

Все метрики сервиса Network Load Balancer имеют общую метку `service=network-load-balancer`.

## Метрики сети {#nlb-net-metrics}

Общие метки для всех метрик сети:

Метка | Значение
--- | ---
downstream_port | Номер порта входящего трафика.
instance | Идентификатор инстанса.
downstream_ip | IP-адрес входящего трафика.
balancer_type | Тип балансировщика: `internal`, `external`.
protocol | Протокол: `TCP`, `UDP`.
network_load_balancer | Идентификатор балансировщика.
upstream_ip | IP-адрес исходящего трафика.
direction | Направление трафика: `ingress`, `egress`.
upstream_port | Номер порта исходящего трафика.

Имя метрики<br>Тип, единицы измерения | Описание<br>Метки
--- | ---
`processed_bytes`<br>`RATE`, байты | Трафик в байтах, прошедший через балансировщик в исходящем и входящем направлениях. С учетом IP-заголовков. За вычетом трафика для проверок состояния.
`processed_packets`<br>`RATE`, пакеты | Трафик в пакетах, прошедший через балансировщик в исходящем и входящем направлениях. С учетом IP-заголовков. За вычетом трафика для проверок состояния.

[*monium-folder-project]: Проект Monium с идентификатором `folder__<идентификатор_каталога>` создается автоматически для каждого каталога и содержит телеметрию его ресурсов.