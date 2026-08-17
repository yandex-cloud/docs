---
title: Как подключить внешний ресурс к {{ backup-full-name }}
description: Следуя данной инструкции, вы сможете подключить к {{ backup-full-name }} виртуальную машину или сервер, расположенные за пределами {{ yandex-cloud }}.
---

# Подключить к {{ backup-name }} виртуальную машину или сервер, расположенные за пределами {{ yandex-cloud }}


С помощью сервиса {{ backup-full-name }} вы можете выполнять резервное копирование и восстановление из резервных копий виртуальных машин и серверов, расположенных в вашей собственной инфраструктуре или инфраструктуре стороннего провайдера.

Чтобы [подключить](../../concepts/vm-connection/external-resources.md) внешнюю ВМ или сервер к {{ backup-name }}, эти ресурсы должны работать под управлением одной из [поддерживаемых операционных систем](../../concepts/vm-connection/external-resources.md#supported-oss).

{% include [requirements](../../../_includes/backup/requirements.md) %}

Чтобы подключить внешнюю ВМ или сервер под управлением ОС семейства Linux Ubuntu к {{ backup-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно подключить внешний ресурс к {{ backup-name }}.
  1. [Перейдите]({{ link-console-main }}/link/backup) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. На панели слева выберите ![resources](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.backup.label_connected-resources }}**.
  1. На панели сверху нажмите кнопку ![image](../../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.backup.button_connect-external-resource }}**.
  1. В открывшемся окне **{{ ui-key.yacloud.backup.dialog_connect-external-resource_title }}**:

      1. В поле **{{ ui-key.yacloud.backup.field_connect-external-resource_resource-type }}** выберите тип внешнего ресурса, который хотите подключить: **{{ ui-key.yacloud.backup.value_external-vm }}** или **{{ ui-key.yacloud.backup.value_external-server }}**.
      1. В поле **{{ ui-key.yacloud.backup.field_connect-external-resource_policies }}** выберите одну или несколько [политик резервного копирования](../../concepts/policy.md), которые будут автоматически применены к внешнему ресурсу после установки агента. Политики также можно [привязать](../policy-vm/attach-and-detach-vm.md) позже.
      1. В блоке **{{ ui-key.yacloud.backup.section_connect-external-resource_command }}** скопируйте команду для установки агента {{ backup-name }} на внешний ресурс.

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

  1. Убедитесь, что внешний ресурс подключен к {{ backup-name }}. Для этого на странице ![resources](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.backup.label_connected-resources }}** откройте вкладку **{{ ui-key.yacloud.backup.label_external-vm-instances }}** или **{{ ui-key.yacloud.backup.label_external-server-instances }}** в зависимости от типа подключенного ресурса. Подключенный ресурс появится в списке.

- {{ yandex-cloud }} CLI {#cli}

  1. [Установите](../../../cli/quickstart.md#install) и [инициализируйте](../../../cli/quickstart.md#initialize) {{ yandex-cloud }} CLI.

      Вы можете установить {{ yandex-cloud }} CLI как непосредственно на ВМ или сервер, для которых хотите настроить резервное копирование, так и на любой другой компьютер.

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      {% note warning %}

      Убедитесь, что [аккаунту](../../../iam/concepts/users/accounts.md), с помощью которого вы аутентифицировались при создании профиля {{ yandex-cloud }} CLI, назначена [роль](../../security/index.md#backup-user) `backup.user` или выше. При необходимости [назначьте](../../../iam/operations/roles/grant.md) вашему аккаунту нужную роль.

      {% endnote %}

  1. Получите код сценария, необходимого для установки агента {{ backup-name }} на внешний ресурс. Команда для получения кода зависит от типа ресурса, который вы хотите подключить к сервису:

      {% list tabs group=backup_resource_type %}

      - Виртуальная машина {#vm}

        ```bash
        yc backup agent install-external vm
        ```

        Результат:

        ```bash
        sudo apt-get update && sudo apt-get install -y jq gawk curl && curl https://{{ s3-storage-host-ru }}/backup-distributions/agent_installer_external_vm.sh | sudo bash -s -- --instance-registration-token="13d1d696-0ea4-****-93a9-f8c5********"
        ```

      - Сервер {#baremetal-server}

        ```bash
        yc backup agent install-external server
        ```

        Результат:

        ```bash
        sudo apt-get update && sudo apt-get install -y jq gawk curl && curl https://{{ s3-storage-host-ru }}/backup-distributions/agent_installer_external_server.sh | sudo bash -s -- --instance-registration-token="ed6991f2-f364-****-a08e-75a7********"
        ```

      {% endlist %}

  1. Выполните полученный на предыдущем шаге bash-сценарий:

      {% list tabs group=backup_resource_type %}

      - Виртуальная машина {#vm}

        ```bash
        sudo apt-get update && \
          sudo apt-get install -y jq gawk curl && \
          curl https://{{ s3-storage-host-ru }}/backup-distributions/agent_installer_external_vm.sh | sudo bash -s -- --instance-registration-token="13d1d696-0ea4-****-93a9-f8c5********"
        ```

      - Сервер {#baremetal-server}

        ```bash
        sudo apt-get update && \
          sudo apt-get install -y jq gawk curl && \
          curl https://{{ s3-storage-host-ru }}/backup-distributions/agent_installer_external_server.sh | sudo bash -s -- --instance-registration-token="ed6991f2-f364-****-a08e-75a7********"
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

      В результате внешний ресурс будет привязан к {{ backup-name }} и получит идентификатор. В приведенном примере идентификатор ресурса — `cdgd246kiae3********`.
  1. Убедитесь, что внешний ресурс подключен к {{ backup-name }}, указав полученный на предыдущем шаге идентификатор:

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

  1. Получите команду для установки агента {{ backup-name }} на внешний ресурс. Для этого воспользуйтесь методом REST API [getAgentInstallCommand](../../backup/api-ref/Setup/getAgentInstallCommand.md) для ресурса [Setup](../../backup/api-ref/Setup/index.md) или вызовом gRPC API [SetupService/GetAgentInstallCommand](../../backup/api-ref/grpc/Setup/getAgentInstallCommand.md). В параметрах запроса укажите тип подключаемого ресурса (`EXTERNAL_VM` или `EXTERNAL_SERVER`).
  1. Подключитесь к внешней ВМ или серверу и выполните полученную команду с правами администратора.
  1. После установки агента внешний ресурс будет автоматически зарегистрирован в {{ backup-name }}. Чтобы получить список подключенных ресурсов, воспользуйтесь методом REST API [list](../../backup/api-ref/Resource/list.md) для ресурса [Resource](../../backup/api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/List](../../backup/api-ref/grpc/Resource/list.md).

{% endlist %}

Чтобы получить возможность создавать резервные копии подключенного внешнего ресурса в {{ backup-name }} и восстанавливать этот ресурс из резервных копий, привяжите ресурс к [политике резервного копирования](../../concepts/policy.md). Подробнее читайте в инструкции [{#T}](../policy-vm/attach-and-detach-vm.md).

#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/vm-connection/external-resources.md)
* [{#T}](../policy-vm/attach-and-detach-vm.md)
* [{#T}](../backup-vm/create.md)
* [{#T}](./recover.md)
