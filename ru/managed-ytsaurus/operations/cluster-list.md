---
title: Информация о кластерах в {{ myt-name }}
description: Вы можете запросить детальную информацию о каждом созданном вами кластере {{ ytsaurus-name }}. Чтобы получить список кластеров в каталоге, перейдите на страницу каталога и выберите сервис {{ myt-name }}.
---

# Информация об имеющихся кластерах

{% include [preview](../../_includes/managed-ytsaurus/note-preview.md) %}

Вы можете запросить детальную информацию о каждом созданном вами кластере {{ ytsaurus-name }}.

## Получить список кластеров в каталоге {#list-clusters}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.

{% endlist %}

## Получить детальную информацию о кластере {#get-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
    1. Нажмите на имя нужного кластера.

{% endlist %}

## Посмотреть операции с кластерами {#list-operations}

Все действия с кластерами {{ ytsaurus-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

### Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы получить список операций для кластера {{ ytsaurus-name }}:

    1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится кластер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.mdb.clusters.label_title }}**.
    1. Выберите нужный кластер.
    1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** для выбранного кластера.

       В открывшемся списке отображаются операции с выбранным кластером.

{% endlist %}

### Получить подробную информацию об операции {#get-operations-info}

1. [Получите список операций](#get-operations) для кластера.
1. Скопируйте идентификатор нужной операции.
1. Получите подробную информацию об операции:

    {% list tabs group=instructions %}

    - CLI {#cli}

        {% include [cli-install](../../_includes/cli-install.md) %}

        {% include [default-catalogue](../../_includes/default-catalogue.md) %}

        Выполните команду:

        ```bash
        yc operation get <идентификатор_операции>
        ```

        Результат:

        ```bash
        id: b9k4900r7k**********
        description: Create cluster
        created_at: "2025-07-11T14:17:29.915505Z"
        created_by: ajeuoi52dg**********
        modified_at: "2025-07-11T15:12:44.572840Z"
        done: true
        metadata:
          '@type': type.googleapis.com/yandex.cloud.ytsaurus.v1.CreateClusterMetadata
          cluster_id: cnkgf75gu***********
        response:
          '@type': type.googleapis.com/yandex.cloud.ytsaurus.v1.Cluster
          ...
        ```
    {% endlist %}


