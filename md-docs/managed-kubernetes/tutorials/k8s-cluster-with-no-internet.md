# Создание и настройка кластера Kubernetes без доступа в интернет


Вы можете создать и настроить кластер Managed Service for Kubernetes, для которого недоступно подключение к интернету. Для этого используется следующая конфигурация:

* У кластера и группы узлов Managed Service for Kubernetes нет публичного адреса. К такому кластеру можно подключиться только с виртуальной машины Yandex Cloud.
* Кластер и группа узлов размещены в подсетях без доступа в интернет.
* У сервисных аккаунтов нет ролей на работу с ресурсами, имеющими доступ в интернет, например [Yandex Network Load Balancer](../../network-load-balancer/index.md).
* Группы безопасности кластера ограничивают входящий и исходящий трафик.

Чтобы создать кластер Managed Service for Kubernetes без доступа в интернет:

1. [Подготовьте инфраструктуру для Managed Service for Kubernetes](#infra).
1. [Подготовьте виртуальную машину](#vm).
1. [Проверьте доступность кластера](#check).
1. (Опционально) [Настройте подключение к NTP-серверам](#ntp).
1. (Опционально) [Подключите приватный реестр Docker-образов](#cert).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for Kubernetes: использование мастера ([тарифы Managed Service for Kubernetes](../pricing.md)).
* Плата за узлы кластера и ВМ: использование вычислительных ресурсов, операционной системы и хранилища ([тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за публичный IP-адрес для ВМ, которая используется для подключения к кластеру ([тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).
* Плата за сервис Key Management Service: количество активных версий ключа (в статусах `Active` и `Scheduled For Destruction`) и выполненных криптографических операций ([тарифы Key Management Service](../../kms/pricing.md)).


## Подготовьте инфраструктуру для Managed Service for Kubernetes {#infra}

{% list tabs group=instructions %}

- Вручную {#manual}

   1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md):

      * `resource-sa` с [ролями](../../iam/concepts/access-control/roles.md) `k8s.clusters.agent`, `logging.writer` и `kms.keys.encrypterDecrypter` на каталог, в котором создается кластер Kubernetes. От имени этого аккаунта будут создаваться ресурсы, необходимые кластеру Kubernetes.
      * `node-sa` с ролью `container-registry.images.puller`. От имени этого аккаунта узлы будут скачивать из реестра необходимые Docker-образы.

      {% note tip %}

      Вы можете использовать один и тот же сервисный аккаунт для управления кластером Kubernetes и его группами узлов.

      {% endnote %}

   1. [Создайте симметричный ключ шифрования](../../kms/operations/key.md#create) Yandex Key Management Service с параметрами:

      * **Имя** — `my-kms-key`.
      * **Алгоритм шифрования** — `AES-256`.
      * **Период ротации, дни** — 365 дней.

   1. [Создайте сеть](../../vpc/operations/network-create.md) `my-net`.
   1. [Создайте подсеть](../../vpc/operations/subnet-create.md) `my-subnet` с доменным именем `internal.`.
   1. [Создайте группы безопасности](../operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

   1. [Создайте кластер](../operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) Managed Service for Kubernetes с параметрами:

      * **Сервисный аккаунт для ресурсов** — `resource-sa`.
      * **Сервисный аккаунт для узлов** — `node-sa`.
      * **Ключ шифрования** — `my-kms-key`.
      * **Публичный адрес** — без адреса.
      * **Облачная сеть** — `my-net`.
      * **Подсеть** — `my-subnet`.
      * **Группы безопасности** — выберите созданные ранее группы безопасности, которые содержат правила для служебного трафика и для доступа к API Kubernetes.
      * **CIDR кластера** — `172.19.0.0/16`.
      * **CIDR сервисов** — `172.20.0.0/16`.
      * **Запись логов** — включена.
      * **Логи Cluster Autoscaler** — включены.
      * **Логи событий** — включены.
      * **Логи API-сервера Kubernetes** — включены.

   1. В кластере Managed Service for Kubernetes [создайте группу узлов](../operations/node-group/node-group-create.md) с параметрами:

      * **Публичный адрес** — без адреса.
      * **Группы безопасности** — выберите созданные ранее группы безопасности, которые содержат правила для служебного трафика, для подключения к сервисам из интернета и для подключения к узлам по SSH.
      * **Расположение** — подсеть `my-subnet`.

- Terraform {#tf}

   1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
   1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
   1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.
   1. Скачайте в ту же рабочую директорию файл конфигурации [k8s-cluster-with-no-internet.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-without-internet/blob/main/k8s-cluster-with-no-internet.tf). С помощью файла будут созданы ресурсы:

      * Сеть.
      * Таблица маршрутизации.
      * Подсети.
      * Кластер Managed Service for Kubernetes.
      * Группа узлов Managed Service for Kubernetes.
      * [Группы безопасности](../../vpc/concepts/security-groups.md), которые содержат [необходимые правила](../operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

      * [Сервисные аккаунты](../../iam/concepts/users/service-accounts.md) для ресурсов и узлов Kubernetes.
      * [Симметричный ключ шифрования](../../kms/concepts/key.md) Yandex Key Management Service.

      Файл подготовлен с помощью библиотек модулей [terraform-yc-vpc](https://github.com/terraform-yc-modules/terraform-yc-vpc) и [terraform-yc-kubernetes](https://github.com/terraform-yc-modules/terraform-yc-kubernetes). Подробнее о конфигурации ресурсов, которые создаются с помощью этих модулей, смотрите на страницах библиотек.

   1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, Terraform на них укажет.

   1. Создайте необходимую инфраструктуру:

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.

      В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

{% note warning %}

Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.

{% endnote %}

## Подготовьте виртуальную машину {#vm}

Так как у кластера Managed Service for Kubernetes нет доступа в интернет, к нему можно подключиться только с ВМ, находящейся в одной сети с кластером. Поэтому, чтобы проверить доступность кластера, подготовьте инфраструктуру:

1. Создайте необходимые ресурсы:

   {% list tabs group=instructions %}

   - Вручную {#manual}

      1. Создайте сервисный аккаунт `vm-sa` с ролями `k8s.cluster-api.cluster-admin` и `k8s.admin`. От имени этого аккаунта вы подключитесь к кластеру Managed Service for Kubernetes.
      1. Создайте группу безопасности `vm-security-group` и укажите в ней правило для входящего трафика:

         * **Диапазон портов** — `22`.
         * **Протокол** — `TCP`.
         * **Источник** — `CIDR`.
         * **CIDR блоки** — `0.0.0.0/0`.

      1. [Создайте ВМ Linux](../../compute/operations/vm-create/create-linux-vm.md) с параметрами:

         * **Подсеть** — `my-subnet`.
         * **Публичный IP-адрес** — `Автоматически`, либо можно [зарезервировать статический публичный IP-адрес](../../vpc/operations/get-static-ip.md) и привязать его к новой ВМ.
         * **Группы безопасности** — `vm-security-group`.
         * **Сервисный аккаунт** — `vm-sa`.

   - Terraform {#tf}

      1. В директорию с файлом `k8s-cluster-with-no-internet.tf` скачайте файл конфигурации [virtual-machine-for-k8s.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-without-internet/blob/main/virtual-machine-for-k8s.tf).

         В этом файле описаны:

         * сервисный аккаунт для ВМ;
         * группа безопасности для ВМ;
         * ВМ.

      1. Укажите в файле `virtual-machine-for-k8s.tf`:

         * Идентификатор каталога.
         * Идентификатор сети, созданной вместе с кластером Managed Service for Kubernetes.
         * Идентификатор подсети, созданной вместе с кластером Managed Service for Kubernetes и располагающейся в зоне доступности `ru-central1-a`. Эта зона указана в настройках ВМ.
         * Имя пользователя, от лица которого будет выполняться подключение к ВМ по SSH.
         * Абсолютный путь до публичной части SSH-ключа для подключения к ВМ.

      1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

         ```bash
         terraform validate
         ```

         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

      1. Создайте необходимую инфраструктуру:

         1. Выполните команду для просмотра планируемых изменений:
         
            ```bash
            terraform plan
            ```
         
            Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
         
         1. Если вас устраивают планируемые изменения, внесите их:
            1. Выполните команду:
         
               ```bash
               terraform apply
               ```
         
            1. Подтвердите изменение ресурсов.
            1. Дождитесь завершения операции.

         В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

   {% endlist %}

1. [Подключитесь к ВМ](../../compute/operations/vm-connect/ssh.md#vm-connect) по протоколу SSH:

   ```bash
   ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
   ```

   Где `<имя_пользователя>` — имя учетной записи пользователя ВМ.

1. [Установите интерфейс командной строки](../../cli/operations/install-cli.md#interactive) Yandex Cloud (YC CLI).
1. [Создайте профиль](../../cli/operations/profile/profile-create.md#create) для YC CLI.
1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/#kubectl) и [настройте его на работу с созданным кластером](../operations/connect/index.md#kubectl-connect).

## Проверьте доступность кластера {#check}

На ВМ выполните команду:

```bash
kubectl cluster-info
```

Команда вернет информацию о кластере Managed Service for Kubernetes:

```text
Kubernetes control plane is running at https://<адрес_кластера>
CoreDNS is running at https://<адрес_кластера>/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

## (Опционально) Настройте синхронизацию времени кластера Managed Service for Kubernetes с собственным NTP-сервером {#ntp}

Чтобы время кластера Managed Service for Kubernetes не расходилось со временем другого ресурса (в данном случае виртуальной машины), разместите в подсети `my-subnet` собственный NTP-сервер и настройте с ним синхронизацию кластера и ВМ.

1. Укажите адрес NTP-сервера в [настройках DHCP](../../vpc/concepts/dhcp-options.md) подсети `my-subnet`.

   {% list tabs group=instructions %}

   - Вручную {#manual}

     [Измените подсеть `my-subnet`](../../vpc/operations/subnet-update.md), добавив IP-адрес NTP-сервера.

   - Terraform {#tf}

     1. В файле конфигурации Terraform измените описание подсети `my-subnet`. Добавьте блок `dhcp_options` (если он отсутствует) с параметром `ntp_servers` и укажите IP-адрес NTP-сервера:

        ```hcl
        ...
        resource "yandex_vpc_subnet" "lab-subnet-a" {
          name           = "subnet-1"
          ...
          v4_cidr_blocks = ["<IPv4-адрес>"]
          network_id     = "<идентификатор_сети>"
          ...
          dhcp_options {
            ntp_servers = ["<IPv4-адрес>"]
            ...
          }
        }
        ...
        ```

        Подробнее о параметрах ресурса `yandex_vpc_subnet` в Terraform смотрите в [документации провайдера](../../terraform/resources/vpc_subnet.md).

     1. Примените изменения:

        1. В терминале перейдите в директорию с конфигурационным файлом.
        1. Проверьте корректность конфигурации с помощью команды:
        
           ```bash
           terraform validate
           ```
        
           Если конфигурация является корректной, появится сообщение:
        
           ```bash
           Success! The configuration is valid.
           ```
        
        1. Выполните команду:
        
           ```bash
           terraform plan
           ```
        
           В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
        1. Примените изменения конфигурации:
        
           ```bash
           terraform apply
           ```
        
        1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.
        
        Terraform изменит все требуемые ресурсы. Проверить изменение подсети можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

        ```
        yc vpc subnet get <имя_подсети>
        ```
     
   {% endlist %}

1. Разрешите подключение кластера и ВМ к NTP-серверу.
   
   [Создайте](../../vpc/operations/security-group-add-rule.md) правила в [группе безопасности кластера и групп узлов](../operations/connect/security-groups.md#rules-internal-cluster) и группе безопасности `vm-security-group`:

   * **Диапазон портов** — `123`. Если вместо порта `123` вы используете на NTP-сервере другой порт, укажите его.
   * **Протокол** — `UDP`.
   * **Назначение** — `CIDR`.
   * **CIDR блоки** — `<IP-адрес_NTP-сервера>/32`.

1. Обновите сетевые параметры в группе узлов кластера и на ВМ одним из следующих способов:

   * Подключитесь к каждому узлу группы и к ВМ [по SSH](../operations/node-connect-ssh.md) или [через OS Login](../operations/node-connect-oslogin.md) и выполните команду `sudo dhclient -v -r && sudo dhclient`.
   * Перезагрузите узлы группы и ВМ в удобное для вас время.

   {% note warning %}

   Обновление сетевых параметров может привести к недоступности сервисов внутри кластера на несколько минут.

   {% endnote %}

## (Опционально) Подключите приватный реестр Docker-образов {#cert}

Вы можете подключить [приватный реестр Docker-образов](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/) к кластеру Managed Service for Kubernetes. Для аутентификации в реестре и подключения к нему по протоколу HTTPS кластеру нужны сертификаты, выданные CA (Certificate Authority — доверенный центр сертификации). Чтобы добавить и позднее автоматически обновлять сертификаты на узлах кластера, используйте контроллер [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/). Он запускает следующий процесс в подах:

1. При помощи Bash-скрипта на узлах кластера постоянно проверяется наличие нужных сертификатов.
1. Если их нет, они копируются из [секрета](https://kubernetes.io/docs/concepts/configuration/secret/) Kubernetes и обновляются.
1. Перезагружается среда запуска контейнеров containerd.

Чтобы настроить обновление сертификатов с помощью DaemonSet, на ВМ:

1. Разместите файлы сертификатов с расширением `.crt`.
1. Создайте файл `certificate-updater-namespace.yaml` c конфигурацией пространства имен. Это пространство будет использовано для работы и изоляции DaemonSet.

   ```yaml
   apiVersion: v1
   kind: Namespace
   metadata:
     name: certificate-updater
     labels:
       name: certificate-updater
   ```

1. Создайте файл `certificate-updater-daemonset.yaml` с конфигурацией DaemonSet:

   {% cut "Содержимое файла" %}

   ```yaml
   ---
   kind: NetworkPolicy
   apiVersion: networking.k8s.io/v1
   metadata:
     name: certificate-updater-deny-all
     namespace: certificate-updater
   spec:
     podSelector:
       matchLabels:
         k8s-app: certificate-updater
     policyTypes:
       - Ingress
       - Egress
     ingress: []
     egress:  []
   ---
   apiVersion: "apps/v1"
   kind: DaemonSet
   metadata:
     name: certificate-updater
     namespace: certificate-updater
     labels:
       k8s-app: certificate-updater
       version: 1v
   spec:
     selector:
       matchLabels:
         k8s-app: certificate-updater
     template:
       metadata:
         labels:
           k8s-app: certificate-updater
       spec:
         hostPID: true
         hostIPC: true
         containers:
         - name: certificate-updater
           image: cr.yandex/yc/mk8s-openssl:stable
           command: 
             - sh
             - -c
             - |
               while true; do
                 diff -x '.*' -r /mnt/user-cert-path/ /usr/local/share/ca-certificates
                 if [ $? -ne 0 ];
                   then
                       echo "Removing all old certificates"
                       rm -r /usr/local/share/ca-certificates/*
                       echo "Copying certificates from configmap"
                       cp /mnt/sbin/update-ca-certificates /usr/sbin/
                       cp /mnt/user-cert-path/* /usr/local/share/ca-certificates
         
                       echo "Updating cerfificates authorities"
                       update-ca-certificates 

                       echo "Restarting containerd"
                       ps -x -o pid= -o comm= | awk '$2 ~ "^(containerd|dockerd)$" { print $1 }' | xargs kill
                       #systemd will get them back less than a minute
                   else
                     echo "Doing Nothing as no certs has not been changed"
                   fi
                 sleep 60
               done
           imagePullPolicy: Never
           securityContext:
             privileged: true
           resources:
             limits:
               memory: 200Mi
             requests:
               cpu: 100m
               memory: 200Mi
           volumeMounts:
           - mountPath: /etc/
             name: etc
           - mountPath: /usr/local/share/ca-certificates
             name: docker-cert
           - name: secret
             mountPath: /mnt/user-cert-path
           - name: sbin
             mountPath: /mnt/sbin
             readOnly: true
           - name: ca-cert
             mountPath: /usr/share/ca-certificates
         volumes:
         - name: secret
           secret:
             secretName: crt
         - name: sbin
           hostPath:
             path: /usr/sbin/
             type: Directory
         - name: ca-cert
           hostPath:
             path: /usr/share/ca-certificates
             type: Directory
         - name: docker-cert
           hostPath:
             path: /usr/local/share/ca-certificates
             type: DirectoryOrCreate
         - name: etc
           hostPath:
             path: /etc/
             type: Directory
   ```

   {% endcut %}

1. Создайте пространство имен:

   ```bash
   kubectl apply -f certificate-updater-namespace.yaml
   ```

1. Создайте секрет с содержимым сертификатов, выпущенных CA:

   ```bash
   kubectl create secret generic crt \
      --from-file=<путь_к_файлу_с_сертификатом>.crt \
      --namespace="certificate-updater"
   ```

   В команде укажите сертификат с расширением `.crt`. Если надо добавить несколько сертификатов, передайте каждый из них в команде с помощью флага `--from-file`.

   Вы можете проверить конфигурацию секрета с помощью команды ниже и убедиться, что конфигурация содержит информацию о сертификатах:

   ```bash
   kubectl get secret crt -o yaml
   ```

1. Создайте DaemonSet:

   ```bash
   kubectl apply -f certificate-updater-daemonset.yaml
   ```

Далее можно отслеживать состояние контроллера DaemonSet. Когда обновятся сертификаты, в кластере перезагрузятся процессы среды запуска контейнеров containerd.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать.

{% list tabs group=instructions %}

- Вручную {#manual}

   Удалите:

   1. [Сервисные аккаунты](../../iam/operations/sa/delete.md).
   1. [Ключ шифрования](../../kms/operations/key.md#delete) Key Management Service.
   1. [Группы безопасности](../../vpc/operations/security-group-delete.md).
   1. [Группу узлов](../operations/node-group/node-group-delete.md) Managed Service for Kubernetes.
   1. [Кластер](../operations/kubernetes-cluster/kubernetes-cluster-delete.md) Managed Service for Kubernetes.
   1. [Виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
   1. [Подсеть](../../vpc/operations/subnet-delete.md).
   1. [Сеть](../../vpc/operations/network-delete.md).

- Terraform {#tf}

   1. В терминале перейдите в директорию с планом инфраструктуры.
   
       {% note warning %}
   
       Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
   
       {% endnote %}
   
   1. Удалите ресурсы:
   
       1. Выполните команду:
   
           ```bash
           terraform destroy
           ```
   
       1. Подтвердите удаление ресурсов и дождитесь завершения операции.
   
       Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

{% endlist %}

Если для ВМ использовался статический публичный IP-адрес, [освободите и удалите его](../../vpc/operations/address-delete.md).