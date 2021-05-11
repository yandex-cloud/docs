# Удаление кластера

{% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

{% list tabs %}

- Консоль управления

  1. Откройте страницу каталога в консоли управления.
  1. Выберите сервис **{{ mms-name }}**.
  1. Нажмите значок ![image](../../_assets/options.svg) для нужного кластера и выберите пункт **Удалить кластер**.
  1. Подтвердите удаление кластера и нажмите кнопку **Удалить**.

- Terraform

    {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

- API

  Чтобы удалить кластер, воспользуйтесь методом API [delete](../api-ref/Cluster/delete.md): передайте значение идентификатора требуемого кластера в параметре `clusterId` запроса.

  Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}
