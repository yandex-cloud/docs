---
title: Создание кластера {{ TR }}
description: Каждый кластер {{ mtr-name }} состоит из набора компонентов {{ TR }}, каждый из которых может быть представлен в нескольких экземплярах. Экземпляры могут находиться в разных зонах доступности.
keywords:
  - создание кластера {{ TR }}
  - кластер {{ TR }}
  - '{{ TR }}'
---

# Создание кластера {{ TR }}

{% include [preview](../../_includes/managed-trino/note-preview.md) %}

Каждый [кластер](../../glossary/cluster.md) {{ mtr-name }} состоит из набора компонентов {{ TR }}: координатора и воркеров, которые могут быть представлены в нескольких экземплярах.

## Роли для создания кластера {#roles}

Для создания кластера {{ mtr-name }} вашему аккаунту в {{ yandex-cloud }} нужны роли:

* [managed-trino.admin](../security.md#managed-trino-admin) — чтобы создать кластер;
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../../vpc/concepts/network.md#network) кластера;
* [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) — чтобы привязать сервисный аккаунт к кластеру.

Сервисному аккаунту кластера должны быть назначены роли `managed-trino.integrationProvider` и `storage.editor`. Это даст кластеру нужные права для работы с пользовательскими ресурсами.

О назначении ролей читайте в [документации {{ iam-full-name }}](../../iam/operations/roles/grant.md).

## Создать кластер {#create-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер {{ mtr-name }}.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        1. Задайте имя кластера. Имя должно быть уникальным в рамках каталога.
        1. (Опционально) Введите описание кластера.
        1. (Опционально) Создайте [метки](../../resource-manager/concepts/labels.md):

            1. Нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.

        1. Выберите существующий [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) или [создайте новый](../../iam/operations/sa/create.md).

            Сервисному аккаунту должны быть назначены роли `managed-trino.integrationProvider` и `storage.editor`.

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите [сеть](../../vpc/operations/network-create.md), [подсеть](../../vpc/operations/subnet-create.md) и [группу безопасности](../../vpc/concepts/security-groups.md) для кластера.
    1. Задайте конфигурацию [координатора](../concepts/index.md#coordinator) и [воркеров](../concepts/index.md#workers).
    1. В блоке **{{ ui-key.yacloud.trino.title_catalogs }}** добавьте необходимые [каталоги](../concepts/index.md#catalog). Вы можете сделать это как при создании кластера, так и позже.

        1. Задайте имя каталога. Имя должно быть уникальным в рамках облака.
        1. Выберите **{{ ui-key.yacloud.trino.catalogs.field_catalog-type }}**.
        1. В блоке **Настройки каталога** задайте параметры в зависимости от выбранного типа:

            * Для [коннекторов](../concepts/index.md#connector) Hive, Iceberg и Delta Lake:

                * **URI** для подключения к кластеру Metastore в формате `thrift://<IP-адрес>:<порт>`.
                * **Файловое хранилище** — выберите тип файлового хранилища: **Yandex Object Storage** или **Внешнее хранилище**. Для внешнего хранилища задайте следующие настройки:
                    * Идентификатор AWS-совместимого статического ключа доступа.
                    * Секретный ключ AWS-совместимого статического ключа доступа.
                    * Эндпоинт файлового хранилища, например `{{ s3-storage-host }}`.
                    * Регион файлового хранилища, например `{{ region-id }}`.

            * Для коннекторов {{ PG }} и {{ CH }}:

                * **URL** для подключения к кластеру в формате `jdbc:<СУБД>://<адрес_хоста>:<порт>/<имя_базы_данных>`, где `СУБД` — `postgresql` или `clickhouse`.
                * **Имя пользователя** для подключения к кластеру.
                * **Пароль** пользователя.

            * Коннекторы [TPC-H](https://trino.io/docs/current/connector/tpch.html) и [TPC-DS](https://trino.io/docs/current/connector/tpcds.html) предоставляют доступ к тестовым данным и не нуждаются в настройке.

        1. (Опционально) Задайте дополнительные настройки каталога в формате `ключ:значение`.

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}**:

        1. (Опционально) Включите защиту от удаления кластера.
        1. (Опционально) Настройте логирование:

            1. Включите настройку **{{ ui-key.yacloud.logging.field_logging }}**.
            1. Выберите место записи логов:
                * **{{ ui-key.yacloud.common.folder }}** — выберите каталог из списка.
                * **{{ ui-key.yacloud.logging.label_group }}** — выберите [лог-группу](../../logging/concepts/log-group.md) из списка или создайте новую.
            1. Выберите **{{ ui-key.yacloud.logging.label_minlevel }}** из списка.

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
