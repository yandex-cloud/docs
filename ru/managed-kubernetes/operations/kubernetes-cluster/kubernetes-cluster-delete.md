---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Удаление кластера {{ k8s }}

{% note alert %}

{% include [about-cluster-delete](../../../_includes/managed-kubernetes/note-k8s-cluster-delete.md) %}

{% endnote %}

{% include [yc-cluster-list](../../../_includes/managed-kubernetes/cluster-list.md) %}

{% list tabs %}

- Консоль управления

  1. Откройте раздел **{{ managed-k8s-name }}** в каталоге, где требуется удалить кластер {{ k8s }}.
  1. Нажмите значок ![image](../../../_assets/vertical-ellipsis.svg) в строке кластера {{ k8s }}, который требуется удалить.
  1. В открывшемся меню нажмите кнопку **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Удалите кластер {{ k8s }}:

     ```bash
     yc managed-kubernetes cluster delete test-k8s-cluster
     .....................done
     ```

  1. Проверьте, что кластер {{ k8s }} действительно удален:

     ```bash
     yc managed-kubernetes cluster list
     +----+------+------------+--------+--------+-------------------+-------------------+
     | ID | NAME | CREATED AT | HEALTH | STATUS | EXTERNAL ENDPOINT | INTERNAL ENDPOINT |
     +----+------+------------+--------+--------+-------------------+-------------------+
     +----+------+------------+--------+--------+-------------------+-------------------+
     ```

- API

  Чтобы удалить кластер {{ k8s }}, воспользуйтесь методом [delete](../../api-ref/Cluster/delete.md) для ресурса [Cluster](../../api-ref/Cluster/).

{% endlist %}