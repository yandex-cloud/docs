{% include [terraform-definition](../../_includes/solutions/terraform-definition.md) %}

Подробнее о Terraform [читайте в документации](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

Чтобы удалить кластер, созданный с помощью {{ TF }}:

1. В командной строке перейдите в каталог, в котором расположен актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
1. Удалите ресурсы с помощью команды:

    ```bash
    terraform destroy
    ```

    {% note alert %}

    {{ TF }} удалит все ресурсы, которые были созданы с его помощью: кластеры, сети, подсети, виртуальные машины и т. д.

    {% endnote %}

1. Подтвердите удаление ресурсов.
