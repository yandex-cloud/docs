# Изменить подсеть

После создания подсети вы можете изменить ее имя, описание и метки.

---

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

1. Посмотрите описание команд CLI для обновления параметров подсетей:

    ```
    $ yc vpc subnet update --help
    ```

1. Получите список всех подсетей в каталоге по умолчанию:

    ```
    $ yc vpc subnet list
    +----------------------+-----------------------+----------------------+---------------+------------------+
    |          ID          |         NAME          |      NETWORK ID      |     ZONE      |      RANGE       |
    +----------------------+-----------------------+----------------------+---------------+------------------+
    | b0c08jm43eltj267sgsr | default-ru-central1-c | enplom7a98s1t0lhass8 | ru-central1-c | [10.130.0.0/24]  |
    | e2l19jf1q1hqitsl6lhc | default-ru-central1-b | enplom7a98s1t0lhass8 | ru-central1-b | [10.129.0.0/24]  |
    | e2l2prrbkbimvjuuhht2 | test-subnet-1         | enplom7a98s1t0lhass8 | ru-central1-b | [192.168.0.0/24] |
    | e9baveuu213nbhqla4cq | default-ru-central1-a | enplom7a98s1t0lhass8 | ru-central1-a | [10.128.0.0/24]  |
    +----------------------+-----------------------+----------------------+---------------+------------------+
    ```

1. Выберите `ID` или `NAME` нужной подсети.
1. Измените параметры подсети, например:

    ```
    $ yc vpc subnet update --name test-subnet-1 --new-name test-subnet-renamed --labels new_label=test_label
    id: e2l2prrbkbimvjuuhht2
    folder_id: b1g6ci08ma55klukmdjs
    created_at: "2018-10-24T13:54:10Z"
    name: test-subnet-renamed
    description: My test subnet
    labels:
      new_label: test_label
    network_id: enplom7a98s1t0lhass8
    zone_id: ru-central1-b
    v4_cidr_blocks:
    - 192.168.0.0/24
    ```
---