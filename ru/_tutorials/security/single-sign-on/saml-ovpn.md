# Создать SAML-приложение в {{ org-full-name }} для интеграции с OpenVPN Access Server

{% include [note-preview](../../../_includes/note-preview.md) %}

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в OpenVPN Access Server с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../organization/concepts/applications.md#saml) в {{ org-name }} и настройте его на стороне {{ org-name }} и на стороне OpenVPN Access Server.

ПО [OpenVPN Access Server](/marketplace/products/yc/openvpn-access-server) совместимо с [открытой версией](https://github.com/OpenVPN) OpenVPN и построено на ее основе. Продукт предоставляет клиенты для Windows, Mac, Android и iOS, а также позволяет управлять подключениями с помощью веб-интерфейса.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

Чтобы дать доступ пользователям вашей организации в OpenVPN Access Server:

1. [Подготовьте OpenVPN Access Server](#prepare-ovpn).
1. [Создайте приложение в {{ org-name }}](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

## Подготовьте OpenVPN Access Server {#prepare-ovpn}

Вы можете использовать собственную установку OpenVPN Access Server, SaaS-версию или создать виртуальную машину с OpenVPN Access Server в {{ yandex-cloud }}.

{% cut "Создать ВМ с OpenVPN Access Server в {{ yandex-cloud }}" %}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `OpenVPN Access Server` и выберите образ [OpenVPN Access Server](/marketplace/products/yc/openvpn-access-server).
   1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md).
   1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа к ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя: `yc-user`.
      * {% include [access-ssh-key](../../../_includes/compute/create/access-ssh-key.md) %}

   1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `vpn-server`.
   1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
   1. Появится окно с информацией о типе тарификации: BYOL (Bring Your Own License).
   1. Нажмите **Создать**.

{% endlist %}

### Получите пароль администратора {#get-admin-password}

{% include [openvpn-get-admin-password](../../_tutorials_includes/openvpn-get-admin-password.md) %}

{% endcut %}

## Создайте приложение в {{ org-name }} {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

   1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
   1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
   1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
      1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}**.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `ovpn-app`.

      1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
      1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

         1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
         1. Введите метку в формате `ключ: значение`.
         1. Нажмите **Enter**.
      1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
   1. Сохраните значение поля **{{ ui-key.yacloud_org.application.overview.saml_field_metadata }}**, оно понадобится на следующем шаге.

{% endlist %}

## Настройте интеграцию {#setup-integration}

### Настройте аутентификацию на стороне OpenVPN Access Server {#setup-sp}

{% note info %}

По умолчанию на сервер установлен самоподписанный сертификат. Если вам необходимо поменять сертификат, воспользуйтесь [инструкцией](https://openvpn.net/vpn-server-resources/installing-a-valid-ssl-web-certificate-in-access-server/).

{% endnote %}

Добавьте на сервере OpenVPN способ аутентификации через SAML:

1. Откройте в браузере административный интерфейс OpenVPN Access Server. По умолчанию он доступен по адресу `https://<адрес сервера>:943/admin`.
1. Введите имя и пароль администратора OpenVPN Access Server.
1. Нажмите кнопку **Agree**. Откроется главный экран административной панели OpenVPN.
1. Разверните вкладку **Authentication** и выберите пункт **SAML**.
1. Переведите чекбокс **Enable SAML authentication** в значение **Yes**.
1. Разверните секцию **Configure Identity Provider (IdP) Automatically via Metadata**.
1. В поле **IdP Metadata URL** введите адрес файла с метаданными, скопированный ранее.
1. Нажмите кнопку **Get**.
1. Нажмите кнопку **Save settings**.
1. Скопируйте значения `SP Identity` и `SP ACS` на этой странице.
   ```text
   These URLs depend on the hostname setting your current setting of '<адрес сервера>'.
      SP Identity: https://<адрес сервера>/saml/metadata
      SP ACS: https://<адрес сервера>/saml/acs
   ```
1. Разверните вкладку **Authentication** и выберите пункт **Settings**.
1. В секции **Default Authentication System** выберите значение **SAML**.
1. Нажмите кнопку **Save settings**.
1. Нажмите кнопку **Update running server**.

### Настройте SAML-приложение на стороне {{ org-full-name }} {#setup-idp}

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:  
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** вставьте адрес `SP Identity`, скопированный ранее.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** вставьте адрес `SP ACS`, скопированный ранее.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Добавьте пользователя {#add-user}

Чтобы пользователи вашей организации могли аутентифицироваться в OpenVPN Access Server с помощью SAML-приложения {{ org-name }}, необходимо явно добавить в SAML-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

{% endnote %}

1. Добавьте пользователей в приложение:

   {% list tabs group=instructions %}

   - Интерфейс {{ cloud-center }} {#cloud-center}

      1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
      1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
      1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
      1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
      1. В открывшемся окне выберите нужного пользователя или группу пользователей.
      1. Нажмите **{{ ui-key.yacloud.common.add }}**.

   {% endlist %}

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе SAML-приложения и интеграции с OpenVPN Access Server, выполните аутентификацию в Access Server от имени одного из добавленных в приложение пользователей. Для этого:

1. В браузере перейдите в клиентский интерфейс OpenVPN Access Server. По умолчанию он доступен по адресу `https://<адрес сервера>:943/`.
1. На странице аутентификации нажмите **Sign In With SAML**.
1. На странице аутентификации {{ yandex-cloud }} укажите почту и пароль пользователя. Пользователь должен быть добавлен в приложение или состоять в группе, добавленной в приложение.
1. Убедитесь, что вы аутентифицировались в OpenVPN Access Server.