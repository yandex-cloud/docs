# Подключиться к рабочему столу

Для подключения к [рабочему столу](../../concepts/desktops-and-groups.md) используется [Remote Desktop Protocol](https://ru.wikipedia.org/wiki/Remote_Desktop_Protocol) (RDP).

## Получите данные для подключения {#get-credentials}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится рабочий стол.
  1. Перейдите в сервис **Cloud Desktop**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/display.svg) **Рабочие столы**.
  1. Выберите рабочий стол, к которому хотите подключиться.
  1. В блоке **Пользователь рабочего стола** напротив пользовательского аккаунта нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Сбросить пароль**.
  1. Подтвердите сброс пароля.
  1. Сохраните новый пароль из всплывающего окна и закройте его.
  1. Справа сверху нажмите ![image](../../../_assets/console-icons/arrow-down-to-line.svg) **Загрузить RDP-файл**.

- Витрина пользовательских рабочих столов {#desktop-showcase}

  1. Откройте [Витрину пользовательских рабочих столов](https://console.yandex.cloud/showcase/cloud-desktop).
  1. Аутентифицируйтесь с помощью [Яндекс ID](https://yandex.ru/support/id/index.html) или через [систему единого входа (SSO)](../../../organization/concepts/add-federation.md).
  1. Если рабочий стол, к которому вы хотите подключиться, находится в статусе `Stopped`, запустите его — нажмите ![image](../../../_assets/console-icons/play.svg) и подтвердите запуск.
  
      Дождитесь перехода рабочего стола в статус `Active`.
  1. Нажмите ![image](../../../_assets/console-icons/lock-open.svg) и подтвердите сброс пароля.
  1. Сохраните новый пароль из всплывающего окна и закройте его.
  1. Нажмите ![image](../../../_assets/console-icons/arrow-down-to-line.svg) **Загрузить RDP-файл**.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../../cli/index.md) для получения данных RDP-файла:

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
  1. [Сбросьте](password-reset.md) пароль пользователя для рабочего стола.


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

  Воспользуйтесь методом REST API [getRdpFile](../../api-ref/Desktop/getRdpFile.md) для ресурса [Desktop](../../api-ref/Desktop/index.md) или вызовом gRPC API [DesktopService/GetRdpFile](../../api-ref/grpc/Desktop/getRdpFile.md).

  Чтобы сбросить пароль, воспользуйтесь методом REST API [resetPassword](../../api-ref/Desktop/resetPassword.md) для ресурса [Desktop](../../api-ref/Desktop/index.md) или вызовом gRPC API [DesktopService/ResetPassword](../../api-ref/grpc/Desktop/resetPassword.md).

{% endlist %}

## Подключитесь к рабочему столу {#connect-desktop}

{% note info %}

* Используйте пароль пользователя рабочего стола. Этот пароль не совпадает с паролем от аккаунта Яндекса. Если вы не знаете пароль, [получите новый](password-reset.md).
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
  1. В верхнем меню нажмите ![image](../../../_assets/console-icons/bars.svg) и выберите **Import**. Выберите загруженный RDP-файл и нажмите кнопку **Import**.
  1. Правой кнопкой мыши нажмите на добавленный рабочий стол и выберите **Edit**.
  1. В окне **Remote Connection Profile** задайте параметры подключения:

     * В поле **Username** удалите первые два символа: `.\`.
     * В поле **Password** введите сохраненный ранее пароль.
  1. Нажмите кнопку **Save and Connect**.

  Чтобы повторно подключиться к рабочему столу, запустите его в приложении Remmina.   

  #### Полезные ссылки {#lin-see-also}

  [Установка Remmina на дистрибутивы Linux, отличные от Ubuntu](https://remmina.org/how-to-install-remmina/)

{% endlist %}