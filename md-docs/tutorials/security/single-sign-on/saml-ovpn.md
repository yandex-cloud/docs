# Создать SAML-приложение в Yandex Identity Hub для интеграции с OpenVPN Access Server

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в OpenVPN Access Server с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../organization/concepts/applications/saml.md) в Yandex Identity Hub и настройте его на стороне Yandex Identity Hub и на стороне OpenVPN Access Server.

ПО [OpenVPN Access Server](https://yandex.cloud/ru/marketplace/products/yc/openvpn-access-server) совместимо с [открытой версией](https://github.com/OpenVPN) OpenVPN и построено на ее основе. Продукт предоставляет клиенты для Windows, Mac, Android и iOS, а также позволяет управлять подключениями с помощью веб-интерфейса.

Управлять SAML-приложениями может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-admin) `organization-manager.samlApplications.admin` или выше.

Чтобы дать доступ пользователям вашей организации в OpenVPN Access Server:

1. [Подготовьте OpenVPN Access Server](#prepare-ovpn).
1. [Создайте приложение в Yandex Identity Hub](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

## Подготовьте OpenVPN Access Server {#prepare-ovpn}

Вы можете использовать собственную установку OpenVPN Access Server, SaaS-версию или создать виртуальную машину с OpenVPN Access Server в Yandex Cloud.

{% cut "Создать ВМ с OpenVPN Access Server в Yandex Cloud" %}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
   1. Перейдите в сервис **Compute Cloud**.
   1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **Виртуальные машины**.
   1. Нажмите кнопку **Создать виртуальную машину**.
   1. В блоке **Образ загрузочного диска** в поле **Поиск продукта** введите `OpenVPN Access Server` и выберите образ [OpenVPN Access Server](https://yandex.cloud/ru/marketplace/products/yc/openvpn-access-server).
   1. В блоке **Расположение** выберите [зону доступности](../../../overview/concepts/geo-scope.md).
   1. В блоке **Доступ** выберите вариант **SSH-ключ** и укажите данные для доступа к ВМ:

      * В поле **Логин** введите имя пользователя: `yc-user`.
      * В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../../organization/concepts/membership.md).
        
        Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
        
        1. Нажмите кнопку **Добавить ключ**.
        1. Задайте имя SSH-ключа.
        1. Выберите вариант:
        
            * `Ввести вручную` — вставьте содержимое открытого [SSH](../../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
            * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
            * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
            
              При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
        
        1. Нажмите кнопку **Добавить**.
        
        SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

   1. В блоке **Общая информация** задайте имя ВМ: `vpn-server`.
   1. Нажмите кнопку **Создать ВМ**.
   1. Появится окно с информацией о типе тарификации: BYOL (Bring Your Own License).
   1. Нажмите **Создать**.

{% endlist %}

### Получите пароль администратора {#get-admin-password}

На сервере OpenVPN заранее создан пользователь `openvpn` с административными правами. Пароль генерируется автоматически при создании [виртуальной машины](../../../compute/concepts/vm.md).

Получите пароль в [выводе последовательного порта](../../../compute/operations/vm-info/get-serial-port-output.md) или в серийной консоли. Пароль отобразится в строке:

```text
To login please use the "openvpn" account with <пароль> password.
```

Где `<пароль>` — пароль пользователя `openvpn`.

Для первого входа в административную панель используйте логин `openvpn` и полученный пароль.

Если вы не получили пароль после первого [запуска сервера VPN](#create-vpn-server), необходимо заново создать ВМ с [OpenVPN Access Server](https://yandex.cloud/ru/marketplace/products/yc/openvpn-access-server). При перезапусках пароль не отображается.

{% endcut %}

## Создайте приложение в Yandex Identity Hub {#create-app}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

   1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
   1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.
   1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **Создать приложение** и в открывшемся окне:
      1. Выберите метод единого входа **SAML (Security Assertion Markup Language)**.
      1. В поле **Имя** задайте имя создаваемого приложения: `ovpn-app`.

      1. (Опционально) В поле **Описание** задайте описание приложения.
      1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

         1. Нажмите **Добавить метку**.
         1. Введите метку в формате `ключ: значение`.
         1. Нажмите **Enter**.
      1. Нажмите **Создать приложение**.
   1. Сохраните значение поля **Metadata URL**, оно понадобится на следующем шаге.

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

### Настройте SAML-приложение на стороне Yandex Identity Hub {#setup-idp}

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное SAML-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **Редактировать** и в открывшемся окне:  
      1. В поле **SP EntityID** вставьте адрес `SP Identity`, скопированный ранее.
      1. В поле **ACS URL** вставьте адрес `SP ACS`, скопированный ранее.
      1. Нажмите **Сохранить**.

{% endlist %}

### Добавьте пользователя {#add-user}

Чтобы пользователи вашей организации могли аутентифицироваться в OpenVPN Access Server с помощью SAML-приложения Yandex Identity Hub, необходимо явно добавить в SAML-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

{% endnote %}

1. Добавьте пользователей в приложение:

   {% list tabs group=instructions %}

   - Интерфейс Cloud Center {#cloud-center}

      1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
      1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное приложение.
      1. Перейдите на вкладку **Пользователи и группы**.
      1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **Добавить пользователей**.
      1. В открывшемся окне выберите нужного пользователя или группу пользователей.
      1. Нажмите **Добавить**.

   {% endlist %}

{% note tip %}

Если вы хотите более тонко настроить аутентификацию пользователей в приложениях, в том числе разрешить аутентификацию только с определенных IP-адресов, используйте [политики аутентификации](*authentication_policies).

{% endnote %}

[*authentication_policies]: Политики аутентификации — это инструмент Yandex Identity Hub, позволяющий гибко настраивать доступ к приложениям, запрещая или разрешая аутентификацию определенным пользователям в определенных приложениях и/или с определенных IP-адресов. Подробнее читайте в разделе [Политики аутентификации в Yandex Identity Hub](../../../organization/concepts/authentication-policy.md).

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе SAML-приложения и интеграции с OpenVPN Access Server, выполните аутентификацию в Access Server от имени одного из добавленных в приложение пользователей. Для этого:

1. В браузере перейдите в клиентский интерфейс OpenVPN Access Server. По умолчанию он доступен по адресу `https://<адрес сервера>:943/`.
1. На странице аутентификации нажмите **Sign In With SAML**.
1. На странице аутентификации Yandex Cloud укажите почту и пароль пользователя. Пользователь должен быть добавлен в приложение или состоять в группе, добавленной в приложение.
1. Убедитесь, что вы аутентифицировались в OpenVPN Access Server.