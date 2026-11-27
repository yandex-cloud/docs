---
title: Рекомендации по повышению надежности, оптимизации стоимости и производительности кластера {{ mch-name }}
description: В этом разделе вы узнаете, как работать с результатами проверок и диагностики кластера {{ mch-name }}.
alternate:
  - href: ru/managed-clickhouse/advisor.md
    type: text/markdown
    title: Markdown version
---

# Инспекции и рекомендации в {{ mch-name }} 

{% include [advisor-description](../_advisor/concept/advisor-description.md) %}

Для управления рекомендациями в {{ mch-name }} требуется роль [{{ roles.mch.editor }} или выше](../managed-clickhouse/security.md).

## Доступные инспекции в {{ mch-name }} {#mch-recommendations}

| **Категория** | **Проверка** | **Риск** | **Критичность** |
|---------------------|----------------------------------------------------|-----------------------------------------------------------------------------------------------------|-----------------|
| Производительность  | Загрузка CPU                                       | [Высокая загрузка CPU на хосте](#clickhouse_cpu_idle)                                               | Высокая         |
| Высокая доступность | Выделение дискового пространства | [Нехватка места на диске](#clickhouse_disk_free_space) | Высокая       |
| Высокая доступность | Размещение сервиса координации на отдельных хостах | [Риск недоступности из-за размещения сервиса координации на хостах](#clickhouse_ha_embedded_keeper) | Высокая         |
| Высокая доступность | Высокая доступность шарда | [Риск потери данных и недоступности кластера при отказе зоны доступности](#clickhouse_ha_shard) | Высокая         |
| Высокая доступность | Кворум сервиса координации при отказе зоны | [Риск потери кворума сервиса координации при отказе зоны](#clickhouse_ha_keeper) | Высокая          |


{% include [clickhouse-cpu-idle](../_advisor/managed-clickhouse/clickhouse-cpu-idle.md) %}

{% include [disk-free-space](../_advisor/managed-clickhouse/clickhouse-disk-free-space.md) %}

{% include [disk-free-space](../_advisor/managed-clickhouse/clickhouse-ha-embedded-keeper.md) %} 

{% include [disk-free-space](../_advisor/managed-clickhouse/clickhouse-ha-shards.md) %}

{% include [disk-free-space](../_advisor/managed-clickhouse/clickhouse-ha-keeper.md) %}

## Управление рекомендациями {#manage-advices}

### Посмотреть рекомендации {#get-advices}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-clickhouse) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Перейдите в раздел ![bulb](../_assets/console-icons/bulb.svg) **{{ ui-key.yacloud.mdb.cluster.switch_recommendations }}**.
  1. Нажмите на нужную рекомендацию — на панели справа отобразится подробная информация.

- CLI {#cli}

  {% include [get-advices-cli](../_includes/mdb/manage-advices/get-advices-cli.md) %}

- REST API {#api}

  {% include [get-advices-rest](../_includes/mdb/manage-advices/get-advices-rest.md) %}

- gRPC API {#grpc-api}

  {% include [get-advices-grpc](../_includes/mdb/manage-advices/get-advices-grpc.md) %}

{% endlist %}

### Скрыть рекомендацию {#hide-advice}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-clickhouse) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Перейдите в раздел ![bulb](../_assets/console-icons/bulb.svg) **{{ ui-key.yacloud.mdb.cluster.switch_recommendations }}**.
  1. В строке с нужной рекомендацией нажмите ![ellipsis](../_assets/console-icons/ellipsis.svg) → ![eye-slash](../_assets/console-icons/eye-slash.svg) **{{ ui-key.yacloud.mdb.ServiceRecommendations.action_dismiss_b4mN9 }}**.
  1. {% include [settings-console](../_includes/mdb/manage-advices/settings-console.md) %}
  1. Нажмите **{{ ui-key.yacloud.components.EntityAdviser.DismissIssueDialog.button_hide }}**.

- CLI {#cli}

  {% include [hide-advice-cli](../_includes/mdb/manage-advices/hide-advice-cli.md) %}

- REST API {#api}

  {% include [hide-advice-rest](../_includes/mdb/manage-advices/hide-advice-rest.md) %}

- gRPC API {#grpc-api}

  {% include [hide-advice-grpc](../_includes/mdb/manage-advices/hide-advice-grpc.md) %}

{% endlist %}

### Посмотреть скрытые рекомендации {#get-hidden-advices}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-clickhouse) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Перейдите в раздел ![bulb](../_assets/console-icons/bulb.svg) **{{ ui-key.yacloud.mdb.cluster.switch_recommendations }}**.
  1. На панели сверху выберите **{{ ui-key.yacloud.mdb.ServiceRecommendations.filter_option_hidden_b6dQ2 }}**.

- CLI {#cli}

  {% include [get-hidden-advices-cli](../_includes/mdb/manage-advices/get-hidden-advices-cli.md) %}

- REST API {#api}

  {% include [get-hidden-advices-rest](../_includes/mdb/manage-advices/get-hidden-advices-rest.md) %}

- gRPC API {#grpc-api}

  {% include [get-hidden-advices-grpc](../_includes/mdb/manage-advices/get-hidden-advices-grpc.md) %}

{% endlist %}
