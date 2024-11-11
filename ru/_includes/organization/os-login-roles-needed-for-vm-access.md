{% list tabs %}

- Подключение через YC CLI

  Для подключения через [YC CLI](../../cli/quickstart.md) к виртуальной машине или узлу {{ k8s }} с включенным доступом по {{ oslogin }} пользователю или [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), от имени которого выполняется команда YC CLI, должна быть назначена роль `compute.osLogin` или `compute.osAdminLogin`, а также роль `compute.operator`.

- Подключение через стандартный SSH-клиент

  Для подключения через стандартный SSH-клиент к виртуальной машине или узлу {{ k8s }} с включенным доступом по {{ oslogin }} пользователю или [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), от имени которого выполняется подключение, должна быть назначена роль `compute.osLogin` или `compute.osAdminLogin`.

{% endlist %}