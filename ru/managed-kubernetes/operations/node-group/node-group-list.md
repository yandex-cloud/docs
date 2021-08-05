---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Получение информации об имеющихся групп узлов

Чтобы узнать `ID` или `NAME` группы узлов, получите [список групп узлов](#list) в кластере {{ k8s }} или [подробную информацию о группе узлов](#get).

## Получить список групп узлов в кластере {{ k8s }} {#list}

Получите список [групп узлов](../../concepts/index.md#node-group) в кластере {{ k8s }}:


{% list tabs %}

- Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ managed-k8s-name }}**.
    1. Нажмите на имя нужного кластера {{ k8s }}.
    1. Перейдите во вкладку **Группы узлов**.

- CLI

    Выполните команду: 

    ```
    $ yc managed-kubernetes node-group list
    +----------------------+----------------------+----------------+----------------------+---------------------+---------+------+
    |          ID          |      CLUSTER ID      |      NAME      |  INSTANCE GROUP ID   |     CREATED AT      | STATUS  | SIZE |
    +----------------------+----------------------+----------------+----------------------+---------------------+---------+------+
    | catvhf4iv6dt8hguut9i | catcafja9ktuc7ven4le | test-nodegroup | cl1ec3le3qv3g2k441sd | 2019-04-09 10:56:22 | RUNNING |    2 |
    +----------------------+----------------------+----------------+----------------------+---------------------+---------+------+
    ```

- API
  
    Чтобы получить список групп узлов в каталоге по умолчанию, воспользуйтесь методом [list](../../api-ref/NodeGroup/list.md) для ресурса [NodeGroup](../../api-ref/NodeGroup/).
    
{% endlist %}

## Получить подробную информацию о группе узлов {#get}

Для обращения к группе узлов используйте параметры `ID` или `NAME` из [предыдущего](node-group-list.md#list) пункта.

{% list tabs %}

- Консоль управления 
       
    1. Перейдите на страницу каталога и выберите сервис **{{ managed-k8s-name }}**.
    1. Нажмите на имя нужного кластера {{ k8s }}.
    1. Перейдите во вкладку **Группы узлов**.
    1. Нажмите на имя нужной группы узлов.

- CLI

    Получите подробную информацию о группе узлов:
        
    ```
    $ yc managed-kubernetes node-group get test-nodegroup
    id: catvhf4iv6dt8hguut9i
    cluster_id: catcafja9ktuc7ven5ny
    created_at: "2019-04-09T10:56:22Z"
    name: test-nodegroup
    status: RUNNING
    node_template:
      platform_id: standard-v1
      resources_spec:
        memory: "4294967296"
        cores: "1"
        core_fraction: "100"
      boot_disk_spec:
        disk_type_id: network-hdd
        disk_size: "103079215104"
      v4_address_spec:
        one_to_one_nat_spec:
          ip_version: IPV4
    scale_policy:
      fixed_scale:
        size: "2"
    allocation_policy:
      locations:
      - zone_id: ru-central1-c
        subnet_id: b0c0jfcpqgngfu05rhcj
    instance_group_id: cl1ec3le3qv3g2k233sd
    node_version: 1.13.3
    ```

- API
  
  Чтобы получить подробную информацию о группе узлов, воспользуйтесь методом [get](../../api-ref/NodeGroup/get.md) для ресурса [NodeGroup](../../api-ref/NodeGroup/).  

{% endlist %}


