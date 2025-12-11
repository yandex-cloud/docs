# Создание виртуальной машины и подключение к ней

После завершения настройки платежного аккаунта вы сможете начать работу с сервисами {{ yandex-cloud }}, например создать [виртуальную машину (ВМ)](../../compute/concepts/vm.md) в сервисе [{{ compute-full-name }}](../../compute/concepts/index.md).

## Создайте виртуальную машину {#create-vm}

1. Перейдите в [консоль управления]({{ link-console-main }}) и на панели слева нажмите на аватар вашего аккаунта.
1. Выберите организацию `Example organization`.
1. На панели слева выберите каталог `default`.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.group.switch_instances }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}** и задайте настройки ВМ:

   1. Выберите **Простая настройка**.
   1. В блоке **Операционные системы и продукты** выберите **Ubuntu 24.04 LTS**.
   1. В блоке **Вычислительные ресурсы** задайте конфигурацию вычислительных ресурсов для ВМ.
   1. В блоке **Диски** задайте размер и тип диска.
   1. Задайте **Имя ВМ**.
   1. Задайте **Логин** администратора ВМ.
   1. В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**. В открывшемся окне:
      1. Задайте **Имя** SSH-ключа.
      1. В блоке **SSH-ключ** выберите **Сгенерировать ключ**.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

         SSH-ключ будет загружен на ваш компьютер, а также добавлен в ваш профиль пользователя организации.

         Если в организации отключена возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя создаваемой виртуальной машины.

1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

## Настройте группу безопасности для подключения к ВМ {#security-group}

*Группа безопасности* (Security Group, SG) — это ресурс, который создается на уровне [облачной сети](../../vpc/concepts/network.md#network). После создания группа безопасности может использоваться в сервисах {{ yandex-cloud }} для разграничения сетевого доступа объекта, к которому она применяется.

Созданной вами ВМ была присвоена группа безопасности по умолчанию. Чтобы разрешить подключение к ВМ по SSH, создайте в этой группе безопасности правило, разрешающее входящий трафик по протоколу TCP на порт 22:

1. Перейдите в [консоль управления]({{ link-console-main }}).
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** и откройте созданную ранее ВМ.
1. На странице с информацией о ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** откройте группу безопасности, присвоенную ВМ.
1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.
1. Откройте вкладку **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}** и нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
1. В открывшемся окне задайте следующие параметры:
   1. **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `22`.
   1. **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `TCP`.
   1. **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
   1. **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`
   1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**. Если требуется, добавьте другие правила.
1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

## Подключение к ВМ {#vm-connect}

Вы можете подключиться к ВМ в статусе `RUNNING` по протоколу SSH. Для инициализации всех служб после [запуска](../../compute/operations/vm-control/vm-stop-and-start.md#start) ВМ может потребоваться время. Если возникла ошибка соединения, попробуйте снова через несколько минут.

Для подключения необходимо указать [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) ВМ. Публичный IP-адрес можно узнать в консоли управления, в поле **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** блока **{{ ui-key.yacloud.compute.instance.overview.section_network }}** на странице ВМ. Если вы создали ВМ только с внутренним IP-адресом, [привяжите к ней публичный IP-адрес](../../compute/operations/vm-control/vm-attach-public-ip.md).

Также можно использовать [внутренние IP-адреса](../../vpc/concepts/address.md#internal-addresses) и [FQDN](../../vpc/concepts/address.md#fqdn) для установки SSH-соединения между ВМ внутри одной [облачной сети](../../vpc/concepts/network.md#network) {{ yandex-cloud }}.

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  В терминале выполните команду:

  ```bash
  ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
  ```

  Где `<имя_пользователя>` — имя учетной записи пользователя ВМ. Если ВМ создавалась через CLI, то пользователь по умолчанию — `yc-user`.

  Если у вас несколько закрытых ключей, укажите нужный:

  ```bash
  ssh -i <путь_к_ключу/имя_файла_ключа> <имя_пользователя>@<публичный_IP-адрес_ВМ>
  ```

  При первом подключении к ВМ появится предупреждение о неизвестном хосте:

  ```text
  The authenticity of host '51.250.83.243 (51.250.83.243)' can't be established.
  ED25519 key fingerprint is SHA256:6Mjv93NJDCaf/vu3NYwiLQK4tKI+4cfLtkd********.
  This key is not known by any other names.
  Are you sure you want to continue connecting (yes/no/[fingerprint])?
  ```

  Введите в терминале слово `yes` и нажмите **Enter**.

- Windows 10/11 {#windows}

  Убедитесь, что учетная запись Windows обладает правами на чтение файлов в папке с ключами.

  Для подключения к ВМ в командной строке выполните команду:

  ```shell
  ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
  ```

  Где `<имя_пользователя>` — имя учетной записи пользователя ВМ. Если ВМ создавалась через CLI, то пользователь по умолчанию — `yc-user`.

  Если у вас несколько закрытых ключей, укажите нужный:

  ```shell
  ssh -i <путь_к_ключу\имя_файла_ключа> <имя_пользователя>@<публичный_IP-адрес_ВМ>
  ```

  При первом подключении к ВМ появится предупреждение о неизвестном хосте:

  ```text
  The authenticity of host '89.169.132.223 (89.169.132.223)' can't be established.
  ECDSA key fingerprint is SHA256:DfjfFB+in0q0MGi0HnqLNMdHssLfm1yRanB********.
  Are you sure you want to continue connecting (yes/no/[fingerprint])?
  ```

  Введите в командной строке `yes` и нажмите **Enter**.

- Windows 7/8 {#windows7-8}

  Установите соединение с помощью приложения PuTTY:
  1. Запустите приложение Pageant.
     1. Нажмите правой кнопкой мыши на значок Pageant на панели задач.
     1. В контекстном меню выберите пункт **Add key**.
     1. Выберите сгенерированный PuTTY приватный ключ в формате `.ppk`. Если для ключа задан пароль, введите его.
  1. Запустите приложение PuTTY.
     1. В поле **Host Name (or IP address)** введите публичный IP-адрес ВМ, к которой вы хотите подключиться. Укажите порт `22` и тип соединения **SSH**.

        ![ssh_add_ip](../../_assets/compute/ssh-putty/ssh_add_ip.png)

     1. Откройте в дереве слева пункт **Connection** → **SSH** → **Auth**.
     1. Установите флаг **Allow agent forwarding**.

        ![ssh_choose_private_key](../../_assets/compute/ssh-putty/authentication_parameters.png)

     1. Откройте в дереве слева пункт **Connection** → **SSH** → **Auth** → **Credentials**.

     1. В поле **Private key file for authentication** выберите файл с приватным ключом.

        ![ssh_choose_private_key](../../_assets/compute/ssh-putty/ssh_choose_private_key.png)

     1. Вернитесь в меню **Sessions**. В поле **Saved sessions** введите любое название для сессии и нажмите кнопку **Save**. Настройки сессии сохранятся под указанным именем. Вы сможете использовать этот профиль сессии для подключения с помощью Pageant.

        ![ssh_save_session](../../_assets/compute/ssh-putty/ssh_save_session.png)

     1. Нажмите кнопку **Open**. Если вы подключаетесь к ВМ в первый раз, может появиться предупреждение о неизвестном хосте:

        ![ssh_unknown_host_warning](../../_assets/compute/ssh-putty/ssh_unknown_host_warning.png)

        Нажмите кнопку **Accept**. Откроется окно терминала с предложением ввести логин пользователя, от имени которого устанавливается соединение. Введите имя пользователя, которое вы указали при создании ВМ, и нажмите **Enter**. Если ВМ создавалась через CLI, то пользователь по умолчанию — `yc-user`.

        Если все настроено верно, будет установлено соединение с сервером.

        ![ssh_login](../../_assets/compute/ssh-putty/ssh_login.png)

  Если вы сохранили профиль сессии в PuTTY, в дальнейшем для установки соединения можно использовать Pageant:
  1. Нажмите правой кнопкой мыши на значок Pageant на панели задач.
  1. Выберите пункт меню **Saved sessions**.
  1. В списке сохраненных сессий выберите нужную сессию.

{% endlist %}

О решении проблем при подключении читайте в разделе [Вопросы и ответы](../../compute/qa/connection.md).
