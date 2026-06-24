# Начало работы с Yandex Cloud Desktop для администраторов

{% note info %}

Инструкция содержит информацию о создании и настройке [группы рабочих столов](concepts/desktops-and-groups.md). Если вы получили от администратора ссылку на [витрину пользовательских рабочих столов](concepts/showcase.md), перейдите к разделу [Начало работы с Yandex Cloud Desktop для пользователей](quickstart-users.md).

{% endnote %}

Cloud Desktop — сервис для управления виртуальной инфраструктурой рабочих столов.

Создайте [группу пользователей](../organization/concepts/groups.md) Yandex Identity Hub и разверните для нее [группу рабочих столов](concepts/desktops-and-groups.md) Cloud Desktop:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте группу пользователей](#create-user-group).
1. [Разверните группу рабочих столов](#create-desktop-group).
1. [Настройте ACL группы рабочих столов](#setup-acl).
1. [Создайте рабочий стол](#create-desktop).
1. [Получите данные для подключения](#get-credentials).
1. [Подключитесь к рабочему столу](#connect-desktop).

## Перед началом работы {#before-you-begin}

1. Войдите в [консоль управления](https://console.yandex.cloud) или зарегистрируйтесь. Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../resource-manager/operations/folder/create.md).
1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud _минимальные_ роли:
    * [organization-manager.admin](../organization/security/index.md#organization-manager-admin) на [облако](../resource-manager/concepts/resources-hierarchy.md#cloud) — для создания группы пользователей.
    * [vdi.admin](security/index.md#vdi-admin) на [каталог](../resource-manager/concepts/resources-hierarchy.md#folder) — для создания группы рабочих столов и назначения ей [ACL](concepts/acl.md).

    Если у вас примитивная роль [admin](../iam/roles-reference.md#admin) на каталог, назначать дополнительно роли не требуется.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

1. Чтобы рабочие столы имели доступ в интернет, для [подсетей](../vpc/concepts/network.md#subnet), в которых они будут размещены, [настройте](../vpc/operations/create-nat-gateway.md) NAT-шлюз.

## Создайте группу пользователей {#create-user-group}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.

  1. На панели слева выберите ![groups](../_assets/console-icons/persons.svg) **Группы**.

  1. В правом верхнем углу страницы нажмите ![Circles3Plus](../_assets/console-icons/circles-3-plus.svg) **Создать группу**.

  1. Задайте название и описание [группы](../organization/concepts/groups.md).

      Название должно быть уникальным в [организации](../overview/roles-and-resources.md) и соответствовать требованиям:

      * длина — от 1 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

  1. Нажмите кнопку **Создать группу**.

  1. На открывшейся странице перейдите на вкладку **Участники** и нажмите кнопку **Добавить участника**.

  1. В открывшемся окне выберите пользователей, для которых будет развернута группа рабочих столов.

  1. Нажмите **Сохранить**.

{% endlist %}

## Разверните группу рабочих столов {#create-desktop-group}

В этой инструкции вы создадите группу рабочих столов на базе предустановленной ОС `Ubuntu 20.04 LTS`. Также вы можете:

* [Создать образ на основе ВМ Linux Compute Cloud](operations/images/create-from-compute-linux.md)
* [Создать образ на основе Windows](operations/images/create-from-windows.md)

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором будет создана группа рабочих столов.
  1. Перейдите в сервис **Cloud Desktop**.
  1. Нажмите кнопку **Создать группу рабочих столов**.
  1. Введите имя группы рабочих столов.
  1. Выберите **Тип группы** — **Персональная**. Рабочие столы назначаются пользователям при их первом подключении и остаются зарезервированными за ними.
  1. В блоке **Рабочие столы** задайте:
     1. **Максимальный размер группы рабочих столов** — `2`, максимальное количество рабочих столов в группе.
     1. **Горячий резерв** — `1`, количество рабочих столов, которые будут всегда загружены для быстрого подключения пользователей.
  1. В блоке **Вычислительные ресурсы** на вкладке **Standard** выберите **Базовая**.
  1. Выберите [образ](concepts/images.md) операционной системы — `Ubuntu 20.04 LTS`.
  1. В блоке **Диски**:
      * Выберите [типы](../compute/concepts/disk.md#disks-types) загрузочного и рабочего [дисков](concepts/disks.md) — `SSD`.
      * Укажите размер загрузочного диска — `60 ГБ`.
      * Укажите размер рабочего диска — `4 ГБ`.
  1. В блоке **Сетевые настройки** выберите [облачную сеть](../vpc/concepts/network.md#network) и [подсети](../vpc/concepts/network.md#subnet), в которых будут размещаться рабочие столы.
  1. В блоке **Пользователи рабочих столов** нажмите **Добавить пользователей** и укажите, кому будут доступны рабочие столы:
     * [Группы пользователей](../iam/concepts/access-control/public-group.md).
     * [Отдельные пользователи](../iam/concepts/users/accounts.md).
     * Почтовый адрес любого пользователя — ему будет отправлено приглашение в вашу организацию и назначена роль для доступа к рабочим столам.
  1. Нажмите кнопку **Создать**.

{% endlist %}

## Настройте ACL группы рабочих столов {#setup-acl}

В Cloud Desktop управление доступом реализовано с помощью [разграничения ролей Yandex Identity and Access Management](security/index.md) и [списков управления доступом (ACL)](concepts/acl.md). [Пример использования механизмов доступа](concepts/acl.md#example).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В списке групп рабочих рабочих столов выберите созданную ранее группу.
  1. На панели слева выберите ![persons](../_assets/console-icons/persons.svg) **Права доступа**.
  1. Нажмите **Назначить роли**.
  1. В открывшемся окне **Выдача доступа** выберите группу пользователей, созданную ранее.
  1. Нажмите **Добавить роль** и укажите [роль](security/index.md#vdi-desktopGroups-user) `vdi.desktopGroups.user` или [роль](security/index.md#vdi-desktopGroups-maintainer) `vdi.desktopGroups.maintainer`.
  1. Нажмите кнопку **Сохранить**.

{% endlist %}

## Создайте рабочий стол {#create-desktop}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На панели слева выберите ![image](../_assets/console-icons/display.svg) **Рабочие столы**.
  1. Нажмите кнопку **Создать рабочий стол**.
  1. Выберите группу рабочих столов, созданную ранее.
  1. Укажите подсеть, в которой будет размещен рабочий стол.

      {% note info %}

      Чтобы рабочий стол имел доступ в интернет, в подсети должен быть [настроен NAT-шлюз](../vpc/operations/create-nat-gateway.md).

      {% endnote %}

  1. Укажите пользователя, для которого создается рабочий стол.
  1. Нажмите кнопку **Создать**.

{% endlist %}

## Получите данные для подключения {#get-credentials}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится рабочий стол.
  1. Перейдите в сервис **Cloud Desktop**.
  1. На панели слева выберите ![image](../_assets/console-icons/display.svg) **Рабочие столы**.
  1. Выберите рабочий стол, к которому хотите подключиться.
  1. В блоке **Пользователь рабочего стола** напротив пользовательского аккаунта нажмите ![image](../_assets/console-icons/ellipsis.svg) и выберите **Сбросить пароль**.
  1. Подтвердите сброс пароля.
  1. Сохраните новый пароль из всплывающего окна и закройте его.
  1. Справа сверху нажмите ![image](../_assets/console-icons/arrow-down-to-line.svg) **Загрузить RDP-файл**.

- Витрина пользовательских рабочих столов {#desktop-showcase}

  1. Откройте [Витрину пользовательских рабочих столов](https://console.yandex.cloud/showcase/cloud-desktop).
  1. Аутентифицируйтесь с помощью [Яндекс ID](https://yandex.ru/support/id/index.html) или через [систему единого входа (SSO)](../organization/concepts/add-federation.md).
  1. Если рабочий стол, к которому вы хотите подключиться, находится в статусе `Stopped`, запустите его — нажмите ![image](../_assets/console-icons/play.svg) и подтвердите запуск.
  
      Дождитесь перехода рабочего стола в статус `Active`.
  1. Нажмите ![image](../_assets/console-icons/lock-open.svg) и подтвердите сброс пароля.
  1. Сохраните новый пароль из всплывающего окна и закройте его.
  1. Нажмите ![image](../_assets/console-icons/arrow-down-to-line.svg) **Загрузить RDP-файл**.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../cli/index.md) для получения данных RDP-файла:

      ```bash
      yc desktops desktop get-rdp-file --help
      ```

  1. Получите список рабочих столов в каталоге по умолчанию:

      ```bash
      yc desktops desktop list
      ```

      Результат:

      ```bash
      +----------------------+------------------+--------+----------------------+---------------------+
      |          ID          |       NAME       | STATUS |   DESKTOP GROUP ID   |   CREATED (UTC-0)   |
      +----------------------+------------------+--------+----------------------+---------------------+
      | e3vmvhgbgac4******** | my-cloud-desktop | ACTIVE | e3v1rbln45tl******** | 2024-10-09 22:42:28 |
      | e3vio1bc5ppz******** | reserved-desktop | ACTIVE | e3v1rbln45tl******** | 2024-10-09 21:35:17 |
      +----------------------+------------------+--------+----------------------+---------------------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного рабочего стола, например `my-cloud-desktop`.
  1. [Сбросьте](operations/desktops/password-reset.md) пароль пользователя для рабочего стола.


  1. Запросите данные:

      ```bash
      yc desktops desktop get-rdp-file --name <имя_рабочего_стола>
      ```

      Результат:

      ```text
      full address:s:my-cloud-desktop
      gatewayhostname:s:rdg.vdi.cloud.yandex.net:3839
      gatewaycredentialssource:i:5
      gatewayusagemethod:i:1
      gatewayprofileusagemethod:i:1
      gatewayaccesstoken:s:ver=1;desktopUserToken=0174a9f2-...V6DQ
      networkautodetect:i:0
      bandwidthautodetect:i:1
      connection type:i:6
      username:s:.\alice-little
      domain:s:
      bitmapcachesize:i:32000
      smart sizing:i:1
      audiocapturemode:i:1
      audiomode:i:0
      authentication level:i:0
      ```

  1. Сохраните полученные данные в файле с расширением `.rdp`.

- API {#api}

  Воспользуйтесь методом REST API [getRdpFile](api-ref/Desktop/getRdpFile.md) для ресурса [Desktop](api-ref/Desktop/index.md) или вызовом gRPC API [DesktopService/GetRdpFile](api-ref/grpc/Desktop/getRdpFile.md).

  Чтобы сбросить пароль, воспользуйтесь методом REST API [resetPassword](api-ref/Desktop/resetPassword.md) для ресурса [Desktop](api-ref/Desktop/index.md) или вызовом gRPC API [DesktopService/ResetPassword](api-ref/grpc/Desktop/resetPassword.md).

{% endlist %}

## Подключитесь к рабочему столу {#connect-desktop}

Для подключения к рабочему столу используется [Remote Desktop Protocol](https://ru.wikipedia.org/wiki/Remote_Desktop_Protocol) (RDP).

{% note info %}

* Используйте пароль пользователя рабочего стола. Этот пароль не совпадает с паролем от аккаунта Яндекса. Если вы не знаете пароль, [получите новый](operations/desktops/password-reset.md).
* Логин подставляется из RDP‑файла автоматически. Если нужно ввести его вручную, укажите адрес почты без домена: `user`, а не `user@example.com`.

{% endnote %}

{% list tabs group=operating_system %}

- Windows {#windows}

  1. Правой кнопкой мыши нажмите на загруженный RDP-файл и выберите **Изменить** (в Windows 11 выберите **Показать дополнительные параметры** → **Изменить**).
  1. В окне **Подключение к удаленному рабочему столу** на вкладке **Общие** включите опцию **Разрешить мне сохранять учетные данные** и нажмите кнопку **Подключить**.
  1. В окне безопасности включите опцию **Больше не выводить запрос о подключениях к этому компьютеру** и нажмите кнопку **Подключить**.  
  1. Введите сохраненный ранее пароль, включите опцию **Запомнить меня** и нажмите кнопку **ОК**.
  
  Чтобы повторно подключиться к рабочему столу, запустите сохраненный RDP-файл.

- macOS {#macos}

  1. Установите и запустите [Microsoft Remote Desktop](https://itunes.apple.com/ru/app/microsoft-remote-desktop/id1295203466) — бесплатный официальный RDP-клиент для macOS.
  1. Откройте меню **Connections** и нажмите **Import from RDP file**.
  1. В открывшемся окне выберите загруженный RDP-файл и нажмите кнопку **Import**.
  1. Откройте меню **Microsoft Remote Desktop** и выберите **Settings**.
  1. В открывшемся окне перейдите на вкладку **User Accounts**.
  1. В списке аккаунтов слева выберите нужный аккаунт для подключения и вставьте сохраненный ранее пароль в поле **Password**. 
  1. Закройте окно настроек.
  1. На вкладке **PCs** запустите добавленный рабочий стол.
  1. В окне безопасности нажмите кнопку **Continue**.
  
  Чтобы повторно подключиться к рабочему столу, запустите его в приложении Microsoft Remote Desktop на вкладке **PCs**. В окне безопасности нажмите кнопку **Continue**.

  #### Полезные ссылки {#mac-see-also}

  [Начало работы с удаленным рабочим столом в macOS](https://docs.microsoft.com/ru-ru/windows-server/remote/remote-desktop-services/clients/remote-desktop-mac)

- Linux {#linux}

  1. Установите [Remmina](https://remmina.org) — бесплатный RDP-клиент для Linux, в терминале выполните команды:

      ```bash
      sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
      sudo apt-get update
      sudo apt-get install remmina remmina-plugin-rdp
      ```

  1. Запустите Remmina.
  1. В верхнем меню нажмите ![image](../_assets/console-icons/bars.svg) и выберите **Import**. Выберите загруженный RDP-файл и нажмите кнопку **Import**.
  1. Правой кнопкой мыши нажмите на добавленный рабочий стол и выберите **Edit**.
  1. В окне **Remote Connection Profile** задайте параметры подключения:

     * В поле **Username** удалите первые два символа: `.\`.
     * В поле **Password** введите сохраненный ранее пароль.
  1. Нажмите кнопку **Save and Connect**.

  Чтобы повторно подключиться к рабочему столу, запустите его в приложении Remmina.   

  #### Полезные ссылки {#lin-see-also}

  [Установка Remmina на дистрибутивы Linux, отличные от Ubuntu](https://remmina.org/how-to-install-remmina/)

{% endlist %}