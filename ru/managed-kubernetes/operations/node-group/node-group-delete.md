# Удаление группы узлов

Чтобы удалить [группу узлов](../../concepts/index.md#node-group) используйте ее имя или идентификатор.

{% include [yc-node-group-list](../../../_includes/managed-kubernetes/node-group-list.md) %}

{% list tabs %}

- Консоль управления

  Чтобы удалить [группу узлов](../../concepts/index.md#node-group):
  1. Перейдите в [кластер {{ k8s }}](../../concepts/index.md#kubernetes-cluster), в котором требуется удалить группу узлов:
     1. Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** в каталоге.
     1. Откройте нужный кластер {{ k8s }}.
     1. Перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
  1. На вкладке **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}** нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) в строке группы узлов, которую требуется удалить.
  1. В открывшемся меню нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.node-groups.popup-confirm_button_delete }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Удалите группу узлов:

     ```bash
     yc k8s node-group delete <имя_группы_узлов>
     ```

     Результат:

     ```bash
     done
     ```

  1. Проверьте, что группа узлов действительно удалена:

     ```bash
     yc managed-kubernetes node-group list
     ```

     Результат:

     ```bash
     +----+------------+------+-------------------+------------+--------+------+
     | ID | CLUSTER ID | NAME | INSTANCE GROUP ID | CREATED AT | STATUS | SIZE |
     +----+------------+------+-------------------+------------+--------+------+
     +----+------------+------+-------------------+------------+--------+------+
     ```

- {{ TF }}

  Чтобы удалить [группу узлов](../../concepts/index.md#node-group):
  1. Откройте актуальный конфигурационный файл {{ TF }} с описанием группы узлов.

     О том, как создать такой файл, см. в разделе [{#T}](node-group-create.md).
  1. Удалите блок с описанием ненужной группы.
  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-nodegroup }}).

- API

  Чтобы удалить группу узлов, воспользуйтесь методом [delete](../../api-ref/NodeGroup/delete.md) для ресурса [NodeGroup](../../api-ref/NodeGroup/).

{% endlist %}