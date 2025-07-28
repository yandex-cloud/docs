---
title: Создание кластера {{ SPQR }}
description: Следуя данной инструкции, вы сможете создать кластер {{ SPQR }} со стандартным или расширенным шардированием.
keywords:
  - создание кластера {{ SPQR }}
  - кластер {{ SPQR }}
  - '{{ SPQR }}'
---

# Создание кластера {{ SPQR }}

{% include notitle [preview](../../_includes/note-preview.md) %}

## Создать кластер {#create-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер {{ SPQR }}.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        1. Задайте имя кластера. Имя должно быть уникальным в рамках каталога.
        1. (Опционально) Введите описание кластера.
        1. (Опционально) Создайте [метки](../../resource-manager/concepts/labels.md):

            1. Нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.

        1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):

            * `PRODUCTION` — для стабильных версий ваших приложений.
            * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению, и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.

        1. Выберите тип шардирования:

            * `{{ ui-key.yacloud.spqr.section_sharding-type-standard }}` — кластер будет состоять только из инфраструктурных хостов.
            * `{{ ui-key.yacloud.spqr.section_sharding-type-advanced }}` — кластер будет состоять только из хостов-роутеров и (опционально) хостов-координаторов.

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите [сеть](../../vpc/operations/network-create.md) и [группы безопасности](../../vpc/concepts/security-groups.md) для кластера.

    1. Задайте конфигурацию вычислительных ресурсов:

        * Для стандартного шардирования задайте в блоке **{{ ui-key.yacloud.spqr.section_infra }}** конфигурацию инфраструктурных хостов.
        * Для расширенного шардирования задайте в блоке **{{ ui-key.yacloud.spqr.section_router }}** конфигурацию хостов-роутеров.

            (Опционально) В блоке **{{ ui-key.yacloud.spqr.section_coordinator }}** включите опцию **{{ ui-key.yacloud.spqr.field_coordinator }}** и задайте конфигурацию хостов-координаторов.

        Чтобы задать конфигурацию вычислительных ресурсов:

        1. В поле **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}** выберите платформу.
        1. Укажите **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** виртуальной машины, на которой будут развернуты хосты.
        1. Выберите **{{ ui-key.yacloud.mdb.forms.section_resource }}**.
        1. В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}** выберите тип диска и укажите размер [хранилища](../concepts/storage.md).
        1. В блоке **{{ ui-key.yacloud.spqr.section_hosts }}**:

            1. Нажмите кнопку **{{ ui-key.yacloud.mdb.hosts.dialog.label_title }}**, чтобы добавить нужное количество хостов, создаваемых вместе с кластером {{ SPQR }}.
            1. Нажмите на значок ![image](../../_assets/console-icons/pencil.svg) и укажите для каждого хоста:

                * [Зону доступности](../../overview/concepts/geo-scope.md).
                * [Подсеть](../../vpc/concepts/network.md#subnet) — по умолчанию каждый хост создается в отдельной подсети.
                * Опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если хост должен быть доступен извне {{ yandex-cloud }}.

            После создания кластера {{ SPQR }} в него можно добавить дополнительные хосты, если для этого достаточно [ресурсов каталога](../concepts/limits.md).

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}** укажите параметры БД:

        * Имя БД. Допустимая длина — от 1 до 63 символов. Может содержать строчные и прописные буквы латинского алфавита, цифры, нижние подчеркивания и дефисы.

        * Имя пользователя. Допустимая длина — от 1 до 63 символов. Может содержать строчные и прописные буквы латинского алфавита, цифры, нижние подчеркивания и дефисы, но не может начинаться с дефиса.

        * Пароль пользователя. Допустимая длина — от 8 до 128 символов.

    1. При необходимости задайте дополнительные настройки кластера:

        {% include [extra-settings](../../_includes/mdb/mspqr/console/extra-settings.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

{% endlist %}
