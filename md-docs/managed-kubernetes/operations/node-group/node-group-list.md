# Информация об имеющихся группах узлов

Чтобы узнать `ID` или `NAME` [группы узлов](../../concepts/index.md#node-group), получите [список групп узлов](#list) в [кластере {{ k8s }}](../../concepts/index.md#kubernetes-cluster) или [подробную информацию о группе узлов](#get).

## Получить список групп узлов в кластере {{ k8s }} {#list}

Получите список [групп узлов](../../concepts/index.md#node-group) в кластере {{ k8s }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
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

  Чтобы получить список групп узлов в каталоге, воспользуйтесь методом REST API [list](../../managed-kubernetes/api-ref/NodeGroup/list.md) для ресурса [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/index.md) или вызовом gRPC API [NodeGroupService/List](../../managed-kubernetes/api-ref/grpc/NodeGroup/list.md).

{% endlist %}

## Получить подробную информацию о группе узлов {#get}

Для обращения к группе узлов используйте параметры `ID` или `NAME` из [предыдущего](node-group-list.md#list) пункта.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
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

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Чтобы получить информацию о группе узлов {{ managed-k8s-name }}:

  1. Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     
     
     Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Создайте конфигурационный файл {{ TF }} с описанием источника данных `yandex_kubernetes_node_group` в блоке `data` и запрашиваемыми параметрами в блоках `output`, по одному параметру на блок. Например:

      ```hcl
      data "yandex_kubernetes_node_group" "my_node_group" {
        node_group_id = "<идентификатор_группы_узлов>"
      }

      output "node_group_status" {
        value = data.yandex_kubernetes_node_group.my_node_group.status
      }
      ```

      Где:

      * `node_group_status` — имя переменной, значение которой будет выводиться в результате.
      * `data.yandex_kubernetes_node_group.my_node_group.status` — запрашиваемый параметр. В этом случае — состояние группы узлов.

      Список параметров группы узлов, которые можно запросить таким образом, см. в [документации провайдера {{ TF }}]({{ tf-provider-datasources-link }}/kubernetes_node_group).

      {% note tip %}

      Чтобы запросить всю доступную информацию о группе узлов, добавьте в файл блок `output` с таким содержимым:

      ```hcl
      output "node_group" {
        value = data.yandex_kubernetes_node_group.my_node_group
      }
      ```

      {% endnote %}

  1. Проверьте корректность конфигурационных файлов:

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }}.

      1. Выполните команду:

          ```bash
          terraform validate
          ```

          Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Выполните команду:

      ```bash
      terraform apply
      ```

      {{ TF }} отобразит значения выходных переменных в терминале.

  1. Чтобы проверить результат, выполните следующую команду с указанием нужной переменной, например:

      ```bash
      terraform output node_group_status
      ```

      Результат:

      ```text
      "running"
      ```

- API {#api}

  Чтобы получить подробную информацию о группе узлов, воспользуйтесь методом REST API [get](../../managed-kubernetes/api-ref/NodeGroup/get.md) для ресурса [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/index.md) или вызовом gRPC API [NodeGroupService/Get](../../managed-kubernetes/api-ref/grpc/NodeGroup/get.md).

{% endlist %}