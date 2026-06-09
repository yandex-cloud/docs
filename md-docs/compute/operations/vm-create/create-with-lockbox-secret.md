# Создать ВМ с доступом к секрету {{ lockbox-full-name }}

Через сервис [метаданных](../../concepts/vm-metadata.md) можно передать в [виртуальную машину](../../concepts/vm.md) идентификатор [секрета {{ lockbox-full-name }}](../../../lockbox/concepts/secret.md), чтобы затем изнутри ВМ получить значение этого секрета с помощью [IAM-токена](../../../iam/concepts/authorization/iam-token.md) привязанного к ВМ [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).

Секреты {{ lockbox-name }}, как и другие пользовательские данные, передаются в ключе `user-data`. Метаданные в [каталог](../../concepts/metadata/directories.md#dir-user) `user-data` можно передавать как при [создании](../index.md#vm-create) ВМ, так и при ее [изменении](../vm-control/vm-update.md).

{% note info %}

Чтобы создавать, изменять и редактировать [ВМ](../../concepts/vm.md), необходима _минимальная_ [роль](../../security/index.md#compute-editor) `compute.editor` на [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder). Для создания ВМ с лицензируемым образом дополнительно потребуется [роль](../../../marketplace/security/index.md#license-manager-viewer) `license-manager.viewer`.

Для создания ВМ с [публичным IP-адресом](../../../vpc/concepts/address.md#public-addresses) дополнительно потребуется [роль](../../../vpc/security/index.md#vpc-public-admin) `vpc.publicAdmin`.

{% endnote %}

Чтобы передать секрет {{ lockbox-name }} на виртуальную машину через метаданные:

1. [Создайте](../../../lockbox/operations/secret-create.md) секрет {{ lockbox-name }}.
1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) ему [роль](../../../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer`.
1. Создайте файл `metadata.yaml` и поместите в него следующую конфигурацию метаданных создаваемой ВМ:

    **metadata.yaml**

    ```yaml
    #cloud-config

    datasource:
      Ec2:
        strict_id: false
      secrets:
        my_secret: <идентификатор_секрета>
    ssh_pwauth: no
    users:
      - name: <имя_пользователя>
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
        ssh-authorized-keys:
          - "<публичный_SSH-ключ_пользователя>"
    packages:
      - jq
      - yq
    ```

    Где:
    * `my_secret` — [идентификатор](../../../lockbox/operations/secret-get-info.md) созданного секрета.

        {% note warning %}

        Передавайте в каталог `user-data` только идентификаторы ваших секретов, а не их [значения](../../../lockbox/concepts/secret.md#secret).

        {% endnote %}

    * `name` — имя локального пользователя, который будет создан на ВМ. Например: `admin`.
    * `ssh-authorized-keys` — публичный SSH-ключ создаваемого пользователя ВМ.

1. Создайте виртуальную машину:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находятся секрет и сервисный аккаунт.
      1. Перейдите в сервис **{{ compute-name }}**.
      1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите образ [Ubuntu 24.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2404-lts-oslogin).
      1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** в поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** укажите идентификатор подсети в зоне доступности создаваемой ВМ или выберите [облачную сеть](../../../vpc/concepts/network.md#network) из списка.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа к ВМ:

          * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя ВМ.
          * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../../organization/concepts/membership.md).
            
            Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
            
            1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
            1. Задайте имя SSH-ключа.
            1. Выберите вариант:
            
                * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-manual }}` — вставьте содержимое открытого [SSH](../../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
                * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-upload }}` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
                * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-generate }}` — автоматическое создание пары SSH-ключей.
                
                  При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
            
            1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
            
            SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}** выберите созданный ранее сервисный аккаунт.
      1. В блоке **{{ ui-key.yacloud.common.metadata }}**:

          * В поле **{{ ui-key.yacloud.common.label_key }}** укажите `user-data`.
          * В поле **{{ ui-key.yacloud.common.value }}** вставьте содержимое созданного ранее файла конфигурации `metadata.yaml`.
      1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      Выполните команду:

      ```bash
      yc compute instance create \
        --name my-vm \
        --hostname <имя_хоста> \
        --zone <зона_доступности> \
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2404-lts-oslogin \
        --network-interface subnet-name=<имя_подсети>,ipv4-address=auto,nat-ip-version=ipv4 \
        --metadata-from-file user-data="<путь_к_файлу_конфигурации>" \
        --service-account-id <идентификатор_сервисного_аккаунта>
      ```

      Где:
      * `--name` — имя создаваемой ВМ. Например: `my-vm`.
      * `--hostname` — имя хоста создаваемой ВМ. Необязательный параметр. Если параметр не задан, в качестве имени хоста будет использовано значение идентификатора ВМ.
      * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться создаваемая ВМ.
      * `--network-interface` — настройки [сетевого интерфейса](../../concepts/network.md) создаваемой ВМ:

          * `subnet-name` — имя [подсети](../../../vpc/concepts/network.md#subnet), расположенной в зоне доступности, указанной в параметре `--zone`.
      * `--metadata-from-file` — ключ `user-data`, значением которого является путь к созданному ранее файлу с конфигурацией `cloud-config` в формате YAML. Например: `--metadata-from-file user-data="/home/user/metadata.yaml"`.
      * `service-account-id` — [идентификатор](../../../iam/operations/sa/get-id.md) созданного ранее сервисного аккаунта с назначенной [ролью](../../../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer`.

      {% cut "Результат" %}

      ```text
      done (31s)
      id: epde2t9aovjm********
      folder_id: b1gt6g8ht345********
      created_at: "2025-02-04T18:18:58Z"
      name: my-vm
      zone_id: {{ region-id }}-b
      platform_id: standard-v2
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
        device_name: epd27gmf2vu2********
        auto_delete: true
        disk_id: epd27gmf2vu2********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:e1:75:2a:c7
          subnet_id: e2lqsms4cdl3********
          primary_v4_address:
            address: 192.168.15.25
            one_to_one_nat:
              address: 51.***.***.93
              ip_version: IPV4
      serial_port_settings:
        ssh_authorization: OS_LOGIN
      gpu_settings: {}
      fqdn: my-vm.ru-central1.internal
      scheduling_policy: {}
      service_account_id: ajegtlf2q28a********
      network_settings:
        type: STANDARD
      placement_policy: {}
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V1
      ```

      {% endcut %}

    - {{ TF }} {#tf}

      Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      
      
      Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

      1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

          ```hcl
          # Создание загрузочного диска для ВМ

          resource "yandex_compute_disk" "boot-disk" {
            type     = "network-ssd"
            zone     = "<зона_доступности>"
            size     = "20"
            image_id = "fd8bpal18cm4kprpjc2m"
          }

          # Создание ВМ

          resource "yandex_compute_instance" "my-vm" {
            name               = "<имя_ВМ>"
            platform_id        = "standard-v2"
            zone               = "<зона_доступности>"
            service_account_id = "<идентификатор_сервисного_аккаунта>"

            resources {
              cores  = "2"
              memory = "4"
            }

            boot_disk {
              disk_id = yandex_compute_disk.boot-disk.id
            }

            network_interface {
              subnet_id          = "<идентификатор_подсети>"
              nat                = true
              security_group_ids = ["<идентификатор_группы_безопасности>"]
            }

            metadata = {
              user-data = "${file("<путь_к_файлу_конфигурации>")}"
            }
          }
          ```

          Где:
          * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будут находиться ВМ и диск.
          * `service_account_id` — [идентификатор](../../../iam/operations/sa/get-id.md) созданного ранее сервисного аккаунта с назначенной [ролью](../../../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer`.
          * `name` — имя создаваемой ВМ. Например: `my-vm`.
          * `subnet_id` — идентификатор [подсети](../../../vpc/concepts/network.md#subnet), расположенной в зоне доступности, указанной в параметре `zone`.
          * `security_group_ids` — идентификатор [группы безопасности](../../../vpc/concepts/security-groups.md).
          * `user-data` — путь к созданному ранее файлу конфигурации `metadata.yaml`.

          Подробнее о создаваемых ресурсах см. в [документации провайдера]({{ tf-provider-link }}).

      1. Создайте ресурсы:

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
          
             В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
          1. Примените изменения конфигурации:
          
             ```bash
             terraform apply
             ```
          
          1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

          После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

    - API {#api}

      Воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/Instance/create.md).

    {% endlist %}

1. [Подключитесь по SSH](../vm-connect/ssh.md) к созданной виртуальной машине и в терминале ВМ:

    1. Получите IAM-токен сервисного аккаунта, привязанного к виртуальной машине, и сохраните полученный токен в переменную `YC_TOKEN`. Для этого выполните запрос к [каталогу](../../concepts/metadata/directories.md#dir-compute) `computeMetadata` сервиса метаданных:

        ```bash
        export YC_TOKEN=$(curl -sf -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token | jq -r .access_token)
        ```
    1. Получите идентификатор секрета, переданный в [каталог](../../concepts/metadata/directories.md#dir-user) `user-data` сервиса метаданных при создании ВМ.

        ```bash
        export my_secret_id=$(curl -sf -H Metadata-Flavor:Google 169.254.169.254/latest/user-data | yq .datasource.secrets.my_secret | tr -d \")
        ```
    1. Получите и сохраните в переменную `my_secret_value` значение секрета, отправив запрос к API {{ lockbox-full-name }}:

        ```bash
        export my_secret_value=$(curl -sf -H "Authorization: Bearer $YC_TOKEN" "https://{{ api-host-lockbox-payload }}/lockbox/v1/secrets/${my_secret_id}/payload" | jq -r .entries[0].textValue)
        echo $my_secret_value
        ```

        Результат:

        ```bash
        admin@my-vm:~$ echo $my_secret_value
        my value
        ```

Другие примеры конфигурации для ключа `user-data` см. в разделе [Примеры](create-with-cloud-init-scripts.md#examples).

#### См. также {#see-also}

* [{#T}](../../concepts/vm-metadata.md)
* [{#T}](create-with-env-variables.md)
* [{#T}](create-with-cloud-init-scripts.md)