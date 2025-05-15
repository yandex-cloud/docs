# {{ oslogin }}

{{ oslogin }} упрощает процесс [SSH](../../glossary/ssh-keygen.md)-подключений к _виртуальным машинам_ в {{ yandex-cloud }}. Под виртуальными машинами (или ВМ) здесь и ниже подразумеваются как собственно [виртуальные машины сервиса {{ compute-full-name }}](../../compute/concepts/vm.md#project), так и [отдельные узлы в группах узлов](../../managed-kubernetes/concepts/index.md#node-group) в составе [кластеров {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), на которых запускаются пользовательские контейнеры.

С помощью {{ oslogin }} можно управлять SSH-доступом к ВМ, полагаясь только на механизмы [сервиса {{ iam-full-name }}](../../iam/concepts/index.md), без необходимости загружать SSH-ключи на каждую новую ВМ при ее создании. {{ oslogin }} связывает учетную запись пользователя ВМ с аккаунтом в {{ org-full-name }} — учетной записью [пользователя организации](../../organization/concepts/membership.md) или [сервисным аккаунтом](../../iam/concepts/users/service-accounts.md).

Преимущества {{ oslogin }}:

* Моментальное обновление [прав доступа](../../iam/concepts/access-control/roles.md) для пользователя внутри ВМ в случае отзыва или назначения ролей. Если у пользователя отозвать роли, он потеряет доступ ко всем ВМ, для которых был включен доступ через {{ oslogin }}.
* Возможность использовать разные способы доступа к ВМ: как по короткоживущим SSH-сертификатам, так и по SSH-ключам, в том числе добавленным в профиль пользователя организации.

## Структура {{ oslogin }} {#structure}

В состав {{ oslogin }} входят следующие элементы: [агент {{ oslogin }}](#agent), [настройки режимов работы](#modes) {{ oslogin }} на уровне организации, а также [профили {{ oslogin }}](#os-login-profiles) и [SSH-ключи](#ssh-keys) пользователей и сервисных аккаунтов в организации.

### Агент {{ oslogin }} {#agent}

_Агент {{ oslogin }}_ разработан на основе [Guest Agent for Google Compute Engine](https://github.com/GoogleCloudPlatform/guest-agent). Изменения, внесенные командой {{ yandex-cloud }}, можно отслеживать в [репозитории на GitHub](https://github.com/yandex-cloud/yandex-cloud-guest-agent).

Агент {{ oslogin }} интегрирован в [ряд образов ОС Linux]({{ link-cloud-marketplace }}?search=oslogin), которые доступны при создании ВМ.

### Настройки режимов работы {{ oslogin }} на уровне организации {{ org-name }} {#modes}

{{ oslogin }} позволяет использовать следующие _режимы работы_ как по отдельности, так и оба одновременно:

* **Режим 1**: {{ ui-key.yacloud_org.form.oslogin-settings.title_ssh-certificate-settings }}.
    Режим позволяет подключаться к ВМ по SSH-сертификату [через {{ yandex-cloud }} CLI](../../compute/operations/vm-connect/os-login.md#connect-with-yc-cli) и [через стандартный SSH-клиент](../../compute/operations/vm-connect/os-login.md#connect-with-ssh-client).

* **Режим 2**: {{ ui-key.yacloud_org.form.oslogin-settings.title_user-ssh-key-settings }}.
    Режим позволяет подключаться к ВМ через {{ yandex-cloud }} CLI и через стандартный SSH-клиент по SSH-ключу, сохраненному в [профиле {{ oslogin }}](../concepts/os-login.md#os-login-profiles) пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

### Профили {{ oslogin }} пользователей и сервисных аккаунтов {#os-login-profiles}

_Профиль {{ oslogin }}_ определяет параметры, которые будут использоваться при создании учетной записи пользователя внутри ВМ.

При [включении](../operations/os-login-access.md) в организации доступа по {{ oslogin }} для всех пользовательских и сервисных аккаунтов этой организации автоматически создаются _профили {{ oslogin }} по умолчанию_.
  
Имя пользователя (логин), назначаемое аккаунту в профиле {{ oslogin }} по умолчанию, зависит от типа аккаунта:
* логин пользовательского аккаунта формируется на основе имени этого пользователя в организации: любые символы, кроме букв латинского алфавита, цифр, дефиса и подчеркивания, а также дефис в начале имени — игнорируются, заглавные буквы латинского алфавита преобразуются в строчные.
* логин сервисного аккаунта формируется добавлением префикса `yc-sa-` к имени сервисного аккаунта. Например: сервисному аккаунту `my-robot` будет по умолчанию присвоен логин `yc-sa-my-robot`.

У одного пользователя или сервисного аккаунта в организации {{ org-name }} может быть несколько профилей {{ oslogin }} — разные профили позволяют подключаться к ВМ от имени разных локальных пользователей ВМ. Подробнее о создании дополнительных профилей {{ oslogin }} см. в инструкции [{#T}](../operations/os-login-profile-create.md).

Управлять профилями {{ oslogin }} пользователей вы можете в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}), а также с помощью [{{ yandex-cloud }} CLI](../../cli/cli-ref/organization-manager/cli-ref/oslogin/index.md) и [API](../api-ref/OsLogin/index.md). Управлять профилями {{ oslogin }} сервисных аккаунтов можно только с помощью {{ yandex-cloud }} CLI или API.

{% include [os-login-profile-tab-access-notice](../../_includes/organization/os-login-profile-tab-access-notice.md) %}

### SSH-ключи пользователей и сервисных аккаунтов {#ssh-keys}

Включив [режим 2](#modes), [администратор организации](../security/index.md#organization-manager-admin) может разрешить использовать публичные SSH-ключи для подключения пользователей и сервисных аккаунтов к ВМ по {{ oslogin }}. При включении данного режима администратор должен будет самостоятельно загрузить публичные SSH-ключи пользователей и сервисных аккаунтов в их [профили {{ oslogin }}](#os-login-profiles).

Администратор организации также может разрешить пользователям самостоятельно управлять своими публичными SSH-ключами, для этого нужно дополнительно [включить](../operations/os-login-access.md) опцию **{{ ui-key.yacloud_org.form.oslogin-settings.title_allow-edit-own-keys }}** в настройках безопасности организации.

### Необходимые условия для использования {{ oslogin }} {#pre-conditions}

{% note info %}

{{ oslogin }} работает только с виртуальными машинами на базе ОС Linux. ВМ с другими типами операционных систем, в том числе с ОС Windows, не поддерживаются.

{% endnote %}

Чтобы начать [подключаться](#os-login-connection) к ВМ по {{ oslogin }}, необходимо:

* [Включить доступ к ВМ через {{ oslogin }}](../operations/os-login-access.md) на уровне организации.
* [Развернуть ВМ](../../compute/operations/vm-connect/os-login-create-vm.md) из [образа]({{ link-cloud-marketplace }}?search=oslogin) с интегрированным [агентом {{ oslogin }}](#agent).
    Если ВМ создана из образа без интегрированного агента {{ oslogin }}, вы можете самостоятельно [установить агента](../../compute/operations/vm-connect/enable-os-login.md#enable-os-login).
* При создании ВМ в консоли управления в блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.field_os-login-access-method }}**. Если этот вариант неактивен, значит выбранный образ не поддерживает доступ по {{ oslogin }}.

{% note info %}

{% include [serial-port-settings-default](../../_includes/compute/serial-port-settings-default.md) %}

{% endnote %}

## Подключение по {{ oslogin }} {#os-login-connection}

Подключиться к виртуальной машине с включенным доступом по {{ oslogin }} можно как с помощью стандартного SSH-клиента, так и с помощью [{{ yandex-cloud }} CLI](../../cli/quickstart.md).

### Подключение с помощью стандартного SSH-клиента {#connect-with-ssh-client}

Пользователи, а также (с помощью сервисных аккаунтов) сторонние инструменты, такие как [{{ TF }}](https://www.terraform.io/) или [Ansible](https://www.ansible.com/), могут использовать стандартный SSH-клиент, чтобы [подключаться](../../compute/operations/vm-connect/os-login.md#connect-with-ssh-client) к ВМ с включенным доступом по {{ oslogin }} с помощью короткоживущего SSH-сертификата или SSH-ключа, [сохраненного](../../organization/operations/add-ssh.md) в профиле {{ oslogin }} пользователя или сервисного аккаунта.

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

### Подключение с помощью {{ yandex-cloud }} CLI {#connect-with-yc-cli}

Подключиться к виртуальной машине с включенным доступом по {{ oslogin }} с помощью {{ yandex-cloud }} CLI можно как по SSH-ключу, [сохраненному](../../organization/operations/add-ssh.md) в профиле {{ oslogin }} пользователя или сервисного аккаунта, так и по SSH-сертификату этого пользователя или сервисного аккаунта.

Подробнее о подключении к ВМ по {{ oslogin }} см. в инструкциях [{#T}](../../compute/operations/vm-connect/os-login.md#connect-with-yc-cli) и [Подключиться к узлу {{ k8s }} по {{ oslogin }}](../../managed-kubernetes/operations/node-connect-oslogin.md#connect-via-cli).

### Необходимые роли для подключения к ВМ по {{ oslogin }} {#necessary-roles}

{% include [os-login-roles-needed-for-vm-access](../../_includes/organization/os-login-roles-needed-for-vm-access.md) %}

{% note alert %}

{% include [sudo-and-oslogin](../../_includes/compute/sudo-and-oslogin.md) %}

{% endnote %}

## Примеры использования {#examples}

* [{#T}](../tutorials/sa-oslogin-ansible.md)
* [{#T}](../../tutorials/security/user-group-access-control.md)

#### См. также {#see-also}

* [{#T}](../operations/os-login-access.md)
* [{#T}](../operations/os-login-profile-create.md)
* [Использовать сервисный аккаунт с профилем {{ oslogin }} для управления ВМ с помощью Ansible](../tutorials/sa-oslogin-ansible.md)
