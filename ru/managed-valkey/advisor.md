---
title: Рекомендации по повышению надежности, оптимизации стоимости и производительности кластера {{ mrd-name }}
description: В этом разделе вы узнаете, как работать с результатами проверок и диагностики кластера {{ mrd-name }}.
alternate:
  - href: ru/managed-valkey/advisor.md
    type: text/markdown
    title: Markdown version
---

# Инспекции и рекомендации в {{ mrd-name }} 

{% include [advisor-description](../_advisor/concept/advisor-description.md) %}

Для управления рекомендациями в {{ mrd-name }} требуется роль [{{ roles.mrd.editor }} или выше](../managed-valkey/security/index.md).

## Доступные инспекции в {{ mrd-name }} {#mrd-recommendations}

| **Категория** | **Проверка** | **Риск** | **Критичность** |
|---------------------|----------------------------------------------|-------------------------------------------------------------------------------------------------------|-----------------|
| Производительность | Загрузка CPU (main thread) | [Риск падения производительности](#valkey_main_thread) | Умеренная |
| Производительность | Частота попадания в кеш | [Низкий процент попадания в кеш](#valkey_cachehit) | Умеренная |
| Высокая доступность | Наличие реплик в шарде | [Риск потери данных и недоступности кластера при отказе зоны (отсутствие реплик)](#valkey_ha_replics) | Низкая |
| Высокая доступность | Высокая доступность кластера при отказе зоны | [Риск потери данных и недоступности кластера при отказе зоны](#valkey_ha_geos) | Высокая |
| Высокая доступность | Выделение памяти | [Нехватка оперативной памяти](#valkey_oom) | Умеренная |
| Высокая доступность | Актуальность версии базы данных | [Версия базы данных устарела](#valkey_deprecated_version) | Высокая |
| Высокая доступность | Политика потребления памяти {{ VLK }} | [Достигнут лимит по объему памяти на хосте](#valkey_maxmemory_policy) | Умеренная |
| Высокая доступность | Возможность автомасштабирования диска | [Ограничена возможность автомасштабирования дискового пространства](#valkey_disk_autoscaling_limit) | Умеренная |

{% include [valkey-main_thread](../_advisor/managed-valkey/valkey-main-thread.md) %}

{% include [valkey-valkey_cachehit](../_advisor/managed-valkey/valkey-cachehit.md) %}

{% include [valkey-ha-replics](../_advisor/managed-valkey/valkey-ha-replics.md) %}

{% include [valkey-ha-geos](../_advisor/managed-valkey/valkey-ha-geos.md) %}

{% include [valkey-oom](../_advisor/managed-valkey/valkey-oom.md) %}

{% include [valkey-deprecated-verion](../_advisor/managed-valkey/valkey-deprecated-version.md) %}

{% include [valkey-maxmemory-policy](../_advisor/managed-valkey/valkey-maxmemory-policy.md) %}

{% include [valkey-disk-autoscaling-limit](../_advisor/managed-valkey/valkey-disk-autoscaling-limit.md) %}

## Управление рекомендациями {#manage-advices}

### Посмотреть рекомендации {#get-advices}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-valkey) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
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
  1. [Перейдите]({{ link-console-main }}/link/managed-valkey) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
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
  1. [Перейдите]({{ link-console-main }}/link/managed-valkey) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Перейдите в раздел ![bulb](../_assets/console-icons/bulb.svg) **{{ ui-key.yacloud.mdb.cluster.switch_recommendations }}**.
  1. На панели сверху выберите **{{ ui-key.yacloud.mdb.ServiceRecommendations.filter_option_hidden_b6dQ2 }}**.

- CLI {#cli}

  {% include [get-hidden-advices-cli](../_includes/mdb/manage-advices/get-hidden-advices-cli.md) %}

- REST API {#api}

  {% include [get-hidden-advices-rest](../_includes/mdb/manage-advices/get-hidden-advices-rest.md) %}

- gRPC API {#grpc-api}

  {% include [get-hidden-advices-grpc](../_includes/mdb/manage-advices/get-hidden-advices-grpc.md) %}

{% endlist %}
