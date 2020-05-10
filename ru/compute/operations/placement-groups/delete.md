# Удалить группу размещения

Удалите [группу размещения](../../concepts/placement-groups.md).

{% list tabs %}

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите список виртуальных машин в группе размещения:
  
     ```
     $ yc compute placement-group list-instances --name my-group
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     |          ID          |        NAME         |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     | epdep2kq6dt5uekuhcrd | instance-in-group-1 | ru-central1-b | RUNNING |             | 10.129.0.5  |
     | epdlv1pp54019j09fhue | instance-in-group-2 | ru-central1-b | RUNNING |             | 10.129.0.30 |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     ```
  
  1. Удалите виртуальные машины в группе:
  
     ```
     $ yc compute instance delete --name instance-in-group-1
     $ yc compute instance delete --name instance-in-group-2
     ```     
  
  1. Удалите группу размещения:

     ```
     $ yc compute placement-group delete --name my-group
     ```
  
  1. Проверьте, что группа размещения удалена:
     
     ```
     $ yc compute placement-group list
     +----+------+----------+
     | ID | NAME | STRATEGY |
     +----+------+----------+
     +----+------+----------+
     ```
     
- API

  Воспользуйтесь методом API [delete](../../api-ref/PlacementGroup/delete.md).

{% endlist %}