# Развертывание веб-интерфейса {{ KF }}


Вы можете установить [веб-интерфейс {{ KF }}](https://docs.kafka-ui.provectus.io/overview/readme) для своего кластера {{ mkf-name }}. С помощью веб-интерфейса можно отслеживать потоки данных, находить и устранять неисправности, управлять [брокерами](../../managed-kafka/concepts/brokers.md), кластером, [производителями и потребителями](../../managed-kafka/concepts/producers-consumers.md).


Развернуть веб-интерфейс {{ KF }} можно двумя способами:

* В [Docker-контейнере](#docker) на виртуальной машине {{ yandex-cloud }}. Этот вариант дешевле, но менее надежный, поэтому подходит для знакомства с веб-интерфейсом {{ KF }}.
* В [кластере {{ managed-k8s-full-name }}](#kubernetes). Этот вариант дороже, но более надежный, поэтому подходит для постоянного и длительного использования веб-интерфейса.


## Развертывание в Docker-контейнере {#docker}

Чтобы развернуть веб-интерфейс {{ KF }} в Docker-контейнере:

1. [Установите дополнительные зависимости](#infra-for-docker).
1. [Создайте хранилище сертификатов TrustStore](#truststore-for-docker).
1. [Подготовьте веб-интерфейс {{ KF }}](#prepare-ui-via-docker).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

### Перед началом работы {#before-you-begin-to-work-with-docker}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

   
   1. [Настройте группу безопасности](../../managed-kafka/operations/connect/index.md#configuring-security-groups) для кластера {{ mkf-name }} и ВМ так, чтобы к топикам можно было подключаться с ВМ в Облаке.


   1. [Создайте кластер](../../managed-kafka/operations/cluster-create.md) {{ mkf-name }}. При создании укажите настроенную группу безопасности.
   1. [Создайте пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) {{ KF }}.
   1. В той же сети, что и кластер {{ mkf-name }}, [создайте ВМ](../../compute/operations/vm-create/create-linux-vm.md) с Ubuntu 22.04, публичным IP-адресом и настроенной группой безопасности.

- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
   1. Скачайте в ту же рабочую директорию файл конфигурации [kafka-ui-via-docker.tf](https://github.com/yandex-cloud-examples/yc-deploy-kafka-ui/blob/main/kafka-ui-via-docker.tf).

      В этом файле описаны:

      * сеть;
      * подсеть;
      * ВМ с Ubuntu 22.04;

      
      * группа безопасности по умолчанию и правила, необходимые для подключения к кластеру и виртуальной машине из интернета;


      * кластер {{ mkf-name }};
      * пользователь {{ KF }}.

   1. Укажите значения переменных в файле `kafka-ui-via-docker.tf`.
   1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

   1. Создайте необходимую инфраструктуру:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Установите дополнительные зависимости {#infra-for-docker}

1. [Подключитесь к ВМ по SSH](../../compute/operations/vm-connect/ssh.md#vm-connect):

   ```bash
   ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
   ```

   Где `<имя_пользователя>` — имя учетной записи пользователя ВМ. Публичный IP-адрес ВМ доступен в [консоли управления]({{ link-console-main }}), на странице ВМ.

1. Чтобы проверить доступность кластера {{ mkf-name }}, подключитесь к одному из его хостов с ролью `KAFKA`:

   ```bash
   telnet <FQDN_хоста> {{ port-mkf-ssl }}
   ```

   FQDN доступен в консоли управления:

      1. Перейдите на страницу кластера.
      1. Перейдите в раздел **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
      1. Скопируйте значение в столбце **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}**, в строке хоста с ролью `KAFKA`.

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

При развертывании {{ KF }} в Docker-контейнере команды для TrustStore выполняются на ВМ.

{% include [TrustStore](../../_includes/mdb/mkf/truststore.md) %}

### Подготовьте веб-интерфейс {{ KF }} {#prepare-ui-via-docker}

1. В ВМ запустите Docker-контейнер, в котором будет развернут веб-интерфейс:

   ```bash
   sudo docker run -it -p 8080:8080 \
      -e DYNAMIC_CONFIG_ENABLED=true \
      -e KAFKA_CLUSTERS_0_NAME=<имя_кластера> \
      -e KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS=<FQDN_хоста>:{{ port-mkf-ssl }} \
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

   * `KAFKA_CLUSTERS_0_NAME` — имя кластера {{ mkf-name }}.
   * `KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS` — FQDN хоста с ролью `KAFKA` в кластере {{ mkf-name }}.
   * `KAFKA_CLUSTERS_0_PROPERTIES_SASL_JAAS_CONFIG`, `username` — логин пользователя {{ KF }}.
   * `KAFKA_CLUSTERS_0_PROPERTIES_SASL_JAAS_CONFIG`, `password` — пароль пользователя {{ KF }}.
   * `KAFKA_CLUSTERS_0_PROPERTIES_SSL_TRUSTSTORE_PASSWORD` — пароль, который вы задали во время создания файла `truststore.jks`.

   После запуска команда не завершается. Пока она работает, доступен веб-интерфейс {{ KF }}.

1. На локальной машине в браузере перейдите по адресу `http://<публичный_IP-адрес_ВМ>:8080`. Откроется веб-интерфейс {{ KF }} с данными о кластере {{ mkf-name }}.

   Публичный IP-адрес ВМ доступен в консоли управления, на странице ВМ.


## Развертывание в кластере {{ managed-k8s-name }} {#kubernetes}

Чтобы развернуть веб-интерфейс {{ KF }} в кластере {{ managed-k8s-name }}:

1. [Установите дополнительные зависимости](#infra-for-kubernetes).
1. [Создайте хранилище сертификатов TrustStore](#truststore-for-kubernetes).
1. [Разверните приложение с веб-интерфейсом {{ KF }} в поде {{ k8s }}](#application-in-pod).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

### Перед началом работы {#before-you-begin-to-work-with-kubernetes}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

   1. Настройте единую группу безопасности:

      * [Для кластера {{ mkf-name }}](../../managed-kafka/operations/connect/index.md#configuring-security-groups) так, чтобы можно было подключаться к топикам через интернет.
      * [Для кластера и группы узлов](../../managed-kubernetes/operations/connect/security-groups.md) {{ managed-k8s-name }}.

   1. [Создайте кластер](../../managed-kafka/operations/cluster-create.md) {{ mkf-name }}. При создании укажите настроенную группу безопасности.
   1. [Создайте пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) {{ KF }}.
   1. В той же сети, что и кластер {{ mkf-name }}, [создайте кластер](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) {{ managed-k8s-name }}. При создании укажите настроенную группу безопасности и предоставьте кластеру публичный адрес.
   1. [Создайте группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) в кластере {{ managed-k8s-name }}. При создании укажите настроенную группу безопасности.

- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
   1. Скачайте в ту же рабочую директорию файл конфигурации [kafka-ui-via-kubernetes.tf](https://github.com/yandex-cloud-examples/yc-deploy-kafka-ui/blob/main/kafka-ui-via-kubernetes.tf).

      В этом файле описаны:

      * Сеть.
      * Подсеть.
      * Группа безопасности по умолчанию и правила, необходимые для подключения из интернета:

         * к кластеру {{ mkf-name }};
         * к кластеру {{ managed-k8s-name }};
         * к группе узлов {{ managed-k8s-name }}.

      * Кластер {{ mkf-name }}.
      * Пользователь {{ KF }}.
      * Кластер {{ managed-k8s-name }}.
      * Группа узлов {{ managed-k8s-name }}.

   1. Укажите значения переменных в файле `kafka-ui-via-kubernetes.tf`.
   1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

   1. Создайте необходимую инфраструктуру:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Установите дополнительные зависимости {#infra-for-kubernetes}

На локальной машине:

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}
1. Чтобы проверить доступность кластера {{ mkf-name }}, подключитесь к одному из его хостов с ролью `KAFKA`:

   ```bash
   telnet <FQDN_хоста> {{ port-mkf-ssl }}
   ```

   FQDN доступен в консоли управления:

      1. Перейдите на страницу кластера.
      1. Перейдите в раздел **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
      1. Скопируйте значение в столбце **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}**, в строке хоста с ролью `KAFKA`.

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

При развертывании {{ KF }} в кластере {{ managed-k8s-name }} команды для TrustStore выполняются на локальной машине.

{% include [TrustStore](../../_includes/mdb/mkf/truststore.md) %}

### Разверните приложение с веб-интерфейсом {{ KF }} в поде {{ k8s }} {#application-in-pod}

1. Чтобы передать поду {{ k8s }} файл `truststore.jks`, создайте [секрет](https://kubernetes.io/docs/concepts/configuration/secret/) с этим файлом:

   ```bash
   kubectl create secret generic truststore --from-file=/truststore/truststore.jks
   ```

1. Создайте файл `kafka-ui-configMap.yaml` с конфигурацией [configMap](https://kubernetes.io/docs/concepts/configuration/configmap/). Она содержит информацию о кластере {{ mkf-name }} и хранилище TrustStore:

   ```yaml
   apiVersion: v1
   kind: ConfigMap
   metadata:
      name: kafka-ui-values
   data:
      KAFKA_CLUSTERS_0_NAME: <имя_кластера_{{ KF }}>
      KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS: <FQDN_хоста>:{{ port-mkf-ssl }}
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

   * `KAFKA_CLUSTERS_0_NAME` — имя кластера {{ mkf-name }}.
   * `KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS` — FQDN хоста с ролью `KAFKA` в кластере {{ mkf-name }}.
   * `KAFKA_CLUSTERS_0_PROPERTIES_SASL_JAAS_CONFIG`, `username` — логин пользователя {{ KF }}.
   * `KAFKA_CLUSTERS_0_PROPERTIES_SASL_JAAS_CONFIG`, `password` — пароль пользователя {{ KF }}.
   * `KAFKA_CLUSTERS_0_PROPERTIES_SSL_TRUSTSTORE_PASSWORD` — пароль, который вы задали во время создания файла `truststore.jks`.

1. Создайте файл `kafka-ui-pod.yaml` с конфигурацией пода, в котором будет развернуто приложение с веб-интерфейсом {{ KF }}:

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

1. Посмотрите логи пода и убедитесь, что веб-интерфейс {{ KF }} развернут успешно:

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

1. Назначьте веб-интерфейс {{ KF }} на порт `8080`:

   ```bash
   kubectl --namespace default port-forward kafka-ui-pod 8080:8080
   ```

1. В браузере перейдите по адресу `http://127.0.0.1:8080/`. Откроется веб-интерфейс {{ KF }} с данными о кластере {{ mkf-name }}.


## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

   Удалите:

   
   1. [Кластер](../../managed-kafka/operations/cluster-delete.md) {{ mkf-name }}.
   1. [Виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
   1. [Группу узлов](../../managed-kubernetes/operations/node-group/node-group-delete.md) {{ managed-k8s-name }}.
   1. [Кластер](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) {{ managed-k8s-name }}.


- {{ TF }} {#tf}

   {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
