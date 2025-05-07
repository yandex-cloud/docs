---
title: История изменений в {{ si-full-name }}
description: В разделе представлена история изменений сервиса {{ si-name }}.
---

# История изменений в {{ si-full-name }}

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
