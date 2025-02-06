# Установка виртуального роутера Cisco CSR 1000v


В {{ yandex-cloud }} можно развернуть виртуальный роутер Cisco Cloud Services Router (CSR) 1000v из готового образа виртуальной машины. 

Чтобы установить CSR 1000v и настроить к нему доступ по [SSH](../../glossary/ssh-keygen.md):

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте пару ключей SSH](#create-ssh-keys).
1. [Создайте виртуальную машину с Cisco Cloud Services Router](#create-router).
1. [Задайте роутеру имя хоста](#hostname).
1. [Создайте пользователя с правами администратора](#create-user).
1. [Настройте аутентификацию с помощью SSH-ключей](#enable-ssh).
1. [Проверьте SSH-подключение к роутеру](#test-ssh).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% note alert %}

Пропускная способность роутера при использовании образа Cisco CSR 1000v без лицензии ограничена 100 Кбит/с. Чтобы снять ограничение, [установите лицензию](https://www.cisco.com/c/en/us/td/docs/routers/csr1000/software/configuration/b_CSR1000v_Configuration_Guide/b_CSR1000v_Configuration_Guide_chapter_01000.html).

{% endnote %}

В стоимость использования виртуального роутера входят:

* плата за диск и постоянно запущенную ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md#prices-public-ip)).

## Создайте пару ключей SSH {#create-ssh-keys}

{% include [vm-ssh-rsa-key](../../_includes/vm-ssh-rsa-key.md) %}

{% note warning %}

Надежно сохраните закрытый ключ: без него подключиться к виртуальной машине будет невозможно.

{% endnote %}

## Создайте виртуальную машину с Cisco Cloud Services Router {#create-router}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `Cisco CSR` и выберите публичный образ [Cisco CSR](/marketplace/products/yc/cisco-csr).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет создана ВМ. Если вы не знаете, какая зона доступности вам нужна, оставьте выбранную по умолчанию.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `100%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите сеть и подсеть, к которым нужно подключить ВМ. Если нужной [сети](../../vpc/concepts/network.md#network) или [подсети](../../vpc/concepts/network.md#subnet) еще нет, [создайте их](../../vpc/operations/subnet-create.md).
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** оставьте значение `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить ВМ случайный внешний IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `cisco-router`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}** выключите опцию `{{ ui-key.yacloud.compute.instances.create.field_serial-port-enable }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Создание ВМ может занять несколько минут. Когда ВМ перейдет в статус `RUNNING`, вы сможете пользоваться серийной консолью.

{% endlist %}

## Задайте роутеру имя хоста {#hostname}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с созданной ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. В списке ВМ выберите `cisco-router`.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/terminal.svg) **{{ ui-key.yacloud.compute.instance.switch_console }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instance.console.connect }}**.
  1. Дождитесь полной загрузки операционной системы.
  1. Чтобы перейти в привилегированный режим, выполните в серийной консоли команду `enable`:

      ```text
      cisco-router.{{ region-id }}.internal>enable
      ```

  1. Перейдите в режим конфигурирования и задайте роутеру имя хоста:

      ```text
      cisco-router.{{ region-id }}.internal#configure terminal
      Enter configuration commands, one per line.  End with CNTL/Z.
      cisco-router.ru-cent(config)#hostname cisco-router
      ```

      Имя роутера в начале командной строки должно измениться на `cisco-router`.

{% endlist %}

## Создайте пользователя с правами администратора {#create-user}

Создайте пользователя с правами администратора без возможности входа по паролю:

{% list tabs group=instructions %}

- Консоль управления {#console}

  В серийной консоли выполните команду:

  ```text
  cisco-router(config)#username test-user privilege 15
  ```

{% endlist %}

## Настройте аутентификацию с помощью SSH-ключей {#enable-ssh}

1. Если ваш публичный SSH-ключ длиннее 72 символов, разбейте ключ на части по 72 символа. Для этого на своем компьютере в терминале выполните команду:

   ```bash
   fold -bw 72 <путь_к_файлу_с_публичным_ключом>
   ```

   В результате будет выведен публичный SSH-ключ, разбитый на строки по 72 символа.

1. В серийной консоли включите доступ на ВМ по SSH:

   ```text
   cisco-router(config)#aaa new-model
   cisco-router(config)#ip ssh server algorithm authentication publickey 
   cisco-router(config)#ip ssh pubkey-chain
   ```

1. Создайте пользователя `test-user` и передайте в режиме `conf-ssh-pubkey-data` свой публичный SSH-ключ частями не длиннее 72 символов, начиная с `ssh-rsa` и заканчивая логином:

   ```text
   cisco-router(conf-ssh-pubkey)#username test-user
   cisco-router(conf-ssh-pubkey-user)#key-string
   cisco-router(conf-ssh-pubkey-data)#<строка_публичного_ключа>
   ...
   cisco-router(conf-ssh-pubkey-data)#<строка_публичного_ключа>
   cisco-router(conf-ssh-pubkey-data)#exit
   cisco-router(conf-ssh-pubkey-user)#exit
   cisco-router(conf-ssh-pubkey)#exit
   cisco-router(config)#exit
   ```

1. Убедитесь, что ключ добавлен:

   ```text
   cisco-router#show run | beg ip ssh
   ip ssh pubkey-chain
     username test-user
      key-hash ssh-rsa <хэш_ключа> <логин_связанный_с_этим_ключом>
   !
   !
   ...
   ```

1. Сравните хэш SSH-ключа на роутере с хэшем ключа на вашем компьютере:

   ```bash
   ssh-keygen -E md5 -lf <путь_к_файлу_с_публичным_ключом>
   ```

1. В серийной консоли задайте пароль для включения привилегированного режима:

   ```text
   cisco-router#configure terminal
   cisco-router(config)#enable secret <пароль>
   ```

## Проверьте SSH-подключение к роутеру {#test-ssh}

1. Выполните вход по SSH на роутер. Для этого на своем компьютере в терминале выполните команду:

   ```bash
   ssh -i <путь_к_файлу_с_закрытым_ключом> test-user@<публичный_IP-адрес_роутера> 
   ```

   Если все настроено верно, вы зайдете на роутер под именем `test-user`. Если соединение не устанавливается, убедитесь, что настройка роутера в серийной консоли выполнена верно: выполнена команда `aaa new-model`, хэши ключей на вашем компьютере и роутере совпадают, авторизация по паролю у тестового пользователя выключена. Если обнаружить проблему не получается, повторите шаги из предыдущих пунктов. 
1. Введите команду `enable` и пароль. Если все настроено верно, вы сможете конфигурировать роутер.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* [удалите](../../compute/operations/vm-control/vm-delete.md) ВМ;
* [удалите](../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы его зарезервировали.
