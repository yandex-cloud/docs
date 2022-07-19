# Запуск Docker-образа на виртуальной машине


В данном примере описаны шаги, необходимые для запуска Docker-образа на виртуальной машине с использованием реестра.

1. Создайте сервисный аккаунт и назначьте ему роль `container-registry.images.puller` на реестр из [примера](../quickstart/index.md):

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать сервисный аккаунт.
     1. Выберите вкладку **Сервисные аккаунты**.
     1. Нажмите кнопку **Создать сервисный аккаунт**.
     1. Введите имя сервисного аккаунта и нажмите кнопку **Создать**.
     1. В списке сервисов выберите **{{ container-registry-name }}**.
     1. Справа от имени нужного реестра нажмите значок ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) и выберите **Настроить ACL**.
     1. В открывшемся окне выберите сервисный аккаунт и нажмите кнопку **Добавить**.
     1. В выпадающем списке **Разрешения** отметьте роль `container-registry.images.puller`.
     1. Нажмите кнопку **Сохранить**.

   - CLI

     1. Создайте сервисный аккаунт:

        {% include [cli-install](../../_includes/cli-install.md) %}

        {% include [default-catalogue](../../_includes/default-catalogue.md) %}

        ```bash
        yc iam service-account create --name service-acc
        ```

        Результат:

        ```bash
        id: ajelabcde12f33nol1v5
        folder_id: b0g12ga82bcv0cdeferg
        created_at: "2020-11-30T14:32:18.900092Z"
        name: service-acc
        ```

     1. Назначьте роль сервисному аккаунту:

        ```bash
        yc <имя сервиса> <ресурс> add-access-binding <имя ресурса>|<id ресурса> \
          --role <id роли> \
          --subject serviceAccount:<id сервисного аккаунта>
        ```

        Где:

        * `<имя сервиса>` — имя сервиса `container`.
        * `<ресурс>` — категория ресурса `registry`.
        * `<имя ресурса>` — имя ресурса, на который назначается роль. Вы можете указать ресурс по имени или идентификатору.
        * `<id ресурса>` — идентификатор реестра `crpc9qeoft236r8tfalm`, на который назначается роль.
        * `<id роли>` — идентификатор роли `container-registry.images.puller`.
        * `<id сервисного аккаунта>` — идентификатор сервисного аккаунта `ajelabcde12f33nol1v5`, которому назначается роль.

   - API

     Воспользуйтесь методом `updateAccessBindings` для ресурса `registry`.

   {% endlist %}

1. Создайте ВМ с публичным IP-адресом и привяжите к ней созданный сервисный аккаунт:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана ВМ.
     1. В списке сервисов выберите **{{ compute-name }}**.
     1. Нажмите кнопку **Создать ВМ**.
     1. В блоке **Базовые параметры**:
        * Введите имя и описание ВМ. Требования к имени:

          {% include [name-format](../../_includes/name-format.md) %}

          {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

        * Выберите созданный на предыдущем шаге [сервисный аккаунт](../../iam/concepts/users/service-accounts.md).
        * Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
     1. В блоке **Образы из {{ marketplace-name }}** выберите один из [образов](../../compute/operations/images-with-pre-installed-software/get-list.md) и версию операционной системы на базе Linux.
     1. (опционально) В блоке **Диски** настройте загрузочный диск:
        * Укажите нужный размер диска.
        * Выберите [тип диска](../../compute/concepts/disk.md#disks_types).

          Если вы хотите создать ВМ из существующего диска, в блоке **Диски** [добавьте диск](../../compute/operations/vm-create/create-from-disks.md).
     1. В блоке **Вычислительные ресурсы**:
        * Выберите [платформу](../../compute/concepts/vm-platforms.md).
        * Укажите [гарантированную долю](../../compute/concepts/performance-levels.md) и необходимое количество vCPU, а также объем RAM.
        * При необходимости сделайте ВМ [прерываемой](../../compute/concepts/preemptible-vm.md).
     1. В блоке **Сетевые настройки**:
        * Укажите идентификатор подсети или выберите [облачную сеть](../../vpc/concepts/network.md#network) из списка. Если сети нет, нажмите кнопку **Создать новую сеть** и создайте ее:
          * В открывшемся окне укажите имя новой сети и выберите, к какой подсети необходимо подключить ВМ. У каждой сети должна быть как минимум одна [подсеть](../../vpc/concepts/network.md#subnet) (если подсети нет, создайте ее). Затем нажмите кнопку **Создать**.
        * В поле **Публичный адрес** выберите способ назначения адреса:
          * **Автоматически** — чтобы назначить случайный IP-адрес из пула адресов {{ yandex-cloud }}.
          * **Список** — чтобы выбрать публичный IP-адрес из списка зарезервированных заранее статических адресов. Подробнее читайте в разделе [{#T}](../../vpc/operations/set-static-ip.md).
          * **Без адреса** — чтобы не назначать публичный IP-адрес.

        * (опционально) Выберите опцию [защиты от DDoS-атак](../../vpc/ddos-protection/).

     1. В блоке **Доступ** укажите данные для доступа на ВМ:
        * В поле **Логин** введите имя пользователя.

          {% note alert %}

          Не используйте логин `root` или другие имена, зарезервированные операционной системой. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

          {% endnote %}

         * В поле **SSH-ключ** вставьте содержимое файла [открытого ключа](../../compute/operations/vm-connect/ssh#creating-ssh-keys).
     1. Нажмите кнопку **Создать ВМ**.

   - CLI

     1. Посмотрите описание команды CLI для создания ВМ:

        ```bash
        yc compute instance create --help
        ```

     1. Подготовьте пару ключей (открытый и закрытый) для SSH-доступа на ВМ.
     1. Выберите в {{ marketplace-name }} один из публичных [образов](../../compute/operations/images-with-pre-installed-software/get-list.md) на базе операционной системы Linux (например, [CentOS 7](/marketplace/products/yc/centos-7)).

        {% include [standard-images](../../_includes/standard-images.md) %}

     1. Выберите подсеть:

        ```bash
        yc vpc subnet list
        ```

        Результат:

        ```bash
        +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
        |          ID          |           NAME            |      NETWORK ID      | ROUTE TABLE ID |       ZONE        |      RANGE      |
        +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
        | b0c6n43f9lgh3695v2k2 | default-{{ region-id }}-c | enpe3m3fa00udao8g5lg |                | {{ region-id }}-c | [10.130.0.0/24] |
        | e2l2da8a20b33g7o73bv | default-{{ region-id }}-b | enpe3m3fa00udao8g5lg |                | {{ region-id }}-b | [10.129.0.0/24] |
        | e9bnlm18l70ao30pvfaa | default-{{ region-id }}-a | enpe3m3fa00udao8g5lg |                | {{ region-id }}-a | [10.128.0.0/24] |
        +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
        ```

     1.  Создайте ВМ в каталоге по умолчанию:

         ```bash
         yc compute instance create \
           --name first-instance \
           --zone {{ region-id }}-a \
           --network-interface subnet-name=default-{{ region-id }}-a,nat-ip-version=ipv4 \
           --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
           --ssh-key ~/.ssh/id_rsa.pub
           --service-account-name service-acc
         ```

         Где:

         * `name` — имя ВМ.

           {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

         * `zone` — зона доступности, которая соответствует выбранной подсети.
         * `subnet-name` — имя выбранной подсети.
         * `image-family` — [семейство образов](../../compute/concepts/image.md#family), например `centos-7`. Эта опция позволит установить последнюю версию операционной системы из указанного семейства.
         * Публичный IP. Чтобы создать ВМ без публичного IP, исключите опцию `nat-ip-version=ipv4`.
         * `ssh-key` — путь до публичного SSH-ключа. Для этого ключа на ВМ будет автоматически создан пользователь `yc-user`.
         * `service-account-name` — имя созданного на предыдущем шаге сервисного аккаунта.

         Будет создана ВМ `first-instance`.

   - API

     Создайте ВМ с помощью метода [Create](../../compute/api-ref/Instance/create.md) для ресурса `Instance`:
     1. Подготовьте пару ключей (открытый и закрытый) для SSH-доступа на ВМ.
     1. Получите [IAM-токен](../../iam/concepts/authorization/iam-token.md), используемый для аутентификации в примерах:
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
        export FOLDER_ID=b1gvmob95yysaplct532
        curl -H "Authorization: Bearer ${IAM_TOKEN}" \
          "https://vpc.{{ api-host }}/vpc/v1/subnets?folderId=${FOLDER_ID}"
        {
          "subnets": [
          {
            "v4CidrBlocks": [
              "10.130.0.0/24"
            ],
            "id": "b0c6n43ftldh30l0vfg2",
            "folderId": "b1gvmob95yysaplct532",
            "createdAt": "2018-09-23T12:15:00Z",
            "name": "default-{{ region-id }}-a",
            "description": "Auto-created default subnet for zone {{ region-id }}-a",
            "networkId": "enpe3m3fagludao8aslg",
            "zoneId": "{{ region-id }}-a"
          },
          ...
          ]}
        ```

     1. Создайте файл с телом запроса на создание ВМ, например `body.json`:

        ```json
        {
          "folderId": "b1gvmob95yysaplct532",
          "name": "instance-demo-no-pwauth",
          "zoneId": "{{ region-id }}-a",
          "platformId": "standard-v3",
          "resourcesSpec": {
            "memory": "2147483648",
            "cores": "2"
          },
          "metadata": {
            "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ssh-rsa AAAAB3N... user@example.com"
          },
          "bootDiskSpec": {
            "diskSpec": {
              "size": "2621440000",
              "imageId": "fd8rc75pn12fe3u2dnmb"
            }
          },
          "networkInterfaceSpecs": [
            {
              "subnetId": "b0c6n43ftldh30l0vfg2",
              "primaryV4AddressSpec": {
                "oneToOneNatSpec": {
                  "ipVersion": "IPV4"
                }
              }
            }
          ],
          "serviceAccountId": "ajelabcde12f33nol1v5"
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
        * `networkInterfaceSpecs` — настройки сети.
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

1. Добавьте переменные для удобства работы:
   * Публичный IP-адрес вашей ВМ в переменную `${PUBLIC_IP}`:

     ```bash
     export PUBLIC_IP=<имя_пользователя>@<публичный_IP-адрес_ВМ>
     ```

   * ID реестра из [примера](../quickstart/index.md) в переменную `${REGISTRY_ID}`:

     ```bash
     export REGISTRY_ID=crpc9qeoft236r8tfalm
     ```

1. Аутентифицируйтесь в реестре от своего имени:

   {% list tabs %}

   - С помощью OAuth-токена

     1. Если у вас еще нет OAuth-токена, получите его по [ссылке]({{ link-cloud-oauth }}).
     1. Выполните команду:

        ```bash
        echo <oauth-токен> | docker login --username oauth --password-stdin {{ registry }}
        ```

        Результат:

        ```bash
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

        ```bash
        Login Succeeded
        ```

   - С помощью Docker Credential helper

     1. Если у вас еще нет профиля для YC CLI, [создайте его](../../cli/quickstart.md#initialize).
     1. Сконфигурируйте Docker для использования `docker-credential-yc`:

        ```bash
        yc container registry configure-docker
        ```

        Результат:

        ```bash
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

1. Создайте файл Dockerfile и добавьте туда следующие строки:

   ```bash
   FROM ubuntu:latest
   CMD echo "Hi, I'm inside"
   ```

1. Соберите Docker-образ:

   ```bash
   docker build . -t {{ registry }}/${REGISTRY_ID}/ubuntu:hello
   ```

1. Загрузите собранный Docker-образ в {{ container-registry-name }}:

   ```bash
   docker push {{ registry }}/${REGISTRY_ID}/ubuntu:hello
   ```

   Результат:

   ```bash
   The push refers to repository [{{ registry }}/crpc9qeoft236r8tfalm/ubuntu]
   cc9d18e90faa: Pushed
   0c2689e3f920: Pushed
   47dde53750b4: Pushed
   hello: digest: sha256:42068479274f1d4c7ea095482430dcba24dcfe8c23ebdf6d32305928e55071cf size: 943
   ```

1. [Зайдите по SSH на ВМ](../../compute/operations/vm-connect/ssh.md#vm-connect) и пройдите аутентификацию от имени сервисного аккаунта, привязанного к этой машине:

   ```bash
   ssh ${PUBLIC_IP} \
   curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token | cut -f1 -d',' | cut -f2 -d':' | tr -d '"' | sudo docker login --username iam --password-stdin {{ registry }}
   ```

   Результат:

   ```bash
   Login Succeeded
   ```

1. Скачайте Docker-образ на ВМ:

   ```bash
   ssh ${PUBLIC_IP} docker pull {{ registry }}/${REGISTRY_ID}/ubuntu:hello
   ```

   Результат:

   ```bash
   hello: Pulling from crpc9qeoft236r8tfalm/ubuntu
   6a5697faee43: Pulling fs layer
   ba13d3bc422b: Pulling fs layer
   ...
   Digest: sha256:42068479274f1d4c7ea095482430dcba24dcfe8c23ebdf6d32305928e55071cf
   Status: Downloaded newer image for {{ registry }}/crpc9qeoft236r8tfalm/ubuntu:hello
   {{ registry }}/crpc9qeoft236r8tfalm/ubuntu:hello
   ```

1. Запустите Docker-образ на ВМ:

   ```bash
   ssh ${PUBLIC_IP} docker run {{ registry }}/${REGISTRY_ID}/ubuntu:hello
   ```

   Результат:

   ```bash
   Hi, I'm inside
   ```