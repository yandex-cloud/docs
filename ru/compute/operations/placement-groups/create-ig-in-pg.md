# Создать группу виртуальных машин в группе размещения

Вы можете создать [группу ВМ](../../concepts/instance-groups/index.md) в [группе размещения](../../concepts/placement-groups.md).

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания группы размещения:

      ```bash
      yc compute placement-group create --help
      ```

  1. Создайте группу размещения в каталоге по умолчанию с одной из стратегий размещения:
  
     {% include [pg-create](../../../_includes/compute/placement-groups-create.md) %}
  
  1. Посмотрите описание команды CLI для создания группы ВМ:

     ```bash
     {{ yc-compute-ig }} create --help
     ```

  1. Проверьте, есть ли в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) хотя бы одна [сеть](../../../vpc/concepts/network.md#network):

      ```bash
      yc vpc network list
      ```

     Если ни одной сети нет, [создайте ее](../../../vpc/operations/network-create.md).

  1. Выберите один из публичных образов {{ marketplace-full-name }} (например, [CentOS 7](/marketplace/products/yc/centos-7)).

     {% include [standard-images.md](../../../_includes/standard-images.md) %}

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
        * `service_account_id` — идентификатор сервисного аккаунта.

          {% include [sa-dependence-brief](../../../_includes/instance-groups/sa-dependence-brief.md) %}

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
          scheduling_policy:
            preemptible: false
          placement_policy:
            placement_group_id: fdvte50kv3nc********
        ```

        {% include [default-unit-size](../../../_includes/instance-groups/default-unit-size.md) %}

        Где:

        * `platform_id` — идентификатор [платформы](../../concepts/vm-platforms.md).
        * `memory` — количество памяти (RAM).
        * `cores` — количество ядер процессора (vCPU).
        * `mode` — режим доступа к [диску](../../concepts/disk.md).
          * `READ_ONLY` — доступ на чтение.
          * `READ_WRITE` — доступ на чтение и запись.
        * `image_id` — идентификатор публичного образа. Идентификаторы образа можно посмотреть в [консоли управления]({{ link-console-main }}) при создании ВМ или в [{{ marketplace-name }}](/marketplace) на странице образа в блоке **Идентификаторы продукта**.
        * `type_id` — тип диска.
        * `size` — размер диска.
        * `network_id` — идентификатор сети `default-net`.
        * `primary_v4_address_spec` — спецификация версии интернет протокола IPv4. Вы можете предоставить публичный доступ к ВМ группы, указав версию IP для [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses). Подробнее читайте в разделе [{#T}](../../concepts/instance-groups/instance-template.md#instance-template).
        * `scheduling_policy` — конфигурация политики планирования.
        * `preemptible` — флаг, указывающий создавать [прерываемые ВМ](../../concepts/preemptible-vm.md).
          * `true` — будет создана прерываемая ВМ.
          * `false` (по умолчанию) — обычная.

          Создавая группу прерываемых ВМ учитывайте, что ВМ будут останавливаться спустя 24 часа непрерывной работы, а могут быть остановлены еще раньше. При этом возможна ситуация, что {{ ig-name }} не сможет сразу перезапустить их из-за нехватки ресурсов. Это может произойти, если резко возрастет потребление вычислительных ресурсов в {{ yandex-cloud }}.

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
            - zone_id: {{ region-id }}-a
              instance_tags_pool:
              - first
              - second
              - third
        ```

        Где:

        * `deploy_policy` — [политика развертывания](../../concepts/instance-groups/policies/deploy-policy.md) ВМ в группе.
        * `scale_policy` — [политика масштабирования](../../concepts/instance-groups/policies/scale-policy.md) ВМ в группе.
        * `allocation_policy` — [политика распределения](../../concepts/instance-groups/policies/allocation-policy.md) ВМ по [зонам доступности](../../../overview/concepts/geo-scope.md) и регионам.

      Полный код файла `specification.yaml`:

      ```yaml
      name: first-fixed-group
      service_account_id: ajed6ilf11qg********
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
          - zone_id: {{ region-id }}-a
            instance_tags_pool:
            - first
            - second
            - third
      ```

  1. Создайте группу ВМ в каталоге по умолчанию:

     ```bash
     {{ yc-compute-ig }} create --file specification.yaml
     ```

     Данная команда создаст группу из трех однотипных ВМ со следующими характеристиками:
     * С именем `first-fixed-group`.
     * С OC CentOS 7.
     * В сети `default-net`.
     * В группе размещения `my-group`.
     * В зоне доступности `{{ region-id }}-a`.
     * С 2 vCPU и 2 ГБ RAM.
     * С сетевым HDD-диском объемом 32 ГБ.

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/InstanceGroup/create.md) для ресурса [InstanceGroup](../../api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Create](../../api-ref/grpc/instance_group_service.md#Create).

{% endlist %}