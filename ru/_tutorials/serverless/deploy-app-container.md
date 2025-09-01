# Запуск контейнерного приложения в {{ serverless-containers-full-name }}


С помощью этого руководства вы сможете развернуть контейнер с приложением в сервисе [{{ serverless-containers-name }}](../../serverless-containers/) для администрирования СУБД {{ MG }}.

СУБД развернута на виртуальной машине [{{ compute-full-name }}](../../compute/), контейнер с приложением хранится в реестре [{{ container-registry-full-name }}](../../container-registry/), чувствительные данные зашифрованы с помощью [{{ lockbox-full-name }}](../../lockbox/), а безопасный доступ к приложению реализован через API-шлюз [{{ api-gw-full-name }}](../../api-gateway/). Вся инфраструктура контейнерного приложения располагается в одном каталоге.

Чтобы развернуть контейнерное приложение:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сервисный аккаунт](#sa-create).
1. [Создайте облачную сеть и подсеть](#create-network).
1. [Настройте группу безопасности](#configure-sg).
1. [Создайте виртуальную машину {{ compute-name }} с {{ MG }}](#create-vm).
1. [Создайте секрет {{ lockbox-name }} и версию](#secret-create).
1. [Создайте реестр {{ container-registry-name }}](#create-registry).
1. [Загрузите Docker-образ в {{ container-registry-name }}](#push-image).
1. [Создайте контейнер {{ serverless-containers-name }}](#create-container).
1. [Создайте API-шлюз {{ api-gw-name }}](#create-api-gw).
1. [Проверьте работу приложения](#check-app).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки приложения входит:

* плата за постоянно запущенную ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за хранение секретов (см. [тарифы {{ lockbox-full-name }}](../../lockbox/pricing.md));
* плата за хранение Docker-образа (см. [тарифы {{ container-registry-full-name }}](../../container-registry/pricing.md));
* плата за количество вызовов контейнера, вычислительные ресурсы, выделенные для выполнения приложения, и исходящий трафик (см. [тарифы {{ serverless-containers-name }}](../../serverless-containers/pricing.md));
* плата за запросы к API-шлюзу (см. [тарифы {{ api-gw-full-name }}](../../api-gateway/pricing.md));
* плата за запись и хранение данных в [лог-группе](../../logging/concepts/log-group.md) (см. [тарифы {{ cloud-logging-full-name }}](../../logging/pricing.md)).


## Создайте сервисный аккаунт {#sa-create}

Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) и назначьте ему [роли](../../iam/concepts/access-control/roles.md) на каталог, в котором будет размещаться инфраструктура контейнерного приложения.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{link-console-main}}) перейдите в каталог, в котором будет размещаться инфраструктура контейнерного приложения.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя сервисного аккаунта — `mongo-express`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите [роли](../../load-testing/security/index.md#roles-list) `{{ roles-cr-puller }}`, `{{ roles-lockbox-payloadviewer }}` и `{{ roles-serverless-containers-invoker }}`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Создайте сервисный аккаунт с именем `mongo-express`:

      ```bash
      yc iam service-account create --name mongo-express
      ```

      Результат:

      ```text
      id: aje3pdqm1cul********
      folder_id: b1g681qpemb4********
      created_at: "2025-06-14T10:31:06.911280565Z"
      name: mongo-express
      ```

  1.  Назначьте сервисному аккаунту роли `{{ roles-cr-puller }}`, `{{ roles-lockbox-payloadviewer }}` и `{{ roles-serverless-containers-invoker }}` на каталог, в котором будет размещаться контейнер:

      ```bash
      yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
        --role {{ roles-cr-puller }} \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>

      yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
        --role {{ roles-lockbox-payloadviewer }} \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>

      yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
        --role {{ roles-serverless-containers-invoker }} \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Где:

      * `<имя_или_идентификатор_каталога>` — имя или идентификатор каталога, в котором будет размещаться контейнер.
      * `--subject serviceAccount` — идентификатор сервисного аккаунта `mongo-express`.

      Результат:

      ```text
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: container-registry.images.puller
            subject:
              id: aje3pdqm1cul********
              type: serviceAccount

      effective_deltas:
        - action: ADD
          access_binding:
            role_id: lockbox.payloadViewer
            subject:
              id: aje3pdqm1cul********
              type: serviceAccount

      effective_deltas:
        - action: ADD
          access_binding:
            role_id: serverless-containers.containerInvoker
            subject:
              id: aje3pdqm1cul********
              type: serviceAccount
      ```

- API {#api}

  1. Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).
  1. Чтобы назначить сервисному аккаунту роли на каталог, воспользуйтесь методом REST API [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md).

{% endlist %}


## Создайте облачную сеть и подсеть {#create-network}

Создайте [облачную сеть](../../vpc/concepts/network.md) и [подсеть](../../vpc/concepts/network.md#subnet), в которых будет располагаться ВМ.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** укажите `mongo-express-network`.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. На панели слева выберите ![subnets](../../_assets/vpc/subnets.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.common.create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** укажите `mongo-express-subnet-{{ region-id }}-b`.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** выберите зону доступности `{{ region-id }}-b`.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_network }}** выберите облачную сеть `mongo-express-network`.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** укажите `192.168.1.0/24`.
  1. Нажмите **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

- CLI {#cli}

  1. Создайте облачную сеть:

      ```bash
      yc vpc network create \
        --name mongo-express-network
      ```

      Результат:

      ```text
      id: enp1b4okmg57********
      folder_id: b1g681qpemb4********
      created_at: "2025-06-13T12:57:02Z"
      name: mongo-express-network
      default_security_group_id: enphs1omp6m4********
      ```

      Сохраните идентификатор группы безопасности по умолчанию, указанный в поле `default_security_group_id`.

  1. Создайте подсеть:

      ```bash
      yc vpc subnet create \
         --name mongo-express-subnet-{{ region-id }}-b \
         --zone {{ region-id }}-b \
         --network-id <идентификатор_сети> \
         --range 192.168.1.0/24
      ```

      Где:

      * `--name` — название подсети.
      * `--zone` — зона доступности.
      * `--network-id` — идентификатор сети `mongo-express-network`.
      * `--range` — список IPv4-адресов, откуда или куда будет поступать трафик.

      Результат:

      ```text
      id: e2l9i0eaq32t********
      folder_id: b1g681qpemb4********
      created_at: "2025-06-14T09:27:37Z"
      name: mongo-express-subnet-ru-central1-b
      network_id: enp1b4okmg57********
      zone_id: ru-central1-b
      v4_cidr_blocks:
        - 192.168.1.0/24
      ```

- API {#api}

  1. Чтобы создать облачную сеть, воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) и передайте в запросе:

      * Идентификатор каталога, в котором будет размещаться сеть.
      * Имя новой сети `mongo-express-network` в параметре `name`.

  1. Чтобы создать подсеть, воспользуйтесь методом REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md).

{% endlist %}


## Настройте группу безопасности {#configure-sg}

Настройте [группу безопасности](../../vpc/concepts/security-groups.md) по умолчанию в созданной [ранее](#create-network) облачной сети.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/vpc/security-group.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**.
  1. Напротив группы безопасности, созданной по умолчанию для сети `mongo-express-network`, нажмите ![image](../../_assets/options.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** перейдите на вкладку **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}**.
  1. Нажмите **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}** и создайте правило по таблице:

      | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
      | --- | --- | --- | --- | --- | --- |
      | `Входящий` | `any` | `27017` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Добавьте правило в группу безопасности:

  ```bash
  yc vpc security-group update-rules <идентификатор_группы_безопасности> \
    --add-rule "direction=ingress,port=27017,protocol=any,v4-cidrs=[0.0.0.0/0,0.0.0.0/0]"
  ```

  Где `<идентификатор_группы_безопасности>` — значение `default_security_group_id`, полученное на предыдущем шаге.

  Результат:

  ```text
  id: enpmal7qcb1q********
  folder_id: b1g681qpemb4********
  created_at: "2025-06-14T09:24:47Z"
  name: default-sg-enpeiqghds1j********
  description: Default security group for network
  network_id: enpeiqghds1j********
  status: ACTIVE
  rules:
    ...
    - id: enprm96de4ec********
      direction: INGRESS
      ports:
        from_port: "27017"
        to_port: "27017"
      protocol_name: ANY
      protocol_number: "-1"
      cidr_blocks:
        v4_cidr_blocks:
          - 0.0.0.0/0
          - 0.0.0.0/0
  default_for_network: true
  ```

- API {#api}

  Чтобы добавить правило в группу безопасности, воспользуйтесь методом REST API [updateRules](../../vpc/api-ref/SecurityGroup/updateRules.md) для ресурса [SecurityGroup](../../vpc/api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/UpdateRules](../../vpc/api-ref/grpc/SecurityGroup/updateRules.md) и передайте в запросе:

    * Идентификатор группы безопасности, в которую будут добавлены правила, в параметре `securityGroupId`.

        {% include [get-security-group-id](../../_includes/vpc/get-security-group-id.md) %}

    * Новые правила группы безопасности в массиве `additionRuleSpecs[]`:

        * Направление трафика — `ingress`.
        * Имя протокола передачи трафика в параметре `additionRuleSpecs[].protocolName` — `any`.
        * Список CIDR и масок подсетей в параметре `additionRuleSpecs[].cidrBlocks.v4CidrBlocks[]` — `[0.0.0.0/0,0.0.0.0/0]`.
        * Первый порт из диапазона портов для трафика в параметре `additionRuleSpecs[].ports.fromPort` — `0`.
        * Последний порт из диапазона портов для трафика в параметре `additionRuleSpecs[].ports.toPort` — `65535`.

{% endlist %}


## Создайте виртуальную машину с {{ MG }} {#create-vm}

Рекомендуем использовать [ВМ](../../compute/concepts/vm.md) в минимальной конфигурации.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Выберите вариант **{{ ui-key.yacloud.compute.instances.create.option_create-form-extended-title }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      1. Перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_coi }}** и нажмите **{{ ui-key.yacloud.compute.instances.create.image_coi_label_empty-button }}**.
      1. В открывшемся окне перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.value_docker-compose-yaml }}** и укажите спецификацию Docker-контейнера:

          ```yaml
          version: '3.1'

          services:
            mongo:
              image: mongo
              restart: always
              environment:
                MONGO_INITDB_ROOT_USERNAME: mongo_db_user
                MONGO_INITDB_ROOT_PASSWORD: <пароль>
              ports:
                - 27017:27017
          ```

          В значении параметра `MONGO_INITDB_ROOT_PASSWORD` задайте пароль, который будет использоваться для доступа к БД. Для создания пароля можно воспользоваться [генератором паролей](https://passwordsgenerator.net/). Сохраните пароль, он понадобится вам на следующих шагах.

      1. Нажмите **{{ ui-key.yacloud.common.apply }}**.

  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет создана ВМ. Если вы не знаете, какая зона доступности вам нужна, оставьте выбранную по умолчанию.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите подсеть `mongo-express-subnet-{{ region-id }}-b`.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `mongo-vm`.
  1. Нажмите **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Дождитесь перехода ВМ в статус `Running` и сохраните ее публичный IP-адрес — он потребуется для подключения к БД.

- CLI {#cli}

  1. [Подготовьте](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) пару ключей (открытый и закрытый) для [SSH-доступа](../../glossary/ssh-keygen.md) на ВМ.
  1. Подготовьте файл спецификации Docker-контейнера `docker-spec.yaml`:

      ```yaml
      version: '3.1'

      services:
        mongo:
          image: mongo
          restart: always
          environment:
            MONGO_INITDB_ROOT_USERNAME: mongo_db_user
            MONGO_INITDB_ROOT_PASSWORD: <пароль>
          ports:
            - 27017:27017
      ```

      В значении параметра `MONGO_INITDB_ROOT_PASSWORD` задайте пароль, который будет использоваться для доступа к БД. Для создания пароля можно воспользоваться [генератором паролей](https://passwordsgenerator.net/). Сохраните пароль, он понадобится вам на следующих шагах.

  1. Выполните команду:

      ```bash
      yc compute instance create-with-container \
        --docker-compose-file docker-spec.yaml \
        --name mongo-vm \
        --zone {{ region-id }}-b \
        --network-interface subnet-name=mongo-express-subnet-{{ region-id }}-b,nat-ip-version=ipv4 \
        --ssh-key <путь_к_файлу_открытого_ключа> \
        --create-boot-disk size=30
      ```

      Где:

      * `--docker-compose-file` — путь к [файлу спецификации](../../cos/concepts/coi-specifications.md#coi-spec) Docker-контейнера.
      * `--name` — имя ВМ.
      * `--zone` — зона доступности.
      * `--network-interface` — сетевые настройки ВМ.
      * `--ssh-key` — путь к файлу открытого ключа SSH, например `./ssh-key.pub`. Имя пользователя по умолчанию для доступа по SSH — `yc-user`.
      * `--create-boot-disk size` — размер загрузочного диска. Должен быть не менее 30 ГБ.

      Результат:

      ```text
      id: epde18u4mahl********
      folder_id: b1g7gvsi89m3********
      created_at: "2023-02-08T10:34:06.601Z"
      name: mongo-vm
      ...
      ```

{% endlist %}


## Создайте секрет {{ lockbox-name}} {#secret-create}

В [секрете {{ lockbox-name }}](../../lockbox/concepts/secret.md) в зашифрованном виде будут храниться данные для аутентификации.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Нажмите **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите имя секрета — `mongodb-creds`.
  1. В блоке **{{ ui-key.yacloud.lockbox.label_version-dialog-title }}**:

      * В поле **{{ ui-key.yacloud.lockbox.forms.label_key }}** введите `login`.
      * В поле **{{ ui-key.yacloud.lockbox.forms.label_value }}** введите логин пользователя БД — `mongo_db_user`.

  1. Нажмите **{{ ui-key.yacloud.lockbox.forms.button_add-pair }}** и укажите второй секрет:

      * В поле **{{ ui-key.yacloud.lockbox.forms.label_key }}** введите `password`.
      * В поле **{{ ui-key.yacloud.lockbox.forms.label_value }}** введите пароль для доступа к БД — значение `MONGO_INITDB_ROOT_PASSWORD` из [спецификации Docker-контейнера](#create-vm).

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   Создайте секрет `mongodb-creds`:

    ```bash
    yc lockbox secret create \
      --name mongodb-creds \
      --payload "[{'key': 'login', 'text_value': 'mongo_db_user'},{'key': 'password', 'text_value': '<пароль>'}]"
    ```

    Где:

    * `--name` — имя секрета.
    * `--payload` — содержимое секрета в виде массива YAML или JSON.
    * `<пароль>` — значение `MONGO_INITDB_ROOT_PASSWORD` из [спецификации Docker-контейнера](#create-vm).

    Результат:

    ```text
    id: e6q6nbjfu9m2********
    folder_id: b1qt6g8ht345********
    created_at: "2023-02-08T10:34:06.601Z"
    name: mongodb-creds
    status: ACTIVE
    current_version:
      id: e6q0s9airqca********
      secret_id: e6q6nbjfu9m2********
      created_at: "2023-02-08T10:34:06.601Z"
      status: ACTIVE
      payload_entry_keys:
        - login
        - password
    ```

- API {#api}

  Чтобы создать секрет, воспользуйтесь методом REST API [create](../../lockbox/api-ref/Secret/create.md) для ресурса [Secret](../../lockbox/api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md).

{% endlist %}


## Создайте реестр {{ container-registry-name }} {#create-registry}

В [реестре](../../container-registry/concepts/registry.md) {{ container-registry-name }} будет храниться Docker-образ приложения `mongo-express`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Нажмите **{{ ui-key.yacloud.cr.overview.button_create }}**.
  1. Задайте имя реестра `app-registry`.
  1. Нажмите **{{ ui-key.yacloud.cr.overview.popup-create_button_create }}**.

- CLI {#cli}

  Создайте реестр `app-registry`:

  ```bash
  yc container registry create --name app-registry
  ```

  Результат:

  ```text
  id: crpd50616s9a********
  folder_id: b1g88tflru0e********
  name: app-registry
  status: ACTIVE
  created_at: "2023-02-08T10:34:06.601Z"
  ```

- API {#api}

  Чтобы создать реестр, воспользуйтесь методом REST API [create](../../container-registry/api-ref/Registry/create.md) для ресурса [Registry](../../container-registry/api-ref/Registry/) или вызовом gRPC API [RegistryService/CreateRegistryRequest](../../container-registry/api-ref/grpc/Registry/create.md).

{% endlist %}


## Загрузите Docker-образ в реестр {#push-image}

1. Зарегистрируйтесь на [Docker Hub](https://hub.docker.com/).
1. Установите Docker:

    * [Версия для Windows](https://docs.docker.com/desktop/install/windows-install/).
    * [Версия для Linux](https://docs.docker.com/desktop/install/linux-install/).
    * [Версия для Mac](https://docs.docker.com/desktop/install/mac-install/).

1. [Скачайте](https://hub.docker.com/_/mongo-express) образ `mongo-express`:

    ```bash
    docker pull mongo-express
    ```

    Результат выполнения команды:

    ```text
    Using default tag: latest
    latest: Pulling from library/mongo-express
    6a428f9f83b0: Pull complete
    ...
    e60224d64a04: Pull complete
    Digest: sha256:dcfcf89bf91238ff129469a5a94523b3025913dcc41597d72d4d5f4a********
    Status: Downloaded newer image for mongo-express:latest
    docker.io/library/mongo-express:latest
    ```

1. [Аутентифицируйтесь](../../container-registry/operations/authentication.md) в {{ container-registry-name }} с помощью Docker Credential helper:

    {% list tabs group=instructions %}

    - CLI {#cli}

      1. Сконфигурируйте Docker для использования `docker-credential-yc`:

          ```bash
          yc container registry configure-docker
          ```

          Результат:

          ```text
          Credential helper is configured in '/home/<user>/.docker/config.json'
          ```

          Настройки сохраняются в профиле текущего пользователя.

      1. Проверьте, что Docker сконфигурирован — в конфигурационном файле `${HOME}/.docker/config.json` должна появиться строка:

          ```json
          "{{ registry }}": "yc"
          ```

      Docker готов к использованию.

    {% endlist %}

1. [Загрузите](../../container-registry/operations/docker-image/docker-image-push.md) Docker-образ в реестр:

    {% list tabs group=instructions %}

    - CLI {#cli}

      1. Присвойте загруженному образу `mongo-express` URL вида `{{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>:<тег>`:

          ```bash
          docker tag mongo-express \
          {{ registry }}/<идентификатор_реестра>/mongo-express:mongo-tag
          ```

      1. Загрузите образ `mongo-express` в реестр:

          ```bash
          docker push {{ registry }}/<идентификатор_реестра>/mongo-express:mongo-tag
          ```

          Результат:

          ```text
          \The push refers to repository [{{ registry }}/crpbr3qaut47********/mongo-express]
          7c550ce9591d: Pushed
          ...
          aedc3bda2944: Pushed
          mongo-tag: digest: sha256:c641... size: 1993
          ```

    {% endlist %}


## Создайте контейнер {{ serverless-containers-name }} {#create-container}

Чтобы запустить приложение в {{ yandex-cloud }}, создайте [контейнер](../../serverless-containers/concepts/container.md) и его [ревизию](../../serverless-containers/concepts/container.md#revision).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. Нажмите **{{ ui-key.yacloud.serverless-containers.button_create-container }}**.
  1. Введите имя контейнера `mongo-express-container`.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-containers.label_editor }}**.

      1. В блоке **{{ ui-key.yacloud.serverless-containers.section_resources }}** укажите объем RAM — `1024 {{ ui-key.yacloud.common.units.label_megabyte }}`.
      1. В блоке **{{ ui-key.yacloud.serverless-containers.section_image }}**:

          1. В поле **{{ ui-key.yacloud.serverless-containers.label_image-url }}** укажите URL Docker-образа, загруженного [ранее](#push-image).
          1. В поле **{{ ui-key.yacloud.serverless-containers.label_environment }}** добавьте переменные:

              * `ME_CONFIG_BASICAUTH_USERNAME` — оставьте значение пустым.
              * `ME_CONFIG_BASICAUTH_PASSWORD` — оставьте значение пустым.
              * `VCAP_APP_PORT` — укажите порт `8080`.
              * `ME_CONFIG_MONGODB_SERVER` — укажите публичный адрес ВМ, полученный [ранее](#create-vm).

          1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}** укажите секреты:

              * `ME_CONFIG_MONGODB_AUTH_USERNAME` — укажите секрет с ключом `login`.
              * `ME_CONFIG_MONGODB_AUTH_PASSWORD` — укажите секрет с ключом `password`.

        1. В блоке **{{ ui-key.yacloud.serverless-containers.section_parameters }}**:

            1. В поле **{{ ui-key.yacloud.serverless-containers.label_service-account }}** укажите `mongo-express`.
            1. В поле **{{ ui-key.yacloud.serverless-containers.label_timeout }}** укажите `15`.

  1. Нажмите **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- CLI {#cli}

  1. Создайте контейнер:

      ```bash
      yc serverless container create --name mongo-express-container
      ```

      Результат:

      ```text
      id: bba3fva6ka5g********
      folder_id: b1gqvft7kjk3********
      created_at: "2023-02-08T10:34:06.601Z"
      name: mongo-express-container
      url: https://bba3fva6ka5g********.{{ serverless-containers-host }}/
      status: ACTIVE
      ```

  1. Создайте ревизию контейнера:

      ```bash
      yc serverless container revision deploy \
        --container-name mongo-express-container \
        --cores 1 \
        --memory 1GB \
        --image {{ registry }}/<идентификатор_реестра>/mongo-express:mongo-tag \
        --environment ME_CONFIG_BASICAUTH=false \
        --environment VCAP_APP_PORT=8080 \
        --environment ME_CONFIG_MONGODB_SERVER=<публичный_адрес_ВМ> \
        --secret environment-variable=ME_CONFIG_MONGODB_AUTH_USERNAME,key=login,id=<идентификатор_секрета> \
        --secret environment-variable=ME_CONFIG_MONGODB_AUTH_PASSWORD,key=password,id=<идентификатор_секрета> \
        --service-account-id <идентификатор_сервисного_аккаунта_mongo-express> \
        --network-id <идентификатор_сети> \
        --execution-timeout 15s \
        --concurrency 1
      ```

      Где:

      * `--image` — URL Docker-образа `mongo-express`, загруженного [ранее](#push-image).
      * `--environment` — переменные окружения:

          * `ME_CONFIG_BASICAUTH` — укажите значение `false`.
          * `VCAP_APP_PORT` — укажите порт `8080`.
          * `ME_CONFIG_MONGODB_SERVER` — укажите публичный адрес ВМ, полученный [ранее](#create-vm).

      * `--secret environment-variable` — секреты `ME_CONFIG_MONGODB_AUTH_USERNAME` и `ME_CONFIG_MONGODB_AUTH_PASSWORD`, созданные [ранее](#secret-create).
      * `--service-account-id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md) `mongo-express`, созданного [ранее](#sa-create).
      * `--network-id` — идентификатор сети `mongo-express-network`.

      Результат:

      ```text
      id: bbas0ktemln9********
      container_id: bbai45hrl5et********
      created_at: "2025-06-14T10:18:06.791Z"
      image:
        image_url: {{ registry }}/crpbr3qaut47********/mongo-express:mongo-tag
        image_digest: sha256:c641....
        environment:
          ME_CONFIG_BASICAUTH: "false"
          ME_CONFIG_MONGODB_SERVER: 89.169.***.***
          VCAP_APP_PORT: "8080"
      resources:
        memory: "1073741824"
        cores: "1"
        core_fraction: "100"
      execution_timeout: 15s
      concurrency: "1"
      service_account_id: ajeldi88vl73********
      status: ACTIVE
      secrets:
        - id: e6qfi832v2j8********
          version_id: e6qj9a9oifme********
          key: login
          environment_variable: ME_CONFIG_MONGODB_AUTH_USERNAME
        - id: e6qfi832v2j8********
          version_id: e6qj9a9oifme********
          key: password
          environment_variable: ME_CONFIG_MONGODB_AUTH_PASSWORD
      log_options:
        folder_id: b1g681qpemb4********
      runtime:
        http: {}
      ```

- API {#api}

  1. Чтобы создать контейнер, воспользуйтесь методом REST API [create](../../serverless-containers/containers/api-ref/Container/create.md) для ресурса [Container](../../serverless-containers/containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/Create](../../serverless-containers/containers/api-ref/grpc/Container/create.md).
  1. Чтобы создать ревизию контейнера, воспользуйтесь методом REST API [deployRevision](../../serverless-containers/containers/api-ref/Container/deployRevision.md) для ресурса [Container](../../serverless-containers/containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../../serverless-containers/containers/api-ref/grpc/Container/deployRevision.md).

{% endlist %}


## Создайте API-шлюз {{ api-gw-name }} {#create-api-gw}

Создайте [API-шлюз](../../api-gateway/concepts/index.md) с расширением `x-yc-apigateway-integration:serverless_containers`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Нажмите **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите название API-шлюза — `mongo-express-gw`.
  1. В блок **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** добавьте спецификацию:

      ```yaml
      openapi: 3.0.0
      info:
        title: Sample API
        version: 1.0.0
      paths:
        /{proxy+}:
          x-yc-apigateway-any-method:
            x-yc-apigateway-integration:
              type: serverless_containers
              container_id: <идентификатор_контейнера>
              service_account_id: <идентификатор_сервисного_аккаунта>
            parameters:
            - explode: false
              in: path
              name: proxy
              required: false
              schema:
                default: '-'
                type: string
              style: simple
      ```

      Где:

      * `container_id` — идентификатор контейнера `mongo-express-container`.
      * `service_account_id` — идентификатор сервисного аккаунта `mongo-express`.

  1. Нажмите **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
  1. Откройте созданный API-шлюз и скопируйте ссылку из поля **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}**.

- CLI {#cli}

  1. Подготовьте файл спецификации API по стандарту [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification).

      {% cut "Спецификация" %}

      ```yaml
      openapi: 3.0.0
      info:
        title: Sample API
        version: 1.0.0
      paths:
        /{proxy+}:
          x-yc-apigateway-any-method:
            x-yc-apigateway-integration:
              type: serverless_containers
              container_id: <идентификатор_контейнера>
              service_account_id: <идентификатор_сервисного_аккаунта>
            parameters:
            - explode: false
              in: path
              name: proxy
              required: false
              schema:
                default: '-'
                type: string
              style: simple
      ```

      Где:

      * `container_id` — идентификатор контейнера `mongo-express-container`.
      * `service_account_id` — идентификатор сервисного аккаунта `mongo-express`.

      {% endcut %}

  1. Укажите параметры и создайте API-шлюз с помощью команды:

      ```bash
      {{ yc-serverless }} api-gateway create \
          --name mongo-express-gw \
          --spec=<путь_к_файлу_спецификации>
      ```

      Результат:

      ```text
      id: d5d63uh1h26g********
      folder_id: b1g681qpemb4********
      created_at: "2025-06-14T10:23:19.682Z"
      name: mongo-express-gw
      status: ACTIVE
      domain: d5d63uh1h26g********.********.apigw.yandexcloud.net
      connectivity: {}
      log_options:
        folder_id: b1g681qpemb4********
      execution_timeout: 300s
      ```

      Сохраните ссылку, указанную в поле `domain`.

- API {#api}

  Чтобы создать API-шлюз, воспользуйтесь методом REST API [create](../../api-gateway/apigateway/api-ref/ApiGateway/create.md) для ресурса [ApiGateway](../../api-gateway/apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Create](../../api-gateway/apigateway/api-ref/grpc/ApiGateway/create.md).

{% endlist %}


## Проверьте работу приложения {#check-app}

Перейдите по ссылке вида `d5d63uh1h26g********.********.apigw.yandexcloud.net`, полученной на предыдущем шаге. Откроется административная панель {{ MG }}.


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../api-gateway/operations/api-gw-delete.md) API-шлюз `mongo-express-gw`.
1. [Удалите](../../serverless-containers/operations/delete.md) контейнер `mongo-express-container`.
1. [Удалите](../../container-registry/operations/docker-image/docker-image-delete.md) образ из реестра `app-registry`.
1. [Удалите](../../container-registry/operations/registry/registry-delete.md) реестр `app-registry`.
1. [Удалите](../../lockbox/operations/secret-delete.md) секрет `mongodb-creds`.
1. [Удалите](../../storedoc/operations/cluster-delete.md) ВМ `mongo-vm`.
1. [Удалите](../../iam/operations/sa/delete.md) сервисный аккаунт `mongo-express`.
