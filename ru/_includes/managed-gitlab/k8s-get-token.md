### Получите токен сервисного аккаунта {{ k8s }} для аутентификации в {{ GL }} {#k8s-get-token}

{% note info %}

[Сервисный аккаунт {{ k8s }}](../../managed-kubernetes/concepts/index.md#service-accounts) отличается от [сервисного аккаунта {{ iam-full-name }}](../../iam/concepts/users/service-accounts.md).

{% endnote %}

Чтобы получить токен сервисного аккаунта {{ k8s }}:
1. [Создайте сервисный аккаунт](../../managed-kubernetes/operations/connect/create-static-conf.md#create-sa).
1. [Получите токен сервисного аккаунта](../../managed-kubernetes/operations/connect/create-static-conf.md#prepare-token).
1. Сохраните полученный токен — он понадобится для следующих шагов.