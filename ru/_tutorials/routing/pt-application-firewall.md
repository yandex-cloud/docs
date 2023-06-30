# Настройка PT Application Firewall

[PT Application Firewall](https://www.ptsecurity.com/ru-ru/products/af/) — [межсетевой экран уровня веб-приложений](https://ru.wikipedia.org/wiki/Файрвол_веб-приложений), который обеспечивает непрерывную защиту веб-приложений, пользователей и сетевой инфраструктуры и помогает соответствовать стандартам безопасности.

В данном сценарии вы развернете тестовую инфраструктуру, включающую межсетевой экран уровня веб-приложений PT Application Firewall и тестовое [уязвимое веб-приложение](https://github.com/digininja/DVWA#damn-vulnerable-web-application), и протестируете возможности защиты от типичных веб-атак.

Чтобы настроить PT Application Firewall и проверить его работу:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Создайте веб-сервер](#create-web-server). 
1. [Запустите уязвимое веб-приложение](#run-dvwa). 
1. [Настройте межсетевой экран](#configure-firewall). 
1. [Протестируйте работу межсетевого экрана](#test-firewall). 

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за постоянно работающие ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование публичных IP-адресов и исходящий трафик (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md));


## Создайте веб-сервер {#create-web-server}

1. Создайте ВМ `dvwa-server` с ОС Ubuntu:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана ВМ.
   1. В списке сервисов выберите **{{ compute-name }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
      * Введите имя `dvwa-server`. 
      * Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
   1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите Ubuntu 22.04.   
   1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:
      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя `ycuser`.
      * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла [открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys). Пару ключей для подключения по [SSH](../../glossary/ssh-keygen.md) необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
   1. Остальные настройки оставьте без изменения и нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   {% note info %}

   При создании ВМ назначаются публичный и внутренний IP-адреса. Запишите их, они понадобятся для доступа к ВМ и настройки межсетевого экрана.

   {% endnote %}

1. Подключитесь к ВМ `dvwa-server` по SSH, выполнив в терминале команду:
   ```bash
   ssh ycuser@<публичный_IP-адрес_ВМ_dvwa-server>
   ```

## Запустите уязвимое веб-приложение DVWA {#run-dvwa}

1. На ВМ `dvwa-server` установите [Docker](https://www.docker.com/):

   ```bash
   curl -fsSL https://test.docker.com -o test-docker.sh
   sudo sh test-docker.sh
   ```

1. Запустите контейнер с уязвимым веб-приложением:
   ```bash
   sudo docker run --rm -it -p 8080:80 sagikazarmark/dvwa
   ```

1. Настройте уязвимое веб-приложение:
   1. В браузере перейдите по адресу:

   ```html
   http://<публичный_IP-адрес_ВМ_dvwa-server>:8080
   ```

   1. На странице авторизации введите логин `admin` и пароль `password`.
   1. На странице `Database Setup` внизу нажмите кнопку **Create / Reset Database**. 
   1. Повторно авторизуйтесь с тем же логином и паролем.
   1. Нажмите на кнопку **DVWA Security** в левой части экрана и перейдите на страницу с настройками безопасности.
   1. В секции Security Level выберите нужный уровень защищенности приложения. В выпадающем списке выберите **Low** и нажмите кнопку **Submit**.
   

## Настройте межсетевой экран {#configure-firewall}

1. Создайте ВМ `pt-firewall` из публичного образа `PT Application Firewall`:

   {% list tabs %}

   - Консоль управления

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана ВМ.
      1. В списке сервисов выберите **{{ compute-name }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
         * Введите имя `pt-firewall`. 
         * Выберите ту же зону доступности, в которой находится ВМ `dvwa-server`.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}**. 
      1. Выберите актуальный образ `PT Application Firewall`.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:
         * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя `ycuser`.
         * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла [открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys). Пару ключей для подключения по [SSH](../../glossary/ssh-keygen.md) необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
      1. Активируйте опцию **{{ ui-key.yacloud.compute.instances.create.field_serial-port-enable }}**.
      1. Остальные настройки оставьте без изменения и нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   {% endlist %}

   {% note info %}

   При создании ВМ назначаются публичный и внутренний IP-адреса. Рекомендуется [сделать публичный адрес статическим](../../vpc/operations/set-static-ip.md).

   {% endnote %}

1. Перейдите в [серийную консоль](../../compute/operations/serial-console/index.md) созданной ВМ:

   {% list tabs %}

   - Консоль управления

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором была создана ВМ.
      1. Перейдите в сервис **{{ compute-name }}** и выберите ВМ `pt-firewall`.
      1. Перейдите на вкладку **{{ ui-key.yacloud.compute.instance.switch_console }}**.
      1. Введите логин `pt` и пароль `positive`.
      1. Вам будет предложено сменить пароль. Введите прежний пароль `positive` и создайте новый пароль в соответствии с требованиями системы.
      1. Вам будут предложены варианты дальнейших действий. Введите `0`.
      1. Создайте конфигурацию, последовательно выполнив следующие команды:

      ```bash
      if set eth-ext1 inet_method dhcp
      dns add 77.88.8.8
      config commit
      config sync
      ```

   {% endlist %}

1. Авторизуйтесь в консоли настройки межсетевого экрана:
   1. В браузере перейдите по адресу:
      ```html
      http://<публичный_IP-адрес_ВМ_pt-firewall>:8443
      ```
   1. На странице авторизации введите логин `admin` и пароль `positive`.
   1. Вам будет предложено сменить пароль. Введите прежний пароль `positive` и создайте новый пароль.
1. Настройте сетевые интерфейсы:
   1. В верхней части экрана выберите **Configuration** / **Network** / **Gateways**.
   1. В таблице, в строке с интерфейсом `pt-firewall` нажмите иконку редактирования.
   1. На вкладке **General** активируйте интерфейс, включив опцию `Active`.
   1. На вкладке **Network** в поле **Aliases** добавте опции `WAN-wan`, `LAN-lan` и `MGMT-mgmt` из выпадающего списка. 
   1. Нажмите **Apply**.
1. Настройте **Upstream**, в котором в качестве бэкенд-сервера будет указано веб-приложение DVWA:
   1. В верхней части экрана выберите **Configuration** / **Network** / **Upstreams**.
   1. На странице `UPSTREAMS` нажмите кнопку **Create**.
   1. В поле **Name** введите `DVWA`.
   1. В строке **Backend** нажмите кнопку **Add** и укажите:
      * В поле **Host** — `<публичный_IP-адрес_ВМ_dvwa-server>`;
      * В поле **Port** — `8080`.
   1. Остальные настройки оставьте без изменения и нажмите кнопку **Apply**.
1. Настройте сервис:
   1. В верхней части экрана выберите **Configuration** / **Network** / **Services**.
   1. На странице `SERVICES` нажмите кнопку **Create**.
   1. В поле **Name** введите `DVWA-RP`.
   1. В строке **Servers** нажмите кнопку **Add** и укажите:
      * В поле **Network interface alias** — `WAN-wan` из выпадающего списка;
      * В поле **Listen Port** — `80`;
      * В поле **Upstream** — `DVWA` из выпадающего списка;
   1. Остальные настройки оставьте без изменения и нажмите кнопку **Apply**.
1. Добавьте веб-приложение:
   1. В верхней части экрана выберите **Configuration** / **Security** / **Web applications**.
   1. На странице `WEB APPLICATIONS` нажмите кнопку **Create**.
   1. В поле **Name** введите `DVWA-APP`.
   1. В поле **Service** — `DVWA-RP` из выпадающего списка;
   1. В поле **Protection mode** — `Detection` из выпадающего списка;
   1. В строке **Locations** нажмите кнопку **Add** и укажите: ` \/ `
   1. Остальные настройки оставьте без изменения и нажмите кнопку **Apply**.

## Протестируйте работу межсетевого экрана {#test-firewall}

Чтобы протестировать работу межсетевого экрана, воспользуйтесь симулятором веб-атак [GoTestWAF](https://github.com/wallarm/gotestwaf#gotestwaf-) от компании Wallarm:

1. Откройте новое окно терминала командной строки и подключитесь к ВМ `dvwa-server` по SSH:
   ```bash
   ssh yclogrus@<публичный_IP-адрес_ВМ_dvwa-server>
   ```

1. Запустите тест, выполнив команду:

   ```bash
   sudo docker run -v ${PWD}/reports:/app/reports wallarm/gotestwaf --url=http://<публичный_IP-адрес_ВМ_pt-firewall>/ --skipWAFBlockCheck
   ```

1. Дождитесь окончания теста и просмотрите результаты. В итоговой таблице `Summary` легко видеть, что атаки не были заблокированы (секция `TRUE-NEGATIVE TESTS BLOCKED`): 

   ```bash
   Summary:
   +-----------------------------+-----------------------------+-----------------------------+-----------------------------+
   |            TYPE             | TRUE-NEGATIVE TESTS BLOCKED | TRUE-POSITIVE TESTS PASSED  |           AVERAGE           |
   +-----------------------------+-----------------------------+-----------------------------+-----------------------------+
   | API Security                | 0.00%                       | n/a                         | 0.00%                       |
   | Application Security        | 0.17%                       | 100.00%                     | 50.09%                      |
   +-----------------------------+-----------------------------+-----------------------------+-----------------------------+
   |                                                                        SCORE            |           25.05%            |
   +-----------------------------+-----------------------------+-----------------------------+-----------------------------+
   ```

1. Вернитесь в браузере на страницу настроек межсетевого экрана, раздел `WEB APPLICATIONS` (**Configuration** / **Security** / **Web applications**) и нажмите иконку редактирования в строке приложения `DVWA`.
1. В поле **Protection mode** выберите `Active prevention` из выпадающего списка и нажмите кнопку **Apply**.
1. В терминале повторно запустите тест из пункта 2.
1. Дождитесь окончания теста и просмотрите результаты. В итоговой таблице `Summary` показано, что в этот раз были отражены все атаки (100% атак в секции `TRUE-NEGATIVE TESTS BLOCKED`): 

   ```bash
   Summary:
   +-----------------------------+-----------------------------+-----------------------------+-----------------------------+
   |            TYPE             | TRUE-NEGATIVE TESTS BLOCKED | TRUE-POSITIVE TESTS PASSED  |           AVERAGE           |
   +-----------------------------+-----------------------------+-----------------------------+-----------------------------+
   | API Security                | 100.00%                     | n/a                         | 100.00%                     |
   | Application Security        | 100.00%                     | 0.00%                       | 50.00%                      |
   +-----------------------------+-----------------------------+-----------------------------+-----------------------------+
   |                                                                        SCORE            |           75.00%            |
   +-----------------------------+-----------------------------+-----------------------------+-----------------------------+
   ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите ВМ](../../compute/operations/vm-control/vm-delete.md) `dvwa-server` и `pt-firewall`.
1. [Удалите статические публичные IP-адреса](../../vpc/operations/address-delete.md).

