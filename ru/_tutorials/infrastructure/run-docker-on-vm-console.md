1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте ВМ](#create-vm).
1. [Соберите и загрузите Docker-образ в {{ container-registry-name }}](#create-image).
1. [Загрузите Docker-образ на ВМ](#run).
1. [Проверьте результат](#check-out).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/run-docker-on-vm/paid-resources.md) %}

### Настройте окружение {#prepare}

{% include [prepare](../_tutorials_includes/run-docker-on-vm/prepare.md) %}

### Создайте сервисный аккаунт {#create-sa}

1. Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) и назначьте ему [роль](../../iam/concepts/access-control/roles.md) `container-registry.images.puller` на реестр, созданный ранее:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать сервисный аккаунт.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Введите имя сервисного аккаунта и нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
      1. Вернитесь в [консоль управления]({{ link-console-main }}) в каталог, в котором вы создали сервисный аккаунт.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
      1. Выберите реестр и нажмите на строку с его именем.
      1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
      1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
      1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.acl.update-dialog.button_select-subject }}** и добавьте сервисный аккаунт, указав его идентификатор.
      1. Нажмите **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}** и выберите роль `container-registry.images.puller`.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

    - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      1. Посмотрите описание команды CLI для создания сервисного аккаунта:

          ```bash
          yc iam service-account create --help
          ```

      1. Создайте сервисный аккаунт:

          {% include [default-catalogue](../../_includes/default-catalogue.md) %}

          ```bash
          yc iam service-account create --name <имя_сервисного_аккаунта>
          ```

          Результат:

          ```text
          id: ajelabcde12f********
          folder_id: b0g12ga82bcv********
          created_at: "2020-11-30T14:32:18.900092Z"
          name: myservice-acc
          ```

      1. Назначьте роль сервисному аккаунту:

          ```bash
          yc <имя_сервиса> <ресурс> add-access-binding <имя_или_идентификатор_ресурса> \
            --role <идентификатор_роли> \
            --subject serviceAccount:<идентификатор_сервисного_аккаунта>
          ```

          Где:
          * `<имя_сервиса>` — имя сервиса `container`.
          * `<ресурс>` — категория ресурса `registry`.
          * `<имя_или_идентификатор_ресурса>` — имя или идентификатор ресурса, на который назначается роль.
          * `--role` — идентификатор роли `container-registry.images.puller`.
          * `--subject` — идентификатор сервисного аккаунта (например: `ajelabcde12f********`), которому назначается роль.

    - API {#api}

      1. Чтобы создать сервисный аккаунт, воспользуйтесь методом [ServiceAccountService/Create](../../iam/api-ref/grpc/service_account_service.md#Create) gRPC API или методом [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса `ServiceAccount` REST API.

      1. Чтобы назначить роль сервисному аккаунту на реестр, воспользуйтесь методом REST API [updateAccessBindings](../../container-registry/api-ref/Registry/updateAccessBindings.md) для ресурса [Registry](../../container-registry/api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/UpdateAccessBindings](../../container-registry/api-ref/grpc/registry_service.md#UpdateAccessBindings).

    {% endlist %}

## Создайте виртуальную машину {#create-vm}

Создайте ВМ с публичным IP-адресом и привяжите к ней созданный сервисный аккаунт:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.landing.action_create-resource }}** и выберите **{{ ui-key.yacloud.compute.instance.label_vm }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
      * Введите имя и описание ВМ. Требования к имени:

        {% include [name-format](../../_includes/name-format.md) %}

        {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

      * Выберите созданный на предыдущем шаге [сервисный аккаунт](../../iam/concepts/users/service-accounts.md).
      * Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите один из [образов](../../compute/operations/images-with-pre-installed-software/get-list.md) и версию операционной системы на базе Linux.
  1. (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** настройте загрузочный диск:
      * Укажите нужный размер [диска](../../compute/concepts/disk.md).
      * Выберите [тип диска](../../compute/concepts/disk.md#disks_types).

        Если вы хотите создать ВМ из существующего диска, в блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** [добавьте диск](../../compute/operations/vm-create/create-from-disks.md).
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
      * Выберите [платформу](../../compute/concepts/vm-platforms.md).
      * Укажите [гарантированную долю](../../compute/concepts/performance-levels.md) и необходимое количество vCPU, а также объем RAM.
      * При необходимости сделайте ВМ [прерываемой](../../compute/concepts/preemptible-vm.md).
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      * Укажите идентификатор подсети или выберите [облачную сеть](../../vpc/concepts/network.md#network) из списка. Если сети нет, нажмите кнопку **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** и создайте ее:
        * В открывшемся окне укажите имя новой сети и выберите, к какой подсети необходимо подключить ВМ. У каждой сети должна быть как минимум одна [подсеть](../../vpc/concepts/network.md#subnet) (если подсети нет, создайте ее). Затем нажмите кнопку **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите способ назначения адреса:
        * `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` — чтобы назначить случайный IP-адрес из пула адресов {{ yandex-cloud }}.
        * `{{ ui-key.yacloud.component.compute.network-select.switch_list }}` — чтобы выбрать публичный IP-адрес из списка зарезервированных заранее статических адресов. Подробнее читайте в разделе [{#T}](../../vpc/operations/set-static-ip.md).
        * `{{ ui-key.yacloud.component.compute.network-select.switch_none }}` — чтобы не назначать публичный IP-адрес.
        * (Опционально) Выберите опцию [защиты от DDoS-атак](../../vpc/ddos-protection/).
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:
      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.

        {% note alert %}

        Не используйте логин `root` или другие имена, зарезервированные операционной системой. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

        {% endnote %}

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла [открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  1. Посмотрите описание команды CLI для создания ВМ:

      ```bash
      yc compute instance create --help
      ```

  1. Подготовьте пару ключей (открытый и закрытый) для SSH-доступа на ВМ.
  1. Выберите в {{ marketplace-name }} один из публичных [образов](../../compute/operations/images-with-pre-installed-software/get-list.md) на базе операционной системы Linux (например, [CentOS 7](/marketplace/products/yc/centos-7)).

      {% include [standard-images](../../_includes/standard-images.md) %}

  1. Посмотрите список доступных подсетей:

      ```bash
      yc vpc subnet list
      ```

      Результат:

      ```text
      +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
      |          ID          |           NAME            |      NETWORK ID      | ROUTE TABLE ID |       ZONE        |      RANGE      |
      +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
      | b0c6n43f9lgh******** | default-{{ region-id }}-d     | enpe3m3fa00u******** |                | {{ region-id }}-d     | [10.130.0.0/24] |
      | e2l2da8a20b3******** | default-{{ region-id }}-b     | enpe3m3fa00u******** |                | {{ region-id }}-b     | [10.129.0.0/24] |
      | e9bnlm18l70a******** | default-{{ region-id }}-a     | enpe3m3fa00u******** |                | {{ region-id }}-a     | [10.128.0.0/24] |
      +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
      ```

  1. Создайте ВМ в каталоге по умолчанию:

      ```bash
      yc compute instance create \
        --name first-instance \
        --zone {{ region-id }}-b \
        --network-interface subnet-name=default-{{ region-id }}-b,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
        --ssh-key ~/.ssh/id_ed25519.pub
        --service-account-name service-acc
      ```

      Где:
      * `--name` — имя ВМ.

        {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

      * `--zone` — зона доступности, которая соответствует выбранной подсети.
      * `subnet-name` — имя выбранной подсети.
      * `image-family` — [семейство образов](../../compute/concepts/image.md#family), например `centos-7`. Эта опция позволит установить последнюю версию операционной системы из указанного семейства.
      * Публичный IP. Чтобы создать ВМ без публичного IP, исключите опцию `nat-ip-version=ipv4`.
      * `--ssh-key` — путь до публичного SSH-ключа. Для этого ключа на ВМ будет автоматически создан пользователь `yc-user`.
      * `--service-account-name` — имя сервисного аккаунта, созданного на предыдущем шаге.

      В результате будет создана ВМ `first-instance`.

- API {#api}

  Создайте ВМ с помощью метода [Create](../../compute/api-ref/Instance/create.md) для ресурса `Instance`:
  1. Подготовьте пару ключей (открытый и закрытый) для SSH-доступа на ВМ.
  1. Получите [{{ iam-full-name }}-токен](../../iam/concepts/authorization/iam-token.md), используемый для аутентификации в примерах:
      * [Инструкция](../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.
      * [Инструкция](../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.

  1. [Получите идентификатор](../../resource-manager/operations/folder/get-id.md) каталога.
  1. Получите информацию об образе, из которого надо создать ВМ (идентификатор образа и минимальный размер диска):
      * Если вы знаете [семейство образа](../../compute/concepts/image.md#family), получите информации о последнем образе в этом семействе:

          ```bash
          export IAM_TOKEN=CggaATEVAgA...
          export FAMILY=ubuntu-1804
          curl --header "Authorization: Bearer ${IAM_TOKEN}" \
            "https://compute.{{ api-host }}/compute/v1/images:latestByFamily?folderId=standard-images&family=${FAMILY}"
          ```

      * Вы можете получить информацию об образе из [списка публичных образов](../../compute/operations/images-with-pre-installed-software/get-list.md).

  1. Получите идентификатор подсети и идентификатор зоны доступности. В запросе укажите идентификатор каталога, в котором создана подсеть:

      ```bash
      export IAM_TOKEN=CggaATEVAgA...
      export FOLDER_ID=b1gvmob95yys********
      curl --header "Authorization: Bearer ${IAM_TOKEN}" \
        "https://vpc.{{ api-host }}/vpc/v1/subnets?folderId=${FOLDER_ID}"
      {
        "subnets": [
          {
            "v4CidrBlocks": [
              "10.130.0.0/24"
            ],
          "id": "b0c6n43ftldh********",
          "folderId": "b1gvmob95yys********",
          "createdAt": "2018-09-23T12:15:00Z",
          "name": "default-{{ region-id }}-b",
          "description": "Auto-created default subnet for zone {{ region-id }}-b",
          "networkId": "enpe3m3faglu********",
          "zoneId": "{{ region-id }}-b"
        },
        ...
        ]}
      ```

  1. Создайте файл с телом запроса на создание ВМ, например `body.json`:

      ```json
      {
        "folderId": "b1gvmob95yys********",
        "name": "instance-demo-no-pwauth",
        "zoneId": "{{ region-id }}-b",
        "platformId": "standard-v3",
        "resourcesSpec": {
          "memory": "2147483648",
          "cores": "2"
        },
        "metadata": {
          "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ssh-ed25519 AAAAB3N... user@example.com"
        },
        "bootDiskSpec": {
          "diskSpec": {
            "size": "2621440000",
            "imageId": "fd8rc75pn12f********"
          }
        },
        "networkInterfaceSpecs": [
          {
            "subnetId": "b0c6n43ftldh********",
            "primaryV4AddressSpec": {
              "oneToOneNatSpec": {
                "ipVersion": "IPV4"
              }
            }
          }
        ],
        "serviceAccountId": "ajelabcde12f********"
      }
      ```

      Где:
      * `folderId` — идентификатор каталога.
      * `name` — имя, которое будет присвоено ВМ при создании.
      * `zoneId` — зона доступности, которая соответствует выбранной подсети.
      * `platformId` — [платформа](../../compute/concepts/vm-platforms.md).
      * `resourceSpec` — ресурсы, доступные ВМ. Значения должны соответствовать выбранной платформе.
      * `metadata` — в метаданных необходимо передать открытый ключ для SSH-доступа на ВМ. Подробнее в разделе [{#T}](../../compute/concepts/vm-metadata.md).
      * `bootDiskSpec` — настройки загрузочного диска. Укажите идентификатор выбранного образа и размер диска. Размер диска должен быть не меньше минимального размера диска, указанного в информации об образе.
      * `networkInterfaceSpecs` — настройки сети:
        * `subnetId` — идентификатор выбранной подсети.
        * `primaryV4AddressSpec` — IP-адрес, который будет присвоен ВМ. Чтобы добавить [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) ВМ, укажите:

            ```yaml
            "primaryV4AddressSpec": {
              "oneToOneNatSpec": {
                "ipVersion": "IPV4"
              }
            }
            ```

      * `serviceAccountId` — идентификатор созданного на предыдущем шаге сервисного аккаунта.

      Подробнее про формат тела запроса в [справочнике API](../../compute/api-ref/Instance/create.md).

  1. Создайте ВМ:

      ```bash
      export IAM_TOKEN=CggaATEVAgA...
      curl --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        https://compute.{{ api-host }}/compute/v1/instances
      ```

{% endlist %}

После создания ВМ, [соберите и загрузите Docker-образ в {{ container-registry-name }}](#create-image). 

## Соберите и загрузите Docker-образ в {{ container-registry-name }} {#create-image}

{% include [create-image](../_tutorials_includes/run-docker-on-vm/create-image.md) %}

## Загрузите Docker-образ на ВМ {#run}

{% include [run](../_tutorials_includes/run-docker-on-vm/run.md) %}

## Проверьте результат {#check-out}

{% include [test](../_tutorials_includes/run-docker-on-vm/test.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [Удалите](../../compute/operations/vm-control/vm-delete.md) ВМ.
* [Удалите](../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы его зарезервировали.
* [Удалите](../../container-registry/operations/docker-image/docker-image-delete.md) Docker-образ.
* [Удалите](../../container-registry/operations/registry/registry-delete.md) реестр.