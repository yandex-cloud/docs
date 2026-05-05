Чтобы подключиться к виртуальной машине или узлу {{ k8s }} с включенным доступом по {{ oslogin }} пользователю или [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), от имени которого выполняется подключение, должны быть назначены роли:

* [роль](../../compute/security/index.md#compute-oslogin) `compute.osLogin` или `compute.osAdminLogin`.
* [роль](../../resource-manager/security/index.md#resource-manager-auditor) `resource-manager.auditor` и выше на каталог, в котором размещена виртуальная машина или узел {{ k8s }}.
* [роль](../../compute/security/index.md#compute-operator) `compute.operator` для подключении с помощью {{ yandex-cloud }} CLI.