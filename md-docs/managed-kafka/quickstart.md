[Документация Yandex Cloud](../index.md) > [Yandex Managed Service for Apache Kafka®](index.md) > Начало работы

# Как начать работать с Managed Service for Apache Kafka®

Чтобы начать работу с сервисом:
1. [Создайте кластер](#cluster-create).
1. [Создайте топик](#topic-create).
1. [Создайте пользователя](#account-create).
1. [Подключитесь к кластеру](#connect).


## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужное [облако](../resource-manager/concepts/resources-hierarchy.md#cloud).
   1. Справа от названия облака нажмите ![image](../_assets/console-icons/ellipsis.svg).
   1. Выберите ![image](../_assets/console-icons/plus.svg) **Создать каталог**.
   
      ![create-folder1](../_assets/resource-manager/create-folder-1.png)
   
   1. Введите имя [каталога](../resource-manager/concepts/resources-hierarchy.md#folder). Требования к имени:
   
       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.
   
   1. (Опционально) Введите описание каталога.
   1. Выберите опцию **Создать сеть по умолчанию**. Будет создана [сеть](../vpc/concepts/network.md#network) с подсетями в каждой зоне доступности. Также в этой сети будет создана [группа безопасности по умолчанию](../vpc/concepts/security-groups.md#default-security-group), внутри которой весь сетевой трафик разрешен.
   1. Нажмите кнопку **Создать**.
   
      ![create-folder2](../_assets/resource-manager/create-folder-2.png)

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роли:

    * [managed-kafka.editor](security/index.md#roles-list) или выше — чтобы создать кластер;
    * [vpc.user](../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../vpc/concepts/network.md#network) кластера;
    * [mdb.viewer](../iam/roles-reference.md#mdb-viewer) — чтобы просматривать кластеры управляемых баз данных (MDB) на дашборде в [консоли управления](https://console.yandex.cloud).

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

1. Подключаться к кластеру Apache Kafka® можно как изнутри, так и извне Yandex Cloud:

   * Чтобы подключиться изнутри Yandex Cloud, создайте виртуальную машину на основе [Linux](../compute/quickstart/quick-create-linux.md) в той же сети, что и кластер.

   * Чтобы подключиться к кластеру из интернета, включите публичный доступ к кластеру при его [создании](operations/cluster-create.md).

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к ВМ по [SSH](../glossary/ssh-keygen.md).

   {% note info %}

   Предполагается, что подключение к кластеру производится с ВМ на основе [Linux](../compute/quickstart/quick-create-linux.md).

   {% endnote %}

1. Установите утилиту `kafkactl` — интерфейс командной строки для взаимодействия с Apache Kafka®:

   ```bash
   wget https://github.com/deviceinsight/kafkactl/releases/download/v<номер_версии>/<имя_архива>.tar.gz
   tar xzf <имя_архива>.tar.gz kafkactl
   sudo mv kafkactl /usr/local/bin
   ```
   
   Версию и имя архива можно посмотреть на [странице релизов `kafkactl`](https://github.com/deviceinsight/kafkactl/releases).

   Убедитесь, что с помощью `kafkactl` можете [подключиться к кластеру-источнику Managed Service for Apache Kafka® через SSL](operations/connect/clients.md#kafkactl).


## Создайте кластер {#cluster-create}

Чтобы создать кластер:
1. В консоли управления выберите каталог, в котором нужно создать кластер.
1. Перейдите в сервис **Managed Service for&nbsp;Kafka**.
1. Нажмите кнопку **Создать кластер**.
1. Задайте параметры кластера и нажмите кнопку **Создать**. Процесс подробно рассмотрен в разделе [Создание кластера](operations/cluster-create.md).
1. Дождитесь, когда кластер будет готов к работе: его статус на панели Managed Service for Apache Kafka® сменится на `Running`, а состояние — на `Alive`. Это может занять некоторое время.

Затем создайте топик в кластере.

## Создайте топик {#topic-create}

[Топик](concepts/topics.md) — это способ группировки потоков сообщений по категориям. [Производители](concepts/producers-consumers.md) пишут сообщения в топик, а [потребители](concepts/producers-consumers.md) читают сообщения из него.

Чтобы создать топик:
1. В консоли управления выберите каталог, в котором находится кластер.
1. Перейдите в сервис **Managed Service for&nbsp;Kafka**.
1. Нажмите на имя созданного ранее кластера, затем выберите вкладку **Топики**.
1. Нажмите кнопку **Создать топик**.
1. Задайте настройки топика и нажмите кнопку **Создать**. Процесс подробно рассмотрен в разделе [Управление топиками Apache Kafka®](operations/cluster-topics.md).

Затем создайте пользователей для производителей и потребителей.

## Создайте пользователя {#account-create}

Настройки пользователей разграничивают права доступа [производителей и потребителей](concepts/producers-consumers.md) к топикам в кластере.

[Подробнее](concepts/account-roles.md) о правах, которые предоставляет каждая роль.

Чтобы создать пользователя:
1. В консоли управления выберите каталог, в котором находится кластер.
1. Перейдите в сервис **Managed Service for&nbsp;Kafka**.
1. Нажмите на имя созданного ранее кластера, затем выберите вкладку **Пользователи**.
1. Нажмите кнопку **Создать пользователя**.
1. Введите имя пользователя и пароль (от 8 до 128 символов).
1. Нажмите кнопку **![image](../_assets/console-icons/plus.svg) Добавить топик** и выберите созданный ранее топик из выпадающего списка.
1. Добавьте права на доступ к этому топику для производителя и потребителя. Процесс подробно рассмотрен в разделе [Управление пользователями](operations/cluster-accounts.md).
1. Нажмите кнопку **Создать**.

Затем подключитесь к кластеру, используя это имя пользователя.

## Подключитесь к кластеру {#connect}

Вы можете подключить производителя и потребителя к кластеру от имени одного пользователя. И производитель и потребитель смогут работать только с теми топиками, доступ к которым разрешен для данного пользователя.

Чтобы подключиться к кластеру:


1. Если вы используете группы безопасности для облачной сети, [настройте их](operations/connect/index.md#configuring-security-groups) так, чтобы был разрешен весь необходимый трафик между кластером и хостом, с которого выполняется подключение.


1. Установите на ВМ SSL-сертификат:

   {% list tabs group=operating_system %}
   
   - Linux (Bash)/macOS (Zsh) {#linux-macos}
   
      ```bash
      mkdir -p /usr/local/share/ca-certificates/Yandex/ && \
      wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
           --output-document /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt && \
      chmod 0655 /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
      ```
   
      Сертификат будет сохранен в файле `/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt`.
   
   - Windows (PowerShell) {#windows}
   
      ```powershell
      mkdir $HOME\.kafka; curl.exe -o $HOME\.kafka\YandexInternalRootCA.crt https://storage.yandexcloud.net/cloud-certs/CA.pem
      ```
   
      Сертификат будет сохранен в файле `$HOME\.kafka\YandexInternalRootCA.crt`.
   
      Корпоративные политики и антивирус могут блокировать скачивание сертификата. Подробнее в разделе [Вопросы и ответы](qa/index.md#get-ssl-error).
   
   {% endlist %}

1. Создайте каталог `~/.config/kafkactl` и поместите в него конфигурационный файл `config.yml` с параметрами подключения к кластеру Apache Kafka®:

   ```bash
   cd ~/ && \
   mkdir --parents .config/kafkactl && \
   cd ~/.config/kafkactl
   ```

   Пример файла `config.yml`:
   
   ```yaml
   contexts:
     default:
       brokers:
       - <FQDN_брокера>:9091
       sasl:
         enabled: true
         username: <логин_потребителя>
         password: <пароль_потребителя>
         mechanism: scram-sha512
       tls:
         enabled: true
         ca: /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
   ```

   В конфигурационном файле укажите FQDN брокера, а также логин и пароль пользователя Apache Kafka®, созданного ранее.

   Как получить FQDN хоста-брокера, читайте в [инструкции](operations/connect/index.md#get-fqdn).

1. Чтобы отправить сообщение в топик, выполните команду:

   ```bash
   echo "test message" | kafkactl produce <имя_топика>
   ```

1. Чтобы получить сообщения из топика, выполните команду:

   ```bash
   kafkactl consume <имя_топика>
   ```

Подробно процесс подключения к кластеру Managed Service for Apache Kafka® рассмотрен в разделе [Подключение к топикам в кластере](operations/connect/clients.md).

## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) и [подключении к кластеру](operations/connect/index.md).