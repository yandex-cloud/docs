# Назначить права доступа

Вы можете назначить роли пользователям, группам и сервисным аккаунтам. Права доступа назначаются на двух уровнях:

* На уровне кластера — с помощью ресурса `ClusterAccessBinding`. Роль действует на всю организацию.
* На уровне проекта — с помощью ресурса `AccessBinding`. Роль действует в рамках конкретного пространства имен.

{% note info %}

Для назначения прав доступа на уровне кластера необходимы права администратора организации.

{% endnote %}

## Назначить роль на уровне кластера {#cluster-level}

Используйте ресурс `ClusterAccessBinding` для назначения ролей на уровне организации.

### Назначить роль пользователю {#assign-to-user}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В консоли управления перейдите в раздел **Управление доступом**.
  1. На странице **Права доступа** нажмите **Назначить роль**.
  1. В поле **Субъект** выберите **Пользователь**.
  1. Выберите пользователя из списка.
  1. В поле **Роль** выберите нужную роль.
  1. Нажмите **Сохранить**.

- CLI {#cli}

  1. Создайте файл `user-role-binding.yaml`:

      ```yaml
      apiVersion: iam.stackland.yandex.cloud/v1alpha1
      kind: ClusterAccessBinding
      metadata:
        name: user-admin-role
      spec:
        roleID: admin
        subject:
          kind: User
          name: username
      ```

      Где:

      * `metadata.name` — уникальное имя привязки роли.
      * `roleID` — идентификатор роли (например, `admin`, `editor`, `viewer`).
      * `kind` — тип субъекта. Для пользователя укажите `User`.
      * `name` — имя пользователя (`username` для локальных пользователей или `name_id` для пользователей из SAML-федерации).

  1. Примените конфигурацию:

      ```bash
      kubectl apply -f user-role-binding.yaml
      ```

  1. Проверьте созданную привязку:

      ```bash
      kubectl get clusteraccessbinding user-admin-role
      ```

{% endlist %}

### Назначить роль группе {#assign-to-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В консоли управления перейдите в раздел **Управление доступом**.
  1. На странице **Права доступа** нажмите **Назначить роль**.
  1. В поле **Субъект** выберите **Группа**.
  1. Выберите группу из списка.
  1. В поле **Роль** выберите нужную роль.
  1. Нажмите **Сохранить**.

- CLI {#cli}

  1. Создайте файл `group-role-binding.yaml`:

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

      * `metadata.name` — уникальное имя привязки роли.
      * `roleID` — идентификатор роли.
      * `kind` — тип субъекта. Для группы укажите `Group`.
      * `name` — имя группы.

  1. Примените конфигурацию:

      ```bash
      kubectl apply -f group-role-binding.yaml
      ```

  1. Проверьте созданную привязку:

      ```bash
      kubectl get clusteraccessbinding stackland-cluster-admins
      ```

{% endlist %}

## Назначить роль на уровне проекта {#project-level}

Используйте ресурс `AccessBinding` для назначения ролей в рамках конкретного пространства имен.

### Назначить роль пользователю в проекте {#assign-to-user-project}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Создайте файл `user-project-role-binding.yaml`:

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

      Где:

      * `metadata.name` — уникальное имя привязки роли.
      * `metadata.namespace` — пространство имен, в котором назначается роль.
      * `roleID` — идентификатор роли.
      * `kind` — тип субъекта. Для пользователя укажите `User`.
      * `name` — имя пользователя.

  1. Примените конфигурацию:

      ```bash
      kubectl apply -f user-project-role-binding.yaml
      ```

  1. Проверьте созданную привязку:

      ```bash
      kubectl get accessbinding bob-is-storage-admin -n warehouse
      ```

{% endlist %}

### Назначить роль сервисному аккаунту в проекте {#assign-to-sa}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Создайте файл `sa-role-binding.yaml`:

      ```yaml
      apiVersion: iam.stackland.yandex.cloud/v1alpha1
      kind: AccessBinding
      metadata:
        namespace: warehouse
        name: app-sa-is-storage-viewer
      spec:
        roleID: storage.viewer
        subject:
          kind: ServiceAccount
          name: app-sa
          namespace: warehouse
      ```

      Где:

      * `metadata.name` — уникальное имя привязки роли.
      * `metadata.namespace` — пространство имен, в котором назначается роль.
      * `roleID` — идентификатор роли.
      * `kind` — тип субъекта. Для сервисного аккаунта укажите `ServiceAccount`.
      * `name` — имя сервисного аккаунта.
      * `namespace` — пространство имен, в котором создан сервисный аккаунт.

  1. Примените конфигурацию:

      ```bash
      kubectl apply -f sa-role-binding.yaml
      ```

  1. Проверьте созданную привязку:

      ```bash
      kubectl get accessbinding app-sa-is-storage-viewer -n warehouse
      ```

{% endlist %}

## Доступные роли {#available-roles}

Основные роли в системе:

* `admin` — полный доступ ко всем ресурсам организации.
* `editor` — права на создание и изменение ресурсов.
* `viewer` — права только на просмотр ресурсов.

Для получения полного списка доступных ролей обратитесь к разделу [Управление доступом](../../access-management.md).

## Отозвать роль {#revoke-role}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В консоли управления перейдите в раздел **Управление доступом**.
  1. На странице **Права доступа** найдите нужную привязку роли.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
  1. Подтвердите удаление.

- CLI {#cli}

  Для отзыва роли на уровне кластера удалите ресурс `ClusterAccessBinding`:

  ```bash
  kubectl delete clusteraccessbinding <имя_привязки>
  ```

  Для отзыва роли на уровне проекта удалите ресурс `AccessBinding`:

  ```bash
  kubectl delete accessbinding <имя_привязки> -n <namespace>
  ```

{% endlist %}

## Что дальше {#what-is-next}

* [Создайте пользователя](create-user.md)
* [Создайте группу пользователей](create-group.md)
* [Подключите SAML-федерацию](connect-saml-federation.md)
