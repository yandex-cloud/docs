# Yandex SpeechSense

# Yandex SpeechSense

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Работа с данными

#### Загрузка данных

 - [Загрузка аудиоданных через консоль управления](operations/data/upload-audio-console.md)

 - [Загрузка аудиоданных через gRPC API](operations/data/upload-data.md)

 - [Загрузка длинных аудиозаписей с разбиением через gRPC API](operations/data/upload-data-split.md)

 - [Загрузка переписки из чата](operations/data/upload-chat-text.md)

#### Поиск данных

 - [Поиск данных через gRPC API](operations/data/search-data-grpc.md)

##### Поиск данных через REST API

 - [Полнотекстовый поиск в REST API](operations/data/rest-full-text-search.md)

 - [Фильтрация по параметрам в REST API](operations/data/rest-search-filters.md)

 - [Получение информации о диалоге в REST API](operations/data/rest-get-dialog-data.md)

 - [Работа с диалогами](operations/data/manage-dialogs.md)

 - [Просмотр связанных диалогов](operations/data/related-dialogs.md)

 - [Работа с отчетами](operations/data/manage-reports.md)

### Пространства

 - [Создать пространство](operations/space/create.md)

 - [Привязать платежный аккаунт](operations/space/link-ba.md)

 - [Изменить платежный аккаунт](operations/space/change-ba.md)

 - [Добавить пользователя в пространство](operations/space/add-user-to-space.md)

 - [Удалить пространство](operations/space/delete.md)

 - [Удалить пользователя из пространства](operations/space/delete-user-from-space.md)

### Подключения

 - [Создать подключение](operations/connection/create.md)

 - [Изменить подключение](operations/connection/edit.md)

### Проекты

 - [Создать проект](operations/project/create.md)

 - [Добавить пользователя в проект](operations/project/add-user-to-project.md)

 - [Удалить проект](operations/project/delete.md)

 - [Удалить пользователя из проекта](operations/project/delete-user-from-project.md)

 - [Обучение YandexGPT](operations/project/yandexgpt-training.md)

### Ассистенты

 - [Создать ассистента](operations/assistant/create.md)

 - [Изменить ассистента](operations/assistant/edit.md)

 - [Удалить ассистента](operations/assistant/delete.md)

### Теги

 - [Создать словарный тег](operations/project/tag/create-dictionary-tag.md)

 - [Создать смысловой тег](operations/project/tag/create-sense-tag.md)

 - [Создать смысловой Pro-тег](operations/project/tag/create-sense-pro-tag.md)

 - [Создать зависимый тег](operations/project/tag/create-dependent-tag.md)

 - [Изменить словарный тег](operations/project/tag/change-dictionary-tag.md)

 - [Изменить смысловой тег](operations/project/tag/change-sense-tag.md)

 - [Объяснить применение смыслового тега](operations/project/tag/explain-apply-sense-tag.md)

 - [Изменить смысловой Pro-тег](operations/project/tag/change-sense-pro-tag.md)

 - [Протестировать тег](operations/project/tag/test.md)

 - [Удалить тег](operations/project/tag/delete.md)

### Словари

 - [Создать словарь](operations/dictionary/create.md)

 - [Изменить словарь](operations/dictionary/change.md)

 - [Добавить словарь в тег](operations/dictionary/add.md)

 - [Удалить словарь](operations/dictionary/delete.md)

### Задачи на пересчет

 - [Пересчет тегов](operations/task-recalculation/tags-recalc.md)

 - [Пересчет ассистентов](operations/task-recalculation/assistants-recalc.md)

### Внешние интеграции

 - [Создание подключения к SpeechSense из DataLens](operations/external-integrations/create-datalens-connection.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Автоматическая загрузка данных с помощью Yandex Workflows](tutorials/auto-upload.md)

 - [Интеграция с amoCRM](tutorials/amocrm.md)

 - [Интеграция с Битрикс24](tutorials/bitrix24.md)

 - [Работа с AI-ассистентом](tutorials/ai-assistant.md)

## Концепции

 - [Иерархия ресурсов](concepts/resources-hierarchy.md)

 - [Ассистенты](concepts/assistants.md)

 - [Диалоги](concepts/dialogs.md)

 - [Теги в диалогах](concepts/tags.md)

 - [Словари для тегов](concepts/dictionaries.md)

### Отчеты

 - [Обзор](concepts/reports/index.md)

 - [Форма оценки](concepts/reports/evaluation-form.md)

 - [Сравнение](concepts/reports/comparison.md)

 - [Детализация](concepts/reports/details.md)

 - [Смысловые атрибуты](concepts/reports/sense-attributes.md)

 - [Поддерживаемые форматы аудио](concepts/formats.md)

 - [Квоты и лимиты](concepts/limits.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Assistants

 - [Overview](api-ref/grpc/Assistants/index.md)

 - [List](api-ref/grpc/Assistants/list.md)

 - [ListModels](api-ref/grpc/Assistants/listModels.md)

#### Classifiers

 - [Overview](api-ref/grpc/Classifiers/index.md)

 - [List](api-ref/grpc/Classifiers/list.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### Project

 - [Overview](api-ref/grpc/Project/index.md)

 - [Create](api-ref/grpc/Project/create.md)

#### Talk

 - [Overview](api-ref/grpc/Talk/index.md)

 - [UploadAsStream](api-ref/grpc/Talk/uploadAsStream.md)

 - [Upload](api-ref/grpc/Talk/upload.md)

 - [UploadText](api-ref/grpc/Talk/uploadText.md)

 - [UploadBadge](api-ref/grpc/Talk/uploadBadge.md)

 - [Search](api-ref/grpc/Talk/search.md)

 - [Get](api-ref/grpc/Talk/get.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Assistants

 - [Overview](api-ref/Assistants/index.md)

 - [List](api-ref/Assistants/list.md)

 - [ListModels](api-ref/Assistants/listModels.md)

#### Classifiers

 - [Overview](api-ref/Classifiers/index.md)

 - [List](api-ref/Classifiers/list.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### Talk

 - [Overview](api-ref/Talk/index.md)

 - [Search](api-ref/Talk/search.md)

 - [Get](api-ref/Talk/get.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

 - [История изменений](release-notes/index.md)

 - [Вопросы и ответы](qa/index.md)

 - [Обучающие курсы](training.md)