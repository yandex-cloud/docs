# Синхронизация пользователей и групп с {{ microsoft-idp.ad-full }}


{% note info %}

Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

Если для управления пользователями ваша компания использует [{{ microsoft-idp.ad-full }}](https://docs.microsoft.com/ru-ru/windows-server/identity/ad-ds/active-directory-domain-services) и вы хотите организовать для ваших пользователей доступ к {{ yandex-cloud }}, вам не нужно вручную создавать для них учетные записи в {{ yandex-cloud }}. Вместо этого вы можете [синхронизировать](../operations/sync-ad.md) с {{ org-full-name }} пользователей и группы, созданные в вашем каталоге {{ microsoft-idp.ad-short }}.

{% note info %}

В настоящее время пользователей из {{ microsoft-idp.ad-short }} можно синхронизировать только с [локальными пользователями](../../iam/concepts/users/accounts.md#local) {{ yandex-cloud }} в пределах [пулов пользователей](user-pools.md).

{% endnote %}

Синхронизация пользователей и групп выполняется [агентом](#sync-agent) синхронизации {{ ad-sync-agent }}, который может быть запущен на любом сервере под управлением ОС [Linux](https://ru.wikipedia.org/wiki/Linux) или [Windows](https://ru.wikipedia.org/wiki/Windows).

Схема синхронизации:

```mermaid
flowchart TB
    A["{{ ad-sync-agent }}"]
    subgraph B [organization-manager.{{ api-host }}]
    D["{{ yandex-cloud }} API"]
    end
    subgraph C [IP-адрес контроллера домена]
    E["Контроллер домена {{ microsoft-idp.ad-short }}"]
    end
    A e1@==>|"TCP 443 (HTTPS)"|B
    A e2@==>|"TCP 389 (LDAP)<br/>TCP 636 (LDAPS)<br/>TCP 135 (MSRPC)<br/>TCP 49152:65535<br/>(MSRPC dynamic)<br/>TCP/UDP 53 (Kerberos)<br/>TCP/UDP 88 (Kerberos)"|C
    class B myStyle
    class C myStyle
    e1@{ curve: linear }
    e2@{ curve: linear }
    classDef myStyle fill:transparent,stroke-width:0
```

На сервере, где [запущен](../operations/sync-ad.md) агент синхронизации, должны быть открыты следующие сетевые порты для входящего и исходящего трафика:

* Для обращения к API {{ yandex-cloud }}:

    * `443 (TCP)` — для [HTTPS](https://ru.wikipedia.org/wiki/HTTPS);

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

## Объекты синхронизации {#sync-objects}

Агент {{ ad-sync-agent }} синхронизирует с каталогом {{ microsoft-idp.ad-short }} следующие объекты:

* **Пользователи**.
* **Атрибуты пользователей**.

    Таблица сопоставления атрибутов пользователей:

    Имя атрибута </br>в [конфигурации агента](#agent-config) | Имя атрибута в {{ microsoft-idp.ad-short }} </br>(по умолчанию) | Имя атрибута </br>в {{ org-full-name }}
    --- | --- | ---
    `FullName` | `displayName` | `full_name`
    `GivenName` | `givenName` | `given_name`
    `FamilyName` | `sn` | `family_name`
    `Email` | `mail` | `email`
    `PhoneNumber` | `telephoneNumber` | `phone_number`
    `Username` | `userPrincipalName` | `username`
    `EmployeeId` | `employeeID` | `employee_id`
    `Department` | `department` | `department`
    `JobTitle` | `title` | `job_title`
    `CompanyName` | `company` | `company_name`
    н/д | `ObjectGUID` | `external_id`

    В параметре `user_attribute_mapping` [конфигурации агента](#agent-config) вы можете настроить сопоставление имен атрибутов пользователя, отличных от заданных по умолчанию для {{ microsoft-idp.ad-short }}, или отключить синхронизацию отдельных атрибутов.
* **Группы пользователей**.
* **Атрибуты групп пользователей**.

    Таблица сопоставления атрибутов групп пользователей:

    Имя атрибута </br>в [конфигурации агента](#agent-config) | Имя атрибута в {{ microsoft-idp.ad-short }} </br>(по умолчанию) | Имя атрибута </br>в {{ org-full-name }}
    --- | --- | ---
    `Name` | `name` | `name`
    `Description` | `description` | `description`
    н/д | `ObjectGUID` | `external_id`

    В параметре `group_attribute_mapping` [конфигурации агента](#agent-config) вы можете настроить сопоставление имен атрибутов групп пользователей, отличных от заданных по умолчанию для {{ microsoft-idp.ad-short }}, или отключить синхронизацию отдельных атрибутов.
* **Членства пользователей в группах**.
* **[Хеши](https://ru.wikipedia.org/wiki/Хеш-функция) паролей пользователей**.

    Пароли пользователей хранятся в {{ microsoft-idp.ad-short }} не в открытом виде, а в виде хешей. {{ yandex-cloud }}, получив из каталога {{ microsoft-idp.ad-short }} хеш пароля пользователя, формирует на его основе собственный хеш с использованием современного и устойчивого к взлому алгоритма [Argon2](https://ru.wikipedia.org/wiki/Argon2).

    {% note alert %}

    {{ yandex-cloud }} не хранит в своих базах данных пароли пользователей в открытом виде.

    {% endnote %}

## Настройка синхронизации {#sync-setup}

Чтобы реализовать синхронизацию пользователей и групп {{ org-full-name }} с {{ microsoft-idp.ad-short }}, необходимо выполнить предварительные настройки, как на стороне вашего [контроллера домена](https://ru.wikipedia.org/wiki/Контроллер_домена) с развернутыми службами {{ microsoft-idp.ad-short }}, так и на стороне {{ yandex-cloud }}.

### Настройка на стороне контроллера домена {{ microsoft-idp.ad-short }} {#dc-setup}

Для корректной работы [агента](#sync-agent) синхронизации на стороне {{ microsoft-idp.ad-short }} выполните следующие действия:

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

### Настройка на стороне {{ yandex-cloud }} {#yc-setup}

Для корректной работы [агента](#sync-agent) синхронизации на стороне {{ yandex-cloud }} выполните следующие действия:

* [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт, от имени которого синхронизация будет выполняться на стороне {{ org-full-name }}.
* [Назначьте](../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) сервисному аккаунту следующие [роли](../../iam/concepts/access-control/roles.md) на [организацию](organization.md), в которой находится нужный пул пользователей:

    * [`organization-manager.userpools.syncAgent`](../security/index.md#organization-manager-userpools-syncAgent);
    * [`organization-manager.groups.viewer`](../security/index.md#organization-manager-groups-viewer);
    * [`organization-manager.groups.externalCreator`](../security/index.md#organization-manager-groups-externalCreator);
    * [`organization-manager.groups.externalConverter`](../security/index.md#organization-manager-groups-externalConverter).
    
    Если вы планируете выгружать логи работы агента синхронизации в [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }}, дополнительно назначьте сервисному аккаунту [роль](../../logging/security/index.md#logging-writer) `logging.writer` на соответствующую лог-группу или [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором она расположена.

* (Опционально) [Создайте](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) и сохраните [авторизованный ключ](../../iam/concepts/authorization/key.md) сервисного аккаунта.

    {% note warning %}
    
    Авторизованный ключ не нужен, если агент синхронизации устанавливается на [виртуальную машину](../../compute/concepts/vm.md) {{ compute-full-name }}, к которой подключен сервисный аккаунт с необходимыми правами доступа.
    
    {% endnote %}

## Агент {{ ad-sync-agent }} {#sync-agent}

Агент синхронизации {{ ad-sync-agent }} выполняет чтение данных о пользователях и группах пользователей в [выбранных](#agent-config) Organization Units (OU) в каталоге {{ microsoft-idp.ad-short }} и синхронизирует их с данными пользователей и групп пользователей в [пуле](user-pools.md) {{ org-full-name }}.

Скрипт установки агента синхронизации доступен для следующих операционных систем:

* [Linux]({{ ad-sync-agent-linuxlink }});
* [Windows]({{ ad-sync-agent-windowslink }}).

### Аутентификация на стороне {{ microsoft-idp.ad-short }} {#agent-ad-auth}

На стороне {{ microsoft-idp.ad-short }} агент синхронизации получает данные пользователей и групп от имени пользователя, [созданного](#dc-setup) в домене {{ microsoft-idp.ad-short }}. При получении этих данных используются протоколы [LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/) и [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/), запросы отправляются на адрес контроллера домена {{ microsoft-idp.ad-short }}, заданный в [конфигурации](#agent-config) агента.

Аутентификация агента синхронизации на стороне {{ microsoft-idp.ad-short }} может осуществляться по имени и паролю пользователя домена или с использованием протокола Kerberos версии 5.

{% note info %}

Использование протокола Kerberos в настоящий момент возможно только при установке агента синхронизации на сервер с ОС Linux.

{% endnote %}

### Аутентификация на стороне {{ yandex-cloud }} {#agent-yc-auth}

На стороне {{ yandex-cloud }} агент синхронизации управляет пользователями и группами пользователей от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) с [назначенными](#yc-setup) разрешениями на выполнение синхронизации. Запросы к {{ yandex-cloud }} направляются на публичный эндпоинт `https://organization-manager.{{ api-host }}` по протоколу [HTTPS](https://ru.wikipedia.org/wiki/HTTPS). Для аутентификации агента в API {{ yandex-cloud }} используется авторизованный ключ сервисного аккаунта или (только при установке на ВМ {{ compute-name }}) — [IAM-токен](../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, [получаемый](../../compute/operations/vm-metadata/get-vm-metadata.md#example5) через [сервис метаданных](../../compute/concepts/vm-metadata.md) ВМ.

### Процесс синхронизации {#sync-process}

В процессе синхронизации данных агент {{ ad-sync-agent }} может создавать, изменять или удалять пользователей и группы пользователей в {{ org-full-name }}. Синхронизация пользователей и групп {{ org-full-name }} с пользователями и группами в {{ microsoft-idp.ad-short }} выполняется в два этапа: [первичная синхронизация](#full-sync) и [инкрементальная синхронизация](#incremental-sync).

При выполнении синхронизации в пуле пользователей может обнаружиться пользователь или группа пользователей с именами, идентичными именам пользователя или группы, которые требуется синхронизировать. В этом случае агент, в зависимости от [заданных настроек](#agent-config), перезапишет данные из {{ microsoft-idp.ad-short }} для существующего пользователя или группу {{ org-full-name }}, либо выведет сообщение об ошибке.

#### Полная (первичная) синхронизация {#full-sync}

При выполнении полной синхронизации агент считывает данные всех пользователей, групп и их атрибутов в [выбранных](#agent-config) Organization Units в каталоге {{ microsoft-idp.ad-short }} и создает аналогичных пользователей и группы с аналогичными атрибутами в пуле пользователей {{ org-full-name }}.

Процесс первичной синхронизации для большого количества [объектов](#sync-objects) может занять достаточно длительное время. Если процесс полной синхронизации прервется в результате ошибки, повторный запуск агента продолжит синхронизацию с того места, на котором прервалась предыдущая попытка. Прогресс полной синхронизации агент отслеживает с помощью файлов с токенами процессов в директории с запущенным агентом:

* `main_sync_replication_token.json`
* `password_hash_replication_token.json`
* `user_control_replication_token.json`

После успешного завершения полной синхронизации агент, запущенный в виде сервиса или службы операционной системы, переходит к непрерывному выполнению частичной (инкрементальной) синхронизации.

{% note tip %}

Вы можете повторно запустить процесс полной синхронизации. Для этого удалите указанные выше файлы с токенами процессов и перезапустите агент.

{% endnote %}

#### Частичная (инкрементальная) синхронизация {#incremental-sync}

Инкрементальная синхронизация непрерывно выполняется запущенным агентом со следующей периодичностью:

* _Синхронизация паролей и состояний пользователей_ — агент отслеживает статус блокировки/разблокировки пользователей в домене {{ microsoft-idp.ad-short }} и смену пользовательских паролей и переносит эти изменения в {{ org-full-name }} с интервалом в несколько секунд. Частоту выполнения этого типа синхронизации изменить нельзя.
* _Синхронизация иных значений_ — агент отслеживает прочие изменения свойств, атрибутов и параметров пользователей и групп с интервалом, [установленным](#agent-config) в файле конфигурации агента.

#### Тестовый запуск (dry run) {#dry-run}

Агент {{ ad-sync-agent }} можно запустить в тестовом режиме (dry run). Этот режим позволяет убедиться в корректности вносимых в конфигурацию агента изменений прежде чем применять эти изменения в рабочем режиме.

В режиме тестового запуска агент не вносит изменения в данные пользователей и групп {{ org-full-name }}. Вместо этого он тестирует выполнение всех операций, вызванных вносимыми в конфигурацию агента изменениями, и сохраняет результаты этих тестов в [логах](#logging) работы агента.

Подробнее о том, как запустить агент в режиме dry run, читайте в разделе [{#T}](../operations/sync-ad.md#dry-run).

### Отслеживаемые изменения {#tracked-changes}

В процессе непрерывной синхронизации агент отслеживает следующие изменения в {{ microsoft-idp.ad-short }} и переносит их в {{ org-full-name }}:

* создание, изменение, блокировка, разблокировка и удаление пользователей;
* создание, изменение и удаление групп пользователей;
* изменение атрибутов пользователей и групп;
* добавление пользователей в группы и исключение их из групп;
* изменение паролей пользователей.

### Логирование процесса синхронизации {#logging}

Агент {{ ad-sync-agent }} регистрирует события, возникающие в процессе синхронизации.

По умолчанию информация о событиях и ошибках выводится в [стандартный поток](https://ru.wikipedia.org/wiki/Стандартные_потоки) `stdout`. В [конфигурации](#agent-config) агента вы можете задать настройки для сохранения логов в файлы.

По умолчанию информация о событиях в стандартный поток или файл выводится в простом текстовом формате, но в конфигурации агента формат можно изменить на [JSON](https://ru.wikipedia.org/wiki/JSON).

В [конфигурации](#agent-config) агента вы также можете настроить выгрузку логов в [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }}.

Кроме того, в конфигурации агента можно задать следующие уровни логирования:

* `debug`
* `info`
* `warn`
* `error`
* `dpanic`
* `panic`
* `fatal`

### Конфигурация агента {#agent-config}

Конфигурация агента синхронизации зависит от типа аутентификации, используемого агентом на стороне {{ microsoft-idp.ad-short }}, и задается в [YAML](https://yaml.org/)-файле в следующем формате:

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

  * `userpool_id` — идентификатор [пула пользователей](user-pools.md) в {{ org-full-name }}.
  * `replication_tokens_path` — путь к директории, в которой сохраняются токены с информацией о текущем прогрессе процессов [полной синхронизации](ad-sync.md#full-sync). Необязательный параметр.
  
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
  
          Чтобы агент мог получать IAM-токены, он должен быть установлен на виртуальной машине {{ compute-full-name }}, к которой подключен сервисный аккаунт с [необходимыми](ad-sync.md#yc-setup) правами доступа.
      * `false` — агент синхронизации не будет получать IAM-токены, а аутентификация в API {{ yandex-cloud }} будет выполняться с помощью авторизационного ключа, заданного в параметре `cloud_credentials_file_path`.
  * `dry_run` — настройки [тестового запуска](ad-sync.md#dry-run) агента (dry run):
  
      * `enabled: true` — активирован режим dry run. Агент не вносит изменения в данные пользователей и групп {{ org-full-name }}. Вместо этого он тестирует выполнение всех предусмотренных конфигурацией агента операций и сохраняет результаты этих тестов в [логах](ad-sync.md#logging) его работы.
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
  
      * `interval` — периодичность выполнения [инкрементальной синхронизации](ad-sync.md#incremental-sync). Необязательный параметр. Значение по умолчанию — 240 секунд.
  
          {% note info %}
  
          Периодичность выполнения синхронизации паролей и состояний пользователей в {{ microsoft-idp.ad-short }} составляет несколько секунд, является константой и не зависит от значения, заданного в параметре `interval`.
  
          {% endnote %}
  
      * `allow_to_capture_users` — параметр, позволяющий изменять существующего пользователя пула {{ org-full-name }} при совпадении его логина с логином пользователя {{ microsoft-idp.ad-short }}, которого требуется синхронизировать. Возможные значения:
  
          * `true` — агент синхронизации будет изменять существующих пользователей {{ org-full-name }}, приводя их в соответствие с учетной записью в {{ microsoft-idp.ad-short }}.
          * `false` — агент синхронизации не будет изменять существующих пользователей {{ org-full-name }}. При обнаружении совпадения логинов пользователя в пуле и в {{ microsoft-idp.ad-short }} процесс синхронизации выдаст ошибку.
      * `allow_to_capture_groups` — параметр, позволяющий изменять существующую группу пользователей {{ org-full-name }} при совпадении ее имени с именем группы в {{ microsoft-idp.ad-short }}, которую требуется синхронизировать. Возможные значения:
  
          * `true` — агент синхронизации будет изменять существующие группы пользователей {{ org-full-name }}, приводя их в соответствие с группами в {{ microsoft-idp.ad-short }}.
          * `false` — агент синхронизации не будет изменять существующие группы пользователей {{ org-full-name }}. При обнаружении совпадения имен групп в пуле и в {{ microsoft-idp.ad-short }} процесс синхронизации выдаст ошибку.
      * `replacement_domain` — [домен](domains.md), привязанный к пулу пользователей {{ org-full-name }}, в котором находятся синхронизируемые пользователи и группы. Например: `newdomain.idp.{{ dns-ns-host-sld }}`.
  
          Необязательный параметр. Значение параметра `replacement_domain` требуется задавать только в том случае, если имя домена, привязанного к пулу пользователей, отличается от имени домена на контроллере домена {{ microsoft-idp.ad-short }}.
      * `user_attribute_mapping` — настройки сопоставления атрибутов пользователя:
  
          * `source` — имя атрибута пользователя, получаемое из {{ microsoft-idp.ad-short }} и отличное от имени, [заданного по умолчанию](ad-sync.md#sync-objects).
  
              Если вы хотите отключить синхронизацию атрибута, оставьте значение пустым: `source: ""`.
          * `target` — имя атрибута на стороне {{ yandex-cloud }}, с которым настраивается сопоставление (или для которого отключается синхронизация). Список доступных значений смотрите в таблице **Атрибуты пользователей** в разделе [{#T}](ad-sync.md#sync-objects).
          * `type` — выбор действия в отношении указанного атрибута. Возможные значения:
  
              * `direct` — настроить сопоставление атрибутов.
              * `empty` — отключить синхронизацию атрибута.
  
          Необязательный параметр. Значение параметра `user_attribute_mapping` необходимо задавать только в том случае, если требуется настроить сопоставление имен атрибутов пользователя, отличных от заданных по умолчанию для {{ microsoft-idp.ad-short }}, или отключить синхронизацию отдельных атрибутов.
      * `group_attribute_mapping` — настройки сопоставления атрибутов групп пользователей:
  
          * `source` — имя атрибута групп пользователей, получаемое из {{ microsoft-idp.ad-short }} и отличное от имени, [заданного по умолчанию](ad-sync.md#sync-objects).
  
              Если вы хотите отключить синхронизацию атрибута, оставьте значение пустым: `source: ""`.
          * `target` — имя атрибута на стороне {{ yandex-cloud }}, с которым настраивается сопоставление (или для которого отключается синхронизация). Список доступных значений смотрите в таблице **Атрибуты групп пользователей** в разделе [{#T}](ad-sync.md#sync-objects).
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
  
          Если не настроить фильтрацию синхронизируемых объектов, агент {{ ad-sync-agent }} попытается синхронизировать все [доступные объекты](ad-sync.md#sync-objects) в каталоге {{ microsoft-idp.ad-short }}.
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

  * `userpool_id` — идентификатор [пула пользователей](user-pools.md) в {{ org-full-name }}.
  * `replication_tokens_path` — путь к директории, в которой сохраняются токены с информацией о текущем прогрессе процессов [полной синхронизации](ad-sync.md#full-sync). Необязательный параметр.
  
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
  
          Чтобы агент мог получать IAM-токены, он должен быть установлен на виртуальной машине {{ compute-full-name }}, к которой подключен сервисный аккаунт с [необходимыми](ad-sync.md#yc-setup) правами доступа.
      * `false` — агент синхронизации не будет получать IAM-токены, а аутентификация в API {{ yandex-cloud }} будет выполняться с помощью авторизационного ключа, заданного в параметре `cloud_credentials_file_path`.
  * `dry_run` — настройки [тестового запуска](ad-sync.md#dry-run) агента (dry run):
  
      * `enabled: true` — активирован режим dry run. Агент не вносит изменения в данные пользователей и групп {{ org-full-name }}. Вместо этого он тестирует выполнение всех предусмотренных конфигурацией агента операций и сохраняет результаты этих тестов в [логах](ad-sync.md#logging) его работы.
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
  
      * `interval` — периодичность выполнения [инкрементальной синхронизации](ad-sync.md#incremental-sync). Необязательный параметр. Значение по умолчанию — 240 секунд.
  
          {% note info %}
  
          Периодичность выполнения синхронизации паролей и состояний пользователей в {{ microsoft-idp.ad-short }} составляет несколько секунд, является константой и не зависит от значения, заданного в параметре `interval`.
  
          {% endnote %}
  
      * `allow_to_capture_users` — параметр, позволяющий изменять существующего пользователя пула {{ org-full-name }} при совпадении его логина с логином пользователя {{ microsoft-idp.ad-short }}, которого требуется синхронизировать. Возможные значения:
  
          * `true` — агент синхронизации будет изменять существующих пользователей {{ org-full-name }}, приводя их в соответствие с учетной записью в {{ microsoft-idp.ad-short }}.
          * `false` — агент синхронизации не будет изменять существующих пользователей {{ org-full-name }}. При обнаружении совпадения логинов пользователя в пуле и в {{ microsoft-idp.ad-short }} процесс синхронизации выдаст ошибку.
      * `allow_to_capture_groups` — параметр, позволяющий изменять существующую группу пользователей {{ org-full-name }} при совпадении ее имени с именем группы в {{ microsoft-idp.ad-short }}, которую требуется синхронизировать. Возможные значения:
  
          * `true` — агент синхронизации будет изменять существующие группы пользователей {{ org-full-name }}, приводя их в соответствие с группами в {{ microsoft-idp.ad-short }}.
          * `false` — агент синхронизации не будет изменять существующие группы пользователей {{ org-full-name }}. При обнаружении совпадения имен групп в пуле и в {{ microsoft-idp.ad-short }} процесс синхронизации выдаст ошибку.
      * `replacement_domain` — [домен](domains.md), привязанный к пулу пользователей {{ org-full-name }}, в котором находятся синхронизируемые пользователи и группы. Например: `newdomain.idp.{{ dns-ns-host-sld }}`.
  
          Необязательный параметр. Значение параметра `replacement_domain` требуется задавать только в том случае, если имя домена, привязанного к пулу пользователей, отличается от имени домена на контроллере домена {{ microsoft-idp.ad-short }}.
      * `user_attribute_mapping` — настройки сопоставления атрибутов пользователя:
  
          * `source` — имя атрибута пользователя, получаемое из {{ microsoft-idp.ad-short }} и отличное от имени, [заданного по умолчанию](ad-sync.md#sync-objects).
  
              Если вы хотите отключить синхронизацию атрибута, оставьте значение пустым: `source: ""`.
          * `target` — имя атрибута на стороне {{ yandex-cloud }}, с которым настраивается сопоставление (или для которого отключается синхронизация). Список доступных значений смотрите в таблице **Атрибуты пользователей** в разделе [{#T}](ad-sync.md#sync-objects).
          * `type` — выбор действия в отношении указанного атрибута. Возможные значения:
  
              * `direct` — настроить сопоставление атрибутов.
              * `empty` — отключить синхронизацию атрибута.
  
          Необязательный параметр. Значение параметра `user_attribute_mapping` необходимо задавать только в том случае, если требуется настроить сопоставление имен атрибутов пользователя, отличных от заданных по умолчанию для {{ microsoft-idp.ad-short }}, или отключить синхронизацию отдельных атрибутов.
      * `group_attribute_mapping` — настройки сопоставления атрибутов групп пользователей:
  
          * `source` — имя атрибута групп пользователей, получаемое из {{ microsoft-idp.ad-short }} и отличное от имени, [заданного по умолчанию](ad-sync.md#sync-objects).
  
              Если вы хотите отключить синхронизацию атрибута, оставьте значение пустым: `source: ""`.
          * `target` — имя атрибута на стороне {{ yandex-cloud }}, с которым настраивается сопоставление (или для которого отключается синхронизация). Список доступных значений смотрите в таблице **Атрибуты групп пользователей** в разделе [{#T}](ad-sync.md#sync-objects).
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
  
          Если не настроить фильтрацию синхронизируемых объектов, агент {{ ad-sync-agent }} попытается синхронизировать все [доступные объекты](ad-sync.md#sync-objects) в каталоге {{ microsoft-idp.ad-short }}.
      * `remove_user_behavior` — позволяет управлять действием в отношении пользователей на стороне {{ yandex-cloud }}, если соответствующие пользователи на стороне {{ microsoft-idp.ad-short }} были удалены или перестали удовлетворять условиям, заданным в параметрах `sync_settings.filter` (например, они были перенесены в другой Organization Unit). Необязательный параметр. Возможные значения:
  
          * `remove` — пользователи, удаленные или переставшие удовлетворять условиям фильтра, удаляются на стороне {{ org-full-name }}. Действие по умолчанию.
          * `block` — пользователи, удаленные или переставшие удовлетворять условиям фильтра, деактивируются на стороне {{ org-full-name }}.
  
      {% note info %}
  
      Если в процессе синхронизации выясняется, что на стороне {{ microsoft-idp.ad-short }} группа пользователей была удалена или перестала удовлетворять заданным фильтрам (например, она была перенесена в другой Organization Unit), то на стороне {{ org-full-name }} такая группа удаляется.
  
      {% endnote %}

{% endlist %}


#### См. также {#see-also}

* [{#T}](../operations/sync-ad.md)