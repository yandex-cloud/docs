{% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

{% if audience != "internal" %}

Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

{% endif %}

Чтобы удалить кластер, созданный с помощью {{ TF }}:
1. В командной строке перейдите в каталог, в котором расположен актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
1. Удалите ресурсы с помощью команды:

   ```bash
   terraform destroy
   ```

   {% note alert %}

   {{ TF }} удалит все ресурсы, которые были созданы с его помощью: кластеры, сети, подсети, виртуальные машины и т. д.

   {% endnote %}

1. Введите слово `yes` и нажмите **Enter**.