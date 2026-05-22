# DataLens

Yandex DataLens — платформа бизнес-аналитики и визуализации данных. Позволяет создавать интерактивные дашборды, графики и таблицы на основе различных источников данных. Компонент основан на [DataLens On-premises](https://datalens.ru/on-premises/docs/ru/).

## Основные возможности {#features}

* Создание интерактивных дашбордов и чартов.
* Подключение к источникам данных: PostgreSQL, ClickHouse® и другие.
* Совместная работа с коллекциями и воркбуками.
* Управление доступом через роли.

## Доступ к интерфейсу {#ui}

Веб-интерфейс DataLens доступен по адресу `https://datalens.sys.<домен кластера>`. Для входа используется аутентификация через Identity and Access Management.

При первом включении компонента автоматически создаётся группа `stackland-datalens-admins`, в которую добавляется администратор кластера. Пользователи этой группы получают роль `datalens.admin`.

## Управление доступом {#access}

DataLens использует три роли:

* `datalens.admin` — полный доступ к DataLens: управление пользователями, коллекциями, воркбуками и источниками данных. Назначается через группу `stackland-datalens-admins` в Identity and Access Management.
* `datalens.creator` — создание и редактирование объектов: дашбордов, чартов, датасетов, подключений.
* `datalens.visitor` — только просмотр опубликованных объектов. Роль по умолчанию для аутентифицированных пользователей.

Маппинг ролей осуществляется через группы Identity and Access Management. Чтобы назначить пользователю роль `datalens.admin`, добавьте его в группу `stackland-datalens-admins`.

### Добавить пользователя через интерфейс {#add-user-ui}

Администратор DataLens может добавить локального пользователя через веб-интерфейс.

Чтобы добавить пользователя:

1. Откройте веб-интерфейс DataLens по адресу `https://datalens.<домен кластера>`.
1. В левом меню выберите **Настройки сервиса**.
1. Перейдите на вкладку **Пользователи**.
1. Нажмите **+ Добавить пользователя**.
1. В форме «Добавление пользователя» заполните поля:

   * **Логин** — имя пользователя для входа в DataLens.
   * **Имя** — имя пользователя (необязательно).
   * **Фамилия** — фамилия пользователя (необязательно).
   * **Почта** — адрес электронной почты (необязательно).
   * **Роль** — роль пользователя в DataLens: `Admin`, `Creator` или `Visitor`.
   * **Группа** — группа пользователей (необязательно).
   * **Пароль** — пароль для входа. Нажмите **Сгенерировать пароль**, чтобы создать пароль автоматически.

1. Нажмите **Добавить**.

## Зависимости {#dependencies}

Для работы DataLens необходимы следующие компоненты:

* [Managed Service for PostgreSQL](postgresql.md) — хранение данных DataLens.
* [Identity and Access Management](iam.md) — аутентификация и авторизация пользователей.

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

## См. также {#see-also}

* [Загрузить образы DataLens](../../operations/datalens/install-images.md)
* [Включить DataLens](../../operations/datalens/configure.md)
* [Отключить DataLens](../../operations/datalens/disable.md)