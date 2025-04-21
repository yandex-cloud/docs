1. [Подготовьте облако к работе](#before-begin).
1. [Создайте группу ВМ](#create-ig).
1. [Создайте ресурсы {{ sf-name }}](#create-sf-resources).
1. [Проверьте масштабирование группы ВМ](#test-scale).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

В качестве примера будет использоваться [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) с именем `example-folder`.

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/vm-scale-scheduled/paid-resources.md) %}

## Создайте вспомогательные ресурсы {#create-aux-resources}

### Создайте сервисный аккаунт {#create-sa}

[Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) будет привязан к группе ВМ {{ compute-name }} и функции {{ sf-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. В поле **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** укажите `vm-scale-scheduled-sa`.
  1. Нажмите ![](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите [роли](../../iam/concepts/access-control/roles.md):
     * `compute.editor` — для управления группой ВМ.
     * `iam.serviceAccounts.user` — для привязки сервисного аккаунта к ВМ, входящим в группу.
     * `{{ roles-functions-invoker }}` — для запуска функции {{ sf-name }}.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

  1. Создайте сервисный аккаунт:

     ```bash
     yc iam service-account create --name vm-scale-scheduled-sa \
       --folder-name example-folder
     ```

     Результат:

     ```yaml
     id: ajeab0cnib1p********
     folder_id: b0g12ga82bcv********
     created_at: "2022-03-15T09:44:35.989446Z"
     name: vm-scale-scheduled-sa
     ```

     Подробнее о команде `yc iam service-account create` см. в [справочнике CLI](../../cli/cli-ref/iam/cli-ref/service-account/create.md).
  1. Назначьте сервисному аккаунту [роли](../../iam/concepts/access-control/roles.md):
     * `compute.editor` — для управления группой ВМ:

       ```bash
       yc resource-manager folder add-access-binding example-folder \
         --service-account-name vm-scale-scheduled-sa \
         --role compute.editor \
         --folder-name example-folder
       ```

     * `iam.serviceAccounts.user` — для привязки сервисного аккаунта к ВМ, входящим в группу:

       ```bash
       yc resource-manager folder add-access-binding example-folder \
         --service-account-name vm-scale-scheduled-sa \
         --role iam.serviceAccounts.user \
         --folder-name example-folder
       ```

     * `{{ roles-functions-invoker }}` — для запуска функции {{ sf-name }}:

       ```bash
       yc resource-manager folder add-access-binding example-folder \
         --service-account-name vm-scale-scheduled-sa \
         --role {{ roles-functions-invoker }} \
         --folder-name example-folder
       ```

     Подробнее о команде `yc resource-manager folder add-access-binding` см. в [справочнике CLI](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

- API {#api}

  1. Создайте сервисный аккаунт `vm-scale-scheduled-sa`. Для этого воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).
  1. Назначьте сервисному аккаунту в текущем каталоге [роли](../../iam/concepts/access-control/roles.md):
     * `compute.admin` — для управления группой ВМ.
     * `iam.serviceAccounts.user` — для привязки сервисного аккаунта к ВМ, входящим в группу.
     * `{{ roles-functions-invoker }}` — для запуска функции {{ sf-name }}.

     Для этого воспользуйтесь методом REST API [setAccessBindings](../../resource-manager/api-ref/Folder/setAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/SetAccessBindings](../../resource-manager/api-ref/grpc/Folder/setAccessBindings.md).

{% endlist %}

### Создайте облачную сеть {#create-network}

Группа ВМ будет размещена в [облачной сети](../../vpc/concepts/network.md#network) [{{ vpc-full-name }}](../../vpc/) и ее [подсетях](../../vpc/concepts/network.md#subnet).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** укажите `vm-scale-scheduled-network`.
  1. Выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.

- CLI {#cli}

  1. Создайте сеть `vm-scale-scheduled-network`:

     ```bash
     yc vpc network create --name vm-scale-scheduled-network \
       --folder-name example-folder
     ```

     Результат:

     ```yaml
     id: enpabce123hd********
     folder_id: b0g12ga82bcv********
     created_at: "2022-03-15T09:55:50.004472Z"
     name: vm-scale-scheduled-network
     ```

     Подробнее о команде `yc vpc network create` см. в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/network/create.md).
  1. Создайте подсеть `vm-scale-scheduled-subnet-a` в [зоне доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-a`:

     ```bash
     yc vpc subnet create --name vm-scale-scheduled-subnet-a \
       --folder-name example-folder \
       --network-name vm-scale-scheduled-network --range 192.168.1.0/24 \
       --zone {{ region-id }}-a
     ```

     Результат:

     ```yaml
     id: e1lnabc23r1c********
     folder_id: b0g12ga82bcv********
     created_at: "2022-03-15T09:56:51.859345Z"
     name: vm-scale-scheduled-subnet-a
     network_id: enpabce123hd********
     zone_id: {{ region-id }}-a
     v4_cidr_blocks:
     - 192.168.1.0/24
     ```

     Подробнее о команде `yc vpc subnet create` см. в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).
  1. Создайте подсеть `vm-scale-scheduled-network-b` в зоне доступности `{{ region-id }}-b`:

     ```bash
     yc vpc subnet create --name vm-scale-scheduled-subnet-b \
       --folder-name example-folder \
       --network-name vm-scale-scheduled-network --range 192.168.2.0/24 \
       --zone {{ region-id }}-b
     ```

     Результат:

     ```yaml
     id: b1csa2b3clid********
     folder_id: b0g12ga82bcv********
     created_at: "2022-03-15T09:57:48.934429Z"
     name: vm-scale-scheduled-subnet-b
     network_id: enpabce123hd********
     zone_id: {{ region-id }}-b
     v4_cidr_blocks:
     - 192.168.2.0/24
     ```

- API {#api}

  1. Создайте сеть `vm-scale-scheduled-network` с помощью метода REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызова gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md).
  1. Создайте подсети `vm-scale-scheduled-subnet-a` в зоне доступности `{{ region-id }}-a` и `vm-scale-scheduled-subnet-b` в зоне `{{ region-id }}-b` с помощью метода REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызова gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md).

{% endlist %}

## Создайте группу виртуальных машин {#create-ig}

Группа ВМ будет создана с ручным масштабированием, чтобы ее размером могла управлять функция {{ sf-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.compute.groups.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_base }}**:
     * В поле **{{ ui-key.yacloud.compute.groups.create.field_name }}** укажите `vm-scale-scheduled-ig`.
     * Выберите **{{ ui-key.yacloud.compute.groups.create.field_service-account }}** `vm-scale-scheduled-sa`.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_allocation }}** в поле **{{ ui-key.yacloud.compute.groups.create.field_zone }}** выберите `{{ region-id }}-a` и `{{ region-id }}-b`.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_instance }}** нажмите **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** и в открывшемся окне:
     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** на вкладке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts).
     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** укажите следующие настройки:
       * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
       * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
       * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `20%`.
       * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
       * В поле **{{ ui-key.yacloud.compute.instances.create.field_instance-group-network }}** выберите `vm-scale-scheduled-network`.
       * В поле **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** выберите `{{ ui-key.yacloud.compute.instances.create.value_address-none }}`.
     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
       * В поле **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** выберите `vm-scale-scheduled-sa`.
       * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** укажите имя пользователя, который будет создан на ВМ. Придумайте имя самостоятельно.
       * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла открытого ключа [SSH](../../glossary/ssh-keygen.md). Создать пару ключей можно по [инструкции](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
     * Нажмите **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_deploy }}** укажите следующие настройки:
     * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-expansion }}** — `2`. 
     * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-unavailable }}** — `2`.
     * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-creating }}** — `2`.
     * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-deleting }}** — `2`.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_scale }}**:
     * В поле **{{ ui-key.yacloud.compute.groups.create.field_scale-type }}** выберите `{{ ui-key.yacloud.compute.groups.create.value_scale-fixed }}`.
     * Укажите **{{ ui-key.yacloud.compute.groups.create.field_scale-size }}** `2`.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  1. Получите идентификаторы ресурсов, созданных ранее:
     * Идентификатор сервисного аккаунта `vm-scale-scheduled-sa`:

       ```bash
       yc iam service-account get vm-scale-scheduled-sa \
         --folder-name example-folder | grep "^id"
       ```

       Результат:

       ```yaml
       id: ajeab0cnib1p********
       ```

       Подробнее о команде `yc iam service-account get` см. в [справочнике CLI](../../cli/cli-ref/iam/cli-ref/service-account/get.md).
     * Идентификатор сети `vm-scale-scheduled-network`:

       ```bash
       yc vpc network get vm-scale-scheduled-network \
         --folder-name example-folder | grep "^id"
       ```

       Результат:

       ```yaml
       id: enpabce123hd********
       ```

       Подробнее о команде `yc vpc network get` см. в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/network/get.md).
     * Идентификатор подсети `vm-scale-scheduled-subnet-a`:

       ```bash
       yc vpc subnet get vm-scale-scheduled-subnet-a \
         --folder-name example-folder | grep "^id"
       ```

       Результат:

       ```yaml
       id: e1lnabc23r1c********
       ```

       Подробнее о команде `yc vpc subnet get` см. в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/subnet/get.md).
     * Идентификатор подсети `vm-scale-scheduled-subnet-b`:

       ```bash
       yc vpc subnet get vm-scale-scheduled-subnet-b \
         --folder-name example-folder | grep "^id"
       ```

       Результат:

       ```yaml
       id: b1csa2b3clid********
       ```

       Подробнее о команде `yc vpc subnet get` см. в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/subnet/get.md).
  1. Получите идентификатор последней версии публичного образа [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts):

     ```bash
     yc compute image get-latest-from-family ubuntu-2004-lts \
       --folder-id standard-images | grep "^id"
     ```

     Результат:

     ```yaml
     id: fd83n3uou8m0********
     ```

     Подробнее о команде `yc compute image get-latest-from-family` см. в [справочнике CLI](../../cli/cli-ref/compute/cli-ref/image/get-latest-from-family.md).
  1. Вставьте полученные идентификаторы в файл `specification.yaml` со спецификацией группы ВМ:

     {% include [vm-scale-scheduled-yaml-spec-init](../../_includes/instance-groups/vm-scale-scheduled-yaml-spec-init.md) %}

  1. Создайте группу ВМ с именем `vm-scale-scheduled-ig` по спецификации `specification.yaml`:

     ```bash
     yc compute instance-group create --file specification.yaml \
       --folder-name example-folder
     ```

     Результат:

     ```text
     done (2m18s)
     id: cl0kabcquk1g********
     folder_id: b0g12ga82bcv********
     ...
     service_account_id: ajeab0cnib1p********
     status: ACTIVE
     ```

- API {#api}

  1. Получите идентификаторы ресурсов, созданных ранее:
     * Идентификатор сервисного аккаунта `vm-scale-scheduled-sa` — с помощью метода REST API [get](../../iam/api-ref/ServiceAccount/get.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызова gRPC API [ServiceAccountService/Get](../../iam/api-ref/grpc/ServiceAccount/get.md).
     * Идентификатор сети `vm-scale-scheduled-network` — с помощью метода REST API [get](../../vpc/api-ref/Network/get.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызова gRPC API [NetworkService/Get](../../vpc/api-ref/grpc/Network/get.md).
     * Идентификаторы подсетей `vm-scale-scheduled-subnet-a` и `vm-scale-scheduled-subnet-b` — с помощью метода REST API [get](../../vpc/api-ref/Subnet/get.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызова gRPC API [SubnetService/Get](../../vpc/api-ref/grpc/Subnet/get.md).
  1. Получите идентификатор последней версии публичного образа [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts) в семействе `standard-images` с помощью метода REST API [getLatestByFamily](../../compute/api-ref/Image/getLatestByFamily.md) для ресурса [Image](../../compute/api-ref/Image/index.md) или вызова gRPC API [ImageService/GetLatestByFamily](../../compute/api-ref/grpc/Image/getLatestByFamily.md).
  1. Вставьте полученные идентификаторы в файл `specification.yaml` со спецификацией группы ВМ:

     {% include [vm-scale-scheduled-yaml-spec-init](../../_includes/instance-groups/vm-scale-scheduled-yaml-spec-init.md) %}

  1. Создайте группу ВМ с именем `vm-scale-scheduled-ig` по спецификации `specification.yaml` с помощью метода REST API [createFromYaml](../../compute/instancegroup/api-ref/InstanceGroup/createFromYaml.md) для ресурса [InstanceGroup](../../compute/instancegroup/api-ref/InstanceGroup/index.md) или вызова gRPC API [InstanceGroupService/CreateFromYaml](../../compute/instancegroup/api-ref/grpc/InstanceGroup/createFromYaml.md).

{% endlist %}

## Создайте ресурсы {{ sf-name }} {#create-sf-resources}

### Создайте функцию {#create-function}

Функция будет содержать код с командами {{ yandex-cloud }} CLI, которые изменяют группу ВМ.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** укажите `vm-scale-scheduled-function`.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.
  1. Выберите среду выполнения **Bash**.
  1. Включите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
  1. Нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** выберите файл `handler.sh`.
  1. Вставьте вместо содержимого файла следующий код:

     {% include [vm-scale-scheduled-function-code.md](../../_includes/instance-groups/vm-scale-scheduled-function-code.md) %}

  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**:
     * В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** укажите значение `60`.
     * В поле **{{ ui-key.yacloud.forms.label_service-account-select }}** выберите `vm-scale-scheduled-sa`.
     * В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}** добавьте следующие переменные:
       * `IG_NAME` = `vm-scale-scheduled-ig`.
       * `IG_BASE_SIZE` = `2`.
       * `FOLDER_ID` = идентификатор каталога. Получить идентификатор можно по [инструкции](../../resource-manager/operations/folder/get-id.md).
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

  1. Создайте файл `handler.sh` со следующим кодом:

     {% include [vm-scale-scheduled-function-code.md](../../_includes/instance-groups/vm-scale-scheduled-function-code.md) %}

  1. Создайте функцию:
 
     ```bash
     yc serverless function create vm-scale-scheduled-function \
       --folder-name example-folder
     ```

     Результат:

     ```text
     done (1s)
     id: d4e7d67ikvmq********
     folder_id: b1g9hv2loamq********
     ...
     log_group_id: ckgij6l0845h********
     http_invoke_url: https://{{ sf-url }}/d4e7d67ikvmq********
     status: ACTIVE
     ```

  1. Создайте версию функции:

     ```bash
     yc serverless function version create --folder-name example-folder \
       --function-name vm-scale-scheduled-function --runtime bash \
       --source-path ./handler.sh --entrypoint "handler.sh" \
       --execution-timeout 60s \
       --service-account-id <идентификатор_сервисного_аккаунта> \
       --environment \
         IG_NAME=vm-scale-scheduled-ig,IG_BASE_SIZE=2,FOLDER_ID=<идентификатор_каталога>
     ```

     Где:
     * Опция `--service-account-id` — идентификатор сервисного аккаунта `vm-scale-schedule-sa`. Получить идентификатор можно по инструкции в шаге [Создайте группу ВМ](#create-ig), на вкладке **CLI**.
     * Переменная `FOLDER_ID` в опции `--environment` — идентификатор каталога. Получить идентификатор можно по [инструкции](../../resource-manager/operations/folder/get-id.md).

     Результат:

     ```text
     done (1s)
     id: d4efmv9n3qf1********
     function_id: d4e7d67ikvmq********
     ...
       FOLDER_ID: b1g9hv2loamq********
       IG_BASE_SIZE: "2"
       IG_NAME: vm-scale-scheduled-ig
     ```

- API {#api}

  1. Создайте функцию `vm-scale-scheduled-function` с помощью метода REST API [create](../../functions/functions/api-ref/Function/create.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызова gRPC API [FunctionService/Create](../../functions/functions/api-ref/grpc/Function/create.md). Из ответных данных получите идентификатор созданной функции.
  1. Создайте версию функции с помощью метода REST API [createVersion](../../functions/functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызова gRPC API [FunctionService/CreateVersion](../../functions/functions/api-ref/grpc/Function/createVersion.md). Версия функции должна иметь следующий код:

     {% include [vm-scale-scheduled-function-code.md](../../_includes/instance-groups/vm-scale-scheduled-function-code.md) %}

{% endlist %}

### Создайте триггер {#create-trigger}

[Триггер](../../functions/concepts/trigger/index.md) определяет условия запуска функции. Для запуска по расписанию используется [триггер-таймер](../../functions/concepts/trigger/timer.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_name }}** укажите `vm-scale-scheduled-trigger`.
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_timer }}`.
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_timer }}** в поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cron-expression }}** укажите `*/2 * * * ? *` — триггер будет срабатывать каждые две минуты, например, в 09:58, 10:00, 10:02, 10:04 и т. д.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**:
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function }}** укажите `vm-scale-scheduled-function`.
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function-tag }}** выберите `$latest`.
     * Выберите **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }}** `vm-scale-scheduled-sa`.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** очистите поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_dlq_service-account }}** (`{{ ui-key.yacloud.component.service-account-select.label_no-service-account }}`).
  1. Нажмите **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

  Выполните следующую команду:

  ```bash
  yc serverless trigger create timer --folder-name example-folder \
    --name vm-scale-scheduled-trigger \
    --cron-expression "*/2 * * * ? *" \
    --invoke-function-name vm-scale-scheduled-function \
    --invoke-function-tag '$latest' \
    --invoke-function-service-account-name vm-scale-scheduled-sa
  ```

  Результат:

  ```yaml
  id: a1s22pb0v5i4********
  folder_id: b1g9hv2loamq********
  created_at: "2022-04-06T14:56:54.253709098Z"
  ...
        function_tag: $latest
        service_account_id: aje9s4pud13h********
  status: ACTIVE
  ```

- API {#api}

  Используйте метод REST API [create](../../functions/triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../functions/triggers/api-ref/Trigger/index.md) или вызов gRPC API [TriggerService/Create](../../functions/triggers/api-ref/grpc/Trigger/create.md), чтобы создать триггер типа `timer` с cron-выражением `*/2 * * * ? *`, связанный с функцией `vm-scale-scheduled-function` версии `$latest` и сервисным аккаунтом `vm-scale-scheduled-sa`.

{% endlist %}

## Проверьте масштабирование группы ВМ {#test-scale}

{% include [test-scale](../_tutorials_includes/vm-scale-scheduled/test-scale.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите](../../functions/operations/trigger/trigger-delete.md) триггер.
1. [Удалите](../../functions/operations/function/function-delete.md) функцию.
1. [Удалите](../../compute/operations/instance-groups/delete.md) группу ВМ.