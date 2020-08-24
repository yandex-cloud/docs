# Создание группы узлов 

Чтобы создать группу узлов, сначала [создайте кластер {{ k8s }}](../kubernetes-cluster/kubernetes-cluster-create.md).

## Создайте группу узлов {#node-group-create}

{% list tabs %}

- Консоль управления
    
    {% include [node-group-create](../../../_includes/managed-kubernetes/node-group-create.md) %}
            
- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}
        
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Создайте группу узлов:
    
    ```
    $ yc managed-kubernetes node-group create \
     --name my-node-group \
     --cluster-name test-k8s \
     --platform-id standard-v2 \
     --location subnet-name=yc-auto-subnet-0,zone=ru-central1-a \
     --public-ip \
     --cores 2 \
     --memory 4 \
     --core-fraction 50 \
     --disk-type network-ssd \
     --disk-size 96 \
     --fixed-size 2 \
     --version 1.13 \
     --daily-maintenance-window start=22:00,duration=10h
  
    done (1m17s)
    id: catpl8c44kiibp20u4f3
    cluster_id: catcsqidoos7tq0513us
    created_at: "2020-01-22T10:34:43Z"
    name: my-node-group
    status: RUNNING
    node_template:
    platform_id: standard-v2
    resources_spec:
      memory: "4294967296"
      cores: "2"
      core_fraction: "50"
    boot_disk_spec:
      disk_type_id: network-ssd
      disk_size: "103079215104"
    v4_address_spec:
      one_to_one_nat_spec:
        ip_version: IPV4
    scheduling_policy: {}
    scale_policy:
    fixed_scale:
      size: "2"
    allocation_policy:
    locations:
    - zone_id: ru-central1-a
      subnet_id: e9bifq12g0u8gnr4lv5q
    instance_group_id: cl17ebkucdsdila0idmg
    node_version: "1.14"
    version_info:
    current_version: "1.14"
    maintenance_policy:
    auto_upgrade: true
    auto_repair: true
    maintenance_window:
      daily_maintenance_window:
        start_time:
          hours: 22
        duration: 36000s
    ```
  
    Где: 
    - `--name` — имя группы узлов.
    - `--cluster-name` — имя кластера {{ k8s }}, в котором будет создана группа узлов.
    - `--platform-id` — [платформа](../../../compute/concepts/vm-platforms.md) для узлов.
    - `--public-ip` — флаг, который указывается, если группе узлов требуется публичный IP-адрес.
    - `--memory` — количество памяти для узлов. 
    - `--cores` — количество vCPU для узлов.
    - `--core-fraction` - [гарантированная доля vCPU](../../../compute/concepts/performance-levels.md) для узлов.
    - `--preemptible` — флаг, который указывается, если виртуальные машины должны быть [прерываемыми](../../../compute/concepts/preemptible-vm.md).
    - `--disk-type` — тип диска узла.
    - `--disk-size` — размер диска узла.
    - `--fixed-size` — количество узлов в группе узлов.
    - `--location` — зона доступности, сеть и подсеть, в которых будут расположены узлы. Можно указать несколько вариантов.
    - `--version` — версия {{ k8s }} для узлов.
    - `--daily-maintenance-window` — настройки окна обновлений.


- API

    Чтобы создать группу узлов, воспользуйтесь методом [create](../../api-ref/NodeGroup/create.md/) для ресурса [NodeGroup](../../api-ref/NodeGroup/).

{% endlist %}