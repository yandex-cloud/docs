{% list tabs group=instructions %}

- Консоль управления {#console}

  
  <iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvgn27iqhtcqzygof3?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

  [Смотреть видео на YouTube](https://www.youtube.com/watch?v=Z7J5OwC8oJM&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=3&pp=iAQB).



  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      * Перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}**.
      * Нажмите значок ![image](../../_assets/console-icons/pencil.svg) и в открывшемся окне выберите **{{ ui-key.yacloud.common.create }}**.
      * В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}` и в списке ниже выберите нужный снимок диска. При необходимости воспользуйтесь фильтром.
      * Задайте имя создаваемого загрузочного диска.
      * Выберите [тип диска](../../compute/concepts/disk.md#disks_types).
      * Задайте нужные размер диска и размер блока.
      * (Опционально) В поле **{{ ui-key.yacloud.compute.field_additional_vt356 }}** включите опцию **{{ ui-key.yacloud.compute.field_disk-autodelete_qZn4x }}**, если вы хотите автоматически удалять этот диск при удалении ВМ.
      * Нажмите кнопку **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.

  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. Добавьте дополнительный [диск](../../compute/concepts/disk.md):

      * В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** нажмите кнопку **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
      * В открывшемся окне выберите **{{ ui-key.yacloud.compute.instances.create-disk.value_source-disk }}** → `Создать новый`.
      * В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}`.
      * Задайте имя создаваемого диска.
      * Выберите [тип диска](../../compute/concepts/disk.md#disks_types).
      * Задайте нужные размер диска и размер блока.
      * (Опционально) В поле **{{ ui-key.yacloud.compute.field_additional_vt356 }}** включите опцию **{{ ui-key.yacloud.compute.field_disk-autodelete_qZn4x }}**, если вы хотите автоматически удалять этот диск при удалении ВМ.
      * Нажмите кнопку **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.

  1. {% include [encryption-section-secondary](encryption-section-secondary.md) %}
  1. {% include [section-storages-filesystem](create/section-storages-filesystem.md) %}
  1. {% include [section-platform](create/section-platform.md) %}
  1. {% include [network-settings](create/section-network.md) %}
  1. {% include [section-access](create/section-access.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ:

      {% include [name-format](../name-format.md) %}

      {% include [name-fqdn](../compute/name-fqdn.md) %}

  1. {% include [section-additional](../../_includes/compute/create/section-additional.md) %}
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

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
        --create-boot-disk snapshot-name=first-snapshot,kms-key-id=<идентификатор_ключа> \
        --create-disk snapshot-name=second-snapshot,kms-key-id=<идентификатор_ключа> \
        --ssh-key ~/.ssh/id_ed25519.pub
      ```

      Где:

      * `--name` — имя ВМ. Требования к имени:

          {% include [name-format](../../_includes/name-format.md) %}

          {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

      * `--zone` — [зона доступности](../../overview/concepts/geo-scope.md).
      * `--public-ip` — подключение публичного IP-адреса. Чтобы создать виртуальную машину без публичного IP-адреса, исключите этот флаг.
      * `--create-boot-disk` — настройки загрузочного диска ВМ:

          * `snapshot-name` — имя снимка диска.
          * `kms-key-id` — идентификатор [симметричного ключа {{ kms-short-name }}](../../kms/concepts/key.md) для создания зашифрованного загрузочного диска. Необязательный параметр.

            {% include [encryption-role](../../_includes/compute/encryption-role.md) %}

            {% include [encryption-disable-warning](../../_includes/compute/encryption-disable-warning.md) %}

            {% include [encryption-keys-note](../../_includes/compute/encryption-keys-note.md) %}

      * `--create-disk` — настройки дополнительного диска:

          * `snapshot-name` — имя снимка диска.
          * `kms-key-id` — идентификатор [симметричного ключа {{ kms-short-name }}](../../kms/concepts/key.md) для создания зашифрованного диска. Необязательный параметр.

      * `--ssh-key` — путь к файлу с [публичным SSH-ключом](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys). Для этого ключа на ВМ будет автоматически создан пользователь `yc-user`.

          {% include [ssh-note](../../_includes/compute/ssh-note.md) %}

      Команда создаст виртуальную машину именем `first-instance` в зоне `{{ region-id }}-a`, с публичным IP и дисками из снимков.

      {% include [add-several-net-interfaces-notice-cli](./add-several-net-interfaces-notice-cli.md) %}

- API {#api}

  Воспользуйтесь методом REST API [create](../../compute/api-ref/Instance/create.md) для ресурса [Instance](../../compute/api-ref/Instance/) или вызовом gRPC API [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md).

{% endlist %}
