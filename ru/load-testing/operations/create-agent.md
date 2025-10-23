---
title: Как создать агента тестирования в {{ load-testing-full-name }}
description: Из статьи вы узнаете, как создать агента тестирования.
---

# Создание агента тестирования

## Подготовка инфраструктуры {#infrastructure-prepare}

1. Создайте сервисный аккаунт для агента тестирования:

    {% include [sa-create](../../_includes/load-testing/sa-create.md) %}
1. [Настройте](../../load-testing/operations/security-groups-agent.md) группу безопасности агента тестирования.

## Создание агента тестирования {#create-agent}

{% note info %}

Если агент нужен вам для единичного использования, вы можете [создать](#create-temporal-agent) временный агент. Временный агент тестирования будет создан только для определенного теста и после завершения теста будет удален.

{% endnote %}

{% include [create-agent](../../_includes/load-testing/create-agent.md) %}

## Создание временного агента тестирования {#create-temporal-agent}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог для тестирования.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
   1. На вкладке ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** нажмите **{{ ui-key.yacloud.load-testing.button_create-test }}**.
   1. В секции **{{ ui-key.yacloud.load-testing.label_agents-list }}** нажмите **{{ ui-key.yacloud.load-testing.label_agent-temporal-selector }}**.
   1. В блоке **{{ ui-key.yacloud.load-testing.title_temporal-agent-field }}**:
      * Выберите подходящий тип агента. Подробнее см. в разделе [Производительность агентов](../../load-testing/concepts/agent.md#benchmark).

      {% note warning %}

      Для работы временного агента тестирования [сервисному аккаунту](../../iam/concepts/users/service-accounts.md) `sa-loadtest` необходимо дополнительно назначить роли `compute.editor`, `iam.serviceAccounts.user`, `vpc.user` и `vpc.publicAdmin`.

      {% endnote %}

      * Выберите сервисный аккаунт `sa-loadtest`.
      * Укажите [подсеть](../../vpc/concepts/network.md#subnet), в которой находится цель тестирования.
      * Если вам доступны [группы безопасности](../../vpc/concepts/security-groups.md), выберите заранее настроенную группу безопасности агента.

{% endlist %}