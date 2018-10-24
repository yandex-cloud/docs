# Создать подсеть

[Подсети](../concepts/network.md#subnet) создаются в облачных сетях и размещаются в зонах доступности, где к ним подключаются облачные ресурсы.

---

**[!TAB Консоль управления]**

Чтобы создать подсеть: 
1. Откройте раздел **Virtual Private Cloud** в каталоге, где требуется создать подсеть.
1. Нажмите на имя облачной сети.
1. Нажмите кнопку **Добавить подсеть**.
1. Заполните форму: укажите название подсети, выберите зону доступности из выпадающего списка.
1. Введите CIDR подсети: IP-адрес и маску подсети. Подробнее про диапазоны IP-адресов в подсетях читайте в разделе [Облачные сети и подсети](../concepts/network.md).
1. Нажмите кнопку **Создать подсеть**.

После этого в выбранной облачной сети будет создана подсеть.

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

Чтобы создать подсеть:
1. Посмотрите описание команд CLI для создания подсетей:

    ```
    $ yc vpc subnet create --help
    ```

1. Создайте подсеть в каталоге и облачной сети по умолчанию:

    ```
    $ yc vpc subnet create --name test-subnet-1 --description "My test subnet"
    --network-name default --zone ru-central1-b --range 192.168.0.0/24
    ```

    [!INCLUDE [name-format](../../_includes/name-format.md)]

    При создании подсети указывается имя облачной сети, в которой создается подсеть, и CIDR. Флаг `--zone` указывает зону доступности, в которой создается подсеть. Если зона доступности не указана, подсеть будет создана в зоне доступности по умолчанию.

    Флаги `--name` и `--description` необязательные — можно создать подсеть без имени и описания и обращаться к ней по идентификатору. 
1. Получите список всех подсетей в каталоге по умолчанию:

    ```
    $ yc vpc subnet list
    +----------------------+-----------------------+----------------------+---------------+------------------+
    |          ID          |         NAME          |      NETWORK ID      |     ZONE      |      RANGE       |
    +----------------------+-----------------------+----------------------+---------------+------------------+
    | b0c08jm43eltj267sgsr | default-ru-central1-c | enplom7a98s1t0lhass8 | ru-central1-c | [10.130.0.0/24]  |
    | e2l0psbfoloefpjb1rau | test-subnet-1         | enplom7a98s1t0lhass8 | ru-central1-b | [192.168.0.0/24] |
    | e2l19jf1q1hqitsl6lhc | default-ru-central1-b | enplom7a98s1t0lhass8 | ru-central1-b | [10.129.0.0/24]  |
    | e9baveuu213nbhqla4cq | default-ru-central1-a | enplom7a98s1t0lhass8 | ru-central1-a | [10.128.0.0/24]  |
    +----------------------+-----------------------+----------------------+---------------+------------------+
    ```

    Получите тот же список c большим количеством деталей в формате YAML:

    ```
    $ yc vpc subnet list --format yaml
    - id: b0c08jm43eltj267sgsr
      folder_id: b1g6ci08ma55klukmdjs
      created_at: "2018-09-24T08:23:07Z"
      name: default-ru-central1-c
      description: Auto-created default subnet for zone ru-central1-c
      network_id: enplom7a98s1t0lhass8
      zone_id: ru-central1-c
      v4_cidr_blocks:
      - 10.130.0.0/24
    - id: e2l0psbfoloefpjb1rau
      folder_id: b1g6ci08ma55klukmdjs
      created_at: "2018-10-24T12:25:58Z"
      name: test-subnet-1
      description: My test subnet
      network_id: enplom7a98s1t0lhass8
      zone_id: ru-central1-b
      v4_cidr_blocks:
      - 192.168.0.0/24
    - id: e2l19jf1q1hqitsl6lhc
      folder_id: b1g6ci08ma55klukmdjs
      created_at: "2018-09-24T08:23:06Z"
      name: default-ru-central1-b
      description: Auto-created default subnet for zone ru-central1-b
      network_id: enplom7a98s1t0lhass8
      zone_id: ru-central1-b
      v4_cidr_blocks:
      - 10.129.0.0/24
    - id: e9baveuu213nbhqla4cq
      folder_id: b1g6ci08ma55klukmdjs
      created_at: "2018-09-24T08:23:06Z"
      name: default-ru-central1-a
      description: Auto-created default subnet for zone ru-central1-a
      network_id: enplom7a98s1t0lhass8
      zone_id: ru-central1-a
      v4_cidr_blocks:
      - 10.128.0.0/24
    ```

---