# Приглашение нового пользователя и назначение ролей

Руководство поможет вам пригласить нового пользователя в организацию и выдать ему права на каталог для создания в нем виртуальной машины (ВМ). Инструкции приведены и для администратора, и для пользователя. Действия, которые должен выполнить пользователь, приведены в разделе [Действия пользователя](#user-actions).

Чтобы пригласить пользователя в организацию и дать ему доступ к каталогу и другим ресурсам:

1. [Подготовьте платформу {{ yandex-cloud }} к работе](#before-begin).
1. [Подготовьте инфраструктуру](#prepare-infrastructure).
1. [Пригласите пользователя в организацию и назначьте роли](#add-account).
1. Убедитесь, что пользователь [принял приглашение и может пользоваться ресурсами](#user-actions).

Если созданные платные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за вычислительные ресурсы, операционную систему, хранилище, объем исходящего трафика и публичный IP-адрес ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).

## Подготовьте платформу {{ yandex-cloud }} к работе {#before-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md).

## Подготовьте инфраструктуру {#prepare-infrastructure}

[_Организация_](../../overview/roles-and-resources.md) — это рабочее пространство, которое объединяет разные типы ресурсов {{ yandex-cloud }} и пользователей. Создать организацию в {{ org-full-name }} может любой пользователь Яндекса. После создания организации вы станете ее [владельцем](../../organization/security/index.md#organization-manager-organizations-owner) и сможете управлять ее настройками.

Чтобы создать организацию:

1. [Перейдите]({{ link-org-cloud-center }}) в сервис {{ org-full-name }}.

    Порядок действий при создании организации зависит от того, состоите ли вы в какой-либо организации {{ org-full-name }}.

1. Создайте организацию:

    {% list tabs %}

    - Вы не состоите в организации

      Если вы пока не состоите в организации {{ org-full-name }}, при переходе по ссылке будет предложено создать новую организацию:

      1. Введите название организации: `Example organization`.
      1. Нажмите кнопку **{{ ui-key.yacloud_components.organization.action.create }}**.

    - Вы уже состоите в организации

      Если вы уже состоите в организации {{ org-full-name }}, при переходе по ссылке откроется интерфейс [{{ org-full-name }}]({{ link-org-cloud-center }}) в {{ cloud-center }}.

      Чтобы не нарушить работу инфраструктуры в существующих организациях, создайте новую организацию:

      1. В левом верхнем углу рядом с названием организации нажмите на значок ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите ![circle-plus](../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_components.organization.action.create-organization }}**.
      1. В открывшемся окне введите название организации: `Example organization`.
      1. Нажмите кнопку **{{ ui-key.yacloud_components.organization.action.create }}**.

    {% endlist %}

Если вы хотите выделить пользователю изолированные ресурсы в организации:

1. [Создайте облако](../../resource-manager/operations/cloud/create.md) `testing` в организации `Example organization`.

1. [Создайте каталог](../../resource-manager/operations/folder/create.md) `test-folder` в облаке `testing`.

Если изолированные ресурсы не нужны, вы можете выдать пользователю доступы к имеющимся облакам и каталогам — например к созданным по умолчанию.

## Пригласите пользователя в организацию и назначьте роли {#add-account}

{% note tip %}

Чтобы пользователь получил все необходимые права уже при первом входе, назначьте роли сразу после отправки приглашения. После принятия приглашения вы сможете назначить дополнительные роли или отозвать уже выданные.

{% endnote %}

### Отправьте приглашение пользователю {#send-invitation}

Чтобы пользователь мог использовать ресурсы {{ yandex-cloud }}, пригласите его в созданную организацию {{ org-full-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.
    1. В правом верхнем углу нажмите кнопку ![person-plus](../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.page.users.dropdown.button-text }}** и выберите ![person-planet-earth](../../_assets/console-icons/person-planet-earth.svg) **{{ ui-key.yacloud_org.page.users.action.invite-users }}**.
    1. Введите почту пользователя.

        {% include [send-invitation](../../_includes/organization/send-invitation.md) %}
    1. Нажмите кнопку **{{ ui-key.yacloud_components.organization.action_send-invitation }}**.

{% endlist %}

### Назначьте пользователю роль на облако {#add-cloud-role}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) [выберите](../../resource-manager/operations/cloud/switch-cloud.md) облако `testing`.
    1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
    1. В открывшемся окне выберите раздел **{{ ui-key.yacloud_org.common.resource-acl.label_invitee-accounts }}**.
    1. Выберите пользователя из списка или воспользуйтесь поиском по пользователям.
    1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите роль `resource-manager.clouds.member`.
    1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

{% endlist %}

### Назначьте пользователю роль на каталог {#add-folder-role}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог `test-folder`.
    1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
    1. В открывшемся окне выберите раздел **{{ ui-key.yacloud_org.common.resource-acl.label_invitee-accounts }}**.
    1. Выберите пользователя из списка или воспользуйтесь поиском по пользователям.
    1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите роль `compute.editor`.

       {% note tip %}

       Вы можете назначить пользователю другие роли в зависимости от того, какие действия с ресурсами каталога вы хотите разрешить. Полный перечень ролей см. в документации [{{ iam-full-name }}](../../iam/roles-reference.md).

       {% endnote %}

    1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

{% endlist %}

После этого передайте пользователю инструкции из [следующего раздела](#user-actions).


## Действия пользователя {#user-actions}

### Примите приглашение в организацию {#accept-invitation}

1. В письме с приглашением нажмите кнопку **Принять приглашение**.
1. На открывшейся странице нажмите кнопку **Принять**.
1. Выберите аккаунт для входа.

Теперь у вас есть доступ к организации `Example organization` и ее ресурсам.

### Проверьте доступ к облаку {#cloud-access-user-action}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в [консоль управления]({{ link-console-main }}) и на панели слева нажмите на аватар вашего аккаунта.
  1. Выберите организацию `Example organization`.
  1. На панели слева выберите облако `testing`. Откроется список каталогов облака.

     Это значит, что у вас есть доступ к облаку `testing`.

{% endlist %}

### Проверьте доступ к каталогу {#catalog-access-user-action}

Убедитесь, что у вас есть доступ к каталогу `test-folder`. После перехода в каталог создайте в нем виртуальную машину:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в [консоль управления]({{ link-console-main }}) и на панели слева нажмите на аватар вашего аккаунта.
  1. Выберите организацию `Example organization`.
  1. На панели слева выберите каталог `test-folder`.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Выберите ![image](../../_assets/console-icons/server.svg) **Виртуальные машины**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}** и задайте настройки ВМ:

     1. Выберите **Простая настройка**.
     1. В блоке **Операционные системы и продукты** выберите **Ubuntu 24.04 LTS**.
     1. В блоке **Вычислительные ресурсы** задайте конфигурацию вычислительных ресурсов для ВМ.
     1. В блоке **Диски** задайте размер и тип диска.
     1. Задайте **Имя ВМ**.
     1. Задайте **Логин** администратора ВМ.
     1. В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**. В открывшемся окне:
        1. Задайте **Имя** SSH-ключа.
        1. В блоке **SSH-ключ** выберите **Ввести вручную**, после чего загрузите или вставьте содержимое открытого SSH-ключа. Пару SSH-ключей для подключения к ВМ по [SSH](../../glossary/ssh-keygen.md) необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

           SSH-ключ будет добавлен в ваш профиль пользователя организации.

           Если в организации отключена возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя создаваемой виртуальной машины.
     1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

Успешное создание ВМ будет означать, что вы получили доступ к облаку и можете взаимодействовать с ресурсами {{ compute-name }}. Сообщите об этом администратору.

## Удалите созданные ресурсы {#clear-out}

Если пользователь больше не планирует использовать созданную виртуальную машину, [удалите ее](../../compute/operations/vm-control/vm-delete), чтобы за нее не списывалась плата.
