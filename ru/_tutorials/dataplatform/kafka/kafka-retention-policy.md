# Отслеживание утери сообщений в топике {{ KF }}

Утеря сообщений в топике {{ KF }} группой потребителей возникает из-за сочетания двух факторов:
1. В этом топике или во всем кластере включена политика очистки лога `Delete` и задано малое время жизни сегмента лога `Log retention`.
2. Одна или несколько групп потребителей недостаточно быстро вычитывают сообщения из топика. В результате могут быть удалены даже те сообщения, которые еще не были прочитаны. 

Утерю сообщений можно отслеживать с помощью [метрик](../../../managed-kafka/metrics.md) сервиса {{ mkf-name }}, поставляемых в [{{ monitoring-name }}](../../../monitoring/concepts/index.md). Если значение `kafka_group_topic_partition_offset` становится меньше `kafka_log_Log_LogStartOffset`, это указывает на утерю сообщений группой потребителей.

В этом руководстве вы:
* Смоделируете утерю сообщений в топике на тестовом кластере {{ mkf-name }}, используя [инструменты подключения к топику](https://kafka.apache.org/downloads).
* Построите график метрик `kafka_group_topic_partition_offset`, `kafka_log_Log_LogStartOffset` и `kafka_log_Log_LogEndOffset` с помощью сервиса {{ monitoring-full-name }}, а также проследите закономерности, возникающие при утере сообщений.

Чтобы смоделировать и отследить утерю сообщений в топике {{ KF }}:

1. [Подготовьте инструменты для подключения к топику](#test-cluster-prepare).
1. [Подготовьте команды для отправки и получения сообщений](#prepare-commands).
1. [Запустите команду получения сообщений](#start-receive).
1. [Создайте графики мониторинга](#create-chart).
1. [Проверьте отправку и получение сообщения](#send-message).
1. [Включите удаление сообщений](#activate-retention-policy).
1. [Повторно проверьте отправку и получение сообщения](#send-second-message).
1. [Проанализируйте графики мониторинга](#check-charts).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ KF }}: использование вычислительных ресурсов, выделенных хостам (в том числе хостам ZooKeeper), и дискового пространства (см. [тарифы {{ KF }}](../../../managed-kafka/pricing.md)).
* Плата за использование публичных IP-адресов для хостов кластеров (см. [тарифы {{ vpc-name }}](../../../vpc/pricing.md)).

## Перед началом работы {#before-you-begin}

1. [Создайте кластер {{ mkf-name }}](../../../managed-kafka/operations/cluster-create.md) любой подходящей конфигурации. При создании кластера включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.
1. [Создайте топик](../../../managed-kafka/operations/cluster-topics.md#create-topic) для обмена сообщениями между производителем и потребителем со следующими параметрами:
    * **{{ ui-key.yacloud.common.name }}** — `messages`;
    * **{{ ui-key.yacloud.kafka.label_partitions }}** — `1`.
1. [Создайте пользователя](../../../managed-kafka/operations/cluster-accounts.md#create-account) с именем `user` и [выдайте ему права](../../../managed-kafka/operations/cluster-accounts.md#grant-permission) на топик `messages`:
    * `ACCESS_ROLE_CONSUMER`,
    * `ACCESS_ROLE_PRODUCER`.
1. [Настройте группы безопасности](../../../managed-kafka/operations/connect/index.md#configuring-security-groups).
1. [Получите SSL-сертификат](../../../managed-kafka/operations/connect/index.md#get-ssl-cert).
   
   {% note info %}

   Подключение к хостам в публичном доступе возможно только с использованием SSL-сертификата.

   {% endnote %}

1. Выберите один из хостов кластера с ролью `KAFKA` и получите его [FQDN](../../../managed-kafka/operations/connect/index.md#get-fqdn).
1. Выберите имя для группы потребителей, например `test-consumer-group`.

## Подготовьте инструменты для подключения к топику {#test-cluster-prepare}

{% list tabs group=instructions %}

- CLI для Bash {#bash}

    1. Установите OpenJDK:

       ```bash
       sudo apt update && sudo apt install --yes default-jdk
       ```

    1. Загрузите [архив с бинарными файлами](https://kafka.apache.org/downloads) для версии {{ KF }}, которая используется в кластере. Версия Scala не важна.

    1. Распакуйте архив.

    1. Перейдите в каталог, где будет располагаться хранилище сертификатов Java:

       ```bash
       cd /etc/security
       ```

    1. {% include [keytool-importcert](../../../_includes/mdb/keytool-importcert.md) %}

    1. Создайте файл с параметрами для подключения к кластеру.

       {% note info %}

       В этом руководстве для простоты используется единственный пользователь, являющийся и производителем, и потребителем. Поэтому достаточно создать только один файл параметров, который будет использоваться и при отправке, и при получении сообщений.

       {% endnote %}

       ```ini
       sasl.mechanism=SCRAM-SHA-512
       sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
         username="user" \
         password="<пароль_пользователя_user>";
       security.protocol=SASL_SSL
       ssl.truststore.location=/etc/security/ssl
       ssl.truststore.password=<пароль_хранилища_сертификатов>
       ```

- CLI для PowerShell {#powershell}

    1. Установите последнюю доступную версию [Microsoft OpenJDK](https://docs.microsoft.com/en-us/java/openjdk/download).

    1. Загрузите [архив с бинарными файлами](https://kafka.apache.org/downloads) для версии {{ KF }}, которая используется в кластере. Версия Scala не важна.

    1. Распакуйте архив.

       {% note tip %}

       Распаковывайте файлы {{ KF }} в корневой каталог диска, например, `C:\kafka_2.12-2.6.0\`.

       Если путь к исполняемым и пакетным файлам {{ KF }} будет слишком длинным, то при попытке запустить их возникнет ошибка `The input line is too long`.

       {% endnote %}

    1. Добавьте SSL-сертификат в хранилище доверенных сертификатов Java (Java Key Store), чтобы драйвер {{ KF }} мог использовать этот сертификат при защищенном подключении к хостам кластера. Задайте пароль в параметре `--storepass` для дополнительной защиты хранилища:

       ```powershell
       keytool.exe -importcert -alias {{ crt-alias }} `
       --file $HOME\.kafka\{{ crt-local-file }} `
       --keystore $HOME\.kafka\ssl `
       --storepass <пароль_хранилища_сертификатов> `
       --noprompt
       ```

    1. Создайте файл с параметрами для подключения к кластеру.

       {% note info %}

       В этом руководстве для простоты используется единственный пользователь, являющийся и производителем, и потребителем. Поэтому достаточно создать только один файл параметров, который будет использоваться и при отправке, и при получении сообщений.

       {% endnote %}

       ```ini
       sasl.mechanism=SCRAM-SHA-512
       sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
         username="user" \
         password="<пароль_пользователя_user>";
       security.protocol=SASL_SSL
       ssl.truststore.location=<значение_переменной_$HOME>\\.kafka\\ssl
       ssl.truststore.password=<пароль_хранилища_сертификатов>
       ```

       В качестве значения параметра `ssl.truststore.location` укажите полный путь к хранилищу сертификатов, например:

       ```ini
       ssl.truststore.location=C:\\Users\\Administrator\\.kafka\\ssl
       ```

       Хранилище сертификатов расположено по пути `$HOME\.kafka\ssl`, но в значении нельзя использовать переменные среды окружения. Чтобы раскрыть переменную, выполните команду:

       ```powershell
       echo $HOME
       ```

       {% note warning %}

       Используйте `\\` вместо `\` при указании значения параметра `ssl.truststore.location`, иначе при запуске команд не удастся получить доступ к хранилищу сертификатов.

       {% endnote %}

{% endlist %}

## Подготовьте команды для отправки и получения сообщений {#prepare-commands}

{% list tabs group=instructions %}

- CLI для Bash {#bash}

    * Команда отправки сообщения в топик `messages`:

        ```bash
        echo "key:test message" | <путь_к_директории_с_файлами_Apache_Kafka>/bin/kafka-console-producer.sh \
          --producer.config <путь_к_файлу_с_параметрами> \
          --bootstrap-server <FQDN_хоста>:9091 \
          --topic messages \
          --property parse.key=true \
          --property key.separator=":"
        ```

    * Команда получения сообщений из топика `messages`:

        ```bash
        <путь_к_директории_с_файлами_Apache_Kafka>/bin/kafka-console-consumer.sh \
          --consumer.config <путь_к_файлу_с_параметрами> \
          --bootstrap-server <FQDN_хоста>:9091 \
          --group test-consumer-group \
          --topic messages \
          --property print.key=true \
          --property key.separator=":"
        ```

- CLI для PowerShell {#powershell}

    * Команда отправки сообщения в топик `messages`:

        ```powershell
        echo "key:test message" | <путь_к_директории_с_файлами_Apache_Kafka>\bin\windows\kafka-console-producer.bat `
            --producer.config <путь_к_файлу_с_параметрами> `
            --bootstrap-server <FQDN_хоста>:9091 `
            --topic messages `
            --property parse.key=true `
            --property key.separator=":"
        ```

    * Команда получения сообщений из топика `messages`:

        ```powershell
        <путь_к_директории_с_файлами_Apache_Kafka>\bin\windows\kafka-console-consumer.bat `
            --consumer.config <путь_к_файлу_с_параметрами> `
            --bootstrap-server <FQDN_хоста>:9091 `
            --group test-consumer-group `    
            --topic messages `
            --property print.key=true `
            --property key.separator=":"
        ```

{% endlist %}

## Запустите команду получения сообщений {#start-receive}

1. Запустите [команду получения сообщений](#prepare-commands).

2. Через 10–15 секунд прервите команду, нажав **Ctrl** + **C**. Проверьте, что в терминале появилось сообщение:

    ```
    Processed a total of 0 messages
    ```
   
   Это сообщение означает, что потребитель успешно подключился к топику.

3. Подтвердите завершение команды.

Теперь группа потребителей `test-consumer-group` зарегистрирована и может быть использована в качестве метки для метрик.

## Создайте графики мониторинга {#create-chart}

Используя сервис [{{ monitoring-full-name }}]({{ link-monitoring }}), [отобразите на одном графике](../../../monitoring/operations/metric/metric-explorer.md#add-graph) метрики `kafka_group_topic_partition_offset`, `kafka_log_Log_LogStartOffset` и `kafka_log_Log_LogEndOffset`:
* Для `kafka_group_topic_partition_offset` укажите метки:
    * `service = managed-kafka`,
    * `name = kafka_group_topic_partition_offset`,
    * `host = <FQDN_хоста>`,
    * `topic = messages`,
    * `group = test-consumer-group`.
* Для `kafka_log_Log_LogStartOffset` укажите метки: 
    * `service = managed-kafka`,
    * `name = kafka_log_Log_LogStartOffset`,
    * `host = <FQDN_хоста>`,
    * `topic = messages`.
* Для `kafka_log_Log_LogEndOffset` укажите метки:
    * `service = managed-kafka`,
    * `name = kafka_log_Log_LogEndOffset`,
    * `host = <FQDN_хоста>`,
    * `topic = messages`.

{% note warning %}

Тестовый топик `messages` содержит только один раздел, поэтому метку `partition` можно не указывать. Если в вашем решении топик содержит несколько разделов, при построении графиков перечисленных метрик укажите метку `partition`.

{% endnote %}

{% note info %}

Для отслеживания утери сообщений достаточно только метрик `kafka_group_topic_partition_offset` и `kafka_log_Log_LogStartOffset`, но дополнительная метрика `kafka_log_Log_LogEndOffset` сделает график более наглядным.

{% endnote %}

## Проверьте отправку и получение сообщения {#send-message}

1. Запустите [команду отправки сообщения](#prepare-commands).

1. Спустя примерно 3 минуты запустите [команду получения сообщений](#prepare-commands). Проверьте, что в терминале отобразилось сообщение `key:test message`.

1. Нажмите **Ctrl** + **C**, чтобы прервать команду получения сообщений из топика. 

Поскольку удаление сообщений выключено, спустя три минуты сообщение все еще доступно для потребителей.

## Включите удаление сообщений {#activate-retention-policy}

[Задайте следующие настройки](../../../managed-kafka/operations/cluster-topics.md#update-topic) топика `messages`:

   * **{{ ui-key.yacloud.kafka.label_topic-cleanup-policy }}** — `Delete`;
   * **{{ ui-key.yacloud.kafka.label_topic-retention-ms }}** — `60000`.

{% note info %}

После изменения настроек топика кластер некоторое время будет обновляться.

{% endnote %}

Теперь сообщения будут автоматически удаляться через 60 секунд после их записи в топик.

## Повторно проверьте отправку и получение сообщения {#send-second-message}

1. Запустите [команду отправки сообщения](#prepare-commands).

1. Спустя примерно 3 минуты запустите [команду получения сообщений](#prepare-commands). Проверьте, что на этот раз сообщение не было получено.

1. Нажмите **Ctrl** + **C**, чтобы прервать команду получения сообщений из топика. 

Спустя 60 секунд после записи в топик все сообщения удаляются, поэтому для группы слишком «медленных» потребителей возникает ситуация утери сообщений.

## Проанализируйте графики мониторинга {#check-charts}

Перейдите в сервис [{{ monitoring-full-name }}]({{ link-monitoring }}) и проанализируйте поведение созданных ранее метрик:
* `kafka_log_Log_LogStartOffset` — первое смещение в разделе. Увеличивается при записи сообщений в топик.
* `kafka_log_Log_LogEndOffset` — последнее смещение в разделе. Увеличивается при удалении сообщений из топика.
* `kafka_group_topic_partition_offset` — текущее смещение группы потребителей в разделе. Увеличивается при вычитывании сообщений из топика группой потребителей.

На графике видны следующие закономерности:
1. В первый момент времени все три метрики имеют значение `0`.
1. После [отправки первого сообщения](#send-message) значение `kafka_log_Log_LogEndOffset` вырастает до `1`.
1. Через 3 минуты, в момент получения первого сообщения, `kafka_group_topic_partition_offset` также вырастает до `1`. Поскольку сообщения не удаляются, `kafka_log_Log_LogStartOffset` остается равным `0`.
1. Через минуту после [включения удаления сообщений](#activate-retention-policy) сообщение удаляется из топика, и `kafka_log_Log_LogStartOffset` принимает значение `1`. Теперь все три метрики имеют значение `1`.
1. После [отправки второго сообщения](#send-second-message) значение `kafka_log_Log_LogEndOffset` вырастает до `2`. Через минуту сообщение удаляется из топика, и `kafka_log_Log_LogStartOffset` также принимает значение `2`. При этом `kafka_group_topic_partition_offset` все еще имеет значение `1`.
1. При втором запуске команды получения сообщений значение `kafka_group_topic_partition_offset` также вырастает до `2`, хотя сообщение не получено.

Выводы:
1. В норме значение `kafka_group_topic_partition_offset` находится между значениями `kafka_log_Log_LogStartOffset` и `kafka_log_Log_LogEndOffset`. Если `kafka_group_topic_partition_offset` становится меньше `kafka_log_Log_LogStartOffset`, это указывает на утерю сообщений этой группой потребителей.
1. Разница между значениями `kafka_log_Log_LogEndOffset` и `kafka_group_topic_partition_offset` показывает, сколько новых сообщений пока не вычитано (т. е. насколько группа потребителей отстает от производителей).

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

* [Удалите кластер {{ mkf-name }}](../../../managed-kafka/operations/cluster-delete.md).
* Освободите и [удалите](../../../vpc/operations/address-delete.md) публичные статические IP-адреса.
