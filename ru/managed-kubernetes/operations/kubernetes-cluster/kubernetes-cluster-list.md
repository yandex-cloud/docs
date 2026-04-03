# Информация об имеющихся кластерах {{ managed-k8s-name }}

Чтобы узнать `ID` или `NAME` [кластера {{ k8s }}](../../concepts/index.md#kubernetes-cluster), получите список кластеров {{ k8s }} в каталоге или подробную информацию об кластере {{ k8s }}.

## Получить список кластеров {{ k8s }} в каталоге {#list}

Получите список кластеров {{ k8s }} в каталоге по умолчанию.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить список кластеров {{ k8s }}, в [консоли управления]({{ link-console-main }}) выберите каталог и [перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc managed-kubernetes cluster list
  ```

  Результат:

  ```text
  +----------------------+------------------+---------------------+---------+---------+-------------------------+-------------------+
  |          ID          |       NAME       |     CREATED AT      | HEALTH  | STATUS  |    EXTERNAL ENDPOINT    | INTERNAL ENDPOINT |
  +----------------------+------------------+---------------------+---------+---------+-------------------------+-------------------+
  | cata9ertn6tc******** | test-k8s-cluster | 2019-04-12 10:00:27 | HEALTHY | RUNNING | https://84.201.150.176/ | https://10.0.0.3/ |
  +----------------------+------------------+---------------------+---------+---------+-------------------------+-------------------+
    ```

- API {#api}

  Воспользуйтесь методом REST API [list](../../managed-kubernetes/api-ref/Cluster/list.md) для ресурса [Cluster](../../managed-kubernetes/api-ref/Cluster/) или вызовом gRPC API [ClusterService/List](../../managed-kubernetes/api-ref/grpc/Cluster/list.md).

{% endlist %}

## Получить подробную информацию о кластере {{ k8s }} {#get}

Для обращения к кластеру {{ k8s }} используйте параметры `ID` или `NAME` из [предыдущего](kubernetes-cluster-list.md#list) пункта.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера {{ k8s }}.

- CLI {#cli}

  Получите подробную информацию о кластере {{ k8s }}:

  ```bash
  yc managed-kubernetes cluster get test-k8s-cluster
  ```

  Результат:

  ```text
  id: cata9ertn6tc********
  folder_id: b1g88tflru0e********
  created_at: "2019-04-12T10:00:27Z"
  ...
  ip_allocation_policy:
    cluster_ipv4_cidr_block: 10.13.0.0/16
    service_ipv4_cidr_block: 10.14.0.0/16
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  Чтобы получить информацию о кластере {{ managed-k8s-name }}:

  1. {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Создайте конфигурационный файл {{ TF }} с описанием источника данных `yandex_kubernetes_cluster` в блоке `data` и запрашиваемыми параметрами в блоках `output`, по одному параметру на блок. Например:

      ```hcl
      data "yandex_kubernetes_cluster" "my_cluster" {
        cluster_id = "<идентификатор_кластера>"
      }

      output "external_v4_endpoint" {
        value = data.yandex_kubernetes_cluster.my_cluster.master.0.external_v4_endpoint
      }
      ```

      Где:

      * `external_v4_endpoint` — имя переменной, значение которой будет выводиться в результате.
      * `data.yandex_kubernetes_cluster.my_cluster.master.0.external_v4_endpoint` — запрашиваемый параметр. В этом случае — публичный IP-адрес кластера.

      Список параметров кластера, которые можно запросить таким образом, см. в [документации провайдера {{ TF }}]({{ tf-provider-datasources-link }}/kubernetes_cluster).

      {% note tip %}

      Чтобы запросить всю доступную информацию о кластере, добавьте в файл блок `output` с таким содержимым:

      ```hcl
      output "kubernetes_cluster" {
        value = data.yandex_kubernetes_cluster.my_cluster
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
      terraform output external_v4_endpoint
      ```

      Результат:

      ```text
      "https://158.1**.***.***"
      ```

- API {#api}

  Чтобы получить подробную информацию о кластере {{ k8s }}, воспользуйтесь методом REST API [get](../../managed-kubernetes/api-ref/Cluster/get.md) для ресурса [Cluster](../../managed-kubernetes/api-ref/Cluster/) или вызовом gRPC API [ClusterService/Get](../../managed-kubernetes/api-ref/grpc/Cluster/get.md).

{% endlist %}
