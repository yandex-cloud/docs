---
title: Работа с рекомендациями с помощью API
description: В этом разделе вы узнаете, как работать с результатами проверок и диагностики кластера с помощью API.
alternate:
  - href: ru/api-design-guide/concepts/about-adviser.md
    type: text/markdown
    title: Markdown version
---

# Работа с рекомендациями

{% include [advisor-description](../../_advisor/concept/advisor-description.md) %}

Для управления рекомендациями с помощью API используются три метода:

| **Метод** | **Назначение** |
|-|-|
|`List GET` | Показывает список рекомендаций: по облаку, каталогу или конкретному ресурсу. Фильтрует рекомендации по состоянию (`ACTIVE` / `RESOLVED` / `STALED`), критичности (`INFO` / `WARNING` / `CRITICAL`), категории, видимости. |
| `Dismiss POST` | Скрывает рекомендацию на время (от часа до года), указав причину (`incorrect` / `wont_fix` / `accepted` / `other`). |
| `GetDismissalInfo GET` | Позволяет просмотреть информацию о том, кто скрыл рекомендацию, с каким объяснением, когда истечет срок действия скрытия и рекомендация снова станет видна. |