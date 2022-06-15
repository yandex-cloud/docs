# Добавить виртуальную машину в группу размещения

Добавьте существующую виртуальную машину в [группу размещения](../../concepts/placement-groups.md).

{% list tabs %}

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Создайте виртуальную машину:

     ```
     $ yc compute instance create --zone {{ region-id }}-b --name instance-in-group-2
     id: epdlv1pp54019j09fhue
     ...
     ```

     Данная команда создаст виртуальную машину со следующими характеристиками:

     - С именем `instance-in-group-2`.
     - В зоне доступности `{{ region-id }}-b`.

  1. Посмотрите список виртуальных машин в группе размещения:

     ```
     $ yc compute placement-group list-instances --name my-group
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     |          ID          |        NAME         |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     | epdep2kq6dt5uekuhcrd | instance-in-group-1 | {{ region-id }}-b | RUNNING |             | 10.129.0.5  |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     ```

  1. Остановите виртуальную машину:

     ```
     $ yc compute instance stop instance-in-group-2
     id: epdlv1pp54019j09fhue
     ...
     status: STOPPED
     ```

  1. Добавьте виртуальную машину в группу размещения:

     ```
     $ yc compute instance update --name instance-in-group-2 --placement-group-name my-group
     id: epdlv1pp54019j09fhue
     ...
     placement_policy:
       placement_group_id: fd83bv4rnsna2sjkiq4s
     ```

     Данная команда добавит виртуальную машину `instance-in-group-2` в группу размещения `my-group`.

  1. Проверьте, что виртуальная машина добавлена в группу размещения:

     ```
     $ yc compute placement-group list-instances --name my-group
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     |          ID          |        NAME         |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     | epdep2kq6dt5uekuhcrd | instance-in-group-1 | {{ region-id }}-b | RUNNING |             | 10.129.0.5  |
     | epdlv1pp54019j09fhue | instance-in-group-2 | {{ region-id }}-b | STOPPED |             | 10.129.0.30 |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     ```

  1. Запустите виртуальную машину:

     ```
     $ yc compute instance start instance-in-group-2
     id: epdlv1pp54019j09fhue
     ...
     status: RUNNING
     ```

- API

  Воспользуйтесь методом API [update](../../api-ref/Instance/update.md).

{% endlist %}

## Смотрите также {#see-also}

* [Как создать виртуальную машину в группе размещения](create-vm-in-pg.md).
