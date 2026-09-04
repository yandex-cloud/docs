# {{ iam-name }}

{{ iam-name }} — компонент для управления доступом пользователей и сервисных аккаунтов к ресурсам платформы. Компонент обеспечивает централизованную аутентификацию и авторизацию во всех сервисах платформы.

## Основные возможности {#features}

### Управление пользователями {#user-management}

{{ iam-name }} поддерживает несколько способов управления пользователями:

* Локальные пользователи — создание и управление пользователям происходит непосредственно в {{ iam-name }}. Подходит для небольших команд или тестовых окружений.
* Внешние провайдеры идентификации — интеграция с корпоративными системами управления пользователями по протоколу SAML. Позволяет использовать существующую инфраструктуру аутентификации.

### Управление группами {#group-management}

Группы позволяют упростить управление правами доступа для команд пользователей. С помощью {{ iam-name }} доступны:

* Создание локальных групп в {{ iam-name }}.
* Управление членством пользователей в группах.
* Маппинг групп из внешних провайдеров идентификации на внутренние группы.
* Назначение ролей группам вместо отдельных пользователей.

### Управление доступом {#access-management}

{{ iam-name }} предоставляет гибкую систему управления правами доступа:

* **Роли** — набор разрешений для выполнения операций с ресурсами.
* **Назначение ролей** — выдача ролей пользователям, группам и сервисным аккаунтам на различных уровнях:
  * Уровень организации — доступ ко всем ресурсам.
  * Уровень проекта — доступ к ресурсам в конкретном пространстве имен.
  * Уровень сервисных ресурсов — доступ к ресурсам сервисов.

### Сервисные аккаунты {#service-accounts}

Сервисные аккаунты используются для автоматизации и межсервисного взаимодействия:

* Создание сервисных аккаунтов для приложений и сервисов.
* Генерация API-ключей для аутентификации.
* Назначение ролей сервисным аккаунтам.
* Интеграция с Kubernetes ServiceAccount.

## Начало работы {#getting-started}

### Первый вход {#first-login}

При развертывании платформы автоматически создается администратор с логином `admin@stackland`. Временный пароль сохраняется в секрете `admin-password` в проекте `stackland-secrets`. При первом входе необходимо изменить пароль.

### Создание пользователей {#create-users}

Администратор может создавать новых пользователей двумя способами:

1. Создать локального пользователя непосредственно в {{ iam-name }} через веб-интерфейс.
1. Через внешний провайдер идентификации – настроить подключение к SAML-провайдеру. Пользователи будут автоматически создаваться при первом входе.

### Назначение ролей {#assign-roles}

После создания пользователя ему можно назначить роли на различных уровнях:

* На уровне организации — для доступа ко всем ресурсам платформы.
* На уровне проекта — для доступа к ресурсам в конкретном пространстве имен.
* На уровне сервисных ресурсов — для доступа к специфичным ресурсам сервисов.

## Примеры использования {#examples}

### Создание локального пользователя {#example-local-user}

Локальные пользователи создаются через IAM API. Для создания пользователя необходимо указать:

* Имя пользователя в формате `username@stackland`.
* Полное имя пользователя.
* Имя.
* Фамилию.
* Email.
* Пароль.

После создания пользователь может войти в систему, используя указанные учетные данные.

### Назначение роли на уровне организации {#example-org-role}

Для назначения роли пользователю на уровне организации используется ресурс `ClusterAccessBinding`:

```yaml
apiVersion: iam.stackland.yandex.cloud/v1alpha1
kind: ClusterAccessBinding
metadata:
  name: user-admin-role
spec:
  # Роль для назначения
  roleID: "admin"
  # Субъект, которому назначается роль
  subject:
    kind: User
    name: "username@stackland"
```

Где:

* `roleID` — идентификатор роли IAM (например, `admin`, `editor`, `viewer`). Обязательное поле. Должен соответствовать существующей роли в {{ iam-name }}.
* `subject` — субъект, которому назначается роль. Обязательное поле.
  * `kind` — тип субъекта. Допустимые значения: `User`, `Group`, `ServiceAccount`, `FederatedUser`. Обязательное поле.
  * `name` — имя субъекта. Для пользователей — имя пользователя из {{ iam-name }}. Обязательное поле.

### Назначение роли группе {#example-group-role}

Для назначения роли группе пользователей используется тот же ресурс `ClusterAccessBinding` с указанием типа субъекта `Group`:

```yaml
apiVersion: iam.stackland.yandex.cloud/v1alpha1
kind: ClusterAccessBinding
metadata:
  name: stackland-cluster-admins
spec:
  roleID: admin
  subject:
    kind: Group
    name: stackland-cluster-admins
```

Где:

* `roleID` — идентификатор роли IAM. Обязательное поле.
* `subject.kind` — тип субъекта `Group` для назначения роли группе. Обязательное поле.
* `subject.name` — имя группы в {{ iam-name }}. Обязательное поле.

### Назначение роли на уровне пространства имен {#example-namespace-role}

Для назначения роли на уровне пространства имен используется ресурс `AccessBinding`:

```yaml
apiVersion: iam.stackland.yandex.cloud/v1alpha1
kind: AccessBinding
metadata:
  name: bob-is-storage-admin
  namespace: warehouse
spec:
  roleID: storage.admin
  subject:
    kind: User
    name: bob@stackland
```

**Описание полей:**

* `metadata.namespace` — пространство имен, на уровне которого назначается роль. Роль будет действовать на folder, соответствующий этому проекту. Обязательное поле.
* `roleID` — идентификатор роли IAM. Обязательное поле.
* `subject` — субъект, которому назначается роль. Обязательное поле.
  * `kind` — тип субъекта. Допустимые значения: `User`, `Group`, `ServiceAccount`, `FederatedUser`. Обязательное поле.
  * `name` — имя субъекта. Обязательное поле.

### Назначение роли сервисному аккаунту {#example-sa-role}

Для назначения роли сервисному аккаунту необходимо указать тип субъекта `ServiceAccount` и проект, в котором находится сервисный аккаунт:

```yaml
apiVersion: iam.stackland.yandex.cloud/v1alpha1
kind: AccessBinding
metadata:
  name: sa-storage-admin
  namespace: my-namespace
spec:
  roleID: "storage.admin"
  subject:
    kind: ServiceAccount
    name: "my-service-account"
    namespace: "my-namespace"
```

Где:

* `metadata.namespace` — проект, на уровне которого назначается роль. Обязательное поле.
* `roleID` — идентификатор роли IAM. Обязательное поле.
* `subject` — субъект, которому назначается роль. Обязательное поле.
  * `kind` — тип субъекта `ServiceAccount`. Обязательное поле.
  * `name` — имя Kubernetes ServiceAccount. Обязательное поле.
  * `namespace` — проект, в котором находится ServiceAccount. Обязательное поле для типа `ServiceAccount`.

### Настройка внешнего провайдера идентификации {#example-external-idp}

{% list tabs %}

- SAML {#saml}

  Для интеграции с внешним провайдером идентификации по протоколу SAML используется ресурс `SAMLFederation`:

  ```yaml
  apiVersion: iam.stackland.yandex.cloud/v1alpha1
  kind: SAMLFederation
  metadata:
    name: corporate-idp
  spec:
    # Описание федерации
    description: "Corporate Identity Provider"
    # URL провайдера идентификации
    issuer: "https://idp.company.com/realms/main"
    # URL для Single Sign-On
    ssoUrl: "https://idp.company.com/realms/main/protocol/saml"
    # Тип привязки SAML
    ssoBinding: POST
    # Автоматическое создание пользователей при первом входе
    autoCreateAccountOnLogin: true
    # Время жизни cookie сессии
    cookieMaxAge: "12h"
    # Сертификаты для проверки подписи SAML-ответов
    certificates:
      - name: "idp-signing-cert"
        description: "IdP signing certificate"
        data: |
          -----BEGIN CERTIFICATE-----
          ...
          -----END CERTIFICATE-----
    # Маппинг внешних групп на внутренние
    groupMapping:
      enabled: true
      mapping:
        - externalId: "idp-admins"
          internalName: "stackland-cluster-admins"
        - externalId: "idp-developers"
          internalName: "developers"
  ```

  Где:

  * `description` — описание федерации. Необязательное поле. Максимальная длина 256 символов.
  * `issuer` — идентификатор провайдера идентификации (Entity ID). Обычно это URL. Обязательное поле.
  * `ssoUrl` — URL для Single Sign-On в провайдере идентификации. Обязательное поле.
  * `ssoBinding` — тип привязки SAML. Допустимые значения: `POST`, `REDIRECT`. По умолчанию `POST`.
  * `autoCreateAccountOnLogin` — автоматически создавать учетные записи пользователей при первом входе. По умолчанию `false`.
  * `cookieMaxAge` — время жизни cookie сессии. Допустимый диапазон от 10 минут до 12 часов. Поддерживает формат Go duration: `2h`, `120m`, `7200s`. По умолчанию `12h`.
  * `caseInsensitiveNameIds` — обрабатывать SAML NameID без учета регистра. По умолчанию `false`.
  * `securitySettings` — настройки безопасности SAML. Необязательное поле.
    * `encryptedAssertions` — требовать зашифрованные SAML-утверждения от провайдера. По умолчанию `false`.
    * `forceAuthn` — требовать повторную аутентификацию при каждом запросе. По умолчанию `false`.
  * `certificates` — список сертификатов для проверки подписи SAML-ответов. Необязательное поле.
    * `name` — имя сертификата. Обязательное поле.
    * `description` — описание сертификата. Необязательное поле.
    * `data` — сертификат в формате PEM. Обязательное поле.
  * `groupMapping` — настройки маппинга групп. Необязательное поле.
    * `enabled` — включить маппинг групп. По умолчанию `false`.
    * `mapping` — список соответствий внешних и внутренних групп. Необязательное поле.
      * `externalId` — идентификатор группы в провайдере идентификации. Обязательное поле.
      * `internalName` — имя группы в {{ iam-name }}. Группа должна существовать. Обязательное поле.

- Active Directory {#ad}

  Для синхронизации пользователей и групп из Active Directory используется встроенный в {{ iam-name }} агент синхронизации.

  Чтобы настроить синхронизацию:

  1. Создайте секрет с паролями для подключения к Active Directory:

     ```yaml
     apiVersion: v1
     kind: Secret
     metadata:
       name: ad-secret
       namespace: default
     stringData:
       drsr-password: "<пароль_DRSR>"
       ldap-password: "<пароль_LDAP>"
     ```

  1. Настройте ресурс `IAMConfig`:

     ```yaml
     apiVersion: stackland.yandex.cloud/v1alpha1
     kind: IAMConfig
     metadata:
       name: main
     spec:
       enabled: true
       settings:
         activeDirectorySync:
           enabled: true
           settings:
             userpoolDomain: "<домен_пула_пользователей>"
             drsr:
               host: "<хост_контроллера_домена>"
               username: "<имя_пользователя_DRSR>"
               passwordRef:
                 key: drsr-password
                 name: ad-secret
                 namespace: default
             ldap:
               host: "ldaps://<хост_контроллера_домена>:<порт>"
               username: "<имя_пользователя_LDAP>"
               passwordRef:
                 key: ldap-password
                 name: ad-secret
                 namespace: default
               certificate: "<сертификат_CA>"
               insecureSkipVerify: false
             interval: "60s"
             filter:
               domain: "<имя_домена_в_Active_Directory>"
               groups: []
               organizationUnits: []
             allowToCaptureUsers: true
             allowToCaptureGroups: true
             userAttributeMapping: []
             groupAttributeMapping: []
             removeUserBehavior: "remove"
     ```

     Где:

     * `enabled` — включить синхронизацию с Active Directory. Обязательное поле.
     * `userpoolDomain` — домен, под которым пользователи из Active Directory будут отображаться в платформе. Обязательное поле.
     * `drsr` — настройки подключения по протоколу DRSR. Обязательное поле.
       * `host` — хост контроллера домена. Обязательное поле.
       * `username` — имя пользователя. Обязательное поле.
       * `passwordRef` — ссылка на секрет с паролем. Обязательное поле.
         * `name` — имя секрета. Обязательное поле.
         * `namespace` — пространство имен секрета. Обязательное поле.
         * `key` — ключ секрета. Обязательное поле.
     * `ldap` — настройки подключения по протоколу LDAP. Обязательное поле.
       * `host` — адрес контроллера домена в формате `ldap://` или `ldaps://`. Обязательное поле.
       * `username` — имя пользователя. Обязательное поле.
       * `passwordRef` — ссылка на секрет с паролем. Обязательное поле.
         * `name` — имя секрета. Обязательное поле.
         * `namespace` — пространство имен секрета. Обязательное поле.
         * `key` — ключ секрета. Обязательное поле.
       * `certificate` — сертификат CA в формате PEM для проверки TLS-соединения. Необязательное поле.
       * `insecureSkipVerify` — отключить проверку TLS-сертификата сервера. Рекомендуется не включать.
     * `interval` — интервал инкрементальной синхронизации. Обязательное поле.
     * `filter` — фильтрация объектов для синхронизации. Необязательное поле.
       * `domain` — имя домена в Active Directory. Необязательное поле.
       * `groups` — список групп для синхронизации. Необязательное поле.
       * `organizationUnits` — список организационных единиц для синхронизации. Необязательное поле.
     * `allowToCaptureUsers` — параметр, позволяющий изменять существующего пользователя пула при совпадении его логина с логином пользователя Active Directory, которого требуется синхронизировать.
     * `allowToCaptureGroups` — параметр, позволяющий изменять существующую группу пользователей при совпадении ее имени с именем группы в Active Directory, которую требуется синхронизировать.
     * `userAttributeMapping` — переопределение маппинга атрибутов пользователей. Необязательное поле.
     * `groupAttributeMapping` — переопределение маппинга атрибутов групп. Необязательное поле.
     * `removeUserBehavior` — поведение при удалении пользователя из Active Directory. Допустимые значения: `remove`, `block`.

{% endlist %}
