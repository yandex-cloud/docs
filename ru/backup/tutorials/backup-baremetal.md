# Подключить сервер {{ baremetal-full-name }} к {{ backup-full-name }}

В {{ backup-name }} вы можете настроить резервное копирование [серверов {{ baremetal-name }}](../../baremetal/concepts/servers.md).

_Сервис {{ baremetal-name }} и функциональность резервного копирования серверов будут запущены в [стадии Preview](../../overview/concepts/launch-stages.md) в 4 квартале 2024 года._

Поддерживаются следующие операционные системы серверов: {#os-support}
* Ubuntu 22.04 LTS;
* Ubuntu 20.04 LTS;
* Ubuntu 18.04 LTS;
* Ubuntu 16.04 LTS.

Чтобы подключить сервер к {{ backup-full-name }}:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сервисный аккаунт](#prepare-service-account).
1. [Активируйте {{ backup-name }}](#activate-provider).
1. [Арендуйте тестовый сервер](#server-lease).
1. [Подключитесь к серверу](#server-connect).
1. [Установите агент резервного копирования](#agent-install).
1. [Привяжите сервер к политике резервного копирования](#add-policy).
1. [Запустите создание резервной копии](#execute-policy).
1. [Восстановите сервер из резервной копии](#server-recovery).

См. также [Как отказаться от аренды и удалить ресурсы](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

{% include [include](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

### Необходимые платные ресурсы {#paid-resources}

Сейчас сервис {{ baremetal-name }} и функциональность резервного копирования серверов не тарифицируются.

## Создайте сервисный аккаунт {#prepare-service-account}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите арендовать сервер {{ baremetal-name }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md). Требования к формату имени:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Нажмите ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите [роль](../security/index.md#backup-editor) `backup.editor`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
  1. Выберите сервисный аккаунт, созданный ранее, нажав на строку с его именем.
  1. На верхней панели нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}**.
  1. Выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
  1. Выберите алгоритм шифрования и нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.action_download-keys-file }}** и нажмите **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_close }}**.

  Авторизованный ключ сервисного аккаунта понадобится в дальнейшем.

{% endlist %}

## Активируйте {{ backup-name }} {#activate-provider}

Чтобы активировать сервис, у вас должна быть _минимальная_ [роль](../security/index.md#backup-editor) `backup.editor` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите арендовать сервер и подключить его к {{ backup-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите арендовать сервер и подключить его к {{ backup-name }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Если сервис {{ backup-name }} еще не активирован, нажмите **{{ ui-key.yacloud.backup.button_action-activate }}**.

      Если кнопки **{{ ui-key.yacloud.backup.button_action-activate }}** нет, значит, сервис уже активирован. Переходите к следующему шагу.

{% endlist %}

После активации автоматически создаются следующие политики резервного копирования:
* `Default daily` — ежедневное создание инкрементальной копии с сохранением последних 15 копий.
* `Default weekly` — еженедельное создание инкрементальной копии с сохранением последних 15 копий.
* `Default monthly` — ежемесячное создание инкрементальной копии с сохранением последних 15 копий.

## Арендуйте тестовый сервер {#server-lease}

Если у вас уже арендован сервер с [подходящей ОС](#os-support), перейдите к шагу [Подключитесь к серверу](#server-connect). Обратите внимание на необходимые [сетевые разрешения](#ip-access) на сервере.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите арендовать сервер.
  1. В списке сервисов выберите **{{ baremetal-name }}**.
  1. Нажмите кнопку **Заказать сервер**.
  1. Выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-m`.
  1. Выберите пул `{{ region-id }}-m3`.
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-config }}**:
  
      1. Выберите конфигурацию сервера `BA-i103-S-10G`.
      1. Настройте разметку диска:

          1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.action_disk-layout-settings }}**.
          1. Оставьте разметку по умолчанию и нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
  
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-product }}** выберите образ `Ubuntu 22.04 LTS`.
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-lease-conditions }}** укажите:

      1. **{{ ui-key.yacloud.baremetal.field_server-count }}** — `1`.
      1. **{{ ui-key.yacloud.baremetal.field_server-lease-duration }}** — `{{ ui-key.yacloud.baremetal.label_one-month-duration }}`.
  
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-network-settings }}**:

      1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.baremetal.action-create-subnetwork }}**.
      1. (опционально) Если вам требуется включить DHCP для автоматического назначения IP-адресов, сделайте это в блоке **Настройки для маршрутизации**.
      1. Введите имя подсети `bm-subnetwork` и нажмите кнопку **Создать подсеть**.
      1. В поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** выберите `{{ ui-key.yacloud.baremetal.label_public-ip-auto }}`.

          Чтобы агент {{ backup-name }} мог обмениваться данными с серверами [провайдера резервного копирования](../concepts/index.md#providers), на сервере должен быть обеспечен сетевой доступ к IP-адресам ресурсов сервиса {{ backup-name }} согласно таблице: {#ip-access}

          {% include [outgoing traffic](../../_includes/backup/outgoing-rules.md) %} 

  1. В блоке **{{ ui-key.yacloud.baremetal.title_server-access }}**:

      1. Сгенерируйте пароль для root-пользователя. Для этого напротив поля **{{ ui-key.yacloud.baremetal.field_password }}** нажмите кнопку **Сгенерировать**. 

      {% note warning %}

      После заказа сервера пароль больше нигде нельзя посмотреть. Сразу сохраните пароль в надежном месте.

      {% endnote %}

      1. В поле **{{ ui-key.yacloud.baremetal.field_ssh-public-key }}** вставьте содержимое файла открытого ключа. Пару ключей для подключения по SSH необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.

  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-info }}** введите **{{ ui-key.yacloud.baremetal.field_name }}** сервера — `bm-server`.
  1. Нажмите кнопку **Заказать сервер**.

{% endlist %}

Сохраните имя и идентификатор сервера, они понадобятся в дальнейшем.

## Подключитесь к серверу {#server-connect}

{% list tabs group=operating_system %}

- KVM-консоль {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит сервер.
  1. В списке сервисов выберите **{{ baremetal-name }}**.
  1. В строке с нужным сервером нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Запустить KVM-консоль**.
  1. В открывшемся окне нажмите кнопку **KVM-консоль**.

- Linux/macOS {#linux-macos}

  Для подключения к серверу необходимо указать его публичный IP-адрес, который можно узнать в консоли управления, в поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** блока **{{ ui-key.yacloud.baremetal.title_section-server-network-settings }}** на странице сервера.

  1. В терминале выполните команду:

      ```bash
      ssh root@<публичный_IP-адрес_сервера>
      ```

      При первом подключении к серверу появится предупреждение о неизвестном хосте:

      ```text
      The authenticity of host '51.250.83.243 (51.250.83.243)' can't be established.
      ED25519 key fingerprint is SHA256:6Mjv93NJDCaf/vu3NYwiLQK4tKI+4cfLtkd********.
      This key is not known by any other names.
      Are you sure you want to continue connecting (yes/no/[fingerprint])?
      ```

  1. Введите в терминале слово `yes` и нажмите **Enter**.
  1. Введите пароль, который вы указали при создании сервера, и нажмите **Enter**.

- Windows 10/11 {#windows}

  Для подключения к серверу необходимо указать его публичный IP-адрес, который можно узнать в консоли управления, в поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** блока **{{ ui-key.yacloud.baremetal.title_section-server-network-settings }}** на странице сервера.
  
  Убедитесь, что учетная запись Windows обладает правами на чтение файлов в папке с ключами.

  1. Для подключения к серверу в командной строке выполните команду:

      ```shell
      ssh root@<публичный_IP-адрес_сервера>
      ```

      При первом подключении к серверу появится предупреждение о неизвестном хосте:

      ```text
      The authenticity of host '89.169.132.223 (89.169.132.223)' can't be established.
      ECDSA key fingerprint is SHA256:DfjfFB+in0q0MGi0HnqLNMdHssLfm1yRanB********.
      Are you sure you want to continue connecting (yes/no/[fingerprint])?
      ```

  1. Введите в терминале слово `yes` и нажмите **Enter**.
  1. Введите пароль, который вы указали при создании сервера, и нажмите **Enter**.

{% endlist %}

## Установите агент резервного копирования {#agent-install}

1. Скопируйте на сервер файл с авторизованным ключом сервисного аккаунта, [созданным ранее](#prepare-service-account). Для этого _на локальной машине_ выполните команду:

    ```bash
    scp <путь_к_файлу_с_авторизованным_ключом_на_локальной_машине> \
    root@<публичный_IP-адрес_сервера>:<абсолютный_путь_к_каталогу_на_сервере>
    ```

1. Установите [{{ yandex-cloud }} CLI](../../cli/). Для этого _на сервере_ выполните команду:

    ```bash
    curl -sSL https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash
    ```

1. Аутентифицируйтесь в {{ yandex-cloud }} CLI от имени сервисного аккаунта:

    ```bash
    yc config set service-account-key <абсолютный_путь_к_авторизованному_ключу>
    ```

1. Получите IAM-токен:

    ```bash
    yc iam create-token
    ```

1. Установите утилиту [jq](https://jqlang.github.io/jq/):

    ```bash
    apt update && apt install -y jq
    ```

1. Установите агент резервного копирования:

    ```bash
    wget https://{{ s3-storage-host }}/backup-distributions/agent_installer_bms.sh && \
    bash agent_installer_bms.sh \
      -i "`<идентификатор_сервера>`-`date +%s`" \
      -n "`<имя_сервера>`-`date +%Y%m%d.%H%M%S`" \
      -t "`<IAM-токен>`"
    ```

    Дождитесь сообщения о регистрации агента:

    ```text
    ...
    Agent registered with id D9CA44FC-716A-4B3B-A702-C6**********
    ```

## Привяжите сервер к политике резервного копирования {#add-policy}

1. Получите список ресурсов, подключенных к {{ backup-name }}, для этого _на локальной машине_ выполните команду:

    ```bash
    yc backup resource list
    ```

    Сервер, подключенный к {{ backup-name }}, будет отображаться с типом (`TYPE`) `BMS`.
    
    Сохраните идентификатор (`INSTANCE ID`) сервера.

1. Получите список политик резервного копирования:

    ```bash
    yc backup policy list
    ```

    Сохраните идентификатор политики (`ID`), которую вы хотите привязать к серверу.

1. Привяжите сервер к политике резервного копирования:

    ```bash
    yc backup policy apply \
      --id <идентификатор_политики> \
      --instance-ids="<идентификатор_сервера>"
    ```

## Запустите создание резервной копии {#execute-policy}

Чтобы запустить создание резервной копии вне расписания политики резервного копирования, выполните команду:

```bash
yc backup policy execute \
  --id <идентификатор_политики> \
  --instance-id <идентификатор_сервера>
```

Дождитесь завершения операции.

Также вы можете выполнить команду в асинхронном режиме с помощью параметра `--async` и отслеживать процесс резервного копирования с помощью команды [yc backup resource list-tasks](../../cli/cli-ref/managed-services/backup/vm/list-tasks.md).

## Восстановите сервер из резервной копии {#server-recovery}

1. Получите список резервных копий сервера:

    ```bash
    yc backup backup list \
      --instance-id <идентификатор_сервера>
    ```

    Сохраните идентификатор (`ID`) резервной копии.

1. Восстановите сервер из резервной копии:

    ```bash
    yc backup backup recover \
      --source-backup-id="<идентификатор_резервной_копии>" \
      --destination-instance-id="<идентификатор_сервера>"
    ```

    Дождитесь завершения операции.

    Также вы можете выполнить команду в асинхронном режиме с помощью параметра `--async` и отслеживать процесс резервного копирования с помощью команды [yc backup resource list-tasks](../../cli/cli-ref/managed-services/backup/vm/list-tasks.md).

## Как отказаться от аренды и удалить ресурсы {#clear-out}

1. [Откажитесь](../../baremetal/operations/servers/server-lease-cancel.md) от аренды сервера {{ baremetal-name }}.
1. [Удалите](../operations/backup-vm/delete.md) резервную копию в {{ backup-name }} с помощью CLI.
