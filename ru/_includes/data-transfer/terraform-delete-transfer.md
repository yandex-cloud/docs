Чтобы удалить трансфер, созданный с помощью {{ TF }}:
1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

   О том, как создать такой файл, см. в разделе [{#T}](../../data-transfer/operations/transfer.md#create).
1. Удалите описание трансфера.
1. Проверьте корректность настроек.

   {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

1. Введите слово `yes` и нажмите **Enter**.

   {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-transfer }}).