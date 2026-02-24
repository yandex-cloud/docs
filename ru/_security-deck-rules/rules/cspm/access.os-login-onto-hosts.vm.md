### Для подключения к виртуальной машине используется OS Login {#vm}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | access.os-login-onto-hosts.vm ||
|#

#### Описание

{% note tip "**Автоматическая проверка**" %}

Данный контроль автоматически проверяет использование OS Login на виртуальных машинах и узлах Kubernetes.

{% endnote %}

[OS Login](https://yandex.cloud/ru/docs/organization/concepts/os-login) — это удобный способ управления подключениями к [виртуальным машинам](https://yandex.cloud/ru/docs/compute/concepts/vm) по SSH через [CLI](https://yandex.cloud/ru/docs/cli/quickstart) или через стандартный SSH-клиент c SSH-сертификатом или SSH-ключом, предварительно добавленным в профиль OS Login пользователя организации или [сервисного аккаунта](https://yandex.cloud/ru/docs/iam/concepts/users/service-accounts) в Yandex Identity Hub.

OS Login связывает учетную запись пользователя виртуальной машины с учетной записью пользователя организации или сервисного аккаунта. Чтобы управлять доступом к виртуальным машинам, на уровне организации [включите](https://yandex.cloud/ru/docs/organization/operations/os-login-access) опцию, разрешающую доступ по OS Login, а затем [активируйте](https://yandex.cloud/ru/docs/compute/operations/vm-connect/enable-os-login) доступ по OS Login отдельно на каждой виртуальной машине.

Так можно легко управлять доступом к виртуальным машинам, назначая пользователю или сервисному аккаунту необходимые роли. Если у пользователя или сервисного аккаунта отозвать роли, он потеряет доступ ко всем виртуальным машинам, для которых включен доступ по OS Login.

#### Инструкции и решения по выполнению

* [Включить доступ по OS Login на уровне организации](https://yandex.cloud/ru/docs/organization/operations/os-login-access)
* [Настроить доступ по OS Login на существующей виртуальной машине](https://yandex.cloud/ru/docs/compute/operations/vm-connect/enable-os-login)
* [Подключиться к виртуальной машине по OS Login](https://yandex.cloud/ru/docs/compute/operations/vm-connect/os-login)