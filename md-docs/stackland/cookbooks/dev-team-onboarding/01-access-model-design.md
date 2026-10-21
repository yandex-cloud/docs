[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Сборник рецептов администратора Stackland](../index.md) > Запуск команды разработки в инсталляцию > Проектирование модели доступов

# Проектирование модели доступов

В этом рецепте вы разберетесь, как устроен IAM платформы, как он связан с Kubernetes RBAC, и составите матрицу доступов для команды разработки.

{% note info %}

Спроектированная модель будет реализована в следующих рецептах.

{% endnote %}

## Авторизация в Stackland {#authorization}

В Stackland за авторизацию действий отвечают две системы, которые работают параллельно: Kubernetes RBAC и IAM AccessBinding.

* Kubernetes RBAC авторизует операции над ресурсами Kubernetes.

* IAM AccessBinding отвечает за пользователей и группы, а также за обращения к API сервисов: S3, SpeechSense, DataLens и т. д.

### Kubernetes RBAC {#rbac}

Kubernetes RBAC авторизует все операции над любыми ресурсами Kubernetes — и над встроенными, и над Custom Resources (CR), через которые управляют сервисами Stackland. Права выдаются как через стандартные `Role`, `RoleBinding` и `ClusterRole`, `ClusterRoleBinding`, так и через дополнительные ресурсы Stackland для управления доступом на уровне проекта — `ProjectRole`, `ProjectRoleBinding`.

#### Когда использовать Kubernetes RBAC {#when-to-use-rbac}

Kubernetes RBAC — основной инструмент для управления инфраструктурой и конфигурацией. Через него настраивают доступ к таким ресурсам:

* Встроенные ресурсы Kubernetes: Pod, Deployment, Service, Ingress, Secret, ConfigMap, PersistentVolumeClaim и другие.

* Ресурсы управляемых (платформенных) сервисов. Через RBAC создают, изменяют и удаляют и сами сервисы, и относящиеся к ним ресурсы:

    * `PostgreSQLCluster`, `ClickHouseCluster`, `KafkaCluster`.

    * `KafkaTopic`, `KafkaUser`.

    {% note info %}

    За доступ к data-plane сервисов — подключение к БД, чтение и запись данных — отвечает сам движок сервиса.

    {% endnote %}

* CR `Bucket` для Object Storage. Управление самим бакетом: создание, удаление, настройка CORS.

    {% note info %}

    Доступ к объектам внутри бакета контролирует IAM. Подробнее — в разделе «[IAM AccessBinding](#access-binding)».

    {% endnote %}

* CR самого IAM. Объекты, которые управляют доступом к платформе:

    * `ApiKey`, `AccessKey`, `OAuthClient`, `SAMLFederation`.

    * `AccessBinding`, `ClusterAccessBinding` — то есть IAM настраивают через ресурсы, доступ к которым контролирует Kubernetes RBAC.

#### Ресурсы и роли Kubernetes RBAC {#rbac-resources}

#|
|| **Ресурс** | **Уровень** | **Область действия** ||
|| `ClusterRoleBinding` | Весь кластер | Ресурсы во всех пространствах имен кластера ||
|| `ProjectRoleBinding` | Проект | Ресурсы во всех пространствах имен проекта ||
|| `RoleBinding` | Пространство имен | Ресурсы только в указанном пространстве имен ||
|#

#### Примитивные роли Stackland {#primitive-roles}

В Stackland есть набор примитивных ролей. Их назначают пользователям и группам через `RoleBinding` или `ClusterRoleBinding` — в зависимости от нужной области доступа.

* `stackland:admin` — полные права на все ресурсы (`'*'`) во всех API-группах.

* `stackland:editor` — то же, что `stackland:admin`, кроме IAM-объектов и проектов.

    {% note warning %}

    В отличие от `admin`, эта роль не позволяет управлять объектами самого IAM: `AccessBinding`, `ClusterAccessBinding`, `OAuthClient` и другими. То есть настроить права доступа для других пользователей с ней не получится. Еще эта роль не дает создавать проекты и управлять пространствами имен.

    {% endnote %}

* `stackland:viewer` — только чтение (`get`, `list`, `watch`) основных ресурсов: подов, деплойментов, конфигураций, ресурсов управляемых сервисов, сертификатов и других.

* `stackland:auditor` — все права `stackland:viewer` плюс расширенный просмотр: видны метаданные секретов, сетевые политики и политики безопасности, сертификаты и RBAC-объекты, то есть роли и привязки.

Пример. Назначение прав редактора для пользователя в пространстве имен `team-alpha-dev`:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: developer-edit
  namespace: team-alpha-dev
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: stackland:editor # Использование предопределенной роли Stackland
subjects:
- kind: User
  name: alice@stackland  # Субъект из IAM
```

### IAM AccessBinding {#access-binding}

IAM AccessBinding — механизм Identity and Access Management. Он назначает права субъектам на разных уровнях: кластера, проекта, пространства имен и так далее.

#### Когда использовать IAM AccessBinding {#when-to-use-access-binding}

Механизм решает несколько задач:

* **Управление пользователями и группами** — создание и редактирование локальных пользователей и групп.

    {% note alert %}

    Пока управлять пользователями и группами можно только из консоли управления.

    {% endnote %}

* **Data-plane операции с Object Storage (S3)** — чтение, запись и удаление объектов внутри бакета через S3 API. За выдачу прав отвечают роли `storage.*`.

* **Доступ к платформенным сервисам** — авторизация всех действий в SpeechSense и Yandex AI Studio on-premises.

#### Ресурсы и роли IAM AccessBinding {#access-binding-resources}

#|
|| **Ресурс** | **Уровень** | **Область действия** ||
|| `ClusterAccessBinding` | Весь кластер | Все проекты и ресурсы кластера ||
|| `ProjectAccessBinding` | Проект | Все проекты и ресурсы проекта ||
|| `AccessBinding` | Пространство имен | Только указанное пространство имен ||
|#

#### IAM-роли {#iam-roles}

Примитивные роли:

* `admin` — администратор. Все права `editor` плюс управление пользователями и группами в консоли.

* `editor` — редактор. Создает и изменяет ресурсы.

* `viewer` — наблюдатель. Только чтение.

Специализированные роли:

* `storage.admin` — полное управление объектами в бакете через S3 API.

* `storage.editor` — чтение и запись объектов в бакете через S3 API.

* `datalens.admin` — полный доступ к DataLens: управление пользователями, коллекциями, воркбуками и источниками данных.

* `datalens.creator` — создание и редактирование объектов: дашбордов, чартов, датасетов, подключений.

Для различных компонентов существуют и другие специализированные роли.

Пример. Назначение роли на чтение и запись объектов в бакетах S3 конкретного проекта:

```yaml
apiVersion: iam.stackland.yandex.cloud/v1alpha1
kind: ProjectAccessBinding
metadata:
  name: bob-storage-editor
  namespace: team-alpha
spec:
  roleID: storage.editor # Роль IAM для data-plane
  subject:
    kind: User
    name: bob@stackland
```

#### Ограничения IAM {#iam-limitations}

* Кастомные роли создать нельзя. Доступны только предопределенные: `admin`, `editor`, `storage.editor` и другие.

* Создание пользователей и групп возможно только через консоль управления.

* Поддерживаются только федерации SAML.

## Типы субъектов {#subject-types}

Kubernetes RBAC и IAM AccessBinding поддерживают в привязках ролей следующие типы субъектов:

#|
|| **Тип** | **Описание** ||
|| `User` | Локальный пользователь IAM ||
|| `Group` | Группа пользователей IAM ||
|| `ServiceAccount` | Сервисный аккаунт Kubernetes® ||
|| `FederatedUser` | Пользователь из внешнего провайдера идентификации ||
|#

## Иерархия ресурсов {#resource-hierarchy}

Права наследуются сверху вниз по трехуровневой модели:

#|
|| **Уровень** | **RBAC-ресурс** | **IAM-ресурс** ||
|| Кластер | `ClusterRoleBinding` | `ClusterAccessBinding` ||
|| Проект | `ProjectRoleBinding` | `ProjectAccessBinding` ||
|| Пространство имен | `RoleBinding` | `AccessBinding` ||
|#

## Примеры использования {#use-cases}

Таблица показывает, какой механизм выбрать под конкретную задачу:

#|
|| **Задача** | **Механизм авторизации** | **Ресурс для настройки** ||
|| Деплой приложений, управление подами | Kubernetes® RBAC | `RoleBinding`, `ProjectRoleBinding`, `ClusterRoleBinding` ||
|| Создание кластера PostgreSQL | Kubernetes® RBAC | `RoleBinding`, `ProjectRoleBinding`, `ClusterRoleBinding` ||
|| Создание бакета S3 | Kubernetes® RBAC | `RoleBinding`, `ProjectRoleBinding`, `ClusterRoleBinding` ||
|| Чтение или запись объектов внутри бакета | IAM AccessBinding | `RoleBinding`, `ProjectRoleBinding`, `ClusterRoleBinding` ||
|| Выдача прав на создание бакетов | Kubernetes® RBAC | `RoleBinding`, `ProjectRoleBinding`, `ClusterRoleBinding` ||
|| Создание нового пользователя в консоли | IAM AccessBinding | `ClusterAccessBinding` ||
|| Управление проектами (создание, удаление) | Kubernetes® RBAC | `ClusterRoleBinding` ||
|#

## Модель доступов для команды {#team-access-model}

Типовая команда — администратор кластера, администратор проекта и разработчик.

* **Администратор кластера**

    Наивысшие права во всем кластере. Управляет проектами, пользователями и группами, назначает любые роли на любых уровнях, работает со всеми ресурсами Kubernetes в кластере.

* **Администратор проекта**

    Управляет ресурсами одного проекта: создает управляемые базы данных и бакеты S3, назначает IAM-роли другим пользователям в пределах проекта. Работает со всеми пространствами имен проекта. За пределы проекта права не выходят, кластером в целом он не управляет.

* **Разработчик**

    Минимально необходимые права для работы. Через IAM (роль `stackland:project-member`) просматривает список доступных проектов и сервисов платформы. Через RBAC (роль `edit` в конкретном пространстве имен) деплоит приложения, смотрит логи, читает и меняет секреты в своем пространстве имен. Конфигурацией проекта и платформой не управляет.

### Матрица доступов {#access-matrix}

#|
|| **Действие** | **Администратор кластера** | **Администратор проекта** | **Разработчик** ||
||
Роль RBAC
|
`stackland:admin` (`ClusterRoleBinding`)
|
`stackland:admin` (`ProjectRoleBinding`)
|
`stackland:project-member` (`ProjectRoleBinding`)

`stackland:editor` (`RoleBinding` в `team-alpha-dev`)
||
|| Роль IAM | `admin` (`ClusterAccessBinding`) | `admin` (`ProjectAccessBinding`) | — ||
|| **Управление платформой (уровень кластера)** | > | > | > ||
|| Создание проектов | Да (RBAC) | Нет | Нет ||
|| Управление пользователями и группами | Да (IAM) | Нет | Нет ||
|| Назначение IAM-ролей | Да (RBAC) | Нет | Нет ||
|| **Управление проектом (уровень проекта)** | > | > | > ||
|| Настройка квот проекта | Да (RBAC) | Нет | Нет ||
|| Создание и удаление пространства имен в проекте | Да (RBAC) | Да (RBAC) | Нет ||
|| Назначение IAM-ролей | Да (RBAC) | Да (RBAC) | Нет ||
|| Создание и настройка кластеров PostgreSQL, ClickHouse® и Apache Kafka® | Да (RBAC) | Да (RBAC) | Нет ||
|| Создание и настройка бакетов S3 | Да (RBAC) | Да (RBAC) | Нет ||
|| **Управление пространством имен (уровень пространства имен)** | > | > | > ||
|| Создание и настройка кластеров PostgreSQL, ClickHouse® и Apache Kafka® | Да (RBAC) | Да (RBAC) | Да (RBAC) ||
|| Создание и настройка бакетов S3 | Да (RBAC) | Да (RBAC) | Да (RBAC) ||
|| Деплой приложений | Да (RBAC) | Да (RBAC) | Да (RBAC) ||
|| Просмотр логов и метрик | Да (RBAC) | Да (RBAC) | Да (RBAC) ||
|| Просмотр и изменение секретов | Да (RBAC) | Да (RBAC) | Да (RBAC) ||
|| Просмотр RBAC-ресурсов | Да (RBAC) | Да (RBAC) | Нет ||
|| Создание и изменение RBAC-ресурсов | Да (RBAC) | Да (RBAC) | Нет ||
|#

## Итоги {#summary}

Вы спроектировали модель доступов для команды разработки. Вот что важно запомнить:

* Kubernetes RBAC — основной инструмент для доступа ко всем ресурсам, включая CR. Через него управляют инфраструктурой и конфигурацией.

* IAM AccessBinding отвечает за доступ к данным S3 через S3 API, за пользователей и группы, а также за действия в некоторых платформенных сервисах: SpeechSense и Yandex AI Studio on-premises.

* Права наследуются сверху вниз по иерархии: кластер, проект, пространство имен.

* Матрица доступов сопоставляет обязанности членов команды с набором привилегий в обеих системах авторизации.