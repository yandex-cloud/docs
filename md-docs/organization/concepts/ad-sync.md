# Синхронизация пользователей и групп с Microsoft Active Directory


{% note info %}

Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

Если для управления пользователями ваша компания использует [Microsoft Active Directory](https://docs.microsoft.com/ru-ru/windows-server/identity/ad-ds/active-directory-domain-services) и вы хотите организовать для ваших пользователей доступ к Yandex Cloud, вам не нужно вручную создавать для них учетные записи в Yandex Cloud. Вместо этого вы можете [синхронизировать](../operations/sync-ad.md) с Yandex Identity Hub пользователей и группы, созданные в вашем каталоге Active Directory.

{% note info %}

В настоящее время пользователей из Active Directory можно синхронизировать только с [локальными пользователями](../../iam/concepts/users/accounts.md#local) Yandex Cloud в пределах [пулов пользователей](user-pools.md).

{% endnote %}

Синхронизация пользователей и групп выполняется [агентом](#sync-agent) синхронизации Identity Hub AD Sync Agent, который может быть запущен на любом сервере под управлением ОС [Linux](https://ru.wikipedia.org/wiki/Linux) или [Windows](https://ru.wikipedia.org/wiki/Windows).

Схема синхронизации:

![ad-sync-agent](../../_assets/organization/ad-sync-agent.svg)

На сервере, где [запущен](../operations/sync-ad.md) агент синхронизации, должны быть открыты следующие [TCP](https://ru.wikipedia.org/wiki/TCP)-порты для входящего и исходящего трафика:

* Для обращения к API Yandex Cloud:

    * `443` — для [HTTPS](https://ru.wikipedia.org/wiki/HTTPS);

* Для обращения к контроллеру домена Active Directory:

    * `389` — для [LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/);
    * `636` — для [LDAPS](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/enable-ldap-over-ssl-3rd-certification-authority);
    * `135` — для [MSRPC](https://learn.microsoft.com/en-us/windows/win32/rpc/rpc-start-page);
    * `49152:65535` — диапазон портов для MSRPC dynamic.

## Объекты синхронизации {#sync-objects}

Агент Identity Hub AD Sync Agent синхронизирует с каталогом Active Directory следующие объекты:

* **Пользователи**.
* **Атрибуты пользователей**.

    Таблица сопоставления атрибутов пользователей:

    Имя атрибута </br>в [конфигурации агента](#agent-config) | Имя атрибута в Active Directory </br>(по умолчанию) | Имя атрибута </br>в Yandex Identity Hub
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

    В параметре `user_attribute_mapping` [конфигурации агента](#agent-config) вы можете настроить сопоставление имен атрибутов пользователя, отличных от заданных по умолчанию для Active Directory, или отключить синхронизацию отдельных атрибутов.
* **Группы пользователей**.
* **Атрибуты групп пользователей**.

    Таблица сопоставления атрибутов групп пользователей:

    Имя атрибута </br>в [конфигурации агента](#agent-config) | Имя атрибута в Active Directory </br>(по умолчанию) | Имя атрибута </br>в Yandex Identity Hub
    --- | --- | ---
    `Name` | `name` | `name`
    `Description` | `description` | `description`
    н/д | `ObjectGUID` | `external_id`

    В параметре `group_attribute_mapping` [конфигурации агента](#agent-config) вы можете настроить сопоставление имен атрибутов групп пользователей, отличных от заданных по умолчанию для Active Directory, или отключить синхронизацию отдельных атрибутов.
* **Членства пользователей в группах**.
* **[Хеши](https://ru.wikipedia.org/wiki/Хеш-функция) паролей пользователей**.

    Пароли пользователей хранятся в Active Directory не в открытом виде, а в виде хешей. Yandex Cloud, получив из каталога Active Directory хеш пароля пользователя, формирует на его основе собственный хеш с использованием современного и устойчивого к взлому алгоритма [Argon2](https://ru.wikipedia.org/wiki/Argon2).

    {% note alert %}

    Yandex Cloud не хранит в своих базах данных пароли пользователей в открытом виде.

    {% endnote %}

## Настройка синхронизации {#sync-setup}

Чтобы реализовать синхронизацию пользователей и групп Yandex Identity Hub с Active Directory, необходимо выполнить предварительные настройки, как на стороне вашего [контроллера домена](https://ru.wikipedia.org/wiki/Контроллер_домена) с развернутыми службами Active Directory, так и на стороне Yandex Cloud.

### Настройка на стороне контроллера домена Active Directory {#dc-setup}

Для корректной работы [агента](#sync-agent) синхронизации на стороне Active Directory выполните следующие действия:

1. Создайте пользователя домена, от имени которого агент будет выполнять синхронизацию.
1. Выдайте этому пользователю следующие разрешения:

    * `Replicating Directory Changes`;
    * `Replicating Directory Changes All`.
1. На контроллере домена откройте сетевые [TCP](https://ru.wikipedia.org/wiki/TCP)-порты для входящего трафика, поступающего с IP-адреса сервера, на котором установлен агент Identity Hub AD Sync Agent:

    * `389` — для [LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/);
    * `636` — для [LDAPS](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/enable-ldap-over-ssl-3rd-certification-authority);
    * `135` — для [MSRPC](https://learn.microsoft.com/en-us/windows/win32/rpc/rpc-start-page);
    * `49152:65535` — диапазон портов для MSRPC dynamic.

### Настройка на стороне Yandex Cloud {#yc-setup}

Для корректной работы [агента](#sync-agent) синхронизации на стороне Yandex Cloud выполните следующие действия:

* [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт, от имени которого синхронизация будет выполняться на стороне Yandex Identity Hub.
* [Назначьте](../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) сервисному аккаунту следующие [роли](../../iam/concepts/access-control/roles.md) на [организацию](organization.md), в которой находится нужный пул пользователей:

    * [`organization-manager.userpools.syncAgent`](../security/index.md#organization-manager-userpools-syncAgent);
    * [`organization-manager.groups.viewer`](../security/index.md#organization-manager-groups-viewer);
    * [`organization-manager.groups.externalCreator`](../security/index.md#organization-manager-groups-externalCreator);
    * [`organization-manager.groups.externalConverter`](../security/index.md#organization-manager-groups-externalConverter).

* (Опционально) [Создайте](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) и сохраните [авторизованный ключ](../../iam/concepts/authorization/key.md) сервисного аккаунта.

    {% note warning %}
    
    Авторизованный ключ не нужен, если агент синхронизации устанавливается на [виртуальную машину](../../compute/concepts/vm.md) Yandex Compute Cloud, к которой подключен сервисный аккаунт с необходимыми правами доступа.
    
    {% endnote %}

## Агент Identity Hub AD Sync Agent {#sync-agent}

Агент синхронизации Identity Hub AD Sync Agent выполняет чтение данных о пользователях и группах пользователей в [выбранных](#agent-config) Organization Units (OU) в каталоге Active Directory и синхронизирует их с данными пользователей и групп пользователей в [пуле](user-pools.md) Yandex Identity Hub.

На стороне Active Directory агент синхронизации получает данные пользователей и групп от имени пользователя, [созданного](#dc-setup) в домене Active Directory. При получении этих данных используются протоколы [LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/) и [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/), запросы отправляются на адрес контроллера домена Active Directory, заданный в [конфигурации](#agent-config) агента.

На стороне Yandex Cloud агент синхронизации управляет пользователями и группами пользователей от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) с [назначенными](#yc-setup) разрешениями на выполнение синхронизации. Запросы к Yandex Cloud направляются на публичный эндпоинт `https://organization-manager.api.cloud.yandex.net` по протоколу [HTTPS](https://ru.wikipedia.org/wiki/HTTPS). Для аутентификации агента в API Yandex Cloud используется авторизованный ключ сервисного аккаунта или (только при установке на ВМ Compute Cloud) — [IAM-токен](../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, [получаемый](../../compute/operations/vm-metadata/get-vm-metadata.md#example5) через [сервис метаданных](../../compute/concepts/vm-metadata.md) ВМ.

Скрипт установки агента синхронизации доступен для следующих операционных систем:

* [Linux](https://storage.yandexcloud.net/yc-identityhub-sync/install.sh);
* [Windows](https://storage.yandexcloud.net/yc-identityhub-sync/install.ps1).

### Процесс синхронизации {#sync-process}

В процессе синхронизации данных агент Identity Hub AD Sync Agent может создавать, изменять или удалять пользователей и группы пользователей в Yandex Identity Hub. Синхронизация пользователей и групп Yandex Identity Hub с пользователями и группами в Active Directory выполняется в два этапа: [первичная синхронизация](#full-sync) и [инкрементальная синхронизация](#incremental-sync).

При выполнении синхронизации в пуле пользователей может обнаружиться пользователь или группа пользователей с именами, идентичными именам пользователя или группы, которые требуется синхронизировать. В этом случае агент, в зависимости от [заданных настроек](#agent-config), перезапишет данные из Active Directory для существующего пользователя или группу Yandex Identity Hub, либо выведет сообщение об ошибке.

#### Полная (первичная) синхронизация {#full-sync}

При выполнении полной синхронизации агент считывает данные всех пользователей, групп и их атрибутов в [выбранных](#agent-config) Organization Units в каталоге Active Directory и создает аналогичных пользователей и группы с аналогичными атрибутами в пуле пользователей Yandex Identity Hub.

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

* _Синхронизация паролей и состояний пользователей_ — агент отслеживает статус блокировки/разблокировки пользователей в домене Active Directory и смену пользовательских паролей и переносит эти изменения в Yandex Identity Hub с интервалом в несколько секунд. Частоту выполнения этого типа синхронизации изменить нельзя.
* _Синхронизация иных значений_ — агент отслеживает прочие изменения свойств, атрибутов и параметров пользователей и групп с интервалом, [установленным](#agent-config) в файле конфигурации агента.

#### Тестовый запуск (dry run) {#dry-run}

Агент Identity Hub AD Sync Agent можно запустить в тестовом режиме (dry run). Этот режим позволяет убедиться в корректности вносимых в конфигурацию агента изменений прежде чем применять эти изменения в рабочем режиме.

В режиме тестового запуска агент не вносит изменения в данные пользователей и групп Yandex Identity Hub. Вместо этого он тестирует выполнение всех операций, вызванных вносимыми в конфигурацию агента изменениями, и сохраняет результаты этих тестов в [логах](#logging) работы агента.

Подробнее о том, как запустить агент в режиме dry run, читайте в разделе [Протестируйте изменения в конфигурации агента](../operations/sync-ad.md#dry-run).

### Отслеживаемые изменения {#tracked-changes}

В процессе непрерывной синхронизации агент отслеживает следующие изменения в Active Directory и переносит их в Yandex Identity Hub:

* создание, изменение, блокировка, разблокировка и удаление пользователей;
* создание, изменение и удаление групп пользователей;
* изменение атрибутов пользователей и групп;
* добавление пользователей в группы и исключение их из групп;
* изменение паролей пользователей.

### Логирование процесса синхронизации {#logging}

Агент Identity Hub AD Sync Agent регистрирует события, возникающие в процессе синхронизации.

По умолчанию информация о событиях и ошибках выводится в [стандартный поток](https://ru.wikipedia.org/wiki/Стандартные_потоки) `stdout`. Вместо этого в [конфигурации](#agent-config) агента вы можете задать настройки для сохранения логов в файлы.

По умолчанию информация о событиях выводится в простом текстовом формате, но в конфигурации агента формат можно изменить на [JSON](https://ru.wikipedia.org/wiki/JSON).

Кроме того, в конфигурации агента можно задать следующие уровни логирования:

* `debug`
* `info`
* `warn`
* `error`
* `dpanic`
* `panic`
* `fatal`

### Конфигурация агента {#agent-config}

Конфигурация агента синхронизации задается в [YAML](https://yaml.org/)-файле в следующем формате:

```yml
# Default configuration for yc-identityhub-sync-agent
# This is a template - please update with your actual values

userpool_id: "<идентификатор_пула_пользователей>"
replication_tokens_path: "<путь_к_директории_с_токенами_процессов>"
working_directory: "<путь_к_рабочей_директории_агента>"

# Yandex Cloud authentication settings

# Use the cloud_credentials_file_path parameter for authentication via an authorized key.
# If you want the agent to authenticate via IAM tokens, remove the cloud_credentials_file_path line.
cloud_credentials_file_path: "<путь_к_файлу_с_авторизованным_ключом>"

# Enable the use_metadata_service parameter for authentication via IAM tokens
# (only available when the agent is installed on a Compute Cloud VM).
# If `true`, the cloud_credentials_file_path parameter will be ignored.
use_metadata_service: true|false

# Enable the Dry Run mode.
# If `true`, no changes will be applied to users or groups in Yandex Identity Hub.
# Instead, all pending operations will be saved to the current log file location.
dry_run:
  enabled: true|false

# Active Directory replication API client settings
drsr:
  host: "<IP-адрес_контроллера_домена>"
  username: "username"
  password: "password"

# LDAP client settings
ldap:
  host: "ldaps://<IP-адрес_контроллера_домена>:636"
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

* `userpool_id` — идентификатор [пула пользователей](user-pools.md) в Yandex Identity Hub.
* `replication_tokens_path` — путь к директории, в которой сохраняются токены с информацией о текущем прогрессе процессов [полной синхронизации](ad-sync.md#full-sync). Необязательный параметр.

    Если параметр не задан, токены сохраняются в рабочей директории агента, указанной в параметре `working_directory`, или, если рабочая директория не задана, — в директории, в которой расположен исполняемый файл агента.
* `working_directory` — путь к директории, в которой сохраняются другие файлы, необходимые агенту для работы. Необязательный параметр.

    Если параметр не задан, в качестве рабочей директории используется директория, в которой расположен исполняемый файл агента. По умолчанию исполняемый файл агента располагается в следующих директориях:

    * `/etc/yc-identityhub-sync-agent/` (для Linux);
    * `C:\\ProgramData\\YcIdentityHubSyncAgent\\` (для Windows).

* `cloud_credentials_file_path` — путь к файлу, содержащему [авторизованный ключ](../../iam/concepts/authorization/key.md) сервисного аккаунта в Yandex Cloud. Необязательный параметр: используется только при аутентификации агента в API Yandex Cloud с помощью авторизованного ключа.

    Примеры значений:

    * `/etc/yc-identityhub-sync-agent/authorized_key.json` (для Linux);
    * `C:\\ProgramData\\YcIdentityHubSyncAgent\\authorized_key.json` (для Windows).

    В параметре `cloud_credentials_file_path` вместо полного пути вы можете передать только имя файла. В этом случае файл будет сохранен в рабочей директории, заданной в параметре `working_directory`, или, если рабочая директория не задана, — в директории, в которой расположен исполняемый файл агента.

    {% note info %}

    Если в параметрах `cloud_credentials_file_path`, `replication_tokens_path` и/или `logger.file.filename` заданы пути, отличные от пути, заданного в параметре `working_directory`, для выбранных сущностей будут использоваться пути, указанные в параметрах `cloud_credentials_file_path`, `replication_tokens_path` и/или `logger.file.filename`.

    {% endnote %}

* `use_metadata_service` — параметр, управляющий аутентификацией агента в API Yandex Cloud с помощью [IAM-токена](../../iam/concepts/authorization/iam-token.md) и позволяющий агенту получать IAM-токены через [сервис метаданных](../../compute/concepts/vm-metadata.md) ВМ.

    Возможные значения:

    * `true` — агент синхронизации будет получать IAM-токены сервисного аккаунта через сервис метаданных виртуальной машины и использовать их для аутентификации в API Yandex Cloud. Значение параметра `cloud_credentials_file_path` при этом будет игнорироваться.

        Чтобы агент мог получать IAM-токены, он должен быть установлен на виртуальной машине Yandex Compute Cloud, к которой подключен сервисный аккаунт с [необходимыми](ad-sync.md#yc-setup) правами доступа.
    * `false` — агент синхронизации не будет получать IAM-токены, а аутентификация в API Yandex Cloud будет выполняться с помощью авторизационного ключа, заданного в параметре `cloud_credentials_file_path`.
* `dry_run` — настройки [тестового запуска](ad-sync.md#dry-run) агента (dry run):

    * `enabled: true` — активирован режим dry run. Агент не вносит изменения в данные пользователей и групп Yandex Identity Hub. Вместо этого он тестирует выполнение всех предусмотренных конфигурацией агента операций и сохраняет результаты этих тестов в [логах](ad-sync.md#logging) его работы.
    * `enabled: false` — агент функционирует в рабочем режиме, необходимые изменения вносятся в данные пользователей и групп Yandex Identity Hub.
* `drsr` — настройки протокола [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) для аутентификации на стороне Active Directory [пользователя](#dc-setup) с назначенными правами на выполнение репликации данных в каталоге.
* `ldap` — настройки протокола [LDAPS](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/enable-ldap-over-ssl-3rd-certification-authority)/[LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/) для аутентификации на стороне Active Directory:

    {% note warning %}

    Вы можете подключаться к контроллеру домена по протоколу `LDAPS` или `LDAP`. Рекомендованным и безопасным протоколом является `LDAPS`. Протокол `LDAP` используйте только при настройке и тестировании.

    {% endnote %}

    * `host` — IP-адрес контроллера домена Active Directory. В зависимости от используемого протокола указываются схема и номер порта:

        * при использовании `LDAPS` — схема `ldaps://` и порт `636`;
        * при использовании `LDAP` — схема `ldap://` и порт `389`.
    * `username` — имя пользователя домена Active Directory, которому [назначены](#dc-setup) права на выполнение репликации данных.
    * `password` — пароль пользователя домена Active Directory.
    * `certificate_path` — путь к файлу с сертификатом открытого ключа, необходимого для расшифрования трафика от контроллера домена. Обязательный параметр при использовании протокола `LDAPS`.

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

    * `format` — формат вывода информации о событиях. Необязательный параметр. Возможные значения:

        * `plain` — информация выводится в простом текстовом виде. Значение по умолчанию.
        * `json` — информация выводится в формате [JSON](https://ru.wikipedia.org/wiki/JSON).
    * `file` — настройки сохранения логов в файлы:

        * `filename` — путь к файлу, в который будет сохраняться информация о событиях при синхронизации.

            В параметре `filename` вместо полного пути вы можете передать только имя файла. В этом случае файл будет сохранен в рабочей директории, заданной в параметре `working_directory`, или, если рабочая директория не задана, — в директории, в которой расположен исполняемый файл агента.

            Необязательный параметр. Имя файла по умолчанию — `identity_hub.log`.
        * `maxsize` — максимальный размер одного файла с логами в мегабайтах.
        * `maxbackups` — максимальное количество файлов с логами, которые агент будет хранить. При превышении максимального количества файлов наиболее старый файл будет удален.

        Необязательный параметр. Если настройки в параметре `file` не заданы, информация не сохраняется в файлы, а выводится в поток `stdout`.
* `sync_settings` — настройки процесса синхронизации:

    * `interval` — периодичность выполнения [инкрементальной синхронизации](ad-sync.md#incremental-sync). Необязательный параметр. Значение по умолчанию — 240 секунд.

        {% note info %}

        Периодичность выполнения синхронизации паролей и состояний пользователей в Active Directory составляет несколько секунд, является константой и не зависит от значения, заданного в параметре `interval`.

        {% endnote %}

    * `allow_to_capture_users` — параметр, позволяющий изменять существующего пользователя пула Yandex Identity Hub при совпадении его логина с логином пользователя Active Directory, которого требуется синхронизировать. Возможные значения:

        * `true` — агент синхронизации будет изменять существующих пользователей Yandex Identity Hub, приводя их в соответствие с учетной записью в Active Directory.
        * `false` — агент синхронизации не будет изменять существующих пользователей Yandex Identity Hub. При обнаружении совпадения логинов пользователя в пуле и в Active Directory процесс синхронизации выдаст ошибку.
    * `allow_to_capture_groups` — параметр, позволяющий изменять существующую группу пользователей Yandex Identity Hub при совпадении ее имени с именем группы в Active Directory, которую требуется синхронизировать. Возможные значения:

        * `true` — агент синхронизации будет изменять существующие группы пользователей Yandex Identity Hub, приводя их в соответствие с группами в Active Directory.
        * `false` — агент синхронизации не будет изменять существующие группы пользователей Yandex Identity Hub. При обнаружении совпадения имен групп в пуле и в Active Directory процесс синхронизации выдаст ошибку.
    * `replacement_domain` — [домен](domains.md), привязанный к пулу пользователей Yandex Identity Hub, в котором находятся синхронизируемые пользователи и группы. Например: `newdomain.idp.yandexcloud.net`.

        Необязательный параметр. Значение параметра `replacement_domain` требуется задавать только в том случае, если имя домена, привязанного к пулу пользователей, отличается от имени домена на контроллере домена Active Directory.
    * `user_attribute_mapping` — настройки сопоставления атрибутов пользователя:

        * `source` — имя атрибута пользователя, получаемое из Active Directory и отличное от имени, [заданного по умолчанию](ad-sync.md#sync-objects).

            Если вы хотите отключить синхронизацию атрибута, оставьте значение пустым: `source: ""`.
        * `target` — имя атрибута на стороне Yandex Cloud, с которым настраивается сопоставление (или для которого отключается синхронизация). Список доступных значений смотрите в таблице **Атрибуты пользователей** в разделе [Объекты синхронизации](ad-sync.md#sync-objects).
        * `type` — выбор действия в отношении указанного атрибута. Возможные значения:

            * `direct` — настроить сопоставление атрибутов.
            * `empty` — отключить синхронизацию атрибута.

        Необязательный параметр. Значение параметра `user_attribute_mapping` необходимо задавать только в том случае, если требуется настроить сопоставление имен атрибутов пользователя, отличных от заданных по умолчанию для Active Directory, или отключить синхронизацию отдельных атрибутов.
    * `group_attribute_mapping` — настройки сопоставления атрибутов групп пользователей:

        * `source` — имя атрибута групп пользователей, получаемое из Active Directory и отличное от имени, [заданного по умолчанию](ad-sync.md#sync-objects).

            Если вы хотите отключить синхронизацию атрибута, оставьте значение пустым: `source: ""`.
        * `target` — имя атрибута на стороне Yandex Cloud, с которым настраивается сопоставление (или для которого отключается синхронизация). Список доступных значений смотрите в таблице **Атрибуты групп пользователей** в разделе [Объекты синхронизации](ad-sync.md#sync-objects).
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

        Если не настроить фильтрацию синхронизируемых объектов, агент Identity Hub AD Sync Agent попытается синхронизировать все [доступные объекты](ad-sync.md#sync-objects) в каталоге Active Directory.
    * `remove_user_behavior` — позволяет управлять действием в отношении пользователей на стороне Yandex Cloud, если соответствующие пользователи на стороне Active Directory были удалены или перестали удовлетворять условиям, заданным в параметрах `sync_settings.filter` (например, они были перенесены в другой Organization Unit). Необязательный параметр. Возможные значения:

        * `remove` — пользователи, удаленные или переставшие удовлетворять условиям фильтра, удаляются на стороне Yandex Identity Hub. Действие по умолчанию.
        * `block` — пользователи, удаленные или переставшие удовлетворять условиям фильтра, деактивируются на стороне Yandex Identity Hub.

    {% note info %}

    Если в процессе синхронизации выясняется, что на стороне Active Directory группа пользователей была удалена или перестала удовлетворять заданным фильтрам (например, она была перенесена в другой Organization Unit), то на стороне Yandex Identity Hub такая группа удаляется.

    {% endnote %}

#### См. также {#see-also}

* [Синхронизировать пользователей и группы с Microsoft Active Directory](../operations/sync-ad.md)