# Создать виртуальную машину в группе размещения

Создайте виртуальную машину в [группе размещения](../../concepts/placement-groups.md).

{% list tabs %}

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания группы размещения:

     ```
     $ yc compute placement-group create --help
     ```

  1. Создайте группу размещения:

     ```
     $ yc compute placement-group create --spread-strategy --name my-group
     id: fdvte50kv3nclagfknoc
     folder_id: aoeieef3k7ppari05ajo
     created_at: "2019-12-20T08:59:44Z"
     name: my-group
     spread_placement_strategy: {}
     ```

     Данная команда создаст группу размещения со следующими характеристиками:

     - С именем `my-group`.
     - Стратегией размещения `spread`.

  1. Посмотрите описание команды CLI для создания виртуальной машины:

     ```
     $ yc compute instance create --help
     ```

  1. Создайте виртуальную машину:

     ```
     $ yc compute instance create --zone ru-central1-b --name instance-in-group-1 --placement-group-name my-group
     id: epdep2kq6dt5uekuhcrd
     ...
     placement_policy:
       placement_group_id: fd83bv4rnsna2sjkiq4s
     ```

     Данная команда создаст виртуальную машину со следующими характеристиками:

     - С именем `instance-in-group-1`.
     - В зоне доступности `ru-central1-b`.
     - В группе размещения `my-group`.

  1. Проверьте, что виртуальная машина создана и добавлена в группу размещения:

     ```
     $ yc compute placement-group list-instances --name my-group
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     |          ID          |        NAME         |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     | epdep2kq6dt5uekuhcrd | instance-in-group-1 | ru-central1-b | RUNNING |             | 10.129.0.5  |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     ```

- API

  Воспользуйтесь методом API [create](../../api-ref/Instance/create.md).

{% endlist %}

## Смотрите также {see-also}

* [Как добавить виртуальную машину в группу размещения](add-vm.md).