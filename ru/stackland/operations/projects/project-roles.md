# Настроить роли проекта

Роли проекта позволяют управлять доступом пользователей и групп ко всем пространствам имен внутри проекта. Роль, назначенная на уровне проекта, автоматически применяется ко всем вложенным пространствам имен.

## Перед началом работы {#before-you-begin}

Убедитесь, что:

* У вас есть роль администратора проекта или администратора кластера.
* Проект уже создан. Если нет, [создайте проект](create-project.md).

## Специальные роли {#special-roles}

В {{ stackland-name }} есть две специальные роли для управления проектами:

* `stackland:admin` — роль администратора проекта. Дает полный доступ ко всем ресурсам проекта, включая управление пространствами имен и ролями.
* `stackland:project-member` — роль участника проекта. Дает возможность видеть проект и его пространства имен в консоли управления и инструментах.

## Назначить администратора проекта {#assign-admin}

Администратор кластера назначает администраторов проекта с помощью ресурса `ProjectRoleBinding`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В левом меню выберите **Проекты**.
  1. Выберите нужный проект из списка.
  1. На боковой панели проекта нажмите **Управление доступом**.
  1. На вкладке **Участники** нажмите **+ Добавить участника**.
  1. В диалоге **Добавить участника** укажите:

      * **Субъект** — выберите пользователя или группу из выпадающего списка.
      * **Роль** — выберите **Администратор**.

  1. Нажмите **Добавить**.


- CLI {#cli}

  Создайте ресурс `ProjectRoleBinding` в служебном пространстве имен проекта:

  ```yaml
  apiVersion: stackland.yandex.cloud/v1alpha1
  kind: ProjectRoleBinding
  metadata:
    name: stackland-projects-team-alpha-admins
    namespace: project-team-alpha
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: stackland:admin
  subjects:
    - kind: User
      name: alice@stackland
    - kind: Group
      name: team-alpha-admins
  ```

  Где:

  * `metadata.name` — имя привязки роли. Должно начинаться с префикса `stackland-projects-`. Обязательное поле.
  * `metadata.namespace` — служебное пространство имен проекта в формате `project-<имя_проекта>`. Обязательное поле.
  * `roleRef.name` — имя роли. Для администратора проекта укажите `stackland:admin`. Обязательное поле.
  * `subjects` — список субъектов, которым назначается роль. Поддерживаются типы `User`, `Group`, `ServiceAccount`. Обязательное поле.

  Примените манифест:

  ```bash
  kubectl apply -f project-role-binding.yaml
  ```

{% endlist %}

Администратор проекта получает:

* полный доступ ко всем пространствам имен проекта;
* возможность создавать и удалять пространства имен;
* возможность назначать роли другим пользователям в рамках проекта.

## Добавить участника проекта {#assign-member}

Участник проекта видит проект и его пространства имен в интерфейсе и инструментах. Для выполнения действий с ресурсами участнику необходимо дополнительно назначить роль с нужными правами.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В левом меню выберите **Проекты**.
  1. Выберите нужный проект из списка.
  1. На боковой панели проекта нажмите **Управление доступом**.
  1. На вкладке **Участники** нажмите **+ Добавить участника**.
  1. В диалоге **Добавить участника** укажите:

      * **Субъект** — выберите пользователя или группу из выпадающего списка.
      * **Роль** — выберите **Участник**.

  1. Нажмите **Добавить**.


- CLI {#cli}

  ```yaml
  apiVersion: stackland.yandex.cloud/v1alpha1
  kind: ProjectRoleBinding
  metadata:
    name: stackland-projects-team-alpha-members
    namespace: project-team-alpha
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: stackland:project-member
  subjects:
    - kind: User
      name: bob@stackland
    - kind: Group
      name: team-alpha-members
  ```

{% endlist %}

## Назначить роль во всех пространствах имен проекта {#assign-project-wide-role}

Администратор проекта может назначить существующую `ClusterRole` во всех пространствах имен проекта:

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: ProjectRoleBinding
metadata:
  name: stackland-projects-kafka-admins
  namespace: project-team-alpha
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: stackland:editor
subjects:
  - kind: Group
    name: team-alpha-developers
```

{{ stackland-name }} автоматически создаст `RoleBinding` в каждом пространстве имен проекта.

## Создать кастомную роль проекта {#create-custom-role}

Администратор проекта может создать кастомную роль, которая будет доступна во всех пространствах имен проекта.

1. Создайте ресурс `ProjectRole`:

    ```yaml
    apiVersion: stackland.yandex.cloud/v1alpha1
    kind: ProjectRole
    metadata:
      name: stackland-projects-pg-admin
      namespace: project-team-alpha
    rules:
      - apiGroups:
          - postgresql.stackland.yandex.cloud
        resources:
          - postgresqlclusters
        verbs:
          - create
          - delete
          - patch
          - update
          - get
          - list
    ```

    Где:

    * `metadata.name` — имя роли. Должно начинаться с префикса `stackland-projects-`. Обязательное поле.
    * `metadata.namespace` — служебное пространство имен проекта. Обязательное поле.
    * `rules` — список правил доступа в формате Kubernetes RBAC. Обязательное поле.

1. Назначьте роль с помощью `ProjectRoleBinding`:

    ```yaml
    apiVersion: stackland.yandex.cloud/v1alpha1
    kind: ProjectRoleBinding
    metadata:
      name: stackland-projects-pg-admins
      namespace: project-team-alpha
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: ProjectRole
      name: stackland-projects-pg-admin
    subjects:
      - kind: Group
        name: team-alpha-pg-admins
    ```

{{ stackland-name }} автоматически создаст соответствующие `Role` и `RoleBinding` в каждом пространстве имен проекта.

## Просмотреть назначенные роли {#list-roles}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В левом меню выберите **Проекты**.
  1. Выберите нужный проект из списка.
  1. На боковой панели проекта нажмите **Управление доступом**.

  На странице доступны три вкладки:

  * **Участники** — список пользователей и групп с ролями **Участник** или **Администратор**.
  * **Роли проекта** — список кастомных ролей проекта.
  * **Привязки ролей проекта** — таблица привязок с колонками **Имя**, **Роль**, **Субъекты**, **Дата создания**.


- CLI {#cli}

  Чтобы получить список привязок ролей проекта:

  ```bash
  kubectl get projectrolebindings -n project-team-alpha
  ```

  Чтобы получить список кастомных ролей проекта:

  ```bash
  kubectl get projectroles -n project-team-alpha
  ```

{% endlist %}

## Отозвать роль {#revoke-role}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В левом меню выберите **Проекты**.
  1. Выберите нужный проект из списка.
  1. На боковой панели проекта нажмите **Управление доступом**.
  1. На вкладке **Участники** найдите нужного участника.
  1. В строке участника нажмите значок **⋯** и выберите **Удалить**.
  1. Подтвердите удаление.


- CLI {#cli}

  Удалите соответствующий ресурс `ProjectRoleBinding`:

  ```bash
  kubectl delete projectrolebinding stackland-projects-kafka-admins -n project-team-alpha
  ```

{% endlist %}

## Что дальше {#what-is-next}

* [Установить квоты проекта](namespace-quotas.md)
* [Управлять пространствами имен в проекте](manage-namespaces.md)
