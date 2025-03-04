# Подключить сервер {{ baremetal-full-name }} к {{ backup-full-name }}

{% note info %}

{% include [baremetal-note](../../_includes/backup/baremetal-note.md) %}

{% endnote %}

В {{ backup-name }} вы можете настроить резервное копирование [серверов {{ baremetal-name }}](../../baremetal/concepts/servers.md).

Подробнее о работе с серверами см. на странице [Пошаговые инструкции для сервиса {{ baremetal-full-name }}](../../baremetal/operations/index.md).

Поддерживаются следующие операционные системы серверов: {#os-support}

{% include [baremetal-os-list](../../_includes/backup/baremetal-os-list.md) %}

Чтобы подключить сервер к {{ backup-name }}:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сервисный аккаунт](#prepare-service-account).
1. [Активируйте {{ backup-name }}](#activate-provider).
1. [Арендуйте тестовый сервер](#server-lease).
1. [Подключитесь к серверу](#server-connect).
1. [Установите агент {{ backup-name }}](#agent-install).
1. [Привяжите сервер к политике резервного копирования](#assign-policy).
1. [Запустите создание резервной копии](#execute-policy).
1. [Восстановите сервер из резервной копии](#server-recovery).

См. также [Как отказаться от аренды и удалить ресурсы](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

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

  1. Нажмите ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роли `backup.editor` и `baremetal.editor`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
  1. Выберите сервисный аккаунт, созданный ранее, нажав на строку с его именем.
  1. На верхней панели нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}**.
  1. Выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
  1. Выберите алгоритм шифрования и нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.action_download-keys-file }}** и нажмите **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_close }}**.

  Авторизованный ключ сервисного аккаунта понадобится в дальнейшем.

{% endlist %}

## Активируйте {{ backup-name }} {#activate-provider}

Чтобы активировать сервис, у вас должна быть _минимальная_ [роль](../../backup/security/index.md#backup-editor) `backup.editor` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите арендовать сервер и подключить его к {{ backup-name }}.

{% include [agent-send-data](../../_includes/backup/agent-send-data.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите арендовать сервер и подключить его к {{ backup-name }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Если сервис {{ backup-name }} еще не активирован, нажмите **{{ ui-key.yacloud.backup.button_action-activate }}**.

      Если кнопки **{{ ui-key.yacloud.backup.button_action-activate }}** нет, значит, сервис уже активирован. Переходите к следующему шагу.

- CLI {#cli}

  {% include [cli-activate-service](../../_includes/backup/operations/cli-activate-service.md) %}

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
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-server }}**.
  1. Выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-m`.
  1. Выберите пул `{{ region-id }}-m3`.
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-config }}**:

      1. Выберите конфигурацию сервера, например `BA-i203-S-10G`.
      1. Настройте разметку диска:

          1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.action_disk-layout-settings }}**.
          1. Оставьте разметку по умолчанию и нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

          {% note info %}

          Параметры разметки диска важны для дальнейшего восстановления сервера из резервной копии. Подробнее см. в подразделе [Восстановите сервер из резервной копии](#server-recovery).

          {% endnote %}

  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-product }}** выберите образ `Ubuntu 22.04 LTS`.
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-lease-conditions }}** укажите:

      1. **{{ ui-key.yacloud.baremetal.field_server-count }}** — `1`.
      1. **{{ ui-key.yacloud.baremetal.field_server-lease-duration }}** — `{{ ui-key.yacloud.baremetal.label_one-month-duration }}`.

  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-network-settings }}**:

      1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.baremetal.action-create-subnetwork }}**.
      1. (опционально) Если вам требуется включить DHCP для автоматического назначения IP-адресов, сделайте это в блоке **{{ ui-key.yacloud.baremetal.title_routing-settings }}**.
      1. Введите имя подсети `bm-subnetwork` и нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.
      1. В поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** выберите `{{ ui-key.yacloud.baremetal.label_public-ip-auto }}`.

          Чтобы [агент {{ backup-name }}](../../backup/concepts/agent.md) мог обмениваться данными с серверами [провайдера резервного копирования](../../backup/concepts/index.md#providers), на сервере должен быть обеспечен сетевой доступ к IP-адресам ресурсов сервиса {{ backup-name }} согласно таблице: {#ip-access}

          {% include [outgoing traffic](../../_includes/backup/outgoing-rules.md) %} 

  1. В блоке **{{ ui-key.yacloud.baremetal.title_server-access }}**:

      1. Сгенерируйте пароль для root-пользователя. Для этого напротив поля **{{ ui-key.yacloud.baremetal.field_password }}** нажмите кнопку **{{ ui-key.yacloud.component.password-input.label_button-generate }}**.

      {% note warning %}

      После заказа сервера пароль больше нигде нельзя посмотреть. Сразу сохраните пароль в надежном месте.

      {% endnote %}

      1. В поле **{{ ui-key.yacloud.baremetal.field_ssh-public-key }}** вставьте содержимое файла открытого ключа. Пару ключей для подключения по SSH необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.

  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-info }}** введите **{{ ui-key.yacloud.baremetal.field_name }}** сервера — `bm-server`.
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-server }}**.

{% endlist %}

Сохраните имя и идентификатор сервера, они понадобятся в дальнейшем.

Подробнее об аренде сервера см. в [документации {{ baremetal-name }}](../../baremetal/operations/servers/server-lease.md).

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

## Установите агент {{ backup-name }} {#agent-install}

1. Скопируйте на сервер файл с авторизованным ключом сервисного аккаунта, [созданным ранее](#prepare-service-account). Для этого _на локальной машине_ выполните команду:

    ```bash
    scp <путь_к_файлу_с_авторизованным_ключом_на_локальной_машине> \
    root@<публичный_IP-адрес_сервера>:<абсолютный_путь_к_каталогу_на_сервере>
    ```

1. Установите [{{ yandex-cloud }} CLI](../../cli/). Для этого _на сервере_ выполните команду:

    ```bash
    curl -sSL https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash
    ```

1. Установите утилиту [jq](https://jqlang.github.io/jq/):

    ```bash
    apt update && apt install -y jq
    ```

1. Аутентифицируйтесь в {{ yandex-cloud }} CLI от имени сервисного аккаунта:

    ```bash
    yc config set service-account-key <абсолютный_путь_к_авторизованному_ключу>
    ```

1. Получите [IAM-токен](../../iam/concepts/authorization/iam-token.md):

    ```bash
    yc iam create-token
    ```

1. Установите агент {{ backup-name }}, указав полученный ранее IAM-токен сервисного аккаунта:

    ```bash
    wget https://{{ s3-storage-host }}/backup-distributions/agent_installer_bms.sh && \
    sudo bash ./agent_installer_bms.sh \
      -t=<IAM-токен>
    ```

    Дождитесь сообщения о регистрации агента {{ backup-name }}:

    ```text
    ...
    Agent registered with id D9CA44FC-716A-4B3B-A702-C6**********
    ```

## Привяжите сервер к политике резервного копирования {#assign-policy}

Резервные копии создаются в {{ backup-name }} только в рамках [политик резервного копирования](../../backup/concepts/policy.md). По умолчанию серверы {{ baremetal-name }} не привязаны ни к одной политике.

Чтобы привязать сервер к политике резервного копирования:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите привязать сервер к политике.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. На панели слева выберите ![policies](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud_billing.backup.label_policies }}**.
  1. Выберите политику, к которой вы хотите привязать сервер.
  
      При необходимости [создайте](../../backup/operations/policy-vm/create.md) новую политику резервного копирования.
  1. В блоке **{{ ui-key.yacloud.backup.title_linked-recourses }}** нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.backup.button_attach-instance }}**.
  1. В открывшемся окне выберите вкладку **{{ ui-key.yacloud.backup.value_bms-recourses }}** и в списке серверов выберите нужный сервер.
  1. Нажмите кнопку **{{ ui-key.yacloud_billing.backup.button_attach-instance-submit }}**.

- CLI {#cli}

  1. Посмотрите описание команды CLI для привязки сервера {{ baremetal-name }} к политике: 

      ```bash
      yc backup policy apply --help
      ```

  1. Узнайте идентификатор политики, к которой вы хотите привязать сервер:

      {% include [get-policy-id](../../_includes/backup/operations/get-policy-id.md) %}

      При необходимости [создайте](../../backup/operations/policy-vm/create.md) новую политику резервного копирования.

  1. Узнайте идентификатор сервера, который нужно привязать. Для этого в [консоли управления]({{ link-console-main }}) в списке сервисов нужного [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**. Идентификаторы указаны в списке серверов в поле **{{ ui-key.yacloud.common.id }}**.

  1. Привяжите сервер к политике резервного копирования, указав ее идентификатор:

      ```bash
      yc backup policy apply <идентификатор_политики> \
        --instance-ids <идентификатор_сервера>
      ```

      Где `--instance-ids` — идентификатор привязываемого к политике сервера {{ baremetal-name }}.

  Подробнее о команде читайте в [справочнике CLI](../../cli/cli-ref/backup/cli-ref/policy/apply.md).

{% endlist %}

## Запустите создание резервной копии {#execute-policy}

Чтобы запустить создание резервной копии сервера {{ baremetal-name }} вне расписания политики резервного копирования:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится политика резервного копирования.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. На панели слева выберите ![bms](../../_assets/console-icons/objects-align-justify-horizontal.svg) **{{ ui-key.yacloud.backup.label_baremetal-instances }}**.
  1. В строке с нужным сервером нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.backup.action_start_backup }}**.
  1. В открывшемся окне выберите политику резервного копирования, в соответствии с которой будет создана резервная копия, и нажмите **{{ ui-key.yacloud.common.create }}**.

  Запустится процесс создания резервной копии сервера {{ baremetal-name }}. Прогресс создания копии будет отображаться в строке соответствующего сервера в поле **{{ ui-key.yacloud.backup.column_baremetal-instance-status }}**.

- CLI {#cli}

  Выполните команду, указав идентификаторы политики резервного копирования и сервера:

  ```bash
  yc backup policy execute \
    --id <идентификатор_политики> \
    --instance-id <идентификатор_сервера>
  ```

  Дождитесь завершения операции.

  Также вы можете выполнить команду в асинхронном режиме с помощью параметра `--async` и отслеживать процесс резервного копирования с помощью команды [yc backup resource list-tasks](../../cli/cli-ref/backup/cli-ref/vm/list-tasks.md).

{% endlist %}

## Восстановите сервер из резервной копии {#server-recovery}

{% include [vm-and-bms-backup-incompatibility](../../_includes/backup/vm-and-bms-backup-incompatibility.md) %}

Если вам нужно восстановить резервную копию с одного сервера на другой, или если на исходном сервере была переустановлена операционная система, заново [установите](#agent-install) агент {{ backup-name }} на этом сервере.

{% include [avoid-errors-when-restoring-from-backup.md](../../_includes/backup/avoid-errors-when-restoring-from-backup.md) %}

{% note tip %}

Если на сервере использовался RAID-массив, рекомендуется восстанавливать резервную копию на сервер с аналогичной конфигурацией разделов. Также рекомендуется устанавливать размеры разделов не меньше, чем на исходном сервере.

{% endnote %}

Чтобы восстановить сервер из резервной копии:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится резервная копия.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. На панели слева выберите ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.backup.label_backups }}** и откройте вкладку **{{ ui-key.yacloud.backup.value_bms-recourses }}**.
  1. В строке с резервной копией, из которой нужно восстановить сервер {{ baremetal-name }}, нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.backup.action_bms-recovery }}**.
  1. В открывшемся окне выберите сервер, из которого была создана выбранная резервная копия. В списке этот сервер будет отмечен как `({{ ui-key.yacloud.backup.context_current-bms }})`.
  1. Нажмите кнопку **{{ ui-key.yacloud.backup.action_recovery-start }}**.

  Будет запущен процесс восстановления сервера {{ baremetal-name }} из резервной копии — дождитесь его завершения.

- CLI {#cli}

  1. Получите список резервных копий сервера, указав его идентификатор:

      ```bash
      yc backup backup list \
        --instance-id <идентификатор_сервера>
      ```

      Сохраните идентификатор (`ID`) резервной копии.

  1. Восстановите сервер из резервной копии, указав их идентификаторы:

      ```bash
      yc backup backup recover \
        --destination-instance-id="<идентификатор_сервера>" \
        --source-backup-id="<идентификатор_резервной_копии>"
      ```

      Будет запущен процесс восстановления сервера {{ baremetal-name }} из резервной копии — дождитесь его завершения.

      Также вы можете выполнить команду в асинхронном режиме с помощью параметра `--async` и отслеживать процесс резервного копирования с помощью команды [yc backup resource list-tasks](../../cli/cli-ref/backup/cli-ref/vm/list-tasks.md).

      Подробнее о команде `yc backup backup recover` см. в [справочнике CLI](../../cli/cli-ref/backup/cli-ref/backup/recover.md).

{% endlist %}

{% include [non-native-bms-restore-connectivity-loss](../../_includes/backup/operations/non-native-bms-restore-connectivity-loss.md) %}

## Как отказаться от аренды и удалить ресурсы {#clear-out}

1. [Откажитесь](../../baremetal/operations/servers/server-lease-cancel.md) от аренды сервера {{ baremetal-name }}.
1. [Удалите](../../backup/operations/backup-vm/delete.md) резервную копию в {{ backup-name }} с помощью CLI.