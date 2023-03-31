# Информация об имеющихся целевых группах

Вы можете запросить детальную информацию о каждой созданной вами целевой группе.

## Получить список целевых групп в каталоге {#list}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ network-load-balancer-name }}**.
    1. На панели слева выберите ![trgroups.svg](../../_assets/trgroups.svg) **Целевые группы**.

- CLI

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
    | enp1d7t5pdeaan2rk8c9 | test-group1 | 2023-02-03 07:17:56 | {{ region-id }} |            1 |
    | ...                  |             |                     |             |              |
    +----------------------+-------------+---------------------+-------------+--------------+
    ```



- API

    Воспользуйтесь методом API [list](../api-ref/TargetGroup/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

{% endlist %}

## Получить детальную информацию о целевой группе {#get}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ network-load-balancer-name }}**.
    1. На панели слева выберите ![trgroups.svg](../../_assets/trgroups.svg) **Целевые группы**.
    1. Нажмите на имя нужной целевой группы.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить информацию о целевой группе, выполните команду:

    ```bash
    yc load-balancer target-group get <идентификатор или имя целевой группы>
    ```

    Идентификатор и имя целевой группы можно получить со [списком целевых групп в каталоге](#list).

- API

    Воспользуйтесь методом API [get](../api-ref/TargetGroup/get.md) и передайте идентификатор целевой группы в параметре `targetGroupId` запроса.

    Идентификатор целевой группы можно получить со [списком целевых групп в каталоге](#list).

{% endlist %}

## Посмотреть список операций в целевой группе {#list-operations}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ network-load-balancer-name }}**.
    1. На панели слева выберите ![trgroups.svg](../../_assets/trgroups.svg) **Целевые группы**.
    1. Нажмите на имя нужной целевой группы и перейдите на вкладку ![operations.svg](../../_assets/mdb/operations.svg) **Операции**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список операций, выполните команду:

    ```bash
    yc load-balancer target-group list-operations <идентификатор или имя целевой группы>
    ```

    Идентификатор и имя целевой группы можно получить со [списком целевых групп в каталоге](#list).

- API

    Воспользуйтесь методом API [listOperations](../api-ref/TargetGroup/listOperations.md) и передайте идентификатор целевой группы в параметре `networkLoadBalancerId` запроса.

    Идентификатор целевой группы можно получить со [списком целевых групп в каталоге](#list).

{% endlist %}
