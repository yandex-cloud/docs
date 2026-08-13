# Удаление группы узлов

Чтобы удалить [группу узлов](../../concepts/index.md#node-group) используйте ее имя или идентификатор.

{% include [yc-node-group-list](../../../_includes/managed-kubernetes/node-group-list.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить [группу узлов](../../concepts/index.md#node-group):
  
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите]({{ link-console-main }}/link/managed-kubernetes) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Выберите кластер {{ managed-k8s-name }}.
  1. Перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**, с ней откроется вкладка **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}**.
  1. В строке группы узлов нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Удалите группу узлов:

     ```bash
     yc k8s node-group delete <имя_группы_узлов>
     ```

     Результат:

     ```text
     done
     ```

  1. Проверьте, что группа узлов действительно удалена:

     ```bash
     yc managed-kubernetes node-group list
     ```

     Результат:

     ```text
     +----+------------+------+-------------------+------------+--------+------+
     | ID | CLUSTER ID | NAME | INSTANCE GROUP ID | CREATED AT | STATUS | SIZE |
     +----+------------+------+-------------------+------------+--------+------+
     +----+------------+------+-------------------+------------+--------+------+
     ```

- {{ TF }} {#tf}

  Чтобы удалить [группу узлов](../../concepts/index.md#node-group):
  1. Откройте актуальный конфигурационный файл {{ TF }} с описанием группы узлов.

     О том, как создать такой файл, читайте в разделе [{#T}](node-group-create.md).
  1. Удалите блок с описанием ненужной группы.
  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../../_includes/managed-kubernetes/terraform-timeout-nodes.md) %}

  Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

  Чтобы удалить группу узлов, воспользуйтесь методом REST API [delete](../../managed-kubernetes/api-ref/NodeGroup/delete.md) для ресурса [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/) или вызовом gRPC API [NodeGroupService/Delete](../../managed-kubernetes/api-ref/grpc/NodeGroup/delete.md).

{% endlist %}
