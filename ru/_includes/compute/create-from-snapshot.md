{% list tabs group=instructions %}

- Консоль управления {#console}

  
  @[youtube](https://www.youtube.com/watch?v=Z7J5OwC8oJM&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=3&pp=iAQB)


  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана виртуальная машина.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:

      * Введите имя и описание ВМ. Требования к имени:

          {% include [name-format](../name-format.md) %}

          {% include [name-fqdn](../compute/name-fqdn.md) %}

      * Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться виртуальная машина.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите один из снимков:

      * Перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_custom }}** и нажмите **{{ ui-key.yacloud.compute.instances.create.button_choose }}**.
      * В открывшемся окне перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}**.
      * Выберите снимок диска из списка и нажмите **{{ ui-key.yacloud.common.apply }}**.

  
  1. {% include [encryption-section-boot](encryption-section-boot.md) %}


  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** [добавьте диск](../../compute/operations/vm-create/create-from-disks.md):

      * Нажмите **{{ ui-key.yacloud.compute.instances.create.label_add-disk }}**.
      * Введите имя диска.
      * Выберите [тип диска](../../compute/concepts/disk.md#disks_types).
      * Укажите нужный размер блока.
      * Укажите нужный размер диска.
  
      
      * {% include [encryption-section-secondary](encryption-section-secondary.md) %}
  
  
      * (Опционально) Включите опцию **{{ ui-key.yacloud.compute.field_disk-autodelete }}**, если нужно автоматически удалять диск при удалении ВМ, к которой он будет подключен.
      * Выберите наполнение `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}`.
      * Нажмите **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.

  
  1. (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** на вкладке **{{ ui-key.yacloud.compute.nfs.label_filesystems }}** подключите [файловое хранилище](../../compute/concepts/filesystem.md):

     * Нажмите **{{ ui-key.yacloud.compute.nfs.button_attach-filesystem-to-the-instance }}**.
     * В открывшемся окне выберите файловое хранилище.
     * Укажите имя устройства.
     * Нажмите **{{ ui-key.yacloud.compute.nfs.button_attach-filesystem-to-the-instance }}**.
 

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:

     * Выберите [платформу](../../compute/concepts/vm-platforms.md).
     * Укажите [гарантированную долю](../../compute/concepts/performance-levels.md) и необходимое количество vCPU, а также объем RAM.
     * При необходимости сделайте ВМ [прерываемой](../../compute/concepts/preemptible-vm.md).
     * (Опционально) Включите [программно-ускоренную сеть](../../compute/concepts/software-accelerated-network.md).

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      {% include [network-settings](network-settings.md) %}

  
  1. {% include [backup-info](backup-info.md) %}


  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:

      * (Опционально) Выберите или создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md). Использование сервисного аккаунта позволяет гибко настраивать права доступа к ресурсам.
      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.

        {% note alert %}

        Не используйте логин `root` или другие имена, зарезервированные операционной системой. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

        {% endnote %}

     * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла [открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
     * Если требуется, разрешите доступ к [серийной консоли](../../compute/operations/serial-console/index.md).
 
     {% include [vm-connect-linux](../vm-connect-linux.md) %}

  1. (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_placement }}** выберите [группу размещения](../../compute/concepts/placement-groups.md) ВМ.
  1. Нажмите **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
  
  Виртуальная машина появится в списке. При создании виртуальной машине назначаются [IP-адрес](../../vpc/concepts/address.md) и [имя хоста](../../vpc/concepts/address.md#fqdn) (FQDN).

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания виртуальной машины:

      ```
      yc compute instance create --help
      ```

  1. Подготовьте снимки нужных дисков, см. раздел [{#T}](../../compute/operations/disk-control/create-snapshot.md).
  1. Получите список снимков в каталоге по умолчанию:

      {% include [compute-snapshot-list](../../compute/_includes_service/compute-snapshot-list.md) %}

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

      {% include [name-fqdn](name-fqdn.md) %}
     
      Чтобы создать виртуальную машину без публичного IP, исключите флаг `--public-ip`.

 
- API {#api}

  Воспользуйтесь методом REST API [create](../../compute/api-ref/Instance/create.md) для ресурса [Instance](../../compute/api-ref/Instance/) или вызовом gRPC API [InstanceService/Create](../../compute/api-ref/grpc/instance_service.md#Create).

{% endlist %}
