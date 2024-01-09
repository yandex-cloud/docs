# Перенести виртуальную машину в другой каталог

При создании виртуальной машины она размещается в текущем каталоге.

В {{ yandex-cloud }} есть возможность переместить виртуальную машину в другой каталог внутри одного облака. Останавливать виртуальную машину при переносе не обязательно.

[Подробнее об иерархии ресурсов в {{ yandex-cloud }}](../../../resource-manager/concepts/resources-hierarchy.md).

## Ограничения {#limits}

Ограничения при переносе виртуальной машины:

* Метрики в [{{ monitoring-full-name }}](../../../monitoring/) не переносятся. То, что было в предыдущем каталоге, останется в нем, новые метрики будут создаваться уже в новом каталоге.
* Перенос возможен только внутри одного облака.

## Перенести виртуальную машину {#relocate-vm}

### Изменить каталог ВМ {#change-folder}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Получите список всех виртуальных машин в каталоге по умолчанию:

      ```bash
      yc compute instance list
      ```

      Результат:

      ```bash
      +----------------------+-----------------+---------------+---------+----------------------+
      |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
      +----------------------+-----------------+---------------+---------+----------------------+
      | fhm0b28lgfp4******** | first-instance  | {{ region-id }}-a | RUNNING | my first vm via CLI  |
      | fhm9gk85nj7g******** | second-instance | {{ region-id }}-a | RUNNING | my second vm via CLI |
      +----------------------+-----------------+---------------+---------+----------------------+
      ```      

  1. Получите список всех каталогов в облаке по умолчанию:

      ```bash
      yc resource-manager folder list
      ```

      Результат:

      ```bash
      +----------------------+--------------------+------------------+--------+
      |          ID          |        NAME        |      LABELS      | STATUS |
      +----------------------+--------------------+------------------+--------+
      | b1gd129pp9ha******** | my-folder          |                  | ACTIVE |
      | b1g66mft1vop******** | default            |                  | ACTIVE |
      +----------------------+--------------------+------------------+--------+
      ```

  1. Посмотрите описание команды CLI для переноса виртуальной машины:

      ```bash
      yc compute instance move --help
      ```

  1. Перенесите виртуальную машину в другой каталог со следующими параметрами: 
      
      * в параметре `id` укажите идентификатор виртуальной машины, например `fhm0b28lgfp4********`;
      * в параметре `destination-folder-id` укажите идентификатор целевого каталога, например `b1gd129pp9ha********`.

      ```bash
      yc compute instance move \
        --id fhm0b28lgfp4******** \
        --destination-folder-id b1gd129pp9ha********
      ```

      Подробнее о команде `yc compute instance move` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/instance/move.md).

- API {#api}

  Воспользуйтесь методом REST API [move](../../api-ref/Instance/move.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Move](../../api-ref/grpc/instance_service.md#Move).

  **Пример**

  Ниже описан пример Bash-скрипта для ОС Linux.
  
  Чтобы воспользоваться примером, [аутентифицируйтесь](../../api-ref/authentication.md) в API и установите утилиту [cURL](https://curl.haxx.se).

  Переносить ВМ можно без ее остановки.

  1. Создайте файл для скрипта:

      ```bash
      sudo touch <имя_файла>
      ```

  1. Откройте файл для записи:

      ```bash
      sudo nano <имя_файла>
      ```
  
  1. Поместите скрипт в файл: 

      ```bash
      #!/bin/bash

      # Создание переменных

      export IAM_TOKEN=`yc iam create-token`
      
      instanceId='<идентификатор_ВМ>'
      bootDiskId='<идентификатор_загрузочного_диска_ВМ>'
      destinationFolderId='<идентификатор_каталога>'
      
      # Перемещение ВМ

      curl -X POST "https://compute.api.cloud.yandex.net/compute/v1/instances/{${instanceId}}:move" \
      -H "Authorization: Bearer ${IAM_TOKEN}" \
      -d '{ "destinationFolderId": "'"${destinationFolderId}"'" }'
      
      # Перемещение загрузочного диска

      curl -X POST "https://compute.api.cloud.yandex.net/compute/v1/disks/{${bootDiskId}}:move" \
      -H "Authorization: Bearer ${IAM_TOKEN}" \
      -d '{ "destinationFolderId": "'"${destinationFolderId}"'" }'
      ```

      Где:

      * `IAM_TOKEN` — IAM-токен для аутентификации в API.
      * `instanceId` — идентификатор ВМ, которую надо перенести.
      * `bootDiskId` — идентификатор загрузочного диска переносимой ВМ.
      * `destinationFolderId` — идентификатор каталога, в который будет перенесена ВМ.

  1. Сделайте файл исполняемым:

      ```bash
      chmod +x <имя_файла>
      ```

  1. Выполните скрипт:

      ```bash
      ./<имя_файла>
      ```

{% endlist %}

### Изменить подсеть ВМ {#change-subnet}

После переноса ВМ остается подключена к [подсети](../../../vpc/concepts/network.md#subnet) исходного каталога. Чтобы перенести ВМ в подсеть каталога назначения:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в который была перемещена ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Нажмите на имя нужной ВМ.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_action-stop }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instances.popup-confirm_button_stop }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}** нажмите значок ![image](../../../_assets/options.svg) и выберите **{{ ui-key.yacloud.compute.instance.overview.button_edit-network-interface }}**.
  1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите новую подсеть и нажмите **{{ ui-key.yacloud.common.save }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_action-start }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Остановите ВМ:

      ```bash
      yc compute instance stop fhm0b28lgfp4********
      ```

  1. Посмотрите описание команды CLI для изменения подсети:

      ```bash
      yc compute instance update-network-interface --help
      ```

  1. Выполните команду:

      ```bash
      yc compute instance update-network-interface fhm0b28lgfp4******** \
        --subnet-id e2lfibapq818******** \
        --ipv4-address auto \
        --network-interface-index 0 \
        --security-group-id enpi8m85mj14********
      ```

      Где:

      * `--subnet-id` — подсеть в каталоге назначения.
      * `--ipv4-address` — внутренний IP-адрес ВМ.
      * `--network-interface-index` — индекс сетевого интерфейса ВМ.
      * `--security-group-id` — группа безопасности, которая будет назначена ВМ.

      Результат:

      ```text
      done (9s)
      id: epdk82knf9rj********
      folder_id: b1gd73mbrli7********
      created_at: "2023-11-16T06:09:46Z"
      name: oslogigor1
      zone_id: ru-central1-b
      platform_id: standard-v3
      resources:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      status: STOPPED
      metadata_options:
        gce_http_endpoint: ENABLED
        aws_v1_http_endpoint: ENABLED
        gce_http_token: ENABLED
        aws_v1_http_token: DISABLED
      boot_disk:
        mode: READ_WRITE
        device_name: epdophaf2gh9********
        auto_delete: true
        disk_id: epdophaf2gh9********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:14:40:a9:77
          subnet_id: e2lfibapq818********
          primary_v4_address:
          address: 10.129.0.22
      gpu_settings: {}
      fqdn: relocated-vm.ru-central1.internal
      scheduling_policy: {}
      network_settings:
      type: STANDARD
      placement_policy: {}
      ```

  1. Запустите ВМ:

      ```bash
      yc compute instance start fhm0b28lgfp4********
      ```

- API {#api}

  Воспользуйтесь методом REST API [updateNetworkInterface](../../api-ref/Instance/updateNetworkInterface.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/UpdateNetworkInterface](../../api-ref/grpc/instance_service.md#UpdateNetworkInterface).

{% endlist %}