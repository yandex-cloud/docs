# Разграничение прав доступа для групп пользователей с различными ролями в {{ org-full-name }}

В настоящем руководстве приведен пример решения по использованию [групп пользователей](../../organization/concepts/groups.md) для разграничения [прав доступа](../../iam/concepts/access-control/index.md) к ресурсам в [организации {{ org-full-name }}](../../overview/roles-and-resources.md).

## Обзор решения {#solution-overview}

![image](../../_assets/iam/organization-user-groups-access-tutorial.svg)

В рамках руководства вы создадите тестовую организацию, в которой будут созданы два [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) — `production` и `testing`, соответствующие независимым друг от друга продуктовой и тестовой средам разработки. Этими облаками будут пользоваться три группы пользователей, созданные в организации: группа инженеров по информационной безопасности (`security`), группа инженеров DevOps (`devops`) и группа разработчиков (`developers`).

Каждой из групп пользователей будет назначен свой набор [ролей](../../iam/concepts/access-control/roles.md), соответствующий объему задач, выполняемых пользователями-участниками этих групп. Так, инженерам по информационной безопасности во всей организации будут предоставлены права на получение информации обо всех ресурсах, настройку сбора и хранения [аудитных логов](../../audit-trails/concepts/trail.md) любых ресурсов, а также настройку и выполнение сканирования [Docker-образов](../../container-registry/concepts/docker-image.md) в [реестрах](../../container-registry/concepts/registry.md) {{ container-registry-full-name }}. 

Кроме того, для группы инженеров по информационной безопасности в продуктовой среде будет создан отдельный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) `security`, в котором у участников этой группы будут права администратора и в котором они смогут управлять любыми необходимыми им ресурсами и доступом к ним.

Группе инженеров DevOps в двух облаках будут предоставлены права на управление реестрами {{ container-registry-name }}, [кластерами](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) {{ managed-k8s-full-name }}, кластерами управляемых баз данных, [виртуальными машинами](../../compute/concepts/vm.md), ресурсами [сервиса {{ monitoring-full-name }}](../../monitoring/index.yaml), а также на управление [лог-группами](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }} и доступом к ним.

Группе разработчиков будут предоставлены следующие права доступа:
* в продуктовой среде на скачивание Docker-образов из реестров {{ container-registry-name }}, просмотр информации о кластерах {{ k8s }}, подключение к виртуальным машинам {{ compute-name }} через [{{ oslogin }}](../../organization/concepts/os-login.md), а также на просмотр информации о ресурсах и [метриках](../../monitoring/concepts/data-model.md#metric) сервиса {{ monitoring-name }};
* в тестовой среде на скачивание и загрузку Docker-образов в реестры {{ container-registry-name }}, управление кластерами {{ k8s }}, подключение к виртуальным машинам {{ compute-name }} через {{ oslogin }} от имени суперпользователя, а также на управление ресурсами сервиса {{ monitoring-name }}. 

Чтобы настроить разграничение прав доступа к ресурсам организации с помощью групп пользователей:

1. [Подготовьте платформу {{ yandex-cloud }} к работе](#before-begin).
1. [Создайте организацию](#create-organization).
1. [Создайте облака](#create-clouds).
1. [Создайте каталог для группы инженеров по информационной безопасности](#create-folder).
1. [Создайте группы пользователей](#create-user-groups).
1. [Настройте права доступа](#setup-access-permissions).
1. [Добавьте пользователей и распределите их по группам](#add-users).
1. [Создайте рабочую инфраструктуру](#move-on).

Если созданная тестовая организация вам больше не нужна, [удалите](#clear-out) ее.

## Подготовьте платформу {{ yandex-cloud }} к работе {#before-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md).

## Создайте организацию {#create-organization}

[_Организация_](../../overview/roles-and-resources.md) — это рабочее пространство, которое объединяет разные типы ресурсов {{ yandex-cloud }} и пользователей. Создать организацию в {{ org-full-name }} может любой пользователь Яндекса.

Чтобы создать организацию:

1. [Перейдите]({{ link-org-cloud-center }}) в сервис {{ org-full-name }}.

    Порядок действий при создании организации будет зависеть от того, являетесь ли вы уже членом какой-либо организации {{ org-full-name }}.
1. Создайте организацию:

    {% list tabs %}

    - Вы не входите в организацию

      Если вы пока не являетесь членом какой-либо организации {{ org-full-name }}, при переходе по ссылке у вас откроется форма создания новой организации:

      1. Введите название организации: `Example organization`.
      1. Нажмите кнопку **{{ ui-key.yacloud_components.organization.action.create }}**.

    - Вы уже состоите в организации

      Если вы уже являетесь членом какой-либо организации {{ org-full-name }}, при переходе по ссылке у вас откроется интерфейс [{{ org-full-name }}]({{ link-org-cloud-center }}) в {{ cloud-center }}.

      Чтобы не нарушить работу инфраструктуры в существующих организациях, для целей данного руководства вы создадите новую организацию:

      1. В левом верхнем углу экрана рядом с названием текущей организации нажмите значок ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите ![circle-plus](../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_components.organization.action.create-organization }}**.
      1. В открывшемся окне введите название организации: `Example organization`.
      1. Нажмите **{{ ui-key.yacloud_components.organization.action.create }}**.

    {% endlist %}

После создания организации вы станете ее [владельцем](../../organization/security/index.md#organization-manager-organizations-owner) и сможете управлять ее настройками.

## Создайте облака {#create-clouds}

В новой организации вы создадите два [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) — `testing` и `production`, в которых, соответственно, будет размещаться инфраструктура независимых друг от друга тестовой и продуктовой сред.

1. Создайте два облака в организации `Example organization`:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. Перейдите в [консоль управления]({{ link-console-main }}) и на панели слева нажмите фото вашего аккаунта.
      1. Выберите организацию `Example organization`. Откроется окно с формой создания первого облака в организации:

          1. Убедитесь, что в поле **{{ ui-key.yacloud.page.welcome.field_organization }}** выбрана организация `Example organization`.
          1. В поле **{{ ui-key.yacloud.page.welcome.field_cloud-name }}** укажите `testing`.
          1. Нажмите **{{ ui-key.yacloud.page.welcome.button_create }}**.

          В результате в организации `Example organization` будет создано первое облако `testing`, а браузер откроет каталог по умолчанию `default`, созданный внутри этого нового облака.
      1. В левой части экрана в строке с именем организации `Example organization` нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.cloud.label_create_cloud }}**. В открывшемся окне:

          1. В поле **{{ ui-key.yacloud.common.name }}** укажите `production`.
          1. Нажмите **{{ ui-key.yacloud.common.create }}**.

          В результате в организации `Example organization` будет создано второе облако `production`.

    {% endlist %}

1. Убедитесь, что созданные облака привязаны к [платежному аккаунту](../../billing/concepts/billing-account.md):

    {% list tabs group=instructions %}

    - Интерфейс {{ cloud-center }} {#cloud-center}

      1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}
      1. Выберите ваш платежный аккаунт.
      1. На странице с информацией об аккаунте убедитесь, что в блоке **{{ ui-key.yacloud_billing.billing.account.dashboard-resources.title_section-billable }}** указаны оба созданных облака — `production` и `testing`.
      1. Если какое-то из облаков (или оба облака) отсутствуют в этом блоке, привяжите их:

          1. В блоке **{{ ui-key.yacloud_billing.billing.account.dashboard-resources.title_section-billable }}** нажмите кнопку ![link](../../_assets/console-icons/link.svg) **{{ ui-key.yacloud_billing.billing.account.dashboard-resources.button_bind-cloud }}**.
          1. В открывшемся окне выберите облако, которое необходимо привязать, и нажмите кнопку **{{ ui-key.yacloud_billing.billing.accounts.button_bind }}**.

    {% endlist %}

## Создайте каталог для группы инженеров по информационной безопасности {#create-folder}

Создайте отдельный каталог `security` для группы инженеров по информационной безопасности в облаке `production`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке организаций, облаков и каталогов в левой части экрана выберите облако `production`.
  1. В строке с именем облака `production` нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**. В открывшемся окне:

      1. В поле **{{ ui-key.yacloud.iam.cloud.folders-create.field_name }}** задайте имя каталога `security`.
      1. (Опционально) В поле **{{ ui-key.yacloud_org.iam.cloud.folders-create.field_description }}** задайте описание создаваемого каталога.
      1. В поле **{{ ui-key.yacloud.iam.cloud.folders-create.field_optionally }}** отключите опцию **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}**. Позднее при создании инфраструктуры вы в любой момент сможете [создать облачную сеть](../../vpc/operations/network-create.md) с нужными вам параметрами.
      1. Нажмите кнопку **{{ ui-key.yacloud_org.iam.cloud.folders-create.button_create }}**. 

{% endlist %}

## Создайте группы пользователей {#create-user-groups}

Создайте три [группы пользователей](../../organization/concepts/groups.md): `security` для инженеров по информационной безопасности, `devops` для инженеров DevOps и `developers` для разработчиков:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![groups](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.
  1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.entity.group.action_create }}** и в открывшемся окне:

      1. Задайте название группы: `security`.
      1. (Опционально) Задайте описание группы.
      1. Нажмите кнопку **{{ ui-key.yacloud_org.groups.action_create-group }}**.
  1. Аналогичным образом создайте две другие группы пользователей — `devops` и `developers`.

{% endlist %}

## Настройте права доступа {#setup-access-permissions}

В рамках настоящего руководства вы назначите группам пользователей несколько [ролей](../../iam/concepts/access-control/roles.md), соответствующих профилям деятельности сотрудников, которые будут входить в эти группы.

{% note info %}

Все пользователи, входящие в группу пользователей, будут автоматически [наследовать](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) роли, назначенные группе. Кроме этого, вы также можете назначать роли каждому отдельному пользователю, в том числе входящему в группу пользователей.

{% endnote %}

### Назначьте роли группе инженеров по информационной безопасности {#assign-security-roles}

Пользователям, входящим в группу инженеров по информационной безопасности (`security`), понадобятся следующие возможности:

* получать информацию обо всех ресурсах во всех облаках организации ([роль](../../iam/roles-reference.md#auditor) `auditor` на организацию);
* настраивать сбор и хранение [аудитных логов](../../audit-trails/concepts/trail.md) всех ресурсов во всех облаках организации ([роль](../../audit-trails/security/index.md#at-admin) `audit-trails.admin` на организацию);
* настраивать и выполнять сканирование [Docker-образов](../../container-registry/concepts/docker-image.md) в [реестрах](../../container-registry/concepts/registry.md) {{ container-registry-full-name }} во всех облаках организации ([роль](../../container-registry/security/index.md#container-registry-images-scanner) `container-registry.images.scanner` на организацию);
* управлять всеми ресурсами и доступом к ним в специальном каталоге `security` облака `production` ([роль](../../iam/roles-reference.md#admin) `admin` на этот каталог).

Для того, чтобы предоставить группе пользователей `security` необходимые права доступа:

1. Назначьте роли на организацию:

    {% list tabs group=instructions %}

    - Интерфейс {{ cloud-center }} {#cloud-center}

      1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
      1. На панели слева выберите ![persons-lock](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.
      1. Справа сверху нажмите кнопку **{{ ui-key.yacloud_org.entity.user.action.acl }}**.
      1. Перейдите на вкладку **{{ ui-key.yacloud_org.pages.groups }}** и выберите [группу](../../organization/concepts/groups.md) `security`.
      1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}**, введите в строке поиска и выберите [роль](../../iam/concepts/access-control/roles.md) `auditor`.
      1. Повторите предыдущее действие, чтобы добавить роли `audit-trails.admin` и `container-registry.images.scanner`.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

    {% endlist %}

1. Назначьте роль `admin` на каталог `security`:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог `security` в облаке `production`.
      1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** и нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**. В открывшемся окне:

          1. Перейдите на вкладку **{{ ui-key.yacloud_org.pages.groups }}** и выберите группу `security`.
          1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}**, введите в строке поиска и выберите роль `admin`.
          1. Нажмите **{{ ui-key.yacloud.common.save }}**.

    {% endlist %}

### Назначьте роли группе инженеров DevOps {#assign-devops-roles}

Пользователям, входящим в группу инженеров DevOps (`devops`), в обоих облаках понадобятся следующие возможности:

* управлять реестрами {{ container-registry-name }} ([роль](../../container-registry/security/index.md#container-registry.editor) `container-registry.editor` на оба облака);
* управлять [кластерами](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) {{ managed-k8s-full-name }} ([роль](../../managed-kubernetes/security/index.md#k8s-editor) `k8s.editor` на оба облака);
* управлять кластерами управляемых баз данных ([роль](../../iam/roles-reference.md#mdb-admin) `mdb.admin` на оба облака);
* управлять [виртуальными машинами](../../compute/concepts/vm.md) {{ compute-full-name }} ([роль](../../compute/security/index.md#compute-editor) `compute.editor` на оба облака);
* управлять ресурсами [сервиса {{ monitoring-full-name }}](../../monitoring/index.yaml) ([роль](../../monitoring/security/index.md#monitoring-admin) `monitoring.admin` на оба облака);
* управлять [лог-группами](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }} и доступом к ним ([роль](../../logging/security/index.md#logging-admin) `logging.admin` на оба облака).

Назначьте группе пользователей `devops` роли на облака:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите облако `production`.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** и нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**. В открывшемся окне:

      1. Перейдите на вкладку **{{ ui-key.yacloud_org.pages.groups }}** и выберите группу `devops`.
      1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}**, найдите и выберите роли `container-registry.editor`, `k8s.editor`, `mdb.admin`, `compute.editor`, `monitoring.admin` и `logging.admin`.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.
  1. Аналогичным образом назначьте эти же роли группе пользователей `devops` на облако `testing`.

{% endlist %}

### Назначьте роли группе разработчиков {#assign-developer-roles}

Пользователям, входящим в группу разработчиков (`developers`), понадобятся следующие возможности:

* скачивать Docker-образы из реестров {{ container-registry-name }} в продуктовой среде ([роль](../../container-registry/security/index.md#container-registry-images-puller) `container-registry.images.puller` на облако `production`);
* скачивать и загружать Docker-образы в реестры {{ container-registry-name }} в тестовой среде ([роль](../../container-registry/security/index.md#container-registry-images-pusher) `container-registry.images.pusher` на облако `testing`);
* просматривать информацию о кластерах {{ k8s }} в продуктовой среде ([роль](../../managed-kubernetes/security/index.md#k8s-viewer) `k8s.viewer` на облако `production`);
* управлять кластерами {{ k8s }} в тестовой среде ([роль](../../managed-kubernetes/security/index.md#k8s-editor) `k8s.editor` и [роль](../../managed-kubernetes/security/index.md#k8s-cluster-api-editor) `k8s.cluster-api.editor` на облако `testing`);
* подключаться к виртуальным машинам {{ compute-name }} через [{{ oslogin }}](../../organization/concepts/os-login.md) в продуктовой среде ([роль](../../compute/security/index.md#compute-oslogin) `compute.osLogin` на облако `production`);
* подключаться к виртуальным машинам {{ compute-name }} через {{ oslogin }} от имени суперпользователя в тестовой среде ([роль](../../compute/security/index.md#compute-osadminlogin) `compute.osAdminLogin` на облако `testing`);
* просматривать информацию о ресурсах и [метриках](../../monitoring/concepts/data-model.md#metric) {{ monitoring-name }} в продуктовой среде ([роль](../../monitoring/security/index.md#monitoring-viewer) `monitoring.viewer` на облако `production`);
* управлять ресурсами сервиса {{ monitoring-name }} в тестовой среде ([роль](../../monitoring/security/index.md#monitoring-editor) `monitoring.editor` на облако `testing`).

Назначьте группе пользователей `developers` роли на облака:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите облако `production`.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** и нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**. В открывшемся окне:

      1. Перейдите на вкладку **{{ ui-key.yacloud_org.pages.groups }}** и выберите группу `developers`.
      1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}**, найдите и выберите роли `container-registry.images.puller`, `k8s.viewer`, `compute.osLogin` и `monitoring.viewer`.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.
  1. Аналогичным образом назначьте группе пользователей `developers` роли `container-registry.images.pusher`, `k8s.editor`, `k8s.cluster-api.editor`, `compute.osAdminLogin` и `monitoring.editor` на облако `testing`.

{% endlist %}

## Добавьте пользователей и распределите их по группам {#add-users}

Чтобы сотрудники вашей компании могли использовать ресурсы {{ yandex-cloud }}, добавьте их в созданную организацию {{ org-full-name }}, а затем, в зависимости от выполняемых ими обязанностей, распределите добавленных сотрудников по созданным ранее группам пользователей.

1. Пригласите сотрудников в организацию:

    {% list tabs group=instructions %}

    - Интерфейс {{ cloud-center }} {#cloud-center}

      1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
      1. На панели слева выберите ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.
      1. В правом верхнем углу экрана нажмите кнопку **{{ ui-key.yacloud_org.page.users.action.invite-users }}**.
      1. Через запятую введите почтовые адреса пользователей, которых вы хотите пригласить в организацию.

          {% include [send-invitation](../../_includes/organization/send-invitation.md) %}
      1. Нажмите кнопку **{{ ui-key.yacloud_components.organization.action_send-invitation }}**.

    {% endlist %}

    Сразу после того, как пользователи примут приглашения по ссылке из письма, они станут [участниками организации](../../organization/concepts/membership.md) и будут отображаться в списке в [разделе **{{ ui-key.yacloud_org.pages.users }}**]({{ link-org-cloud-center }}/users) вашей организации.

    {% note info %}

    Для доступа к сервисам, которые подключены к организации, приглашенным пользователям достаточно войти в свой аккаунт на Яндексе.

    {% endnote %}

1. Распределите добавленных пользователей по созданным ранее группам:

    {% list tabs group=instructions %}

    - Интерфейс {{ cloud-center }} {#cloud-center}

      1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
      1. На панели слева выберите ![groups](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}** и нажмите строку с названием нужной [группы](../../organization/concepts/groups.md).
      1. Перейдите на вкладку **{{ ui-key.yacloud_org.entity.group.title_tab-members }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud_org.entity.group.action_add-member }}**. В открывшемся окне:

          1. Выберите нужных пользователей. При необходимости воспользуйтесь поиском.
          1. Нажмите **{{ ui-key.yacloud_org.component.subject-select-dialog.action_apply }}**.

    {% endlist %}

    Распределите всех пользователей по группам в соответствии с выполняемыми ими обязанностями.

    {% note info %}

    Пользователь может являться участником одновременно нескольких групп пользователей.

    {% endnote %}

## Создайте рабочую инфраструктуру {#move-on}

Вы завершили базовую настройку прав доступа в вашей тестовой организации. Теперь вы можете создавать в облаках организации различные ресурсы: [виртуальные машины](../../compute/operations/vm-create/create-linux-vm.md), [кластеры](../../managed-kubernetes/quickstart.md#kubernetes-cluster-create) {{ managed-k8s-full-name }}, [реестры](../../container-registry/operations/registry/registry-create.md) {{ container-registry-full-name }}, [ключи шифрования](../../kms/operations/key.md#create) {{ kms-short-name }}, [секреты](../../lockbox/operations/secret-create.md) {{ lockbox-short-name }} и др.

{% note warning %}

Обратите внимание, что виртуальные машины, кластеры, реестры, ключи, секреты и многие другие ресурсы, создаваемые в каталогах, тарифицируются. Подробнее о тарификации облачных ресурсов см. в [документации соответствующих сервисов](../../billing/pricing.md#billable).

{% endnote %}

Права доступа к создаваемым ресурсам будут предоставлены пользователям в соответствии с настройками прав доступа для соответствующих групп пользователей.

Управлять созданной инфраструктурой рекомендуется от имени [сервисных аккаунтов](/iam/concepts/users/service-accounts), которые могут использоваться для аутентификации программ. Сервисные аккаунты создаются в каталогах. Сервисные аккаунты также можно добавлять в группы пользователей.

При необходимости вы можете в любое время [назначить](../../iam/operations/roles/grant.md) дополнительные роли отдельным пользователям или сервисным аккаунтам как на всю организацию, так и на отдельные облака, каталоги или ресурсы.

## Как удалить созданные ресурсы {#clear-out}

Если созданная тестовая организация вам больше не нужна, [удалите](../../organization/operations/delete-org.md) ее.

Сами по себе организации, облака, каталоги и пользователи не тарифицируются, поэтому вам не придется за них платить. Однако другие ресурсы, создаваемые внутри каталогов, могут тарифицироваться.

Кроме того, созданная в настоящем руководстве инфраструктура расходует [квоты](../../billing/concepts/limits.md) сервиса {{ billing-name }} и некоторых других сервисов. Поэтому неиспользуемую организацию лучше удалить.

Также вы можете отдельно удалить [облака](../../resource-manager/operations/cloud/delete.md), [каталоги](../../resource-manager/operations/folder/delete.md), [группы пользователей](../../organization/operations/delete-group.md), [сервисные аккаунты](../../iam/operations/sa/delete.md) или [исключить](../../organization/operations/edit-account.md#remove-user) пользователей из организации.

#### См. также {#see-also}

* {{ at-full-name }}:
    * [{#T}](../../audit-trails/operations/create-trail.md)
* {{ billing-name }}:
    * [Создание платежного аккаунта](../../billing/operations/create-new-account.md)
    * [Назначение прав доступа к платежному аккаунту](../../billing/security/index.md#set-role)
* {{ cloud-logging-full-name }}:
    * [Создание лог-группы](../../logging/operations/create-group.md)
    * [Назначение прав доступа к лог-группе](../../logging/operations/access-rights.md)
* {{ org-full-name }}:
    * [{#T}](../../organization/operations/index.md)
* {{ compute-full-name }}:
    * [{#T}](../../compute/operations/index.md#vm-create)
    * [Назначение прав доступа к виртуальной машине](../../compute/operations/vm-control/vm-access.md)
* {{ container-registry-full-name }}:
    * [Создание реестра](../../container-registry/operations/registry/registry-create.md)
    * [Назначение прав доступа к реестру](../../container-registry/operations/roles/grant.md)
* {{ iam-full-name }}:
    * [{#T}](../../iam/operations/sa/create.md)
    * [Назначение прав доступа к сервисному аккаунту](../../iam/operations/sa/set-access-bindings.md)
* {{ kms-full-name }}:
    * [Создание симметричного ключа шифрования](../../kms/operations/key.md#create)
    * [{#T}](../../kms/operations/key-access.md)
* {{ lockbox-full-name }}:
    * [Создание секрета](../../lockbox/operations/secret-create.md)
    * [Назначение прав доступа к секрету](../../lockbox/operations/secret-access.md)
* {{ managed-k8s-full-name }}:
    * [{#T}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md)
* {{ mpg-full-name }}:
    * [{#T}](../../managed-postgresql/operations/cluster-create.md)
* {{ monitoring-full-name }}:
    * [{#T}](../../monitoring/operations/dashboard/create.md)
