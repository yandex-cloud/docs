# Как начать работать с {{ baremetal-full-name }}

Арендуйте свой первый [физический сервер](concepts/servers.md) и подключитесь к нему. Все ресурсы арендованного сервера выделяются только вам и могут обеспечить лучшую производительность, чем аналогичная [виртуальная машина](../glossary/vm.md).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md) и [привяжите](../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../resource-manager/concepts/resources-hierarchy.md).

## Арендуйте сервер {#server-lease}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите арендовать сервер.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-server }}** и в открывшемся окне выберите вариант `{{ ui-key.yacloud_components.baremetal.StockConfigurations }}` и подходящую [конфигурацию](concepts/server-configurations.md) сервера {{ baremetal-name }}. Например: `BA-i103-S-10G`.

      Чтобы выбрать подходящую вам конфигурацию сервера, нажмите на блок с именем этой конфигурации в центральной части экрана.
      
      {% note info %}
      
      Чтобы быстрее подобрать подходящую конфигурацию, вы можете воспользоваться фильтром с аппаратными характеристиками конфигураций в правой части экрана.
      
      {% endnote %}

      {% note tip %}
      
      Вы можете снизить стоимость аренды сервера в некоторых конфигурациях, заказав его [сборку](concepts/server-custom-configurations.md#assembly).
      
      Чтобы воспользоваться скидкой, в блоке с нужной конфигурацией наведите курсор на **{{ ui-key.yacloud_components.baremetal.assemblyDiscountLabel }}** ![circle-info.svg](../_assets/console-icons/circle-info.svg) и во всплывающем окне нажмите ![person-nut-hex.svg](../_assets/console-icons/person-nut-hex.svg) **{{ ui-key.yacloud_components.baremetal.goToAssembly }}**.
      
      При заказе сервера со сборкой воспользуйтесь приведенной ниже инструкцией, чтобы задать необходимые параметры сервера. При этом сервер станет доступен вам не сразу, а после завершения сборки (в течение четырех календарных дней) и по более низкой цене.
      
      {% endnote %}

  1. В открывшемся окне с настройками конфигурации сервера:

      1. В блоках **{{ ui-key.yacloud.baremetal.title_section-server-config }}**, **{{ ui-key.yacloud.baremetal.title_section-location }}** и **{{ ui-key.yacloud.baremetal.title_section-lease-conditions }}** убедитесь, что параметры выбранной конфигурации сервера соответствуют вашим потребностям.
         
         Если выбранные параметры вам не подходят, нажмите значок ![arrow-left](../_assets/console-icons/arrow-left.svg) в блоке **{{ ui-key.yacloud.baremetal.title_section-server-config }}**, чтобы вернуться к выбору конфигурации.
      1. В поле **{{ ui-key.yacloud.baremetal.field_server-lease-duration }}** выберите [период](concepts/servers.md#server-lease), на который вы будете арендовать сервер.

          {% note tip %}

          Для первоначального тестирования достаточно арендовать сервер сроком на 1 день или 1 месяц. Если этого времени окажется недостаточно, аренда сервера будет автоматически продлена на следующий период той же продолжительности.

          {% endnote %}
      1. В поле **{{ ui-key.yacloud.baremetal.field_server-count_jPgTg }}** оставьте `1`.
      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-product }}** выберите вариант `{{ ui-key.yacloud.baremetal.field_choose-marketplace-os }}` и образ с операционной системой `Ubuntu 24.04 LTS`.
      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-disk }}** нажмите кнопку **{{ ui-key.yacloud.baremetal.action_disk-layout-settings }}**, чтобы задать конфигурацию разделов [дисковых устройств](concepts/disks/disk-types.md), имеющихся на сервере.

          В открывшемся окне оставьте параметры разметки дисков по умолчанию или измените их, затем нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-network-interfaces }}** в разделе **Интерфейс 1** выберите [приватную подсеть](concepts/private-network.md#private-subnet) в той [зоне доступности](../overview/concepts/geo-scope.md), в которой вы арендуете сервер.
         
         Если в зоне доступности арендуемого сервера еще нет приватной подсети или вы хотите создать новую приватную подсеть, нажмите кнопку **{{ ui-key.yacloud.common.create }}** и в открывшемся окне задайте параметры подсети по инструкции [{#T}](operations/subnet-create.md).
      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-network-interfaces }}** в разделе **Интерфейс 2** в поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** выберите `{{ ui-key.yacloud.baremetal.label_public-ip-ephemeral }}`.
      1. В блоке **{{ ui-key.yacloud.baremetal.title_server-access }}**:

          1. В поле **{{ ui-key.yacloud.baremetal.field_password }}** воспользуйтесь одним из вариантов создания пароля для root-пользователя:
          
              * Чтобы сгенерировать пароль для root-пользователя, выберите опцию `{{ ui-key.yacloud.baremetal.label_password-plain }}` и нажмите кнопку **{{ ui-key.yacloud.component.password-input.label_button-generate }}**.
          
                  {% note warning %}
                  
                  Этот вариант предусматривает ответственность пользователя за безопасность пароля. Сохраните сгенерированный пароль в надежном месте: он не сохраняется в {{ yandex-cloud }}, и после заказа сервера вы не сможете посмотреть его.
                  
                  {% endnote %}
          
              * Чтобы использовать пароль root-пользователя, сохраненный в [секрете](../lockbox/concepts/secret.md) {{ lockbox-full-name }}, выберите опцию `{{ ui-key.yacloud.baremetal.label_password-lockbox }}`:
          
                  В полях **{{ ui-key.yacloud.baremetal.label_lockbox-name }}**, **{{ ui-key.yacloud.baremetal.label_lockbox-version }}** и **{{ ui-key.yacloud.baremetal.label_lockbox-key }}** выберите соответственно секрет, его версию и ключ, в которых сохранен ваш пароль.
                  
                  Если у вас еще нет секрета {{ lockbox-name }}, нажмите кнопку **{{ ui-key.yacloud.common.create }}**, чтобы создать его.
          
                  Этот вариант позволяет вам как задать собственный пароль (тип секрета `{{ ui-key.yacloud.lockbox.FormFields.title_secret-type-custom }}`), так и использовать пароль, сгенерированный автоматически (тип секрета `{{ ui-key.yacloud.lockbox.FormFields.title_secret-type-generated }}`).
          
          1. В поле **{{ ui-key.yacloud.baremetal.field_ssh-public-key }}** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../organization/concepts/membership.md).
          
              Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
              
              1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
              1. Задайте имя SSH-ключа.
              1. Выберите вариант:
              
                  * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-manual }}` — вставьте содержимое открытого [SSH](../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
                  * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-upload }}` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
                  * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-generate }}` — автоматическое создание пары SSH-ключей.
                  
                    При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
              
              1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
              
              SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-info }}** введите **{{ ui-key.yacloud.baremetal.field_name }}** сервера — `bm-server`.
      1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-server }}**.

{% endlist %}

## Подключитесь к серверу {#server-connect}

{% list tabs group=operating_system %}

- KVM-консоль {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит сервер.
  1. Перейдите в сервис **{{ baremetal-name }}**.
  1. В строке с нужным сервером нажмите значок ![image](../_assets/console-icons/ellipsis.svg) и выберите **KVM-консоль**.

- Linux/macOS {#linux-macos}

  Для подключения к серверу необходимо указать его публичный IP-адрес, который можно узнать в консоли управления, в поле **{{ ui-key.yacloud.baremetal.field_server-public-ip }}** блока **{{ ui-key.yacloud.baremetal.title_section-network-interfaces }}** на странице сервера.

  В терминале выполните команду:

  ```bash
  ssh root@<публичный_IP-адрес_сервера>
  ```

  При первом подключении к серверу появится предупреждение о неизвестном хосте:

  ```text
  The authenticity of host '51.250.83.243 (51.250.83.243)' can't be established.
  ED25519 key fingerprint is SHA256:6Mjv93NJDCaf/vu3NYwiLQK4tKI+4cfLtkd********.
  This key is not known by any other names.
  Are you sure you want to continue connecting (yes/no/[fingerprint])?
  ```

  Введите в терминале слово `yes` и нажмите **Enter**.

- Windows 10/11 {#windows}

  Для подключения к серверу необходимо указать его публичный IP-адрес, который можно узнать в консоли управления, в поле **{{ ui-key.yacloud.baremetal.field_server-public-ip }}** блока **{{ ui-key.yacloud.baremetal.title_section-network-interfaces }}** на странице сервера.

  Убедитесь, что учетная запись Windows обладает правами на чтение файлов в папке с ключами.

  Для подключения к серверу в командной строке выполните команду:

  ```shell
  ssh root@<публичный_IP-адрес_сервера>
  ```

  При первом подключении к серверу появится предупреждение о неизвестном хосте:

  ```text
  The authenticity of host '89.169.132.223 (89.169.132.223)' can't be established.
  ECDSA key fingerprint is SHA256:DfjfFB+in0q0MGi0HnqLNMdHssLfm1yRanB********.
  Are you sure you want to continue connecting (yes/no/[fingerprint])?
  ```

  Введите в командной строке `yes` и нажмите **Enter**.

- Windows 7/8 {#windows7-8}

  Для подключения к серверу необходимо указать его публичный IP-адрес, который можно узнать в консоли управления, в поле **{{ ui-key.yacloud.baremetal.field_server-public-ip }}** блока **{{ ui-key.yacloud.baremetal.title_section-network-interfaces }}** на странице сервера.

  Установите соединение с помощью приложения PuTTY:

  1. Запустите приложение Pageant.
     1. Нажмите правой кнопкой мыши на значок Pageant на панели задач.
     1. В контекстном меню выберите пункт **Add key**.
     1. Выберите сгенерированный PuTTY приватный ключ в формате `.ppk`. Если для ключа задан пароль, введите его.
  1. Запустите приложение PuTTY.
     1. В поле **Host Name (or IP address)** введите публичный IP-адрес сервера, к которому вы хотите подключиться. Укажите порт `22` и тип соединения **SSH**.

        ![ssh_add_ip](../_assets/compute/ssh-putty/ssh_add_ip.png)

     1. Откройте в дереве слева пункт **Connection** → **SSH** → **Auth**.
     1. Установите флаг **Allow agent forwarding**.

        ![ssh_choose_private_key](../_assets/compute/ssh-putty/authentication_parameters.png)

     1. Откройте в дереве слева пункт **Connection** → **SSH** → **Auth** → **Credentials**.
     1. В поле **Private key file for authentication** выберите файл с приватным ключом.

        ![ssh_choose_private_key](../_assets/compute/ssh-putty/ssh_choose_private_key.png)

     1. Вернитесь в меню **Sessions**. В поле **Saved sessions** введите любое название для сессии и нажмите кнопку **Save**. Настройки сессии сохранятся под указанным именем. Вы сможете использовать этот профиль сессии для подключения с помощью Pageant.

        ![ssh_save_session](../_assets/compute/ssh-putty/ssh_save_session.png)

     1. Нажмите кнопку **Open**. Если вы подключаетесь к серверу в первый раз, может появиться предупреждение о неизвестном хосте:

        ![ssh_unknown_host_warning](../_assets/compute/ssh-putty/ssh_unknown_host_warning.png)

        Нажмите кнопку **Accept**. Откроется окно терминала с предложением ввести логин пользователя, от имени которого устанавливается соединение. Введите имя пользователя `root`.

        Если все настроено верно, будет установлено соединение с сервером.

        ![ssh_login](../_assets/compute/ssh-putty/ssh_login.png)

  Если вы сохранили профиль сессии в PuTTY, в дальнейшем для установки соединения можно использовать Pageant:

  1. Нажмите правой кнопкой мыши на значок Pageant на панели задач.
  1. Выберите пункт меню **Saved sessions**.
  1. В списке сохраненных сессий выберите нужную сессию.

{% endlist %}