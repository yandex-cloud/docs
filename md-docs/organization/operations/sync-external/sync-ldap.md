[Документация Yandex Cloud](../../../index.md) > [Yandex Identity Hub](../../index.md) > [Пошаговые инструкции](../index.md) > [Синхронизация с внешними службами каталогов](index.md) > LDAP-совместимые службы каталогов

# Синхронизировать пользователей и группы с LDAP-совместимыми каталогами


Если для управления пользователями ваша компания использует службу каталогов, совместимую с протоколом [LDAP](https://ru.wikipedia.org/wiki/LDAP), и вы хотите организовать для ваших пользователей доступ к Yandex Cloud, вам не нужно создавать учетные записи для них вручную. Вместо этого вы можете настроить [синхронизацию](../../concepts/sync-external/ldap-sync.md) с Yandex Identity Hub пользователей и групп из вашего каталога.

## Подготовьте к синхронизации организацию Yandex Identity Hub {#prepare-org}

1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен [платежный аккаунт](../../../billing/concepts/billing-account.md) и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему [облако](../../../resource-manager/concepts/resources-hierarchy.md#cloud).
1. [Создайте](../user-pools/create-userpool.md) пул пользователей в Yandex Identity Hub и [привяжите](../user-pools/add-domain.md#userpool) к нему [домен](../../concepts/domains.md), идентичный домену, который используется для доступа к LDAP-серверу.

    Привязывать ваш собственный домен к [пулу пользователей](../../concepts/user-pools.md) не обязательно. Вместо этого вы можете привязать другой домен или выбрать домен по умолчанию. Но в этом случае в конфигурации [агента синхронизации](../../concepts/sync-external/ldap-sync.md#sync-agent) потребуется настроить подстановку домена в параметре `replacement_domain`. Подробнее читайте в разделе [Параметры конфигурации агента](#config-sync-settings).
1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) ему следующие роли на [организацию](../../concepts/organization.md), в которой находится нужный пул пользователей:

    * [`organization-manager.userpools.syncAgent`](../../security/index.md#organization-manager-userpools-syncAgent);
    * [`organization-manager.groups.viewer`](../../security/index.md#organization-manager-groups-viewer);
    * [`organization-manager.groups.externalCreator`](../../security/index.md#organization-manager-groups-externalCreator);
    * [`organization-manager.groups.externalConverter`](../../security/index.md#organization-manager-groups-externalConverter).
    
    Если вы планируете выгружать логи работы агента синхронизации в [лог-группу](../../../logging/concepts/log-group.md) Yandex Cloud Logging, дополнительно назначьте сервисному аккаунту [роль](../../../logging/security/index.md#logging-writer) `logging.writer` на соответствующую лог-группу или [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором она расположена.
1. (Опционально) [Создайте](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) и сохраните [авторизованный ключ](../../../iam/concepts/authorization/key.md) для вашего [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).

    {% note warning %}
    
    Авторизованный ключ не нужен, если агент синхронизации устанавливается на [виртуальную машину](../../../compute/concepts/vm.md) Yandex Compute Cloud, к которой привязан сервисный аккаунт с необходимыми правами доступа.
    
    {% endnote %}

## Подготовьте LDAP-сервер {#dc-setup}

Для корректной работы агента синхронизации на стороне LDAP-сервера выполните следующие действия:

1. Создайте аккаунт пользователя, от имени которого агент будет выполнять синхронизацию.
1. Выдайте этому аккаунту разрешения, необходимые для чтения информации о пользователях и изменения паролей (хешей паролей) пользователей.

    В зависимости от используемой службы каталогов механизм выдачи и названия конкретных разрешений различаются. В некоторых случаях также могут потребоваться дополнительные полномочия. Подробнее о необходимых разрешениях читайте в документации к используемой службе каталогов.
1. (Опционально) Если вы используете обратную запись паролей, в зависимости от используемой службы каталогов (например, [FreeIPA](https://www.freeipa.org/) и [ApacheDS™](https://directory.apache.org/apacheds/)), создайте дополнительный аккаунт пользователя, который позволит сбрасывать пароль пользователя без необходимости его смены после первого входа. Подробнее читайте в документации к используемой службе каталогов.
1. На LDAP-сервере откройте сетевые порты для входящего трафика, который поступает с IP-адреса сервера с установленным агентом Yandex Identity Hub Sync Agent:

    * `389 (TCP)` — для [LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/);
    * `636 (TCP)` — для [LDAPS](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/enable-ldap-over-ssl-3rd-certification-authority);
    * `53 (TCP/UDP)` и `88 (TCP/UDP)` — для [Kerberos](https://ru.wikipedia.org/wiki/Kerberos).

## Включите обратную запись паролей (опционально) {#enable-password-writeback}

Если вы планируете использовать [обратную запись паролей](../../concepts/sync-external/ldap-sync.md#password-writeback) из Yandex Identity Hub во внешний каталог, включите ее для пула пользователей в Yandex Identity Hub.

{% note info %}

Функциональность обратной записи паролей находится на стадии [Preview](../../../overview/concepts/launch-stages.md). Чтобы получить к ней доступ, обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

{% endnote %}

Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.

Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. Посмотрите описание команды CLI для создания настроек синхронизации:

    ```bash
    yc organization-manager idp synchronization-settings create --help
    ```

1. Создайте настройки синхронизации с включенной обратной записью паролей:

    ```bash
    yc organization-manager idp synchronization-settings create \
      --subject-container-id <идентификатор_пула_пользователей> \
      --filter "domain=<домен_во_внешнем_каталоге>" \
      --enable-password-writeback
    ```

    Где:

    * `--subject-container-id` — идентификатор [пула пользователей](../../concepts/user-pools.md), для которого создаются настройки синхронизации.
    * `--filter` — домен внешнего LDAP-каталога, который нужно синхронизировать. Укажите тот же домен, что и в параметре `sync_settings.filter.domain` конфигурации агента.
    * `--enable-password-writeback` — включает обратную запись паролей для пула пользователей.

При [настройке агента](#setup-agent) также задайте в его конфигурации параметр `enable_password_writeback: true` и настройки в секции `ldap.password_writeback`.

{% note warning %}

В некоторых внешних каталогах (например, [FreeIPA](https://www.freeipa.org/) и [ApacheDS™](https://directory.apache.org/apacheds/)) для выполнения обратной записи паролей необходим дополнительный аккаунт, который позволяет сбрасывать пароль пользователя без необходимости его смены после первого входа. Подробнее читайте в документации к используемой службе каталогов.

{% endnote %}

## Настройте и запустите агент синхронизации {#setup-agent}

Вы можете установить агент синхронизации на любой сервер под управлением ОС [Linux](https://ru.wikipedia.org/wiki/Linux) или [Windows](https://ru.wikipedia.org/wiki/Windows).

Если вы устанавливаете агент синхронизации на [виртуальную машину](../../../compute/concepts/vm.md) Yandex Compute Cloud, [подключите](../../../compute/operations/vm-control/vm-connect-sa.md) к этой виртуальной машине созданный [ранее](#prepare-org) сервисный аккаунт.

Прежде чем приступать к синхронизации, откройте на сервере, где вы будете запускать агент, следующие сетевые порты для входящего и исходящего сетевого трафика:

* Для обращения к API Yandex Cloud:

    * `443` — для [HTTPS](https://ru.wikipedia.org/wiki/HTTPS);

* Для обращения к LDAP-серверу:

    * `389 (TCP)` — для [LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/);
    * `636 (TCP)` — для [LDAPS](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/enable-ldap-over-ssl-3rd-certification-authority);
    * `53 (TCP/UDP)` и `88 (TCP/UDP)` — для [Kerberos](https://ru.wikipedia.org/wiki/Kerberos).

Если для аутентификации на стороне внешней службы каталогов вы планируете использовать протокол [Kerberos](https://ru.wikipedia.org/wiki/Kerberos), самостоятельно установите на сервер с агентом компоненты, необходимые для работы этого протокола, и создайте файл `keytab` с ключами шифрования.

Чтобы запустить синхронизацию пользователей и групп:

{% list tabs group=operating_system %}

- Linux {#linux}

  В терминале Linux:

  1. Чтобы установить агент Yandex Identity Hub Sync Agent, выполните команду:
     
     ```bash
     curl https://storage.yandexcloud.net/yc-identityhub-sync/install.sh | bash
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
  1. (Опционально) Если для аутентификации агента в API Yandex Cloud вы будете использовать авторизованный ключ сервисного аккаунта, скопируйте на ваш сервер файл с сохраненным ранее авторизованным ключом.
     
     Для этого вы можете воспользоваться командой `scp` или любым другим подходящим инструментом.
  1. В любом текстовом редакторе откройте [YAML](https://yaml.org/)-файл с конфигурацией агента синхронизации. В примере ниже используется редактор `nano`:
     
     ```bash
     nano /etc/yc-identityhub-sync-agent/config.yaml
     ```
  1. В открывшемся файле задайте конфигурацию агента синхронизации. Конфигурация зависит от способа аутентификации, используемого агентом на стороне LDAP-сервера, и задается в [YAML](https://yaml.org/)-файле в следующем формате:

      {% list tabs group=authentication_linux %}

      - По логину и паролю {#password_linux}

        ```yml
        # Default configuration for yc-identityhub-sync-agent
        # This is a template - please update with your actual values
        
        userpool_id: "<идентификатор_пула_пользователей>"
        working_directory: "<путь_к_рабочей_директории_агента>"
        
        # Validate config, static credentials, and configured keytab file permissions at startup.
        check_config_permissions: true|false
        
        # Yandex Cloud authentication settings
        
        # Use the cloud_credentials_file_path parameter for authentication via an authorized key.
        # If you want the agent to authenticate via IAM tokens, remove the cloud_credentials_file_path line.
        cloud_credentials_file_path: "<путь_к_файлу_с_авторизованным_ключом>"
        
        # Enable the use_metadata_service parameter for authentication via IAM tokens
        # (only available when the agent is installed on a Compute Cloud VM).
        # If `true`, the cloud_credentials_file_path parameter will be ignored.
        use_metadata_service: true|false
        
        # Enable Password Writeback so the agent can synchronize password changes
        # back from Yandex Identity Hub to the LDAP server.
        enable_password_writeback: true|false
        
        # Enable the Dry Run mode.
        # If `true`, no changes will be applied to users or groups in Yandex Identity Hub.
        # Instead, all pending operations will be saved to the current log file location.
        dry_run:
          enabled: true|false
        
        # LDAP client settings
        ldap:
          host: "ldaps://<адрес_LDAP-сервера>:636"
          username: "<DN_пользователя_во_внешнем_каталоге>"
          password: "<пароль_пользователя_во_внешнем_каталоге>"
          certificate_path: "<путь_к_CA_сертификату>"
          insecure_skip_verify: false|true
        
          # Additional settings required to enable password writeback. 
          password_writeback:
            flavor: "freeipa"   # Available options: freeipa (default), 389, and apache.
            permanent_reset:    # For ApacheDS/FreeIPA the agent requires credentials of an additional account with privileges sufficient to reset users' passwords without requiring the users to change it at first login.
              username: "<DN_пользователя_во_внешнем_каталоге>"
              password: "<пароль_пользователя_во_внешнем_каталоге>"
        
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
            # The following syntax allows to reconfigure the default mapping ('cn' --> 'name')
            # to custom mapping ('CustomAttributeName' --> 'name')
            - source: "CustomAttributeName"
              target: "Name"
              type: "direct"
            # The following syntax allows to disable synchronization for attribute 'description'
            - source: ""
              target: "Description"
              type: "empty"
          filter:
            domain: "<имя_домена_во_внешнем_каталоге>"
            groups:
              - "GroupName1"
              - "GroupName2"
          remove_user_behavior: "remove|block"
        
          # Additional settings required for synchronization with a specific external LDAP directory.
          ldap_settings:
            external_id_attribute: "ipaUniqueID"  # Attribute that contains unique record ID in the external LDAP directory.
            dn_attribute: "entryDN"  # LDAP operational attribute that contains an entry's DN.
            user_object_class: "inetOrgPerson"  # Object class used by user objects.
            group_object_class: "ipausergroup"  # Object class used by group objects.
            account_disabled_attribute: "nsAccountLock"  # Attribute that indicates whether a user is active or inactive.
            account_disabled_value: "TRUE"  # Value of the attribute set in account_disabled_attribute, that indicates that an account is disabled.
            account_enabled_value: "FALSE"  # Value of the attribute set in account_disabled_attribute, that indicates that an account is enabled.
            password_attribute: "userPassword"  # Attribute that contains a user's password (hash).
            delta_sync_mode: "full_sync"
        ```

        Описание полей приведено в разделе [Параметры конфигурации агента](#agent-config).

      - По протоколу Kerberos {#kerberos_linux}

        ```yml
        # Default configuration for yc-identityhub-sync-agent
        # This is a template - please update with your actual values
        
        userpool_id: "<идентификатор_пула_пользователей>"
        working_directory: "<путь_к_рабочей_директории_агента>"
        
        # Validate config, static credentials, and configured keytab file permissions at startup.
        check_config_permissions: true|false
        
        # Yandex Cloud authentication settings
        
        # Use the cloud_credentials_file_path parameter for authentication via an authorized key.
        # If you want the agent to authenticate via IAM tokens, remove the cloud_credentials_file_path line.
        cloud_credentials_file_path: "<путь_к_файлу_с_авторизованным_ключом>"
        
        # Enable the use_metadata_service parameter for authentication via IAM tokens
        # (only available when the agent is installed on a Compute Cloud VM).
        # If `true`, the cloud_credentials_file_path parameter will be ignored.
        use_metadata_service: true|false
        
        # Enable Password Writeback so the agent can synchronize password changes
        # back from Yandex Identity Hub to the LDAP server.
        enable_password_writeback: true|false
        
        # Enable the Dry Run mode.
        # If `true`, no changes will be applied to users or groups in Yandex Identity Hub.
        # Instead, all pending operations will be saved to the current log file location.
        dry_run:
          enabled: true|false
        
        # LDAP client settings
        ldap:
          host: "ldaps://<адрес_LDAP-сервера>:636"
          certificate_path: "<путь_к_CA_сертификату>"
          insecure_skip_verify: false|true
          use_kerberos: true
        
          # Additional settings required to enable password writeback. 
          password_writeback:
            flavor: "freeipa"   # Available options: freeipa (default), 389, and apache.
            permanent_reset:    # For ApacheDS/FreeIPA the agent requires credentials of an additional account with privileges sufficient to reset users' passwords without requiring the users to change it at first login.
              kerberos:
                keytab_path: "<путь_к_файлу_keytab_дополнительного_аккаунта>"
                principal: "<SPN_дополнительного_аккаунта>"
                krb5_config_path: "<путь_к_файлу_конфигурации_Kerberos>"  # optional, the default location is /etc/krb5.conf or whatever path is set in the KRB5_CONFIG environment variable
                disable_pa_fx_fast: true
        
        # Kerberos settings
        kerberos:
          keytab_path: "<путь_к_файлу_keytab_основного_аккаунта>"
          principal: "<SPN_основного_аккаунта_во_внешнем_каталоге>"
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
            # The following syntax allows to reconfigure the default mapping ('cn' --> 'name')
            # to custom mapping ('CustomAttributeName' --> 'name')
            - source: "CustomAttributeName"
              target: "Name"
              type: "direct"
            # The following syntax allows to disable synchronization for attribute 'description'
            - source: ""
              target: "Description"
              type: "empty"
          filter:
            domain: "<имя_домена_во_внешнем_каталоге>"
            groups:
              - "GroupName1"
              - "GroupName2"
          remove_user_behavior: "remove|block"
        
          # Additional settings required for synchronization with a specific external LDAP directory.
          ldap_settings:
            external_id_attribute: "ipaUniqueID"  # Attribute that contains unique record ID in the external LDAP directory.
            dn_attribute: "entryDN"  # LDAP operational attribute that contains an entry's DN.
            user_object_class: "inetOrgPerson"  # Object class used by user objects.
            group_object_class: "ipausergroup"  # Object class used by group objects.
            account_disabled_attribute: "nsAccountLock"  # Attribute that indicates whether a user is active or inactive.
            account_disabled_value: "TRUE"  # Value of the attribute set in account_disabled_attribute, that indicates that an account is disabled.
            account_enabled_value: "FALSE"  # Value of the attribute set in account_disabled_attribute, that indicates that an account is enabled.
            password_attribute: "userPassword"  # Attribute that contains a user's password (hash).
            delta_sync_mode: "full_sync"
        ```

        Описание полей приведено в разделе [Параметры конфигурации агента](#agent-config).

      {% endlist %}

  1. Запустите сервис агента Yandex Identity Hub Sync Agent, чтобы начать процесс синхронизации:

      ```bash
      sudo systemctl start yc-identityhub-sync-agent
      ```
  1. Чтобы убедиться, что процесс синхронизации идет, посмотрите файл с логами агента. Например:

      ```bash
      sudo cat /etc/yc-identityhub-sync-agent/identity_hub.log
      ```

      Результат синхронизации вы также можете посмотреть в интерфейсе сервиса [Yandex Identity Hub](https://center.yandex.cloud/organization) — в выбранном пуле пользователей должны создаться новые пользователи и группы, полученные из внешнего каталога.

  1. Чтобы остановить синхронизацию, остановите запущенный процесс агента синхронизации:

      ```bash
      sudo systemctl stop yc-identityhub-sync-agent
      ```

      В результате процесс синхронизации пользователей и групп будет остановлен.

- Windows {#windows}

  В терминале PowerShell:

  1. Чтобы установить агент Yandex Identity Hub Sync Agent, выполните команду:
     
     ```bash
     iex (New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yc-identityhub-sync/install.ps1')
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
  1. В любом текстовом редакторе откройте [YAML](https://yaml.org/)-файл конфигурации агента `config.yaml`, расположенный в папке `C:\ProgramData\YcIdentityHubSyncAgent\`.
  1. В открывшемся файле задайте конфигурацию агента синхронизации. Конфигурация зависит от способа аутентификации, используемого агентом на стороне LDAP-сервера, и задается в [YAML](https://yaml.org/)-файле в следующем формате:

      {% list tabs group=authentication_windows %}

      - По логину и паролю {#password_windows}

        ```yml
        # Default configuration for yc-identityhub-sync-agent
        # This is a template - please update with your actual values
        
        userpool_id: "<идентификатор_пула_пользователей>"
        working_directory: "<путь_к_рабочей_директории_агента>"
        
        # Validate config, static credentials, and configured keytab file permissions at startup.
        check_config_permissions: true|false
        
        # Yandex Cloud authentication settings
        
        # Use the cloud_credentials_file_path parameter for authentication via an authorized key.
        # If you want the agent to authenticate via IAM tokens, remove the cloud_credentials_file_path line.
        cloud_credentials_file_path: "<путь_к_файлу_с_авторизованным_ключом>"
        
        # Enable the use_metadata_service parameter for authentication via IAM tokens
        # (only available when the agent is installed on a Compute Cloud VM).
        # If `true`, the cloud_credentials_file_path parameter will be ignored.
        use_metadata_service: true|false
        
        # Enable Password Writeback so the agent can synchronize password changes
        # back from Yandex Identity Hub to the LDAP server.
        enable_password_writeback: true|false
        
        # Enable the Dry Run mode.
        # If `true`, no changes will be applied to users or groups in Yandex Identity Hub.
        # Instead, all pending operations will be saved to the current log file location.
        dry_run:
          enabled: true|false
        
        # LDAP client settings
        ldap:
          host: "ldaps://<адрес_LDAP-сервера>:636"
          username: "<DN_пользователя_во_внешнем_каталоге>"
          password: "<пароль_пользователя_во_внешнем_каталоге>"
          certificate_path: "<путь_к_CA_сертификату>"
          insecure_skip_verify: false|true
        
          # Additional settings required to enable password writeback. 
          password_writeback:
            flavor: "freeipa"   # Available options: freeipa (default), 389, and apache.
            permanent_reset:    # For ApacheDS/FreeIPA the agent requires credentials of an additional account with privileges sufficient to reset users' passwords without requiring the users to change it at first login.
              username: "<DN_пользователя_во_внешнем_каталоге>"
              password: "<пароль_пользователя_во_внешнем_каталоге>"
        
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
            # The following syntax allows to reconfigure the default mapping ('cn' --> 'name')
            # to custom mapping ('CustomAttributeName' --> 'name')
            - source: "CustomAttributeName"
              target: "Name"
              type: "direct"
            # The following syntax allows to disable synchronization for attribute 'description'
            - source: ""
              target: "Description"
              type: "empty"
          filter:
            domain: "<имя_домена_во_внешнем_каталоге>"
            groups:
              - "GroupName1"
              - "GroupName2"
          remove_user_behavior: "remove|block"
        
          # Additional settings required for synchronization with a specific external LDAP directory.
          ldap_settings:
            external_id_attribute: "ipaUniqueID"  # Attribute that contains unique record ID in the external LDAP directory.
            dn_attribute: "entryDN"  # LDAP operational attribute that contains an entry's DN.
            user_object_class: "inetOrgPerson"  # Object class used by user objects.
            group_object_class: "ipausergroup"  # Object class used by group objects.
            account_disabled_attribute: "nsAccountLock"  # Attribute that indicates whether a user is active or inactive.
            account_disabled_value: "TRUE"  # Value of the attribute set in account_disabled_attribute, that indicates that an account is disabled.
            account_enabled_value: "FALSE"  # Value of the attribute set in account_disabled_attribute, that indicates that an account is enabled.
            password_attribute: "userPassword"  # Attribute that contains a user's password (hash).
            delta_sync_mode: "full_sync"
        ```

        Описание полей приведено в разделе [Параметры конфигурации агента](#agent-config).

      - По протоколу Kerberos {#kerberos_windows}

        ```yml
        # Default configuration for yc-identityhub-sync-agent
        # This is a template - please update with your actual values
        
        userpool_id: "<идентификатор_пула_пользователей>"
        working_directory: "<путь_к_рабочей_директории_агента>"
        
        # Validate config, static credentials, and configured keytab file permissions at startup.
        check_config_permissions: true|false
        
        # Yandex Cloud authentication settings
        
        # Use the cloud_credentials_file_path parameter for authentication via an authorized key.
        # If you want the agent to authenticate via IAM tokens, remove the cloud_credentials_file_path line.
        cloud_credentials_file_path: "<путь_к_файлу_с_авторизованным_ключом>"
        
        # Enable the use_metadata_service parameter for authentication via IAM tokens
        # (only available when the agent is installed on a Compute Cloud VM).
        # If `true`, the cloud_credentials_file_path parameter will be ignored.
        use_metadata_service: true|false
        
        # Enable Password Writeback so the agent can synchronize password changes
        # back from Yandex Identity Hub to the LDAP server.
        enable_password_writeback: true|false
        
        # Enable the Dry Run mode.
        # If `true`, no changes will be applied to users or groups in Yandex Identity Hub.
        # Instead, all pending operations will be saved to the current log file location.
        dry_run:
          enabled: true|false
        
        # LDAP client settings
        ldap:
          host: "ldaps://<адрес_LDAP-сервера>:636"
          certificate_path: "<путь_к_CA_сертификату>"
          insecure_skip_verify: false|true
          use_kerberos: true
        
          # Additional settings required to enable password writeback. 
          password_writeback:
            flavor: "freeipa"   # Available options: freeipa (default), 389, and apache.
            permanent_reset:    # For ApacheDS/FreeIPA the agent requires credentials of an additional account with privileges sufficient to reset users' passwords without requiring the users to change it at first login.
              kerberos:
                keytab_path: "<путь_к_файлу_keytab_дополнительного_аккаунта>"
                principal: "<SPN_дополнительного_аккаунта>"
                krb5_config_path: "<путь_к_файлу_конфигурации_Kerberos>"  # optional, the default location is /etc/krb5.conf or whatever path is set in the KRB5_CONFIG environment variable
                disable_pa_fx_fast: true
        
        # Kerberos settings
        kerberos:
          keytab_path: "<путь_к_файлу_keytab_основного_аккаунта>"
          principal: "<SPN_основного_аккаунта_во_внешнем_каталоге>"
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
            # The following syntax allows to reconfigure the default mapping ('cn' --> 'name')
            # to custom mapping ('CustomAttributeName' --> 'name')
            - source: "CustomAttributeName"
              target: "Name"
              type: "direct"
            # The following syntax allows to disable synchronization for attribute 'description'
            - source: ""
              target: "Description"
              type: "empty"
          filter:
            domain: "<имя_домена_во_внешнем_каталоге>"
            groups:
              - "GroupName1"
              - "GroupName2"
          remove_user_behavior: "remove|block"
        
          # Additional settings required for synchronization with a specific external LDAP directory.
          ldap_settings:
            external_id_attribute: "ipaUniqueID"  # Attribute that contains unique record ID in the external LDAP directory.
            dn_attribute: "entryDN"  # LDAP operational attribute that contains an entry's DN.
            user_object_class: "inetOrgPerson"  # Object class used by user objects.
            group_object_class: "ipausergroup"  # Object class used by group objects.
            account_disabled_attribute: "nsAccountLock"  # Attribute that indicates whether a user is active or inactive.
            account_disabled_value: "TRUE"  # Value of the attribute set in account_disabled_attribute, that indicates that an account is disabled.
            account_enabled_value: "FALSE"  # Value of the attribute set in account_disabled_attribute, that indicates that an account is enabled.
            password_attribute: "userPassword"  # Attribute that contains a user's password (hash).
            delta_sync_mode: "full_sync"
        ```

        Описание полей приведено в разделе [Параметры конфигурации агента](#agent-config).

      {% endlist %}

  1. Запустите службу агента синхронизации:

      ```powershell
      Start-Service yc-identityhub-sync-agent
      ```
  1. Чтобы убедиться, что процесс синхронизации идет, посмотрите файл с логами агента. Например:

      ```bash
      cat C:\ProgramData\YcIdentityHubSyncAgent\identity_hub.log
      ```

      Результат синхронизации вы также можете посмотреть в интерфейсе сервиса [Yandex Identity Hub](https://center.yandex.cloud/organization) — в выбранном пуле пользователей должны создаться новые пользователи и группы, полученные из внешнего каталога.

  1. Чтобы остановить процесс синхронизации, остановите созданную службу:

      ```powershell
      Stop-Service yc-identityhub-sync-agent
      ```

      В результате процесс синхронизации пользователей и групп будет остановлен.

{% endlist %}

## Протестируйте изменения в конфигурации агента {#dry-run}

Агент Yandex Identity Hub Sync Agent можно запустить в [тестовом режиме](../../concepts/sync-external/ldap-sync.md#dry-run) (dry run). Этот режим позволяет убедиться в корректности вносимых в конфигурацию агента изменений, прежде чем применять эти изменения в рабочем режиме.

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

      В результате в логах агента будут сохранены изменения, которые должны быть внесены в данные пользователей и групп Yandex Identity Hub в связи с изменениями, внесенными в конфигурацию агента.
      
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
      
      Из приведенного примера видно, что после запуска синхронизации в Yandex Identity Hub:
      
      * будет создано 10 новых пользователей;
      * будет удалено 2 пользователя;
      * будут обновлены хеши паролей для 300 пользователей;
      * будет создано 5 групп пользователей;
      * будет добавлено 30 новых членств пользователей в группах.

  1. Если все сохраненные в файл логов изменения являются ожидаемыми, а операции не содержат ошибок, значит, внесенные в конфигурацию агента изменения корректны, и агент можно запускать в рабочем режиме:

      1. Отключите режим dry run, заменив в файле конфигурации в секции `dry_run` значение поля на `enabled: false`.
      1. В терминале Linux запустите сервис агента Yandex Identity Hub Sync Agent, чтобы начать процесс синхронизации:

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

      В результате в логах агента будут сохранены изменения, которые должны быть внесены в данные пользователей и групп Yandex Identity Hub в связи с изменениями, внесенными в конфигурацию агента.
      
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
      
      Из приведенного примера видно, что после запуска синхронизации в Yandex Identity Hub:
      
      * будет создано 10 новых пользователей;
      * будет удалено 2 пользователя;
      * будут обновлены хеши паролей для 300 пользователей;
      * будет создано 5 групп пользователей;
      * будет добавлено 30 новых членств пользователей в группах.

  1. Если все сохраненные в файл логов изменения являются ожидаемыми, а операции не содержат ошибок, значит, внесенные в конфигурацию агента изменения корректны, и агент можно запускать в рабочем режиме:

      1. Отключите режим dry run, заменив в файле конфигурации в секции `dry_run` значение поля на `enabled: false`.
      1. В терминале PowerShell запустите службу агента Yandex Identity Hub Sync Agent, чтобы начать процесс синхронизации:

          ```powershell
          Start-Service yc-identityhub-sync-agent
          ```

{% endlist %}

{% note info %}

Если на стороне внешнего каталога для учетной записи пользователя в поле `shadowExpire` (класс `posixAccount`) задан срок действия, агент синхронизирует это значение с полем **Дата деактивации** (`expires_at`) в свойствах локального пользователя Yandex Identity Hub. При наступлении момента, который [указан](*shadow_expire_format) в этом поле, локальный пользователь Yandex Identity Hub будет автоматически [деактивирован](../user-pools/deactivate-user.md).

В этом случае, чтобы повторно активировать пользователя, измените или удалите срок действия для учетной записи пользователя в поле `shadowExpire` на стороне внешнего каталога.

[*shadow_expire_format]: Значение поля `shadowExpire` указывается в формате числа, которое равно количеству дней, прошедших с 01.01.1970. Момент окончания срока действия аккаунта определяется как конец указанного дня ([UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время)). Если значение отрицательное или отсутствует, значит, срок действия аккаунта не задан.

{% endnote %}

## Параметры конфигурации агента {#agent-config}

В файле `config.yaml` задайте параметры подключения и синхронизации.

Для подключения к LDAP-серверу выберите настройки `ldap`, которые соответствуют вашему способу аутентификации:

* По логину и паролю — укажите учетные данные пользователя домена.
* По протоколу Kerberos — дополнительно заполните секцию `kerberos`.

Параметры сгруппированы по назначению:

* Подключение к Yandex Cloud:

    * [userpool_id](#config-userpool-id);
    * [cloud_credentials_file_path](#config-cloud-credentials-file-path);
    * [use_metadata_service](#config-use-metadata-service).

* Файлы агента:

    * [working_directory](#config-working-directory);
    * [check_config_permissions](#config-check-config-permissions).

* Подключение к LDAP-серверу:

    * [ldap](#config-ldap);
    * [kerberos](#config-kerberos).

* Синхронизация:

    * [sync_settings](#config-sync-settings);
    * [enable_password_writeback](#config-enable-password-writeback);
    * [dry_run](#config-dry-run).

* Логи:

    * [logger](#config-logger).

### userpool_id {#config-userpool-id}

Идентификатор [пула пользователей](../../concepts/user-pools.md) в Yandex Identity Hub.

### working_directory {#config-working-directory}

Путь к директории, в которой сохраняются файлы, необходимые агенту для работы. Необязательный параметр.

Если параметр не задан, в качестве рабочей директории используется директория, в которой расположен исполняемый файл агента. По умолчанию исполняемый файл агента располагается в следующих директориях:

* `/etc/yc-identityhub-sync-agent/` (для Linux);
* `C:\\ProgramData\\YcIdentityHubSyncAgent\\` (для Windows).

### check_config_permissions {#config-check-config-permissions}

Настройки проверки прав доступа к файлам с аутентификационными данными, которая выполняется при запуске агента. Необязательный параметр. Возможные значения:

* `true` — проверка прав доступа к файлам конфигурации агента, которые содержат чувствительные данные, включена.
* `false` — проверка прав доступа к файлам конфигурации агента отключена. Значение по умолчанию.

### cloud_credentials_file_path {#config-cloud-credentials-file-path}

Путь к файлу, содержащему [авторизованный ключ](../../../iam/concepts/authorization/key.md) сервисного аккаунта в Yandex Cloud. Необязательный параметр: используется только при аутентификации агента в API Yandex Cloud с помощью авторизованного ключа.

Примеры значений:

* `/etc/yc-identityhub-sync-agent/authorized_key.json` (для Linux);
* `C:\\ProgramData\\YcIdentityHubSyncAgent\\authorized_key.json` (для Windows).

В параметре `cloud_credentials_file_path` вместо полного пути вы можете передать только имя файла. В этом случае файл будет сохранен в рабочей директории, заданной в параметре `working_directory`, или, если рабочая директория не задана, — в директории, в которой расположен исполняемый файл агента.

{% note info %}

Если в параметрах `cloud_credentials_file_path` и/или `logger.file.filename` заданы пути, отличные от пути, заданного в параметре `working_directory`, для выбранных сущностей будут использоваться пути, указанные в параметрах `cloud_credentials_file_path` и/или `logger.file.filename`.

{% endnote %}

### use_metadata_service {#config-use-metadata-service}

Параметр, управляющий аутентификацией агента в API Yandex Cloud с помощью [IAM-токена](../../../iam/concepts/authorization/iam-token.md) и позволяющий агенту получать IAM-токены через [сервис метаданных](../../../compute/concepts/vm-metadata.md) ВМ.

Возможные значения:

* `true` — агент синхронизации будет получать IAM-токены сервисного аккаунта через сервис метаданных виртуальной машины и использовать их для аутентификации в API Yandex Cloud. Значение параметра `cloud_credentials_file_path` при этом будет игнорироваться.

    Чтобы агент мог получать IAM-токены, он должен быть установлен на виртуальной машине Yandex Compute Cloud, к которой подключен сервисный аккаунт с [необходимыми](#prepare-org) правами доступа.
* `false` — агент синхронизации не будет получать IAM-токены, а аутентификация в API Yandex Cloud будет выполняться с помощью авторизованного ключа, заданного в параметре `cloud_credentials_file_path`.

### enable_password_writeback {#config-enable-password-writeback}

Параметр, управляющий [обратной записью паролей](../../concepts/sync-external/ldap-sync.md#password-writeback) пользователей во внешний каталог.

{% note info %}

Функциональность обратной записи паролей находится на стадии [Preview](../../../overview/concepts/launch-stages.md). Чтобы получить к ней доступ, обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

{% endnote %}

Возможные значения:

* `true` — при попытке изменить пароль синхронизированного пользователя на стороне Yandex Identity Hub ([изменение пароля](../manage-account.md#edit-password) самим пользователем или [сброс пароля](../user-pools/reset-user-password.md#reset) администратором) агент сначала попытается изменить пароль соответствующего пользователя во внешнем каталоге. И только в случае успеха этой операции агент изменит пароль в Yandex Identity Hub.
* `false` — при изменении пароля синхронизированного пользователя на стороне Yandex Identity Hub пароль этого пользователя не будет изменен во внешнем каталоге. В процессе ближайшей итерации синхронизации агент вернет на стороне Yandex Identity Hub пароль этого пользователя к прежнему значению, полученному из внешнего каталога. Это также поведение по умолчанию, если функциональность обратной записи не активирована.

Для корректной работы обратной записи паролей настройте также [раздел](#config-ldap) `ldap.password_writeback` конфигурации агента синхронизации.

### dry_run {#config-dry-run}

Настройки тестового запуска агента (dry run):

* `enabled: true` — активирован режим dry run. Агент не вносит изменения в данные пользователей и групп Yandex Identity Hub. Вместо этого он тестирует выполнение всех предусмотренных конфигурацией агента операций и сохраняет результаты этих тестов в логах его работы.
* `enabled: false` — агент функционирует в рабочем режиме, необходимые изменения вносятся в данные пользователей и групп Yandex Identity Hub.

### ldap {#config-ldap}

Настройки протокола [LDAPS](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/enable-ldap-over-ssl-3rd-certification-authority)/[LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/) для аутентификации на стороне LDAP-сервера:

{% note warning %}

Вы можете подключаться к LDAP-серверу по протоколу `LDAPS` или `LDAP`. Рекомендованным и безопасным протоколом является `LDAPS`. Протокол `LDAP` используйте только при настройке и тестировании.

{% endnote %}

* `host` — домен или IP-адрес LDAP-сервера. В зависимости от используемого протокола указываются схема и номер порта:

    * при использовании `LDAPS` — схема `ldaps://` и порт `636`;
    * при использовании `LDAP` — схема `ldap://` и порт `389`.
* `certificate_path` — путь к файлу с корневым сертификатом удостоверяющего центра (CA), которым подписан сертификат LDAP-сервера. Необязательный параметр.

    Укажите этот параметр, если вы используете протокол `LDAPS` и корневой сертификат отсутствует в системном хранилище доверенных сертификатов.

    Если в параметре `working_directory` задан путь к рабочей директории, вместо пути к файлу сертификата достаточно указать имя этого файла.
* `insecure_skip_verify` — параметр, позволяющий игнорировать ошибки валидации сертификата открытого ключа при подключении к LDAP-серверу. Необязательный параметр. Возможные значения:

    * `false` — ошибки валидации сертификата не будут игнорироваться. Значение по умолчанию.
    * `true` — агент синхронизации будет игнорировать ошибки валидации сертификата. Может быть полезно при настройке и тестировании синхронизации. Не рекомендуется использовать в рабочем режиме.
* `password_writeback` — дополнительные настройки, необходимые для корректной работы обратной записи паролей:

    * `flavor` — тип LDAP-каталога, с которым выполняется синхронизация. Возможные значения:

        * `freeipa` — [FreeIPA](https://www.freeipa.org/) (значение по умолчанию).
        * `apache` — [ApacheDS™](https://directory.apache.org/apacheds/).
        * `389` — [389 Directory Server](https://www.port389.org/).
    * `permanent_reset` — данные дополнительной учетной записи во внешнем каталоге с правами на изменение паролей пользователей без требования к пользователям менять пароль при первом входе. Задавайте настройки в разделе `permanent_reset` только если настраиваете синхронизацию с каталогом FreeIPA или ApacheDS™.

        В зависимости от способа аутентификации задайте следующие параметры учетной записи:

        {% list tabs group=authentication %}

        - По логину и паролю {#password}

          * `username` — DN учетной записи.
          * `password` — пароль учетной записи.

        - По протоколу Kerberos {#kerberos}

          * `kerberos` — подраздел с настройками Kerberos:

              * `keytab_path` — путь к файлу `keytab` с ключами шифрования дополнительного аккаунта, необходимого для изменения паролей.
              * `principal` — [SPN](https://learn.microsoft.com/en-us/windows/win32/ad/service-principal-names) дополнительного аккаунта, необходимого для изменения паролей.
              * `krb5_config_path` — путь к файлу конфигурации Kerberos. Необязательный параметр. По умолчанию используется путь `/etc/krb5.conf` или значение, заданное в переменной окружения `KRB5_CONFIG`.
              * `disable_pa_fx_fast: true` — параметр, управляющий режимом [FAST](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831747(v=ws.11)#kerberos-armoring-flexible-authentication-secure-tunneling-fast).

        {% endlist %}

        {% note warning %}

        В разделе файла конфигурации `ldap.password_writeback.permanent_reset` настраиваются учетные данные, необходимые для корректной работы обратной записи паролей пользователей.

        Параметры учетных данных, от имени которых агент будет читать информацию на стороне LDAP-сервера, задаются в полях `ldap.username`/`ldap.password` или [разделе](#config-kerberos) `kerberos`.

        {% endnote %}

#### Аутентификация агента по логину и паролю {#config-ldap-password}

* `username` — [DN](https://learn.microsoft.com/en-us/previous-versions/windows/desktop/ldap/distinguished-names) учетной записи в LDAP-каталоге, которой назначены [необходимые права](../../concepts/sync-external/ldap-sync.md#dc-setup) на чтение данных в каталоге.
* `password` — пароль к учетной записи с правами на чтение данных в LDAP-каталоге.

#### Аутентификация агента по протоколу Kerberos {#config-ldap-kerberos}

* `use_kerberos` — параметр, указывающий на необходимость использовать протокол Kerberos для аутентификации пользователя с правами на чтение данных на стороне LDAP-сервера.

### kerberos {#config-kerberos}

Настройки протокола Kerberos для аутентификации на стороне LDAP-сервера:

* `keytab_path` — путь к файлу `keytab` с ключами шифрования основного аккаунта.
* `principal` — [SPN](https://learn.microsoft.com/en-us/windows/win32/ad/service-principal-names) основного аккаунта для подключения к LDAP-серверу.
* `krb5_config_path` — путь к файлу конфигурации Kerberos. Необязательный параметр. По умолчанию используется путь `/etc/krb5.conf` или значение, заданное в переменной окружения `KRB5_CONFIG`.
* `disable_pa_fx_fast: true` — параметр, управляющий режимом [FAST](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831747(v=ws.11)#kerberos-armoring-flexible-authentication-secure-tunneling-fast).

### logger {#config-logger}

Настройки логирования процесса синхронизации:

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
* `cloud_logger` — настройки сохранения логов в [лог-группу](../../../logging/concepts/log-group.md) Yandex Cloud Logging:

    * `log_group_id` — идентификатор лог-группы, в которую будут выгружаться логи работы агента синхронизации.

    Необязательный параметр. Если настройки в разделе `cloud_logger` не заданы, события не будут выгружаться в лог-группу.

    Чтобы выгружать логи работы агента синхронизации в лог-группу, дополнительно назначьте сервисному аккаунту [роль](../../../logging/security/index.md#logging-writer) `logging.writer` на соответствующую лог-группу или [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором она расположена.

{% note info %}

Если настройки в разделах `logger.file` и `logger.cloud_logger` не заданы, информация о событиях и ошибках будет выводиться в стандартный поток `stdout`. В противном случае логи будут сохраняться в файлы и/или лог-группу.

{% endnote %}

### sync_settings {#config-sync-settings}

Настройки процесса синхронизации:

* `interval` — периодичность выполнения синхронизации. Необязательный параметр. Значение по умолчанию — 240 секунд.
* `allow_to_capture_users` — параметр, позволяющий изменять существующего пользователя пула Yandex Identity Hub при совпадении его логина с логином пользователя внешнего каталога, которого требуется синхронизировать. Возможные значения:

    * `true` — агент синхронизации будет изменять существующих пользователей Yandex Identity Hub, приводя их в соответствие с учетными записями во внешнем каталоге.
    * `false` — агент синхронизации не будет изменять существующих пользователей Yandex Identity Hub. При обнаружении совпадения логинов пользователя в пуле и во внешнем каталоге процесс синхронизации выдаст ошибку.
* `allow_to_capture_groups` — параметр, позволяющий изменять существующую группу пользователей Yandex Identity Hub при совпадении ее имени с именем группы во внешнем каталоге, которую требуется синхронизировать. Возможные значения:

    * `true` — агент синхронизации будет изменять существующие группы пользователей Yandex Identity Hub, приводя их в соответствие с группами во внешнем каталоге.
    * `false` — агент синхронизации не будет изменять существующие группы пользователей Yandex Identity Hub. При обнаружении совпадения имен групп в пуле и во внешнем каталоге процесс синхронизации выдаст ошибку.
* `replacement_domain` — [домен](../../concepts/domains.md), привязанный к пулу пользователей Yandex Identity Hub, в котором находятся синхронизируемые пользователи и группы. Например: `newdomain.idp.yandexcloud.net`.

    Необязательный параметр. Значение параметра `replacement_domain` нужно задавать только в том случае, если имя домена, привязанного к пулу пользователей, отличается от имени домена, который используется внешним каталогом.
* `user_attribute_mapping` — настройки сопоставления атрибутов пользователя:

    * `source` — имя атрибута пользователя, получаемое из внешнего каталога и отличное от имени, которое [задано по умолчанию](../../concepts/sync-external/ldap-sync.md#sync-objects).

        Если вы хотите отключить синхронизацию атрибута, оставьте значение пустым: `source: ""`.
    * `target` — имя атрибута на стороне Yandex Cloud, с которым настраивается сопоставление (или для которого отключается синхронизация). Список доступных значений смотрите в таблице **Атрибуты пользователей** в разделе [Объекты синхронизации](../../concepts/sync-external/ldap-sync.md#sync-objects).
    * `type` — выбор действия в отношении указанного атрибута. Возможные значения:

        * `direct` — настроить сопоставление атрибутов.
        * `empty` — отключить синхронизацию атрибута.
    Необязательный параметр. Значение параметра `user_attribute_mapping` необходимо задавать только в том случае, если требуется настроить сопоставление имен атрибутов пользователя, отличных от заданных по умолчанию для внешнего каталога, или отключить синхронизацию отдельных атрибутов.
* `group_attribute_mapping` — настройки сопоставления атрибутов групп пользователей:

    * `source` — имя атрибута групп пользователей, получаемое из внешнего каталога и отличное от имени, которое [задано по умолчанию](../../concepts/sync-external/ldap-sync.md#sync-objects).

        Если вы хотите отключить синхронизацию атрибута, оставьте значение пустым: `source: ""`.
    * `target` — имя атрибута на стороне Yandex Cloud, с которым настраивается сопоставление (или для которого отключается синхронизация). Список доступных значений смотрите в таблице **Атрибуты групп пользователей** в разделе [Объекты синхронизации](../../concepts/sync-external/ldap-sync.md#sync-objects).
    * `type` — выбор действия в отношении указанного атрибута. Возможные значения:

        * `direct` — настроить сопоставление атрибутов.
        * `empty` — отключить синхронизацию атрибута.
    Необязательный параметр. Значение параметра `group_attribute_mapping` необходимо задавать только в том случае, если требуется настроить сопоставление имен атрибутов групп пользователей, отличных от заданных по умолчанию для внешнего каталога, или отключить синхронизацию отдельных атрибутов.
* `filter` — настройки фильтрации синхронизируемых объектов на стороне внешнего каталога:

    * `domain` — имя домена на LDAP-сервере, в котором агент будет синхронизировать пользователей и группы.
    * `groups` — список групп пользователей во внешнем каталоге, в которых агент будет синхронизировать пользователей. Вы можете указать одну или несколько групп, при этом фильтр по нескольким группам будет применяться с логикой `ИЛИ`.

        {% note info %}

        Параметр `groups` влияет только на синхронизацию пользователей и не влияет на настройки синхронизации групп пользователей.

        {% endnote %}

    Если не настроить фильтрацию синхронизируемых объектов, агент Yandex Identity Hub Sync Agent попытается синхронизировать все [доступные объекты](../../concepts/sync-external/ldap-sync.md#sync-objects) во внешнем каталоге.
* `remove_user_behavior` — позволяет управлять действием в отношении пользователей на стороне Yandex Cloud, если соответствующие пользователи на стороне внешнего каталога были удалены или перестали удовлетворять условиям, заданным в параметрах `sync_settings.filter`. Необязательный параметр. Возможные значения:

    * `remove` — пользователи, удаленные или переставшие удовлетворять условиям фильтра, удаляются на стороне Yandex Identity Hub. Действие по умолчанию.
    * `block` — пользователи, удаленные или переставшие удовлетворять условиям фильтра, деактивируются на стороне Yandex Identity Hub.

    {% note info %}

    Если в процессе синхронизации выясняется, что на стороне внешнего каталога была удалена или перестала удовлетворять заданным фильтрам группа пользователей, то на стороне Yandex Identity Hub такая группа пользователей удаляется.

    {% endnote %}

* `ldap_settings` — дополнительные настройки синхронизации, специфичные для используемого типа внешнего LDAP-каталога:

    * `external_id_attribute` — имя атрибута на стороне внешнего каталога, в котором содержится уникальный идентификатор записи. Например, `ipaUniqueID` для FreeIPA.
    * `dn_attribute` — имя операционного атрибута на стороне внешнего каталога, в котором содержится DN записи. Например, `entryDN` для FreeIPA.
    * `user_object_class` — класс объектов, который используется для хранения данных о пользователях на стороне внешнего каталога. Например, `inetOrgPerson` для FreeIPA. Подробнее о возможных классах объектов и атрибутах в них читайте в разделе [Объекты синхронизации](../../concepts/sync-external/ldap-sync.md#sync-objects).
    * `group_object_class` — класс объектов, который используется для хранения данных о группах пользователей на стороне внешнего каталога. Например, `ipausergroup` для FreeIPA.
    * `account_disabled_attribute` — имя атрибута на стороне внешнего каталога, в котором содержится состояние пользователя (активный/неактивный). Например, `nsAccountLock` для FreeIPA.
    * `account_disabled_value` — значение атрибута, заданного в поле `account_disabled_attribute`, которое означает, что аккаунт неактивен. Например: `TRUE`.
    * `account_enabled_value` — значение атрибута, заданного в поле `account_disabled_attribute`, которое означает, что аккаунт активен. Например: `FALSE`.
    * `password_attribute` — имя атрибута на стороне внешнего каталога, в котором содержится пароль (хеш пароля) пользователя. Например, `userPassword` для FreeIPA.
    * `delta_sync_mode` — режим синхронизации. В настоящее время поддерживается только режим полной синхронизации (значение `full_sync`).

#### Полезные ссылки {#see-also}

* [Синхронизация пользователей и групп с внешними службами каталогов](../../concepts/sync-external/index.md)
* [Синхронизация пользователей и групп с LDAP-совместимыми службами каталогов](../../concepts/sync-external/ldap-sync.md)