# Перенести виртуальную машину в другой каталог

При создании виртуальной машины она размещается в текущем каталоге.

В Yandex Cloud есть возможность переместить виртуальную машину в другой каталог внутри одного облака. Останавливать виртуальную машину при переносе не обязательно.

[Подробнее об иерархии ресурсов в Yandex Cloud](../../../resource-manager/concepts/resources-hierarchy.md).

## Ограничения {#limits}

Ограничения при переносе виртуальной машины:

* Метрики в [Yandex Monitoring](../../../monitoring/index.md) не переносятся. То, что было в предыдущем каталоге, останется в нем, новые метрики будут создаваться уже в новом каталоге.
* Перенос возможен только внутри одного облака.

## Перенести виртуальную машину {#relocate-vm}

### Изменить каталог ВМ {#change-folder}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
  
  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Получите список всех виртуальных машин в каталоге по умолчанию:

      ```bash
      yc compute instance list
      ```

      Результат:

      ```bash
      +----------------------+-----------------+---------------+---------+----------------------+
      |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
      +----------------------+-----------------+---------------+---------+----------------------+
      | fhm0b28lgfp4******** | first-instance  | ru-central1-a | RUNNING | my first vm via CLI  |
      | fhm9gk85nj7g******** | second-instance | ru-central1-a | RUNNING | my second vm via CLI |
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

      Подробнее о команде `yc compute instance move` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/move.md).

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. [Настройте](../../../resource-manager/operations/folder/set-access-bindings.md) права доступа к целевому каталогу. У аккаунта из исходного каталога, от имени которого вы будете выполнять операцию, должна быть минимальная [роль](../../security/index.md#compute-editor) `compute.editor` на целевой каталог.

  1. [Получите идентификатор целевого каталога](../../../resource-manager/operations/folder/get-id.md).
  1. В конфигурационном файле в ресурсе `yandex_compute_instance` добавьте параметры:

      ```bash
      resource "yandex_compute_instance" "vm-1" {
          ...
          allow_stopping_for_update = true
          folder_id = <идентификатор_целевого_каталога>
          ...
      }
      ```

      Где:

      * `allow_stopping_for_update` — параметр для разрешения остановки ВМ на время обновления.
      * `folder_id` — идентификатор каталога, в котором должна размещаться ВМ (по умолчанию указывается из [переменной окружения](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials)).

      Более подробную информацию о параметрах ресурса `yandex_compute_instance` читайте в [документации провайдера](../../../terraform/resources/compute_instance.md).

  1. Примените новую конфигурацию:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Terraform обновит все требуемые ресурсы. Проверить изменения можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Воспользуйтесь методом REST API [move](../../api-ref/Instance/move.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Move](../../api-ref/grpc/Instance/move.md).

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

      curl \
        --request POST \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '{ "destinationFolderId": "'"${destinationFolderId}"'" }' \
        "https://compute.api.cloud.yandex.net/compute/v1/instances/{${instanceId}}:move"
      
      # Перемещение загрузочного диска

      curl \
        --request POST \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '{ "destinationFolderId": "'"${destinationFolderId}"'" }' \
        "https://compute.api.cloud.yandex.net/compute/v1/disks/{${bootDiskId}}:move"
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

После переноса сетевые интерфейсы ВМ остаются подключены к [подсетям](../../../vpc/concepts/network.md#subnet) исходного каталога. Чтобы подключить ВМ к подсетям каталога назначения:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в который была перемещена ВМ.
  1. Перейдите в сервис **Compute Cloud**.
  1. Нажмите на имя нужной ВМ.
  1. Нажмите кнопку **Остановить**.
  1. В открывшемся окне нажмите кнопку **Остановить**.
  1. В секции **Сеть** в правом верхнем углу блока нужного сетевого интерфейса нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Изменить**.
  1. В поле **Подсеть** выберите новую подсеть и нажмите **Сохранить**.
      Если у ВМ несколько [сетевых интерфейсов](../../concepts/network.md), измените подсеть для каждого из них.
  1. Нажмите кнопку **Запустить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
  
  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения подсети:

      ```bash
      yc compute instance update-network-interface --help
      ```

  1. Остановите ВМ:

      ```bash
      yc compute instance stop fhm0b28lgfp4********
      ```

  1. Получите список сетевых интерфейсов ВМ, указав ее идентификатор:

     ```bash
     yc compute instance get fhm0b28lgfp4********
     ```

     Результат:

     ```yml
     ...
     network_interfaces:
       - index: "0"
         mac_address: d0:0d:24:**:**:**
         subnet_id: e2lpp96bvvgp********
         primary_v4_address:
           address: 192.168.2.23
       - index: "1"
         mac_address: d0:1d:24:**:**:**
         subnet_id: e2lrucutusnd********
         primary_v4_address:
           address: 192.168.1.32
       - index: "2"
         mac_address: d0:2d:24:**:**:**
         subnet_id: e2lv9c6aek1d********
         primary_v4_address:
           address: 192.168.4.26
     ...
     ```

     Сохраните значение поля `index` — номер сетевого интерфейса, который требуется подключить к другой подсети.

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
      * `--ipv4-address` — внутренний IP-адрес сетевого интерфейса ВМ в подсети в каталоге назначения. Задайте значение `auto`, чтобы внутренний адрес был присвоен автоматически.
      * `--network-interface-index` — сохраненный ранее номер сетевого интерфейса ВМ.
      * `--security-group-id` — группа безопасности, которая будет назначена сетевому интерфейсу ВМ.

      Результат:

      ```text
      done (9s)
      id: fhm0b28lgfp4********
      folder_id: b1gd73mbrli7********
      created_at: "2023-11-16T06:09:46Z"
      name: oslogigor1
      zone_id: ru-central1-a
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
          mac_address: d0:0d:24:**:**:**
          subnet_id: e2lfibapq818********
          primary_v4_address:
            address: 10.129.0.22
          security_group_ids:
            - enpi8m85mj14********
        - index: "1"
          mac_address: d0:1d:24:**:**:**
          subnet_id: e2lrucutusnd********
          primary_v4_address:
            address: 192.168.1.32
        - index: "2"
          mac_address: d0:2d:24:**:**:**
          subnet_id: e2lv9c6aek1d********
          primary_v4_address:
            address: 192.168.4.26
      gpu_settings: {}
      fqdn: relocated-vm.ru-central1.internal
      scheduling_policy: {}
      network_settings:
      type: STANDARD
      placement_policy: {}
      ```

      Если у ВМ несколько сетевых интерфейсов, измените подсеть для каждого из них.

  1. Запустите ВМ:

      ```bash
      yc compute instance start fhm0b28lgfp4********
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. [Настройте](../../../resource-manager/operations/folder/set-access-bindings.md) права доступа к каталогу, в котором вы изменяете подсеть ВМ. У аккаунта, от имени которого вы будете выполнять операцию, должна быть минимальная [роль](../../../vpc/security/index.md#vpc-admin) `vpc.admin` на этот каталог.

  1. Если дополнительная подсеть уже создана, [получите](../../../vpc/operations/subnet-get-info.md) ее идентификатор.
  1. В конфигурационном файле измените ресурс `yandex_compute_instance`:

      ```hcl
      resource "yandex_compute_instance" "vm-1" {
        ...
        network_interface {
          subnet_id = "<идентификатор_подсети>"
        }

        allow_stopping_for_update = true
        ...
      }
      ```

      Где:

      * `subnet_id` — идентификатор [подсети](../../../vpc/concepts/network.md#subnet).
      * `allow_stopping_for_update` — параметр для разрешения остановки ВМ на время обновления.

      Более подробную информацию о параметрах ресурса `yandex_compute_instance` читайте в [документации провайдера](../../../terraform/resources/compute_instance.md).

  1. Примените новую конфигурацию:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Terraform обновит все требуемые ресурсы. Проверить изменения можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Воспользуйтесь методом REST API [updateNetworkInterface](../../api-ref/Instance/updateNetworkInterface.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/UpdateNetworkInterface](../../api-ref/grpc/Instance/updateNetworkInterface.md).

{% endlist %}