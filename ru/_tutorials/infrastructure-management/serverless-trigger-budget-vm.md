# Создание триггера для бюджетов, который вызывает функцию {{ sf-name }} для остановки ВМ

Создайте триггер для [бюджетов](../../billing/concepts/budget.md), который вызывает [функцию](../../functions/concepts/function.md) {{ sf-name }}. Функция будет останавливать [виртуальные машины](../../compute/concepts/vm.md#project) {{ compute-name }} при превышении пороговых значений, заданных в бюджете.

Чтобы развернуть проект:
1. [Скачайте проект](#download).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Подготовьте ZIP-архив с кодом функции](#prepare-zip).
1. [Создайте функцию {{ sf-name }}](#create-function).
1. [Создайте бюджет](#create-budget).
1. [Создайте триггер для бюджетов](#create-trigger).
1. [Создайте виртуальные машины {{ compute-name }}](#create-vm).
1. [Проверьте, что ВМ останавливаются по триггеру](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов входят:
* Плата за использование виртуальных машин (см. [тарифы {{ compute-name }} ](../../compute/pricing.md)).
* Плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы {{ sf-name }}](../../functions/pricing.md)).

## Скачайте проект {#download}

Склонируйте репозиторий c проектом:

```bash
git clone https://github.com/yandex-cloud-examples/yc-serverless-trigger-budget
```

## Создайте сервисный аккаунт {#create-sa}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать сервисный аккаунт.
    1. Перейдите на вкладку **Сервисные аккаунты**.
    1. Нажмите кнопку **Создать сервисный аккаунт**.
    1. Введите имя сервисного аккаунта `service-account-for-budget`.
    1. Нажмите **Добавить роль** и назначьте сервисному аккаунту роли `compute.admin`, `iam.serviceAccounts.user` и `serverless.functions.invoker`.
    1. Нажмите кнопку **Создать**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Создайте сервисный аккаунт `service-account-for-budget`:
        ```bash
        yc iam service-account create --name service-account-for-budget
        ```

        Результат:
        ```
        id: ajersamh4sjq********
        folder_id: b1gc1t4cb638********
        created_at: "2022-12-07T10:36:29.726397755Z"
        name: service-account-for-budget
        ```

    1. Получите список каталогов в облаке:
        ```bash
        yc resource-manager folder list
        ```

        Результат:
        ```
        +----------------------+----------------------+--------+--------+
        |          ID          |         NAME         | LABELS | STATUS |
        +----------------------+----------------------+--------+--------+
        | b1gp7arme3nn******** | my-folder            |        | ACTIVE |
        | b1g0itj57rbj******** | test-folder          |        | ACTIVE |
        +----------------------+----------------------+--------+--------+
        ```

        Сохраните идентификатор каталога, в котором хотите создать сервисный аккаунт.

    1. Получите список сервисных аккаунтов в каталоге:
        ```bash
        yc iam service-account list
        ```

        Результат:
        ```
        +----------------------+------------------------------+
        |          ID          |             NAME             |
        +----------------------+------------------------------+
        | aje07l4q4vmo******** | test-sa                      |
        | ajersamh4sjq******** | service-account-for-budget   |
        +----------------------+------------------------------+
        ```

        Сохраните идентификатор сервисного аккаунта `service-account-for-budget`.

    1. Назначьте сервисному аккаунту роли `compute.admin`, `iam.serviceAccounts.user` и `serverless.functions.invoker` на каталог:
        ```bash
        yc resource-manager folder add-access-binding <идентификатор_каталога> \
           --role compute.admin \
           --subject serviceAccount:<идентификатор_сервисного_аккаунта>

        yc resource-manager folder add-access-binding <идентификатор_каталога> \
           --role iam.serviceAccounts.user \
           --subject serviceAccount:<идентификатор_сервисного_аккаунта>

        yc resource-manager folder add-access-binding <идентификатор_каталога> \
           --role serverless.functions.invoker \
           --subject serviceAccount:<идентификатор_сервисного_аккаунта>
        ```

        Результат:
        ```
        done (1s)
        ```

- API

    Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md).

    Чтобы назначить сервисному аккаунта роли `compute.admin`, `iam.serviceAccounts.user` и `serverless.functions.invoker` на каталог, воспользуйтесь методом [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md).

{% endlist %}

## Подготовьте ZIP-архив с кодом функции {#prepare-zip}

Перейдите в директорию `yc-serverless-trigger-budget/steps/2-create-function/` и добавьте файлы в ZIP-архив `src.zip`:
```bash
zip src.zip index.go go.mod
```

## Создайте функцию {{ sf-name }} {#create-function}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором создали сервисный аккаунт.
    1. Выберите сервис **{{ sf-name }}**.
    1. Создайте функцию:
        1. Нажмите кнопку **Создать функцию**.
        1. Введите имя функции `function-for-budget`.
        1. Нажмите кнопку **Создать**.
    1. Создайте версию функции:
        1. Выберите среду выполнения `golang119`, выключите опцию **Добавить файлы с примерами кода** и нажмите кнопку **Продолжить**.
        1. Укажите способ загрузки **ZIP-архив** и выберите архив, который создали на предыдущем шаге.
        1. Укажите точку входа `index.StopComputeInstances`.
        1. В блоке **Параметры** укажите:
            * **Таймаут** — 5 секунд;
            * **Память** — 512 МБ;
            * **Сервисный аккаунт** — `service-account-for-budget`;
            * **Переменные окружения**:
                * `FOLDER_ID` — идентификатор каталога, в котором вы хотите останавливать виртуальные машины.
                * `TAG` — `target-for-stop`.
        1. Нажмите кнопку **Создать версию**.

- CLI

    1. Создайте функцию `function-for-budget`:
        ```bash
        yc serverless function create --name function-for-budget
        ```

        Результат:
        ```
        done (1s)
        id: d4eiqjdbqt7s********
        folder_id: b1gc1t4cb638********
        created_at: "2022-12-07T10:44:13.156Z"
        name: function-for-budget
        log_group_id: ckg6bie2rtgd********
        http_invoke_url: https://functions.yandexcloud.net/d4eiqjdbqt7s********
        status: ACTIVE
        ```

    1. Создайте версию функции `function-for-budget`:
        ```bash
        yc serverless function version create \
          --function-name function-for-budget \
          --memory=512m \
          --execution-timeout=5s \
          --runtime=golang119 \
          --entrypoint=index.StopComputeInstances \
          --service-account-id=<идентификатор_сервисного_аккаунта> \
          --environment FOLDER_ID=<идентификатор_каталога> \
          --environment TAG=target-for-stop \
          --source-path=./src.zip
        ```

        Где:
        * `--function-name` — имя функции, версия которой создается.
        * `--memory` —  объем RAM.
        * `--execution-timeout` — максимальное время выполнения функции до достижения таймаута.
        * `--runtime` — среда выполнения.
        * `--entrypoint` — точка входа.
        * `--service-account-id` — идентификатор сервисного аккаунта `service-account-for-budget`.
        * `--environment` — переменные окружения. `FOLDER_ID` — идентификатор каталога, в котором вы хотите останавливать виртуальные машины.
        * `--source-path` — путь до ZIP-архива `src.zip`.

        Результат:
        ```
        done (2m7s)
        id: d4ev38dddr41********
        function_id: d4eiqjdbqt7s********
        created_at: "2022-12-07T11:14:07.802Z"
        runtime: golang119
        entrypoint: index.StopComputeInstances
        resources:
          memory: "536870912"
        execution_timeout: 5s
        service_account_id: ajersamh4sjq********
        image_size: "19587072"
        status: ACTIVE
        tags:
          - $latest
        log_group_id: ckg6bie2rtgd********
        environment:
          FOLDER_ID: b1gc1t4cb638********
          TAG: target-for-stop
        log_options:
          folder_id: b1gc1t4cb638********
        ```

- API

    Чтобы создать функцию, воспользуйтесь методом [create](../../functions/functions/api-ref/Function/create.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md).

    Чтобы создать версию функцию, воспользуйтесь методом [createVersion](../../functions/functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md).

{% endlist %}

## Создайте бюджет {#create-budget}

Чтобы создать бюджет, у пользователя должна быть роль `editor`. Чтобы получать оповещения, достаточно роли `viewer`. 

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором создали сервисный аккаунт и функцию.
    1. В левом верхнем углу нажмите кнопку ![image](../../_assets/main-menu.svg) **Все сервисы**.
    1. Выберите вкладку ![image](../../_assets/billing.svg) [**Биллинг**]({{ link-console-billing }}).
    1. На странице **Список аккаунтов** выберите платежный аккаунт.
    1. Перейдите на вкладку **Бюджеты** и нажмите **Создать бюджет**.
    1. В блоке **Общая информация** укажите:
        * Имя бюджета — `vm-budget`.
        * Тип бюджета — **К оплате**.
        * Сумму расходов на потребление.
        * Период расчета — **Месячный**.
        * Дату окончания действия бюджета. Дата окончания устанавливает, когда бюджет перестанет считать потребление и отправлять уведомления. Дата окончания — последнее число месяца. Не может быть позже пяти лет от текущей даты.
        * Пользователей, которых нужно уведомить, что достигнуты пороговые значения.
    1. В блоке **Область действия** выберите каталог, в котором ведете работу, и сервис **{{ compute-name }}**.
    1. В блоке **Пороги** укажите пороговые значения в процентах, при достижении которых:
        * указанным пользователям будут приходить уведомления.
        * будет срабатывать триггер для бюджетов.

        Например, можно указать два порога — 50% и 100%.
    1. Нажмите кнопку **Создать**.

- API

    Чтобы создать бюджет, воспользуйтесь методом [create](../../billing/api-ref/Budget/create.md) для ресурса [Budget](../../billing/api-ref/Budget/index.md).

{% endlist %}

## Создайте триггер для бюджетов {#create-trigger}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором создали сервисный аккаунт, функцию и бюджет.

    1. Выберите сервис **{{ sf-name }}**.

    1. На панели слева выберите ![image](../../_assets/functions/triggers.svg) **Триггеры**.

    1. Нажмите кнопку **Создать триггер**.

    1. В блоке **Базовые параметры**:

        * Введите имя триггера `vm-stop-trigger`.
        * В поле **Тип** выберите **Бюджет**.
        * В поле **Запускаемый ресурс** выберите **Функция**.

    1. В блоке **Настройки бюджета** выберите платежный аккаунт и бюджет `vm-budget`, который создали на предыдущем шаге.

    1. В блоке **Настройки функции** выберите функцию `function-for-budget` и укажите:

        * [тег версии функции](../../functions/concepts/function.md#tag). По умолчанию указан тег `$latest`.
        * сервисный аккаунт `service-account-for-budget`. От его имени будет вызываться функция.

    1. Нажмите кнопку **Создать триггер**.

- CLI

    Чтобы создать триггер для бюджетов, который вызывает функцию `function-for-budget`, выполните команду:

    ```bash
    yc serverless trigger create billing-budget \
      --name vm-stop-trigger \
      --billing-account-id <идентификатор_платежного_аккаунта> \
      --budget-id <идентификатор_бюджета> \
      --invoke-function-id <идентификатор_функции> \
      --invoke-function-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--billing-account-id` — идентификатор [платежного аккаунта](../../billing/concepts/billing-account.md).
    * `--budget-id` — идентификатор бюджета `vm-budget`.
    * `--invoke-function-id` — идентификатор функции `function-for-budget`.
    * `--invoke-function-service-account-id` — идентификатор сервисного аккаунта `service-account-for-budget`.

    Результат:

    ```text
    id: a1sfe084v4**********
    folder_id: b1g88tflru**********
    created_at: "2022-12-04T08:45:31.131391Z"
    name: vm-stop-trigger
    rule:
      billing-budget:
        billing-account-id: dn2char50j**********
        budget-id: dn2jnshmdlc1********
        invoke_function:
          function_id: d4eofc7n0m03********
          function_tag: $latest
          service_account_id: aje3932acd0c********
    status: ACTIVE
    ```

- API

    Чтобы создать триггер для бюджетов, воспользуйтесь методом [create](../../functions/triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../functions/triggers/api-ref/Trigger/index.md).

{% endlist %}

## Создайте виртуальные машины {{ compute-name }} {##create-vm}

{% list tabs %}

- CLI

    1. Выберите подсеть:
        ```
        yc vpc subnet list
        ```

    1. Создайте виртуальную машину:
        ```bash
        yc compute instance create \
           --name target-instance-1 \
           --labels target-for-stop=true \
           --zone {{ region-id }}-a \
           --network-interface subnet-name=<имя_подсети>,nat-ip-version=ipv4 \
           --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2004-lts \
           --ssh-key ~/.ssh/<имя_ключа>.pub
        ```

        Где:

        * `--name` — имя виртуальной машины.
        * `--labels` — метка. Триггер для бюджетов будет останавливать виртуальную машину при достижении пороговых значений, если значение метки `target-for-stop` равно `true`.
        * `--zone` — зона доступности, которая соответствует выбранной подсети.
        * `--subnet-name` — имя выбранной подсети.
        * `--nat-ip-version` — публичный IP.
        * `image-family` — [семейство образов](../../compute/concepts/image#family). Эта опция позволит установить последнюю версию операционной системы из указанного семейства.
        * `--ssh-key` — путь до публичного SSH-ключа. Для этого ключа на виртуальной машине будет автоматически создан пользователь `yc-user`. [Как создать пару SSH-ключей](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

        Результат:
        ```
        done (34s)
        id: fhm8lon8b9a9********
        folder_id: b1gc1t4cb638********
        created_at: "2022-12-07T11:29:39Z"
        name: target-instance-1
        labels:
          target-for-stop: "true"
        zone_id: {{ region-id }}-a
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
          aws_v1_http_token: ENABLED
        boot_disk:
          mode: READ_WRITE
          device_name: fhm459pv68ta********
          auto_delete: true
          disk_id: fhm459pv68ta********
        network_interfaces:
          - index: "0"
            mac_address: d0:0d:8a:e2:e8:5a
            subnet_id: e9b3vsm91fl7********
            primary_v4_address:
              address: 10.128.0.4
              one_to_one_nat:
                address: 158.160.47.82
                ip_version: IPV4
        fqdn: fhm8lon8b9a9********.auto.internal
        scheduling_policy: {}
        network_settings:
          type: STANDARD
        placement_policy: {}
        ```

- API

    Чтобы создать виртуальную машину, воспользуйтесь методом [create](../../compute/api-ref/Instance/create.md) для ресурса [Instance](../../compute/api-ref/Instance/index.md).

{% endlist %}

Аналогичным способом создайте еще две виртуальные машины — `target-instance-2` и `target-instance-3`. У последней укажите значение `false` для метки `target-for-stop`.

## Проверьте, что ВМ останавливаются по триггеру {#test}

Дождитесь, когда будут достигнуты пороговые значения, которые вы указали в бюджете. Убедитесь, что триггер для бюджетов запустил функцию и виртуальные машины `target-instance-1` и `target-instance-2` остановились.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../functions/operations/trigger/trigger-delete.md) триггер для бюджетов.
1. [Удалите](../../functions/operations/function/function-delete.md) функцию.
1. [Удалите](../../compute/operations/vm-control/vm-delete.md) виртуальные машины.
1. [Удалите](../../iam/operations/sa/delete.md) сервисный аккаунт.
