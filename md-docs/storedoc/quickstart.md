# Как начать работать с {{ mmg-name }}

Чтобы начать работу с сервисом:


* [Создайте кластер](#cluster-create).
* [Подключитесь к БД](#connect).



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

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) и роль [{{ roles.mmg.editor }} или выше](security/index.md#roles-list). Эти роли позволяют создать кластер.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

1. Подключаться к кластерам БД можно как изнутри, так и извне {{ yandex-cloud }}:

   * Чтобы подключиться изнутри {{ yandex-cloud }}, создайте виртуальную машину в той же облачной сети, что и кластер БД (на основе [Linux](../compute/quickstart/quick-create-linux.md)).

   * Чтобы подключиться к кластеру из интернета, запросите публичный доступ к хостам при создании кластера.

   {% note info %}

   Следующий шаг предполагает, что подключение к кластеру производится с ВМ на основе [Linux](../compute/quickstart/quick-create-linux.md).

   {% endnote %}

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к ВМ по [SSH](../glossary/ssh-keygen.md).

1. Установите {{ MG }} Shell:

   ```bash
   cd ~/ && \
   wget https://repo.mongodb.org/apt/ubuntu/dists/focal/mongodb-org/4.4/multiverse/binary-amd64/mongodb-org-shell_4.4.1_amd64.deb && \
   sudo dpkg -i mongodb-org-shell_4.4.1_amd64.deb
   ```
   

## Создайте кластер {#cluster-create}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер БД.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Задайте параметры кластера и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**. Процесс подробно рассмотрен в разделе [Создание кластера](operations/cluster-create.md).
1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ mmg-short-name }} сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.


## Подключитесь к БД {#connect}

1. Если вы используете группы безопасности для облачной сети, [настройте их](operations/connect/index.md#configuring-security-groups) так, чтобы был разрешен весь необходимый трафик между кластером и хостом, с которого выполняется подключение.

1. Получите SSL-сертификат:

   {% list tabs group=operating_system %}
   
   - Linux (Bash)/macOS (Zsh) {#linux-macos}
   
      ```bash
      mkdir -p ~/.mongodb && \
      wget "{{ crt-web-path }}" \
           --output-document ~/.mongodb/root.crt && \
      chmod 0644 ~/.mongodb/root.crt
      ```
   
      Сертификат будет сохранен в файле `~/.mongodb/root.crt`.
   
   - Windows (PowerShell) {#windows}
   
      ```powershell
      mkdir $HOME\.mongodb; curl.exe -o $HOME\.mongodb\root.crt {{ crt-web-path }}
      ```
   
      Сертификат будет сохранен в файле `$HOME\.mongodb\root.crt`.
   
      Корпоративные политики и антивирус могут блокировать скачивание сертификата. Подробнее см. в разделе [Вопросы и ответы](qa/storedoc.md#get-ssl-error).
   
   {% endlist %}

1. Подключитесь к кластеру с помощью {{ MG }} CLI:

   ```bash
   mongo --norc \
         --ssl \
         --sslCAFile ~/.mongodb/root.crt \
         --host '<FQDN_хоста_1_Yandex_StoreDoc>:{{ port-mmg }},...,<FQDN_хоста_N_Yandex_StoreDoc>:{{ port-mmg }}' \
         --username <имя_пользователя_БД> \
         --password <пароль_пользователя_БД> \
         <имя_БД>
   ```

    О том, как получить FQDN хоста, см. [инструкцию](operations/connect/index.md#get-fqdn).


## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) и [подключении к БД](operations/connect/index.md).
* Посмотрите запись вебинара «Руководство по {{ mmg-short-name }}» на [YouTube](https://www.youtube.com/live/uTt52jcvJ98) или [{{ video-name }}](https://runtime.strm.yandex.ru/player/episode/vple7zg5c6ekr4mgkoqf).
* Ознакомьтесь с [вопросами и ответами](qa/general.md).