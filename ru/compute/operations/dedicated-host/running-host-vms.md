# Создание виртуальной машины на выделенном хосте

Виртуальная машина будет создана с привязкой к выбранному [выделенному хосту](../../concepts/dedicated-host.md) из группы. При остановке ВМ она будет недоступна на хосте, а при последующем перезапуске будет привязана к этому же хосту из группы.

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

      {% include [dedicated-types-cli-output](../../../_includes/compute/dedicated-types-cli-output.md) %}

  1. Узнайте идентификатор выделенного хоста в группе, на котором необходимо создать ВМ:

      ```bash
      yc compute host-group list-hosts <идентификатор_группы_выделенных_хостов>
      ```

      Результат:

      ```bash
      +----------------------+----------------------+
      |          ID          |      SERVER ID       |
      +----------------------+----------------------+
      | fhm1ab2mhnf3cd1610f5 | fhmlabct12vp3de45728 |
      | fhmabcun12kbbvhdeug3 | fhm1a2bcsl13ide4cqp2 |
      +----------------------+----------------------+
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
        --host-id <идентификатор_выделенного_хоста> \
        --zone <зона_доступности> \
        --platform <ID_платформы> \
        --network-interface subnet-name=<имя_подсети> \
        --attach-local-disk size=<размер_диска>
      ```

      Где:

      * `--host-id` — идентификатор выделенного хоста.
      * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой размещена группа выделенных хостов.
      * {% include [dedicated-cli-platform](../../../_includes/compute/dedicated-cli-platform.md) %}
      * `--network-interface` — описание сетевого интерфейса ВМ:

        * `subnet-name` — имя подсети в зоне доступности.
      
      * {% include [dedicated-cli-attach-local-disk](../../../_includes/compute/dedicated-cli-attach-local-disk.md) %}

      Чтобы указать остальные характеристики ВМ, используйте параметры команды `yc compute instance create`, описанные в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/instance/create.md). Подробнее см. в разделах [{#T}](../../concepts/vm.md) и [{#T}](../index.md#vm-create).

      Результат:

      ```bash
      done (41s)
      id: fhm1abc23407de854r9e
      folder_id: m4n56op78mev0cljderg
      created_at: "2020-10-13T08:00:55Z"
      zone_id: {{ region-id }}-a
      ...
      placement_policy:
        host_affinity_rules:
        - key: yc.hostId
          op: IN
          values:
          - fhm1ab2mhnf3cd1610f5
      ```

- API

  1. Узнайте идентификатор группы выделенных хостов с помощью метода [list](../../api-ref/HostGroup/list.md) для ресурса `HostGroup`.
  1. Узнайте идентификаторы выделенных хостов в группе с помощью метода [listHosts](../../api-ref/HostGroup/listHosts.md) для ресурса `HostGroup`.
  1. Создайте ВМ с помощью метода [create](../../api-ref/Instance/create.md) для ресурса `Instance`.

{% endlist %}

{% include [dedicated-mount-local-disk](../../../_includes/compute/dedicated-mount-local-disk.md) %}


## Пример создания ВМ с локальным диском на выделенном хосте {#host-vm-nvme}

Перед созданием ВМ:

1. [Создайте группу выделенных хостов](create-host-group.md) и узнайте ее идентификатор с помощью [команды CLI](../../../cli/cli-ref/managed-services/compute/host-group/list.md) `yc compute host-group list`.
1. Получите список идентификаторов выделенных хостов в группе с помощью [команды CLI](../../../cli/cli-ref/managed-services/compute/host-group/list-hosts.md) `yc compute host-group list-hosts`.
1. [Создайте пару ключей](../vm-connect/ssh.md#creating-ssh-keys) для подключения к ВМ по SSH.

Создайте ВМ со следующими характеристиками:
* Размещение: выделенный хост.
* Платформа: Intel Ice Lake.
* Количество vCPU: 64.
* Объем RAM: 704 ГБ.
* Количество локальных дисков: 1.
* Размер локального диска: 3200 × 10^9^ Б (~ 2,91 ТБ).
* Операционная система: [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts).

Для этого выполните следующие действия:

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Выполните команду для создания ВМ:

  ```bash
  yc compute instance create \
    --cloud-id <идентификатор_облака> \
    --folder-id <идентификатор_каталога> \
    --zone <зона_доступности> \
    --name <имя_ВМ> \
    --platform standard-v3 \
    --cores 64 \
    --memory 704 \
    --host-id <идентификатор_выделенного_хоста> \
    --network-interface subnet-id=<идентификатор_подсети> \
    --attach-local-disk "size=3200000000000" \
    --ssh-key <путь_к_файлу_открытого_ключа_SSH> \
    --create-boot-disk name=boot-disk,size=1000,image-folder-id=standard-images,image-family=ubuntu-2204-lts
  ```

  Где:

 * `--cloud-id` — [идентификатор облака](../../../resource-manager/operations/cloud/get-id.md).
 * `--folder-id` — идентификатор каталога.
 * `--zone` — зона доступности, в которой размещена группа выделенных хостов.
 * `--name` — имя ВМ.
 * `--platform` — платформа ВМ.
 * `--cores` — количество vCPU.
 * `--memory` — объем RAM.
 * `--host-id` — идентификатор выделенного хоста.
 * `--network-interface` — описание сетевого интерфейса ВМ:

  * `subnet-id` — идентификатор подсети в зоне доступности, в которой размещается ВМ.

 * `--attach-local-disk` — описание подключаемого локального диска:

  * `size` — размер диска.

 * `--ssh-key` — путь до публичного SSH-ключа. Для этого ключа на виртуальной машине будет автоматически создан пользователь `yc-user`.
 * `--create-boot-disk` — параметры загрузочного диска.

  Результат:

  ```bash
  done (20s)
  id: fhmbdt1jj2k3mri767ll
  folder_id: m4n56op78mev0cljderg
  created_at: "2023-01-27T12:06:52Z"
  zone_id: {{ region-id }}-a
  ...
  placement_policy:
    host_affinity_rules:
    - key: yc.hostId
      op: IN
      values:
      - fhm1ceqtmivgr0d76fvb
  ```

{% endlist %}

{% include [intel-trademark](../../../_includes/intel-trademark.md) %}