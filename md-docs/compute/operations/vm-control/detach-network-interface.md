# Удалить сетевой интерфейс на виртуальной машине


К виртуальной машине может быть привязано от одного до восьми [сетевых интерфейсов](../../concepts/network.md). Ненужные сетевые интерфейсы можно удалять как на остановленных, так и на работающих ВМ.

{% note info %}

Единственный сетевой интерфейс виртуальной машины удалить нельзя.

{% endnote %}

Чтобы удалить сетевой интерфейс на виртуальной машине:

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления сетевого интерфейса на виртуальной машине:

      ```bash
      yc compute instance detach-network-interface --help
      ```

  1. Получите список ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

      ```bash
      yc compute instance list
      ```
      
      Результат:
      ```text
      +----------------------+-----------------+---------------+---------+----------------------+
      |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
      +----------------------+-----------------+---------------+---------+----------------------+
      | fhm0b28lgfp4******** | first-instance  | ru-central1-a | RUNNING | my first vm via CLI  |
      | fhm9gk85nj7g******** | second-instance | ru-central1-a | RUNNING | my second vm via CLI |
      +----------------------+-----------------+---------------+---------+----------------------+
      ```

      Сохраните идентификатор ВМ, на которой вы хотите удалить сетевой интерфейс.

  1. При необходимости остановите выбранную ВМ, указав ее идентификатор:

      {% note info %}

      Функциональность по добавлению и удалению сетевых интерфейсов на работающих ВМ находится на [стадии Preview](../../../overview/concepts/launch-stages.md). Чтобы получить доступ к функциональности, [обратитесь](https://center.yandex.cloud/support) в техническую поддержку.

      {% endnote %}

      ```bash
      yc compute instance stop <идентификатор_ВМ>
      ```

  1. Получите список сетевых интерфейсов выбранной ВМ, указав ее идентификатор:

      ```bash
      yc compute instance get <идентификатор_ВМ>
      ```

      Результат:

      ```yml
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:1a:**:**:**
          subnet_id: e2lrucutusnd********
          primary_v4_address:
            address: 192.168.1.20
            one_to_one_nat:
              address: 158.***.**.***
              ip_version: IPV4
          security_group_ids:
            - enpuatgvejtn********
        - index: "1"
          mac_address: d0:1d:1a:**:**:**
          subnet_id: e2lpp96bvvgp********
          primary_v4_address:
            address: 192.168.2.3
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
        - index: "2"
          mac_address: d0:2d:1a:**:**:**
          subnet_id: e2lv9c6aek1d********
          primary_v4_address:
            address: 192.168.4.17
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
      ...
      ```

      Сохраните номер (значение поля `index`) сетевого интерфейса, который требуется удалить.

  1. Удалите сетевой интерфейс:

      ```bash
      yc compute instance detach-network-interface \
        --id <идентификатор_ВМ> \
        --network-interface-index <номер_сетевого_интерфейса>
      ```

      Где:
      * `--id` — идентификатор выбранной виртуальной машины. Вместо идентификатора вы можете использовать параметр `--name`, чтобы указать имя ВМ.
      * `--network-interface-index` — сохраненный ранее номер сетевого интерфейса ВМ, который требуется удалить.

      Результат:

      ```yml
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:1a:**:**:**
          subnet_id: e2lrucutusnd********
          primary_v4_address:
            address: 192.168.1.20
            one_to_one_nat:
              address: 158.***.**.***
              ip_version: IPV4
          security_group_ids:
            - enpuatgvejtn********
        - index: "1"
          mac_address: d0:1d:1a:**:**:**
          subnet_id: e2lpp96bvvgp********
          primary_v4_address:
            address: 192.168.2.3
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
      ...
      ```

- API {#api}

  Воспользуйтесь методом REST API [detachNetworkInterface](../../api-ref/Instance/detachNetworkInterface.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/DetachNetworkInterface](../../api-ref/grpc/Instance/detachNetworkInterface.md).

{% endlist %}