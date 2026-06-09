# Развертывание веб-интерфейса Apache Kafka®

# Самостоятельное развертывание веб-интерфейса Apache Kafka®



{% note info %}

Managed Service for Apache Kafka® имеет [встроенную поддержку веб-интерфейса Kafka UI](../../managed-kafka/concepts/kafka-ui.md). Если вам по какой-то причине не подходит такой вариант, используйте информацию из этого руководства.

{% endnote %}


Вы можете установить [веб-интерфейс Apache Kafka®](https://ui.docs.kafbat.io/) для своего кластера Managed Service for Apache Kafka®. С помощью веб-интерфейса можно отслеживать потоки данных, находить и устранять неисправности, управлять [брокерами](../../managed-kafka/concepts/brokers.md), кластером, [производителями и потребителями](../../managed-kafka/concepts/producers-consumers.md).


Развернуть веб-интерфейс Apache Kafka® можно двумя способами:

* В [Docker-контейнере](#docker) на виртуальной машине Yandex Cloud. Этот вариант дешевле, но менее надежный, поэтому подходит для знакомства с веб-интерфейсом Apache Kafka®.
* В [кластере Yandex Managed Service for Kubernetes](#kubernetes). Этот вариант дороже, но более надежный, поэтому подходит для постоянного и длительного использования веб-интерфейса.


## Развертывание в Docker-контейнере {#docker}

Чтобы развернуть веб-интерфейс Apache Kafka® в Docker-контейнере:

1. [Установите дополнительные зависимости](#infra-for-docker).
1. [Создайте хранилище сертификатов TrustStore](#truststore-for-docker).
1. [Подготовьте веб-интерфейс Apache Kafka®](#prepare-ui-via-docker).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for Apache Kafka®: использование вычислительных ресурсов, выделенных хостам (в том числе хостам ZooKeeper), и дискового пространства (см. [тарифы Apache Kafka®](../../managed-kafka/pricing.md)).
* Плата за ВМ: использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за публичные IP-адреса для ВМ и хостов кластера, если для них включен публичный доступ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).


### Перед началом работы {#before-you-begin-to-work-with-docker}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

   
   1. [Настройте группу безопасности](../../managed-kafka/operations/connect/index.md#configuring-security-groups) для кластера Managed Service for Apache Kafka® и ВМ так, чтобы к топикам можно было подключаться с ВМ в Облаке.


   1. [Создайте кластер](../../managed-kafka/operations/cluster-create.md) Managed Service for Apache Kafka®. При создании укажите настроенную группу безопасности.
   1. [Создайте пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) Apache Kafka®.
   1. В той же сети, что и кластер Managed Service for Apache Kafka®, [создайте ВМ](../../compute/operations/vm-create/create-linux-vm.md) с Ubuntu 22.04, публичным IP-адресом и настроенной группой безопасности.

- Terraform {#tf}

   1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
   1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
   1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.
   1. Скачайте в ту же рабочую директорию файл конфигурации [kafka-ui-via-docker.tf](https://github.com/yandex-cloud-examples/yc-deploy-kafka-ui/blob/main/kafka-ui-via-docker.tf).

      В этом файле описаны:

      * сеть;
      * подсеть;
      * ВМ с Ubuntu 22.04;

      
      * группа безопасности по умолчанию и правила, необходимые для подключения к кластеру и виртуальной машине из интернета;


      * кластер Managed Service for Apache Kafka®;
      * пользователь Apache Kafka®.

   1. Укажите значения переменных в файле `kafka-ui-via-docker.tf`.
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

### Установите дополнительные зависимости {#infra-for-docker}

1. [Подключитесь к ВМ по SSH](../../compute/operations/vm-connect/ssh.md#vm-connect):

   ```bash
   ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
   ```

   Где `<имя_пользователя>` — имя учетной записи пользователя ВМ. Публичный IP-адрес ВМ доступен в [консоли управления](https://console.yandex.cloud), на странице ВМ.

1. Чтобы проверить доступность кластера Managed Service for Apache Kafka®, подключитесь к одному из его хостов с ролью `KAFKA`:

   ```bash
   telnet <FQDN_хоста> 9091
   ```

   FQDN доступен в консоли управления:

      1. Перейдите на страницу кластера.
      1. Перейдите в раздел **Хосты**.
      1. Скопируйте значение в столбце **FQDN хоста**, в строке хоста с ролью `KAFKA`.

   Если кластер доступен, появится сообщение:

   ```text
   Connected to <FQDN_хоста>
   ```

   После этого выполнение команды можно прервать, так как далее она не завершается, а ожидает передачи данных.

1. Установите Docker:

   ```bash
   sudo apt update && sudo apt install docker.io
   ```

1. Установите утилиту `keytool` для управления ключами и сертификатами:

   ```bash
   sudo apt install openjdk-19-jre-headless
   ```

### Создайте хранилище сертификатов TrustStore {#truststore-for-docker}

При развертывании Apache Kafka® в Docker-контейнере команды для TrustStore выполняются на ВМ.

TrustStore — это хранилище доверенных сертификатов, которое используется в файлах JKS (Java KeyStore). Оно применяется для аутентификации клиента при его подключении к серверу. Сервер валидирует клиента с помощью сертификатов, которые хранятся в TrustStore. При этом клиент хранит приватный ключ и сертификат на своей стороне, в хранилище KeyStore.

В примере ниже TrustStore используется, чтобы подключиться к кластеру Managed Service for Apache Kafka®. Без создания TrustStore в веб-интерфейсе Apache Kafka® не появится информация о кластере.

Чтобы использовать TrustStore:

1. Создайте SSL-сертификат:

   ```bash
   sudo mkdir -p /usr/local/share/ca-certificates/Yandex/ && \
   sudo wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
        --output-document /usr/local/share/ca-certificates/Yandex/YandexCA.crt && \
   sudo chmod 0655 /usr/local/share/ca-certificates/Yandex/YandexCA.crt
   ```

1. Создайте директорию `/truststore`:

   ```bash
   mkdir /truststore
   ```

   В ней будет храниться файл `truststore.jks`. Отдельная директория нужна, чтобы далее путь к файлу был корректно распознан в командах и конфигурационных файлах.

1. Загрузите сертификат `YandexCA.crt` в файл `truststore.jks`:

   ```bash
   sudo keytool -import \
                -file /usr/local/share/ca-certificates/Yandex/YandexCA.crt \
                -alias "kafka-ui-cert" \
                -keystore /truststore/truststore.jks
   ```

   Команда предложит создать пароль. Запомните его — он понадобится для развертывания веб-интерфейса Apache Kafka®.

### Подготовьте веб-интерфейс Apache Kafka® {#prepare-ui-via-docker}

1. В ВМ запустите Docker-контейнер, в котором будет развернут веб-интерфейс:

   ```bash
   sudo docker run -it -p 8080:8080 \
      -e DYNAMIC_CONFIG_ENABLED=true \
      -e KAFKA_CLUSTERS_0_NAME=<имя_кластера> \
      -e KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS=<FQDN_хоста>:9091 \
      -e KAFKA_CLUSTERS_0_PROPERTIES_SECURITY_PROTOCOL=SASL_SSL \
      -e KAFKA_CLUSTERS_0_PROPERTIES_SASL_MECHANISM=PLAIN \
      -e KAFKA_CLUSTERS_0_PROPERTIES_CLIENT_DNS_LOOKUP=use_all_dns_ips \
      -e KAFKA_CLUSTERS_0_PROPERTIES_SASL_JAAS_CONFIG='org.apache.kafka.common.security.plain.PlainLoginModule required username="<логин_пользователя>" password="<пароль_пользователя>";' \
      -e KAFKA_CLUSTERS_0_PROPERTIES_SSL_TRUSTSTORE_LOCATION=/truststore/truststore.jks \
      -e KAFKA_CLUSTERS_0_PROPERTIES_SSL_TRUSTSTORE_PASSWORD=<пароль_для_TrustStore> \
      -v /truststore/truststore.jks:/truststore/truststore.jks \
      provectuslabs/kafka-ui
   ```

   Укажите в переменных окружения:

   * `KAFKA_CLUSTERS_0_NAME` — имя кластера Managed Service for Apache Kafka®.
   * `KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS` — FQDN хоста с ролью `KAFKA` в кластере Managed Service for Apache Kafka®.
   * `KAFKA_CLUSTERS_0_PROPERTIES_SASL_JAAS_CONFIG`, `username` — логин пользователя Apache Kafka®.
   * `KAFKA_CLUSTERS_0_PROPERTIES_SASL_JAAS_CONFIG`, `password` — пароль пользователя Apache Kafka®.
   * `KAFKA_CLUSTERS_0_PROPERTIES_SSL_TRUSTSTORE_PASSWORD` — пароль, который вы задали во время создания файла `truststore.jks`.

   После запуска команда не завершается. Пока она работает, доступен веб-интерфейс Apache Kafka®.

1. На локальной машине в браузере перейдите по адресу `http://<публичный_IP-адрес_ВМ>:8080`. Откроется веб-интерфейс Apache Kafka® с данными о кластере Managed Service for Apache Kafka®.

   Публичный IP-адрес ВМ доступен в консоли управления, на странице ВМ.


## Развертывание в кластере Managed Service for Kubernetes {#kubernetes}

Чтобы развернуть веб-интерфейс Apache Kafka® в кластере Managed Service for Kubernetes:

1. [Установите дополнительные зависимости](#infra-for-kubernetes).
1. [Создайте хранилище сертификатов TrustStore](#truststore-for-kubernetes).
1. [Разверните приложение с веб-интерфейсом Apache Kafka® в поде Kubernetes](#application-in-pod).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for Apache Kafka®: использование вычислительных ресурсов, выделенных хостам (в том числе хостам ZooKeeper), и дискового пространства (см. [тарифы Apache Kafka®](../../managed-kafka/pricing.md)).
* Плата за кластер Managed Service for Kubernetes: использование мастера и исходящий трафик (см. [тарифы Managed Service for Kubernetes](../pricing.md)).
* Плата за узлы кластера Managed Service for Kubernetes (ВМ): использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за публичные IP-адреса для хостов кластера Managed Service for Apache Kafka® и узлов кластера Managed Service for Kubernetes, если для них включен публичный доступ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).


### Перед началом работы {#before-you-begin-to-work-with-kubernetes}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

   1. Настройте единую группу безопасности:

      * [Для кластера Managed Service for Apache Kafka®](../../managed-kafka/operations/connect/index.md#configuring-security-groups) так, чтобы можно было подключаться к топикам через интернет.
      * [Для кластера и группы узлов](../operations/connect/security-groups.md) Managed Service for Kubernetes.

   1. [Создайте кластер](../../managed-kafka/operations/cluster-create.md) Managed Service for Apache Kafka®. При создании укажите настроенную группу безопасности.
   1. [Создайте пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) Apache Kafka®.
   1. В той же сети, что и кластер Managed Service for Apache Kafka®, [создайте кластер](../operations/kubernetes-cluster/kubernetes-cluster-create.md) Managed Service for Kubernetes. При создании укажите настроенную группу безопасности и предоставьте кластеру публичный адрес.
   1. [Создайте группу узлов](../operations/node-group/node-group-create.md) в кластере Managed Service for Kubernetes. При создании укажите настроенную группу безопасности.

- Terraform {#tf}

   1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
   1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
   1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.
   1. Скачайте в ту же рабочую директорию файл конфигурации [kafka-ui-via-kubernetes.tf](https://github.com/yandex-cloud-examples/yc-deploy-kafka-ui/blob/main/kafka-ui-via-kubernetes.tf).

      В этом файле описаны:

      * Сеть.
      * Подсеть.
      * Группа безопасности по умолчанию и правила, необходимые для подключения из интернета:

         * к кластеру Managed Service for Apache Kafka®;
         * к кластеру Managed Service for Kubernetes;
         * к группе узлов Managed Service for Kubernetes.

      * Кластер Managed Service for Apache Kafka®.
      * Пользователь Apache Kafka®.
      * Кластер Managed Service for Kubernetes.
      * Группа узлов Managed Service for Kubernetes.

   1. Укажите значения переменных в файле `kafka-ui-via-kubernetes.tf`.
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

### Установите дополнительные зависимости {#infra-for-kubernetes}

На локальной машине:

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../operations/connect/index.md#kubectl-connect).
1. Чтобы проверить доступность кластера Managed Service for Apache Kafka®, подключитесь к одному из его хостов с ролью `KAFKA`:

   ```bash
   telnet <FQDN_хоста> 9091
   ```

   FQDN доступен в консоли управления:

      1. Перейдите на страницу кластера.
      1. Перейдите в раздел **Хосты**.
      1. Скопируйте значение в столбце **FQDN хоста**, в строке хоста с ролью `KAFKA`.

   Если кластер доступен, появится сообщение:

   ```text
   Connected to <FQDN_хоста>
   ```

   После этого выполнение команды можно прервать, так как далее она не завершается, а ожидает передачи данных.

1. Установите утилиту `keytool` для управления ключами и сертификатами:

   ```bash
   sudo apt update && sudo apt install openjdk-19-jre-headless
   ```

### Создайте хранилище сертификатов TrustStore {#truststore-for-kubernetes}

При развертывании Apache Kafka® в кластере Managed Service for Kubernetes команды для TrustStore выполняются на локальной машине.

TrustStore — это хранилище доверенных сертификатов, которое используется в файлах JKS (Java KeyStore). Оно применяется для аутентификации клиента при его подключении к серверу. Сервер валидирует клиента с помощью сертификатов, которые хранятся в TrustStore. При этом клиент хранит приватный ключ и сертификат на своей стороне, в хранилище KeyStore.

В примере ниже TrustStore используется, чтобы подключиться к кластеру Managed Service for Apache Kafka®. Без создания TrustStore в веб-интерфейсе Apache Kafka® не появится информация о кластере.

Чтобы использовать TrustStore:

1. Создайте SSL-сертификат:

   ```bash
   sudo mkdir -p /usr/local/share/ca-certificates/Yandex/ && \
   sudo wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
        --output-document /usr/local/share/ca-certificates/Yandex/YandexCA.crt && \
   sudo chmod 0655 /usr/local/share/ca-certificates/Yandex/YandexCA.crt
   ```

1. Создайте директорию `/truststore`:

   ```bash
   mkdir /truststore
   ```

   В ней будет храниться файл `truststore.jks`. Отдельная директория нужна, чтобы далее путь к файлу был корректно распознан в командах и конфигурационных файлах.

1. Загрузите сертификат `YandexCA.crt` в файл `truststore.jks`:

   ```bash
   sudo keytool -import \
                -file /usr/local/share/ca-certificates/Yandex/YandexCA.crt \
                -alias "kafka-ui-cert" \
                -keystore /truststore/truststore.jks
   ```

   Команда предложит создать пароль. Запомните его — он понадобится для развертывания веб-интерфейса Apache Kafka®.

### Разверните приложение с веб-интерфейсом Apache Kafka® в поде Kubernetes {#application-in-pod}

1. Чтобы передать поду Kubernetes файл `truststore.jks`, создайте [секрет](https://kubernetes.io/docs/concepts/configuration/secret/) с этим файлом:

   ```bash
   kubectl create secret generic truststore --from-file=/truststore/truststore.jks
   ```

1. Создайте файл `kafka-ui-configMap.yaml` с конфигурацией [configMap](https://kubernetes.io/docs/concepts/configuration/configmap/). Она содержит информацию о кластере Managed Service for Apache Kafka® и хранилище TrustStore:

   ```yaml
   apiVersion: v1
   kind: ConfigMap
   metadata:
      name: kafka-ui-values
   data:
      KAFKA_CLUSTERS_0_NAME: <имя_кластера_Apache Kafka®>
      KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS: <FQDN_хоста>:9091
      KAFKA_CLUSTERS_0_PROPERTIES_SECURITY_PROTOCOL: SASL_SSL
      KAFKA_CLUSTERS_0_PROPERTIES_SASL_MECHANISM: PLAIN
      KAFKA_CLUSTERS_0_PROPERTIES_CLIENT_DNS_LOOKUP: use_all_dns_ips
      KAFKA_CLUSTERS_0_PROPERTIES_SASL_JAAS_CONFIG: 'org.apache.kafka.common.security.plain.PlainLoginModule required username="<логин_пользователя>" password="<пароль_пользователя>";'
      KAFKA_CLUSTERS_0_PROPERTIES_SSL_TRUSTSTORE_LOCATION: /truststore/truststore.jks
      KAFKA_CLUSTERS_0_PROPERTIES_SSL_TRUSTSTORE_PASSWORD: <пароль_для_TrustStore>
      AUTH_TYPE: "DISABLED"
      MANAGEMENT_HEALTH_LDAP_ENABLED: "FALSE"
   ```

   Укажите в переменных окружения:

   * `KAFKA_CLUSTERS_0_NAME` — имя кластера Managed Service for Apache Kafka®.
   * `KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS` — FQDN хоста с ролью `KAFKA` в кластере Managed Service for Apache Kafka®.
   * `KAFKA_CLUSTERS_0_PROPERTIES_SASL_JAAS_CONFIG`, `username` — логин пользователя Apache Kafka®.
   * `KAFKA_CLUSTERS_0_PROPERTIES_SASL_JAAS_CONFIG`, `password` — пароль пользователя Apache Kafka®.
   * `KAFKA_CLUSTERS_0_PROPERTIES_SSL_TRUSTSTORE_PASSWORD` — пароль, который вы задали во время создания файла `truststore.jks`.

1. Создайте файл `kafka-ui-pod.yaml` с конфигурацией пода, в котором будет развернуто приложение с веб-интерфейсом Apache Kafka®:

   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
      name: kafka-ui-pod
   spec:
      containers:
      - name: kafka-ui-pod
        image: provectuslabs/kafka-ui
        envFrom:
           - configMapRef:
                name: kafka-ui-values
        volumeMounts:
        - name: truststore
          mountPath: "/truststore"
          readOnly: true
      volumes:
      - name: truststore
        secret:
           secretName: truststore
      - name: kafka-ui-configmap
        configMap:
           name: kafka-ui-values
   ```

1. Примените конфигурацию configMap:

   ```bash
   kubectl apply -f kafka-ui-configMap.yaml
   ```

1. Примените конфигурацию пода:

   ```bash
   kubectl apply -f kafka-ui-pod.yaml
   ```

### Проверьте результат {#check-result}

1. Посмотрите логи пода и убедитесь, что веб-интерфейс Apache Kafka® развернут успешно:

   ```bash
   kubectl logs kafka-ui-pod
   ```

   Результат содержит строки:

   ```text
    _   _ ___    __             _                _          _  __      __ _
   | | | |_ _|  / _|___ _ _    /_\  _ __ __ _ __| |_  ___  | |/ /__ _ / _| |_____
   | |_| || |  |  _/ _ | '_|  / _ \| '_ / _` / _| ' \/ -_) | ' </ _` |  _| / / _`|
    \___/|___| |_| \___|_|   /_/ \_| .__\__,_\__|_||_\___| |_|\_\__,_|_| |_\_\__,|
                                    |_|                                             

   2024-01-23 12:13:25,648 INFO  [background-preinit] o.h.v.i.u.Version: HV000001: Hibernate Validator 8.0.0.Final
   2024-01-23 12:13:25,745 INFO  [main] c.p.k.u.KafkaUiApplication: Starting KafkaUiApplication using Java 17.0.6 with PID 1 (/kafka-ui-api.jar started by kafkaui in /)
   2024-01-23 12:13:25,746 DEBUG [main] c.p.k.u.KafkaUiApplication: Running with Spring Boot v3.0.6, Spring v6.0.8
   2024-01-23 12:13:25,747 INFO  [main] c.p.k.u.KafkaUiApplication: No active profile set, falling back to 1 default profile: "default"
   ```

1. Назначьте веб-интерфейс Apache Kafka® на порт `8080`:

   ```bash
   kubectl --namespace default port-forward kafka-ui-pod 8080:8080
   ```

1. В браузере перейдите по адресу `http://127.0.0.1:8080/`. Откроется веб-интерфейс Apache Kafka® с данными о кластере Managed Service for Apache Kafka®.


## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

   Удалите:

   
   1. [Кластер](../../managed-kafka/operations/cluster-delete.md) Managed Service for Apache Kafka®.
   1. [Виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
   1. [Группу узлов](../operations/node-group/node-group-delete.md) Managed Service for Kubernetes.
   1. [Кластер](../operations/kubernetes-cluster/kubernetes-cluster-delete.md) Managed Service for Kubernetes.


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