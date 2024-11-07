# {{ oslogin }}

{{ oslogin }} — это удобный способ управления подключениями к [виртуальным машинам](../../compute/concepts/vm.md) и узлам [кластеров](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) {{ managed-k8s-full-name }} по SSH через [YC CLI](../../cli/quickstart.md) или через стандартный SSH-клиент c SSH-сертификатом или с SSH-ключом, предварительно добавленным в профиль пользователя организации или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) в {{ org-full-name }}.

Агент {{ oslogin }} разработан на основе [Guest Agent for Google Compute Engine](https://github.com/GoogleCloudPlatform/guest-agent). Изменения, внесенные командой {{ yandex-cloud }}, можно отслеживать в репозитории на [GitHub](https://github.com/yandex-cloud/yandex-cloud-guest-agent).

{{ oslogin }} связывает учетную запись пользователя виртуальной машины или узла {{ k8s }} с учетной записью пользователя организации. Для управления доступом к виртуальным машинам и узлам [включите на уровне организации опцию](../operations/os-login-access.md), разрешающую доступ по {{ oslogin }}, а затем [активируйте](../../compute/operations/vm-control/vm-update.md#enable-oslogin-access) доступ по {{ oslogin }} отдельно на каждой виртуальной машине или узле {{ k8s }}.

Так можно легко управлять доступом к виртуальным машинам и узлам {{ k8s }}, назначая пользователю необходимые роли. Если у пользователя отозвать роли, он потеряет доступ ко всем виртуальным машинам и узлам {{ k8s }}, для которых включен доступ по {{ oslogin }}.

## Профили {{ oslogin }} {#os-login-profiles}

Для каждого пользователя и сервисного аккаунта в организации можно создавать профили {{ oslogin }}, содержащие имя (логин) и идентификатор (UID) пользователя или сервисного аккаунта, которые будут использоваться для идентификации этого пользователя или сервисного аккаунта в операционных системах виртуальных машин и узлов кластеров {{ k8s }}.

Профили {{ oslogin }} по умолчанию создаются для всех пользователей организации при [включении доступа по {{ oslogin }}](../operations/os-login-access.md). При необходимости вы можете [создать](../operations/os-login-profile-create.md) дополнительные профили или редактировать существующие.

Управлять профилями {{ oslogin }} пользователей вы можете в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}), а также с помощью [{{ yandex-cloud }} CLI](../../cli/cli-ref/managed-services/organization-manager/oslogin/index.md) и [API](../api-ref/OsLogin/index.md). Управлять профилями {{ oslogin }} сервисных аккаунтов можно только с помощью CLI или API.

{% include [os-login-profile-tab-access-notice](../../_includes/organization/os-login-profile-tab-access-notice.md) %}

## Подключение по {{ oslogin }} {#os-login-connection}

Пользователи или сторонние инструменты, такие как [{{ TF }}](https://www.terraform.io/) или [Ansible](https://www.ansible.com/), могут использовать стандартный SSH-клиент, чтобы [подключаться](../../compute/operations/vm-connect/os-login.md#connect-with-ssh-client) к ВМ и узлам {{ k8s }} с включенным доступом по {{ oslogin }} с помощью SSH-сертификатов или SSH-ключей.

Чтобы подключиться через стандартный SSH-клиент с использованием SSH-сертификата к ВМ или узлу {{ k8s }} с включенным доступом по {{ oslogin }}, нужно [экспортировать](../../compute/operations/vm-connect/os-login-export-certificate.md) сертификат {{ oslogin }} и использовать его при подключении. Сертификат действителен один час. По истечении этого времени для подключения к ВМ или узлу {{ k8s }} необходимо экспортировать новый сертификат.

Чтобы [подключиться](../../compute/operations/vm-connect/os-login.md) к ВМ или узлу {{ k8s }} с включенным доступом по {{ oslogin }} через YC CLI или через стандартный SSH-клиент с SSH-ключом, нужно [создать пару SSH-ключей](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) и [добавить](../../organization/operations/add-ssh.md) публичный SSH-ключ в профиль пользователя организации {{ org-name }}. Вы также можете добавить SSH-ключ в профиль [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), чтобы иметь возможность [подключаться](../tutorials/sa-oslogin-ansible.md) к ВМ по {{ oslogin }} от имени этого сервисного аккаунта.

{% note info %}

Необходимые роли для подключения к ВМ по {{ oslogin }}:

{% include [os-login-roles-needed-for-vm-access](../../_includes/organization/os-login-roles-needed-for-vm-access.md) %}

{% endnote %}

Преимущества {{ oslogin }}:

* моментальное обновление прав доступа в случае отзыва или назначения ролей;
* возможность доступа по короткоживущим SSH-сертификатам;
* возможность доступа по SSH-ключам;
* возможность восстановления доступа к ВМ и узлам кластеров {{ k8s }} в случае утери SSH-ключей (если используются обычные SSH-ключи, а не {{ oslogin }});
* возможность загрузки пользователем собственных SSH-ключей в свой профиль.

#### Что дальше {#what-is-next}

* [{#T}](../operations/os-login-access.md)
* [{#T}](../operations/os-login-profile-create.md)
* [{#T}](../../compute/operations/vm-connect/os-login.md)
* [Подключиться к узлу {{ k8s }} через {{ oslogin }}](../../managed-kubernetes/operations/node-connect-oslogin.md)
* [Использовать сервисный аккаунт с профилем {{ oslogin }} для управления ВМ с помощью Ansible](../tutorials/sa-oslogin-ansible.md)