Чтобы создать виртуальную машину:
1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана виртуальная машина.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Справа сверху нажмите **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
    * Введите имя и описание ВМ. Требования к имени:

        {% include [name-format](../../name-format.md) %}

        {% include [name-fqdn](../name-fqdn.md) %}

    * Выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться виртуальная машина.

      
      {% include [gpu-zones](../gpu-zones.md) %}
      


1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** на вкладке **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** выберите один из [GPU-ориентированных образов](/marketplace?search=gpu) и версию операционной системы.

    {% include [gpu-os](../gpu-os.md) %}

1. (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** настройте загрузочный диск:
    * Выберите [тип диска](../../../compute/concepts/disk.md#disks_types).
    * Укажите нужный размер диска.


1. (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** на вкладке **{{ ui-key.yacloud.compute.nfs.label_filesystems }}** подключите [файловое хранилище](../../../compute/concepts/filesystem.md):

     * Нажмите **{{ ui-key.yacloud.compute.nfs.button_attach-filesystem-to-the-instance }}**.
     * В открывшемся окне выберите файловое хранилище.
     * Укажите имя устройства.
     * Нажмите **{{ ui-key.yacloud.compute.nfs.button_attach-filesystem-to-the-instance }}**.


1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
    * Выберите одну из [платформ](../../../compute/concepts/vm-platforms.md#gpu-platforms):

      
      * {{ v100-broadwell }}
      * {{ v100-cascade-lake }}
      * {{ a100-epyc }}
      * {{ t4-ice-lake }}
      
      
       
    * Выберите [конфигурацию](../../../compute/concepts/gpus.md#config) виртуальной машины, указав необходимое количество [GPU](../../../glossary/gpu.md).
    * При необходимости сделайте виртуальную машину [прерываемой](../../../compute/concepts/preemptible-vm.md).


1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

    {% include [network-settings](../../../_includes/compute/network-settings.md) %}

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на виртуальную машину:
    * (Опционально) Выберите или создайте [сервисный аккаунт](../../../iam/concepts/index.md#sa). Использование сервисного аккаунта позволяет гибко настраивать права доступа к ресурсам.

        Для ВМ с операционной системой на базе Linux:
        * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.

          {% note alert %}

          Не используйте логин `root` или другие имена, зарезервированные операционной системой. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

          {% endnote %}

        * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла [открытого ключа](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

        * (Опционально) При необходимости разрешите доступ к [серийной консоли](../../../compute/operations/index.md#serial-console).

        {% include [vm-connect-linux](../../../_includes/vm-connect-linux.md) %}

1. Нажмите **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

Виртуальная машина появится в списке.
