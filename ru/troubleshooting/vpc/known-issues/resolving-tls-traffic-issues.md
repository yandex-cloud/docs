# Устранение ошибок при установке TLS-соединений на ВМ


## Описание проблемы {#issue-description}

* Возникают ошибки при загрузке пакетов из удаленных репозиториев;
* Процесс установки TLS соединения занимает длительное время либо завершается с ошибкой;
* Утилита `curl` не возвращает код HTTP-ответа и долго устанавливает соединения.

## Диагностика и воспроизведение {#diagnosis-and-reproduction}

* Проверьте, используется ли на виртуальной машине [внешний IP-адрес с защитой от DDoS-атак](../../../vpc/operations/enable-ddos-protection.md);
* В случае, если на машине запущен веб-сервер, выполните запрос к нему с другого хоста с помощью утилиты `curl` с указанием параметров `-vI`:

{% cut "Пример curl-запроса к веб-серверу с внешним IP-адресом с защитой от DDoS-атак без измененного MTU" %}

```bash
curl -vI https://site-name.site/
*   Trying ip...
* TCP_NODELAY set
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*   CAfile: /etc/ssl/cert.pem
  CApath: none
* TLSv1.2 (OUT), TLS handshake, Client hello (1):
* TLSv1.2 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (IN), TLS handshake, Server key exchange (12):
* TLSv1.2 (IN), TLS handshake, Server finished (14):
* TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
* TLSv1.2 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (OUT), TLS handshake, Finished (20):
* TLSv1.2 (IN), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (IN), TLS handshake, Finished (20):
```

{% endcut %}

Процесс установки TLS соединения займет длительное время, заметно дольше обычного.

## Решение {#issue-resolution}

Проверьте, используется ли на виртуальной машине [IP-адрес с защитой от DDoS-атак](../../../vpc/operations/enable-ddos-protection.md).
Для корректной работы с внешними ресурсами через защищённый адрес понадобится [уменьшить значение MTU или MSS](../../../vpc/concepts/mtu-mss.md) на сетевом интерфейсе виртуальной машины.

Если на ВМ запущена служба контейнеризации (например, Docker), понадобится указать MTU для всех сетевых интерфейсов, создаваемых этой службой (инструкция для Docker приведена в отдельной вкладке ниже).

{% list tabs group=operating_system %}

- Linux {#linux}

   В действующем сеансе оболочки Linux MTU можно уменьшить командой `sudo ip link set dev <имя_интерфейса> mtu 1450`
   Эти изменения останутся в силе до первой перезагрузки.

   В качестве одного из вариантов внесения этих изменений на постоянной основе, вы можете задействовать службу `rc.local` для выполнения указанных команд при запуске ВМ. Для создания файла с командами для `rc.local` выполните следующие действия:

   1. Создайте файл с последовательностью команд, выполнив `sudo nano /etc/rc.local`. 
   Внутри файла укажите следующее содержимое:

      ```bash
      #!/bin/sh
      sudo ifconfig <имя_интерфейса> mtu 1450 up
      ```

   {% note info %}

   После `ipconfig` потребуется указать наименование сетевого интерфейса ВМ с защищенным адресом и желаемое значение MTU.

   {% endnote %}

   2. Сделайте файл исполняемым, выполнив команду `sudo chmod +x /etc/rc.local`;

   3. Активируйте и запустите службу `rc.local` командой `sudo systemctl enable rc-local.service --now`;

   4. Проверьте работу службы командой `sudo systemctl status rc-local.service`. 
   В результате выполнения команды должен быть подобен приведенному ниже:

      ```bash
      ● rc-local.service - /etc/rc.local Compatibility
      Loaded: loaded (/lib/systemd/system/rc-local.service; enabled-runtime; vendor preset: enabled)
      Drop-In: /usr/lib/systemd/system/rc-local.service.d
      └─debian.conf
      Active: active (exited) since Wed 2022-03-23 10:46:05 UTC; 4min 16s ago
      Docs: man:systemd-rc-local-generator(8)
      Process: 491 ExecStart=/etc/rc.local start (code=exited, status=0/SUCCESS)
      ```

   Обратите внимание: код возврата должен быть указан как `0/SUCCESS`

- Docker {#docker}

   Чтобы изменить значение MTU у всех сетевых интерфейсов, созданных для Docker-контейнеров на ВМ, необходимо изменить конфигурацию службы Docker. Для этого выполните следующие действия:

   1. Выполните команду `sudo nano /etc/docker/daemon.json и добавьте в содержимое файла блок:

      ```json
      {
      "mtu": 1450
      }
      ```
   2. Сохраните файл и перезапустите службу Docker: `sudo systemctl restart docker`.

   - Managed Service for Kubernetes

   Чтобы изменить значение MTU у сетевых интерфейсов всех виртуальных машин, входящих в группу узлов Managed Service for Kubrenetes, понадобится создать объект с типом `DaemonSet` и применить его к кластеру.  Для этого выполните следующие действия:

   1. Создайте файл с манифестом объекта, выполнив `nano ds-set-mtu.yaml`.
   Внутри файла укажите следующее содержимое:

      ```yaml
      apiVersion: apps/v1
      kind: DaemonSet
      metadata:
      name: set-mtu
      spec:
      selector:
         matchLabels:
            app: set-mtu
      template:
         metadata:
            labels:
            app: set-mtu
         spec:
            containers:
            - name: set-mtu
            image: amouat/network-utils
            command: ["sh", "-c", "ip link set dev <имя_интерфейса> mtu 1450"]
            securityContext:
               privileged: true
            resources:
               requests:
                  cpu: "100m"
                  memory: "50Mi"
               limits:
                  cpu: "200m"
                  memory: "100Mi"
            hostNetwork: true
            nodeSelector:
            kubernetes.io/os: linux
      ```

   2. Сохраните файл манифеста и примените его к кластеру: `kubectl apply -f ds-set-mtu.yaml`.

   {% note info %}

   Если вы используете контроллер сетевых политик Calico, задать значение MTU для кластера Managed Service for Kubernetes явным образом не получится.
   В этом случае рекомендуется задать значение MTU на вышестоящей сетевой инфраструктуре (маршрутизаторе, NAT-инстансе или IPsec-инстансе).

   {% endnote %}

- Windows {#windows}

   Для изменения значения MTU на сетевом интерфейсе ВМ, выполните следующие действия в командном интерпретаторе `cmd`, запущенном от имени администратора:

   1. Выполните команду `netsh interface ipv4 show subinterfaces`, чтобы отобразить список всех имеющихся сетевых интерфейсов на виртуальной машине.
   В поле `Interface` выберите и сохраните имя сетевого интерфейса, на котором нужно изменить значение MTU;

   2. Выполните команду `netsh interface ipv4 set subinterface "<имя_интерфейса>" mtu=1450 store=persistent`, указав имя требуемого сетевого интерфейса, чтобы задать для него желаемое значение MTU. Указанное значение сохраняется после перезагрузки системы;

   3. Перезагрузите виртуальную машину;

   4. Убедитесь, что значение MTU было сохранено для сетевого устройства, выполнив команду `netsh interface ipv4 show subinterfaces`

{% endlist %}

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку]({{ link-console-support }}).
В запросе укажите следующую информацию:

1. Идентификатор проблемной виртуальной машины;
2. Внешний IP-адрес с защитой от DDoS-атак, на котором возникает проблема;
3. Описание проблемы: 
   * Консольный вывод менеджера пакетов (`apt`, `yum`, `dnf`, `apk`, `npm` и т.д...) при попытке загрузки ПО из удаленных репозиториев;
   * Вывод утилиты `curl -vk https://$DESTINATION_URL`, где `$DESTINATION_URL` - IP-адрес или домен сайта, при установлении соединении с которыми возникает проблема.