# Удаление кластера {{ k8s }}

{% note alert %}

При удалении кластера {{ managed-k8s-name }} диски {{ compute-name }}, связанные с `PersistentVolumes`, не удаляются автоматически.

{% endnote %}

Для обращения к кластеру {{ k8s }} используйте его имя или уникальный идентификатор, которые можно узнать с помощью команды:

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

  1. Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где требуется удалить [кластер {{ k8s }}](../../concepts/index.md#kubernetes-cluster).
  1. Нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке кластера {{ k8s }}, который требуется удалить.
  1. В открывшемся меню нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.k8s.clusters.popup-confirm_button_delete }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. Удалите кластер {{ k8s }}:

     ```bash
     yc managed-kubernetes cluster delete test-k8s-cluster
     ```

     Результат:

     ```text
     done
     ```

  1. Проверьте, что кластер {{ k8s }} действительно удален:

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

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).
  
  
  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.
  
  
  Чтобы удалить кластер, созданный с помощью {{ TF }}:
  1. В командной строке перейдите в каталог, в котором расположен актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  1. Удалите ресурсы с помощью команды:
  
     ```bash
     terraform destroy
     ```
  
     {% note alert %}
  
     {{ TF }} удалит все ресурсы, которые были созданы с его помощью: кластеры, сети, подсети, виртуальные машины и т. д.
  
     {% endnote %}
  
  1. Введите слово `yes` и нажмите **Enter**.

- API {#api}

  Чтобы удалить кластер {{ k8s }}, воспользуйтесь методом REST API [delete](../../managed-kubernetes/api-ref/Cluster/delete.md) для ресурса [Cluster](../../managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Delete](../../managed-kubernetes/api-ref/grpc/Cluster/delete.md).

{% endlist %}