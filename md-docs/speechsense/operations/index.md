# Пошаговые инструкции для SpeechSense

## Работа с данными {#data}

* Загрузка данных:

  * [Загрузка аудиоданных через интерфейс SpeechSense](data/upload-audio-console.md)
  * [Загрузка аудиоданных через gRPC API](data/upload-data.md)
  * [Загрузка длинных аудиозаписей с разбиением через gRPC API](data/upload-data-split.md)
  * [Загрузка переписки из чата](data/upload-chat-text.md)

* Поиск данных:

  * [Поиск данных через gRPC API](data/search-data-grpc.md)
  * Поиск данных через REST API:
    * [Полнотекстовый поиск в REST API](data/rest-full-text-search.md)
    * [Фильтрация по параметрам в REST API](data/rest-search-filters.md)
    * [Получение информации о диалоге в REST API](data/rest-get-dialog-data.md)

* [Работа с диалогами](data/manage-dialogs.md)
* [Работа с отчетами](data/manage-reports.md)

## Пространства {#space}

* [Создать пространство](space/create.md)
* [Привязать платежный аккаунт](space/link-ba.md)
* [Изменить платежный аккаунт](space/change-ba.md)
* [Добавить пользователя в пространство](space/add-user-to-space.md)
* [Удалить пространство](space/delete.md)
* [Удалить пользователя из пространства](space/delete-user-from-space.md)

## Подключения {#connection}

* [Создать подключение](connection/create.md)
* [Изменить подключение](connection/edit.md)

## Проекты {#project}

* [Создать проект](project/create.md)
* [Добавить пользователя в проект](project/add-user-to-project.md)
* [Удалить проект](project/delete.md)
* [Удалить пользователя из проекта](project/delete-user-from-project.md)
* [Обучение YandexGPT](project/yandexgpt-training.md)

## Ассистенты {#assistant}

* [Создать ассистента](assistant/create.md)
* [Изменить ассистента](assistant/edit.md)
* [Удалить ассистента](assistant/delete.md)

## Теги {#tag}

* [Создать словарный тег](project/tag/create-dictionary-tag.md)
* [Создать смысловой тег](project/tag/create-sense-tag.md)
* [Создать смысловой Pro-тег](project/tag/create-sense-pro-tag.md)
* [Создать зависимый тег](project/tag/create-dependent-tag.md)
* [Изменить словарный тег](project/tag/change-dictionary-tag.md)
* [Изменить смысловой тег](project/tag/change-sense-tag.md)
* [Объяснить применение смыслового тега](project/tag/explain-apply-sense-tag.md)
* [Изменить смысловой Pro-тег](project/tag/change-sense-pro-tag.md)
* [Протестировать тег](project/tag/test.md)
* [Удалить тег](project/tag/delete.md)

## Словари {#dictionary}

* [Создать словарь](dictionary/create.md)
* [Изменить словарь](dictionary/change.md)
* [Добавить словарь в тег](dictionary/add.md)
* [Удалить словарь](dictionary/delete.md)


## Задачи на пересчет {#task-recalculation}
* [Пересчет тегов](task-recalculation/tags-recalc.md)
* [Пересчет ассистентов](task-recalculation/assistants-recalc.md)

## Внешние интеграции {#external-integrations}

* [Создание подключения к SpeechSense из Yandex DataLens](external-integrations/create-datalens-connection.md)