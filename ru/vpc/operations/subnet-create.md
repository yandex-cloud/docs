# Создать подсеть

[Подсети](../concepts/network.md#subnet) создаются в облачных сетях. Созданная подсеть размещается в одной из зон доступности. К подсети можно подключить ресурсы из той же зоны, где находится подсеть.

{% list tabs %}

- Консоль управления

  Чтобы создать подсеть:
  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется создать подсеть.
  1. В списке сервисов выберите **{{ vpc-name }}**.
  1. Нажмите на имя облачной сети.
  1. Нажмите кнопку **Добавить подсеть**.
  1. Укажите название подсети.

     {% include [name-format](../../_includes/name-format.md) %}
	 
  1. (опционально) Укажите описание.
  1. Выберите зону доступности из выпадающего списка.
  1. Введите CIDR подсети: IP-адрес и маску подсети. Подробнее про диапазоны IP-адресов в подсетях читайте в разделе [Облачные сети и подсети](../concepts/network.md). 
     Если нужно указать еще один или несколько CIDR, нажмите кнопку **Добавить CIDR**.
  1. (опционально) Выберите опцию **NAT для доступа в интернет**, чтобы подсеть получила доступ в интернет без резервирования внешнего IP-адреса. 
  1. (опционально) Задайте **Настройки DHCP**. Для этого:
      1. Укажите [домен DNS](../concepts/dhcp-options.md) для поиска неквалифицированных имен.
      1. В поле **DNS-серверы** нажмите кнопку **Добавить DNS-сервер** и укажите адрес вашего DNS-сервера. Можно указать несколько DNS-серверов.
      1. В поле **NTP-серверы** нажмите кнопку **Добавить NTP-сервер** и укажите адрес вашего NTP-сервера. Можно указать несколько NTP-серверов.

        {% note info %}

        Настройки NTP не применяются к ВМ с ОС Windows. Подробнее см. в разделе [Настройки NTP на ОС Windows](../concepts/dhcp-options.md#ntp-windows).
        
        {% endnote %}
      
  1. Нажмите кнопку **Создать подсеть**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать подсеть:

  1. Посмотрите описание команды CLI для создания подсети:

      ```
      yc vpc subnet create --help
      ```

  1. Получите список облачных сетей в требуемом каталоге:

      ```
      yc vpc network list --folder-id b1g6ci08ma55klukmdjs
      +----------------------+----------------+
      |          ID          |      NAME      |
      +----------------------+----------------+
      | enpavfmgapumnl7cqin8 | test-network-1 |
      | enplom7a98s1t0lhass8 | default        |
      +----------------------+----------------+
      ```

  1. Выберите `NAME` или `ID` требуемой облачной сети. Создайте подсеть в каталоге по умолчанию, указав идентификатор облачной сети с помощью флага `--network-id`:

      ```
      yc vpc subnet create --name test-subnet-1 \
        --description "My test subnet" \
        --network-id enplom7a98s1t0lhass8 \
        --zone {{ region-id }}-a \
        --range 192.168.0.0/24
      ```

      Также можно выбрать облачную сеть, указав ее имя с помощью флага `--network-name`. При создании подсети указывается имя облачной сети, в которой создается подсеть, и CIDR. Флаг `--zone` указывает зону доступности, в которой создается подсеть. Если флаг не указан, подсеть будет создана в зоне доступности по умолчанию.

      {% include [name-format](../../_includes/name-format.md) %}

      ```
      yc vpc subnet create --name test-subnet-1 \
        --description "My test subnet" \
        --network-name test-network-1 \
        --zone {{ region-id }}-a \
        --range 192.168.0.0/24
      ```

      Флаги `--name` и `--description` необязательные — можно создать подсеть без имени и описания и обращаться к ней по идентификатору.

  1. Получите список всех подсетей в каталоге по умолчанию:

      ```
      yc vpc subnet list
      +----------------------+-----------------------+------------------------+
      |          ID          |         NAME          | ... |       RANGE      |
      +----------------------+-----------------------+------------------------+
      ...
      | e2l0psbfoloefpjb1rau | test-subnet-1         | ... | [192.168.0.0/24] |
      ...
      +----------------------+-----------------------+-----+------------------+
      ```

      Получите тот же список c большим количеством деталей в формате YAML:

      ```
      yc vpc subnet list --format yaml

      ...

      - id: e2l0psbfoloefpjb1rau
        folder_id: b1g6ci08ma55klukmdjs
        created_at: "2018-10-24T12:25:58Z"
        name: test-subnet-1
        description: My test subnet
        network_id: enplom7a98s1t0lhass8
        zone_id: {{ region-id }}-a
        v4_cidr_blocks:
        - 192.168.0.0/24

      ...
      ```

{% endlist %}

## Примеры {#examples}

{% list tabs %}
- CLI

  Создайте подсеть с именем и описанием в выбранном каталоге:

    ```
    yc vpc subnet create --name test-subnet-1 \
      --description "My test subnet" \
      --folder-id b1g6ci08ma55klukmdjs \
      --network-id enplom7a98s1t0lhass8 \
      --zone {{ region-id }}-a \
      --range 192.168.0.0/24
    ```

    Создайте подсеть с настройками DHCP:
    ```
    yc vpc subnet create --name test-subnet-1 \
      --description "My test subnet" \
      --folder-id b1g6ci08ma55klukmdjs \
      --network-id enplom7a98s1t0lhass8 \
      --zone {{ region-id }}-a \
      --range 192.168.0.0/24 \
      --domain-name test.domain \
      --domain-name-server 192.168.0.100 \
      --ntp-server 192.168.0.101
    ```
{% endlist %}
