Чтобы создать [виртуальную машину](../concepts/vm.md):
1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
   * Введите имя и описание ВМ. Требования к имени:

     {% include [name-format](../../_includes/name-format.md) %}

     {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

   * Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите один из [образов](../concepts/image.md) и версию операционной системы на базе Linux.
1. (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** на вкладке **{{ ui-key.yacloud.compute.instances.create.section_disk }}** настройте загрузочный [диск](../concepts/disk.md):
   * Выберите [тип диска](../concepts/disk.md#disks_types).
   * Укажите нужный размер диска.

     Если вы хотите создать ВМ из существующего диска, в блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** [добавьте диск](../operations/vm-create/create-from-disks.md):
     * Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.label_add-disk }}**.
     * Введите имя диска.
     * Выберите [тип диска](../concepts/disk.md#disks_types).
     * Укажите нужный размер блока.
     * Укажите нужный размер диска.
     * (Опционально) В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_additional }}** включите опцию **{{ ui-key.yacloud.compute.instances.create-disk.field_auto-delete }}**, если нужно автоматически удалять диск при удалении ВМ, к которой он будет подключен.
     * В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите `{{ ui-key.yacloud.compute.instances.create-disk.value_source-disk }}`.
     * Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.


1. (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** на вкладке **{{ ui-key.yacloud.compute.nfs.label_filesystems }}** подключите [файловое хранилище](../concepts/filesystem.md):
   * Нажмите кнопку **{{ ui-key.yacloud.compute.nfs.button_attach-filesystem-to-the-instance }}**.
   * В открывшемся окне укажите файловое хранилище.
   * Укажите имя устройства.
   * Нажмите кнопку **{{ ui-key.yacloud.compute.nfs.button_attach-filesystem-to-the-instance }}**.


1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
   * Выберите [платформу](../concepts/vm-platforms.md).
   * Укажите [гарантированную долю](../../compute/concepts/performance-levels.md) и необходимое количество vCPU, а также объем RAM.
   * При необходимости сделайте ВМ [прерываемой](../concepts/preemptible-vm.md).
   * (Опционально) Включите [программно-ускоренную сеть](../concepts/software-accelerated-network.md).
  
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

   {% include [network-settings](../../_includes/compute/network-settings.md) %}


1. {% include [backup-info](../../_includes/compute/backup-info.md) %}


1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:
   * (Опционально) Выберите или создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md). Использование сервисного аккаунта позволяет гибко настраивать права доступа к ресурсам.
   * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.

     {% note alert %}

     Не используйте логин `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

     {% endnote %}

   * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла [открытого ключа](../operations/vm-connect/ssh.md#creating-ssh-keys). Пару ключей для подключения по [SSH](../../glossary/ssh-keygen.md) необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
   * Если требуется, разрешите доступ к [серийной консоли](../operations/serial-console/index.md).

   {% include [vm-connect-linux](../../_includes/vm-connect-linux.md) %}

1. (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_placement }}** выберите [группу размещения](../concepts/placement-groups.md) ВМ.
1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

ВМ появится в списке. При создании ВМ назначаются [IP-адрес](../../vpc/concepts/address.md) и [имя хоста](../../vpc/concepts/address.md#fqdn) (FQDN).