---
title: Рекомендации по повышению надежности, оптимизации стоимости и производительности кластера {{ mos-name }}
description: В этом разделе вы узнаете, как работать с результатами проверок и диагностики кластера {{ mos-name }}.
alternate:
  - href: ru/managed-opensearch/advisor.md
    type: text/markdown
    title: Markdown version
---

# Инспекции и рекомендации в {{ mos-name }}

{% include [advisor-description](../_advisor/concept/advisor-description.md) %}

Для управления рекомендациями в {{ mos-name }} требуется роль [{{ roles.mos.editor }} или выше](../managed-opensearch/security/index.md).

## Доступные инспекции в {{ mos-name }} {#mos-recommendations}

| **Категория** | **Проверка** | **Риск** | **Критичность** |
|---------------------|-----------------------------------------------|---------------------------------------------------------------------------------------------------------|-----------------|
| Производительность | Загрузка CPU | [Риск падения производительности](#opensearch_cpu_idle) | Высокая         |
| Высокая доступность | Актуальность версии базы данных | [Версия базы данных устарела](#opensearch_deprecated_version) | Высокая         |
| Высокая доступность | Возможность автомасштабирования | [Автомасштабирование дискового пространства не настроено](#opensearch_disk_autoscaling) | Низкая          |
| Высокая доступность | Возможность автомасштабирования (ограничения) | [Ограничена возможность автомасштабирования дискового пространства](#opensearch-disk-autoscaling-limit) | Умеренная       |
| Высокая доступность | Выделение дискового пространства | [Риск недоступности кластера](#opensearch_disk_free_space) | Высокая         |
| Высокая доступность | Выделение памяти | [Нехватка оперативной памяти](#opensearch_oom) | Высокая         |
| Высокая доступность | Высокая доступность кластера при отказе зоны | [Риск потери данных и недоступности кластера при отказе зоны](#opensearch_high_availability) | Высокая         |

{% include [opensearch-cpu-idle](../_advisor/managed-opensearch/opensearch-cpu-idle.md) %}

{% include [opensearch-deprecated-version](../_advisor/managed-opensearch/opensearch-deprecated-version.md) %}

{% include [opensearch-disk-autoscaling](../_advisor/managed-opensearch/opensearch-disk-autoscaling.md) %}

{% include [opensearch-disk-autoscaling-limit](../_advisor/managed-opensearch/opensearch-disk-autoscaling-limit.md) %}

{% include [opensearch-disk-free-space](../_advisor/managed-opensearch/opensearch-disk-free-space.md) %}

{% include [opensearch-oom](../_advisor/managed-opensearch/opensearch-oom.md) %}

{% include [opensearch-ha-zone](../_advisor/managed-opensearch/opensearch-ha-zone.md) %}

## Управление рекомендациями {#manage-advices}

### Посмотреть рекомендации {#get-advices}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-opensearch) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
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
  1. [Перейдите]({{ link-console-main }}/link/managed-opensearch) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
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
  1. [Перейдите]({{ link-console-main }}/link/managed-opensearch) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
  1. Перейдите в раздел ![bulb](../_assets/console-icons/bulb.svg) **{{ ui-key.yacloud.mdb.cluster.switch_recommendations }}**.
  1. На панели сверху выберите **{{ ui-key.yacloud.mdb.ServiceRecommendations.filter_option_hidden_b6dQ2 }}**.

- CLI {#cli}

  {% include [get-hidden-advices-cli](../_includes/mdb/manage-advices/get-hidden-advices-cli.md) %}

- REST API {#api}

  {% include [get-hidden-advices-rest](../_includes/mdb/manage-advices/get-hidden-advices-rest.md) %}

- gRPC API {#grpc-api}

  {% include [get-hidden-advices-grpc](../_includes/mdb/manage-advices/get-hidden-advices-grpc.md) %}

{% endlist %}
