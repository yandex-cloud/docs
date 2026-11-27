---
title: Рекомендации по повышению надежности, оптимизации стоимости и производительности кластера {{ mmg-name }}
description: В этом разделе вы узнаете, как работать с результатами проверок и диагностики кластера {{ mmg-name }}.
alternate:
  - href: ru/storedoc/advisor.md
    type: text/markdown
    title: Markdown version
---

# Инспекции и рекомендации в {{ mmg-name }} 

{% include [advisor-description](../_advisor/concept/advisor-description.md) %}

Для управления рекомендациями в {{ mmg-name }} требуется роль [{{ roles.mmg.editor }} или выше](../storedoc/security/index.md).

## Доступные инспекции в {{ mmg-name }} {#mmg-recommendations}

| **Категория** | **Проверка** | **Риск** | **Критичность** |
|---------------------|----------------------------------------------|-------------------------------------------------------------------------------------------------------|-----------------|
| Производительность | Загрузка CPU | [Риск падения производительности](#storedoc_cpu_idle) | Высокая         |
| Высокая доступность | Наличие реплик в шарде                       | [Риск потери данных и недоступности кластера при отказе зоны (отсутствие реплик)](#storedoc_ha_replics) | Низкая          |
| Высокая доступность | Высокая доступность кластера при отказе зоны | [Риск потери данных и недоступности кластера при отказе зоны](#storedoc_ha_geos) | Высокая         |
| Высокая доступность | Выделение дискового пространства | [Риск недоступности кластера](#storedoc_disk_free_space) | Высокая         |
| Высокая доступность | Выделение памяти | [Нехватка оперативной памяти](#storedoc_oom) | Высокая         |
| Высокая доступность | Актуальность версии базы данных | [Версия базы данных устарела](#storedoc_deprecated_version) | Высокая         |
| Высокая доступность | Лаг репликации | [Риск потери данных](#storedoc_replication_lag) | Умеренная       |
| Высокая доступность | Возможность автомасштабирования диска | [Ограничена возможность автомасштабирования дискового пространства](#storedoc_disk_autoscaling_limit) | Умеренная       |

{% include [storedoc-cpu-idle](../_advisor/storedoc/storedoc-cpu-idle.md) %}

{% include [storedoc-ha-replics](../_advisor/storedoc/storedoc-ha-replics.md) %}

{% include [storedoc-ha-geos](../_advisor/storedoc/storedoc-ha-geos.md) %}

{% include [storedoc-disk-free-space](../_advisor/storedoc/storedoc-disk-free-space.md) %} 

{% include [storedoc-oom](../_advisor/storedoc/storedoc-oom.md) %}

{% include [storedoc-deprecated-version](../_advisor/storedoc/storedoc-deprecated-version.md) %}

{% include [storedoc-replication-lag](../_advisor/storedoc/storedoc-replication-lag.md) %}

{% include [storedoc-disk-autoscaling-limit](../_advisor/storedoc/storedoc-disk-autoscaling-limit.md) %}

## Управление рекомендациями {#manage-advices}

### Посмотреть рекомендации {#get-advices}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/storedoc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
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
  1. [Перейдите]({{ link-console-main }}/link/storedoc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
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
  1. [Перейдите]({{ link-console-main }}/link/storedoc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Перейдите в раздел ![bulb](../_assets/console-icons/bulb.svg) **{{ ui-key.yacloud.mdb.cluster.switch_recommendations }}**.
  1. На панели сверху выберите **{{ ui-key.yacloud.mdb.ServiceRecommendations.filter_option_hidden_b6dQ2 }}**.

- CLI {#cli}

  {% include [get-hidden-advices-cli](../_includes/mdb/manage-advices/get-hidden-advices-cli.md) %}

- REST API {#api}

  {% include [get-hidden-advices-rest](../_includes/mdb/manage-advices/get-hidden-advices-rest.md) %}

- gRPC API {#grpc-api}

  {% include [get-hidden-advices-grpc](../_includes/mdb/manage-advices/get-hidden-advices-grpc.md) %}

{% endlist %}
