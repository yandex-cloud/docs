---
sourcePath: ru/tracker/api-ref/concepts/entities/about-entities.md
---
# Проекты и портфели. Обзор

API Entities (Сущности) представляет унифицированный набор методов для управления проектами и портфелями, более гибкий и функциональный, чем API управления проектами.

С помощью данного API вы сможете:

- [Создавать](create-entity.md), [редактировать](update-entity.md) и [удалять](delete-entity.md) проекты и портфели.
- [Получать информацию](get-entity.md) о проектах и портфелях.
- [Искать](search-entities.md) и [пакетно обновлять](bulkchange-entities.md) проекты и портфели.
- [Создавать](./checklists/add-checklist.md), [редактировать](./checklists/patch-checklist.md) и [удалять](./checklists/delete-checklist.md) чеклисты.
- [Редактировать](./checklists/patch-checklist-item.md), [перемещать](./checklists/move-checklist-item.md) и [удалять](./checklists/delete-checklist-item.md) отдельные пункты чеклиста.

## Параметры запроса {#query-params}

С помощью параметров запроса вы можете включить в тело ответа дополнительную информацию.

{% include [query-params](../../../_includes/tracker/api/query-params.md) %}
