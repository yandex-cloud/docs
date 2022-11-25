{% include [terraform-definition](../../_includes/solutions/terraform-definition.md) %}

Подробнее о {{ TF }} [читайте в документации](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

Если вы создавали <что-то> с помощью {{ TF }}, вы можете удалить <его/ее>:
1. В командной строке перейдите в папку, где расположен конфигурационный файл {{ TF }}.
1. Удалите ресурсы с помощью команды:

   ```bash
   terraform destroy
   ```

   {% note alert %}

   {{ TF }} удалит все ресурсы, созданные в текущей конфигурации: кластеры, сети, подсети, виртуальные машины и т. д.

   {% endnote %}

1. Введите слово `yes` и нажмите **Enter**.