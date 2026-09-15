### Для подключения к виртуальной машине используется OS Login {#vm}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | access.os-login-onto-hosts.vm ||
|#

#### Описание

**Риски при невыполнении правила:** без OS Login доступ к ВМ предоставляется через SSH-ключи, распределяемые вручную и не привязанные к IAM-идентификаторам. При увольнении сотрудника или компрометации ключа нет централизованного способа отозвать доступ — ключ нужно вручную удалять с каждой ВМ. Неуправляемые SSH-ключи могут существовать бесконечно долго, предоставляя бывшим сотрудникам или злоумышленникам постоянный доступ к виртуальным машинам.

[OS Login](https://yandex.cloud/ru/docs/organization/concepts/os-login) — это удобный способ управления подключениями к [виртуальным машинам](https://yandex.cloud/ru/docs/compute/concepts/vm) по SSH через [CLI](https://yandex.cloud/ru/docs/cli/quickstart) или через стандартный SSH-клиент c SSH-сертификатом или SSH-ключом, предварительно добавленным в профиль OS Login пользователя организации или [сервисного аккаунта](https://yandex.cloud/ru/docs/iam/concepts/users/service-accounts) в Yandex Identity Hub.

OS Login связывает учетную запись пользователя виртуальной машины с учетной записью пользователя организации или сервисного аккаунта. Чтобы управлять доступом к виртуальным машинам, на уровне организации [включите](https://yandex.cloud/ru/docs/organization/operations/os-login-access) опцию, разрешающую доступ по OS Login, а затем [активируйте](https://yandex.cloud/ru/docs/compute/operations/vm-connect/enable-os-login) доступ по OS Login отдельно на каждой виртуальной машине.

Так можно легко управлять доступом к виртуальным машинам, назначая пользователю или сервисному аккаунту необходимые роли. Если у пользователя или сервисного аккаунта отозвать роли, он потеряет доступ ко всем виртуальным машинам, для которых включен доступ по OS Login.

#### Инструкции и решения по выполнению

* [Включите доступ по OS Login](https://yandex.cloud/ru/docs/organization/operations/os-login-access) на уровне организации.
* [Настройте доступ по OS Login](https://yandex.cloud/ru/docs/compute/operations/vm-connect/enable-os-login) на существующей виртуальной машине.
* [Подключитесь к виртуальной машине ](https://yandex.cloud/ru/docs/compute/operations/vm-connect/os-login)по OS Login.
