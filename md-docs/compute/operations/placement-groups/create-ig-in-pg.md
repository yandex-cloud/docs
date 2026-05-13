# Создать группу виртуальных машин в группе размещения


Вы можете создать [группу ВМ](../../concepts/instance-groups/index.md) в [группе размещения](../../concepts/placement-groups.md).

Все операции в Instance Groups выполняются от имени сервисного аккаунта. Если сервисного аккаунта нет, [создайте его](../../../iam/operations/sa/create.md).

Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль [compute.editor](../../security/index.md#compute-editor).

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания группы размещения:

      ```bash
      yc compute placement-group create --help
      ```

  1. Создайте группу размещения в каталоге по умолчанию с одной из стратегий размещения:
  
     * [Распределенное размещение](../../concepts/placement-groups.md#spread) (spread):
     
       ```bash
       yc compute placement-group create \
         --spread-strategy \
         --name <имя_группы_размещения>
       ```
     
       Где:
     
       * `--spread-strategy` — выбор стратегии распределенного размещения.
       * `--name` — имя группы размещения.
     
     * [Размещение разделами](../../concepts/placement-groups.md#partition) (partition):
     
       ```bash
       yc compute placement-group create \
         --partitions <количество_разделов> \
         --name <имя_группы_размещения>
       ```
     
       Где:
     
       * `--partitions` — выбор стратегии размещения разделами с указанием количества разделов: от `1` до `5`.
       * `--name` — имя группы размещения.
  
  1. Посмотрите описание команды CLI для создания группы ВМ:

     ```bash
     yc compute instance-group create --help
     ```

  1. Проверьте, есть ли в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) хотя бы одна [сеть](../../../vpc/concepts/network.md#network):

      ```bash
      yc vpc network list
      ```

     Если ни одной сети нет, [создайте ее](../../../vpc/operations/network-create.md).

  1. Выберите один из публичных образов Yandex Cloud Marketplace (например, [CentOS 7](https://yandex.cloud/ru/marketplace/products/yc/centos-7)).

     Чтобы получить список доступных образов с помощью CLI, выполните команду:
     
     ```bash
     yc compute image list --folder-id standard-images
     ```
     
     Результат:
     
     ```text
     +----------------------+-------------------------------------+--------------------------+----------------------+--------+
     |          ID          |                NAME                 |          FAMILY          |     PRODUCT IDS      | STATUS |
     +----------------------+-------------------------------------+--------------------------+----------------------+--------+
     ...
     | fdvk34al8k5n******** | centos-7-1549279494                 | centos-7                 | dqni65lfhvv2******** | READY  |
     | fdv7ooobjfl3******** | windows-2016-gvlk-1548913814        | windows-2016-gvlk        | dqnnc72gj2is******** | READY  |
     | fdv4f5kv5cvf******** | ubuntu-1604-lts-1549457823          | ubuntu-1604-lts          | dqnnb6dc7640******** | READY  |
     ...
     +----------------------+-------------------------------------+--------------------------+----------------------+--------+
     ```
     
     Где:
     
     * `ID` — идентификатор образа.
     * `NAME` — имя образа.
     * `FAMILY` — идентификатор [семейства образов](../../concepts/image.md#family), к которому относится образ.
     * `PRODUCT IDS` — идентификаторы [продуктов](../../../marketplace/concepts/product.md) Yandex Cloud Marketplace, связанных с образом.
     * `STATUS` — текущий статус образа. Может принимать одно из значений:
     
         * `STATUS_UNSPECIFIED` — статус образа не определен.
         * `CREATING` — образ в процессе создания.
         * `READY` — образ готов к использованию.
         * `ERROR` — образ нельзя использовать из-за возникшей с ним проблемы.
         * `DELETING` — образ в процессе удаления.

  1. Создайте YAML-файл с произвольным именем, например `specification.yaml`.

  1. Опишите в созданном файле:

      * Общую информацию о группе ВМ:

        ```yaml
        name: first-fixed-group
        service_account_id: <идентификатор_сервисного_аккаунта>
        description: "This instance group was created from YAML config."
        ```

        Где:

        * `name` — произвольное имя группы ВМ. Имя должно быть уникальным в рамках каталога. Имя может содержать строчные буквы латинского алфавита, цифры и дефисы. Первый символ должен быть буквой. Последний символ не может быть дефисом. Максимальная длина имени — 63 символа.
        * `service_account_id` — идентификатор [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).

          Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль [compute.editor](../../security/index.md#compute-editor).

          Сервисный аккаунт нельзя удалить, пока он связан с группой виртуальных машин.

        * `description` — произвольное описание группы ВМ.
     
      * [Шаблон ВМ](../../concepts/instance-groups/instance-template.md), например:

        ```yaml
        instance_template:
          platform_id: standard-v3
          resources_spec:
            memory: 2g
            cores: 2
          boot_disk_spec:
            mode: READ_WRITE
            disk_spec:
              image_id: fdvk34al8k5n********
              type_id: network-hdd
              size: 32g
          network_interface_specs:
            - network_id: c64mknqgnd8a********
              primary_v4_address_spec: {}
              security_group_ids:
                - enps0ar5s3ti********
          scheduling_policy:
            preemptible: false
          placement_policy:
            placement_group_id: fdvte50kv3nc********
        ```

        По умолчанию размер диска указывается в байтах. Вы можете указать другую единицу измерения с помощью соответствующего суффикса.
        
        Суффикс | Приставка и множитель | Пример
        ----- | ----- | -----
        `k` | кило- (2^10^) | `640k` = 640 × 2^10^ = `655360`
        `m` | мега- (2^20^) | `48m` = 48 × 2^20^ = `50331648`
        `g` | гига- (2^30^) | `10g` = 10 × 2^30^ = `10737418240`
        `t` | тера- (2^40^) | `4t` = 4 × 2^40^ = `4398046511104`
        `p` | пета- (2^50^) | `2p` = 2 × 2^50^ = `2251799813685248`

        Где:

        * `platform_id` — идентификатор [платформы](../../concepts/vm-platforms.md).
        * `memory` — количество памяти (RAM).
        * `cores` — количество ядер процессора (vCPU).
        * `mode` — режим доступа к [диску](../../concepts/disk.md).
          * `READ_ONLY` — доступ на чтение.
          * `READ_WRITE` — доступ на чтение и запись.
        * `image_id` — идентификатор публичного образа. Идентификаторы образа можно посмотреть в [консоли управления](https://console.yandex.cloud) при создании ВМ или в [Cloud Marketplace](https://yandex.cloud/ru/marketplace) на странице образа в блоке **Идентификаторы продукта**.
        * `type_id` — тип диска.
        * `size` — размер диска.
        * `network_id` — идентификатор сети `default-net`.
        * `primary_v4_address_spec` — спецификация версии интернет протокола IPv4. Вы можете предоставить публичный доступ к ВМ группы, указав версию IP для [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses). Подробнее читайте в разделе [Описание шаблона в YAML-файле](../../concepts/instance-groups/instance-template.md#instance-template).
        * `security_group_ids` — список идентификаторов [групп безопасности](../../../vpc/concepts/security-groups.md).
        * `scheduling_policy` — конфигурация политики планирования.
        * `preemptible` — флаг, указывающий создавать [прерываемые ВМ](../../concepts/preemptible-vm.md).
          * `true` — будет создана прерываемая ВМ.
          * `false` (по умолчанию) — обычная.

          Создавая группу прерываемых ВМ учитывайте, что ВМ будут останавливаться спустя 24 часа непрерывной работы, а могут быть остановлены еще раньше. При этом возможна ситуация, что Instance Groups не сможет сразу перезапустить их из-за нехватки ресурсов. Это может произойти, если резко возрастет потребление вычислительных ресурсов в Yandex Cloud.

        * `placement_policy` — параметры [группы размещения ВМ](../../concepts/placement-groups.md):
          * `placement_group_id` — идентификатор группы размещения.
      * [Политики](../../concepts/instance-groups/policies/index.md):

        ```yaml
        deploy_policy:
          max_unavailable: 1
          max_expansion: 0
        scale_policy:
          fixed_scale:
            size: 3
        allocation_policy:
          zones:
            - zone_id: ru-central1-a
              instance_tags_pool:
              - first
              - second
              - third
        ```

        Где:

        * `deploy_policy` — [политика развертывания](../../concepts/instance-groups/policies/deploy-policy.md) ВМ в группе.
        * `scale_policy` — [политика масштабирования](../../concepts/instance-groups/policies/scale-policy.md) ВМ в группе.
        * `allocation_policy` — [политика распределения](../../concepts/instance-groups/policies/allocation-policy.md) ВМ по [зонам доступности](../../../overview/concepts/geo-scope.md).

      Полный код файла `specification.yaml`:

      ```yaml
      name: first-fixed-group
      service_account_id: <идентификатор_сервисного_аккаунта>
      description: "This instance group was created from YAML config."
      instance_template:
        platform_id: standard-v3
        resources_spec:
          memory: 2g
          cores: 2
        boot_disk_spec:
          mode: READ_WRITE
          disk_spec:
            image_id: fdvk34al8k5n********
            type_id: network-hdd
            size: 32g
        network_interface_specs:
          - network_id: c64mknqgnd8a********
            primary_v4_address_spec: {}
            security_group_ids:
              - enps0ar5s3ti********
         scheduling_policy:
           preemptible: false
         placement_policy:
           placement_group_id: fdvte50kv3nc********
      deploy_policy:
        max_unavailable: 1
        max_expansion: 0
      scale_policy:
        fixed_scale:
          size: 3
      allocation_policy:
        zones:
          - zone_id: ru-central1-a
            instance_tags_pool:
            - first
            - second
            - third
      ```

  1. Создайте группу ВМ в каталоге по умолчанию:

     ```bash
     yc compute instance-group create --file specification.yaml
     ```

     Данная команда создаст группу из трех однотипных ВМ со следующими характеристиками:
     * С именем `first-fixed-group`.
     * С OC CentOS 7.
     * В сети `default-net`.
     * В группе размещения `my-group`.
     * В зоне доступности `ru-central1-a`.
     * С 2 vCPU и 2 ГБ RAM.
     * С сетевым HDD-диском объемом 32 ГБ.

- API {#api}

  Воспользуйтесь методом REST API [create](../../instancegroup/api-ref/InstanceGroup/create.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Create](../../instancegroup/api-ref/grpc/InstanceGroup/create.md).

{% endlist %}