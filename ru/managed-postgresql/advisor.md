---
title: Рекомендации по повышению надежности, оптимизации стоимости и производительности кластера {{ mpg-name }}
description: В этом разделе вы узнаете, как работать с результатами проверок и диагностики кластера {{ mpg-name }}.
alternate:
  - href: ru/managed-postgresql/advisor.md
    type: text/markdown
    title: Markdown version
---

# Инспекции и рекомендации в {{ mpg-name }} 

{% include [advisor-description](../_advisor/concept/advisor-description.md) %}

Для управления рекомендациями в {{ mpg-name }} требуется роль [{{ roles.mpg.editor }} или выше](../managed-postgresql/security/index.md).

## Доступные инспекции {{ mpg-name }} {#mpg-recommendations}

| **Категория** | **Проверка** | **Риск** | **Критичность** |
|---------------------|-------------------------------------------------------|---------------------------------------------------------------------------------------------------------|-----------------|
| Производительность | Загрузка CPU | [Риск падения производительности](#postgresql_cpu_idle) | Высокая         |
| Высокая доступность | Наличие синхронных реплик в кластере                  | [Риск потери данных и недоступности кластера при отказе зоны (реплики)](#postgresql_ha_replics) | Высокая         |
| Высокая доступность | Выделение памяти | [Нехватка оперативной памяти](#postgresql_oom) | Высокая         |
| Высокая доступность | Выделение дискового пространства | [Риск недоступности кластера](#postgresql_disk_free_space) | Высокая         |
| Высокая доступность | Высокая доступность кластера при отказе зоны | [Риск потери данных и недоступности кластера при отказе зоны доступности](#postgresql_ha_zone) | Высокая         |
| Высокая доступность | Высокая доступность кластера при отказе зоны (кворум) | [Риск потери данных и недоступности кластера при отказе зоны (кворум)](#postgresql_ha_quorum) | Высокая         |
| Высокая доступность | Возможность автомасштабирования диска | [Ограничена возможность автомасштабирования дискового пространства](#postgresql_disk_autoscaling_limit) | Умеренная       |

{% include [postgresql-cpu-idle](../_advisor/managed-postgresql/postgresql-cpu-idle.md) %}

{% include [postgresql-ha-replics](../_advisor/managed-postgresql/postgresql-ha-replics.md) %}

{% include [postgresql-oom](../_advisor/managed-postgresql/postgresql-oom.md) %}

{% include [postgresql-disk-free-space](../_advisor/managed-postgresql/postgresql-disk-free-space.md) %}

{% include [postgresql-ha-zone](../_advisor/managed-postgresql/postgresql-ha-zone.md) %}

{% include [postgresql-ha-quorum](../_advisor/managed-postgresql/postgresql-ha-quorum.md) %}

{% include [postgresql-disk-autoscaling-limit](../_advisor/managed-postgresql/postgresql-disk-autoscaling-limit.md) %}

## Управление рекомендациями {#manage-advices}

### Посмотреть рекомендации {#get-advices}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
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
  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
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
  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Перейдите в раздел ![bulb](../_assets/console-icons/bulb.svg) **{{ ui-key.yacloud.mdb.cluster.switch_recommendations }}**.
  1. На панели сверху выберите **{{ ui-key.yacloud.mdb.ServiceRecommendations.filter_option_hidden_b6dQ2 }}**.

- CLI {#cli}

  {% include [get-hidden-advices-cli](../_includes/mdb/manage-advices/get-hidden-advices-cli.md) %}

- REST API {#api}

  {% include [get-hidden-advices-rest](../_includes/mdb/manage-advices/get-hidden-advices-rest.md) %}

- gRPC API {#grpc-api}

  {% include [get-hidden-advices-grpc](../_includes/mdb/manage-advices/get-hidden-advices-grpc.md) %}

{% endlist %}
