# Информация об имеющихся целевых группах

Вы можете запросить детальную информацию о каждой созданной вами целевой группе.

## Получить список целевых групп в каталоге {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
    1. На панели слева выберите ![trgroups.svg](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.load-balancer.target-group.label_list }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список целевых групп в каталоге по умолчанию, выполните команду:

    ```bash
    yc load-balancer target-group list
    ```

    Результат:

    
    ```text
    +----------------------+-------------+---------------------+-------------+--------------+
    |          ID          |    NAME     |       CREATED       |  REGION ID  | TARGET COUNT |
    +----------------------+-------------+---------------------+-------------+--------------+
    | enp1d7t5pdea******** | test-group1 | 2023-02-03 07:17:56 | {{ region-id }} |            1 |
    | ...                  |             |                     |             |              |
    +----------------------+-------------+---------------------+-------------+--------------+
    ```



- API {#api}

    Воспользуйтесь методом API [list](../api-ref/TargetGroup/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

{% endlist %}

## Получить детальную информацию о целевой группе {#get}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
    1. На панели слева выберите ![trgroups.svg](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.load-balancer.target-group.label_list }}**.
    1. Нажмите на имя нужной целевой группы.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить информацию о целевой группе, выполните команду:

    ```bash
    yc load-balancer target-group get <имя_или_идентификатор_целевой_группы>
    ```

    Идентификатор и имя целевой группы можно получить со [списком целевых групп в каталоге](#list).

- API {#api}

    Воспользуйтесь методом API [get](../api-ref/TargetGroup/get.md) и передайте идентификатор целевой группы в параметре `targetGroupId` запроса.

    Идентификатор целевой группы можно получить со [списком целевых групп в каталоге](#list).

{% endlist %}

## Посмотреть список операций в целевой группе {#list-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
    1. На панели слева выберите ![trgroups.svg](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.load-balancer.target-group.label_list }}**.
    1. Нажмите на имя нужной целевой группы и перейдите на вкладку ![operations.svg](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список операций, выполните команду:

    ```bash
    yc load-balancer target-group list-operations <имя_или_идентификатор_целевой_группы>
    ```

    Идентификатор и имя целевой группы можно получить со [списком целевых групп в каталоге](#list).

- API {#api}

    Воспользуйтесь методом API [listOperations](../api-ref/TargetGroup/listOperations.md) и передайте идентификатор целевой группы в параметре `networkLoadBalancerId` запроса.

    Идентификатор целевой группы можно получить со [списком целевых групп в каталоге](#list).

{% endlist %}
