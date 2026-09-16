[Документация Yandex Cloud](../../../index.md) > [Yandex MPP Analytics for PostgreSQL](../../index.md) > [Пошаговые инструкции](../index.md) > Доступ из Trino

# Доступ из Trino

Чтобы работать с данными кластера Yandex MPP Analytics for PostgreSQL из Managed Service for Trino, включите **Доступ из Trino** в настройках кластера Yandex MPP Analytics for PostgreSQL. Эта настройка обеспечивает подключение с шифрованием данных при передаче между сегментами Greenplum® и воркерами Trino по протоколу GPFDIST.

{% note info %}

**Доступ из Trino** — обязательная настройка для чтения данных из Yandex MPP Analytics for PostgreSQL через GPFDIST в Managed Service for Trino. Шифрование используется автоматически, дополнительно настраивать его не нужно.

{% endnote %}

## Перед началом работы {#before-you-begin}

1. [Настройте группы безопасности](../connect/index.md#sg-for-trino) для взаимодействия кластеров Yandex MPP Analytics for PostgreSQL и Managed Service for Trino. Группы безопасности определяют, какие сетевые подключения разрешены.
1. Подготовьте пользователя Greenplum® и [каталог Trino с коннектором Greenplum®/Cloudberry](../../../managed-trino/operations/catalog-create.md#gp-clouberry). Для чтения через GPFDIST пользователю нужны права на создание записываемых внешних таблиц.

## Включить доступ из Trino {#enable-trino-access}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог с нужным кластером.
    1. [Перейдите](https://console.yandex.cloud/link/managed-greenplum) в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
    1. Выберите кластер и нажмите кнопку **Редактировать** в верхней части страницы.
    1. В дополнительных настройках включите **Доступ из Trino**.
    1. Нажмите кнопку **Сохранить** и дождитесь завершения изменения кластера.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
    
    Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Посмотрите описание команды изменения кластера:

        ```bash
        yc managed-greenplum cluster update --help
        ```

    1. Включите доступ из Trino:

        ```bash
        yc managed-greenplum cluster update <имя_или_идентификатор_кластера> \
            --trino-access=true
        ```

        Параметр `--trino-access=true` включает доступ из Trino с шифрованием данных при передаче.

    1. Дождитесь завершения операции и проверьте настройки кластера:

        ```bash
        yc managed-greenplum cluster get <имя_или_идентификатор_кластера>
        ```

        В блоке `config.access` параметр `trino` должен иметь значение `true`.

{% endlist %}

Доступ из Trino также можно включить при [создании кластера](../cluster-create.md): в консоли управления используйте настройку **Доступ из Trino**, в CLI — параметр `--trino-access=true` команды `yc managed-greenplum cluster create`.

## Настроить чтение данных {#configure-reading}

В каталоге Trino с коннектором Greenplum®/Cloudberry [задайте настройки](../../../managed-trino/operations/catalog-update.md) для чтения через GPFDIST:

* `greenplum.gpfdist.server.enabled` — `true`.
* `greenplum.gpfdist.read.enabled` — `true`.

Коннектор создаст внешние таблицы и организует передачу данных от сегментов Greenplum® к воркерам Trino. Создавать эти внешние таблицы вручную не требуется.

## Ограничения {#limitations}

* Для чтения через GPFDIST с шифрованием требуется кластер Managed Service for Trino версии 476 с поддержкой шифрования на стороне коннектора.
* Настройка предназначена только для интеграции с Managed Service for Trino.
* Управление доступом из Trino через Terraform пока не поддерживается. Используйте консоль управления или CLI.
* Включение доступа из Trino не заменяет настройку групп безопасности, прав пользователя базы данных и каталога Trino.
* Настройка относится к передаче данных по GPFDIST между сегментами Greenplum® и воркерами Trino. Параметры подключения к базе данных задаются отдельно в каталоге Trino.
* Сохраняются [ограничения чтения данных по GPFDIST](../../../managed-trino/concepts/greenplum-connector.md#gpfdist-reading).

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._

_Apache® и Apache Cloudberry™ являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._