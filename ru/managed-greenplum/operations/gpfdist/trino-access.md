---
title: Доступ из {{ TR }}
description: Как включить безопасное подключение {{ mgp-name }} к {{ mtr-name }} через консоль управления и CLI.
---

# Доступ из {{ TR }}

Чтобы работать с данными кластера {{ mgp-name }} из {{ mtr-name }}, включите **Доступ из Trino** в настройках кластера {{ mgp-name }}. Эта настройка обеспечивает подключение с шифрованием данных при передаче между сегментами {{ GP }} и воркерами {{ TR }} по протоколу GPFDIST.

{% note info %}

**Доступ из Trino** — обязательная настройка для чтения данных из {{ mgp-name }} через GPFDIST в {{ mtr-name }}. Шифрование используется автоматически, дополнительно настраивать его не нужно.

{% endnote %}

## Перед началом работы {#before-you-begin}

1. [Настройте группы безопасности](../connect/index.md#sg-for-trino) для взаимодействия кластеров {{ mgp-name }} и {{ mtr-name }}. Группы безопасности определяют, какие сетевые подключения разрешены.
1. Подготовьте пользователя {{ GP }} и [каталог {{ TR }} с коннектором {{ GP }}/Cloudberry](../../../managed-trino/operations/catalog-create.md#gp-clouberry). Для чтения через GPFDIST пользователю нужны права на создание записываемых внешних таблиц.

## Включить доступ из {{ TR }} {#enable-trino-access}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
    1. [Перейдите]({{ link-console-main }}/link/managed-greenplum) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** в верхней части страницы.
    1. В дополнительных настройках включите **Доступ из Trino**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}** и дождитесь завершения изменения кластера.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды изменения кластера:

        ```bash
        {{ yc-mdb-gp }} cluster update --help
        ```

    1. Включите доступ из {{ TR }}:

        ```bash
        {{ yc-mdb-gp }} cluster update <имя_или_идентификатор_кластера> \
            --trino-access=true
        ```

        Параметр `--trino-access=true` включает доступ из {{ TR }} с шифрованием данных при передаче.

    1. Дождитесь завершения операции и проверьте настройки кластера:

        ```bash
        {{ yc-mdb-gp }} cluster get <имя_или_идентификатор_кластера>
        ```

        В блоке `config.access` параметр `trino` должен иметь значение `true`.

{% endlist %}

Доступ из {{ TR }} также можно включить при [создании кластера](../cluster-create.md): в консоли управления используйте настройку **Доступ из Trino**, в CLI — параметр `--trino-access=true` команды `{{ yc-mdb-gp }} cluster create`.

## Настроить чтение данных {#configure-reading}

В каталоге {{ TR }} с коннектором {{ GP }}/Cloudberry [задайте настройки](../../../managed-trino/operations/catalog-update.md) для чтения через GPFDIST:

* `greenplum.gpfdist.server.enabled` — `true`.
* `greenplum.gpfdist.read.enabled` — `true`.

Коннектор создаст внешние таблицы и организует передачу данных от сегментов {{ GP }} к воркерам {{ TR }}. Создавать эти внешние таблицы вручную не требуется.

## Ограничения {#limitations}

* Для чтения через GPFDIST с шифрованием требуется кластер {{ mtr-name }} версии 476 с поддержкой шифрования на стороне коннектора.
* Настройка предназначена только для интеграции с {{ mtr-name }}.
* Управление доступом из {{ TR }} через {{ TF }} пока не поддерживается. Используйте консоль управления или CLI.
* Включение доступа из {{ TR }} не заменяет настройку групп безопасности, прав пользователя базы данных и каталога {{ TR }}.
* Настройка относится к передаче данных по GPFDIST между сегментами {{ GP }} и воркерами {{ TR }}. Параметры подключения к базе данных задаются отдельно в каталоге {{ TR }}.
* Сохраняются [ограничения чтения данных по GPFDIST](../../../managed-trino/concepts/greenplum-connector.md#gpfdist-reading).

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}

{% include [cloudberry-trademark](../../../_includes/mdb/mgp/trademark-cloudberry.md) %}
