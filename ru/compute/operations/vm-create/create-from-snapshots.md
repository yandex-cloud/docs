# Создать виртуальную машину с дисками из снимков

Вы можете создать виртуальную машину с дисками, восстановленными из имеющихся в каталоге снимков. О том, как создать снимок диска, см. раздел [{#T}](../disk-control/create-snapshot.md).

{% list tabs %}

- Консоль управления

  Чтобы создать виртуальную машину:
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана виртуальная машина.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:

      * Введите имя и описание ВМ. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

          {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * Выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться виртуальная машина.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите один из снимков:

      * Перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_custom }}** и нажмите **{{ ui-key.yacloud.compute.instances.create.button_choose }}**.
      * В открывшемся окне перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}**.
      * Выберите снимок диска из списка и нажмите **{{ ui-key.yacloud.common.apply }}**.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** [добавьте диск](create-from-disks.md):

      * Нажмите **{{ ui-key.yacloud.compute.instances.create.label_add-disk }}**.
      * Введите имя диска.
      * Выберите [тип диска](../../concepts/disk.md#disks_types).
      * Укажите нужный размер блока.
      * Укажите нужный размер диска.
      * (Опционально) Включите опцию **{{ ui-key.yacloud.compute.instances.create-disk.field_auto-delete }}**, если нужно автоматически удалять диск при удалении ВМ, к которой он будет подключен.
      * Выберите наполнение `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}`.
      * Нажмите **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.

  
  1. (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** на вкладке **{{ ui-key.yacloud.compute.nfs.label_filesystems }}** подключите [файловое хранилище](../../concepts/filesystem.md):

     * Нажмите **{{ ui-key.yacloud.compute.nfs.button_attach-filesystem-to-the-instance }}**.
     * В открывшемся окне выберите файловое хранилище.
     * Укажите имя устройства.
     * Нажмите **{{ ui-key.yacloud.compute.nfs.button_attach-filesystem-to-the-instance }}**.
 

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:

     * Выберите [платформу](../../concepts/vm-platforms.md).
     * Укажите [гарантированную долю](../../../compute/concepts/performance-levels.md) и необходимое количество vCPU, а также объем RAM.
     * При необходимости сделайте ВМ [прерываемой](../../concepts/preemptible-vm.md).
     * (Опционально) Включите [программно-ускоренную сеть](../../concepts/software-accelerated-network.md).

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      {% include [network-settings](../../../_includes/compute/network-settings.md) %}

  
  1. {% include [backup-info](../../../_includes/compute/backup-info.md) %}


  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:

      * (Опционально) Выберите или создайте [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md). Использование сервисного аккаунта позволяет гибко настраивать права доступа к ресурсам.
      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.

        {% note alert %}

        Не используйте логин `root` или другие имена, зарезервированные операционной системой. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

        {% endnote %}

     * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла [открытого ключа](../../operations/vm-connect/ssh.md#creating-ssh-keys).
     * Если требуется, разрешите доступ к [серийной консоли](../../operations/serial-console/index.md).
 
     {% include [vm-connect-linux](../../../_includes/vm-connect-linux.md) %}

  1. Нажмите **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
  
  Виртуальная машина появится в списке. При создании виртуальной машине назначаются [IP-адрес](../../../vpc/concepts/address.md) и [имя хоста](../../../vpc/concepts/address.md#fqdn) (FQDN).

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания виртуальной машины:

      ```
      yc compute instance create --help
      ```

  1. Подготовьте снимки нужных дисков, см. раздел [{#T}](../disk-control/create-snapshot.md).
  1. Получите список снимков в каталоге по умолчанию:

      {% include [compute-snapshot-list](../../_includes_service/compute-snapshot-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужных снимков.
  1. Создайте виртуальную машину в каталоге по умолчанию:

      ```
      yc compute instance create \
        --name first-instance \
        --zone {{ region-id }}-a \
        --public-ip \
        --create-boot-disk snapshot-name=first-snapshot \
        --create-disk snapshot-name=second-snapshot \
        --ssh-key ~/.ssh/id_ed25519.pub
      ```

      Данная команда создаст виртуальную машину именем `first-instance` в зоне `{{ region-id }}-a`, с публичным IP и дисками из снимков.

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}
     
      Чтобы создать виртуальную машину без публичного IP, исключите флаг `--public-ip`.

 
- API

  Воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/instance_service.md#Create).

{% endlist %}
