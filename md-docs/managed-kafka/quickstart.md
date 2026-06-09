# Как начать работать с {{ mkf-name }}

Чтобы начать работу с сервисом:
1. [Создайте кластер](#cluster-create).
1. [Создайте топик](#topic-create).
1. [Создайте пользователя](#account-create).
1. [Подключитесь к кластеру](#connect).


## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужное [облако](../resource-manager/concepts/resources-hierarchy.md#cloud).
   1. Справа от названия облака нажмите ![image](../_assets/console-icons/ellipsis.svg).
   1. Выберите ![image](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   
      ![create-folder1](../_assets/resource-manager/create-folder-1.png)
   
   1. Введите имя [каталога](../resource-manager/concepts/resources-hierarchy.md#folder). Требования к имени:
   
       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.
   
   1. (Опционально) Введите описание каталога.
   1. Выберите опцию **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}**. Будет создана [сеть](../vpc/concepts/network.md#network) с подсетями в каждой зоне доступности. Также в этой сети будет создана [группа безопасности по умолчанию](../vpc/concepts/security-groups.md#default-security-group), внутри которой весь сетевой трафик разрешен.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.
   
      ![create-folder2](../_assets/resource-manager/create-folder-2.png)

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) и роль [{{ roles.mkf.editor }} или выше](security/index.md#roles-list). Эти роли позволяют создать кластер.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

1. Подключаться к кластеру {{ KF }} можно как изнутри, так и извне {{ yandex-cloud }}:

   * Чтобы подключиться изнутри {{ yandex-cloud }}, создайте виртуальную машину на основе [Linux](../compute/quickstart/quick-create-linux.md) в той же сети, что и кластер.

   * Чтобы подключиться к кластеру из интернета, включите публичный доступ к кластеру при его [создании](operations/cluster-create.md).

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к ВМ по [SSH](../glossary/ssh-keygen.md).

   {% note info %}

   Предполагается, что подключение к кластеру производится с ВМ на основе [Linux](../compute/quickstart/quick-create-linux.md).

   {% endnote %}

1. Установите утилиту `kafkacat` — приложение с открытым исходным кодом, которое может работать как универсальный производитель или потребитель данных:

   ```bash
   sudo apt-get install kafkacat
   ```

   Убедитесь, что можете с ее помощью [подключиться к кластеру-источнику {{ mkf-name }} через SSL](operations/connect/clients.md#bash-zsh).


## Создайте кластер {#cluster-create}

Чтобы создать кластер:
1. В консоли управления выберите каталог, в котором нужно создать кластер.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Задайте параметры кластера и нажмите кнопку **{{ ui-key.yacloud.common.create }}**. Процесс подробно рассмотрен в разделе [Создание кластера](operations/cluster-create.md).
1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ mkf-name }} сменится на `Running`, а состояние — на `Alive`. Это может занять некоторое время.

Затем создайте топик в кластере.

## Создайте топик {#topic-create}

[Топик](concepts/topics.md) — это способ группировки потоков сообщений по категориям. [Производители](concepts/producers-consumers.md) пишут сообщения в топик, а [потребители](concepts/producers-consumers.md) читают сообщения из него.

Чтобы создать топик:
1. В консоли управления выберите каталог, в котором находится кластер.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
1. Нажмите на имя созданного ранее кластера, затем выберите вкладку **{{ ui-key.yacloud.kafka.label_topics }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.kafka.button_create-topic }}**.
1. Задайте настройки топика и нажмите кнопку **{{ ui-key.yacloud.common.create }}**. Процесс подробно рассмотрен в разделе [{#T}](operations/cluster-topics.md).

Затем создайте пользователей для производителей и потребителей.

## Создайте пользователя {#account-create}

Настройки пользователей разграничивают права доступа [производителей и потребителей](concepts/producers-consumers.md) к топикам в кластере.

[Подробнее](concepts/account-roles.md) о правах, которые предоставляет каждая роль.

Чтобы создать пользователя:
1. В консоли управления выберите каталог, в котором находится кластер.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
1. Нажмите на имя созданного ранее кластера, затем выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_users }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
1. Введите имя пользователя и пароль (от 8 до 128 символов).
1. Нажмите кнопку **![image](../_assets/console-icons/plus.svg) {{ ui-key.yacloud.kafka.button_add-topic }}** и выберите созданный ранее топик из выпадающего списка.
1. Добавьте права на доступ к этому топику для производителя и потребителя. Процесс подробно рассмотрен в разделе [Управление пользователями](operations/cluster-accounts.md).
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-button_add }}**.

Затем подключитесь к кластеру, используя это имя пользователя.

## Подключитесь к кластеру {#connect}

Вы можете подключить производителя и потребителя к кластеру от имени одного пользователя. И производитель и потребитель смогут работать только с теми топиками, доступ к которым разрешен для данного пользователя.

Чтобы подключиться к кластеру:


1. Если вы используете группы безопасности для облачной сети, [настройте их](operations/connect/index.md#configuring-security-groups) так, чтобы был разрешен весь необходимый трафик между кластером и хостом, с которого выполняется подключение.


1. Установите на ВМ SSL-сертификат:

   {% list tabs group=operating_system %}
   
   - Linux (Bash)/macOS (Zsh) {#linux-macos}
   
      ```bash
      mkdir -p {{ crt-local-dir }} && \
      wget "{{ crt-web-path }}" \
           --output-document {{ crt-local-dir }}{{ crt-local-file }} && \
      chmod 0655 {{ crt-local-dir }}{{ crt-local-file }}
      ```
   
      Сертификат будет сохранен в файле `{{ crt-local-dir }}{{ crt-local-file }}`.
   
   - Windows (PowerShell) {#windows}
   
      ```powershell
      mkdir $HOME\.kafka; curl.exe -o $HOME\.kafka\{{ crt-local-file }} {{ crt-web-path }}
      ```
   
      Сертификат будет сохранен в файле `$HOME\.kafka\{{ crt-local-file }}`.
   
      Корпоративные политики и антивирус могут блокировать скачивание сертификата. Подробнее в разделе [Вопросы и ответы](qa/index.md#get-ssl-error).
   
   {% endlist %}

1. Чтобы отправить сообщение в топик, выполните команду:

   ```bash
   echo "test message" | kafkacat -P \
       -b <FQDN_брокера>:9091 \
       -t <имя_топика> \
       -k key \
       -X security.protocol=SASL_SSL \
       -X sasl.mechanism=SCRAM-SHA-512 \
       -X sasl.username="<логин_производителя>" \
       -X sasl.password="<пароль_производителя>" \
       -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
   ```

   В команде укажите FQDN брокера, имя топика, логин и пароль пользователя {{ KF }}, созданного ранее.

   Как получить FQDN хоста-брокера, читайте в [инструкции](operations/connect/index.md#get-fqdn).

1. Чтобы получить сообщения из топика, выполните команду:

   ```bash
   kafkacat -C \
            -b <FQDN_брокера>:9091 \
            -t <имя_топика> \
            -X security.protocol=SASL_SSL \
            -X sasl.mechanism=SCRAM-SHA-512 \
            -X sasl.username="<логин_потребителя>" \
            -X sasl.password="<пароль_потребителя>" \
            -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z -K:
   ```

   В команде укажите FQDN брокера, имя топика, логин и пароль пользователя {{ KF }}, созданного ранее.

   Как получить FQDN хоста-брокера, читайте в [инструкции](operations/connect/index.md#get-fqdn).

Подробно процесс подключения к кластеру {{ mkf-name }} рассмотрен в разделе [Подключение к топикам в кластере](operations/connect/clients.md).

## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) и [подключении к кластеру](operations/connect/index.md).