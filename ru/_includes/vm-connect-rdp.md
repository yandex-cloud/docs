В образах всех версий и редакций операционной системы Windows, подготовленных для запуска в {{ yandex-cloud }}, включен Remote Desktop Protocol (RDP) с проверкой подлинности на уровне сети — Network Level Authentication (NLA). Перед подключением к виртуальной машине убедитесь, что NLA включен в настройках вашего компьютера. Когда ВМ будет запущена (в статусе `RUNNING`), вы сможете подключиться к ней по протоколу RDP.

[Группы безопасности](../vpc/concepts/security-groups.md) виртуальной машины должны разрешать входящий трафик по протоколу TCP на порт 3389.
  
  {% include [security-groups-note](../compute/_includes_service/security-groups-note.md) %}

Для подключения по протоколу RDP укажите публичный IP-адрес или FQDN ВМ. Доступ по FQDN возможен из другой ВМ {{ yandex-cloud }}, если она подключена к той же сети. IP-адрес и FQDN можно узнать в консоли управления, в блоке **Сеть** на странице ВМ.

Для подключения к ВМ:

{% list tabs %}

- Windows

  1. Нажмите **Пуск**.
  1. В поле поиска введите **Подключение к удаленному рабочему столу** и выберите соответствующий пункт.
  1. В окне **Подключение к удаленному рабочему столу** в поле **Компьютер** введите публичный IP-адрес ВМ, к которой необходимо подключиться.
  1. Нажмите кнопку **Подключиться**.
  1. Укажите параметры учетной записи:
     * **Имя пользователя** `Administrator`.
     * **Пароль**, который вы задали при создании ВМ.
  1. Нажмите кнопку **ОК**.

  {% include [initialization-windows-vm](initialization-windows-vm.md) %}

  #### См. также

  * [Подключение к удаленному рабочему столу](https://support.microsoft.com/ru-ru/help/17463/windows-7-connect-to-another-computer-remote-desktop-connection).

- macOS

  1. Установите и запустите [Microsoft Remote Desktop](https://itunes.apple.com/ru/app/microsoft-remote-desktop/id1295203466) (бесплатный официальный RDP-клиент для Mac).
  1. Нажмите ![image](../_assets/plus.svg) → **Desktop**.
  1. В диалоговом окне **Add Desktop** в поле **PC Name** введите публичный IP-адрес виртуальной машины, к которой необходимо подключиться.
  1. В поле **User Account** выберите **Add User Account**.
  1. В диалоговом окне **Add User Account** укажите параметры учетной записи:
     * **User Name** `Administrator`.
     * **Password** пароль, который вы задали при создании виртуальной машины.
  1. Дважды нажмите кнопку **Save**.
  1. Подключитесь к удаленной машине двойным нажатием на созданное подключение в главном окне Microsoft Remote Desktop.

  #### См. также

  * [Начало работы с удаленного рабочего стола в Mac](https://docs.microsoft.com/ru-ru/windows-server/remote/remote-desktop-services/clients/remote-desktop-mac).

- Linux

  1. Установите Remmina (бесплатный RDP-клиент для Linux) с помощью команд:

     ```bash
     sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
     ```

     ```bash
     sudo apt-get update
     ```

     ```bash
     sudo apt-get install remmina remmina-plugin-rdp
     ```

  1. Запустите Remmina.
  1. Нажмите значок ![image](../_assets/plus.svg).
  1. В блоке **Profile** укажите следующие данные:
     * **Name**: произвольное имя подключения.
     * **Protocol**: **RDP - Remote Desktop Protocol**.
  1. На вкладке **Basic** укажите данные для подключения и авторизации:
     * **Server**: публичный IP-адрес виртуальной машины, к которой необходимо подключиться.
     * **User Name**: `Administrator`.
     * **Password**: пароль, который вы задали при создании виртуальной машины.
  1. Нажмите кнопку **Save**.
  1. Подключитесь к удаленной машине двойным нажатием на созданное подключение в списке подключений для быстрого доступа.

  #### См. также

  * [Установка Remmina на дистрибутивы Linux отличные от Ubuntu](https://remmina.org/how-to-install-remmina/).

{% endlist %}