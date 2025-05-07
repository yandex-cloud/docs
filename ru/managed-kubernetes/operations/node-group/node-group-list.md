# Информация об имеющихся группах узлов

Чтобы узнать `ID` или `NAME` [группы узлов](../../concepts/index.md#node-group), получите [список групп узлов](#list) в [кластере {{ k8s }}](../../concepts/index.md#kubernetes-cluster) или [подробную информацию о группе узлов](#get).

## Получить список групп узлов в кластере {{ k8s }} {#list}

Получите список [групп узлов](../../concepts/index.md#node-group) в кластере {{ k8s }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера {{ k8s }}.
  1. Перейдите во вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc managed-kubernetes node-group list
  ```

  Результат:

  ```text
  +----------------------+----------------------+----------------+----------------------+---------------------+---------+------+
  |          ID          |      CLUSTER ID      |      NAME      |  INSTANCE GROUP ID   |     CREATED AT      | STATUS  | SIZE |
  +----------------------+----------------------+----------------+----------------------+---------------------+---------+------+
  | catvhf4iv6dt******** | catcafja9ktu******** | test-nodegroup | cl1ec3le3qv3******** | 2019-04-09 10:56:22 | RUNNING |    2 |
  +----------------------+----------------------+----------------+----------------------+---------------------+---------+------+
  ```

- API {#api}

  Чтобы получить список групп узлов в каталоге по умолчанию, воспользуйтесь методом [list](../../managed-kubernetes/api-ref/NodeGroup/list.md) для ресурса [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/).

{% endlist %}

## Получить подробную информацию о группе узлов {#get}

Для обращения к группе узлов используйте параметры `ID` или `NAME` из [предыдущего](node-group-list.md#list) пункта.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера {{ k8s }}.
  1. Перейдите во вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
  1. Нажмите на имя нужной группы узлов.

  Чтобы посмотреть информацию о конкретном узле, перейдите на вкладку **{{ ui-key.yacloud.k8s.node-group.overview.label_tab-nodes }}** и нажмите на имя нужного узла. {#get-node}

- CLI {#cli}

  Получите подробную информацию о группе узлов:

  ```bash
  yc managed-kubernetes node-group get test-nodegroup
  ```

  Результат:

  ```text
  id: catvhf4iv6dt********
  cluster_id: catcafja9ktu********
  created_at: "2019-04-09T10:56:22Z"
  ...
      subnet_id: b0c0jfcpqgng********
  instance_group_id: cl1ec3le3qv3********
  node_version: 1.13.3
  ```

- API {#api}

  Чтобы получить подробную информацию о группе узлов, воспользуйтесь методом [get](../../managed-kubernetes/api-ref/NodeGroup/get.md) для ресурса [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/).

{% endlist %}
