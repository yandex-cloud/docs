# Создание виртуальной машины в группе выделенных хостов

Виртуальная машина будет создана с привязкой к одному из [выделенных хостов](../../concepts/dedicated-host.md) группы. При остановке ВМ она будет недоступна на хостах группы, а при последующем перезапуске может быть привязана к другому хосту из группы.

Если у вас еще нет группы выделенных хостов, [создайте](create-host-group.md) ее.

Чтобы создать ВМ:

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Узнайте идентификатор группы выделенных хостов, в которой необходимо создать ВМ:

      ```bash
      yc compute host-group list
      ```

      Результат:

      ```bash
      +----------------------+------+---------------+--------+---------------------+------+
      |          ID          | NAME |     ZONE      | STATUS |        TYPE         | SIZE |
      +----------------------+------+---------------+--------+---------------------+------+
      | abcdefg1hi23gkl16dnf |      | {{ region-id }}-a | READY  | intel-6230-c66-m454 |    2 |
      +----------------------+------+---------------+--------+---------------------+------+
      ```

  1. Получите список доступных подсетей:

      ```bash
      yc vpc subnet list
      ```

      Результат:

      ```bash
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      |          ID          |         NAME          |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE      |
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      | b0c6n43f9lgh3695v2k2 | default-{{ region-id }}-c | enpe3m3fa00udao8g5lg |                | {{ region-id }}-c | [10.130.0.0/24] |
      | e2l2da8a20b33g7o73bv | default-{{ region-id }}-b | enpe3m3fa00udao8g5lg |                | {{ region-id }}-b | [10.129.0.0/24] |
      | e9bnlm18l70ao30pvfaa | default-{{ region-id }}-a | enpe3m3fa00udao8g5lg |                | {{ region-id }}-a | [10.128.0.0/24] |
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      ```

  1. Выполните команду для создания ВМ:

      ```bash
      yc compute instance create \
        --host-group-id <идентификатор группы выделенных хостов> \
        --zone <зона доступности> \
        --network-interface subnet-name=<имя подсети>
      ```

      Где:

      * `host-group-id` — идентификатор группы выделенных хостов.
      * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой размещена группа выделенных хостов.      
      * `network-interface subnet-name` — имя подсети в зоне доступности.
      
      Чтобы указать характеристики ВМ, используйте параметры команды `yc compute instance create`, описанные в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/instance/create.md). Подробнее см. в разделах [{#T}](../../concepts/vm.md) и [{#T}](../index.md#vm-create).

      Результат:

      ```bash
      done (20s)
      id: fhmbdt1jj2k3ls036909
      folder_id: m4n56op78mev0cljderg
      created_at: "2020-10-13T07:41:19Z"
      zone_id: {{ region-id }}-a
      ...
      placement_policy:
        host_affinity_rules:
        - key: yc.hostGroupId
          op: IN
          values:
          - abcdefg1hi23gkl16dnf
      ```

- API

  1. Узнайте идентификатор группы выделенных хостов с помощью метода [list](../../api-ref/HostGroup/list.md) для ресурса `HostGroup`.
  1. Создайте ВМ с помощью метода [create](../../api-ref/Instance/create.md) для ресурса `Instance`.

{% endlist %}

{% if product == "cloud-il" %}

## Пример создания виртуальной машины в группе выделенных хостов с локальным NVMe-диском {#host-vm-nvme}

Перед созданием ВМ, [создайте](create-host-group.md) группу выделенных хостов и узнайте ее идентификатор с помощью [команды CLI](../../../cli/cli-ref/managed-services/compute/host-group/list.md) `yc compute host-group list`.

Создайте ВМ со следующими характеристиками:
* Размещение: группа выделенных хостов.
* Платформа: Intel Cascade Lake.
* Количество vCPU: 32.
* Объем RAM: 352 ГБ.
* Количество NVMe-дисков: 2.
* Размер NVMe-диска: 1600 ГБ.
* Операционная система: [Windows Server 2019 Datacenter](/marketplace/products/yc/windows-server-2019-datacenter).

Для этого выполните следующие действия:

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Создайте файл формата YAML, например `metadata.yaml`, в котором задайте пароль пользователя administrator создаваемой ВМ:

      ```bash
      #ps1
      net user administrator '<пароль>'
      ```

  1. Выполните команду для создания ВМ:
  
      ```bash
      yc compute instance create \
        --cloud-id <идентификатор облака> \
        --folder-id <идентификатор каталога> \
        --zone <зона доступности> \
        --name <имя ВМ> \
        --platform standard-v2 \
        --cores 32 \
        --memory 352 \
        --host-group-id <идентификатор группы выделенных хостов> \
        --network-interface subnet-id=<идентификатор подсети> \
        --attach-local-disk "size=1717986918400" \
        --attach-local-disk "size=1717986918400" \
        --metadata-from-file user-data=metadata.yaml \
        --create-boot-disk name=rds-c1-d1-sas-boot-disk,size=1000,image-folder-id=standard-images,image-family=windows-2019-dc-gvlk
      ```

      Где:

      * `cloud-id` — [идентификатор облака](../../../resource-manager/operations/cloud/get-id.md).
      * `folder-id` — идентификатор каталога.
      * `zone` — зона доступности, в которой размещена группа выделенных хостов.
      * `name` — имя ВМ.
      * `platform` — платформа ВМ.
      * `cores` — количество vCPU.
      * `memory` — объем RAM.
      * `host-group-id` — идентификатор группы выделенных хостов.
      * `network-interface subnet-id` — идентификатор подсети в зоне доступности, в которой размещается ВМ.
      * `attach-local-disk` — размер подключаемого локального диска.
      * `metadata-from-file user-data` — путь к файлу с паролем пользователя administrator.
      * `create-boot-disk` — параметры загрузочного диска.

      Результат:

      ```bash
      done (20s)
      id: fhmbdt1jj2k3ls036909
      folder_id: m4n56op78mev0cljderg
      created_at: "2020-10-13T07:41:19Z"
      zone_id: {{ region-id }}-a
      ...
      placement_policy:
        host_affinity_rules:
        - key: yc.hostGroupId
          op: IN
          values:
          - abcdefg1hi23gkl16dnf
      ```

{% endlist %}

{% endif %}
