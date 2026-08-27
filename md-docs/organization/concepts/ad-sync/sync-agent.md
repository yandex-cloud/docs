[Документация Yandex Cloud](../../../index.md) > [Yandex Identity Hub](../../index.md) > Концепции > [Синхронизация с внешними службами каталогов](index.md) > Агент синхронизации Identity Hub AD Sync Agent

# Агент синхронизации Identity Hub AD Sync Agent


Агент синхронизации Identity Hub AD Sync Agent выполняет чтение данных о пользователях и группах пользователей в [выбранных](#agent-config) Organization Units (OU) в каталоге Active Directory и синхронизирует их с данными пользователей и групп пользователей в [пуле](../user-pools.md) Yandex Identity Hub.

Скрипт установки агента синхронизации доступен для следующих операционных систем:

* [Linux](https://storage.yandexcloud.net/yc-identityhub-sync/install.sh);
* [Windows](https://storage.yandexcloud.net/yc-identityhub-sync/install.ps1).

### Аутентификация на стороне Active Directory {#agent-ad-auth}

На стороне Active Directory агент синхронизации получает данные пользователей и групп от имени аккаунта, [созданного](index.md#dc-setup) в домене Active Directory. При получении этих данных используются протоколы [LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/) и [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/), запросы отправляются на адрес контроллера домена Active Directory, заданный в [конфигурации](#agent-config) агента.

Вне зависимости от операционной системы сервера, на котором установлен агент синхронизации, аутентификация агента на стороне Active Directory может осуществляться по имени и паролю пользователя домена или с использованием протокола [Kerberos](https://ru.wikipedia.org/wiki/Kerberos) версии 5.

Кроме того, при установке агента синхронизации на сервер с ОС Windows аутентификацию агента на стороне Active Directory можно настроить от имени [аккаунта gMSA](*gmsa_account).

{% note tip %}

Аккаунт gMSA является предпочтительным способом аутентификации в Active Directory, так как не требует сохранения пароля в файле конфигурации агента или ключей Kerberos на сервере.

{% endnote %}

### Аутентификация на стороне Yandex Cloud {#agent-yc-auth}

На стороне Yandex Cloud агент синхронизации управляет пользователями и группами пользователей от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) с [назначенными](index.md#yc-setup) разрешениями на выполнение синхронизации. Запросы к Yandex Cloud направляются на публичный эндпоинт `https://organization-manager.api.cloud.yandex.net` по протоколу [HTTPS](https://ru.wikipedia.org/wiki/HTTPS). Для аутентификации агента в API Yandex Cloud используется авторизованный ключ сервисного аккаунта или (только при установке на ВМ Compute Cloud) — [IAM-токен](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, [получаемый](../../../compute/operations/vm-metadata/get-vm-metadata.md#example5) через [сервис метаданных](../../../compute/concepts/vm-metadata.md) ВМ.

### Процесс синхронизации {#sync-process}

В процессе синхронизации данных агент Identity Hub AD Sync Agent может создавать, изменять или удалять пользователей и группы пользователей в Yandex Identity Hub. Синхронизация пользователей и групп Yandex Identity Hub с пользователями и группами в Active Directory выполняется в два этапа: [первичная синхронизация](#full-sync) и [инкрементальная синхронизация](#incremental-sync).

При выполнении синхронизации в пуле пользователей может обнаружиться пользователь или группа пользователей с именами, идентичными именам пользователя или группы, которые требуется синхронизировать. В этом случае агент, в зависимости от [заданных настроек](#agent-config), перезапишет данные из Active Directory для существующего пользователя или группы Yandex Identity Hub, либо выведет сообщение об ошибке.

#### Полная (первичная) синхронизация {#full-sync}

При выполнении полной синхронизации агент считывает данные всех пользователей, групп и их атрибутов в [выбранных](#agent-config) Organization Units в каталоге Active Directory и создает аналогичных пользователей и группы с аналогичными атрибутами в пуле пользователей Yandex Identity Hub.

Процесс первичной синхронизации для большого количества [объектов](index.md#sync-objects) может занять достаточно длительное время. Если процесс полной синхронизации прервется в результате ошибки, повторный запуск агента продолжит синхронизацию с того места, на котором прервалась предыдущая попытка. Прогресс полной синхронизации агент отслеживает с помощью файлов с токенами процессов в директории с запущенным агентом:

* `main_sync_replication_token.json`
* `password_hash_replication_token.json`
* `user_control_replication_token.json`

После успешного завершения полной синхронизации агент, запущенный в виде сервиса или службы операционной системы, переходит к непрерывному выполнению частичной (инкрементальной) синхронизации.

{% note tip %}

Вы можете повторно запустить процесс полной синхронизации. Для этого удалите указанные выше файлы с токенами процессов и перезапустите агент.

{% endnote %}

#### Частичная (инкрементальная) синхронизация {#incremental-sync}

Инкрементальная синхронизация непрерывно выполняется запущенным агентом со следующей периодичностью:

* _Синхронизация паролей и состояний пользователей_ — агент отслеживает статус блокировки/разблокировки пользователей в домене Active Directory и смену пользовательских паролей и переносит эти изменения в Yandex Identity Hub с интервалом в несколько секунд. Частоту выполнения этого типа синхронизации изменить нельзя.
* _Синхронизация иных значений_ — агент отслеживает прочие изменения свойств, атрибутов и параметров пользователей и групп с интервалом, [установленным](#agent-config) в файле конфигурации агента.

#### Тестовый запуск (dry run) {#dry-run}

Агент Identity Hub AD Sync Agent можно запустить в тестовом режиме (dry run). Этот режим позволяет убедиться в корректности вносимых в конфигурацию агента изменений прежде чем применять эти изменения в рабочем режиме.

В режиме тестового запуска агент не вносит изменения в данные пользователей и групп Yandex Identity Hub. Вместо этого он тестирует выполнение всех операций, вызванных вносимыми в конфигурацию агента изменениями, и сохраняет результаты этих тестов в [логах](#logging) работы агента.

Подробнее о том, как запустить агент в режиме dry run, читайте в разделе [Протестируйте изменения в конфигурации агента](../../operations/sync-ad.md#dry-run).

### Отслеживаемые изменения {#tracked-changes}

В процессе непрерывной синхронизации агент отслеживает следующие изменения в Active Directory и переносит их в Yandex Identity Hub:

* создание, изменение, блокировка, разблокировка и удаление пользователей;
* создание, изменение и удаление групп пользователей;
* изменение атрибутов пользователей и групп;
* добавление пользователей в группы и исключение их из групп;
* изменение паролей пользователей.

Если для учетной записи пользователя на стороне Active Directory задано значение поля **accountExpires**, агент синхронизирует это значение с полем **Дата деактивации** (`expires_at`) в свойствах локального пользователя Yandex Identity Hub. При наступлении момента, указанного в этом поле, локальный пользователь Yandex Identity Hub будет автоматически [деактивирован](../../operations/user-pools/deactivate-user.md).

В этом случае, чтобы повторно активировать пользователя, измените или удалите значение поля **accountExpires** для учетной записи пользователя на стороне Active Directory.

### Логирование процесса синхронизации {#logging}

Агент Identity Hub AD Sync Agent регистрирует события, возникающие в процессе синхронизации.

По умолчанию информация о событиях и ошибках выводится в [стандартный поток](https://ru.wikipedia.org/wiki/Стандартные_потоки) `stdout`. В [конфигурации](#agent-config) агента вы можете задать настройки для сохранения логов в файлы.

По умолчанию информация о событиях в стандартный поток или файл выводится в простом текстовом формате, но в конфигурации агента формат можно изменить на [JSON](https://ru.wikipedia.org/wiki/JSON).

В [конфигурации](#agent-config) агента вы также можете настроить выгрузку логов в [лог-группу](../../../logging/concepts/log-group.md) Yandex Cloud Logging.

Кроме того, в конфигурации агента можно задать следующие уровни логирования:

* `debug`
* `info`
* `warn`
* `error`
* `dpanic`
* `panic`
* `fatal`

### Проверка прав доступа к файлам с аутентификационными данными {#auth-data-security}

При запуске агент синхронизации может проверять права доступа, назначенные файлам, которые используются агентом и содержат чувствительные данные:

* файл [конфигурации агента](#agent-config) может содержать пароль к учетной записи пользователя, от имени которого агент выполняет синхронизацию на стороне Active Directory;
* файл `keytab` содержит ключи шифрования, необходимые для аутентификации в Active Directory по протоколу Kerberos;
* файл с [авторизованным ключом](../../../iam/concepts/authorization/key.md) сервисного аккаунта содержит ключ, позволяющий получить доступ к Yandex Cloud.

Если проверка прав доступа включена, при запуске агент синхронизации проверяет соблюдение следующих условий:

{% list tabs group=operating_system %}

- Linux {#linux}

  * владельцем файлов является пользователь, от имени которого запускается агент;
  * права на чтение и запись для файлов предоставлены только их владельцу (`chmod 600`).

- Windows {#windows}

  * для файлов отключено наследование прав доступа;
  * полный доступ (разрешение `FullAccess`) к файлам имеют только субъекты `System`, `Local Administrator` и/или субъекты, входящие в группу `BUILTIN\Administrators`;
  * разрешение на чтение файлов есть только у пользователя, от имени которого запускается агент.

{% endlist %}

Если при запуске агент выявляет нарушение указанных условий, запуск завершается ошибкой.

Включить или отключить проверку прав доступа к файлам с чувствительной информацией можно с помощью параметра `check_config_permissions` конфигурации агента.

### Конфигурация агента {#agent-config}

Конфигурация агента синхронизации зависит от [способа аутентификации](#agent-ad-auth), используемого агентом на стороне Active Directory, и задается в [YAML](https://yaml.org/)-файле в следующем формате:

{% list tabs group=authentication_linux %}

- От имени аккаунта gMSA {#gmsa-windows}

  {% note info %}
  
  Аутентификация от имени [аккаунта gMSA](*gmsa_account) возможна только при установке агента синхронизации на сервер с ОС Windows и является предпочтительным способом аутентификации при использовании серверов с этой операционной системой.
  
  {% endnote %}

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
  # back from Yandex Identity Hub to Active Directory.
  enable_password_writeback: true|false
  
  # Enable the Dry Run mode.
  # If `true`, no changes will be applied to users or groups in Yandex Identity Hub.
  # Instead, all pending operations will be saved to the current log file location.
  dry_run:
    enabled: true|false
  
  # Active Directory replication API client settings
  drsr:
    host: "<адрес_контроллера_домена>"
    use_windows_identity: true
  
  # LDAP client settings
  ldap:
    host: "ldaps://<адрес_контроллера_домена>:636"
    certificate_path: "<путь_к_CA_сертификату>"
    insecure_skip_verify: false|true
    use_windows_identity: true
  
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

  {% list tabs accordion %}

  - userpool_id
    
    Идентификатор [пула пользователей](../user-pools.md) в Yandex Identity Hub.
  
  - working_directory
    
    Путь к директории, в которой сохраняются файлы, необходимые агенту для работы. Необязательный параметр.
    
    Если параметр не задан, в качестве рабочей директории используется директория, в которой расположен исполняемый файл агента. По умолчанию исполняемый файл агента располагается в следующих директориях:
    
    * `/etc/yc-identityhub-sync-agent/` (для Linux);
    * `C:\\ProgramData\\YcIdentityHubSyncAgent\\` (для Windows).
  
  - check_config_permissions
    
    Настройки [проверки прав доступа](sync-agent.md#auth-data-security) к файлам с аутентификационными данными, выполняемой при запуске агента. Необязательный параметр. Возможные значения:
    
    * `true` — проверка прав доступа к файлам конфигурации агента, содержащим чувствительные данные, включена.
    * `false` — проверка прав доступа к файлам конфигурации агента отключена. Значение по умолчанию.
  
  - cloud_credentials_file_path
    
    Путь к файлу, содержащему [авторизованный ключ](../../../iam/concepts/authorization/key.md) сервисного аккаунта в Yandex Cloud. Необязательный параметр: используется только при аутентификации агента в API Yandex Cloud с помощью авторизованного ключа.
    
    Примеры значений:
    
    * `/etc/yc-identityhub-sync-agent/authorized_key.json` (для Linux);
    * `C:\\ProgramData\\YcIdentityHubSyncAgent\\authorized_key.json` (для Windows).
    
    В параметре `cloud_credentials_file_path` вместо полного пути вы можете передать только имя файла. В этом случае файл будет сохранен в рабочей директории, заданной в параметре `working_directory`, или, если рабочая директория не задана, — в директории, в которой расположен исполняемый файл агента.
    
    {% note info %}
    
    Если в параметрах `cloud_credentials_file_path` и/или `logger.file.filename` заданы пути, отличные от пути, заданного в параметре `working_directory`, для выбранных сущностей будут использоваться пути, указанные в параметрах `cloud_credentials_file_path` и/или `logger.file.filename`.
    
    {% endnote %}
  
  - use_metadata_service
    
    Параметр, управляющий аутентификацией агента в API Yandex Cloud с помощью [IAM-токена](../../../iam/concepts/authorization/iam-token.md) и позволяющий агенту получать IAM-токены через [сервис метаданных](../../../compute/concepts/vm-metadata.md) ВМ.
    
    Возможные значения:
    
    * `true` — агент синхронизации будет получать IAM-токены сервисного аккаунта через сервис метаданных виртуальной машины и использовать их для аутентификации в API Yandex Cloud. Значение параметра `cloud_credentials_file_path` при этом будет игнорироваться.
    
        Чтобы агент мог получать IAM-токены, он должен быть установлен на виртуальной машине Yandex Compute Cloud, к которой подключен сервисный аккаунт с [необходимыми](index.md#yc-setup) правами доступа.
    * `false` — агент синхронизации не будет получать IAM-токены, а аутентификация в API Yandex Cloud будет выполняться с помощью авторизованного ключа, заданного в параметре `cloud_credentials_file_path`.
  
  - enable_password_writeback
    
    Параметр, управляющий [обратной записью паролей](index.md#password-writeback) пользователей в Active Directory.
    
    {% note info %}
    
    Функциональность обратной записи паролей находится на стадии [Preview](../../../overview/concepts/launch-stages.md). Чтобы получить к ней доступ, обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.
    
    {% endnote %}
    
    Возможные значения:
    
    * `true` — при попытке изменить пароль синхронизированного пользователя на стороне Yandex Identity Hub ([изменение пароля](../../operations/manage-account.md#edit-password) самим пользователем или [сброс пароля](../../operations/user-pools/reset-user-password.md#reset) администратором) агент сначала попытается изменить пароль соответствующего пользователя в Active Directory, и только в случае успеха этой операции пароль будет изменен в Yandex Identity Hub.
    * `false` — при изменении пароля синхронизированного пользователя на стороне Yandex Identity Hub пароль этого пользователя не будет изменен в Active Directory. Если после изменения пароля выполнить [полную синхронизацию](sync-agent.md#full-sync), агент заменит обновленный пароль в Yandex Identity Hub паролем, взятым из Active Directory. Это также поведение по умолчанию, если функциональность обратной записи не активирована.
  
  - dry_run
    
    Настройки [тестового запуска](sync-agent.md#dry-run) агента (dry run):
    
    * `enabled: true` — активирован режим dry run. Агент не вносит изменения в данные пользователей и групп Yandex Identity Hub. Вместо этого он тестирует выполнение всех предусмотренных конфигурацией агента операций и сохраняет результаты этих тестов в [логах](sync-agent.md#logging) его работы.
    * `enabled: false` — агент функционирует в рабочем режиме, необходимые изменения вносятся в данные пользователей и групп Yandex Identity Hub.
  
  - drsr
    
    Настройки протокола [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) для аутентификации на стороне Active Directory [аккаунта gMSA](*gmsa_account) с [назначенными правами](index.md#dc-setup) на выполнение репликации данных в каталоге:
    
    
    * `host` — домен или IP-адрес контроллера домена Active Directory.
    * `use_windows_identity: true` — параметр, который устанавливает для агента синхронизации требование аутентифицироваться на стороне Active Directory от имени аккаунта gMSA.
    
        {% note warning %}
        
        Чтобы агент синхронизации мог аутентифицироваться на стороне Active Directory от имени аккаунта gMSA, служба агента на сервере также должна быть запущена от имени этого аккаунта gMSA.
        
        {% endnote %}
  
  - ldap
    
    Настройки протокола [LDAPS](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/enable-ldap-over-ssl-3rd-certification-authority)/[LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/) для аутентификации на стороне Active Directory:
    
    {% note warning %}
    
    Вы можете подключаться к контроллеру домена по протоколу `LDAPS` или `LDAP`. Рекомендованным и безопасным протоколом является `LDAPS`. Протокол `LDAP` используйте только при настройке и тестировании.
    
    {% endnote %}
    
    * `host` — домен или IP-адрес контроллера домена Active Directory. В зависимости от используемого протокола указываются схема и номер порта:
    
        * при использовании `LDAPS` — схема `ldaps://` и порт `636`;
        * при использовании `LDAP` — схема `ldap://` и порт `389`.
    * `certificate_path` — путь к файлу с корневым сертификатом удостоверяющего центра (CA), которым подписан сертификат контроллера домена. Необязательный параметр.
    
        Укажите этот параметр, если вы используете протокол `LDAPS` и корневой сертификат отсутствует в системном хранилище доверенных сертификатов.
    
        Если в параметре `working_directory` задан путь к рабочей директории, вместо пути к файлу сертификата достаточно указать имя этого файла.
    * `insecure_skip_verify` — параметр, позволяющий игнорировать ошибки валидации сертификата открытого ключа при подключении к контроллеру домена. Необязательный параметр. Возможные значения:
    
        * `false` — ошибки валидации сертификата не будут игнорироваться. Значение по умолчанию.
        * `true` — агент синхронизации будет игнорировать ошибки валидации сертификата. Может быть полезно при настройке и тестировании синхронизации. Не рекомендуется использовать в рабочем режиме.
    * `use_windows_identity: true` — параметр, который устанавливает для агента синхронизации требование аутентифицироваться на стороне Active Directory от имени [аккаунта gMSA](*gmsa_account).
    
        {% note warning %}
        
        Чтобы агент синхронизации мог аутентифицироваться на стороне Active Directory от имени аккаунта gMSA, служба агента на сервере также должна быть запущена от имени этого аккаунта gMSA.
        
        {% endnote %}
  
  - logger
    
    Настройки [логирования](sync-agent.md#logging) процесса синхронизации:
    
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
  
  - sync_settings
    
    Настройки процесса синхронизации:
    
    * `interval` — периодичность выполнения [инкрементальной синхронизации](sync-agent.md#incremental-sync). Необязательный параметр. Значение по умолчанию — 240 секунд.
    
        {% note info %}
    
        Периодичность выполнения синхронизации паролей и состояний пользователей в Active Directory составляет несколько секунд, является константой и не зависит от значения, заданного в параметре `interval`.
    
        {% endnote %}
    
    * `allow_to_capture_users` — параметр, позволяющий изменять существующего пользователя пула Yandex Identity Hub при совпадении его логина с логином пользователя Active Directory, которого требуется синхронизировать. Возможные значения:
    
        * `true` — агент синхронизации будет изменять существующих пользователей Yandex Identity Hub, приводя их в соответствие с учетной записью в Active Directory.
        * `false` — агент синхронизации не будет изменять существующих пользователей Yandex Identity Hub. При обнаружении совпадения логинов пользователя в пуле и в Active Directory процесс синхронизации выдаст ошибку.
    * `allow_to_capture_groups` — параметр, позволяющий изменять существующую группу пользователей Yandex Identity Hub при совпадении ее имени с именем группы в Active Directory, которую требуется синхронизировать. Возможные значения:
    
        * `true` — агент синхронизации будет изменять существующие группы пользователей Yandex Identity Hub, приводя их в соответствие с группами в Active Directory.
        * `false` — агент синхронизации не будет изменять существующие группы пользователей Yandex Identity Hub. При обнаружении совпадения имен групп в пуле и в Active Directory процесс синхронизации выдаст ошибку.
    * `replacement_domain` — [домен](../domains.md), привязанный к пулу пользователей Yandex Identity Hub, в котором находятся синхронизируемые пользователи и группы. Например: `newdomain.idp.yandexcloud.net`.
    
        Необязательный параметр. Значение параметра `replacement_domain` требуется задавать только в том случае, если имя домена, привязанного к пулу пользователей, отличается от имени домена на контроллере домена Active Directory.
    * `user_attribute_mapping` — настройки сопоставления атрибутов пользователя:
    
        * `source` — имя атрибута пользователя, получаемое из Active Directory и отличное от имени, [заданного по умолчанию](index.md#sync-objects).
    
            Если вы хотите отключить синхронизацию атрибута, оставьте значение пустым: `source: ""`.
        * `target` — имя атрибута на стороне Yandex Cloud, с которым настраивается сопоставление (или для которого отключается синхронизация). Список доступных значений смотрите в таблице **Атрибуты пользователей** в разделе [Объекты синхронизации](index.md#sync-objects).
        * `type` — выбор действия в отношении указанного атрибута. Возможные значения:
    
            * `direct` — настроить сопоставление атрибутов.
            * `empty` — отключить синхронизацию атрибута.
    
        Необязательный параметр. Значение параметра `user_attribute_mapping` необходимо задавать только в том случае, если требуется настроить сопоставление имен атрибутов пользователя, отличных от заданных по умолчанию для Active Directory, или отключить синхронизацию отдельных атрибутов.
    * `group_attribute_mapping` — настройки сопоставления атрибутов групп пользователей:
    
        * `source` — имя атрибута групп пользователей, получаемое из Active Directory и отличное от имени, [заданного по умолчанию](index.md#sync-objects).
    
            Если вы хотите отключить синхронизацию атрибута, оставьте значение пустым: `source: ""`.
        * `target` — имя атрибута на стороне Yandex Cloud, с которым настраивается сопоставление (или для которого отключается синхронизация). Список доступных значений смотрите в таблице **Атрибуты групп пользователей** в разделе [Объекты синхронизации](index.md#sync-objects).
        * `type` — выбор действия в отношении указанного атрибута. Возможные значения:
    
            * `direct` — настроить сопоставление атрибутов.
            * `empty` — отключить синхронизацию атрибута.
    
        Необязательный параметр. Значение параметра `group_attribute_mapping` необходимо задавать только в том случае, если требуется настроить сопоставление имен атрибутов групп пользователей, отличных от заданных по умолчанию для Active Directory, или отключить синхронизацию отдельных атрибутов.
    * `filter` — настройки фильтрации синхронизируемых объектов на стороне Active Directory:
    
        * `domain` — имя домена на контроллере домена Active Directory, в котором агент будет синхронизировать пользователей и группы.
        * `organization_units` — список Organization Units (OU) в каталоге Active Directory, в которых агент будет синхронизировать пользователей и группы.
        * `groups` — список групп пользователей в каталоге Active Directory, в которых агент будет синхронизировать пользователей. Вы можете указать одну или несколько групп, при этом фильтр по нескольким группам будет применяться с логикой `ИЛИ`.
    
            {% note info %}
    
            Параметр `groups` влияет только на синхронизацию пользователей и не влияет на настройки синхронизации групп пользователей.
    
            {% endnote %}
    
        Если не настроить фильтрацию синхронизируемых объектов, агент Identity Hub AD Sync Agent попытается синхронизировать все [доступные объекты](index.md#sync-objects) в каталоге Active Directory.
    * `remove_user_behavior` — позволяет управлять действием в отношении пользователей на стороне Yandex Cloud, если соответствующие пользователи на стороне Active Directory были удалены или перестали удовлетворять условиям, заданным в параметрах `sync_settings.filter` (например, они были перенесены в другой Organization Unit). Необязательный параметр. Возможные значения:
    
        * `remove` — пользователи, удаленные или переставшие удовлетворять условиям фильтра, удаляются на стороне Yandex Identity Hub. Действие по умолчанию.
        * `block` — пользователи, удаленные или переставшие удовлетворять условиям фильтра, деактивируются на стороне Yandex Identity Hub.
    
    {% note info %}
    
    Если в процессе синхронизации выясняется, что на стороне Active Directory группа пользователей была удалена или перестала удовлетворять заданным фильтрам (например, она была перенесена в другой Organization Unit), то на стороне Yandex Identity Hub такая группа удаляется.
    
    {% endnote %}

  {% endlist %}

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
  # back from Yandex Identity Hub to Active Directory.
  enable_password_writeback: true|false
  
  # Enable the Dry Run mode.
  # If `true`, no changes will be applied to users or groups in Yandex Identity Hub.
  # Instead, all pending operations will be saved to the current log file location.
  dry_run:
    enabled: true|false
  
  # Active Directory replication API client settings
  drsr:
    host: "<адрес_контроллера_домена>"
    username: "<sAMAccountName_пользователя_Active_Directory>"
    password: "password"
  
  # LDAP client settings
  ldap:
    host: "ldaps://<адрес_контроллера_домена>:636"
    username: "<DN_пользователя_Active_Directory>"
    password: "<пароль_пользователя_Active_Directory>"
    certificate_path: "<путь_к_CA_сертификату>"
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

  {% list tabs accordion %}

  - userpool_id
    
    Идентификатор [пула пользователей](../user-pools.md) в Yandex Identity Hub.
  
  - working_directory
    
    Путь к директории, в которой сохраняются файлы, необходимые агенту для работы. Необязательный параметр.
    
    Если параметр не задан, в качестве рабочей директории используется директория, в которой расположен исполняемый файл агента. По умолчанию исполняемый файл агента располагается в следующих директориях:
    
    * `/etc/yc-identityhub-sync-agent/` (для Linux);
    * `C:\\ProgramData\\YcIdentityHubSyncAgent\\` (для Windows).
  
  - check_config_permissions
    
    Настройки [проверки прав доступа](sync-agent.md#auth-data-security) к файлам с аутентификационными данными, выполняемой при запуске агента. Необязательный параметр. Возможные значения:
    
    * `true` — проверка прав доступа к файлам конфигурации агента, содержащим чувствительные данные, включена.
    * `false` — проверка прав доступа к файлам конфигурации агента отключена. Значение по умолчанию.
  
  - cloud_credentials_file_path
    
    Путь к файлу, содержащему [авторизованный ключ](../../../iam/concepts/authorization/key.md) сервисного аккаунта в Yandex Cloud. Необязательный параметр: используется только при аутентификации агента в API Yandex Cloud с помощью авторизованного ключа.
    
    Примеры значений:
    
    * `/etc/yc-identityhub-sync-agent/authorized_key.json` (для Linux);
    * `C:\\ProgramData\\YcIdentityHubSyncAgent\\authorized_key.json` (для Windows).
    
    В параметре `cloud_credentials_file_path` вместо полного пути вы можете передать только имя файла. В этом случае файл будет сохранен в рабочей директории, заданной в параметре `working_directory`, или, если рабочая директория не задана, — в директории, в которой расположен исполняемый файл агента.
    
    {% note info %}
    
    Если в параметрах `cloud_credentials_file_path` и/или `logger.file.filename` заданы пути, отличные от пути, заданного в параметре `working_directory`, для выбранных сущностей будут использоваться пути, указанные в параметрах `cloud_credentials_file_path` и/или `logger.file.filename`.
    
    {% endnote %}
  
  - use_metadata_service
    
    Параметр, управляющий аутентификацией агента в API Yandex Cloud с помощью [IAM-токена](../../../iam/concepts/authorization/iam-token.md) и позволяющий агенту получать IAM-токены через [сервис метаданных](../../../compute/concepts/vm-metadata.md) ВМ.
    
    Возможные значения:
    
    * `true` — агент синхронизации будет получать IAM-токены сервисного аккаунта через сервис метаданных виртуальной машины и использовать их для аутентификации в API Yandex Cloud. Значение параметра `cloud_credentials_file_path` при этом будет игнорироваться.
    
        Чтобы агент мог получать IAM-токены, он должен быть установлен на виртуальной машине Yandex Compute Cloud, к которой подключен сервисный аккаунт с [необходимыми](index.md#yc-setup) правами доступа.
    * `false` — агент синхронизации не будет получать IAM-токены, а аутентификация в API Yandex Cloud будет выполняться с помощью авторизованного ключа, заданного в параметре `cloud_credentials_file_path`.
  
  - enable_password_writeback
    
    Параметр, управляющий [обратной записью паролей](index.md#password-writeback) пользователей в Active Directory.
    
    {% note info %}
    
    Функциональность обратной записи паролей находится на стадии [Preview](../../../overview/concepts/launch-stages.md). Чтобы получить к ней доступ, обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.
    
    {% endnote %}
    
    Возможные значения:
    
    * `true` — при попытке изменить пароль синхронизированного пользователя на стороне Yandex Identity Hub ([изменение пароля](../../operations/manage-account.md#edit-password) самим пользователем или [сброс пароля](../../operations/user-pools/reset-user-password.md#reset) администратором) агент сначала попытается изменить пароль соответствующего пользователя в Active Directory, и только в случае успеха этой операции пароль будет изменен в Yandex Identity Hub.
    * `false` — при изменении пароля синхронизированного пользователя на стороне Yandex Identity Hub пароль этого пользователя не будет изменен в Active Directory. Если после изменения пароля выполнить [полную синхронизацию](sync-agent.md#full-sync), агент заменит обновленный пароль в Yandex Identity Hub паролем, взятым из Active Directory. Это также поведение по умолчанию, если функциональность обратной записи не активирована.
  
  - dry_run
    
    Настройки [тестового запуска](sync-agent.md#dry-run) агента (dry run):
    
    * `enabled: true` — активирован режим dry run. Агент не вносит изменения в данные пользователей и групп Yandex Identity Hub. Вместо этого он тестирует выполнение всех предусмотренных конфигурацией агента операций и сохраняет результаты этих тестов в [логах](sync-agent.md#logging) его работы.
    * `enabled: false` — агент функционирует в рабочем режиме, необходимые изменения вносятся в данные пользователей и групп Yandex Identity Hub.
  
  - drsr
    
    Настройки протокола [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) для аутентификации на стороне Active Directory [пользователя](index.md#dc-setup) с назначенными правами на выполнение репликации данных в каталоге:
    
    * `host` — домен или IP-адрес контроллера домена Active Directory.
    * `username` — `sAMAccountName` пользователя домена Active Directory, которому [назначены](index.md#dc-setup) права на выполнение репликации данных.
    * `password` — пароль пользователя домена Active Directory.
  
  - ldap
    
    Настройки протокола [LDAPS](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/enable-ldap-over-ssl-3rd-certification-authority)/[LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/) для аутентификации на стороне Active Directory:
    
    {% note warning %}
    
    Вы можете подключаться к контроллеру домена по протоколу `LDAPS` или `LDAP`. Рекомендованным и безопасным протоколом является `LDAPS`. Протокол `LDAP` используйте только при настройке и тестировании.
    
    {% endnote %}
    
    * `host` — домен или IP-адрес контроллера домена Active Directory. В зависимости от используемого протокола указываются схема и номер порта:
    
        * при использовании `LDAPS` — схема `ldaps://` и порт `636`;
        * при использовании `LDAP` — схема `ldap://` и порт `389`.
    * `username` — [DN](https://learn.microsoft.com/en-us/previous-versions/windows/desktop/ldap/distinguished-names) пользователя домена Active Directory, которому [назначены](index.md#dc-setup) права на выполнение репликации данных.
    * `password` — пароль пользователя домена Active Directory.
    * `certificate_path` — путь к файлу с корневым сертификатом удостоверяющего центра (CA), которым подписан сертификат контроллера домена. Необязательный параметр.
    
        Укажите этот параметр, если вы используете протокол `LDAPS` и корневой сертификат отсутствует в системном хранилище доверенных сертификатов.
    
        Если в параметре `working_directory` задан путь к рабочей директории, вместо пути к файлу сертификата достаточно указать имя этого файла.
    * `insecure_skip_verify` — параметр, позволяющий игнорировать ошибки валидации сертификата открытого ключа при подключении к контроллеру домена. Необязательный параметр. Возможные значения:
    
        * `false` — ошибки валидации сертификата не будут игнорироваться. Значение по умолчанию.
        * `true` — агент синхронизации будет игнорировать ошибки валидации сертификата. Может быть полезно при настройке и тестировании синхронизации. Не рекомендуется использовать в рабочем режиме.
  
  - logger
    
    Настройки [логирования](sync-agent.md#logging) процесса синхронизации:
    
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
  
  - sync_settings
    
    Настройки процесса синхронизации:
    
    * `interval` — периодичность выполнения [инкрементальной синхронизации](sync-agent.md#incremental-sync). Необязательный параметр. Значение по умолчанию — 240 секунд.
    
        {% note info %}
    
        Периодичность выполнения синхронизации паролей и состояний пользователей в Active Directory составляет несколько секунд, является константой и не зависит от значения, заданного в параметре `interval`.
    
        {% endnote %}
    
    * `allow_to_capture_users` — параметр, позволяющий изменять существующего пользователя пула Yandex Identity Hub при совпадении его логина с логином пользователя Active Directory, которого требуется синхронизировать. Возможные значения:
    
        * `true` — агент синхронизации будет изменять существующих пользователей Yandex Identity Hub, приводя их в соответствие с учетной записью в Active Directory.
        * `false` — агент синхронизации не будет изменять существующих пользователей Yandex Identity Hub. При обнаружении совпадения логинов пользователя в пуле и в Active Directory процесс синхронизации выдаст ошибку.
    * `allow_to_capture_groups` — параметр, позволяющий изменять существующую группу пользователей Yandex Identity Hub при совпадении ее имени с именем группы в Active Directory, которую требуется синхронизировать. Возможные значения:
    
        * `true` — агент синхронизации будет изменять существующие группы пользователей Yandex Identity Hub, приводя их в соответствие с группами в Active Directory.
        * `false` — агент синхронизации не будет изменять существующие группы пользователей Yandex Identity Hub. При обнаружении совпадения имен групп в пуле и в Active Directory процесс синхронизации выдаст ошибку.
    * `replacement_domain` — [домен](../domains.md), привязанный к пулу пользователей Yandex Identity Hub, в котором находятся синхронизируемые пользователи и группы. Например: `newdomain.idp.yandexcloud.net`.
    
        Необязательный параметр. Значение параметра `replacement_domain` требуется задавать только в том случае, если имя домена, привязанного к пулу пользователей, отличается от имени домена на контроллере домена Active Directory.
    * `user_attribute_mapping` — настройки сопоставления атрибутов пользователя:
    
        * `source` — имя атрибута пользователя, получаемое из Active Directory и отличное от имени, [заданного по умолчанию](index.md#sync-objects).
    
            Если вы хотите отключить синхронизацию атрибута, оставьте значение пустым: `source: ""`.
        * `target` — имя атрибута на стороне Yandex Cloud, с которым настраивается сопоставление (или для которого отключается синхронизация). Список доступных значений смотрите в таблице **Атрибуты пользователей** в разделе [Объекты синхронизации](index.md#sync-objects).
        * `type` — выбор действия в отношении указанного атрибута. Возможные значения:
    
            * `direct` — настроить сопоставление атрибутов.
            * `empty` — отключить синхронизацию атрибута.
    
        Необязательный параметр. Значение параметра `user_attribute_mapping` необходимо задавать только в том случае, если требуется настроить сопоставление имен атрибутов пользователя, отличных от заданных по умолчанию для Active Directory, или отключить синхронизацию отдельных атрибутов.
    * `group_attribute_mapping` — настройки сопоставления атрибутов групп пользователей:
    
        * `source` — имя атрибута групп пользователей, получаемое из Active Directory и отличное от имени, [заданного по умолчанию](index.md#sync-objects).
    
            Если вы хотите отключить синхронизацию атрибута, оставьте значение пустым: `source: ""`.
        * `target` — имя атрибута на стороне Yandex Cloud, с которым настраивается сопоставление (или для которого отключается синхронизация). Список доступных значений смотрите в таблице **Атрибуты групп пользователей** в разделе [Объекты синхронизации](index.md#sync-objects).
        * `type` — выбор действия в отношении указанного атрибута. Возможные значения:
    
            * `direct` — настроить сопоставление атрибутов.
            * `empty` — отключить синхронизацию атрибута.
    
        Необязательный параметр. Значение параметра `group_attribute_mapping` необходимо задавать только в том случае, если требуется настроить сопоставление имен атрибутов групп пользователей, отличных от заданных по умолчанию для Active Directory, или отключить синхронизацию отдельных атрибутов.
    * `filter` — настройки фильтрации синхронизируемых объектов на стороне Active Directory:
    
        * `domain` — имя домена на контроллере домена Active Directory, в котором агент будет синхронизировать пользователей и группы.
        * `organization_units` — список Organization Units (OU) в каталоге Active Directory, в которых агент будет синхронизировать пользователей и группы.
        * `groups` — список групп пользователей в каталоге Active Directory, в которых агент будет синхронизировать пользователей. Вы можете указать одну или несколько групп, при этом фильтр по нескольким группам будет применяться с логикой `ИЛИ`.
    
            {% note info %}
    
            Параметр `groups` влияет только на синхронизацию пользователей и не влияет на настройки синхронизации групп пользователей.
    
            {% endnote %}
    
        Если не настроить фильтрацию синхронизируемых объектов, агент Identity Hub AD Sync Agent попытается синхронизировать все [доступные объекты](index.md#sync-objects) в каталоге Active Directory.
    * `remove_user_behavior` — позволяет управлять действием в отношении пользователей на стороне Yandex Cloud, если соответствующие пользователи на стороне Active Directory были удалены или перестали удовлетворять условиям, заданным в параметрах `sync_settings.filter` (например, они были перенесены в другой Organization Unit). Необязательный параметр. Возможные значения:
    
        * `remove` — пользователи, удаленные или переставшие удовлетворять условиям фильтра, удаляются на стороне Yandex Identity Hub. Действие по умолчанию.
        * `block` — пользователи, удаленные или переставшие удовлетворять условиям фильтра, деактивируются на стороне Yandex Identity Hub.
    
    {% note info %}
    
    Если в процессе синхронизации выясняется, что на стороне Active Directory группа пользователей была удалена или перестала удовлетворять заданным фильтрам (например, она была перенесена в другой Organization Unit), то на стороне Yandex Identity Hub такая группа удаляется.
    
    {% endnote %}

  {% endlist %}

- По протоколу Kerberos {#kerberos_linux}

  {% note info %}

  Если для [аутентификации](sync-agent.md#agent-ad-auth) на стороне Active Directory вы планируете использовать протокол [Kerberos](https://ru.wikipedia.org/wiki/Kerberos), самостоятельно установите на сервер компоненты, необходимые для работы этого протокола, и создайте файл `keytab` с ключами шифрования.

  {% endnote %}

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
  # back from Yandex Identity Hub to Active Directory.
  enable_password_writeback: true|false
  
  # Enable the Dry Run mode.
  # If `true`, no changes will be applied to users or groups in Yandex Identity Hub.
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
    certificate_path: "<путь_к_CA_сертификату>"
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

  {% list tabs accordion %}

  - userpool_id
    
    Идентификатор [пула пользователей](../user-pools.md) в Yandex Identity Hub.
  
  - working_directory
    
    Путь к директории, в которой сохраняются файлы, необходимые агенту для работы. Необязательный параметр.
    
    Если параметр не задан, в качестве рабочей директории используется директория, в которой расположен исполняемый файл агента. По умолчанию исполняемый файл агента располагается в следующих директориях:
    
    * `/etc/yc-identityhub-sync-agent/` (для Linux);
    * `C:\\ProgramData\\YcIdentityHubSyncAgent\\` (для Windows).
  
  - check_config_permissions
    
    Настройки [проверки прав доступа](sync-agent.md#auth-data-security) к файлам с аутентификационными данными, выполняемой при запуске агента. Необязательный параметр. Возможные значения:
    
    * `true` — проверка прав доступа к файлам конфигурации агента, содержащим чувствительные данные, включена.
    * `false` — проверка прав доступа к файлам конфигурации агента отключена. Значение по умолчанию.
  
  - cloud_credentials_file_path
    
    Путь к файлу, содержащему [авторизованный ключ](../../../iam/concepts/authorization/key.md) сервисного аккаунта в Yandex Cloud. Необязательный параметр: используется только при аутентификации агента в API Yandex Cloud с помощью авторизованного ключа.
    
    Примеры значений:
    
    * `/etc/yc-identityhub-sync-agent/authorized_key.json` (для Linux);
    * `C:\\ProgramData\\YcIdentityHubSyncAgent\\authorized_key.json` (для Windows).
    
    В параметре `cloud_credentials_file_path` вместо полного пути вы можете передать только имя файла. В этом случае файл будет сохранен в рабочей директории, заданной в параметре `working_directory`, или, если рабочая директория не задана, — в директории, в которой расположен исполняемый файл агента.
    
    {% note info %}
    
    Если в параметрах `cloud_credentials_file_path` и/или `logger.file.filename` заданы пути, отличные от пути, заданного в параметре `working_directory`, для выбранных сущностей будут использоваться пути, указанные в параметрах `cloud_credentials_file_path` и/или `logger.file.filename`.
    
    {% endnote %}
  
  - use_metadata_service
    
    Параметр, управляющий аутентификацией агента в API Yandex Cloud с помощью [IAM-токена](../../../iam/concepts/authorization/iam-token.md) и позволяющий агенту получать IAM-токены через [сервис метаданных](../../../compute/concepts/vm-metadata.md) ВМ.
    
    Возможные значения:
    
    * `true` — агент синхронизации будет получать IAM-токены сервисного аккаунта через сервис метаданных виртуальной машины и использовать их для аутентификации в API Yandex Cloud. Значение параметра `cloud_credentials_file_path` при этом будет игнорироваться.
    
        Чтобы агент мог получать IAM-токены, он должен быть установлен на виртуальной машине Yandex Compute Cloud, к которой подключен сервисный аккаунт с [необходимыми](index.md#yc-setup) правами доступа.
    * `false` — агент синхронизации не будет получать IAM-токены, а аутентификация в API Yandex Cloud будет выполняться с помощью авторизованного ключа, заданного в параметре `cloud_credentials_file_path`.
  
  - enable_password_writeback
    
    Параметр, управляющий [обратной записью паролей](index.md#password-writeback) пользователей в Active Directory.
    
    {% note info %}
    
    Функциональность обратной записи паролей находится на стадии [Preview](../../../overview/concepts/launch-stages.md). Чтобы получить к ней доступ, обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.
    
    {% endnote %}
    
    Возможные значения:
    
    * `true` — при попытке изменить пароль синхронизированного пользователя на стороне Yandex Identity Hub ([изменение пароля](../../operations/manage-account.md#edit-password) самим пользователем или [сброс пароля](../../operations/user-pools/reset-user-password.md#reset) администратором) агент сначала попытается изменить пароль соответствующего пользователя в Active Directory, и только в случае успеха этой операции пароль будет изменен в Yandex Identity Hub.
    * `false` — при изменении пароля синхронизированного пользователя на стороне Yandex Identity Hub пароль этого пользователя не будет изменен в Active Directory. Если после изменения пароля выполнить [полную синхронизацию](sync-agent.md#full-sync), агент заменит обновленный пароль в Yandex Identity Hub паролем, взятым из Active Directory. Это также поведение по умолчанию, если функциональность обратной записи не активирована.
  
  - dry_run
    
    Настройки [тестового запуска](sync-agent.md#dry-run) агента (dry run):
    
    * `enabled: true` — активирован режим dry run. Агент не вносит изменения в данные пользователей и групп Yandex Identity Hub. Вместо этого он тестирует выполнение всех предусмотренных конфигурацией агента операций и сохраняет результаты этих тестов в [логах](sync-agent.md#logging) его работы.
    * `enabled: false` — агент функционирует в рабочем режиме, необходимые изменения вносятся в данные пользователей и групп Yandex Identity Hub.
  
  - drsr
    
    Настройки протокола [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) для аутентификации на стороне Active Directory с использованием Kerberos.
  
  - ldap
    
    Настройки протокола [LDAPS](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/enable-ldap-over-ssl-3rd-certification-authority)/[LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/) для аутентификации на стороне Active Directory с использованием Kerberos:
    
    {% note warning %}
    
    Вы можете подключаться к контроллеру домена по протоколу `LDAPS` или `LDAP`. Рекомендованным и безопасным протоколом является `LDAPS`. Протокол `LDAP` используйте только при настройке и тестировании.
    
    {% endnote %}
    
    * `host` — домен или IP-адрес контроллера домена Active Directory. В зависимости от используемого протокола указываются схема и номер порта:
    
        * при использовании `LDAPS` — схема `ldaps://` и порт `636`;
        * при использовании `LDAP` — схема `ldap://` и порт `389`.
    * `certificate_path` — путь к файлу с корневым сертификатом удостоверяющего центра (CA), которым подписан сертификат контроллера домена. Необязательный параметр.
    
        Укажите этот параметр, если вы используете протокол `LDAPS` и корневой сертификат отсутствует в системном хранилище доверенных сертификатов.
    
        Если в параметре `working_directory` задан путь к рабочей директории, вместо пути к файлу сертификата достаточно указать имя этого файла.
    * `insecure_skip_verify` — параметр, позволяющий игнорировать ошибки валидации сертификата открытого ключа при подключении к контроллеру домена. Необязательный параметр. Возможные значения:
    
        * `false` — ошибки валидации сертификата не будут игнорироваться. Значение по умолчанию.
        * `true` — агент синхронизации будет игнорировать ошибки валидации сертификата. Может быть полезно при настройке и тестировании синхронизации. Не рекомендуется использовать в рабочем режиме.
    * `use_kerberos` — параметр, указывающий на необходимость использовать протокол Kerberos для аутентификации пользователя на стороне Active Directory.
  
  - kerberos
    
    Настройки протокола Kerberos для аутентификации на стороне Active Directory:
    
    * `keytab_path` — путь к файлу `keytab` с ключами шифрования.
    * `principal` — [SPN](https://learn.microsoft.com/en-us/windows/win32/ad/service-principal-names) пользовательского аккаунта для подключения к Active Directory.
    * `krb5_config_path` — путь к файлу конфигурации Kerberos. Необязательный параметр. По умолчанию используется путь `/etc/krb5.conf` или значение, заданное в переменной окружения `KRB5_CONFIG`.
    * `disable_pa_fx_fast: true` — параметр, управляющий режимом [FAST](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831747(v=ws.11)#kerberos-armoring-flexible-authentication-secure-tunneling-fast).
  
  - logger
    
    Настройки [логирования](sync-agent.md#logging) процесса синхронизации:
    
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
  
  - sync_settings
    
    Настройки процесса синхронизации:
    
    * `interval` — периодичность выполнения [инкрементальной синхронизации](sync-agent.md#incremental-sync). Необязательный параметр. Значение по умолчанию — 240 секунд.
    
        {% note info %}
    
        Периодичность выполнения синхронизации паролей и состояний пользователей в Active Directory составляет несколько секунд, является константой и не зависит от значения, заданного в параметре `interval`.
    
        {% endnote %}
    
    * `allow_to_capture_users` — параметр, позволяющий изменять существующего пользователя пула Yandex Identity Hub при совпадении его логина с логином пользователя Active Directory, которого требуется синхронизировать. Возможные значения:
    
        * `true` — агент синхронизации будет изменять существующих пользователей Yandex Identity Hub, приводя их в соответствие с учетной записью в Active Directory.
        * `false` — агент синхронизации не будет изменять существующих пользователей Yandex Identity Hub. При обнаружении совпадения логинов пользователя в пуле и в Active Directory процесс синхронизации выдаст ошибку.
    * `allow_to_capture_groups` — параметр, позволяющий изменять существующую группу пользователей Yandex Identity Hub при совпадении ее имени с именем группы в Active Directory, которую требуется синхронизировать. Возможные значения:
    
        * `true` — агент синхронизации будет изменять существующие группы пользователей Yandex Identity Hub, приводя их в соответствие с группами в Active Directory.
        * `false` — агент синхронизации не будет изменять существующие группы пользователей Yandex Identity Hub. При обнаружении совпадения имен групп в пуле и в Active Directory процесс синхронизации выдаст ошибку.
    * `replacement_domain` — [домен](../domains.md), привязанный к пулу пользователей Yandex Identity Hub, в котором находятся синхронизируемые пользователи и группы. Например: `newdomain.idp.yandexcloud.net`.
    
        Необязательный параметр. Значение параметра `replacement_domain` требуется задавать только в том случае, если имя домена, привязанного к пулу пользователей, отличается от имени домена на контроллере домена Active Directory.
    * `user_attribute_mapping` — настройки сопоставления атрибутов пользователя:
    
        * `source` — имя атрибута пользователя, получаемое из Active Directory и отличное от имени, [заданного по умолчанию](index.md#sync-objects).
    
            Если вы хотите отключить синхронизацию атрибута, оставьте значение пустым: `source: ""`.
        * `target` — имя атрибута на стороне Yandex Cloud, с которым настраивается сопоставление (или для которого отключается синхронизация). Список доступных значений смотрите в таблице **Атрибуты пользователей** в разделе [Объекты синхронизации](index.md#sync-objects).
        * `type` — выбор действия в отношении указанного атрибута. Возможные значения:
    
            * `direct` — настроить сопоставление атрибутов.
            * `empty` — отключить синхронизацию атрибута.
    
        Необязательный параметр. Значение параметра `user_attribute_mapping` необходимо задавать только в том случае, если требуется настроить сопоставление имен атрибутов пользователя, отличных от заданных по умолчанию для Active Directory, или отключить синхронизацию отдельных атрибутов.
    * `group_attribute_mapping` — настройки сопоставления атрибутов групп пользователей:
    
        * `source` — имя атрибута групп пользователей, получаемое из Active Directory и отличное от имени, [заданного по умолчанию](index.md#sync-objects).
    
            Если вы хотите отключить синхронизацию атрибута, оставьте значение пустым: `source: ""`.
        * `target` — имя атрибута на стороне Yandex Cloud, с которым настраивается сопоставление (или для которого отключается синхронизация). Список доступных значений смотрите в таблице **Атрибуты групп пользователей** в разделе [Объекты синхронизации](index.md#sync-objects).
        * `type` — выбор действия в отношении указанного атрибута. Возможные значения:
    
            * `direct` — настроить сопоставление атрибутов.
            * `empty` — отключить синхронизацию атрибута.
    
        Необязательный параметр. Значение параметра `group_attribute_mapping` необходимо задавать только в том случае, если требуется настроить сопоставление имен атрибутов групп пользователей, отличных от заданных по умолчанию для Active Directory, или отключить синхронизацию отдельных атрибутов.
    * `filter` — настройки фильтрации синхронизируемых объектов на стороне Active Directory:
    
        * `domain` — имя домена на контроллере домена Active Directory, в котором агент будет синхронизировать пользователей и группы.
        * `organization_units` — список Organization Units (OU) в каталоге Active Directory, в которых агент будет синхронизировать пользователей и группы.
        * `groups` — список групп пользователей в каталоге Active Directory, в которых агент будет синхронизировать пользователей. Вы можете указать одну или несколько групп, при этом фильтр по нескольким группам будет применяться с логикой `ИЛИ`.
    
            {% note info %}
    
            Параметр `groups` влияет только на синхронизацию пользователей и не влияет на настройки синхронизации групп пользователей.
    
            {% endnote %}
    
        Если не настроить фильтрацию синхронизируемых объектов, агент Identity Hub AD Sync Agent попытается синхронизировать все [доступные объекты](index.md#sync-objects) в каталоге Active Directory.
    * `remove_user_behavior` — позволяет управлять действием в отношении пользователей на стороне Yandex Cloud, если соответствующие пользователи на стороне Active Directory были удалены или перестали удовлетворять условиям, заданным в параметрах `sync_settings.filter` (например, они были перенесены в другой Organization Unit). Необязательный параметр. Возможные значения:
    
        * `remove` — пользователи, удаленные или переставшие удовлетворять условиям фильтра, удаляются на стороне Yandex Identity Hub. Действие по умолчанию.
        * `block` — пользователи, удаленные или переставшие удовлетворять условиям фильтра, деактивируются на стороне Yandex Identity Hub.
    
    {% note info %}
    
    Если в процессе синхронизации выясняется, что на стороне Active Directory группа пользователей была удалена или перестала удовлетворять заданным фильтрам (например, она была перенесена в другой Organization Unit), то на стороне Yandex Identity Hub такая группа удаляется.
    
    {% endnote %}

  {% endlist %}

{% endlist %}


#### Полезные ссылки {#see-also}

* [Синхронизация пользователей и групп с Microsoft Active Directory](index.md)
* [Синхронизировать пользователей и группы с Microsoft Active Directory](../../operations/sync-ad.md)

[*gmsa_account]: gMSA (group Managed Service Account) — это тип учетных записей в Microsoft Active Directory, паролями для которых автоматически управляет контроллер домена, что упрощает запуск и работу одной и той же службы (SPN) на разных серверах. Подробнее читайте в [документации Microsoft](https://learn.microsoft.com/ru-ru/windows-server/identity/ad-ds/manage/group-managed-service-accounts/group-managed-service-accounts/group-managed-service-accounts-overview).