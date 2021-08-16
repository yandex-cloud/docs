# Отказоустойчивый веб-сайт с DNS-балансировкой нагрузки

В этом сценарии описано, как настроить веб-сайт с балансировкой нагрузки между двумя зонами доступности, защищенный от сбоев в одной зоне.

Чтобы настроить отказоустойчивый веб-сайт с DNS-балансировкой нагрузки:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте сетевую инфраструктуру](#prepare-network).
1. [Cоздайте две виртуальные машины](#create-web-server-vm) с предустановленным веб-сервером в разных зонах доступности.
1. [Загрузите файлы веб-сайта](#upload-files).
1. [Создайте две виртуальные машины](#create-dns-balancer-vm) для DNS-балансировщиков в разных зонах доступности.
1. [Установите и настройте ПО DNS-балансировщика](#install-configure-dns-balancer).
1. [Настройте DNS](#configure-dns).
1. [Протестируйте отказоустойчивость](#test-ha).

Если сайт вам больше не нужен, [удалите все используемые им ресурсы](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Перед тем, как разворачивать сервер, нужно зарегистрироваться в {{ yandex-cloud }} и создать платежный аккаунт:

{% include [prepare-register-billing](../../_includes/solutions/_common/prepare-register-billing.md) %}

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать каталог, в котором будет работать ваша ВМ, на [странице облака](https://console.cloud.yandex.ru/cloud).
 
[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры 1С-Битрикс входит:
* плата за постоянно запущенные ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Подготовьте сетевую инфраструктуру {#prepare-network}

Перед тем, как создавать ВМ:
1. Перейдите в [консоль управления]({{ link-console-main }}) {{ yandex-cloud }} и выберите каталог, в котором будете выполнять операции.
1. Убедитесь, что в выбранном каталоге есть сеть с подсетями в зонах доступности `ru-cental1-a` и `ru-central1-b`. Для этого на странице каталога выберите сервис **{{ vpc-name }}**. Если в списке есть сеть — нажмите на нее, чтобы увидеть список подсетей. Если нужных подсетей или сети нет, [создайте их](../../vpc/quickstart.md).

## Создайте виртуальные машины с предустановленным веб-сервером {#create-web-server-vm}

Последовательно создайте две ВМ по инструкции:
1. На странице каталога нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
1. В поле **Имя** введите имя ВМ:
   * для первой — `dns-lb-tutorial-web-ru-central1-a`;
   * для второй — `dns-lb-tutorial-web-ru-central1-b`.
1. Выберите [зону доступности](../../overview/concepts/geo-scope.md):
   * для первой — `ru-central1-a`;
   * для второй — `ru-central1-b`.
1. Выберите один публичный образ для обеих ВМ:
   * **LEMP** для Linux, nginx, MySQL, PHP;
   * **LAMP** для Linux, Apache, MySQL, PHP.
1. В блоке **Вычислительные ресурсы**:
   * Выберите [платформу](../../compute/concepts/vm-platforms.md).
   * Укажите необходимое количество vCPU и объем RAM.

   Характеристики обеих ВМ должны совпадать.

   Для функционального тестирования хватит минимальной конфигурации:
   * **Платформа** — Intel Cascade Lake.
   * **Гарантированная доля vCPU** — 5%.
   * **vCPU** — 2.
   * **RAM** — 1 ГБ.
1. В блоке **Сетевые настройки** выберите, к какой подсети необходимо подключить ВМ при создании.
1. Укажите данные для доступа на ВМ:
   * В поле **Логин** введите имя пользователя.
   * В поле **SSH ключ** вставьте содержимое файла открытого ключа.

     Пару ключей для подключения по SSH необходимо создать самостоятельно. Для создания ключей используйте сторонние инструменты, например утилиты `ssh-keygen` в Linux и macOS или [PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) в Windows.
1. Нажмите кнопку **Создать ВМ**.

Создание ВМ может занять несколько минут. Когда ВМ перейдет в статус `RUNNING`, вы можете [загрузить на нее файлы веб-сайта](#upload-files).

При создании ВМ назначаются IP-адрес и имя хоста (FQDN). Эти данные можно использовать для доступа по SSH.

#### См. также

* [{#T}](../../compute/operations/vm-connect/ssh.md)

## Загрузите файлы веб-сайта {#upload-files}

Для ВМ `dns-lb-tutorial-web-ru-central1-a` и `dns-lb-tutorial-web-ru-central1-b` выполните:

{% include [upload-files](../../_includes/solutions/_common/upload-web-site-files.md) %}

## Создайте виртуальные машины для DNS-балансировщиков {#create-dns-balancer-vm}

Последовательно создайте две ВМ по инструкции:
1. На странице каталога нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
1. В поле **Имя** введите имя ВМ:
   * для первой — `dns-lb-tutorial-slb-ru-central1-a`;
   * для второй — `dns-lb-tutorial-slb-ru-central1-b`.
1. Выберите [зону доступности](../../overview/concepts/geo-scope.md):
   * для первой — `ru-central1-a`;
   * для второй — `ru-central1-b`.
1. Выберите публичный образ **Ubuntu** или **CentOS**. Поддерживаемые версии для **Ubuntu**: 16.04 или выше.
1. В блоке **Вычислительные ресурсы**:
   * Выберите [платформу](../../compute/concepts/vm-platforms.md).
   * Укажите необходимое количество vCPU и объем RAM.

   Характеристики обеих ВМ должны совпадать.

   Для функционального тестирования хватит минимальной конфигурации:
   * **Платформа** — Intel Cascade Lake.
   * **Гарантированная доля vCPU** — 5%.
   * **vCPU** — 2.
   * **RAM** — 1 ГБ.
1. В блоке **Сетевые настройки** выберите, к какой подсети необходимо подключить ВМ при создании.
1. Укажите данные для доступа на ВМ:
   * В поле **Логин** введите имя пользователя.
   * В поле **SSH ключ** вставьте содержимое файла открытого ключа.

     Пару ключей для подключения по SSH необходимо создать самостоятельно. Для создания ключей используйте сторонние инструменты, например утилиты `ssh-keygen` в Linux и macOS или [PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) в Windows.
1. Нажмите кнопку **Создать ВМ**.

Создание ВМ может занять несколько минут. Когда ВМ перейдет в статус `RUNNING`, вы можете [установить и настроить ПО DNS-балансировщика](#install-configure-dns-balancer).

При создании ВМ назначаются IP-адрес и имя хоста (FQDN). Эти данные можно использовать для доступа по SSH.

#### См. также

* [{#T}](../../compute/operations/vm-connect/ssh.md)

## Установите и настройте ПО DNS-балансировщика {#install-configure-dns-balancer}

Для ВМ `dns-lb-tutorial-slb-ru-central1-a` и `dns-lb-tutorial-slb-ru-central1-b` выполните:
1. В блоке **Сеть** на странице ВМ в [консоли управления]({{ link-console-main }}) найдите публичный IP-адрес ВМ.
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH. Для этого можно использовать утилиту `ssh` в Linux и macOS и программу [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) для Windows.

   Рекомендуемый способ аутентификации при подключении по SSH — с помощью пары ключей. Не забудьте настроить использование созданной пары ключей: закрытый ключ должен соответствовать открытому ключу, переданному на ВМ.
1. Установите необходимые зависимости:

   {% list tabs %}

   - Ubuntu 16/18

     ```bash
     sudo apt-get update
     sudo apt-get install pdns-server pdns-backend-remote memcached python3-yaml python3-memcache python3-pip
     ```

   - CentOS 6/7

     ```bash
     sudo yum check-update
     sudo yum -y install epel-release
     sudo yum -y install pdns pdns-backend-remote memcached python34-yaml python34-setuptools git nano
     sudo service memcached start
     sudo chkconfig pdns on
     sudo chkconfig memcached on
     ```

   {% endlist %}

1. Установите `polaris-gslb`:

   ```bash
   git clone https://github.com/polaris-gslb/polaris-gslb.git
   cd polaris-gslb
   sudo python3 setup.py install
   ```

1. Скопируйте файлы конфигурации для `polaris-gslb`:

   {% list tabs %}

   - Ubuntu 16/18

     ```bash
     sudo cp /opt/polaris/etc/pdns.conf.dist /etc/powerdns/pdns.conf
     cd /opt/polaris/etc
     sudo cp polaris-lb.yaml.dist polaris-lb.yaml
     sudo cp polaris-health.yaml.dist polaris-health.yaml
     sudo cp polaris-pdns.yaml.dist polaris-pdns.yaml
     sudo cp polaris-topology.yaml.dist polaris-topology.yaml
     ```

   - CentOS 6

     ```bash
     sudo cp /opt/polaris/etc/pdns.conf.dist /etc/pdns/pdns.conf
     cd /opt/polaris/etc
     sudo cp polaris-lb.yaml.dist polaris-lb.yaml
     sudo cp polaris-health.yaml.dist polaris-health.yaml
     sudo cp polaris-pdns.yaml.dist polaris-pdns.yaml
     sudo cp polaris-topology.yaml.dist polaris-topology.yaml
     sudo cp -a /opt/polaris/bin/polaris-health /etc/init.d/polaris-health
     sudo chkconfig polaris-health on
     ```

   - CentOS 7

     ```bash
     sudo cp /opt/polaris/etc/pdns.conf.dist /etc/pdns/pdns.conf
     cd /opt/polaris/etc
     sudo cp polaris-lb.yaml.dist polaris-lb.yaml
     sudo cp polaris-health.yaml.dist polaris-health.yaml
     sudo cp polaris-pdns.yaml.dist polaris-pdns.yaml
     sudo cp polaris-topology.yaml.dist polaris-topology.yaml
     ```

   {% endlist %}

1. Узнайте внутренний адрес ВМ:

   ```bash
   hostname -i
   ```

1. В конфигурационном файле `pdns.conf` укажите внутренний IP-адрес ВМ. Вы можете отредактировать конфигурационный файл с помощью утилиты `nano`:

   {% list tabs %}

   - Ubuntu 16/18

     ```bash
     sudo nano /etc/powerdns/pdns.conf
     ```

   - CentOS 6/7

     ```bash
     sudo nano /etc/pdns/pdns.conf
     ```

   {% endlist %}

   Файл `pdns.conf` имеет вид:

   ```text
   # Polaris specific PDNS configuration

   #################################
   # launch    Which backends to launch and order to query them in
   #
   # Python3 binary must be in the $PATH!
   launch=remote
   remote-connection-string=pipe:command=/opt/polaris/bin/polaris-pdns,timeout=2000

   local-address=<INTERNAL IP ADRESS>

   #################################
   # distributor-threads   Default number of Distributor (backend) threads to start
   #
   # distributor-threads=3

   # logs received from a Polaris remotebackend will be logged from loglevel 6
   #
   # loglevel=6

   # If not using the topology load balancing method, comment out the caching
   # options below to greatly improve the backend performance

   #################################
   # cache-ttl Seconds to store packets in the PacketCache
   #
   # cache-ttl=20
   cache-ttl=0

   #################################
   # negquery-cache-ttl    Seconds to store negative query results in the QueryCache
   #
   # negquery-cache-ttl=60
   negquery-cache-ttl=0

   #################################
   # query-cache-ttl   Seconds to store query results in the QueryCache
   #
   # query-cache-ttl=20
   query-cache-ttl=0
   ```

   Укажите внутренний IP-адрес в значении параметра `local-address` вместо `<INTERNAL IP ADRESS>`.

1. Настройте `polaris-gslb`. Вы можете отредактировать конфигурационные файлы с помощью утилиты `nano`:
   1. `sudo nano /opt/polaris/etc/polaris-lb.yaml`

      Файл `polaris-lb.yaml` имеет вид:

       ```yaml
      pools:
        www-example:
          monitor: http
          monitor_params:
            hostname: www.example.com
            url_path: /
          lb_method: wrr
          fallback: any
          members:
          - ip: <dns-lb-tutorial-web-ru-central1-a PUBLIC IP>
            name: dns-lb-tutorial-web-ru-central1-a
            weight: 1
          - ip: <dns-lb-tutorial-web-ru-central1-b PUBLIC IP>
            name: dns-lb-tutorial-web-ru-central1-b
            weight: 1

      globalnames:
        www.example.com:
          pool: www-example
          ttl: 1
      ```

      * `www.example.com` — имя вашего домена.
      * `<dns-lb-tutorial-web-ru-central1-a PUBLIC IP>` — публичный IP-адрес ВМ `dns-lb-tutorial-web-ru-central1-a`.
      * `<dns-lb-tutorial-web-ru-central1-b PUBLIC IP>` — публичный IP-адрес ВМ `dns-lb-tutorial-web-ru-central1-b`.

      Публичный адрес ВМ вы можете найти в блоке **Сеть** на странице ВМ в [консоли управления]({{ link-console-main }}).
   1. `sudo nano /opt/polaris/etc/polaris-pdns.yaml`

      Файл `polaris-pdns.yaml` имеет вид:

      ```yaml
      ###############################
      # SOA record format
      # MNAME                RNAME                           SERIAL REFRESH RETRY EXPIRE MINIMUM
      # polaris.example.com. hostmaster.polaris.example.com. 42     3600    600   86400  1

      ###############################
      # SOA MNAME, must end with a dot.
      #
      SOA_MNAME: dns-lb-tutorial-slb-ru-central1-a.example.com.

      ###############################
      # SOA_RNAME, must end with a dot.
      #
      SOA_RNAME: hostmaster.example.com.

      ###############################
      # SOA serial can either be an absolute numeric value e.g. 1(default), or "auto",
      # which automatically sets the serial to seconds since the epoch of the last state
      # update.
      #
      # SOA_SERIAL: 1

      ###############################
      # SOA REFRESH
      #
      # SOA_REFRESH: 3600

      ###############################
      # SOA RETRY
      #
      # SOA_RETRY: 600

      ###############################
      # SOA EXPIRE
      #
      # SOA_EXPIRE: 86400

      ###############################
      # SOA MINIMUM
      #
      # SOA_MINIMUM: 1

      ###############################
      # TTL to set on SOA record
      #
      # SOA_TTL: 86400

      ################################
      # Whether to log a detailed request/response information to pdns.
      # If set to "true", pdns.conf "loglevel" option must be set to 6 or higher.
      #
      # Setting to "false" will improve the backend performance.
      #
      # LOG: false

      ################################
      # Memcache hostname/ip:port to use e.g. "192.168.1.10:12345",
      # if port is omitted the default memcache port is used.
      #
      # SHARED_MEM_HOSTNAME: 127.0.0.1
      ```

      `www.example.com` — имя вашего домена.
1. Если на ВМ установлена ОС CentOS 6, пропустите этот шаг.

   Настройте проверки состояния для `polaris-gslb`:
   1. Добавьте `systemd Unit` файл для проверки состояния `polaris-gslb`. Вы можете отредактировать файл с помощью утилиты `nano`:

      ```bash
      sudo mkdir -p /etc/systemd/system
      sudo nano /etc/systemd/system/polaris-health.service
      ```

      Приведите `polaris-health.service` файл к виду:

      ```text
      [Unit]
      Description=Polaris-GSLB Health Check
      After=network-online.target

      [Service]
      ExecStart=/opt/polaris/bin/polaris-health start
      Type=forking
      Restart=on-failure
      RestartSec=1
      StartLimitInterval=0

      [Install]
      WantedBy=multi-user.target
      ```

   1. Добавьте `polaris-health` в автозагрузку операционной системы:

      ```bash
      sudo systemctl enable polaris-health
      ```

1. Перезапустите PowerDNS:

   ```bash
   sudo service pdns restart
   ```

1. Запустите проверку состояния `polaris-health`:

   ```bash
   sudo service polaris-health start
   ```

1. Этот шаг нужно выполнять только на ВМ с ОС CentOS 6.

   Откройте сетевой порт 53 с помощью утилиты `iptables`:

   ```bash
   sudo iptables -I INPUT -p tcp -m tcp --dport 53 -j ACCEPT
   sudo iptables -I INPUT -p udp -m udp --dport 53 -j ACCEPT
   sudo iptables-save | sudo tee /etc/sysconfig/iptables
   ```

## Настройте DNS {#configure-dns}

Доменное имя, которое вы хотите использовать для веб-сайта, нужно связать с созданными ВМ.

В инструкции ниже описана настройка внешнего DNS-сервиса на примере [reg.ru](https://www.reg.ru/) для доменных имен `www.example.com` и `example.com`.

Чтобы настроить внешний DNS-сервер, выполните:
1. Найдите публичные IP-адреса ВМ `dns-lb-tutorial-slb-ru-central1-a` и `dns-lb-tutorial-slb-ru-central1-b` в блоке **Сеть** на страницах ВМ в [консоли управления]({{ link-console-main }}).
1. Войдите в панель управления внешнего DNS-сервиса. Перейдите в список ваших доменов и нажмите на имя нужного домена.
1. Создайте две A-записи:
   * Для ВМ `dns-lb-tutorial-slb-ru-central1-a`:
     * **IP Address** — публичный IP-адрес вашей ВМ.
     * **Subdomain** — `dns-lb-tutorial-slb-ru-central1-a`.
   * Для ВМ `dns-lb-tutorial-slb-ru-central1-b`:
     * **IP Address** — публичный IP-адрес вашей ВМ.
     * **Subdomain** — `dns-lb-tutorial-slb-ru-central1-b`.
1. Создайте 2 NS-записи со значениями полей:
   * Для ВМ `dns-lb-tutorial-slb-ru-central1-a`:
     * **Subdomain** — `www`.
     * **Canonical name** — `dns-lb-tutorial-slb-ru-central1-a.example.com.`.
   * Для ВМ `dns-lb-tutorial-slb-ru-central1-b`:
     * **Subdomain** — `www`.
     * **Value** — `dns-lb-tutorial-slb-ru-central1-b.example.com.`.
1. Подождите 15-20 минут, пока изменения DNS-записей вводятся в действие. Время ожидания может отличаться для вашего DNS-сервиса.

## Протестируйте отказоустойчивость {#test-ha}

### DNS-балансировщики {#test-dns-balancers}

1. В блоке **Сеть** на странице ВМ в [консоли управления]({{ link-console-main }}) найдите публичный IP-адрес ВМ `dns-lb-tutorial-slb-ru-central1-a`.
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH.
1. Остановите сервис DNS, чтобы сымитировать сбой в работе DNS-баласировщика:

   ```bash
   sudo service pdns stop
   ```

1. Подключитесь к вашему веб-сайту через браузер. Несмотря на сбой в работе одного из DNS-балансировщиков, подключение должно пройти успешно.
1. После завершения проверки запустите сервис DNS:

   ```bash
   sudo service pdns start
   ```

### Веб-серверы {#test-web-servers}

1. В блоке **Сеть** на странице ВМ в [консоли управления]({{ link-console-main }}) найдите публичный IP-адрес ВМ `dns-lb-tutorial-web-ru-central1-a`.
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH.
1. Остановите веб-сервис, чтобы сымитировать сбой в работе веб-сервера:

   {% list tabs %}

   - LAMP

     ```bash
     sudo service apache2 stop
     ```

   - LEMP

     ```bash
     sudo service nginx stop
     ```

   {% endlist %}

1. Подключитесь к вашему веб-сайту через браузер. Несмотря на сбой в работе одного из веб-серверов, подключение должно пройти успешно.
1. После завершения проверки запустите веб-сервис:

   {% list tabs %}

   - LAMP

     ```bash
     sudo service apache2 start
     ```

   - LEMP

     ```bash
     sudo service nginx start
     ```

   {% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за развернутые серверы, достаточно [удалить](../../compute/operations/vm-control/vm-delete.md) созданные ВМ `dns-lb-tutorial-web-ru-central1-a` и `dns-lb-tutorial-web-ru-central1-b`.