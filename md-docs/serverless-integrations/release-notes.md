[Документация Yandex Cloud](../index.md) > [Yandex Serverless Integrations](index.md) > История изменений

# История изменений в Yandex Serverless Integrations

{% note warning %}

Сервис Yandex Serverless Integrations прекращает работу 8 октября 2026 года. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса Yandex Serverless Integrations](sunset.md).

{% endnote %}

## Февраль 2026 {#february-2026}

### Обновления {#updates}

* Добавлена поддержка запуска рабочего процесса по ссылке.
* Добавлена поддержка поля `auto_approve` для шага [AIStudioAgent](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/workflows/yawl/integration/aistudioagent).

## Январь 2026 {#january-2026}

### Обновления {#updates}

* Добавлена поддержка поля `message` для шага [AIStudioAgent](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/workflows/yawl/integration/aistudioagent).

## Декабрь 2025 {#december-2025}

### Обновления {#updates}

* Обновлена версия языка шаблонизации `jq` в Workflows.

## Ноябрь 2025 {#november-2025}

### Обновления {#updates}

* Обновлен список поддерживаемых моделей AI Studio в интеграционных шагах Workflows.

## Октябрь 2025 {#october-2025}

### Обновления {#updates}

* Добавлена поддержка режима форматирования `Без разметки` для шага [Telegram-бот](https://aistudio.yandex.ru/docs/ru/ai-studio/operations/workflows/constructor/telegrambot) в конструкторе.

### Исправления и улучшения {#fixes-improvements}

* Шаг Foundation Models переименован в [Модели AI Studio](https://aistudio.yandex.ru/docs/ru/ai-studio/operations/workflows/constructor/foundationmodelscall).
* Изменена работа режимов форматирования для шага [Telegram-бот](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/workflows/yawl/integration/telegrambot): теперь, если произошла ошибка парсинга формата сообщения, оно будет передано в исходном виде.

## Сентябрь 2025 {#september-2025}

### Обновления {#updates}

* Добавлена поддержка шагов [DatabaseQuery](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/workflows/yawl/integration/databasequery), [VectorStore](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/workflows/yawl/integration/vectorstore) и [AIStudioAgent](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/workflows/yawl/integration/aistudioagent).
* Добавлена поддержка запуска рабочего процесса по [таймеру](https://aistudio.yandex.ru/docs/ru/ai-studio/operations/workflows/execution/start-by-timer).
* Добавлена поддержка Playground и редактора с подсветкой синтаксиса для написания и отладки шаблонизируемых выражений на языке jq.

### Исправления и улучшения {#fixes-improvements}

* Исправлена ошибка задания настройки, которая включает и выключает защиту от удаления коннектора.

## Август 2025 {#august-2025}

### Обновления {#updates}

* Добавлена поддержка [правил перехода по ошибкам](https://aistudio.yandex.ru/docs/ru/ai-studio/operations/workflows/constructor/setup-catch-rule) для интеграционных шагов в конструкторе Workflows.

## Июль 2025 {#july-2025}

### Обновления {#updates}

* Добавлена поддержка нового типа источника для коннектора — [API EventRouter](concepts/eventrouter/connector.md#from-api).
* Добавлена поддержка шага [TelegramBot](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/workflows/yawl/integration/telegrambot).

## Июнь 2025 {#june-2025}

### Обновления {#updates}

* Добавлена поддержка гарантии доставки `At least once` для внутренних ошибок Yandex Workflows.
* Добавлена поддержка больших языковых моделей и источников знаний для шага AIAgent.
* Добавлена поддержка поля `concurrency` для шагов [Foreach](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/workflows/yawl/management/foreach) и [Parallel](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/workflows/yawl/management/parallel).

## Май 2025 {#may-2025}

### Обновления {#updates}

* Yandex Workflows теперь доступен публично на стадии [Preview](../overview/concepts/launch-stages.md).
* Добавлена поддержка нового типа источника для коннектора — [таймер](concepts/eventrouter/connector.md#timer).
* Добавлена поддержка шага AIAgent.
* Обновлены [квоты для Yandex Workflows](concepts/limits.md#sw-quotas).

## Апрель 2025 {#april-2025}

### Обновления {#updates}

* Добавлена поддержка шагов [Workflow](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/workflows/yawl/integration/workflow), [Disk](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/workflows/yawl/integration/disk) и [While](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/workflows/yawl/management/while) в Workflows.
* Добавлена поддержка типов `EXCEL` и `CSV` для шагов [ObjectStorage](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/workflows/yawl/integration/objectstorage) и [Disk](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/workflows/yawl/integration/disk) в Workflows — теперь объекты этих типов можно автоматически декодировать из base64-encoded-строки.
* Добавлена поддержка [правил перехода по ошибкам](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/workflows/yawl/index#catchrule) для интеграционных шагов в Workflows.

## Март 2025 {#march-2025}

### Обновления {#updates}

* Добавлена поддержка типов `TEXT` и `JSON` для шага [ObjectStorage](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/workflows/yawl/integration/objectstorage) в Workflows — теперь объекты этих типов можно автоматически декодировать из base64-encoded-строки.

## Февраль 2025 {#february-2025}

### Исправления и улучшения {#fixes-improvements}

* Обновлен формат входных данных для рабочего процесса Workflows — теперь на вход рабочего процесса можно передавать не только JSON-объект, а любую валидную JSON-структуру, например массив или строку.

## Декабрь 2024 {#december-2024}

### Обновления {#updates}

* Добавлена поддержка шагов [Tracker](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/workflows/yawl/integration/tracker), [Postbox](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/workflows/yawl/integration/postbox) и [Wait](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/workflows/yawl/management/wait) в Workflows.

## Ноябрь 2024 {#november-2024}

### Обновления {#updates}

* Добавлена поддержка шага [YDBDocument](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/workflows/yawl/integration/ydbdocument) в Workflows.
* Добавлена поддержка EventRouter в Terraform.