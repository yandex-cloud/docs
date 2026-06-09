# Синхронизировать пользователей и группы с {{ microsoft-idp.ad-full }}


{% note info %}

Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

Если для управления пользователями ваша компания использует [{{ microsoft-idp.ad-full }}](https://docs.microsoft.com/ru-ru/windows-server/identity/ad-ds/active-directory-domain-services) и вы хотите организовать для ваших пользователей доступ к {{ yandex-cloud }}, вам не нужно вручную создавать в {{ yandex-cloud }} учетные записи для ваших пользователей. Вместо этого вы можете настроить [синхронизацию](../concepts/ad-sync.md) с {{ org-full-name }} пользователей и групп, созданных в вашем каталоге {{ microsoft-idp.ad-short }}.

## Подготовьте к синхронизации организацию {{ org-full-name }} {#prepare-org}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud).
1. [Создайте](user-pools/create-userpool.md) пул пользователей в {{ org-full-name }} и [привяжите](user-pools/add-domain.md#userpool) к нему [домен](../concepts/domains.md), идентичный домену, который используется на [контроллере домена](https://ru.wikipedia.org/wiki/Контроллер_домена) {{ microsoft-idp.ad-short }}.

    Привязывать ваш собственный домен к [пулу пользователей](../concepts/user-pools.md) не обязательно. Вместо этого вы можете привязать другой домен или выбрать домен по умолчанию. Но в этом случае в конфигурации [агента синхронизации](../concepts/ad-sync.md#sync-agent) потребуется настроить подстановку домена в параметре `replacement_domain`. Подробнее см. в разделе [{#T}](../concepts/ad-sync.md#agent-config).
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) ему следующие роли на [организацию](../concepts/organization.md), в которой находится нужный пул пользователей:

    * [`organization-manager.userpools.syncAgent`](../security/index.md#organization-manager-userpools-syncAgent);
    * [`organization-manager.groups.viewer`](../security/index.md#organization-manager-groups-viewer);
    * [`organization-manager.groups.externalCreator`](../security/index.md#organization-manager-groups-externalCreator);
    * [`organization-manager.groups.externalConverter`](../security/index.md#organization-manager-groups-externalConverter).
    
    Если вы планируете выгружать логи работы агента синхронизации в [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }}, дополнительно назначьте сервисному аккаунту [роль](../../logging/security/index.md#logging-writer) `logging.writer` на соответствующую лог-группу или [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором она расположена.
1. (Опционально) [Создайте](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) и сохраните [авторизованный ключ](../../iam/concepts/authorization/key.md) для вашего [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

    {% note warning %}
    
    Авторизованный ключ не нужен, если агент синхронизации устанавливается на [виртуальную машину](../../compute/concepts/vm.md) {{ compute-full-name }}, к которой подключен сервисный аккаунт с необходимыми правами доступа.
    
    {% endnote %}

## Подготовьте контроллер домена {{ microsoft-idp.ad-short }} {#dc-setup}

1. Создайте пользователя домена, от имени которого агент будет выполнять синхронизацию.
1. Выдайте этому пользователю следующие разрешения:

    * `Replicating Directory Changes`;
    * `Replicating Directory Changes All`.
1. На контроллере домена откройте сетевые порты для входящего трафика, поступающего с IP-адреса сервера, на котором установлен агент {{ ad-sync-agent }}:

    * `389 (TCP)` — для [LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/);
    * `636 (TCP)` — для [LDAPS](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/enable-ldap-over-ssl-3rd-certification-authority);
    * `135 (TCP)` — для [MSRPC](https://learn.microsoft.com/en-us/windows/win32/rpc/rpc-start-page);
    * `49152:65535 (TCP)` — диапазон портов для MSRPC dynamic;
    * `53 (TCP/UDP)` и `88 (TCP/UDP)` — для [Kerberos](https://ru.wikipedia.org/wiki/Kerberos).

1. (Опционально) Если вы планируете настраивать аутентификацию с использованием протокола [Kerberos](https://ru.wikipedia.org/wiki/Kerberos), настройте [SPN](https://learn.microsoft.com/en-us/windows/win32/ad/service-principal-names).

## Настройте и запустите агент синхронизации {#setup-agent}

Вы можете установить [агент](../concepts/ad-sync.md#sync-agent) синхронизации на любой сервер под управлением ОС [Linux](https://ru.wikipedia.org/wiki/Linux) или [Windows](https://ru.wikipedia.org/wiki/Windows).

Если вы устанавливаете агент синхронизации на [виртуальную машину](../../compute/concepts/vm.md) {{ compute-full-name }}, [подключите](../../compute/operations/vm-control/vm-connect-sa.md) к этой виртуальной машине созданный [ранее](#prepare-org) сервисный аккаунт.

Прежде, чем приступать к синхронизации, откройте на сервере, где вы будете запускать агент, следующие сетевые порты для входящего и исходящего сетевого трафика:

* Для обращения к API {{ yandex-cloud }}:

    * `443` — для [HTTPS](https://ru.wikipedia.org/wiki/HTTPS);

* Для обращения к контроллеру домена {{ microsoft-idp.ad-short }}:

    * `389 (TCP)` — для [LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/);
    * `636 (TCP)` — для [LDAPS](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/enable-ldap-over-ssl-3rd-certification-authority);
    * `135 (TCP)` — для [MSRPC](https://learn.microsoft.com/en-us/windows/win32/rpc/rpc-start-page);
    * `49152:65535 (TCP)` — диапазон портов для MSRPC dynamic;
    * `53 (TCP/UDP)` и `88 (TCP/UDP)` — для [Kerberos](https://ru.wikipedia.org/wiki/Kerberos).

Если для аутентификации на стороне {{ microsoft-idp.ad-short }} вы планируете использовать протокол [Kerberos](https://ru.wikipedia.org/wiki/Kerberos), самостоятельно установите на сервер компоненты, необходимые для работы этого протокола, и создайте файл `keytab` с ключами шифрования.

{% note info %}

Использование протокола Kerberos в настоящий момент возможно только при установке агента синхронизации на сервер с ОС Linux.

{% endnote %}

Чтобы запустить синхронизацию пользователей и групп:

{% list tabs group=operating_system %}

- Linux {#linux}

  В терминале Linux:

  1. Чтобы установить агент {{ ad-sync-agent }}, выполните команду:

      ```bash
      curl {{ ad-sync-agent-linuxlink }} | bash
      ```

      Результат:

      ```text
      Example config file downloaded to /etc/yc-identityhub-sync-agent/config.yaml. Modify it with your values
      Service installed as yc-identityhub-sync-agent
      To start the service: sudo systemctl start yc-identityhub-sync-agent
      To enable the service to start on boot: sudo systemctl enable yc-identityhub-sync-agent
      To check service status: sudo systemctl status yc-identityhub-sync-agent
      yc-identityhub-sync-agent is installed to /usr/bin/yc-identityhub-sync-agent
      ```
  1. (Опционально) Если для аутентификации агента в API {{ yandex-cloud }} вы будете использовать авторизованный ключ сервисного аккаунта, скопируйте на ваш сервер файл с сохраненным ранее авторизованным ключом.

      Для этого вы можете воспользоваться командой `scp` или любым другим подходящим инструментом.
  1. В любом текстовом редакторе откройте [YAML](https://yaml.org/)-файл с конфигурацией агента синхронизации. В примере ниже используется редактор `nano`:

      ```bash
      nano /etc/yc-identityhub-sync-agent/config.yaml
      ```
  1. В открывшемся файле задайте конфигурацию агента синхронизации. Конфигурация зависит от типа аутентификации, используемого агентом на стороне {{ microsoft-idp.ad-short }}, и задается в [YAML](https://yaml.org/)-файле в следующем формате:

      {% list tabs group=authentication %}

      - Аутентификация по логину и паролю {#password}

        ```yml
        # Default configuration for yc-identityhub-sync-agent
        # This is a template - please update with your actual values
        
        userpool_id: "<идентификатор_пула_пользователей>"
        replication_tokens_path: "<путь_к_директории_с_токенами_процессов>"
        working_directory: "<путь_к_рабочей_директории_агента>"
        
        # {{ yandex-cloud }} authentication settings
        
        # Use the cloud_credentials_file_path parameter for authentication via an authorized key.
        # If you want the agent to authenticate via IAM tokens, remove the cloud_credentials_file_path line.
        cloud_credentials_file_path: "<путь_к_файлу_с_авторизованным_ключом>"
        
        # Enable the use_metadata_service parameter for authentication via IAM tokens
        # (only available when the agent is installed on a {{ compute-name }} VM).
        # If `true`, the cloud_credentials_file_path parameter will be ignored.
        use_metadata_service: true|false
        
        # Enable the Dry Run mode.
        # If `true`, no changes will be applied to users or groups in {{ org-full-name }}.
        # Instead, all pending operations will be saved to the current log file location.
        dry_run:
          enabled: true|false
        
        # Active Directory replication API client settings
        drsr:
          host: "<адрес_контроллера_домена>"
          username: "username"
          password: "password"
        
        # LDAP client settings
        ldap:
          host: "ldaps://<адрес_контроллера_домена>:636"
          username: "<имя_пользователя_Active_Directory>"
          password: "<пароль_пользователя_Active_Directory>"
          certificate_path: "<путь_к_сертификату>"
          insecure_skip_verify: false|true
        
        # Logger configuration
        logger:
          level: "<уровень_логирования>"
          format: "plain|json"
          file:
            filename: "<путь_к_файлу_с_логами>"
            maxsize: 30
            maxbackups: 10
          cloud_logger:
            log_group_id: <идентификатор_лог-группы>
        
        # Sync settings
        sync_settings:
          interval: "600s"
          allow_to_capture_users: true|false
          allow_to_capture_groups: true|false
          # Remove the replacement_domain line if you don't need to replace domain
          replacement_domain: "<домен_пула_пользователей>"
          # Remove the user_attribute_mapping section if you don't need to remap default user attribute names
          # If you need remapping, the user_attribute_mapping section should only contain the attributes you need to remap
          user_attribute_mapping:
            # The following syntax allows to reconfigure the default mapping ('displayName' --> 'full_name')
            # to custom mapping ('CustomAttributeName' --> 'full_name')
            - source: "CustomAttributeName"
              target: "FullName"
              type: "direct"
            # The following syntax allows to disable synchronization for attribute 'given_name'
            - source: ""
              target: "GivenName"
              type: "empty"
          # Remove the group_attribute_mapping section if you don't need to remap default group attribute names
          # If you need remapping, the group_attribute_mapping section should only contain the attributes you need to remap
          group_attribute_mapping:
            # The following syntax allows to reconfigure the default mapping ('name' --> 'name')
            # to custom mapping ('CustomAttributeName' --> 'name')
            - source: "CustomAttributeName"
              target: "Name"
              type: "direct"
            # The following syntax allows to disable synchronization for attribute 'description'
            - source: ""
              target: "Description"
              type: "empty"
          filter:
            domain: "<имя_домена_в_Active_Directory>"
            organization_units:
              - OU=IdPUsersOU,DC=example,DC=com
              - OU=IdPGroupsOU,DC=example,DC=com
            groups:
              - "GroupName1"
              - "GroupName2"
          remove_user_behavior: "remove|block"
        ```

        Где:

        * `userpool_id` — идентификатор [пула пользователей](../concepts/user-pools.md) в {{ org-full-name }}.
        * `replication_tokens_path` — путь к директории, в которой сохраняются токены с информацией о текущем прогрессе процессов [полной синхронизации](../concepts/ad-sync.md#full-sync). Необязательный параметр.
        
            Если параметр не задан, токены сохраняются в рабочей директории агента, указанной в параметре `working_directory`, или, если рабочая директория не задана, — в директории, в которой расположен исполняемый файл агента.
        * `working_directory` — путь к директории, в которой сохраняются другие файлы, необходимые агенту для работы. Необязательный параметр.
        
            Если параметр не задан, в качестве рабочей директории используется директория, в которой расположен исполняемый файл агента. По умолчанию исполняемый файл агента располагается в следующих директориях:
        
            * `/etc/yc-identityhub-sync-agent/` (для Linux);
            * `C:\\ProgramData\\YcIdentityHubSyncAgent\\` (для Windows).
        
        * `cloud_credentials_file_path` — путь к файлу, содержащему [авторизованный ключ](../../iam/concepts/authorization/key.md) сервисного аккаунта в {{ yandex-cloud }}. Необязательный параметр: используется только при аутентификации агента в API {{ yandex-cloud }} с помощью авторизованного ключа.
        
            Примеры значений:
        
            * `/etc/yc-identityhub-sync-agent/authorized_key.json` (для Linux);
            * `C:\\ProgramData\\YcIdentityHubSyncAgent\\authorized_key.json` (для Windows).
        
            В параметре `cloud_credentials_file_path` вместо полного пути вы можете передать только имя файла. В этом случае файл будет сохранен в рабочей директории, заданной в параметре `working_directory`, или, если рабочая директория не задана, — в директории, в которой расположен исполняемый файл агента.
        
            {% note info %}
        
            Если в параметрах `cloud_credentials_file_path`, `replication_tokens_path` и/или `logger.file.filename` заданы пути, отличные от пути, заданного в параметре `working_directory`, для выбранных сущностей будут использоваться пути, указанные в параметрах `cloud_credentials_file_path`, `replication_tokens_path` и/или `logger.file.filename`.
        
            {% endnote %}
        
        * `use_metadata_service` — параметр, управляющий аутентификацией агента в API {{ yandex-cloud }} с помощью [IAM-токена](../../iam/concepts/authorization/iam-token.md) и позволяющий агенту получать IAM-токены через [сервис метаданных](../../compute/concepts/vm-metadata.md) ВМ.
        
            Возможные значения:
        
            * `true` — агент синхронизации будет получать IAM-токены сервисного аккаунта через сервис метаданных виртуальной машины и использовать их для аутентификации в API {{ yandex-cloud }}. Значение параметра `cloud_credentials_file_path` при этом будет игнорироваться.
        
                Чтобы агент мог получать IAM-токены, он должен быть установлен на виртуальной машине {{ compute-full-name }}, к которой подключен сервисный аккаунт с [необходимыми](../concepts/ad-sync.md#yc-setup) правами доступа.
            * `false` — агент синхронизации не будет получать IAM-токены, а аутентификация в API {{ yandex-cloud }} будет выполняться с помощью авторизационного ключа, заданного в параметре `cloud_credentials_file_path`.
        * `dry_run` — настройки [тестового запуска](../concepts/ad-sync.md#dry-run) агента (dry run):
        
            * `enabled: true` — активирован режим dry run. Агент не вносит изменения в данные пользователей и групп {{ org-full-name }}. Вместо этого он тестирует выполнение всех предусмотренных конфигурацией агента операций и сохраняет результаты этих тестов в [логах](../concepts/ad-sync.md#logging) его работы.
            * `enabled: false` — агент функционирует в рабочем режиме, необходимые изменения вносятся в данные пользователей и групп {{ org-full-name }}.

        * `drsr` — настройки протокола [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) для аутентификации на стороне {{ microsoft-idp.ad-short }} [пользователя](#dc-setup) с назначенными правами на выполнение репликации данных в каталоге.
        * `ldap` — настройки протокола [LDAPS](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/enable-ldap-over-ssl-3rd-certification-authority)/[LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/) для аутентификации на стороне {{ microsoft-idp.ad-short }}:
        
            {% note warning %}
        
            Вы можете подключаться к контроллеру домена по протоколу `LDAPS` или `LDAP`. Рекомендованным и безопасным протоколом является `LDAPS`. Протокол `LDAP` используйте только при настройке и тестировании.
        
            {% endnote %}
        
            * `host` — домен или IP-адрес контроллера домена {{ microsoft-idp.ad-short }}. В зависимости от используемого протокола указываются схема и номер порта:
        
                * при использовании `LDAPS` — схема `ldaps://` и порт `636`;
                * при использовании `LDAP` — схема `ldap://` и порт `389`.
            * `username` — имя пользователя домена {{ microsoft-idp.ad-short }}, которому [назначены](#dc-setup) права на выполнение репликации данных.
            * `password` — пароль пользователя домена {{ microsoft-idp.ad-short }}.
            * `certificate_path` — путь к файлу с сертификатом открытого ключа, необходимым для расшифрования трафика от контроллера домена. Обязательный параметр при использовании протокола `LDAPS`.
        
                Если в параметре `working_directory` задан путь к рабочей директории, вместо пути к файлу сертификата достаточно указать имя этого файла.
            * `insecure_skip_verify` — параметр, позволяющий игнорировать ошибки валидации сертификата открытого ключа при подключении к контроллеру домена. Необязательный параметр. Возможные значения:
        
                * `false` — ошибки валидации сертификата не будут игнорироваться. Значение по умолчанию.
                * `true` — агент синхронизации будет игнорировать ошибки валидации сертификата. Может быть полезно при настройке и тестировании синхронизации. Не рекомендуется использовать в рабочем режиме.

        * `logger` — настройки [логирования](#logging) процесса синхронизации:
        
            * `level` — уровень логирования. Возможные значения:
        
                * `debug`
                * `info`
                * `warn`
                * `error`
                * `dpanic`
                * `panic`
                * `fatal`
        
            * `format` — формат вывода информации о событиях в стандартный поток или файл. Необязательный параметр. Возможные значения:
        
                * `plain` — информация выводится в простом текстовом виде. Значение по умолчанию.
                * `json` — информация выводится в формате [JSON](https://ru.wikipedia.org/wiki/JSON).
            * `file` — настройки сохранения логов в файлы:
        
                * `filename` — путь к файлу, в который будет сохраняться информация о событиях при синхронизации.
        
                    В параметре `filename` вместо полного пути вы можете передать только имя файла. В этом случае файл будет сохранен в рабочей директории, заданной в параметре `working_directory`, или, если рабочая директория не задана, — в директории, в которой расположен исполняемый файл агента.
        
                    Необязательный параметр. Имя файла по умолчанию — `identity_hub.log`.
                * `maxsize` — максимальный размер одного файла с логами в мегабайтах.
                * `maxbackups` — максимальное количество файлов с логами, которые агент будет хранить. При превышении максимального количества файлов наиболее старый файл будет удален.
        
                Необязательный параметр. Если настройки в разделе `file` не заданы, события не будут сохраняться в файлы.
            * `cloud_logger` — настройки сохранения логов в [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }}:
        
                * `log_group_id` — идентификатор лог-группы, в которую будут выгружаться логи работы агента синхронизации.
                
                Необязательный параметр. Если настройки в разделе  `cloud_logger` не заданы, события не будут выгружаться в лог-группу.
        
                Чтобы выгружать логи работы агента синхронизации в лог-группу, дополнительно назначьте сервисному аккаунту [роль](../../logging/security/index.md#logging-writer) `logging.writer` на соответствующую лог-группу или [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором она расположена.
        
            {% note info %}
        
            Если настройки в разделах `logger.file` и `logger.cloud_logger` не заданы, информация о событиях и ошибках будет выводиться в стандартный поток `stdout`. В противном случае логи будут сохраняться в файлы и/или лог-группу.
        
            {% endnote %}
        
        * `sync_settings` — настройки процесса синхронизации:
        
            * `interval` — периодичность выполнения [инкрементальной синхронизации](../concepts/ad-sync.md#incremental-sync). Необязательный параметр. Значение по умолчанию — 240 секунд.
        
                {% note info %}
        
                Периодичность выполнения синхронизации паролей и состояний пользователей в {{ microsoft-idp.ad-short }} составляет несколько секунд, является константой и не зависит от значения, заданного в параметре `interval`.
        
                {% endnote %}
        
            * `allow_to_capture_users` — параметр, позволяющий изменять существующего пользователя пула {{ org-full-name }} при совпадении его логина с логином пользователя {{ microsoft-idp.ad-short }}, которого требуется синхронизировать. Возможные значения:
        
                * `true` — агент синхронизации будет изменять существующих пользователей {{ org-full-name }}, приводя их в соответствие с учетной записью в {{ microsoft-idp.ad-short }}.
                * `false` — агент синхронизации не будет изменять существующих пользователей {{ org-full-name }}. При обнаружении совпадения логинов пользователя в пуле и в {{ microsoft-idp.ad-short }} процесс синхронизации выдаст ошибку.
            * `allow_to_capture_groups` — параметр, позволяющий изменять существующую группу пользователей {{ org-full-name }} при совпадении ее имени с именем группы в {{ microsoft-idp.ad-short }}, которую требуется синхронизировать. Возможные значения:
        
                * `true` — агент синхронизации будет изменять существующие группы пользователей {{ org-full-name }}, приводя их в соответствие с группами в {{ microsoft-idp.ad-short }}.
                * `false` — агент синхронизации не будет изменять существующие группы пользователей {{ org-full-name }}. При обнаружении совпадения имен групп в пуле и в {{ microsoft-idp.ad-short }} процесс синхронизации выдаст ошибку.
            * `replacement_domain` — [домен](../concepts/domains.md), привязанный к пулу пользователей {{ org-full-name }}, в котором находятся синхронизируемые пользователи и группы. Например: `newdomain.idp.{{ dns-ns-host-sld }}`.
        
                Необязательный параметр. Значение параметра `replacement_domain` требуется задавать только в том случае, если имя домена, привязанного к пулу пользователей, отличается от имени домена на контроллере домена {{ microsoft-idp.ad-short }}.
            * `user_attribute_mapping` — настройки сопоставления атрибутов пользователя:
        
                * `source` — имя атрибута пользователя, получаемое из {{ microsoft-idp.ad-short }} и отличное от имени, [заданного по умолчанию](../concepts/ad-sync.md#sync-objects).
        
                    Если вы хотите отключить синхронизацию атрибута, оставьте значение пустым: `source: ""`.
                * `target` — имя атрибута на стороне {{ yandex-cloud }}, с которым настраивается сопоставление (или для которого отключается синхронизация). Список доступных значений смотрите в таблице **Атрибуты пользователей** в разделе [{#T}](../concepts/ad-sync.md#sync-objects).
                * `type` — выбор действия в отношении указанного атрибута. Возможные значения:
        
                    * `direct` — настроить сопоставление атрибутов.
                    * `empty` — отключить синхронизацию атрибута.
        
                Необязательный параметр. Значение параметра `user_attribute_mapping` необходимо задавать только в том случае, если требуется настроить сопоставление имен атрибутов пользователя, отличных от заданных по умолчанию для {{ microsoft-idp.ad-short }}, или отключить синхронизацию отдельных атрибутов.
            * `group_attribute_mapping` — настройки сопоставления атрибутов групп пользователей:
        
                * `source` — имя атрибута групп пользователей, получаемое из {{ microsoft-idp.ad-short }} и отличное от имени, [заданного по умолчанию](../concepts/ad-sync.md#sync-objects).
        
                    Если вы хотите отключить синхронизацию атрибута, оставьте значение пустым: `source: ""`.
                * `target` — имя атрибута на стороне {{ yandex-cloud }}, с которым настраивается сопоставление (или для которого отключается синхронизация). Список доступных значений смотрите в таблице **Атрибуты групп пользователей** в разделе [{#T}](../concepts/ad-sync.md#sync-objects).
                * `type` — выбор действия в отношении указанного атрибута. Возможные значения:
        
                    * `direct` — настроить сопоставление атрибутов.
                    * `empty` — отключить синхронизацию атрибута.
        
                Необязательный параметр. Значение параметра `group_attribute_mapping` необходимо задавать только в том случае, если требуется настроить сопоставление имен атрибутов групп пользователей, отличных от заданных по умолчанию для {{ microsoft-idp.ad-short }}, или отключить синхронизацию отдельных атрибутов.
            * `filter` — настройки фильтрации синхронизируемых объектов на стороне {{ microsoft-idp.ad-short }}:
        
                * `domain` — имя домена на контроллере домена {{ microsoft-idp.ad-short }}, в котором агент будет синхронизировать пользователей и группы.
                * `organization_units` — список Organization Units (OU) в каталоге {{ microsoft-idp.ad-short }}, в которых агент будет синхронизировать пользователей и группы.
                * `groups` — список групп пользователей в каталоге {{ microsoft-idp.ad-short }}, в которых агент будет синхронизировать пользователей. Вы можете указать одну или несколько групп, при этом фильтр по нескольким группам будет применяться с логикой `ИЛИ`.
        
                    {% note info %}
        
                    Параметр `groups` влияет только на синхронизацию пользователей и не влияет на настройки синхронизации групп пользователей.
        
                    {% endnote %}
        
                Если не настроить фильтрацию синхронизируемых объектов, агент {{ ad-sync-agent }} попытается синхронизировать все [доступные объекты](../concepts/ad-sync.md#sync-objects) в каталоге {{ microsoft-idp.ad-short }}.
            * `remove_user_behavior` — позволяет управлять действием в отношении пользователей на стороне {{ yandex-cloud }}, если соответствующие пользователи на стороне {{ microsoft-idp.ad-short }} были удалены или перестали удовлетворять условиям, заданным в параметрах `sync_settings.filter` (например, они были перенесены в другой Organization Unit). Необязательный параметр. Возможные значения:
        
                * `remove` — пользователи, удаленные или переставшие удовлетворять условиям фильтра, удаляются на стороне {{ org-full-name }}. Действие по умолчанию.
                * `block` — пользователи, удаленные или переставшие удовлетворять условиям фильтра, деактивируются на стороне {{ org-full-name }}.
        
            {% note info %}
        
            Если в процессе синхронизации выясняется, что на стороне {{ microsoft-idp.ad-short }} группа пользователей была удалена или перестала удовлетворять заданным фильтрам (например, она была перенесена в другой Organization Unit), то на стороне {{ org-full-name }} такая группа удаляется.
        
            {% endnote %}

      - Аутентификация по протоколу Kerberos {#kerberos}

        {% note info %}

        Использование протокола Kerberos в настоящий момент возможно только при установке агента синхронизации на сервер с ОС Linux.

        {% endnote %}

        ```yml
        # Default configuration for yc-identityhub-sync-agent
        # This is a template - please update with your actual values
        
        userpool_id: "<идентификатор_пула_пользователей>"
        replication_tokens_path: "<путь_к_директории_с_токенами_процессов>"
        working_directory: "<путь_к_рабочей_директории_агента>"
        
        # {{ yandex-cloud }} authentication settings
        
        # Use the cloud_credentials_file_path parameter for authentication via an authorized key.
        # If you want the agent to authenticate via IAM tokens, remove the cloud_credentials_file_path line.
        cloud_credentials_file_path: "<путь_к_файлу_с_авторизованным_ключом>"
        
        # Enable the use_metadata_service parameter for authentication via IAM tokens
        # (only available when the agent is installed on a {{ compute-name }} VM).
        # If `true`, the cloud_credentials_file_path parameter will be ignored.
        use_metadata_service: true|false
        
        # Enable the Dry Run mode.
        # If `true`, no changes will be applied to users or groups in {{ org-full-name }}.
        # Instead, all pending operations will be saved to the current log file location.
        dry_run:
          enabled: true|false
        
        # Active Directory replication API client settings
        drsr:
          host: "<адрес_контроллера_домена>"
          use_kerberos: true
        
        # LDAP client settings
        ldap:
          host: "ldaps://<адрес_контроллера_домена>:636"
          certificate_path: "<путь_к_сертификату>"
          insecure_skip_verify: false|true
          use_kerberos: true
        
        # Kerberos settings
        kerberos:
          keytab_path: "<путь_к_файлу_keytab>"
          principal: "<SPN_пользователя_в_Active_Directory>"
          krb5_config_path: "<путь_к_файлу_конфигурации_Kerberos>"  # optional, the default location is /etc/krb5.conf or whatever path is set in the KRB5_CONFIG environment variable
          disable_pa_fx_fast: true
        
        # Logger configuration
        logger:
          level: "<уровень_логирования>"
          format: "plain|json"
          file:
            filename: "<путь_к_файлу_с_логами>"
            maxsize: 30
            maxbackups: 10
          cloud_logger:
            log_group_id: <идентификатор_лог-группы>
        
        # Sync settings
        sync_settings:
          interval: "600s"
          allow_to_capture_users: true|false
          allow_to_capture_groups: true|false
          # Remove the replacement_domain line if you don't need to replace domain
          replacement_domain: "<домен_пула_пользователей>"
          # Remove the user_attribute_mapping section if you don't need to remap default user attribute names
          # If you need remapping, the user_attribute_mapping section should only contain the attributes you need to remap
          user_attribute_mapping:
            # The following syntax allows to reconfigure the default mapping ('displayName' --> 'full_name')
            # to custom mapping ('CustomAttributeName' --> 'full_name')
            - source: "CustomAttributeName"
              target: "FullName"
              type: "direct"
            # The following syntax allows to disable synchronization for attribute 'given_name'
            - source: ""
              target: "GivenName"
              type: "empty"
          # Remove the group_attribute_mapping section if you don't need to remap default group attribute names
          # If you need remapping, the group_attribute_mapping section should only contain the attributes you need to remap
          group_attribute_mapping:
            # The following syntax allows to reconfigure the default mapping ('name' --> 'name')
            # to custom mapping ('CustomAttributeName' --> 'name')
            - source: "CustomAttributeName"
              target: "Name"
              type: "direct"
            # The following syntax allows to disable synchronization for attribute 'description'
            - source: ""
              target: "Description"
              type: "empty"
          filter:
            domain: "<имя_домена_в_Active_Directory>"
            organization_units:
              - OU=IdPUsersOU,DC=example,DC=com
              - OU=IdPGroupsOU,DC=example,DC=com
            groups:
              - "GroupName1"
              - "GroupName2"
          remove_user_behavior: "remove|block"
        ```

        Где:

        * `userpool_id` — идентификатор [пула пользователей](../concepts/user-pools.md) в {{ org-full-name }}.
        * `replication_tokens_path` — путь к директории, в которой сохраняются токены с информацией о текущем прогрессе процессов [полной синхронизации](../concepts/ad-sync.md#full-sync). Необязательный параметр.
        
            Если параметр не задан, токены сохраняются в рабочей директории агента, указанной в параметре `working_directory`, или, если рабочая директория не задана, — в директории, в которой расположен исполняемый файл агента.
        * `working_directory` — путь к директории, в которой сохраняются другие файлы, необходимые агенту для работы. Необязательный параметр.
        
            Если параметр не задан, в качестве рабочей директории используется директория, в которой расположен исполняемый файл агента. По умолчанию исполняемый файл агента располагается в следующих директориях:
        
            * `/etc/yc-identityhub-sync-agent/` (для Linux);
            * `C:\\ProgramData\\YcIdentityHubSyncAgent\\` (для Windows).
        
        * `cloud_credentials_file_path` — путь к файлу, содержащему [авторизованный ключ](../../iam/concepts/authorization/key.md) сервисного аккаунта в {{ yandex-cloud }}. Необязательный параметр: используется только при аутентификации агента в API {{ yandex-cloud }} с помощью авторизованного ключа.
        
            Примеры значений:
        
            * `/etc/yc-identityhub-sync-agent/authorized_key.json` (для Linux);
            * `C:\\ProgramData\\YcIdentityHubSyncAgent\\authorized_key.json` (для Windows).
        
            В параметре `cloud_credentials_file_path` вместо полного пути вы можете передать только имя файла. В этом случае файл будет сохранен в рабочей директории, заданной в параметре `working_directory`, или, если рабочая директория не задана, — в директории, в которой расположен исполняемый файл агента.
        
            {% note info %}
        
            Если в параметрах `cloud_credentials_file_path`, `replication_tokens_path` и/или `logger.file.filename` заданы пути, отличные от пути, заданного в параметре `working_directory`, для выбранных сущностей будут использоваться пути, указанные в параметрах `cloud_credentials_file_path`, `replication_tokens_path` и/или `logger.file.filename`.
        
            {% endnote %}
        
        * `use_metadata_service` — параметр, управляющий аутентификацией агента в API {{ yandex-cloud }} с помощью [IAM-токена](../../iam/concepts/authorization/iam-token.md) и позволяющий агенту получать IAM-токены через [сервис метаданных](../../compute/concepts/vm-metadata.md) ВМ.
        
            Возможные значения:
        
            * `true` — агент синхронизации будет получать IAM-токены сервисного аккаунта через сервис метаданных виртуальной машины и использовать их для аутентификации в API {{ yandex-cloud }}. Значение параметра `cloud_credentials_file_path` при этом будет игнорироваться.
        
                Чтобы агент мог получать IAM-токены, он должен быть установлен на виртуальной машине {{ compute-full-name }}, к которой подключен сервисный аккаунт с [необходимыми](../concepts/ad-sync.md#yc-setup) правами доступа.
            * `false` — агент синхронизации не будет получать IAM-токены, а аутентификация в API {{ yandex-cloud }} будет выполняться с помощью авторизационного ключа, заданного в параметре `cloud_credentials_file_path`.
        * `dry_run` — настройки [тестового запуска](../concepts/ad-sync.md#dry-run) агента (dry run):
        
            * `enabled: true` — активирован режим dry run. Агент не вносит изменения в данные пользователей и групп {{ org-full-name }}. Вместо этого он тестирует выполнение всех предусмотренных конфигурацией агента операций и сохраняет результаты этих тестов в [логах](../concepts/ad-sync.md#logging) его работы.
            * `enabled: false` — агент функционирует в рабочем режиме, необходимые изменения вносятся в данные пользователей и групп {{ org-full-name }}.

        * `drsr` — настройки протокола [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) для аутентификации на стороне {{ microsoft-idp.ad-short }} с использованием Kerberos.
        * `ldap` — настройки протокола [LDAPS](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/enable-ldap-over-ssl-3rd-certification-authority)/[LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/) для аутентификации на стороне {{ microsoft-idp.ad-short }} с использованием Kerberos:
        
            {% note warning %}
        
            Вы можете подключаться к контроллеру домена по протоколу `LDAPS` или `LDAP`. Рекомендованным и безопасным протоколом является `LDAPS`. Протокол `LDAP` используйте только при настройке и тестировании.
        
            {% endnote %}
        
            * `host` — домен или IP-адрес контроллера домена {{ microsoft-idp.ad-short }}. В зависимости от используемого протокола указываются схема и номер порта:
        
                * при использовании `LDAPS` — схема `ldaps://` и порт `636`;
                * при использовании `LDAP` — схема `ldap://` и порт `389`.
            * `certificate_path` — путь к файлу с сертификатом открытого ключа, необходимым для расшифрования трафика от контроллера домена. Обязательный параметр при использовании протокола `LDAPS`.
        
                Если в параметре `working_directory` задан путь к рабочей директории, вместо пути к файлу сертификата достаточно указать имя этого файла.
            * `insecure_skip_verify` — параметр, позволяющий игнорировать ошибки валидации сертификата открытого ключа при подключении к контроллеру домена. Необязательный параметр. Возможные значения:
        
                * `false` — ошибки валидации сертификата не будут игнорироваться. Значение по умолчанию.
                * `true` — агент синхронизации будет игнорировать ошибки валидации сертификата. Может быть полезно при настройке и тестировании синхронизации. Не рекомендуется использовать в рабочем режиме.
            * `use_kerberos` — параметр, указывающий на необходимость использовать протокол Kerberos для аутентификации пользователя на стороне {{ microsoft-idp.ad-short }}.
        * `kerberos` — настройки протокола Kerberos для аутентификации на стороне {{ microsoft-idp.ad-short }}:
        
            * `keytab_path` — путь к файлу `keytab` с ключами шифрования.
            * `principal` — [SPN](https://learn.microsoft.com/en-us/windows/win32/ad/service-principal-names) пользовательского аккаунта для подключения к {{ microsoft-idp.ad-short }}.
            * `krb5_config_path` — путь к файлу конфигурации Kerberos. Необязательный параметр. По умолчанию используется путь `/etc/krb5.conf` или значение, заданное в переменной окружения `KRB5_CONFIG`.
            * `disable_pa_fx_fast: true` — параметр, управляющий режимом [FAST](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831747(v=ws.11)#kerberos-armoring-flexible-authentication-secure-tunneling-fast).

        * `logger` — настройки [логирования](#logging) процесса синхронизации:
        
            * `level` — уровень логирования. Возможные значения:
        
                * `debug`
                * `info`
                * `warn`
                * `error`
                * `dpanic`
                * `panic`
                * `fatal`
        
            * `format` — формат вывода информации о событиях в стандартный поток или файл. Необязательный параметр. Возможные значения:
        
                * `plain` — информация выводится в простом текстовом виде. Значение по умолчанию.
                * `json` — информация выводится в формате [JSON](https://ru.wikipedia.org/wiki/JSON).
            * `file` — настройки сохранения логов в файлы:
        
                * `filename` — путь к файлу, в который будет сохраняться информация о событиях при синхронизации.
        
                    В параметре `filename` вместо полного пути вы можете передать только имя файла. В этом случае файл будет сохранен в рабочей директории, заданной в параметре `working_directory`, или, если рабочая директория не задана, — в директории, в которой расположен исполняемый файл агента.
        
                    Необязательный параметр. Имя файла по умолчанию — `identity_hub.log`.
                * `maxsize` — максимальный размер одного файла с логами в мегабайтах.
                * `maxbackups` — максимальное количество файлов с логами, которые агент будет хранить. При превышении максимального количества файлов наиболее старый файл будет удален.
        
                Необязательный параметр. Если настройки в разделе `file` не заданы, события не будут сохраняться в файлы.
            * `cloud_logger` — настройки сохранения логов в [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }}:
        
                * `log_group_id` — идентификатор лог-группы, в которую будут выгружаться логи работы агента синхронизации.
                
                Необязательный параметр. Если настройки в разделе  `cloud_logger` не заданы, события не будут выгружаться в лог-группу.
        
                Чтобы выгружать логи работы агента синхронизации в лог-группу, дополнительно назначьте сервисному аккаунту [роль](../../logging/security/index.md#logging-writer) `logging.writer` на соответствующую лог-группу или [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором она расположена.
        
            {% note info %}
        
            Если настройки в разделах `logger.file` и `logger.cloud_logger` не заданы, информация о событиях и ошибках будет выводиться в стандартный поток `stdout`. В противном случае логи будут сохраняться в файлы и/или лог-группу.
        
            {% endnote %}
        
        * `sync_settings` — настройки процесса синхронизации:
        
            * `interval` — периодичность выполнения [инкрементальной синхронизации](../concepts/ad-sync.md#incremental-sync). Необязательный параметр. Значение по умолчанию — 240 секунд.
        
                {% note info %}
        
                Периодичность выполнения синхронизации паролей и состояний пользователей в {{ microsoft-idp.ad-short }} составляет несколько секунд, является константой и не зависит от значения, заданного в параметре `interval`.
        
                {% endnote %}
        
            * `allow_to_capture_users` — параметр, позволяющий изменять существующего пользователя пула {{ org-full-name }} при совпадении его логина с логином пользователя {{ microsoft-idp.ad-short }}, которого требуется синхронизировать. Возможные значения:
        
                * `true` — агент синхронизации будет изменять существующих пользователей {{ org-full-name }}, приводя их в соответствие с учетной записью в {{ microsoft-idp.ad-short }}.
                * `false` — агент синхронизации не будет изменять существующих пользователей {{ org-full-name }}. При обнаружении совпадения логинов пользователя в пуле и в {{ microsoft-idp.ad-short }} процесс синхронизации выдаст ошибку.
            * `allow_to_capture_groups` — параметр, позволяющий изменять существующую группу пользователей {{ org-full-name }} при совпадении ее имени с именем группы в {{ microsoft-idp.ad-short }}, которую требуется синхронизировать. Возможные значения:
        
                * `true` — агент синхронизации будет изменять существующие группы пользователей {{ org-full-name }}, приводя их в соответствие с группами в {{ microsoft-idp.ad-short }}.
                * `false` — агент синхронизации не будет изменять существующие группы пользователей {{ org-full-name }}. При обнаружении совпадения имен групп в пуле и в {{ microsoft-idp.ad-short }} процесс синхронизации выдаст ошибку.
            * `replacement_domain` — [домен](../concepts/domains.md), привязанный к пулу пользователей {{ org-full-name }}, в котором находятся синхронизируемые пользователи и группы. Например: `newdomain.idp.{{ dns-ns-host-sld }}`.
        
                Необязательный параметр. Значение параметра `replacement_domain` требуется задавать только в том случае, если имя домена, привязанного к пулу пользователей, отличается от имени домена на контроллере домена {{ microsoft-idp.ad-short }}.
            * `user_attribute_mapping` — настройки сопоставления атрибутов пользователя:
        
                * `source` — имя атрибута пользователя, получаемое из {{ microsoft-idp.ad-short }} и отличное от имени, [заданного по умолчанию](../concepts/ad-sync.md#sync-objects).
        
                    Если вы хотите отключить синхронизацию атрибута, оставьте значение пустым: `source: ""`.
                * `target` — имя атрибута на стороне {{ yandex-cloud }}, с которым настраивается сопоставление (или для которого отключается синхронизация). Список доступных значений смотрите в таблице **Атрибуты пользователей** в разделе [{#T}](../concepts/ad-sync.md#sync-objects).
                * `type` — выбор действия в отношении указанного атрибута. Возможные значения:
        
                    * `direct` — настроить сопоставление атрибутов.
                    * `empty` — отключить синхронизацию атрибута.
        
                Необязательный параметр. Значение параметра `user_attribute_mapping` необходимо задавать только в том случае, если требуется настроить сопоставление имен атрибутов пользователя, отличных от заданных по умолчанию для {{ microsoft-idp.ad-short }}, или отключить синхронизацию отдельных атрибутов.
            * `group_attribute_mapping` — настройки сопоставления атрибутов групп пользователей:
        
                * `source` — имя атрибута групп пользователей, получаемое из {{ microsoft-idp.ad-short }} и отличное от имени, [заданного по умолчанию](../concepts/ad-sync.md#sync-objects).
        
                    Если вы хотите отключить синхронизацию атрибута, оставьте значение пустым: `source: ""`.
                * `target` — имя атрибута на стороне {{ yandex-cloud }}, с которым настраивается сопоставление (или для которого отключается синхронизация). Список доступных значений смотрите в таблице **Атрибуты групп пользователей** в разделе [{#T}](../concepts/ad-sync.md#sync-objects).
                * `type` — выбор действия в отношении указанного атрибута. Возможные значения:
        
                    * `direct` — настроить сопоставление атрибутов.
                    * `empty` — отключить синхронизацию атрибута.
        
                Необязательный параметр. Значение параметра `group_attribute_mapping` необходимо задавать только в том случае, если требуется настроить сопоставление имен атрибутов групп пользователей, отличных от заданных по умолчанию для {{ microsoft-idp.ad-short }}, или отключить синхронизацию отдельных атрибутов.
            * `filter` — настройки фильтрации синхронизируемых объектов на стороне {{ microsoft-idp.ad-short }}:
        
                * `domain` — имя домена на контроллере домена {{ microsoft-idp.ad-short }}, в котором агент будет синхронизировать пользователей и группы.
                * `organization_units` — список Organization Units (OU) в каталоге {{ microsoft-idp.ad-short }}, в которых агент будет синхронизировать пользователей и группы.
                * `groups` — список групп пользователей в каталоге {{ microsoft-idp.ad-short }}, в которых агент будет синхронизировать пользователей. Вы можете указать одну или несколько групп, при этом фильтр по нескольким группам будет применяться с логикой `ИЛИ`.
        
                    {% note info %}
        
                    Параметр `groups` влияет только на синхронизацию пользователей и не влияет на настройки синхронизации групп пользователей.
        
                    {% endnote %}
        
                Если не настроить фильтрацию синхронизируемых объектов, агент {{ ad-sync-agent }} попытается синхронизировать все [доступные объекты](../concepts/ad-sync.md#sync-objects) в каталоге {{ microsoft-idp.ad-short }}.
            * `remove_user_behavior` — позволяет управлять действием в отношении пользователей на стороне {{ yandex-cloud }}, если соответствующие пользователи на стороне {{ microsoft-idp.ad-short }} были удалены или перестали удовлетворять условиям, заданным в параметрах `sync_settings.filter` (например, они были перенесены в другой Organization Unit). Необязательный параметр. Возможные значения:
        
                * `remove` — пользователи, удаленные или переставшие удовлетворять условиям фильтра, удаляются на стороне {{ org-full-name }}. Действие по умолчанию.
                * `block` — пользователи, удаленные или переставшие удовлетворять условиям фильтра, деактивируются на стороне {{ org-full-name }}.
        
            {% note info %}
        
            Если в процессе синхронизации выясняется, что на стороне {{ microsoft-idp.ad-short }} группа пользователей была удалена или перестала удовлетворять заданным фильтрам (например, она была перенесена в другой Organization Unit), то на стороне {{ org-full-name }} такая группа удаляется.
        
            {% endnote %}

      {% endlist %}

  1. Запустите сервис агента {{ ad-sync-agent }}, чтобы начать процесс синхронизации:

      ```bash
      sudo systemctl start yc-identityhub-sync-agent
      ```
  1. Чтобы убедиться, что процесс синхронизации идет, посмотрите файл с логами агента. Например:

      ```bash
      sudo cat /etc/yc-identityhub-sync-agent/identity_hub.log
      ```

      Результат синхронизации вы также можете посмотреть в интерфейсе сервиса [{{ org-full-name }}]({{ link-org-cloud-center }}) — в выбранном пуле пользователей должны создаться новые пользователи и группы, полученные из {{ microsoft-idp.ad-short }}.

  1. Чтобы остановить синхронизацию, остановите запущенный процесс агента синхронизации:

      ```bash
      sudo systemctl stop yc-identityhub-sync-agent
      ```

      В результате процесс синхронизации пользователей и групп будет остановлен.

- Windows {#windows}

  В терминале PowerShell:

  1. Чтобы установить агент {{ ad-sync-agent }}, выполните команду:

      ```bash
      iex (New-Object System.Net.WebClient).DownloadString('{{ ad-sync-agent-windowslink }}')
      ```

      Результат:

      ```text
      Example config file downloaded to C:\ProgramData\YcIdentityHubSyncAgent\config.yaml. Modify it with your values
      yc-identityhub-sync-agent is installed to C:\Program Files\YcIdentityHubSyncAgent\bin\yc-identityhub-sync-agent.exe
      Config file is located at C:\ProgramData\YcIdentityHubSyncAgent\config.yaml

      Status   Name               DisplayName
      ------   ----               -----------
      Stopped  yc-identityhub-... Yandex Identity Hub Sync Agent
      yc-identityhub-sync-agent installed as Windows service 'yc-identityhub-sync-agent' (not started automatically)
      1. Modify the config file at C:\ProgramData\YcIdentityHubSyncAgent\config.yaml with your values
      2. Run: Start-Service yc-identityhub-sync-agent
      ```
  1. Скопируйте на ваш сервер файл с сохраненным ранее авторизованным ключом сервисного аккаунта. Для этого вы можете воспользоваться любым подходящим инструментом.
  1. В любом текстовом редакторе откройте [YAML](https://yaml.org/)-файл конфигурации агента `config.yaml`, расположенный в папке `C:\ProgramData\YcIdentityHubSyncAgent\`, и добавьте в него следующую конфигурацию:

      ```yml
      # Default configuration for yc-identityhub-sync-agent
      # This is a template - please update with your actual values
      
      userpool_id: "<идентификатор_пула_пользователей>"
      replication_tokens_path: "<путь_к_директории_с_токенами_процессов>"
      working_directory: "<путь_к_рабочей_директории_агента>"
      
      # {{ yandex-cloud }} authentication settings
      
      # Use the cloud_credentials_file_path parameter for authentication via an authorized key.
      # If you want the agent to authenticate via IAM tokens, remove the cloud_credentials_file_path line.
      cloud_credentials_file_path: "<путь_к_файлу_с_авторизованным_ключом>"
      
      # Enable the use_metadata_service parameter for authentication via IAM tokens
      # (only available when the agent is installed on a {{ compute-name }} VM).
      # If `true`, the cloud_credentials_file_path parameter will be ignored.
      use_metadata_service: true|false
      
      # Enable the Dry Run mode.
      # If `true`, no changes will be applied to users or groups in {{ org-full-name }}.
      # Instead, all pending operations will be saved to the current log file location.
      dry_run:
        enabled: true|false
      
      # Active Directory replication API client settings
      drsr:
        host: "<адрес_контроллера_домена>"
        username: "username"
        password: "password"
      
      # LDAP client settings
      ldap:
        host: "ldaps://<адрес_контроллера_домена>:636"
        username: "<имя_пользователя_Active_Directory>"
        password: "<пароль_пользователя_Active_Directory>"
        certificate_path: "<путь_к_сертификату>"
        insecure_skip_verify: false|true
      
      # Logger configuration
      logger:
        level: "<уровень_логирования>"
        format: "plain|json"
        file:
          filename: "<путь_к_файлу_с_логами>"
          maxsize: 30
          maxbackups: 10
        cloud_logger:
          log_group_id: <идентификатор_лог-группы>
      
      # Sync settings
      sync_settings:
        interval: "600s"
        allow_to_capture_users: true|false
        allow_to_capture_groups: true|false
        # Remove the replacement_domain line if you don't need to replace domain
        replacement_domain: "<домен_пула_пользователей>"
        # Remove the user_attribute_mapping section if you don't need to remap default user attribute names
        # If you need remapping, the user_attribute_mapping section should only contain the attributes you need to remap
        user_attribute_mapping:
          # The following syntax allows to reconfigure the default mapping ('displayName' --> 'full_name')
          # to custom mapping ('CustomAttributeName' --> 'full_name')
          - source: "CustomAttributeName"
            target: "FullName"
            type: "direct"
          # The following syntax allows to disable synchronization for attribute 'given_name'
          - source: ""
            target: "GivenName"
            type: "empty"
        # Remove the group_attribute_mapping section if you don't need to remap default group attribute names
        # If you need remapping, the group_attribute_mapping section should only contain the attributes you need to remap
        group_attribute_mapping:
          # The following syntax allows to reconfigure the default mapping ('name' --> 'name')
          # to custom mapping ('CustomAttributeName' --> 'name')
          - source: "CustomAttributeName"
            target: "Name"
            type: "direct"
          # The following syntax allows to disable synchronization for attribute 'description'
          - source: ""
            target: "Description"
            type: "empty"
        filter:
          domain: "<имя_домена_в_Active_Directory>"
          organization_units:
            - OU=IdPUsersOU,DC=example,DC=com
            - OU=IdPGroupsOU,DC=example,DC=com
          groups:
            - "GroupName1"
            - "GroupName2"
        remove_user_behavior: "remove|block"
      ```

      Где:

      * `userpool_id` — идентификатор [пула пользователей](../concepts/user-pools.md) в {{ org-full-name }}.
      * `replication_tokens_path` — путь к директории, в которой сохраняются токены с информацией о текущем прогрессе процессов [полной синхронизации](../concepts/ad-sync.md#full-sync). Необязательный параметр.
      
          Если параметр не задан, токены сохраняются в рабочей директории агента, указанной в параметре `working_directory`, или, если рабочая директория не задана, — в директории, в которой расположен исполняемый файл агента.
      * `working_directory` — путь к директории, в которой сохраняются другие файлы, необходимые агенту для работы. Необязательный параметр.
      
          Если параметр не задан, в качестве рабочей директории используется директория, в которой расположен исполняемый файл агента. По умолчанию исполняемый файл агента располагается в следующих директориях:
      
          * `/etc/yc-identityhub-sync-agent/` (для Linux);
          * `C:\\ProgramData\\YcIdentityHubSyncAgent\\` (для Windows).
      
      * `cloud_credentials_file_path` — путь к файлу, содержащему [авторизованный ключ](../../iam/concepts/authorization/key.md) сервисного аккаунта в {{ yandex-cloud }}. Необязательный параметр: используется только при аутентификации агента в API {{ yandex-cloud }} с помощью авторизованного ключа.
      
          Примеры значений:
      
          * `/etc/yc-identityhub-sync-agent/authorized_key.json` (для Linux);
          * `C:\\ProgramData\\YcIdentityHubSyncAgent\\authorized_key.json` (для Windows).
      
          В параметре `cloud_credentials_file_path` вместо полного пути вы можете передать только имя файла. В этом случае файл будет сохранен в рабочей директории, заданной в параметре `working_directory`, или, если рабочая директория не задана, — в директории, в которой расположен исполняемый файл агента.
      
          {% note info %}
      
          Если в параметрах `cloud_credentials_file_path`, `replication_tokens_path` и/или `logger.file.filename` заданы пути, отличные от пути, заданного в параметре `working_directory`, для выбранных сущностей будут использоваться пути, указанные в параметрах `cloud_credentials_file_path`, `replication_tokens_path` и/или `logger.file.filename`.
      
          {% endnote %}
      
      * `use_metadata_service` — параметр, управляющий аутентификацией агента в API {{ yandex-cloud }} с помощью [IAM-токена](../../iam/concepts/authorization/iam-token.md) и позволяющий агенту получать IAM-токены через [сервис метаданных](../../compute/concepts/vm-metadata.md) ВМ.
      
          Возможные значения:
      
          * `true` — агент синхронизации будет получать IAM-токены сервисного аккаунта через сервис метаданных виртуальной машины и использовать их для аутентификации в API {{ yandex-cloud }}. Значение параметра `cloud_credentials_file_path` при этом будет игнорироваться.
      
              Чтобы агент мог получать IAM-токены, он должен быть установлен на виртуальной машине {{ compute-full-name }}, к которой подключен сервисный аккаунт с [необходимыми](../concepts/ad-sync.md#yc-setup) правами доступа.
          * `false` — агент синхронизации не будет получать IAM-токены, а аутентификация в API {{ yandex-cloud }} будет выполняться с помощью авторизационного ключа, заданного в параметре `cloud_credentials_file_path`.
      * `dry_run` — настройки [тестового запуска](../concepts/ad-sync.md#dry-run) агента (dry run):
      
          * `enabled: true` — активирован режим dry run. Агент не вносит изменения в данные пользователей и групп {{ org-full-name }}. Вместо этого он тестирует выполнение всех предусмотренных конфигурацией агента операций и сохраняет результаты этих тестов в [логах](../concepts/ad-sync.md#logging) его работы.
          * `enabled: false` — агент функционирует в рабочем режиме, необходимые изменения вносятся в данные пользователей и групп {{ org-full-name }}.

      * `drsr` — настройки протокола [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) для аутентификации на стороне {{ microsoft-idp.ad-short }} [пользователя](#dc-setup) с назначенными правами на выполнение репликации данных в каталоге.
      * `ldap` — настройки протокола [LDAPS](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/enable-ldap-over-ssl-3rd-certification-authority)/[LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/) для аутентификации на стороне {{ microsoft-idp.ad-short }}:
      
          {% note warning %}
      
          Вы можете подключаться к контроллеру домена по протоколу `LDAPS` или `LDAP`. Рекомендованным и безопасным протоколом является `LDAPS`. Протокол `LDAP` используйте только при настройке и тестировании.
      
          {% endnote %}
      
          * `host` — домен или IP-адрес контроллера домена {{ microsoft-idp.ad-short }}. В зависимости от используемого протокола указываются схема и номер порта:
      
              * при использовании `LDAPS` — схема `ldaps://` и порт `636`;
              * при использовании `LDAP` — схема `ldap://` и порт `389`.
          * `username` — имя пользователя домена {{ microsoft-idp.ad-short }}, которому [назначены](#dc-setup) права на выполнение репликации данных.
          * `password` — пароль пользователя домена {{ microsoft-idp.ad-short }}.
          * `certificate_path` — путь к файлу с сертификатом открытого ключа, необходимым для расшифрования трафика от контроллера домена. Обязательный параметр при использовании протокола `LDAPS`.
      
              Если в параметре `working_directory` задан путь к рабочей директории, вместо пути к файлу сертификата достаточно указать имя этого файла.
          * `insecure_skip_verify` — параметр, позволяющий игнорировать ошибки валидации сертификата открытого ключа при подключении к контроллеру домена. Необязательный параметр. Возможные значения:
      
              * `false` — ошибки валидации сертификата не будут игнорироваться. Значение по умолчанию.
              * `true` — агент синхронизации будет игнорировать ошибки валидации сертификата. Может быть полезно при настройке и тестировании синхронизации. Не рекомендуется использовать в рабочем режиме.

      * `logger` — настройки [логирования](#logging) процесса синхронизации:
      
          * `level` — уровень логирования. Возможные значения:
      
              * `debug`
              * `info`
              * `warn`
              * `error`
              * `dpanic`
              * `panic`
              * `fatal`
      
          * `format` — формат вывода информации о событиях в стандартный поток или файл. Необязательный параметр. Возможные значения:
      
              * `plain` — информация выводится в простом текстовом виде. Значение по умолчанию.
              * `json` — информация выводится в формате [JSON](https://ru.wikipedia.org/wiki/JSON).
          * `file` — настройки сохранения логов в файлы:
      
              * `filename` — путь к файлу, в который будет сохраняться информация о событиях при синхронизации.
      
                  В параметре `filename` вместо полного пути вы можете передать только имя файла. В этом случае файл будет сохранен в рабочей директории, заданной в параметре `working_directory`, или, если рабочая директория не задана, — в директории, в которой расположен исполняемый файл агента.
      
                  Необязательный параметр. Имя файла по умолчанию — `identity_hub.log`.
              * `maxsize` — максимальный размер одного файла с логами в мегабайтах.
              * `maxbackups` — максимальное количество файлов с логами, которые агент будет хранить. При превышении максимального количества файлов наиболее старый файл будет удален.
      
              Необязательный параметр. Если настройки в разделе `file` не заданы, события не будут сохраняться в файлы.
          * `cloud_logger` — настройки сохранения логов в [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }}:
      
              * `log_group_id` — идентификатор лог-группы, в которую будут выгружаться логи работы агента синхронизации.
              
              Необязательный параметр. Если настройки в разделе  `cloud_logger` не заданы, события не будут выгружаться в лог-группу.
      
              Чтобы выгружать логи работы агента синхронизации в лог-группу, дополнительно назначьте сервисному аккаунту [роль](../../logging/security/index.md#logging-writer) `logging.writer` на соответствующую лог-группу или [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором она расположена.
      
          {% note info %}
      
          Если настройки в разделах `logger.file` и `logger.cloud_logger` не заданы, информация о событиях и ошибках будет выводиться в стандартный поток `stdout`. В противном случае логи будут сохраняться в файлы и/или лог-группу.
      
          {% endnote %}
      
      * `sync_settings` — настройки процесса синхронизации:
      
          * `interval` — периодичность выполнения [инкрементальной синхронизации](../concepts/ad-sync.md#incremental-sync). Необязательный параметр. Значение по умолчанию — 240 секунд.
      
              {% note info %}
      
              Периодичность выполнения синхронизации паролей и состояний пользователей в {{ microsoft-idp.ad-short }} составляет несколько секунд, является константой и не зависит от значения, заданного в параметре `interval`.
      
              {% endnote %}
      
          * `allow_to_capture_users` — параметр, позволяющий изменять существующего пользователя пула {{ org-full-name }} при совпадении его логина с логином пользователя {{ microsoft-idp.ad-short }}, которого требуется синхронизировать. Возможные значения:
      
              * `true` — агент синхронизации будет изменять существующих пользователей {{ org-full-name }}, приводя их в соответствие с учетной записью в {{ microsoft-idp.ad-short }}.
              * `false` — агент синхронизации не будет изменять существующих пользователей {{ org-full-name }}. При обнаружении совпадения логинов пользователя в пуле и в {{ microsoft-idp.ad-short }} процесс синхронизации выдаст ошибку.
          * `allow_to_capture_groups` — параметр, позволяющий изменять существующую группу пользователей {{ org-full-name }} при совпадении ее имени с именем группы в {{ microsoft-idp.ad-short }}, которую требуется синхронизировать. Возможные значения:
      
              * `true` — агент синхронизации будет изменять существующие группы пользователей {{ org-full-name }}, приводя их в соответствие с группами в {{ microsoft-idp.ad-short }}.
              * `false` — агент синхронизации не будет изменять существующие группы пользователей {{ org-full-name }}. При обнаружении совпадения имен групп в пуле и в {{ microsoft-idp.ad-short }} процесс синхронизации выдаст ошибку.
          * `replacement_domain` — [домен](../concepts/domains.md), привязанный к пулу пользователей {{ org-full-name }}, в котором находятся синхронизируемые пользователи и группы. Например: `newdomain.idp.{{ dns-ns-host-sld }}`.
      
              Необязательный параметр. Значение параметра `replacement_domain` требуется задавать только в том случае, если имя домена, привязанного к пулу пользователей, отличается от имени домена на контроллере домена {{ microsoft-idp.ad-short }}.
          * `user_attribute_mapping` — настройки сопоставления атрибутов пользователя:
      
              * `source` — имя атрибута пользователя, получаемое из {{ microsoft-idp.ad-short }} и отличное от имени, [заданного по умолчанию](../concepts/ad-sync.md#sync-objects).
      
                  Если вы хотите отключить синхронизацию атрибута, оставьте значение пустым: `source: ""`.
              * `target` — имя атрибута на стороне {{ yandex-cloud }}, с которым настраивается сопоставление (или для которого отключается синхронизация). Список доступных значений смотрите в таблице **Атрибуты пользователей** в разделе [{#T}](../concepts/ad-sync.md#sync-objects).
              * `type` — выбор действия в отношении указанного атрибута. Возможные значения:
      
                  * `direct` — настроить сопоставление атрибутов.
                  * `empty` — отключить синхронизацию атрибута.
      
              Необязательный параметр. Значение параметра `user_attribute_mapping` необходимо задавать только в том случае, если требуется настроить сопоставление имен атрибутов пользователя, отличных от заданных по умолчанию для {{ microsoft-idp.ad-short }}, или отключить синхронизацию отдельных атрибутов.
          * `group_attribute_mapping` — настройки сопоставления атрибутов групп пользователей:
      
              * `source` — имя атрибута групп пользователей, получаемое из {{ microsoft-idp.ad-short }} и отличное от имени, [заданного по умолчанию](../concepts/ad-sync.md#sync-objects).
      
                  Если вы хотите отключить синхронизацию атрибута, оставьте значение пустым: `source: ""`.
              * `target` — имя атрибута на стороне {{ yandex-cloud }}, с которым настраивается сопоставление (или для которого отключается синхронизация). Список доступных значений смотрите в таблице **Атрибуты групп пользователей** в разделе [{#T}](../concepts/ad-sync.md#sync-objects).
              * `type` — выбор действия в отношении указанного атрибута. Возможные значения:
      
                  * `direct` — настроить сопоставление атрибутов.
                  * `empty` — отключить синхронизацию атрибута.
      
              Необязательный параметр. Значение параметра `group_attribute_mapping` необходимо задавать только в том случае, если требуется настроить сопоставление имен атрибутов групп пользователей, отличных от заданных по умолчанию для {{ microsoft-idp.ad-short }}, или отключить синхронизацию отдельных атрибутов.
          * `filter` — настройки фильтрации синхронизируемых объектов на стороне {{ microsoft-idp.ad-short }}:
      
              * `domain` — имя домена на контроллере домена {{ microsoft-idp.ad-short }}, в котором агент будет синхронизировать пользователей и группы.
              * `organization_units` — список Organization Units (OU) в каталоге {{ microsoft-idp.ad-short }}, в которых агент будет синхронизировать пользователей и группы.
              * `groups` — список групп пользователей в каталоге {{ microsoft-idp.ad-short }}, в которых агент будет синхронизировать пользователей. Вы можете указать одну или несколько групп, при этом фильтр по нескольким группам будет применяться с логикой `ИЛИ`.
      
                  {% note info %}
      
                  Параметр `groups` влияет только на синхронизацию пользователей и не влияет на настройки синхронизации групп пользователей.
      
                  {% endnote %}
      
              Если не настроить фильтрацию синхронизируемых объектов, агент {{ ad-sync-agent }} попытается синхронизировать все [доступные объекты](../concepts/ad-sync.md#sync-objects) в каталоге {{ microsoft-idp.ad-short }}.
          * `remove_user_behavior` — позволяет управлять действием в отношении пользователей на стороне {{ yandex-cloud }}, если соответствующие пользователи на стороне {{ microsoft-idp.ad-short }} были удалены или перестали удовлетворять условиям, заданным в параметрах `sync_settings.filter` (например, они были перенесены в другой Organization Unit). Необязательный параметр. Возможные значения:
      
              * `remove` — пользователи, удаленные или переставшие удовлетворять условиям фильтра, удаляются на стороне {{ org-full-name }}. Действие по умолчанию.
              * `block` — пользователи, удаленные или переставшие удовлетворять условиям фильтра, деактивируются на стороне {{ org-full-name }}.
      
          {% note info %}
      
          Если в процессе синхронизации выясняется, что на стороне {{ microsoft-idp.ad-short }} группа пользователей была удалена или перестала удовлетворять заданным фильтрам (например, она была перенесена в другой Organization Unit), то на стороне {{ org-full-name }} такая группа удаляется.
      
          {% endnote %}

  1. Запустите службу агента синхронизации:

      ```powershell
      Start-Service yc-identityhub-sync-agent
      ```
  1. Чтобы убедиться, что процесс синхронизации идет, посмотрите файл с логами агента. Например:

      ```bash
      cat C:\ProgramData\YcIdentityHubSyncAgent\identity_hub.log
      ```

      Результат синхронизации вы также можете посмотреть в интерфейсе сервиса [{{ org-full-name }}]({{ link-org-cloud-center }}) — в выбранном пуле пользователей должны создаться новые пользователи и группы, полученные из {{ microsoft-idp.ad-short }}.

  1. Чтобы остановить процесс синхронизации, остановите созданную службу:

      ```powershell
      Stop-Service yc-identityhub-sync-agent
      ```

      В результате процесс синхронизации пользователей и групп будет остановлен.

{% endlist %}

## Протестируйте изменения в конфигурации агента {#dry-run}

Агент {{ ad-sync-agent }} можно запустить в [тестовом режиме](../concepts/ad-sync.md#dry-run) (dry run). Этот режим позволяет убедиться в корректности вносимых в конфигурацию агента изменений прежде чем применять эти изменения в рабочем режиме.

Чтобы запустить агент в режиме dry run:

{% list tabs group=operating_system %}

- Linux {#linux}

  1. В терминале Linux остановите сервис агента синхронизации:

      ```bash
      sudo systemctl stop yc-identityhub-sync-agent
      ```
  1. Внесите в конфигурацию агента изменения, которые вы хотите протестировать.
  1. В секции `dry_run` файла конфигурации агента включите режим dry run:

      ```yml
      ...
      dry_run:
        enabled: true
      ...
      ```
  1. В терминале Linux вручную запустите исполняемый файл агента и дождитесь завершения его работы:

      ```bash
      ./yc-identityhub-sync-agent \
        --config /etc/yc-identityhub-sync-agent/config.yaml
      ```

      В результате в [логах](../concepts/ad-sync.md#logging) агента будут сохранены изменения, которые должны быть внесены в данные пользователей и групп {{ org-full-name }} в связи с изменениями, внесенными в конфигурацию агента.
      
      Например:
      
      ```text
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Users. Change type: Create. Successful: 10. Failed: 0
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Users. Change type: Update. Successful: 0. Failed: 0
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Users. Change type: Delete. Successful: 2. Failed: 0
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Users. Change type: Activate. Successful: 0. Failed: 0
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Users. Change type: Deactivate. Successful: 0. Failed: 0
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Users. Change type: PasswordHashUpdate. Successful: 300. Failed: 0
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Groups. Change type: Create. Successful: 5. Failed: 0
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Groups. Change type: Update. Successful: 0. Failed: 0
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Groups. Change type: Delete. Successful: 0. Failed: 0
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Memberships. Change type: Create. Successful: 30. Failed: 0
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Memberships. Change type: Delete. Successful: 0. Failed: 0
      ```
      
      Из приведенного примера видно, что после запуска синхронизации в {{ org-full-name }}:
      
      * будет создано 10 новых пользователей;
      * будет удалено 2 пользователя;
      * будут обновлены хеши паролей для 300 пользователей;
      * будет создано 5 групп пользователей;
      * будет добавлено 30 новых членств пользователей в группах.

  1. Если все сохраненные в файл логов изменения являются ожидаемыми, а операции не содержат ошибок, значит, внесенные в конфигурацию агента изменения корректны, и агент можно запускать в рабочем режиме:

      1. Отключите режим dry run, заменив в файле конфигурации в секции `dry_run` значение поля на `enabled: false`.
      1. В терминале Linux запустите сервис агента {{ ad-sync-agent }}, чтобы начать процесс синхронизации:

          ```bash
          sudo systemctl start yc-identityhub-sync-agent
          ```

- Windows {#windows}

  1. В терминале PowerShell остановите службу агента синхронизации:

      ```powershell
      Stop-Service yc-identityhub-sync-agent
      ```
  1. Внесите в конфигурацию агента изменения, которые вы хотите протестировать.
  1. В секции `dry_run` файла конфигурации агента включите режим dry run:

      ```yml
      ...
      dry_run:
        enabled: true
      ...
      ```
  1. В терминале PowerShell вручную запустите исполняемый файл агента и дождитесь завершения его работы:

      ```powershell
      ./yc-identityhub-sync-agent.exe \
        --config C:\ProgramData\YcIdentityHubSyncAgent\config.yaml
      ```

      В результате в [логах](../concepts/ad-sync.md#logging) агента будут сохранены изменения, которые должны быть внесены в данные пользователей и групп {{ org-full-name }} в связи с изменениями, внесенными в конфигурацию агента.
      
      Например:
      
      ```text
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Users. Change type: Create. Successful: 10. Failed: 0
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Users. Change type: Update. Successful: 0. Failed: 0
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Users. Change type: Delete. Successful: 2. Failed: 0
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Users. Change type: Activate. Successful: 0. Failed: 0
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Users. Change type: Deactivate. Successful: 0. Failed: 0
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Users. Change type: PasswordHashUpdate. Successful: 300. Failed: 0
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Groups. Change type: Create. Successful: 5. Failed: 0
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Groups. Change type: Update. Successful: 0. Failed: 0
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Groups. Change type: Delete. Successful: 0. Failed: 0
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Memberships. Change type: Create. Successful: 30. Failed: 0
      2026-04-22T06:46:35.504Z	info	synchronization/sync_process.go:542	Would synchronize Memberships. Change type: Delete. Successful: 0. Failed: 0
      ```
      
      Из приведенного примера видно, что после запуска синхронизации в {{ org-full-name }}:
      
      * будет создано 10 новых пользователей;
      * будет удалено 2 пользователя;
      * будут обновлены хеши паролей для 300 пользователей;
      * будет создано 5 групп пользователей;
      * будет добавлено 30 новых членств пользователей в группах.

  1. Если все сохраненные в файл логов изменения являются ожидаемыми, а операции не содержат ошибок, значит, внесенные в конфигурацию агента изменения корректны, и агент можно запускать в рабочем режиме:

      1. Отключите режим dry run, заменив в файле конфигурации в секции `dry_run` значение поля на `enabled: false`.
      1. В терминале PowerShell запустите службу агента {{ ad-sync-agent }}, чтобы начать процесс синхронизации:

          ```powershell
          Start-Service yc-identityhub-sync-agent
          ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](../concepts/ad-sync.md)