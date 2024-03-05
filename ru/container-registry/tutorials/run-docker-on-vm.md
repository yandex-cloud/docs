# Запуск Docker-образа на виртуальной машине

В этом руководстве описаны шаги, необходимые для запуска [Docker-образа](../../container-registry/concepts/docker-image.md) на [ВМ](../../compute/concepts/vm.md) с использованием реестра [{{ cos-full-name }}](../../cos/).

Для запуска Docker-образа на ВМ с использованием реестра:
1. [Подготовьте облако к работе](#before-begin).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте ВМ](#create-vm).
1. [Соберите и загрузите Docker-образ в {{ container-registry-name }}](#create-image).
1. [Загрузите Docker-образ на ВМ](#run).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

Также инфраструктуру для запуска Docker-образа на ВМ можно развернуть через {{ TF }} с помощью [готового файла конфигурации](#terraform).

## Перед началом работы {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:
* Плата за постоянно запущенную ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование динамического или статического [внешнего IP-адреса](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Плата за хранение Docker-образа в реестре и исходящий трафик (см. [тарифы {{ cos-full-name }}](../../cos/pricing.md)).


### Настройте окружение {#prepare}

1. [Установите](../../cli/operations/install-cli.md) интерфейс командной строки {{ yandex-cloud }}.
1. [Подготовьте](../../compute/operations/vm-connect/ssh.md) [SSH-ключ](../../glossary/ssh-keygen.md) для доступа к ВМ.
1. [Создайте](../../container-registry/operations/registry/registry-create.md) реестр в {{ cos-name }}, в котором будет хранится Docker-образ.
1. [Установите](https://www.docker.com) Docker.

## Создайте сервисный аккаунт {#create-sa}

1. Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) и назначьте ему [роль](../../iam/concepts/access-control/roles.md) `container-registry.images.puller` на реестр, созданный ранее:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать сервисный аккаунт.
     1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
     1. Введите имя сервисного аккаунта и нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
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

   - {{ TF }} {#tf}

     См. раздел [{#T}](#terraform).

   - API {#api}

     Воспользуйтесь методом `updateAccessBindings` для ресурса `registry`.

   {% endlist %}

## Создайте виртуальную машину {#create-vm}

1. Создайте ВМ с публичным IP-адресом и привяжите к ней созданный сервисный аккаунт:

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
          * В открывшемся окне укажите имя новой сети и выберите, к какой подсети необходимо подключить ВМ. У каждой сети должна быть как минимум одна [подсеть](../../vpc/concepts/network.md#subnet) (если подсети нет, создайте ее). Затем нажмите кнопку **{{ ui-key.yacloud.component.vpc.create-network-dialog.button_create }}**.
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
        | b0c6n43f9lgh******** | default-{{ region-id }}-c     | enpe3m3fa00u******** |                | {{ region-id }}-c     | [10.130.0.0/24] |
        | e2l2da8a20b3******** | default-{{ region-id }}-b     | enpe3m3fa00u******** |                | {{ region-id }}-b     | [10.129.0.0/24] |
        | e9bnlm18l70a******** | default-{{ region-id }}-a     | enpe3m3fa00u******** |                | {{ region-id }}-a     | [10.128.0.0/24] |
        +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
        ```

     1. Создайте ВМ в каталоге по умолчанию:

        ```bash
        yc compute instance create \
          --name first-instance \
          --zone {{ region-id }}-a \
          --network-interface subnet-name=default-{{ region-id }}-a,nat-ip-version=ipv4 \
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

   - {{ TF }} {#tf}

     См. раздел [{#T}](#terraform).

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
          curl -H "Authorization: Bearer ${IAM_TOKEN}" \
            "https://compute.{{ api-host }}/compute/v1/images:latestByFamily?folderId=standard-images&family=${FAMILY}"
          ```

        * Вы можете получить информацию об образе из [списка публичных образов](../../compute/operations/images-with-pre-installed-software/get-list.md).
     1. Получите идентификатор подсети и идентификатор зоны доступности. В запросе укажите идентификатор каталога, в котором создана подсеть:

        ```bash
        export IAM_TOKEN=CggaATEVAgA...
        export FOLDER_ID=b1gvmob95yys********
        curl -H "Authorization: Bearer ${IAM_TOKEN}" \
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
            "name": "default-{{ region-id }}-a",
            "description": "Auto-created default subnet for zone {{ region-id }}-a",
            "networkId": "enpe3m3faglu********",
            "zoneId": "{{ region-id }}-a"
          },
          ...
          ]}
        ```

     1. Создайте файл с телом запроса на создание ВМ, например `body.json`:

        ```json
        {
          "folderId": "b1gvmob95yys********",
          "name": "instance-demo-no-pwauth",
          "zoneId": "{{ region-id }}-a",
          "platformId": "standard-v3",
          "resourcesSpec": {
            "memory": "2147483648",
            "cores": "2"
          },
          "metadata": {
            "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ssh-ed25519 AAAAB3N... user@example.com"
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
        curl -X POST \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d '@body.json' \
          https://compute.{{ api-host }}/compute/v1/instances
        ```

   {% endlist %}

## Соберите и загрузите Docker-образ в {{ container-registry-name }} {#create-image}

1. Для удобства выполнения команд добавьте переменные:
   * Имя пользователя и публичный IP-адрес вашей ВМ — в переменную `${PUBLIC_IP}`:

     ```bash
     export PUBLIC_IP=<имя_пользователя>@<публичный_IP-адрес_ВМ>
     ```

   * Идентификатор реестра, созданного ранее, в формате `crpc9qeoft23********` — в переменную `${REGISTRY_ID}`:

     ```bash
     export REGISTRY_ID=<идентификатор_реестра>
     ```

1. Аутентифицируйтесь от своего имени:

   {% list tabs %}

   
   - С помощью OAuth-токена

     1. Если у вас еще нет OAuth-токена, получите его по [ссылке]({{ link-cloud-oauth }}).
     1. Выполните команду:

        ```bash
        echo <OAuth-токен> | docker login --username oauth --password-stdin {{ registry }}
        ```

        Результат:

        ```text
        Login Succeeded
        ```


   - С помощью IAM-токена

     {% note info %}

     {% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

     {% endnote %}

     1. [Получите](../../iam/operations/iam-token/create.md) IAM-токен.
     1. Выполните команду:

        ```bash
        yc iam create-token | docker login --username iam --password-stdin {{ registry }}
        ```

        Результат:

        ```text
        ...
        Login Succeeded
        ```

   - С помощью Docker Credential helper

     1. Если у вас еще нет профиля для YC CLI, [создайте его](../../cli/quickstart.md#initialize).
     1. Сконфигурируйте Docker для использования `docker-credential-yc`:

        ```bash
        yc container registry configure-docker
        ```

        Результат:

        ```text
        Credential helper is configured in '/home/<user>/.docker/config.json'
        ```

        Настройки сохраняются в профиле текущего пользователя.

        {% note warning %}

        Credential helper работает только при использовании Docker без `sudo`. О том, как настроить запуск Docker от имени текущего пользователя без использования `sudo` читайте в [официальной документации](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

        {% endnote %}

     1. Проверьте, что Docker сконфигурирован.

        В конфигурационном файле `/home/<user>/.docker/config.json` должна появиться строка:

        ```json
        "{{ registry }}": "yc"
        ```

     1. Docker готов к использованию, например, для [загрузки Docker-образов](../operations/docker-image/docker-image-push.md). При этом выполнять команду `docker login` не надо.

   {% endlist %}

1. Создайте файл Dockerfile:

   ```bash
   touch .dockerfile
   ```

1. Откройте Dockerfile текстовым редактором, например:

   ```bash
   nano .dockerfile
   ```

1. Добавьте туда следующие строки:

   ```text
   FROM ubuntu:latest
   CMD echo "Hi, I'm inside"
   ```

1. Соберите Docker-образ:

   ```bash
   docker build . -t {{ registry }}/${REGISTRY_ID}/ubuntu:hello -f .dockerfile
   ```

   Результат:

   ```text
   ...
   Successfully built b68ee9b6b1af
   Successfully tagged {{ registry }}/crpmnjr98tm5********/ubuntu:hello
   ```

1. Загрузите собранный Docker-образ в {{ container-registry-name }}:

   ```bash
   docker push {{ registry }}/${REGISTRY_ID}/ubuntu:hello
   ```

   Результат:

   ```text
   The push refers to repository [{{ registry }}/crpc9qeoft23********/ubuntu]
   cc9d18e90faa: Pushed
   0c2689e3f920: Pushed
   47dde53750b4: Pushed
   hello: digest: sha256:42068479274f1d4c7ea095482430dcba24dcfe8c23ebdf6d32305928******** size: 943
   ```

## Загрузите Docker-образ на ВМ {#run}

1. [Подключитесь по SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ.
1. Пройдите [аутентификацию](../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm) от имени сервисного аккаунта, привязанного к этой машине:

   ```bash
   curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token | \
   cut -f1 -d',' | \
   cut -f2 -d':' | \
   tr -d '"' | \
   sudo docker login --username iam --password-stdin {{ registry }}
   ```

   Результат:

   ```text
   Login Succeeded
   ```

1. Скачайте Docker-образ на ВМ:

   ```bash
   docker pull {{ registry }}/${REGISTRY_ID}/ubuntu:hello
   ```

   Результат:

   ```text
   hello: Pulling from crpc9qeoft23********/ubuntu
   6a5697faee43: Pulling fs layer
   ba13d3bc422b: Pulling fs layer
   ...
   Digest: sha256:42068479274f1d4c7ea095482430dcba24dcfe8c23ebdf6d32305928********
   Status: Downloaded newer image for {{ registry }}/crpc9qeoft23********/ubuntu:hello
   {{ registry }}/crpc9qeoft23********/ubuntu:hello
   ```

## Проверьте результат {#check-result}

На ВМ запустите Docker-образ:

```bash
docker run {{ registry }}/${REGISTRY_ID}/ubuntu:hello
```

Результат:

```text
Hi, I'm inside
```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* [Удалите](../../compute/operations/vm-control/vm-delete.md) ВМ.
* [Удалите](../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы его зарезервировали.
* [Удалите](../../container-registry/operations/docker-image/docker-image-delete.md) Docker-образ.
* [Удалите](../../container-registry/operations/registry/registry-delete.md) реестр.

## Как создать инфраструктуру с помощью {{ TF }} {#terraform}

{% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

Чтобы создать инфраструктуру для запуска Docker-образа на ВМ с использованием реестра:
1. [Установите](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) {{ TF }} и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файл с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовый архив {#ready}

     1. Создайте папку для файла с описанием инфраструктуры.
     1. Скачайте [архив](https://{{ s3-storage-host }}/doc-files/run-docker-on-vm-terraform.zip) (1,5 КБ).
     1. Разархивируйте архив в папку. В результате в ней должен появиться конфигурационный файл `run-docker-on-vm.tf`.

   - Вручную {#manual}

     1. Создайте папку для файла с описанием инфраструктуры.
     1. Создайте в папке конфигурационный файл `run-docker-on-vm.tf`:

        {% cut "Содержимое файла run-docker-on-vm.tf" %}
     
        {% include [run-docker-on-vm-tf-config](../../_includes/container-registry/run-docker-on-vm-tf-config.md) %}
     
        {% endcut %}

   {% endlist %}

1. В блоке `locals` задайте параметры создаваемых ресурсов:
   * `zone` — [зона доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
   * `username` — имя пользователя, который будет создан на ВМ.
   * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * `target_folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будет находиться ВМ.
   * `registry_name` — имя реестра {{ container-registry-name }}.
   * `sa_name` — имя сервисного аккаунта.
   * `network_name` — имя облачной сети.
   * `subnet_name` — имя подсети.
   * `vm_name` — имя ВМ.
   * `image_id` — идентификатор образа, из которого будет создана ВМ. Подробнее см. [{#T}](../../compute/operations/images-with-pre-installed-software/get-list.md).
1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

1. [{#T}](#create-image).
1. [{#T}](#run).
1. [{#T}](#check-result).