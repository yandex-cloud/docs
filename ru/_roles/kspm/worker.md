Роль `kspm.worker` позволяет просматривать информацию о [кластерах](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) Managed Service for Kubernetes и устанавливать в них компоненты [модуля KSPM](../../security-deck/concepts/kspm.md).

Роль выдается [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), от имени которого будут выполняться проверки кластера, и назначается на организацию, облако или каталог. Этот сервисный аккаунт указывается при [создании](../../security-deck/operations/workspaces/create.md) окружения.
