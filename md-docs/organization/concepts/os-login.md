# OS Login

OS Login упрощает процесс [SSH](../../glossary/ssh-keygen.md)-подключений к _виртуальным машинам_ в Yandex Cloud. Под виртуальными машинами (или ВМ) здесь и ниже подразумеваются собственно [виртуальные машины сервиса Yandex Compute Cloud](../../compute/concepts/vm.md#project), хосты [подкластеров Yandex Data Processing](../../data-proc/concepts/index.md#resources) и [отдельные узлы в группах узлов](../../managed-kubernetes/concepts/index.md#node-group) в составе [кластеров Yandex Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), на которых запускаются пользовательские контейнеры.

С помощью OS Login можно управлять SSH-доступом к ВМ, полагаясь только на механизмы [сервиса Yandex Identity and Access Management](../../iam/concepts/index.md), без необходимости загружать SSH-ключи на каждую новую ВМ при ее создании. OS Login связывает учетную запись пользователя ВМ с аккаунтом в Yandex Identity Hub — учетной записью [пользователя организации](membership.md) или [сервисным аккаунтом](../../iam/concepts/users/service-accounts.md).

Преимущества OS Login:

* Моментальное обновление [прав доступа](../../iam/concepts/access-control/roles.md) для пользователя внутри ВМ в случае отзыва или назначения ролей. Если у пользователя отозвать роли, он потеряет доступ ко всем ВМ, для которых был включен доступ через OS Login.
* Возможность использовать разные способы доступа к ВМ: как по короткоживущим SSH-сертификатам, так и по SSH-ключам, в том числе добавленным в профиль пользователя организации.

## Структура OS Login {#structure}

В состав OS Login входят следующие элементы: [агент OS Login](#agent), [настройки режимов работы](#modes) OS Login на уровне организации, а также [профили OS Login](#os-login-profiles) и [SSH-ключи](#ssh-keys) пользователей и сервисных аккаунтов в организации.

### Агент OS Login {#agent}

_Агент OS Login_ разработан на основе [Guest Agent for Google Compute Engine](https://github.com/GoogleCloudPlatform/guest-agent). Изменения, внесенные командой Yandex Cloud, можно отслеживать в [репозитории на GitHub](https://github.com/yandex-cloud/yandex-cloud-guest-agent).

Агент OS Login интегрирован в [ряд образов ОС Linux](https://yandex.cloud/ru/marketplace?search=oslogin), которые доступны при создании ВМ.

### Настройки режимов работы OS Login на уровне организации Yandex Identity Hub {#modes}

OS Login позволяет использовать следующие _режимы работы_ как по отдельности, так и оба одновременно:

* **Режим 1**: Доступ по OS Login при помощи SSH-сертификатов (рекомендуется).
    Режим позволяет подключаться к ВМ по SSH-сертификату [через Yandex Cloud CLI](../../compute/operations/vm-connect/os-login.md#connect-with-yc-cli) и [через стандартный SSH-клиент](../../compute/operations/vm-connect/os-login.md#connect-with-ssh-client).

* **Режим 2**: Доступ по OS Login при помощи SSH-ключей.
    Режим позволяет подключаться к ВМ через Yandex Cloud CLI и через стандартный SSH-клиент по SSH-ключу, сохраненному в [профиле OS Login](os-login.md#os-login-profiles) пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

### Профили OS Login пользователей и сервисных аккаунтов {#os-login-profiles}

_Профиль OS Login_ определяет параметры, которые будут использоваться при создании учетной записи пользователя внутри ВМ.

При [включении](../operations/os-login-access.md) в организации доступа по OS Login для всех пользовательских аккаунтов этой организации автоматически создаются _профили OS Login по умолчанию_.

Имя пользователя (логин), назначаемое пользовательскому аккаунту в профиле OS Login по умолчанию, формируется на основе имени этого пользователя в организации: любые символы, кроме букв латинского алфавита, цифр, дефиса и подчеркивания, а также дефис в начале имени — игнорируются, заглавные буквы латинского алфавита преобразуются в строчные.

{% note info %}

Для сервисных аккаунтов профили OS Login не создаются автоматически. Чтобы подключаться к ВМ или узлу Kubernetes от имени сервисного аккаунта, вручную [создайте](../operations/os-login-profile-create.md) для него профиль OS Login.

{% endnote %}

У одного пользователя или сервисного аккаунта в организации Yandex Identity Hub может быть несколько профилей OS Login — разные профили позволяют подключаться к ВМ от имени разных локальных пользователей ВМ. Подробнее о создании дополнительных профилей OS Login см. в инструкции [Создать профиль OS Login](../operations/os-login-profile-create.md).

Каждому профилю OS Login присваивается числовой идентификатор UID, который соответствует идентификатору [UID](https://ru.wikipedia.org/wiki/Идентификатор_пользователя) пользователя в операционных системах виртуальных машин. UID профиля OS Login должен быть уникальным в пределах как [организации](organization.md), так и операционной системы виртуальной машины.

{% note warning %}

Нельзя допускать совпадения UID профиля OS Login и системных профилей операционной системы. Если вы задаете UID вручную, используйте значения в диапазоне от `1002` до `2^63 - 1`, чтобы избежать такого совпадения.

{% endnote %}

Управлять профилями OS Login пользователей вы можете в [интерфейсе Cloud Center](https://center.yandex.cloud/organization), а также с помощью [Yandex Cloud CLI](../../cli/cli-ref/organization-manager/cli-ref/oslogin/index.md) и [API](../api-ref/OsLogin/index.md). Управлять профилями OS Login сервисных аккаунтов можно только с помощью Yandex Cloud CLI или API.

Минимально необходимая роль, позволяющая просматривать список профилей OS Login пользователей — [роль](../security/index.md#organization-manager-osLogins-viewer) `organization-manager.osLogins.viewer`, назначенная на организацию. Информацию о других ролях, позволяющих просматривать список профилей OS Login, смотрите в разделе [Управление доступом в Yandex Identity Hub](../security/index.md#service-roles).

### SSH-ключи пользователей и сервисных аккаунтов {#ssh-keys}

Включив [режим 2](#modes), [администратор организации](../security/index.md#organization-manager-admin) может разрешить использовать публичные SSH-ключи для подключения пользователей и сервисных аккаунтов к ВМ по OS Login. При включении данного режима администратор должен будет самостоятельно загрузить публичные SSH-ключи пользователей и сервисных аккаунтов в их [профили OS Login](#os-login-profiles).

Администратор организации также может разрешить пользователям самостоятельно управлять своими публичными SSH-ключами, для этого нужно дополнительно [включить](../operations/os-login-access.md) опцию **Разрешить членам организации управлять своими SSH-ключами** в настройках безопасности организации.

Загружать SSH-ключи в [профили OS Login](os-login.md#os-login-profiles) сервисных аккаунтов могут только пользователи [с аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport), [федеративные](../../iam/concepts/users/accounts.md#saml-federation) или [локальные](../../iam/concepts/users/accounts.md#local) пользователи, которым назначена [роль](../security/index.md#organization-manager-osLogins-admin) `organization-manager.osLogins.admin` или выше.

### Необходимые условия для использования OS Login {#pre-conditions}

{% note info %}

OS Login работает только с виртуальными машинами на базе ОС Linux. ВМ с другими типами операционных систем, в том числе с ОС Windows, не поддерживаются.

{% endnote %}

Чтобы начать [подключаться](#os-login-connection) к ВМ по OS Login, необходимо:

* [Включить доступ к ВМ через OS Login](../operations/os-login-access.md) на уровне организации.
* [Развернуть ВМ](../../compute/operations/vm-connect/os-login-create-vm.md) из [образа](https://yandex.cloud/ru/marketplace?search=oslogin) с интегрированным [агентом OS Login](#agent).
    Если ВМ создана из образа без интегрированного агента OS Login, вы можете самостоятельно [установить агента](../../compute/operations/vm-connect/enable-os-login.md#enable-os-login).
* При создании ВМ в консоли управления в блоке **Доступ** выберите вариант **Доступ по OS Login**. Если этот вариант неактивен, значит выбранный образ не поддерживает доступ по OS Login.

{% note info %}

Если на уровне организации [включен](../operations/os-login-access.md) доступ по OS Login, то для новых ВМ, создаваемых в этой организации, полю `serial_port_settings.ssh_authorization` по умолчанию будет присваиваться значение `OS_LOGIN`. Если доступ по OS Login в организации выключен, этому полю по умолчанию будет присваиваться значение `INSTANCE_METADATA`.

{% endnote %}

## Подключение по OS Login {#os-login-connection}

Подключиться к виртуальной машине с включенным доступом по OS Login можно как с помощью стандартного SSH-клиента, так и с помощью [Yandex Cloud CLI](../../cli/quickstart.md).

### Подключение с помощью стандартного SSH-клиента {#connect-with-ssh-client}

Пользователи, а также (с помощью сервисных аккаунтов) сторонние инструменты, такие как [Terraform](https://www.terraform.io/) или [Ansible](https://www.ansible.com/), могут использовать стандартный SSH-клиент, чтобы [подключаться](../../compute/operations/vm-connect/os-login.md#connect-with-ssh-client) к ВМ с включенным доступом по OS Login с помощью короткоживущего SSH-сертификата или SSH-ключа, [сохраненного](../operations/add-ssh.md) в профиле OS Login пользователя или сервисного аккаунта.

Чтобы подключиться к ВМ через стандартный SSH-клиент с использованием SSH-сертификата, нужно [экспортировать](../../compute/operations/vm-connect/os-login-export-certificate.md) SSH-сертификат и использовать его при подключении.

{% cut "Пример подключения по короткоживущему SSH-сертификату" %}

```bash
# 1. Получение публичного IP-адреса ВМ my-oslogin-vm и идентификатора организации
PUB_IP=$(yc compute instance get my-oslogin-vm \
  --format=json | jq -r '.network_interfaces[0].primary_v4_address.one_to_one_nat.address')
ORG_ID=$(yc organization-manager organization list --format=json | jq -r '.[0].id')

# 2. Получение короткоживущего SSH-сертификата
yc compute ssh certificate export --organization-id $ORG_ID --directory ~/Downloads/cert

# 3. Подключение к ВМ по публичному IP-адресу ВМ
ssh -i ~/Downloads/cert/yc-organization-id-bpfdp4pdeg8d********-username username@$PUB_IP
```

В данном примере:

1. С помощью команд `yc compute instance get` и `yc organization-manager organization list` получаются и сохраняются в переменные публичный IP-адрес виртуальной машины `my-oslogin-vm` и идентификатор текущей организации.
1. С помощью команды `yc compute ssh certificate export` в директорию `~/Downloads/cert` экспортируется короткоживущий SSH-сертификат пользователя.
1. Полученный SSH-сертификат используется для подключения к ВМ по сохраненному ранее публичному IP-адресу.

{% endcut %}

Сертификат действителен один час. По истечении этого времени для подключения к ВМ необходимо экспортировать новый сертификат.

### Подключение с помощью Yandex Cloud CLI {#connect-with-yc-cli}

Подключиться к виртуальной машине с включенным доступом по OS Login с помощью Yandex Cloud CLI можно как по SSH-ключу, [сохраненному](../operations/add-ssh.md) в профиле OS Login пользователя или сервисного аккаунта, так и по SSH-сертификату этого пользователя или сервисного аккаунта.

Подробнее о подключении к ВМ по OS Login см. в инструкциях [Подключиться с помощью Yandex Cloud CLI](../../compute/operations/vm-connect/os-login.md#connect-with-yc-cli), [Подключиться к узлу Kubernetes по OS Login](../../managed-kubernetes/operations/node-connect-oslogin.md#connect-via-cli) и [Подключение к кластеру Yandex Data Processing](../../data-proc/operations/connect-oslogin.md#os-login-cli).

### Необходимые роли для подключения к ВМ по OS Login {#necessary-roles}

Чтобы подключиться к виртуальной машине или узлу Kubernetes с включенным доступом по OS Login пользователю или [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), от имени которого выполняется подключение, должны быть назначены роли:

* [роль](../../compute/security/index.md#compute-oslogin) `compute.osLogin` или `compute.osAdminLogin`.
* [роль](../../resource-manager/security/index.md#resource-manager-auditor) `resource-manager.auditor` и выше на каталог, в котором размещена виртуальная машина или узел Kubernetes.
* [роль](../../compute/security/index.md#compute-operator) `compute.operator` для подключении с помощью Yandex Cloud CLI.

{% note alert %}

Если у пользователя есть права [суперпользователя](https://ru.wikipedia.org/wiki/Root) на ВМ, то он может сохранить доступ к ней даже при [отзыве ролей](../security/index.md#revoke). Чтобы пользователь не смог зайти на ВМ с прежними правами, [создайте](../../compute/operations/images-with-pre-installed-software/create.md) новую ВМ из чистого образа.

{% endnote %}

## Примеры использования {#examples}

* [Использование сервисного аккаунта с профилем OS Login для управления ВМ с помощью Ansible](../tutorials/sa-oslogin-ansible.md)
* [Разграничение прав доступа для групп пользователей с различными ролями в Yandex Identity Hub](../../tutorials/security/user-group-access-control.md)

#### Полезные ссылки {#see-also}

* [Включить доступ по OS Login](../operations/os-login-access.md)
* [Создать профиль OS Login](../operations/os-login-profile-create.md)
* [Использовать сервисный аккаунт с профилем OS Login для управления ВМ с помощью Ansible](../tutorials/sa-oslogin-ansible.md)
* [Чеклист безопасности аутентификации и авторизации](../../security/domains/iam-checklist.md)