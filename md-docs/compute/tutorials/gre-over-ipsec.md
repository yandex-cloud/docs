[Документация Yandex Cloud](../../index.md) > [Yandex Compute Cloud](../index.md) > [Практические руководства](index.md) > Настройка защищенного туннеля GRE поверх IPsec

# Настройка защищенного туннеля GRE поверх IPsec


Для безопасного взаимодействия удаленных ресурсов между собой и передачи данных через открытые каналы связи (например через интернет) применяются технологии организации защищенных соединений, такие как протокол [IPsec](https://www.ietf.org/rfc/rfc2401.txt). Однако, IPsec имеет существенные ограничения — он предназначен для передачи только IP-пакетов, а также не поддерживает многоадресный трафик ([мультикаст-трансляцию](https://en.wikipedia.org/wiki/IP_multicast)) и комбинирование с другими протоколами в рамках одного запроса.

Чтобы расширить возможности протокола IPsec, используется протокол [GRE](https://ru.wikipedia.org/wiki/GRE_(протокол)), настроенный поверх IPsec. Протокол GRE инкапсулирует сетевые пакеты в IP-пакеты, что позволяет передавать по IPsec-протоколу любой трафик.

В этом примере вы создадите защищенный туннель по протоколу GRE поверх IPsec между двумя виртуальными маршрутизаторами [Cisco CSR 1000v](https://yandex.cloud/ru/marketplace/products/yc/cisco-csr), расположенными в Yandex Cloud в разных [виртуальных сетях](../../vpc/concepts/network.md) и [зонах доступности](../../overview/concepts/geo-scope.md). 

Поскольку Yandex Cloud использует [NAT](https://ru.wikipedia.org/wiki/NAT), а GRE-протокол не предусматривает использование портов, настройка IPSEC приводится в режиме NAT-T ([NAT Traversal](https://ru.wikipedia.org/wiki/NAT_traversal)). Этот режим обеспечивает возможность трансляции адресов маршрутизаторов через NAT при использовании туннеля GRE поверх IPsec. Благодаря этому описанная в примере настройка туннеля подходит как для облачной инфраструктуры в Yandex Cloud, так и для удаленных ресурсов, находящихся за устройством, которое осуществляет NAT-трансляцию. 

Чтобы настроить защищенный туннель между двумя виртуальными маршрутизаторами:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте пару ключей SSH](#create-ssh-keys).
1. [Создайте каталоги](#create-folders).
1. [Создайте две виртуальные машины с Cisco Cloud Services Router](#create-routers).
1. [Настройте IPsec-протоколы](#ipsec-setup).
1. [Создайте туннельные интерфейсы](#create-interfaces).
1. [Настройте маршрутизацию](#setup-routers).
1. [Проверьте работу туннеля](#check-tunnel).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

{% note alert %}

Пропускная способность роутера при использовании образа Cisco CSR 1000v без лицензии ограничена 100 Кбит/с. Чтобы снять ограничение, [установите лицензию](https://www.cisco.com/c/en/us/td/docs/routers/csr1000/software/configuration/b_CSR1000v_Configuration_Guide/b_CSR1000v_Configuration_Guide_chapter_01000.html).

{% endnote %}

В стоимость поддержки инфраструктуры входит:

* плата за диски и постоянно запущенные ВМ ([тарифы Yandex Compute Cloud](../pricing.md));
* плата за использование внешнего IP-адреса ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).

## Создайте пару ключей SSH {#create-ssh-keys}

Чтобы подключаться к [виртуальной машине](../concepts/vm.md) по [SSH](../../glossary/ssh-keygen.md), нужна пара ключей: открытый ключ размещается на ВМ, а закрытый ключ хранится у пользователя. Такой способ более безопасен, чем подключение по логину и паролю.

{% note info %}

В публичных образах Linux, предоставляемых Yandex Cloud, возможность подключения по протоколу SSH с использованием логина и пароля по умолчанию отключена.

{% endnote %}

Роутер Cisco Cloud Services Router (CSR) 1000v поддерживает только ключи, сгенерированные по алгоритму RSA.

Чтобы создать пару ключей:

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  1. Откройте терминал.
  1. Создайте новый ключ с помощью команды `ssh-keygen`:

     ```bash
     ssh-keygen -t rsa -b 2048
     ```

     После выполнения команды вам будет предложено указать имена файлов, в которые будут сохранены ключи, и ввести пароль для закрытого ключа. По умолчанию используется имя `id_rsa`, ключи создаются в директории `~/.ssh`.

     Публичная часть ключа будет сохранена в файле `<имя_ключа>.pub`.

- Windows 10/11 {#windows}

  1. Запустите `cmd.exe` или `powershell.exe`.
  1. Создайте новый ключ с помощью команды `ssh-keygen`:

     ```shell
     ssh-keygen -t rsa -b 2048
     ```

     После выполнения команды вам будет предложено указать имена файлов, в которые будут сохранены ключи, и ввести пароль для закрытого ключа. По умолчанию используется имя `id_rsa`. Ключи создаются в директории `C:\Users\<имя_пользователя>\.ssh\` или `C:\Users\<имя_пользователя>\` в зависимости от интерфейса командной строки.

     Публичная часть ключа будет сохранена в файле с названием `<имя_ключа>.pub`.

- Windows 7/8 {#windows7-8}

  Создайте ключи с помощью приложения PuTTY:
  1. [Скачайте](https://www.putty.org) и установите PuTTY.
  1. Добавьте папку с PuTTY в переменную `PATH`:

      1. Нажмите кнопку **Пуск** и в строке поиска Windows введите **Изменение системных переменных среды**.
      1. Справа снизу нажмите кнопку **Переменные среды...**.
      1. В открывшемся окне найдите параметр `PATH` и нажмите **Изменить**.
      1. Добавьте путь к папке в список.
      1. Нажмите кнопку **ОК**.

  1. Запустите приложение PuTTYgen.
  1. В качестве типа генерируемой пары выберите **RSA** и укажите длину 2048. Нажмите **Generate** и поводите курсором в поле выше до тех пор, пока не закончится создание ключа.

     ![ssh_generate_key](../../_assets/compute/ssh-putty/ssh-generate-key-rsa.png)

  1. В поле **Key passphrase** введите надежный пароль. Повторно введите его в поле ниже.
  1. Нажмите кнопку **Save private key** и сохраните закрытый ключ. Никому не сообщайте ключевую фразу от него.
  1. Сохраните ключ в текстовом файле. Для этого скопируйте открытый ключ из текстового поля в текстовый файл с названием `id_rsa.pub`. Обратите внимание, что ключ должен быть записан **одной строкой** (не должно быть переносов и разрывов строки).

{% endlist %}

{% note warning %}

Надежно сохраните закрытый ключ: без него подключиться к виртуальной машине будет невозможно.

{% endnote %}

## Создайте каталоги {#create-folders}

Для тестирования туннелирования между двумя разными виртуальными сетями расположите ресурсы в Yandex Cloud в разных каталогах. Чтобы создать новый каталог:

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и справа сверху нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/plus.svg) **Создать каталог**.
   1. Введите имя [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder): `site-d`.
   1. При желании, добавьте описание каталога.
   1. Выберите опцию **Создать сеть по умолчанию**. 
   1. Нажмите кнопку **Создать**.

- CLI {#cli}

   Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   Создайте каталог:
   ```bash
   yc resource-manager folder create \
   --name site-d \
   --description "Folder for site-d"
   ```

- API {#api}

   Чтобы создать каталог, воспользуйтесь методом REST API [create](../../resource-manager/api-ref/Folder/create.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/Create](../../resource-manager/api-ref/grpc/Folder/create.md).

- Terraform {#tf}

   Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   
   
   Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

   1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_resourcemanager_folder" "folder1" {
         cloud_id    = "<идентификатор облака>"
         name        = "site-d"
         description = "Folder for site-d"
      }
      ```

      Подробнее о параметрах ресурса `yandex_resourcemanager_folder` в Terraform смотрите в [документации провайдера](../../terraform/resources/resourcemanager_folder.md).

   1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в папку, где вы создали конфигурационный файл.

      1. Проверьте конфигурацию командой:

         ```
         terraform validate
         ```
     
         Если конфигурация является корректной, появится сообщение:
     
         ```
         Success! The configuration is valid.
         ```

      1. Выполните команду:

         ```
         terraform plan
         ```

         Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 

   1. Разверните облачные ресурсы.

      1. Если в конфигурации нет ошибок, выполните команду:

         ```
         terraform apply
         ```

      1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

      После этого в указанном облаке будет создан каталог. Проверить появление каталога и его настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

      ```
      yc resource-manager cloud list
      ```

{% endlist %}

Аналогично создайте второй каталог с именем `site-b`.

## Создайте две виртуальные машины с Cisco Cloud Services Router {#create-routers}

### Создайте первую ВМ с Cisco Cloud Services Router {#create-first-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `site-d`.
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Создать ресурс** и выберите ![image](../../_assets/console-icons/cpu.svg) **Виртуальная машина**.
  1. В блоке **Образ загрузочного диска** в поле **Поиск продукта** введите `Cisco CSR` и выберите публичный образ [Cisco CSR](https://yandex.cloud/ru/marketplace/products/yc/cisco-csr).
  1. В блоке **Расположение** выберите [зону доступности](../../overview/concepts/geo-scope.md) `ru-central1-d`.
  1. В блоке **Вычислительные ресурсы** перейдите на вкладку `Своя конфигурация` и укажите необходимую [платформу](../concepts/vm-platforms.md), количество vCPU и объем RAM:

      * **Платформа** — `Intel Ice Lake`.
      * **vCPU** — `2`.
      * **Гарантированная доля vCPU** — `100%`.
      * **RAM** — `4 ГБ`.

  1. В блоке **Сетевые настройки**:

      * В поле **Подсеть** выберите сеть и подсеть, к которым нужно подключить ВМ.
      * В поле **Публичный IP-адрес** оставьте значение `Автоматически`, чтобы назначить ВМ случайный внешний IP-адрес из пула Yandex Cloud, или выберите статический адрес из списка, если вы зарезервировали его заранее.

  1. В блоке **Доступ** выберите вариант **SSH-ключ** и укажите данные для доступа на ВМ:

      * В поле **Логин** введите имя пользователя. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
      * В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).
        
        Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
        
        1. Нажмите кнопку **Добавить ключ**.
        1. Задайте имя SSH-ключа.
        1. Выберите вариант:
        
            * `Ввести вручную` — вставьте содержимое открытого [SSH](../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
            * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
            * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
            
              При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
        
        1. Нажмите кнопку **Добавить**.
        
        SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

  1. В блоке **Общая информация** задайте имя ВМ: `cisco-router-d`.
  1. В блоке **Дополнительно** включите опцию `Доступ к серийной консоли`.
  1. Нажмите кнопку **Создать ВМ**.

  Создание ВМ может занять несколько минут. Когда ВМ перейдет в статус `RUNNING`, вы сможете пользоваться серийной консолью.

{% endlist %}

### Задайте роутеру имя хоста {#hostname}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
   1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог с созданной ВМ.
   1. Перейдите в сервис **Compute Cloud**.
   1. В списке ВМ выберите `cisco-router-d`.
   1. Перейдите на вкладку ![image](../../_assets/console-icons/terminal.svg) **Серийная консоль** и нажмите кнопку **Подключиться**.
   1. Дождитесь полной загрузки операционной системы.
   1. Чтобы перейти в привилегированный режим, выполните в серийной консоли команду:

      ```bash
      enable
      ```

   1. Перейдите в режим конфигурирования и задайте роутеру имя хоста:

      ```bash
      conf t
      hostname cisco-router
      ```

      Имя роутера в начале командной строки должно измениться на `cisco-router`.

{% endlist %}

### Создайте пользователя с правами администратора {#create-user}

Создайте пользователя с правами администратора без возможности входа по паролю:

{% list tabs group=instructions %}

- Консоль управления {#console}

   В серийной консоли выполните команду:

   ```bash
   username test-user privilege 15
   ```

{% endlist %}

### Подготовьте ключ {#split-ssh}

Если ваш публичный SSH-ключ длиннее 72 символов, разбейте ключ на части по 72 символа:

1. На своем компьютере в терминале выполните команду:

   ```bash
   fold -bw 72 <путь_к_файлу_с_публичным_ключом>
   ```

   В результате будет выведен публичный SSH-ключ, разбитый на строки по 72 символа.

1. Сохраните хэш ключа:

   ```bash
   ssh-keygen -E md5 -lf <путь_к_файлу_с_публичным_ключом>
   ```


### Настройте аутентификацию с помощью SSH-ключей {#enable-ssh}


{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В серийной консоли включите доступ на ВМ по SSH:

      ```bash
      conf t
      aaa new-model
         ip ssh server algorithm authentication publickey 
         ip ssh pubkey-chain
      ```

   1. Создайте пользователя `test-user` и передайте свой публичный SSH-ключ частями, на которые вы разбили ключ в предыдущем пункте:

      ```bash
         username test-user
            key-string
               <строка_публичного_ключа>
               ...
               <строка_публичного_ключа>
               exit
            exit
         exit
      exit
      ```

   1. Убедитесь, что ключ добавлен:

      ```bash
      show run | beg ip ssh
      ```
      Результат:

      ```bash
      ip ssh pubkey-chain
        username test-user
         key-hash ssh-rsa <хэш_ключа> <логин_связанный_с_этим_ключом>
      !
      !
      ...
      ```

      Сравните хэш SSH-ключа на роутере с хэшем ключа на вашем компьютере.

   1. В серийной консоли задайте пароль для включения привилегированного режима:

      ```bash
      cisco-router#configure terminal
      cisco-router(config)#enable secret <пароль>
      ```

{% endlist %}


### Проверьте SSH-подключение к роутеру {#test-ssh}

1. Выполните вход по SSH на роутер. Для этого на своем компьютере в терминале выполните команду:

   ```bash
   ssh -i <путь_к_файлу_с_закрытым_ключом> test-user@<публичный_IP-адрес_роутера> 
   ```

   Если все настроено верно, вы зайдете на роутер под именем `test-user`. Если соединение не устанавливается, убедитесь, что настройка роутера в серийной консоли выполнена верно: выполнена команда `aaa new-model`, хэши ключей на вашем компьютере и роутере совпадают, авторизация по паролю у тестового пользователя выключена. Если обнаружить проблему не получается, повторите шаги из предыдущих пунктов. 
1. Перейдите в режим привилегированного пользователя. Для этого введите команду `enable` и пароль. Если все настроено верно, вы сможете конфигурировать роутер.

### Создайте и настройте вторую ВМ с Cisco Cloud Services Router {#create-second-vm}

1. В каталоге `site-b` создайте ВМ `cisco-router-b` по вышеописанной схеме. В качестве зоны доступности выберите **ru-central1-b**.
1. Настройте ВМ так же, как ВМ `cisco-router-d`.

## Настройте IPsec-протоколы {#ipsec-setup}

{% note warning %}

* Настройка производится одинаково на обеих ВМ, за исключением специально оговоренных параметров.
* Настройка производится в терминале, подключенном к ВМ по SSH, в режиме привилегированного пользователя. 

{% endnote %}

1. Настройте глобальные [IKEv2](https://ru.wikipedia.org/wiki/IKE) параметры:

   ```bash
   conf t
   crypto logging ikev2
   crypto ikev2 nat keepalive 900
   crypto ikev2 dpd 10 2 periodic
   ```

1. Настройте IKEv2 `proposal`:

   ```bash
   crypto ikev2 proposal MY_IKEV2_PROPOSAL
      encryption aes-cbc-256
      integrity sha256
      group 2
      exit
   ```

1. Настройте IKEv2 `policy`:

   ```bash
   crypto ikev2 policy MY_IKEV2_POLICY
      proposal MY_IKEV2_PROPOSAL
      exit
   ```

1. Задайте секретный ключ:

   {% list tabs %}

   - ВМ cisco-router-d

     ```bash
     crypto ikev2 keyring MY_IKEV2_KEYRING
        peer SiteB
        address cisco-router-b
        pre-shared-key <секретный_ключ> 
        exit
     ```

   - ВМ cisco-router-b

     ```bash
     crypto ikev2 keyring MY_IKEV2_KEYRING
        peer SiteA
        address cisco-router-d
        pre-shared-key <секретный_ключ> 
        exit
     ```

   {% endlist %}

   Где:
   * `<секретный_ключ>` — ключ шифрования, длиной не менее 16 символов, например `MySecretKey12345`. Используйте один ключ на обеих ВМ.

1. Создайте IKEv2-профиль:

   {% list tabs %}

   - ВМ cisco-router-d

     ```bash
     crypto ikev2 profile MY_IKEV2_PROFILE
        match address local interface GigabitEthernet1
        match identity remote address cisco-router-b
        authentication remote pre-share
        authentication local pre-share
        keyring local MY_IKEV2_KEYRING
        lifetime 28800
        dpd 20 2 periodic
        exit
     ```

   - ВМ cisco-router-b

     ```bash
     crypto ikev2 profile MY_IKEV2_PROFILE
        match address local interface GigabitEthernet1
        match identity remote address cisco-router-d
        authentication remote pre-share
        authentication local pre-share
        keyring local MY_IKEV2_KEYRING
        lifetime 28800
        dpd 20 2 periodic
        exit
     ```

   {% endlist %}

   {% note info %}

   Для целей тестирования вместо IP-адресов вы можете использовать шаблон `0.0.0.0`, чтобы обеспечить доступ к любым IP-адресам.
   Также можно настроить отдельные профили для разных пиров.

   {% endnote %}

1. Добавьте IKEv2-профиль в IPsec-профиль:

   ```bash
   crypto ipsec transform-set ESP_AES128_SHA256 esp-aes esp-sha-hmac
      mode tunnel
      exit
   crypto ipsec profile MY_IPSEC_PROFILE
      set transform-set ESP_AES128_SHA256
      set ikev2-profile MY_IKEV2_PROFILE
      exit
   exit
   ```

## Создайте туннельные интерфейсы {#create-interfaces}

{% note warning %}

* Настройка производится одинаково на обеих ВМ, за исключением специально оговоренных параметров.
* Настройка производится в терминале, подключенном к ВМ по SSH, в режиме привилегированного пользователя. 

{% endnote %}

1. Настройте конфигурацию туннеля GRE:

   {% list tabs %}

   - ВМ cisco-router-d

     ```bash
     conf t
     int tu192
        ip address 192.168.0.1 255.255.255.0
        no ip redirects
        no ip proxy-arp
        ip mtu 1400
        ip tcp adjust-mss 1360
        tunnel source GigabitEthernet1
        tunnel destination cisco-router-b
        tunnel mode ipsec ipv4
        tunnel protection ipsec profile MY_IPSEC_PROFILE
     ```

   - ВМ cisco-router-b

     ```bash
     conf t
     int tu192
        ip address 192.168.0.2 255.255.255.0
        no ip redirects
        no ip proxy-arp
        ip mtu 1400
        ip tcp adjust-mss 1360
        tunnel source GigabitEthernet1
        tunnel destination cisco-router-d
        tunnel mode ipsec ipv4
        tunnel protection ipsec profile MY_IPSEC_PROFILE
     ```

   {% endlist %}

1. Проверьте наличие туннеля:

   {% list tabs %}

   - ВМ cisco-router-d

     ```bash
     show crypto ikev2 sa remote cisco-router-b
     ```

   - ВМ cisco-router-b

     ```bash
     show crypto ikev2 sa remote cisco-router-d
     ```

   {% endlist %}

   Результат:

   ```bash
   Tunnel-id Local                 Remote                fvrf/ivrf            Status
   4         10.128.0.32/4500      51.250.***.***/4500   none/none            READY
         Encr: AES-CBC, keysize: 256, PRF: SHA256, Hash: SHA256, DH Grp:2, Auth sign: PSK, Auth verify: PSK
         Life/Active Time: 28800/23528 sec
   ```

   Также вы можете посмотреть логи туннеля, выполнив команды:

   ```bash
   debug crypto ikev2
   conf t
   do sh log
   ```

## Настройте маршрутизацию {#setup-routers}

{% note warning %}

* Настройка производится одинаково на обеих ВМ, за исключением специально оговоренных параметров.
* Настройка производится в терминале, подключенном к ВМ по SSH, в режиме привилегированного пользователя. 

{% endnote %}

1. Для обеспечения отправки ответа на запрос, настройте [Loopback](https://ru.wikipedia.org/wiki/Loopback)-интерфейс:

   {% list tabs %}

   - ВМ cisco-router-d

     ```bash
     conf t
     int lo10
        ip address 10.1.1.1 255.255.255.255
        exit
     ```

   - ВМ cisco-router-b

     ```bash
     conf t
     int lo10
        ip address 10.1.1.2 255.255.255.255
        exit
     ```

   {% endlist %}

1. Для обеспечения динамической маршрутизации, настройте BGP-протокол:

   {% list tabs %}

   - ВМ cisco-router-d

     ```bash
     router bgp 65001 
        bgp log-neighbor-changes
        neighbor 192.168.0.2 remote-as 65002
        address-family ipv4
           network 10.1.1.1 mask 255.255.255.255
           neighbor 192.168.0.2 activate
           exit
        exit
     exit
     ```

   - ВМ cisco-router-b

     ```bash
     router bgp 65002
        bgp log-neighbor-changes
        neighbor 192.168.0.1 remote-as 65001
        address-family ipv4
           network 10.1.1.2 mask 255.255.255.255
           neighbor 192.168.0.1 activate
           exit
        exit
     exit
     ```

   {% endlist %}

## Проверьте работу туннеля GRE {#check-tunnel}

Убедитесь, что через туннель отправляются и возвращаются пакеты. Для этого на ВМ `cisco-router-d` выполните:

   ```bash
   ping 10.1.1.2 source lo10
   ```

   Результат:

   ```bash
   Type escape sequence to abort.
   Sending 5, 100-byte ICMP Echos to 10.1.1.2, timeout is 2 seconds:
   Packet sent with a source address of 10.1.1.1
   !!!!!
   Success rate is 100 percent (5/5), round-trip min/avg/max = 10/10/11 ms
   ```

Для диагностики туннеля GRE, вы также можете выполнить следующие команды:

   ```bash
   show ip int brief
   show ip bgp summary
   show ip bgp
   show ip route bgp
   ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* [удалите](../operations/vm-control/vm-delete.md) ВМ;
* [удалите](../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы его зарезервировали.