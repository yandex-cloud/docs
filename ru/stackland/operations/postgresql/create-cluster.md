# Создать кластер PostgreSQL

Если у вас есть [проект](../projects/create-project.md), создайте в нем кластер [PostgreSQL](../../concepts/components/postgresql.md).

## Через CLI {#cli}

1. Если проект еще не создан, то создайте его: `kubectl create namespace <название проекта>`.
1. Если для базы данных нужно резервное копирование, подготовьте хранилище в зависимости от типа S3:

    {% list tabs %}

    - Внешний S3

        Создайте Secret с учётными данными доступа к S3-совместимому хранилищу:

        1. Создайте файл, например: `touch s3-credentials.yaml`.
        1. Вставьте конфигурацию и подставьте свои `accessKey` и `secretKey`:

            {% include notitle [YAML-файл секрета для внешнего S3](../../_includes/yamls/operations/postgresql/create-secret-s3-credentials.md) %}

        1. Примените манифест: `kubectl apply -f s3-credentials.yaml -n <название проекта>`.

        В манифесте кластера укажите `spec.backup.storage.type: s3` и ссылку на этот секрет в `spec.backup.storage.s3.credentialsSecretRef.name` (например, `access-key-credentials`).

    - Stackland Storage (внутреннее объектное хранилище Stackland)

        Ничего создавать не нужно. В манифесте кластера укажите `spec.backup.storage.type: stackland-storage` — оператор создаст Bucket и AccessKey автоматически. При необходимости можно сослаться на существующие ресурсы через `spec.backup.storage.stacklandStorage.bucketRef` и `accessKeyRef`.

    {% endlist %}

1. Создайте файл ресурса `PostgresqlCluster`. Например, с помощью команды `touch postgresqlcluster.yaml`.
1. Откройте файл и вставьте конфигурацию ниже:

    {% list tabs %}

    - Минимальная конфигурация

        {% include notitle [YAML-файл](../../_includes/yamls/operations/postgresql/create-cluster-min.md) %}

        Данные пользователя будут храниться в секрете с названием `<название кластера>-superuser`.

    - Максимальная конфигурация (резервное копирование во внешний S3)

        Используйте, если на предыдущем шаге вы создали Secret с учётными данными внешнего S3.

        {% note info %}

        Чтобы задать собственный пароль для суперпользователя, создайте секрет с паролем и укажите имя пользователя — `postgres`.

        {% endnote %}

        {% include notitle [YAML-файл](../../_includes/yamls/operations/postgresql/create-cluster-max.md) %}

        Подставьте в параметр `spec.backup.schedule` расписание резервного копирования. Формат — [CRON Expression Format](https://pkg.go.dev/github.com/robfig/cron#hdr-CRON_Expression_Format). В `spec.backup.storage.s3` укажите `endpointUrl`, `prefix`, `region` и имя секрета в `credentialsSecretRef.name`. При желании можно убрать `schedule` и не создавать расписание.

    - Максимальная конфигурация (резервное копирование в Stackland Storage)

        Вариант для резервного копирования во внутреннее объектное хранилище Stackland Storage. Укажите в манифесте `spec.backup.storage.type: stackland-storage` — бакет и ключ доступа оператор создаст автоматически.

        {% note info %}

        Чтобы задать собственный пароль для суперпользователя, создайте секрет с паролем и укажите имя пользователя — `postgres`.

        {% endnote %}

        {% include notitle [YAML-файл](../../_includes/yamls/operations/postgresql/create-cluster-max-stackland-storage.md) %}

        Подставьте в параметр `spec.backup.schedule` расписание резервного копирования. Формат — [CRON Expression Format](https://pkg.go.dev/github.com/robfig/cron#hdr-CRON_Expression_Format).

    {% endlist %}

1. Примените манифест: `kubectl apply -f postgresqlcluster.yaml -n <название проекта>`. При необходимости можно прописать название проекта в параметр ресурса `metadata.namespace` и не использовать в команде.

## Защита от удаления {#deletion-protection}

Чтобы запретить случайное удаление кластера, включите защиту от удаления: в манифесте укажите `spec.deletionProtection: true`. Пока защита включена, удаление ресурса `PostgresqlCluster` через `kubectl delete` или через консоль управления будет отклонено. Чтобы удалить кластер, сначала отключите защиту — установите `spec.deletionProtection: false` и примените манифест, после чего можно удалить кластер.

В консоли управления переключатель **Защита от удаления** доступен при создании и при редактировании кластера.

{% note info %}

Ссылка для подключения к базе данных генерируется по шаблону: `jdbc:postgresql://<название кластера>.<название проекта>.svc.{{ cluster-domain }}:6432/<название базы данных>?user=postgres&password=<пароль>&ssl=true&sslmode=require`.

Для первого подключения можно использовать название базы данных `postgres` и имя суперпользователя `postgres`.

{% endnote %}

## Через консоль управления {#console}

1. Если вы еще не открыли проект, выберите проект.
1. В левом меню выберите **PostgreSQL Clusters**.
1. Нажмите **Создать**.
1. Заполните поля:

    * **Название кластера**. Только строчные буквы, цифры и дефисы.
    * **Количество инстансов**, количество копий кластера.
    * **Версия PostgreSQL**, выберите из списка доступных версий.
    * **Вычислительные ресурсы**, где **Лимиты** — верхняя граница, **Запросы** — нижняя граница.
    * **Хранилище**, где **Тип диска** — это Storage Class (`stackland-nvme`, `stackland-ssd`, `stackland-hdd`, `stackland-other`). Подробнее о Storage Classes см. в разделе [Дисковая подсистема](../../concepts/components/disk-storage.md#storage-classes).
    * **База данных**, раздел с данными для аутентификации.
    * **Менеджер соединений**, сервис для записи и чтения, используется для всех операций изменения данных и критически важных транзакций.
    * **Резервные копии**, настройки резервного копирования базы данных в S3-бакет.
    * **Защита от удаления** — переключатель. Включённая защита запрещает удаление кластера через API и консоль до её отключения.

1. Нажмите **Создать**.

Готово, кластер появился в списке **PostgreSQL Clusters**. Чтобы скопировать ссылку для подключения:

1. Выберите кластер в списке.
1. Нажмите **Подключиться** и скопируйте ссылку.

    {% note info %}

    Ссылка генерируется по шаблону: `jdbc:postgresql://<название кластера>.<название проекта>.svc.{{ cluster-domain }}:6432/<название базы данных>?user=postgres&password=<пароль>&ssl=true&sslmode=require`. Подставьте пароль от базы данных для подключения.

    Для первого подключения можно использовать название базы данных `postgres` и имя суперпользователя `postgres`.

    {% endnote %}
