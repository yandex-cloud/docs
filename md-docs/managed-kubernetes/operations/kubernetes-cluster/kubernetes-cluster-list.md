[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for Kubernetes](../../index.md) > [Пошаговые инструкции](../index.md) > Управление кластером Kubernetes > Получение информации о кластере Kubernetes

# Информация об имеющихся кластерах Managed Service for Kubernetes

Чтобы узнать `ID` или `NAME` [кластера Kubernetes](../../concepts/index.md#kubernetes-cluster), получите список кластеров Kubernetes в каталоге или подробную информацию об кластере Kubernetes.

## Получить список кластеров Kubernetes в каталоге {#list}

Получите список кластеров Kubernetes в каталоге по умолчанию.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить список кластеров Kubernetes, в [консоли управления](https://console.yandex.cloud) выберите каталог и Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.

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

  Воспользуйтесь методом REST API [list](../../managed-kubernetes/api-ref/Cluster/list.md) для ресурса [Cluster](../../managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/List](../../managed-kubernetes/api-ref/grpc/Cluster/list.md).

{% endlist %}

## Получить подробную информацию о кластере Kubernetes {#get}

Для обращения к кластеру Kubernetes используйте параметры `ID` или `NAME` из [предыдущего](kubernetes-cluster-list.md#list) пункта.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера Kubernetes.

- CLI {#cli}

  Получите подробную информацию о кластере Kubernetes:

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

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Чтобы получить информацию о кластере Managed Service for Kubernetes:

  1. Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     
     
     Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Создайте конфигурационный файл Terraform с описанием источника данных `yandex_kubernetes_cluster` в блоке `data` и запрашиваемыми параметрами в блоках `output`, по одному параметру на блок. Например:

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

      Список параметров кластера, которые можно запросить таким образом, приведен в [документации провайдера Terraform](../../../terraform/data-sources/kubernetes_cluster.md).

      {% note tip %}

      Чтобы запросить всю доступную информацию о кластере, добавьте в файл блок `output` с таким содержимым:

      ```hcl
      output "kubernetes_cluster" {
        value = data.yandex_kubernetes_cluster.my_cluster
      }
      ```

      {% endnote %}

  1. Проверьте корректность конфигурационных файлов:

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform.

      1. Выполните команду:

          ```bash
          terraform validate
          ```

          Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Выполните команду:

      ```bash
      terraform apply
      ```

      Terraform отобразит значения выходных переменных в терминале.

  1. Чтобы проверить результат, выполните следующую команду с указанием нужной переменной, например:

      ```bash
      terraform output external_v4_endpoint
      ```

      Результат:

      ```text
      "https://158.1**.***.***"
      ```

- API {#api}

  Чтобы получить подробную информацию о кластере Kubernetes, воспользуйтесь методом REST API [get](../../managed-kubernetes/api-ref/Cluster/get.md) для ресурса [Cluster](../../managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Get](../../managed-kubernetes/api-ref/grpc/Cluster/get.md).

{% endlist %}