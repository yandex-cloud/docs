# Создать виртуальную машину Linux с подключением к {{ backup-name }}

Сервис {{ backup-name }} поддерживает резервное копирование [виртуальных машин {{ compute-name }}](../../compute/concepts/vm.md) с операционными системами семейства Linux — Ubuntu 20.04 и ниже и CentOS 7. Подробнее см. в разделе [{#T}](../concepts/vm-connection.md#os).

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать ВМ.
  1. В списке сервисов выберите **{{ compute-name }}**.
  1. Нажмите кнопку **Создать ВМ**.
  1. В блоке **Выбор образа/загрузочного диска** выберите операционную систему Ubuntu версии 20.04 или ниже или CentOS 7.
  1. Укажите необходимые параметры ВМ. Подробнее см. [Создать виртуальную машину из публичного образа Linux](../../compute/operations/vm-create/create-linux-vm).

     {% include [vm-prereqs-note](../../_includes/backup/vm-prereqs-note.md) %}

  1. В блоке **Резервное копирование** выберите опцию подключения ВМ к сервису {{ backup-name }}.
  1. Нажмите кнопку **Создать ВМ**. 

{% endlist %}

{% include [agent-installation-timespan](../../_includes/backup/agent-installation-timespan.md) %}

{% include [vm-list](../../_includes/backup/vm-list.md) %}

{% include [agent-installation-failure](../../_includes/backup/agent-installation-failure.md) %}

#### См. также {#see-also}

* [{#T}](connect-vm-windows.md)
* [{#T}](connect-vm-linux.md)
* [Привязать виртуальную машину к политике резервного копирования](./policy-vm/update.md#update-vm-list)
* [{#T}](./backup-vm/recover.md)
* [{#T}](./backup-vm/delete.md)
* [{#T}](./policy-vm/create.md)
