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

{% include [create-agent](../../_includes/load-testing/create-agent.md) %}