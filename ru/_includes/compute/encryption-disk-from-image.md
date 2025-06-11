{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать зашифрованный диск.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.disks.button_create }}**.
  1. Введите имя диска.

      {% include [name-format](../name-format.md) %}

  1. Выберите ту же [зону доступности](../../overview/concepts/geo-scope.md), в которой находился исходный диск.
  1. Задайте параметры диска: [тип диска](../../compute/concepts/disk.md#disks_types), а также [размер блока](../../compute/concepts/disk.md#maximum-disk-size) и [размер диска](../../compute/concepts/disk.md#maximum-disk-size).
  1. В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` и в списке ниже отметьте образ, который создали ранее. Для поиска образа воспользуйтесь фильтром.
  1. {% include [encryption-section](encryption-section.md) %}
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.disks.button_create }}**.

  После создания диск перейдет в статус `Creating`. Дождитесь, когда диск перейдет в статус `Ready`, прежде чем его использовать.

{% endlist %}
