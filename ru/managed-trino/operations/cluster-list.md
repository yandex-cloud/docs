---
title: Информация о кластерах в {{ mtr-name }}
description: Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mtr-name }}. Чтобы получить список кластеров в каталоге, перейдите на страницу каталога и выберите сервис {{ mtr-name }}.
noIndex: true
---

# Информация об имеющихся кластерах в {{ mtr-name }}

{% include [preview](../../_includes/managed-trino/note-preview.md) %}

Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mtr-name }}.

## Получить список кластеров в каталоге {#list-clusters}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.

{% endlist %}

## Получить детальную информацию о кластере {#get-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
    1. Нажмите на имя нужного кластера.

{% endlist %}

## Посмотреть операции с кластерами {#list-operations}

Все действия с кластерами {{ mtr-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

### Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы получить список операций для кластера {{ mtr-name }}:

    1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится кластер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.mdb.clusters.label_title }}**.
    1. Выберите нужный кластер.
    1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** для выбранного кластера.

        В открывшемся списке отображаются операции с выбранным кластером.

{% endlist %}

## См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
