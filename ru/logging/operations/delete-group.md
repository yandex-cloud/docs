#   Удаление группы

{% list tabs %}

- Консоль управления

 	1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите удалить [лог-группу](../concepts/log-group.md).
	1. Откройте сервис **{{ cloud-logging-name }}**.
	1. В строке с лог-группой нажмите значок ![image](../../_assets/horizontal-ellipsis.svg).
	1. В открывшемся меню нажмите кнопку **Удалить**.
	1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Для обращения к лог-группе используйте ее имя или уникальный идентификатор. Чтобы узнать их, [получите](./list.md) список лог-групп в каталоге.

    Чтобы удалить лог-группу, выполните команду:

    ```
    yc logging group delete --name=group
    ```

    Результат:

    ```
    done (1s)
    id: af3flf29t8**********
    folder_id: aoek6qrs8t**********
    cloud_id: aoegtvhtp8**********
    created_at: "2021-06-24T09:56:38.970Z"
    name: group
    status: ACTIVE
    retention_period: 3600s
    ```

{% endlist %}