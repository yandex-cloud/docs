# Исключить виртуальную машину из группы размещения

Исключите виртуальную машину из [группы размещения](../../concepts/placement-groups.md). 

Исключенную виртуальную машину можно [удалить насовсем](../vm-control/vm-delete.md), или [добавить обратно](add-vm.md) в группу размещения.

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
     
  1. Остановите виртуальную машину, которую необходимо исключить:
  
     ```
     $ yc compute instance stop instance-in-group-2
     id: epdlv1pp54019j09fhue
     ...
     status: STOPPED
     ```
  
  1. Исключите виртуальную машину из группы размещения. Для этого, обновите виртуальную машину, оставив имя группы размещения (`placement-group-name`) пустым:
     
     ```
     $ yc compute instance update --name instance-in-group-2 --placement-group-name=""
     ```  
  
  1. Проверьте, что виртуальная машина исключена из группы:
  
     ```
     $ yc compute placement-group list-instances --name my-group
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     |          ID          |        NAME         |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     | epdep2kq6dt5uekuhcrd | instance-in-group-1 | ru-central1-b | RUNNING |             | 10.129.0.5  |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     ```  
     
- API

  Воспользуйтесь методом API [update](../../api-ref/Instance/update.md).

{% endlist %}
