# Создать подсеть

[Подсети](../concepts/network.md#subnet) создаются в облачных сетях. Созданная подсеть размещается в одной из зон доступности. К подсети можно подключить ресурсы из той же зоны, где находится подсеть.

---

**[!TAB Консоль управления]**

Чтобы создать подсеть: 
1. Откройте раздел **Virtual Private Cloud** в каталоге, где требуется создать подсеть.
1. Нажмите на имя облачной сети.
1. Нажмите кнопку **Добавить подсеть**.
1. Заполните форму: укажите название подсети, выберите зону доступности из выпадающего списка.

  [!INCLUDE [name-format](../../_includes/name-format.md)]

1. Введите CIDR подсети: IP-адрес и маску подсети. Подробнее про диапазоны IP-адресов в подсетях читайте в разделе [Облачные сети и подсети](../concepts/network.md).
1. Нажмите кнопку **Создать подсеть**.

**[!TAB CLI]**

Если у вас еще нет интерфейса командной строки Яндекс.Облака, [установите его](../../cli/quickstart#install).

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

Чтобы создать подсеть:

1. Посмотрите описание команды CLI для создания подсети:

    ```
    $ yc vpc subnet create --help
    ```

1. Получите список облачных сетей в требуемом каталоге:

    ```
    $ yc vpc network list --folder-id b1g6ci08ma55klukmdjs
    +----------------------+----------------+
    |          ID          |      NAME      |
    +----------------------+----------------+
    | enpavfmgapumnl7cqin8 | test-network-1 |
    | enplom7a98s1t0lhass8 | default        |
    +----------------------+----------------+
    ```

1. Выберите NAME или ID требуемой облачной сети. Создайте подсеть в каталоге по умолчанию, указав идентификатор облачной сети с помощью флага `--network-id`:

    ```
    $ yc vpc subnet create test-subnet-1 \
      --description "My test subnet" \
      --network-id enplom7a98s1t0lhass8 \
      --zone ru-central1-b \
      --range 192.168.0.0/24
    ```

    Также можно выбрать облачную сеть, указав ее имя с помощью флага `--network-name`:

    ```
    $ yc vpc subnet create test-subnet-1 \
      --description "My test subnet" \
      --network-name test-network-1 \
      --zone ru-central1-b \
      --range 192.168.0.0/24
    ```

    [!INCLUDE [name-format](../../_includes/name-format.md)]

    Чтобы создать подсеть в другом каталоге, используйте флаг `--folder-id`:

    ```
    $ yc vpc subnet create test-subnet-1 \
      --description "My test subnet" \
      --folder-id b1g6ci08ma55klukmdjs \
      --network-id enplom7a98s1t0lhass8 \
      --zone ru-central1-b \
      --range 192.168.0.0/24
    ```

    При создании подсети указывается имя облачной сети, в которой создается подсеть, и CIDR. Флаг `--zone` указывает зону доступности, в которой создается подсеть. Если флаг не указан, подсеть будет создана в зоне доступности по умолчанию.

    Флаги `--name` и `--description` необязательные — можно создать подсеть без имени и описания и обращаться к ней по идентификатору. 

    Идентификатор и имя можно передавать не только как позиционный аргумент, но и с помощью флагов `--id` и `--name`:

    ```
    $ yc vpc network create --id enpavfmgapumnl7cqin8
    ```
    ```
    $ yc vpc network create --name test-network-1
    ```

1. Получите список всех подсетей в каталоге по умолчанию:

    ```
    $ yc vpc subnet list
    +----------------------+-----------------------+----------------------+---------------+------------------+
    |          ID          |         NAME          |      NETWORK ID      |     ZONE      |      RANGE       |
    +----------------------+-----------------------+----------------------+---------------+------------------+
    ...
    | e2l0psbfoloefpjb1rau | test-subnet-1         | enplom7a98s1t0lhass8 | ru-central1-b | [192.168.0.0/24] |
    ...
    +----------------------+-----------------------+----------------------+---------------+------------------+
    ```

    Получите тот же список c большим количеством деталей в формате YAML:

    ```
    $ yc vpc subnet list --format yaml
    
    ...
    
    - id: e2l0psbfoloefpjb1rau
      folder_id: b1g6ci08ma55klukmdjs
      created_at: "2018-10-24T12:25:58Z"
      name: test-subnet-1
      description: My test subnet
      network_id: enplom7a98s1t0lhass8
      zone_id: ru-central1-b
      v4_cidr_blocks:
      - 192.168.0.0/24
    
    ...
    ```

---