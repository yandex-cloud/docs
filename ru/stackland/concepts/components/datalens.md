---
alternate:
  - href: ru/stackland/concepts/components/datalens.md
    type: text/markdown
    title: Markdown version
---
# {{ datalens-name }}

{{ datalens-full-name }} — платформа бизнес-аналитики и визуализации данных. Позволяет создавать интерактивные дашборды, графики и таблицы на основе различных источников данных.

## Основные возможности {#features}

* Создание интерактивных дашбордов и чартов.
* Подключение к источникам данных, создание датасетов и выполнение запросов.
* Совместная работа с коллекциями и воркбуками.
* Аутентификация и управление доступом через {{ iam-name }}.
* Управление подключениями через Connection Manager.
* Интеграция с Data Catalog.

## Доступ к интерфейсу {#ui}

Веб-интерфейс {{ datalens-name }} доступен по адресу `https://datalens.sys.<домен кластера>`. Для входа используется аутентификация через {{ iam-name }}.

## Управление доступом {#access}

Пользователи и их права управляются в {{ iam-name }}.

При первом включении компонента автоматически создаётся группа `stackland-datalens-admins`, в которую добавляется администратор кластера. Пользователи этой группы получают роль `datalens.admin`. Чтобы выдать административный доступ, добавьте пользователя в эту группу.

## Зависимости {#dependencies}

Для работы {{ datalens-name }} необходимы следующие компоненты:

* [{{ mpg-name }}](postgresql.md) — хранение данных {{ datalens-name }}.
* [{{ objstorage-name }}](storage.md) — хранение резервных копий PostgreSQL.
* [{{ iam-name }}](iam.md) — аутентификация и авторизация пользователей.
* Connection Manager — управление подключениями к источникам данных.

## Конфигурация {#configuration}

Управление компонентом осуществляется через кастомный ресурс `DataLensConfig`.

Пример:

{% include notitle [YAML-файл](../../_includes/yamls/components/datalensconfig.md) %}

Где:

* `enabled` — включает или отключает компонент.
* `settings.clusterIssuer` — имя ClusterIssuer для TLS-сертификатов. По умолчанию `stackland-default`.
* `settings.database.instances` — количество инстансов {{ PG }}. По умолчанию один.
* `settings.database.storageSize` — размер хранилища базы данных. По умолчанию `2Gi`.
* `settings.database.storageClass` — класс хранилища. По умолчанию используется платформенный класс хранилища.
* `settings.database.logLevel` — уровень логирования {{ PG }}. По умолчанию `info`.
* `settings.database.resources` — ресурсы для подов базы данных:
  * `requests` — минимальные требования к ресурсам.
  * `limits` — максимальные ограничения ресурсов.
* `settings.ai` — параметры нейроаналитика. Подробнее см. в [инструкции по подключению модели](../../operations/datalens/configure.md#ai-analyst).
Подробнее см. в [инструкции по настройке](../../operations/datalens/configure.md#integrations).

## См. также {#see-also}

* [{#T}](../../operations/datalens/install-images.md)
* [{#T}](../../operations/datalens/configure.md)
* [{#T}](../../operations/datalens/disable.md)
