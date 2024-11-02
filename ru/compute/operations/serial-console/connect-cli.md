# Подключение к серийной консоли виртуальной машины с помощью CLI

После [включения доступа](./index.md), вы можете подключиться к серийной консоли для взаимодействия с [ВМ](../../concepts/vm.md).

{% include [sc-warning](../../../_includes/compute/serial-console-warning.md) %}

## Подключиться к серийной консоли {#connect-to-serial-console}

{% note info %}

Работа серийной консоли зависит от настроек используемой операционной системы. Сервис {{ compute-name }} обеспечивает канал между пользователем и COM-портом ВМ и не гарантирует стабильность работы консоли со стороны ОС.

{% endnote %}

Чтобы подключиться к серийной консоли, используйте CLI.

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

Дальнейший порядок действий по подключению зависит от операционной системы и от того, включен ли для ВМ доступ по [{{ oslogin }}](../../../organization/concepts/os-login.md). Если для ВМ [включен](../vm-connect/enable-os-login.md) доступ по {{ oslogin }}, подключение к серийной консоли происходит с использованием короткоживущих SSH-сертификатов. Для подключения к ВМ с выключенным доступом по {{ oslogin }} используются [SSH-ключи](../../../glossary/ssh-keygen.md).

Некоторые ОС могут запрашивать данные пользователя для доступа на ВМ. Поэтому перед подключением к серийной консоли таких ВМ необходимо создать локальный пароль пользователя.

{% list tabs %}

- Linux c SSH-ключом

  1. Создайте локальный пароль пользователя на ВМ:
      1. [Подключитесь](../vm-connect/ssh.md) к ВМ по SSH.
      1. {% include [create-serial-console-user](../../../_includes/compute/create-serial-console-user.md) %}
      1. Отключитесь от ВМ. Для этого введите команду `logout`.

  1. Посмотрите описание команды CLI для подключения к серийной консоли:

      ```bash
      yc compute connect-to-serial-port --help
      ```

  1. Получите список ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Подключитесь к серийной консоли нужной ВМ:

      ```bash
      yc compute connect-to-serial-port \
        --instance-name <имя_ВМ> \
        --ssh-key ~/.ssh/id_ed25519
      ```

      Где:
      * `--instance-name` — обязательный параметр. Имя виртуальной машины.
          Вместо имени ВМ можно передать ее идентификатор в параметре `--instance-id`.

      * `--ssh-key` — опциональный параметр. Путь к закрытому ключу для [SSH-доступа](../../../glossary/ssh-keygen.md) к ВМ, например `~/.ssh/id_ed25519`. Если параметр не указан, будет сгенерирован SSH-ключ `yc_serialssh_key`.

      {% include [key-without-password-alert](../../../_includes/compute/key-without-password-alert.md) %}

      При подключении система может запросить логин и пароль для аутентификации на ВМ. Введите созданные ранее логин и пароль, после чего вы получите доступ к серийной консоли.

      Подробнее о команде `yc compute connect-to-serial-port` читайте в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/connect-to-serial-port.md).

- Linux по {{ oslogin }}

  1. Создайте локальный пароль пользователя на ВМ:
      1. [Подключитесь](../vm-connect/os-login.md) к ВМ по {{ oslogin }}.
      1. {% include [create-serial-console-user](../../../_includes/compute/create-serial-console-user.md) %}
      1. Отключитесь от ВМ. Для этого введите команду `logout`.

  1. Получите список ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. {% include [enable-os-login-serial-console-auth](../../../_includes/compute/enable-os-login-serial-console-auth.md) %}

  1. Посмотрите описание команды CLI для подключения к серийной консоли:

      ```bash
      yc compute connect-to-serial-port --help
      ```

  1. Подключитесь к серийной консоли нужной ВМ:

      ```bash
      yc compute connect-to-serial-port \
        --instance-name <имя_ВМ>
      ```

      Где `--instance-name` — обязательный параметр. Имя виртуальной машины. Вместо имени ВМ можно передать ее идентификатор в параметре `--instance-id`.

      При подключении система может запросить логин и пароль для аутентификации на ВМ. Введите созданные ранее логин и пароль, после чего вы получите доступ к серийной консоли.

      Подробнее о команде `yc compute connect-to-serial-port` читайте в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/connect-to-serial-port.md).

- Windows

  1. Посмотрите описание команды CLI для подключения к серийной консоли:

      ```bash
      yc compute connect-to-serial-port --help
      ```

  1. Получите список ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Подключитесь к SAC Windows нужной ВМ:

      ```bash
      yc compute connect-to-serial-port \
        --instance-name <имя_ВМ> \
        --port 2
      ```

      Где:
      * `--instance-name` — обязательный параметр. Имя виртуальной машины. Вместо имени ВМ можно передать ее идентификатор в параметре `--instance-id`.
      * `--port` — опциональный параметр. Номер порта для подключения к серийной консоли. При подключении к серийной консоли Windows (SAC) передайте значение `2`.

      По запросу системы введите логин, домен (имя ВМ) и пароль. Подробнее см. в разделе [Запустить командную оболочку в Windows SAC](./windows-sac.md).

      Подробнее о команде `yc compute connect-to-serial-port` читайте в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/connect-to-serial-port.md).

{% endlist %}

### Решение проблем {#troubleshooting}

* Если после подключения к серийной консоли на экране ничего не отображается:
  * Нажмите на клавиатуре клавишу **Enter**.
  * Перезапустите ВМ (для ВМ, созданных до 22 февраля 2019 года).

## Отключиться от серийной консоли {#turn-off-serial-console}

Чтобы отключиться от серийной консоли:
1. Нажмите на клавиатуре клавишу **Enter**.
1. Введите последовательно символы `~.`.