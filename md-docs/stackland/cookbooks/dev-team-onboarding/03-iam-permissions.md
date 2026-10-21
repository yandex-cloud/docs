[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Сборник рецептов администратора Stackland](../index.md) > Запуск команды разработки в инсталляцию > Настройка прав в IAM

# Настройка прав в IAM

Этот рецепт поможет вам настроить права доступа для команды разработки в проекте `team-alpha`. Вы узнаете, как создавать локальных пользователей и группы и назначать им права.

Как создать проект `team-alpha`, показано в рецепте [Подготовка проекта и пространств имен команды](02-project-and-namespaces.md).

В этом рецепте вы:

* создадите трех локальных пользователей: `alice`, `bob` и `andy`;

* создадите группы `developers-team-alpha` и `project-admins-team-alpha` и добавите в них пользователей;

* создадите сервисные аккаунты `ci-runner` для CI/CD и `sa-s3-access` для получения доступа к S3 API разработчиком;

* назначите пользователям, группам и сервисному аккаунту необходимые права.

Прежде чем перейти к созданию ресурсов, кратко напомним о субъектах доступа и возможных уровнях назначения прав.

## Субъекты доступа {#access-subjects}

В IAM Stackland роли можно назначать следующим типам субъектов:

#|
|| **Тип** | **Описание** | **Пример** ||
||
`User`
|
Локальный пользователь IAM
|
`alice@stackland`

`andy@stackland`

`bob@stackland`
||
||
`Group`
|
Группа пользователей
|
`developers-team-alpha`

`project-admins-team-alpha`
||
||
`ServiceAccount`
|
Сервисный аккаунт для автоматизации
|
`ci-runner`

`sa-s3-access`
||
|| `FederatedUser` | Пользователь из внешнего IdP (SAML) | `sso:alice` (в этом рецепте отсутствует) ||
|#

## Схема привязок для пользователей и групп {#bindings-scheme}

В таблице ниже показаны типы привязок и область их действия, которые используются для того, чтобы назначать каждому пользователю соответствующие права.

#|
|| **Пользователь** | **Роль в команде** | **Тип привязки** | **Область** | **Роль в системе** ||
|| `andy@stackland` | Администратор кластера | `ClusterAccessBinding` (IAM) | Кластер | `admin` ||
|| `andy@stackland` | Администратор кластера | `ClusterRoleBinding` (RBAC) | Кластер | `stackland:admin` ||
|| `alice@stackland` | Администратор проекта | `ProjectAccessBinding` (IAM) | `project-team-alpha` (проект) | `admin` ||
|| `alice@stackland` | Администратор проекта | `ProjectRoleBinding` (RBAC) | `project-team-alpha` (проект) | `stackland:admin` ||
|| `bob@stackland` | Разработчик | `ProjectRoleBinding` (RBAC) | `project-team-alpha` (проект) | `stackland:project-member` ||
|| `bob@stackland` | Разработчик | `RoleBinding` (RBAC) | `team-alpha-dev` (пространство имен) | `stackland:editor` ||
|| `ci-runner` | Сервисный аккаунт для CI/CD | `RoleBinding` (RBAC) | `team-alpha-dev` (пространство имен) | `stackland:editor` ||
|| `sa-s3-access` | Сервисный аккаунт для доступа к S3 API | `AccessBinding` (IAM) | `team-alpha-dev` (пространство имен) | `storage.editor` ||
|#

* Пользователь `andy` как администратор кластера имеет полные права на весь кластер.

* Пользователь `alice` как администратор проекта получает `stackland:admin` через `ProjectRoleBinding`. Эта роль дает полный контроль над всеми ресурсами проекта, включая право настраивать IAM-привязки (`AccessBinding`) для других. IAM-роль `admin` на уровне проекта дает ей возможность взаимодействовать с S3 API, управлять данными внутри S3 и платформенными сервисами, такими как Yandex SpeechSense и Yandex AI Studio.

* Пользователь `bob` как разработчик получает `stackland:editor` через `RoleBinding` только в своем рабочем пространстве имен `team-alpha-dev` для деплоя и управления рабочими нагрузками. Чтобы он мог видеть проект и принадлежащие ему пространства имен в консоли управления, ему отдельно выдается роль `stackland:project-member`.

* Сервисный аккаунт `ci-runner` получает роль `stackland:editor` в пространстве имен `team-alpha-dev`, чтобы иметь возможность разворачивать приложение из CI/CD.

* Сервисный аккаунт `sa-s3-access` получает роль `storage.editor` посредством `AccessBinding` в пространстве имен `team-alpha-dev`, чтобы разработчик мог получить статический ключ доступа (`APIKey`) от этого сервисного аккаунта для доступа к бакетам в своем пространстве имен `team-alpha-dev` с помощью S3 API.

## Создание пользователей и групп {#create-users-and-groups}

{% note warning %}

Локальные пользователи и группы создаются через консоль управления. С помощью CLI можно только назначить роль уже существующему пользователю или группе.

{% endnote %}

### Шаг 1. Создайте пользователей {#create-users}

1. В консоли управления перейдите в раздел **Пользователи и группы**.

1. На вкладке **Пользователи** нажмите **Создать пользователя**.

1. Укажите имя пользователя: `alice`. Суффикс `@stackland` добавляется автоматически.

1. Укажите полное имя.

1. Задайте временный пароль или оставьте автоматически сгенерированный.

1. Нажмите **Создать**.

{% note info %}

При первом входе пользователю потребуется изменить временный пароль.

{% endnote %}

Повторите шаги для пользователей `bob` и `andy`.

### Шаг 2. Создайте группу `developers-team-alpha` {#create-group}

1. В консоли управления перейдите в раздел **Пользователи и группы**.

1. На вкладке **Группы** нажмите **Создать группу**.

1. Укажите название группы: `developers-team-alpha`.

1. Добавьте описание (необязательно).

1. Нажмите **Создать**.

Повторите шаги для группы `project-admins-team-alpha`.

### Шаг 3. Добавьте пользователей в группу {#add-users-to-group}

{% note warning %}

Управление членством в группах доступно только через консоль управления.

{% endnote %}

Добавьте пользователей в группы в соответствии с их ролями: `alice` — в группу `project-admins-team-alpha`, `bob` — в группу `developers-team-alpha`:

1. В консоли управления перейдите в раздел **Пользователи и группы**.

1. На вкладке **Группы** выберите нужную группу.

1. Перейдите на вкладку **Участники группы**.

1. Нажмите **Добавить участника**.

1. Выберите пользователя.

1. Нажмите **Добавить**.

## Назначение прав {#assign-permissions}

Теперь назначьте пользователям права согласно спроектированной модели. Все привязки вы будете создавать через CLI с помощью YAML-манифестов.

{% note tip %}

Права кластерного администратора также можно выдать. Для этого добавьте пользователя в преднастроенную группу `stackland-cluster-admins`.

{% endnote %}

### Назначение прав администратору кластера (`andy`) {#cluster-admin-permissions}

**Шаг 1. RBAC-роль `stackland:admin` на уровне кластера**

Создайте файл `andy-cluster-admin-rbac.yaml`:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: andy-cluster-admin-rbac
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: stackland:admin
subjects:
- kind: User
  name: andy@stackland
```

Примените манифест:

```bash
kubectl apply -f andy-cluster-admin-rbac.yaml
```

**Шаг 2. IAM-роль `admin` на уровне кластера**

Создайте файл `andy-cluster-admin-iam.yaml`:

```yaml
apiVersion: iam.stackland.yandex.cloud/v1alpha1
kind: ClusterAccessBinding
metadata:
  name: andy-cluster-admin-iam
spec:
  roleID: admin
  subject:
    kind: User
    name: andy@stackland
```

Примените манифест:

```bash
kubectl apply -f andy-cluster-admin-iam.yaml
```

### Назначение прав администратору проекта (`alice`) {#project-admin-permissions}

**Шаг 1. RBAC-роль `stackland:admin` на уровне проекта для группы `project-admins-team-alpha`**

Создайте файл `alice-project-admin-rbac.yaml`:

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: ProjectRoleBinding
metadata:
  name: stackland-projects-alice-admin
  namespace: project-team-alpha
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: stackland:admin
subjects:
- kind: Group
  name: project-admins-team-alpha
```

Примените манифест:

```bash
kubectl apply -f alice-project-admin-rbac.yaml
```

**Шаг 2. IAM-роль `admin` на уровне проекта для группы `project-admins-team-alpha`**

Создайте файл `alice-project-admin-iam.yaml`:

```yaml
apiVersion: iam.stackland.yandex.cloud/v1alpha1
kind: ProjectAccessBinding
metadata:
  name: alice-project-admin-iam
  namespace: project-team-alpha
spec:
  roleID: admin
  subject:
    kind: Group
    name: project-admins-team-alpha
```

Примените манифест:

```bash
kubectl apply -f alice-project-admin-iam.yaml
```

### Назначение прав разработчику `bob` (группа `developers-team-alpha`) {#developer-permissions}

**Шаг 1. RBAC-роль `stackland:project-member` на уровне проекта**

Создайте файл `developers-project-member.yaml`:

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: ProjectRoleBinding
metadata:
  name: stackland-projects-developers-member
  namespace: project-team-alpha
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: stackland:project-member
subjects:
- kind: Group
  name: developers-team-alpha
```

Примените манифест:

```bash
kubectl apply -f developers-project-member.yaml
```

**Шаг 2. RBAC-роль `stackland:editor` в пространстве имен `team-alpha-dev`**

{% note info %}

Совместно с ролью участника проекта `stackland:project-member` эта роль позволит просматривать рабочие нагрузки в пространстве имен `team-alpha-dev` через консоль управления.

{% endnote %}

Создайте файл `developers-dev-editor.yaml`:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: developers-dev-editor
  namespace: team-alpha-dev
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: stackland:editor
subjects:
- kind: Group
  name: developers-team-alpha
```

Примените манифест:

```bash
kubectl apply -f developers-dev-editor.yaml
```

### Назначение прав сервисному аккаунту `ci-runner` {#ci-runner-permissions}

**Шаг 1. Создайте Kubernetes ServiceAccount**

Создайте файл `ci-runner-sa.yaml`:

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: ci-runner
  namespace: team-alpha-dev
```

Примените манифест:

```bash
kubectl apply -f ci-runner-sa.yaml
```

**Шаг 2. Назначьте RBAC-роль сервисному аккаунту**

Создайте файл `ci-runner-rbac.yaml`:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: ci-runner-editor
  namespace: team-alpha-dev
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: stackland:editor
subjects:
- kind: ServiceAccount
  name: ci-runner
  namespace: team-alpha-dev
```

Примените манифест:

```bash
kubectl apply -f ci-runner-rbac.yaml
```

**Шаг 3. Получите токен для CI/CD**

Создайте секрет с типом `kubernetes.io/service-account-token`. Для этого создайте файл `ci-runner-token.yaml`:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: ci-runner-token
  namespace: team-alpha-dev
  annotations:
    kubernetes.io/service-account.name: ci-runner
type: kubernetes.io/service-account-token
```

Примените манифест:

```bash
kubectl apply -f ci-runner-token.yaml
```

Получите токен:

```bash
kubectl get secret ci-runner-token -n team-alpha-dev -o jsonpath='{.data.token}' | base64 -d
```

Этот токен можно использовать в CI/CD для аутентификации в Kubernetes API.

### Назначение прав сервисному аккаунту `sa-s3-access` {#s3-access-permissions}

Для доступа к S3 API разработчику нужен **сервисный аккаунт** с IAM-ролью `storage.editor` и его **ключи доступа** (Access Key ID и Secret Access Key).

**Шаг 1. Создайте сервисный аккаунт**

Создайте файл `sa-s3-access.yaml`:

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: sa-s3-access
  namespace: team-alpha-dev
```

Примените манифест:

```bash
kubectl apply -f sa-s3-access.yaml
```

**Шаг 2. Назначьте IAM-роль `storage.editor`**

Для доступа к S3 через S3 API для чтения и записи объектов назначьте сервисному аккаунту роль `storage.editor`. Для этого создайте файл `sa-s3-access-binding.yaml`:

```yaml
apiVersion: iam.stackland.yandex.cloud/v1alpha1
kind: AccessBinding
metadata:
  name: sa-s3-access-binding
  namespace: team-alpha-dev
spec:
  roleID: storage.editor
  subject:
    kind: ServiceAccount
    name: sa-s3-access
    namespace: team-alpha-dev
```

Примените манифест:

```bash
kubectl apply -f sa-s3-access-binding.yaml
```

**Шаг 3. Создайте ключи доступа для сервисного аккаунта**

Для работы с S3 создайте статический ключ доступа (`AccessKey`). Для этого создайте файл `sa-s3-access-key.yaml`:

```yaml
apiVersion: iam.stackland.yandex.cloud/v1alpha1
kind: AccessKey
metadata:
  name: sa-s3-access-key
  namespace: team-alpha-dev
spec:
  serviceAccountRef: sa-s3-access
  description: "Access key for S3 storage"
```

Примените манифест:

```bash
kubectl apply -f sa-s3-access-key.yaml
```

**Шаг 4. Получите ключи доступа**

Получите имя созданного секрета с помощью команды:

```bash
kubectl get accesskeys sa-s3-access-key -n team-alpha-dev -o yaml | grep secretName
```

```plaintext
secretName: stackland-accesskey-sa-s3-access-key
```

Извлеките Access Key ID и Secret Access Key из созданного секрета:

```bash
export AWS_ACCESS_KEY_ID=$(kubectl get secret stackland-accesskey-sa-s3-access-key -n team-alpha-dev -o jsonpath='{.data.access-key-id}' | base64 -d)
export AWS_SECRET_ACCESS_KEY=$(kubectl get secret stackland-accesskey-sa-s3-access-key -n team-alpha-dev -o jsonpath='{.data.access-key-secret}' | base64 -d)
```

Выведите ключи:

```bash
echo "Access Key ID: $AWS_ACCESS_KEY_ID"; \
echo "Secret Access Key: $AWS_SECRET_ACCESS_KEY"
```

**Шаг 5. Создайте тестовый S3-бакет**

Для проверки доступа используйте S3-бакет. Для этого создайте файл `bucket.yaml`:

```yaml
apiVersion: storage.stackland.yandex.cloud/v1alpha1
kind: Bucket
metadata:
  name: bucket-private
  namespace: team-alpha-dev
spec:
  anonymousAccessFlags:
    configRead: true
    list: true
    read: true
```

Примените манифест:

```bash
kubectl apply -f bucket.yaml
```

**Шаг 6. Проверьте доступ к S3**

Для проверки подключения к Object Storage получите список файлов в бакете, предварительно загрузив туда тестовый файл. Для этого выполните следующие команды:

```bash
# Получение имени домена кластера
export CLUSTER_DOMAIN=$(kubectl get platformenvironments main -o jsonpath='{.status.clusterDomain}')
```

```bash
# Загрузка файла в бакет
aws --endpoint-url=https://storage.sys.$CLUSTER_DOMAIN s3 cp bucket.yaml s3://bucket-private --no-verify-ssl
```

```bash
# Получение списка файлов в бакете
aws --endpoint-url=https://storage.sys.$CLUSTER_DOMAIN s3 ls s3://bucket-private --no-verify-ssl
```

## Итоги {#summary}

Вы успешно настроили права доступа для команды разработки в проекте `team-alpha`. Что важно запомнить:

* Создавать локальных пользователей и группы, а также управлять членством в группах можно только через консоль управления.

* Необходимо отдельно настраивать RBAC-привязки и IAM-привязки.

* Чтобы разработчик мог работать с объектным хранилищем через S3-совместимый интерфейс, он должен использовать ключ доступа от сервисного аккаунта, которому явно назначена необходимая IAM-роль.