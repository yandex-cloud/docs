---
title: История изменений в {{ si-full-name }}
description: В разделе представлена история изменений сервиса {{ si-name }}.
---

# История изменений в {{ si-full-name }}

## Июнь 2025 {#june-2025}

### Обновления {#updates}

* Добавлена поддержка гарантии доставки `At least once` для внутренних ошибок {{ sw-full-name }}.
* Добавлена поддержка больших языковых моделей и источников знаний для шага [AIAgent](concepts/workflows/yawl/integration/aiagent.md).
* Добавлена поддержка поля `concurrency` для шагов [Foreach](concepts/workflows/yawl/management/foreach.md) и [Parallel](concepts/workflows/yawl/management/parallel.md).

## Май 2025 {#may-2025}

### Обновления {#updates}

* {{ sw-full-name }} теперь доступен публично на стадии [Preview](../overview/concepts/launch-stages.md).
* Добавлена поддержка нового типа источника для коннектора — [таймер](concepts/eventrouter/connector.md#timer).
* Добавлена поддержка шага [AIAgent](concepts/workflows/yawl/integration/aiagent.md).
* Обновлены [квоты для {{ sw-full-name }}](concepts/limits.md#sw-quotas).

## Апрель 2025 {#april-2025}

### Обновления {#updates}

* Добавлена поддержка шагов [Workflow](concepts/workflows/yawl/integration/workflow.md), [Disk](concepts/workflows/yawl/integration/disk.md) и [While](concepts/workflows/yawl/management/while.md) в {{ sw-name }}.
* Добавлена поддержка типов `EXCEL` и `CSV` для шагов [ObjectStorage](concepts/workflows/yawl/integration/objectstorage.md) и [Disk](concepts/workflows/yawl/integration/disk.md) в {{ sw-name }} — теперь объекты этих типов можно автоматически декодировать из base64-encoded-строки.
* Добавлена поддержка [правил перехода по ошибкам](concepts/workflows/yawl/index.md#catchrule) для интеграционных шагов в {{ sw-name }}.

## Март 2025 {#march-2025}

### Обновления {#updates}

* Добавлена поддержка типов `TEXT` и `JSON` для шага [ObjectStorage](concepts/workflows/yawl/integration/objectstorage.md) в {{ sw-name }} — теперь объекты этих типов можно автоматически декодировать из base64-encoded-строки.

## Февраль 2025 {#february-2025}

### Исправления и улучшения {#fixes-improvements}

* Обновлен формат входных данных для рабочего процесса {{ sw-name }} — теперь на вход рабочего процесса можно передавать не только JSON-объект, а любую валидную JSON-структуру, например массив или строку.

## Декабрь 2024 {#december-2024}

### Обновления {#updates}

* Добавлена поддержка шагов [Tracker](concepts/workflows/yawl/integration/tracker.md), [Postbox](concepts/workflows/yawl/integration/postbox.md) и [Wait](concepts/workflows/yawl/management/wait.md) в {{ sw-name }}.

## Ноябрь 2024 {#november-2024}

### Обновления {#updates}

* Добавлена поддержка шага [YDBDocument](concepts/workflows/yawl/integration/ydbdocument.md) в {{ sw-name }}.
* Добавлена поддержка {{ er-name }} в {{ TF }}.
