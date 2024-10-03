{% list tabs group=instructions %}

- Консоль управления {#console}

  
  @[youtube](https://www.youtube.com/watch?v=Z7J5OwC8oJM&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=3&pp=iAQB)


  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      * Перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}**.
      * Нажмите значок ![image](../../_assets/console-icons/pencil.svg) и в открывшемся окне выберите **{{ ui-key.yacloud.common.create-new }}**.
      * В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}` и в списке ниже выберите нужный снимок диска. При необходимости воспользуйтесь фильтром.
      * Задайте имя создаваемого загрузочного диска.
      * Выберите [тип диска](../../compute/concepts/disk.md#disks_types).
      * Задайте нужные размер диска и размер блока.
      * (Опционально) В поле **{{ ui-key.yacloud.compute.field_additional }}** включите опцию **{{ ui-key.yacloud.compute.field_disk-autodelete }}**, если вы хотите автоматически удалять этот диск при удалении ВМ.
      * Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.label_add-disk }}**.

  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. Добавьте дополнительный [диск](../../compute/concepts/disk.md):

      * В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** нажмите кнопку **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
      * В открывшемся окне выберите **{{ ui-key.yacloud.compute.instances.create-disk.value_source-disk }}** → `Создать новый`.
      * В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}`.
      * Задайте имя создаваемого диска.
      * Выберите [тип диска](../../compute/concepts/disk.md#disks_types).
      * Задайте нужные размер диска и размер блока.
      * (Опционально) В поле **{{ ui-key.yacloud.compute.field_additional }}** включите опцию **{{ ui-key.yacloud.compute.field_disk-autodelete }}**, если вы хотите автоматически удалять этот диск при удалении ВМ.
      * Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.label_add-disk }}**.

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
        --create-boot-disk snapshot-name=first-snapshot \
        --create-disk snapshot-name=second-snapshot \
        --ssh-key ~/.ssh/id_ed25519.pub
      ```

      Данная команда создаст виртуальную машину именем `first-instance` в зоне `{{ region-id }}-a`, с публичным IP и дисками из снимков.

      {% include [name-fqdn](name-fqdn.md) %}
     
      Чтобы создать виртуальную машину без публичного IP, исключите флаг `--public-ip`.

      {% include [add-several-net-interfaces-notice-cli](./add-several-net-interfaces-notice-cli.md) %}

 
- API {#api}

  Воспользуйтесь методом REST API [create](../../compute/api-ref/Instance/create.md) для ресурса [Instance](../../compute/api-ref/Instance/) или вызовом gRPC API [InstanceService/Create](../../compute/api-ref/grpc/instance_service.md#Create).

{% endlist %}
