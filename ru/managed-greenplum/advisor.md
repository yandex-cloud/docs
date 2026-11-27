---
title: Рекомендации по повышению надежности, оптимизации стоимости и производительности кластера {{ mgp-name }}
description: В этом разделе вы узнаете, как работать с результатами проверок и диагностики кластера {{ mgp-name }}.
alternate:
  - href: ru/managed-greenplum/advisor.md
    type: text/markdown
    title: Markdown version
---

# Инспекции и рекомендации в {{ mgp-name }} 

{% include [advisor-description](../_advisor/concept/advisor-description.md) %}

Для управления рекомендациями в {{ mgp-name }} требуется роль [{{ roles.mgp.editor }} или выше](../managed-greenplum/security/index.md).

## Доступные инспекции в {{ mgp-name }} {#mgp-recommendations}

| **Категория** | **Проверка** | **Риск** | **Критичность** |
|---------------------|-------------------------|----------------------------------------------------------------------------------------------------|-----------------|
| Производительность | Загрузка CPU | [Риск падения производительности](#greenplum_cpu_idle) | Высокая         |
| Высокая доступность | Выделение памяти | [Нехватка оперативной памяти](#greenplum_oom) | Умеренная       |
| Высокая доступность | Учет памяти ZSTD | [Риск превышения лимитов памяти ресурсного менеджера](#greenplum_gp_enable_zstd_memory_accounting) | Умеренная       |

{% include [greenplum-cpu-idle](../_advisor/managed-greenplum/greenplum-cpu-idle.md) %}

{% include [greenplum-oom](../_advisor/managed-greenplum/greenplum-oom.md) %} 

{% include [greenplum-gp-enable-zstd-memory-accounting](../_advisor/managed-greenplum/greenplum-gp-enable-zstd-memory-accounting.md) %}

## Управление рекомендациями {#manage-advices}

### Посмотреть рекомендации {#get-advices}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-greenplum) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
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
  1. [Перейдите]({{ link-console-main }}/link/managed-greenplum) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
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
  1. [Перейдите]({{ link-console-main }}/link/managed-greenplum) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Перейдите в раздел ![bulb](../_assets/console-icons/bulb.svg) **{{ ui-key.yacloud.mdb.cluster.switch_recommendations }}**.
  1. На панели сверху выберите **{{ ui-key.yacloud.mdb.ServiceRecommendations.filter_option_hidden_b6dQ2 }}**.

- CLI {#cli}

  {% include [get-hidden-advices-cli](../_includes/mdb/manage-advices/get-hidden-advices-cli.md) %}

- REST API {#api}

  {% include [get-hidden-advices-rest](../_includes/mdb/manage-advices/get-hidden-advices-rest.md) %}

- gRPC API {#grpc-api}

  {% include [get-hidden-advices-grpc](../_includes/mdb/manage-advices/get-hidden-advices-grpc.md) %}

{% endlist %}
