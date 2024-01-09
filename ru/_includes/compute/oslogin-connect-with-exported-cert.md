Подключиться к виртуальной машине с включенным доступом через OS Login можно с помощью стандартного [SSH](../../glossary/ssh-keygen.md)-клиента. Для этого нужно [экспортировать](../../compute/operations/vm-connect/os-login-export-certificate.md) сертификат OS Login на локальный компьютер и указать этот сертификат при подключении:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Получите список всех ВМ в каталоге по умолчанию:

      ```bash
      yc compute instance list
      ```

      Результат:

      ```text
      +----------------------+-----------------+---------------+---------+---------------+--------------+
      |          ID          |       NAME      |    ZONE ID    | STATUS  |  EXTERNAL IP  | INTERNAL IP  |
      +----------------------+-----------------+---------------+---------+---------------+--------------+
      | fhm0b28lgf********** | first-instance  | {{ region-id }}-a | RUNNING | 158.160.**.** | 192.168.0.8  |
      | fhm9gk85nj********** | second-instance | {{ region-id }}-a | RUNNING | 51.250.**.*** | 192.168.0.12 |
      +----------------------+-----------------+---------------+---------+---------------+--------------+
      ```

  1. Получите [публичный адрес](../../vpc/concepts/address.md#public-addresses) нужной ВМ, указав ее идентификатор:

      ```bash
      yc compute instance get \
          --id <идентификатор_ВМ>
      ```

      {% cut "Результат:" %}

      ```yaml
      id: fhm0b28lgf**********
      folder_id: b1gt6g8ht345********
      created_at: "2023-12-09T06:23:04Z"
      name: first-instance
      zone_id: {{ region-id }}-a
      platform_id: standard-v3
      resources:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      status: RUNNING
      metadata_options:
        gce_http_endpoint: ENABLED
        aws_v1_http_endpoint: ENABLED
        gce_http_token: ENABLED
        aws_v1_http_token: DISABLED
      boot_disk:
        mode: READ_WRITE
        device_name: epd9m2csd95p********
        auto_delete: true
        disk_id: epd9m2csd95p********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:87:75:**:**
          subnet_id: e2li9tcgi7ii********
          primary_v4_address:
            address: 192.168.0.8
            one_to_one_nat:
              address: 158.160.**.**
              ip_version: IPV4
      gpu_settings: {}
      fqdn: first-instance.{{ region-id }}.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      ```

      Публичный адрес виртуальной машины указан в поле `network_interfaces.primary_v4_address.one_to_one_nat.address`.

      {% endcut %}

  1. Подключитесь к ВМ:

      ```bash
      ssh -i <путь_к_файлу_сертификата> <имя_пользователя>@<публичный_IP-адрес_ВМ>
      ```

      Где:
      * `<путь_к_файлу_сертификата>` — путь к сохраненному ранее файлу `Identity` сертификата. Например: `/home/user1/.ssh/yc-cloud-id-b1gia87mbaom********-orgusername`.
      * `<имя_пользователя>` — имя пользователя в организации. Имя пользователя указано в конце имени экспортированного сертификата OS Login. В примере выше это — `orgusername`.
      * `<публичный_IP-адрес_ВМ>` — полученный ранее публичный адрес виртуальной машины.

      При первом подключении к ВМ появится предупреждение о неизвестном хосте:

      ```text
      The authenticity of host '158.160.**.** (158.160.**.**)' can't be established.
      ECDSA key fingerprint is SHA256:PoaSwqxRc8g6iOXtiH7ayGHpSN0MXwUfWHk********.
      Are you sure you want to continue connecting (yes/no)?
      ```

      Введите в терминале слово `yes` и нажмите **Enter**.

{% endlist %}