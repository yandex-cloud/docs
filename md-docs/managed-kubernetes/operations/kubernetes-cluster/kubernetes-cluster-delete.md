# Удаление кластера Kubernetes

{% note alert %}

При удалении кластера Managed Service for Kubernetes диски Compute Cloud, связанные с `PersistentVolumes`, не удаляются автоматически.

{% endnote %}

Для обращения к кластеру Kubernetes используйте его имя или уникальный идентификатор, которые можно узнать с помощью команды:

```bash
yc managed-kubernetes cluster list
```

Результат:

```bash
+----------------------+----------+---------------------+---------+---------+-------------------------+-----------------------+
|          ID          |   NAME   |     CREATED AT      | HEALTH  | STATUS  |    EXTERNAL ENDPOINT    |   INTERNAL ENDPOINT   |
+----------------------+----------+---------------------+---------+---------+-------------------------+-----------------------+
| cati493bu7ia******** | k8s-demo | 2019-11-20 11:26:36 | HEALTHY | RUNNING | https://84.201.174.147/ | https://192.168.0.27/ |
+----------------------+----------+---------------------+---------+---------+-------------------------+-----------------------+
```

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте раздел **Managed Service for&nbsp;Kubernetes** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где требуется удалить [кластер Kubernetes](../../concepts/index.md#kubernetes-cluster).
  1. Нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке кластера Kubernetes, который требуется удалить.
  1. В открывшемся меню нажмите кнопку **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. Удалите кластер Kubernetes:

     ```bash
     yc managed-kubernetes cluster delete test-k8s-cluster
     ```

     Результат:

     ```text
     done
     ```

  1. Проверьте, что кластер Kubernetes действительно удален:

     ```bash
     yc managed-kubernetes cluster list
     ```

     Результат:

     ```text
     +----+------+------------+--------+--------+-------------------+-------------------+
     | ID | NAME | CREATED AT | HEALTH | STATUS | EXTERNAL ENDPOINT | INTERNAL ENDPOINT |
     +----+------+------------+--------+--------+-------------------+-------------------+
     +----+------+------------+--------+--------+-------------------+-------------------+
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).
  
  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы удалить кластер, созданный с помощью Terraform:
  1. В командной строке перейдите в каталог, в котором расположен актуальный конфигурационный файл Terraform с планом инфраструктуры.
  1. Удалите ресурсы с помощью команды:
  
     ```bash
     terraform destroy
     ```
  
     {% note alert %}
  
     Terraform удалит все ресурсы, которые были созданы с его помощью: кластеры, сети, подсети, виртуальные машины и т. д.
  
     {% endnote %}
  
  1. Введите слово `yes` и нажмите **Enter**.

- API {#api}

  Чтобы удалить кластер Kubernetes, воспользуйтесь методом REST API [delete](../../managed-kubernetes/api-ref/Cluster/delete.md) для ресурса [Cluster](../../managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Delete](../../managed-kubernetes/api-ref/grpc/Cluster/delete.md).

{% endlist %}