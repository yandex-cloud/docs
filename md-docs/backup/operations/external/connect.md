[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Backup](../../index.md) > [Пошаговые инструкции](../index.md) > Внешние ресурсы в Cloud Backup > Подключить внешний ресурс

# Подключить к Cloud Backup виртуальную машину или сервер, расположенные за пределами Yandex Cloud

С помощью сервиса Yandex Cloud Backup вы можете выполнять резервное копирование и восстановление из резервных копий виртуальных машин и серверов, расположенных в вашей собственной инфраструктуре или инфраструктуре стороннего провайдера.

Чтобы [подключить](../../concepts/vm-connection/external-resources.md) внешнюю ВМ или сервер к Cloud Backup, эти ресурсы должны работать под управлением одной из [поддерживаемых операционных систем](../../concepts/vm-connection/external-resources.md#supported-oss).

Для корректной работы [агента Cloud Backup](../../concepts/agent.md) ВМ должна соответствовать [минимальным требованиям](../../concepts/vm-connection/index.md#requirements).

Чтобы подключить внешнюю ВМ или сервер под управлением ОС семейства Linux Ubuntu к Cloud Backup:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно подключить внешний ресурс к Cloud Backup.
  1. [Перейдите](https://console.yandex.cloud/link/backup) в сервис **Cloud Backup**.
  1. На панели слева выберите ![resources](../../../_assets/console-icons/server.svg) **Подключённые ресурсы**.
  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/console-icons/plug-connection.svg) **Подключить внешний ресурс**.
  1. В открывшемся окне **Подключение внешнего ресурса**:

      1. В поле **Тип ресурса** выберите тип внешнего ресурса, который хотите подключить: **Внешняя виртуальная машина** или **Внешний сервер**.
      1. В поле **Политики резервного копирования** выберите одну или несколько [политик резервного копирования](../../concepts/policy.md), которые будут автоматически применены к внешнему ресурсу после установки агента. Политики также можно [привязать](../policy-vm/attach-and-detach-vm.md) позже.
      1. В блоке **Команда для установки агента Cloud Backup** скопируйте команду для установки агента Cloud Backup на внешний ресурс.

  1. Подключитесь к внешней ВМ или серверу и выполните скопированную команду с правами администратора.

      Результат:

      ```text
      ...
      Fetched instance id from file: cdgd246kiae3********
      fetched registration token: 802C-AE...
      installing agent with rain https://ru01-cloud.cyberprotect.ru (log: /var/log/baas-agent-installer/log.txt)
      Trying to register agent using RegisterAgent...
      Agent registered with id E6B1A5DC-ECE0-****-A9B8-AFD2********
      ```

  1. Убедитесь, что внешний ресурс подключен к Cloud Backup. Для этого на странице ![resources](../../../_assets/console-icons/server.svg) **Подключённые ресурсы** откройте вкладку **Внешние виртуальные машины** или **Внешние серверы** в зависимости от типа подключенного ресурса. Подключенный ресурс появится в списке.

- Yandex Cloud CLI {#cli}

  1. [Установите](../../../cli/quickstart.md#install) и [инициализируйте](../../../cli/quickstart.md#initialize) Yandex Cloud CLI.

      Вы можете установить Yandex Cloud CLI как непосредственно на ВМ или сервер, для которых хотите настроить резервное копирование, так и на любой другой компьютер.

      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      {% note warning %}

      Убедитесь, что [аккаунту](../../../iam/concepts/users/accounts.md), с помощью которого вы аутентифицировались при создании профиля Yandex Cloud CLI, назначена [роль](../../security/index.md#backup-user) `backup.user` или выше. При необходимости [назначьте](../../../iam/operations/roles/grant.md) вашему аккаунту нужную роль.

      {% endnote %}

  1. Получите код сценария, необходимого для установки агента Cloud Backup на внешний ресурс. Команда для получения кода зависит от типа ресурса, который вы хотите подключить к сервису:

      {% list tabs group=backup_resource_type %}

      - Виртуальная машина {#vm}

        ```bash
        yc backup agent install-external vm
        ```

        Результат:

        ```bash
        sudo apt-get update && sudo apt-get install -y jq gawk curl && curl https://storage.yandexcloud.net/backup-distributions/agent_installer_external_vm.sh | sudo bash -s -- --instance-registration-token="13d1d696-0ea4-****-93a9-f8c5********"
        ```

      - Сервер {#baremetal-server}

        ```bash
        yc backup agent install-external server
        ```

        Результат:

        ```bash
        sudo apt-get update && sudo apt-get install -y jq gawk curl && curl https://storage.yandexcloud.net/backup-distributions/agent_installer_external_server.sh | sudo bash -s -- --instance-registration-token="ed6991f2-f364-****-a08e-75a7********"
        ```

      {% endlist %}

  1. Выполните полученный на предыдущем шаге bash-сценарий:

      {% list tabs group=backup_resource_type %}

      - Виртуальная машина {#vm}

        ```bash
        sudo apt-get update && \
          sudo apt-get install -y jq gawk curl && \
          curl https://storage.yandexcloud.net/backup-distributions/agent_installer_external_vm.sh | sudo bash -s -- --instance-registration-token="13d1d696-0ea4-****-93a9-f8c5********"
        ```

      - Сервер {#baremetal-server}

        ```bash
        sudo apt-get update && \
          sudo apt-get install -y jq gawk curl && \
          curl https://storage.yandexcloud.net/backup-distributions/agent_installer_external_server.sh | sudo bash -s -- --instance-registration-token="ed6991f2-f364-****-a08e-75a7********"
        ```

      {% endlist %}

      Результат:

      ```text
      ...
      Fetched instance id from file: cdgd246kiae3********
      fetched registration token: 802C-AE...
      installing agent with rain https://ru01-cloud.cyberprotect.ru (log: /var/log/baas-agent-installer/log.txt)
      Trying to register agent using RegisterAgent...
      Agent registered with id E6B1A5DC-ECE0-****-A9B8-AFD2********
      ```

      В результате внешний ресурс будет привязан к Cloud Backup и получит идентификатор. В приведенном примере идентификатор ресурса — `cdgd246kiae3********`.
  1. Убедитесь, что внешний ресурс подключен к Cloud Backup, указав полученный на предыдущем шаге идентификатор:

      ```bash
      yc backup vm get <идентификатор_внешнего_ресурса_в_Cloud_Backup>
      ```

      Результат:

      ```text
      compute_instance_id: cdgd246kiae3********
      created_at: "2026-04-24T14:23:06.382900082Z"
      updated_at: "2026-04-29T19:48:22.013489248Z"
      enabled: true
      status: IDLE
      last_backup_time: "2026-04-27T13:07:05Z"
      next_backup_time: "2026-04-29T21:00:00Z"
      resource_id: d1fdd342-0ea8-****-9906-fa6c********
      is_active: true
      init_status: REGISTRED
      metadata: "null"
      type: EXTERNAL_VM
      agent_info:
        current_version: 18.0.38811
      ```

- API {#api}

  1. Получите команду для установки агента Cloud Backup на внешний ресурс. Для этого воспользуйтесь методом REST API [getAgentInstallCommand](../../backup/api-ref/Setup/getAgentInstallCommand.md) для ресурса [Setup](../../backup/api-ref/Setup/index.md) или вызовом gRPC API [SetupService/GetAgentInstallCommand](../../backup/api-ref/grpc/Setup/getAgentInstallCommand.md). В параметрах запроса укажите тип подключаемого ресурса (`EXTERNAL_VM` или `EXTERNAL_SERVER`).
  1. Подключитесь к внешней ВМ или серверу и выполните полученную команду с правами администратора.
  1. После установки агента внешний ресурс будет автоматически зарегистрирован в Cloud Backup. Чтобы получить список подключенных ресурсов, воспользуйтесь методом REST API [list](../../backup/api-ref/Resource/list.md) для ресурса [Resource](../../backup/api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/List](../../backup/api-ref/grpc/Resource/list.md).

{% endlist %}

Чтобы получить возможность создавать резервные копии подключенного внешнего ресурса в Cloud Backup и восстанавливать этот ресурс из резервных копий, привяжите ресурс к [политике резервного копирования](../../concepts/policy.md). Подробнее читайте в инструкции [Привязать защищаемый ресурс к политике резервного копирования](../policy-vm/attach-and-detach-vm.md).

#### Полезные ссылки {#see-also}

* [Подключение к Cloud Backup виртуальных машин и серверов, расположенных за пределами Yandex Cloud](../../concepts/vm-connection/external-resources.md)
* [Привязать защищаемый ресурс к политике резервного копирования](../policy-vm/attach-and-detach-vm.md)
* [Создать резервную копию защищаемого ресурса](../backup-vm/create.md)
* [Восстановить внешнюю виртуальную машину или сервер из резервной копии](recover.md)