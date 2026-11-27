[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > Концепции > [Компоненты](overview.md) > DataLens

# DataLens

Yandex DataLens — платформа бизнес-аналитики и визуализации данных. Позволяет создавать интерактивные дашборды, графики и таблицы на основе различных источников данных.

## Основные возможности {#features}

* Создание интерактивных дашбордов и чартов.
* Подключение к источникам данных, создание датасетов и выполнение запросов.
* Совместная работа с коллекциями и воркбуками.
* Аутентификация и управление доступом через Identity and Access Management.
* Управление подключениями через Connection Manager.
* Интеграция с Data Catalog.

## Доступ к интерфейсу {#ui}

Веб-интерфейс DataLens доступен по адресу `https://datalens.sys.<домен кластера>`. Для входа используется аутентификация через Identity and Access Management.

## Управление доступом {#access}

Пользователи и их права управляются в Identity and Access Management.

При первом включении компонента автоматически создаётся группа `stackland-datalens-admins`, в которую добавляется администратор кластера. Пользователи этой группы получают роль `datalens.admin`. Чтобы выдать административный доступ, добавьте пользователя в эту группу.

## Зависимости {#dependencies}

Для работы DataLens необходимы следующие компоненты:

* [Managed Service for PostgreSQL](postgresql.md) — хранение данных DataLens.
* [Object Storage](storage.md) — хранение резервных копий PostgreSQL.
* [Identity and Access Management](iam.md) — аутентификация и авторизация пользователей.
* Connection Manager — управление подключениями к источникам данных.

## Конфигурация {#configuration}

Управление компонентом осуществляется через кастомный ресурс `DataLensConfig`.

Пример:

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: DataLensConfig
metadata:
  name: main # Поле обязательно и должно иметь значение main
spec:
  enabled: true
  settings:
    clusterIssuer: "stackland-default"
    database:
      instances: 3
      storageSize: "2Gi"
      logLevel: "info"
      storageClass: ""
      resources:
        requests:
          cpu: "200m"
          memory: "256Mi"
        limits:
          cpu: "1000m"
          memory: "1Gi"
```

Где:

* `enabled` — включает или отключает компонент.
* `settings.clusterIssuer` — имя ClusterIssuer для TLS-сертификатов. По умолчанию `stackland-default`.
* `settings.database.instances` — количество инстансов PostgreSQL. По умолчанию один.
* `settings.database.storageSize` — размер хранилища базы данных. По умолчанию `2Gi`.
* `settings.database.storageClass` — класс хранилища. По умолчанию используется платформенный класс хранилища.
* `settings.database.logLevel` — уровень логирования PostgreSQL. По умолчанию `info`.
* `settings.database.resources` — ресурсы для подов базы данных:
  * `requests` — минимальные требования к ресурсам.
  * `limits` — максимальные ограничения ресурсов.
* `settings.ai` — параметры нейроаналитика. Подробнее см. в [инструкции по подключению модели](../../operations/datalens/configure.md#ai-analyst).
Подробнее см. в [инструкции по настройке](../../operations/datalens/configure.md#integrations).

## См. также {#see-also}

* [Загрузить образы DataLens](../../operations/datalens/install-images.md)
* [Включить DataLens](../../operations/datalens/configure.md)
* [Отключить DataLens](../../operations/datalens/disable.md)