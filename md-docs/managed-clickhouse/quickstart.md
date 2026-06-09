# Как начать работать с {{ mch-name }}



<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/episode/vpleqgrv2vfmu7sbwkge?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=qdaGELCN8fs).




Чтобы начать работу с сервисом:


* [Создайте кластер базы данных](#cluster-create).
* [Подключитесь к БД](#connect).



{% note info %}

О том, как создать кластер {{ CH }}, подключиться к нему и выполнять простые запросы, вы также можете узнать из урока [«Установка, базовая настройка, управление сервером»](https://practicum.yandex.ru/introduction/?slug=ycloud-clickhouse&platform=desktop&lang=ru) в обучающем курсе по {{ mch-name }}.

{% endnote %}



## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. Если у вас еще нет [каталога](../resource-manager/concepts/resources-hierarchy.md#folder), создайте его:

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

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) и роль [{{ roles.mch.editor }} или выше](security.md#roles-list). Эти роли позволяют создать кластер.

   Для привязки сервисного аккаунта к кластеру (например, для [работы с {{ objstorage-full-name }}](operations/s3-access.md)) вашему аккаунту дополнительно нужна роль [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user) или выше.

   {% note info %}
   
   Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
   
   {% endnote %}

1. Подключаться к [кластерам](concepts/index.md) БД можно изнутри и извне {{ yandex-cloud }}:
   * Чтобы подключиться изнутри {{ yandex-cloud }}, создайте [виртуальную машину](../compute/concepts/vm.md) на основе [Linux](../compute/quickstart/quick-create-linux.md) в той же [сети](../vpc/concepts/network.md#network), что и кластер БД.
   * Чтобы подключиться к кластеру из интернета, запросите публичный доступ к хостам при создании кластера.

   {% note info %}

   Следующие шаги предполагают, что подключение к кластеру производится с ВМ на основе [Linux](../compute/quickstart/quick-create-linux.md).

   {% endnote %}

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к ВМ по [SSH](../glossary/ssh-keygen.md).
1. Подключите [DEB-репозиторий]({{ ch.docs }}{{ lang }}/install#install-from-deb-packages) {{ CH }}:

   ```bash
   sudo apt update && sudo apt install --yes apt-transport-https ca-certificates dirmngr && \
   sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8919F6BD******** && \
   echo "deb https://packages.{{ ch-domain }}/deb stable main" | sudo tee \
   /etc/apt/sources.list.d/clickhouse.list
   ```

1. Установите зависимости и клиентское приложение `clickhouse-client`:

   ```bash
   sudo apt update && sudo apt install --yes clickhouse-client
   ```

1. Загрузите файл конфигурации для `clickhouse-client`:

   ```bash
   mkdir -p ~/.clickhouse-client && \
   wget "https://{{ s3-storage-host-doc-files }}/clickhouse-client.conf.example" \
     --output-document ~/.clickhouse-client/config.xml
   ```


## Создайте кластер {#cluster-create}

1. В консоли управления выберите каталог, в котором нужно создать кластер БД.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Задайте параметры кластера и нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**. Процесс подробно рассмотрен в разделе [Создание кластера](operations/cluster-create.md).
1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ mch-short-name }} сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.


## Подключитесь к БД {#connect}

1. Если вы используете [группы безопасности](../vpc/concepts/security-groups.md) для облачной сети, [настройте их](operations/connect/index.md#configuring-security-groups) так, чтобы был разрешен весь необходимый трафик между кластером и хостом, с которого выполняется подключение.

1. Для подключения к серверу БД получите SSL-сертификаты:

   {% list tabs group=operating_system %}
   
   - Linux (Bash) {#linux}
   
      ```bash
      sudo mkdir --parents {{ crt-local-dir }} && \
      sudo wget "{{ crt-web-path-root }}" \
           --output-document {{ crt-local-dir }}{{ crt-local-file-root }} && \
      sudo wget "{{ crt-web-path-int }}" \
           --output-document {{ crt-local-dir }}{{ crt-local-file-int }} && \
      sudo chmod 655 \
           {{ crt-local-dir }}{{ crt-local-file-root }} \
           {{ crt-local-dir }}{{ crt-local-file-int }} && \
      sudo update-ca-certificates
      ```
   
      Сертификаты будут сохранены в файлах:
   
      * `{{ crt-local-dir }}{{ crt-local-file-root }}`
      * `{{ crt-local-dir }}{{ crt-local-file-int }}`
   
   - macOS (Zsh) {#macos}
   
      ```bash
      sudo mkdir -p {{ crt-local-dir }} && \
      sudo wget "{{ crt-web-path-root }}" \
           --output-document {{ crt-local-dir }}{{ crt-local-file-root }} && \
      sudo wget "{{ crt-web-path-int }}" \
           --output-document {{ crt-local-dir }}{{ crt-local-file-int }} && \
      sudo chmod 655 \
           {{ crt-local-dir }}{{ crt-local-file-root }} \
           {{ crt-local-dir }}{{ crt-local-file-int }} && \
      security import {{ crt-local-dir }}{{ crt-local-file-root }} -k ~/Library/Keychains/login.keychain; \
      security import {{ crt-local-dir }}{{ crt-local-file-int }} -k ~/Library/Keychains/login.keychain
      ```
   
      Сертификаты будут сохранены в файлах:
   
      * `{{ crt-local-dir }}{{ crt-local-file-root }}`
      * `{{ crt-local-dir }}{{ crt-local-file-int }}`
   
   - Windows (PowerShell) {#windows}
   
      1. Скачайте и импортируйте сертификаты:
   
         ```powershell
         mkdir -Force $HOME\.yandex; `
         curl.exe {{ crt-web-path-root }} `
           --output $HOME\.yandex\{{ crt-local-file-root }}; `
         curl.exe {{ crt-web-path-int }} `
           --output $HOME\.yandex\{{ crt-local-file-int }}; `
         Import-Certificate `
           -FilePath $HOME\.yandex\{{ crt-local-file-root }} `
           -CertStoreLocation cert:\CurrentUser\Root; `
         Import-Certificate `
           -FilePath $HOME\.yandex\{{ crt-local-file-int }} `
           -CertStoreLocation cert:\CurrentUser\Root
         ```
   
         Корпоративные политики и антивирус могут блокировать скачивание сертификата. Подробнее см. в разделе [Вопросы и ответы](qa/connection.md#get-ssl-error).
   
      1. Подтвердите согласие с установкой сертификатов в хранилище <q>Доверенные корневые центры сертификации</q>.
   
      Сертификаты будут сохранены в файлах:
   
      * `$HOME\.yandex\{{ crt-local-file-root }}`
      * `$HOME\.yandex\{{ crt-local-file-int }}`
   
   {% endlist %}

1. Используйте для подключения {{ CH }} CLI:
   1. Укажите путь к SSL-сертификату `{{ crt-local-file-root }}` в [конфигурационном файле]({{ ch.docs }}{{ lang }}/interfaces/cli#interfaces_cli_configuration), в элементе `<caConfig>`:

      ```xml
      <config>
        <openSSL>
          <client>
            <loadDefaultCAFile>true</loadDefaultCAFile>
            <caConfig>{{ crt-local-dir }}{{ crt-local-file-root }}</caConfig>
            <cacheSessions>true</cacheSessions>
            <disableProtocols>sslv2,sslv3</disableProtocols>
            <preferServerCiphers>true</preferServerCiphers>
            <invalidCertificateHandler>
              <name>RejectCertificateHandler</name>
            </invalidCertificateHandler>
          </client>
        </openSSL>
      </config>
      ```

   1. Запустите {{ CH }} CLI со следующими параметрами:

      ```bash
      clickhouse-client --host <FQDN_любого_хоста_{{ CH }}> \
                        --secure \
                        --user <имя_пользователя> \
                        --database <имя_БД> \
                        --port 9440 \
                        --ask-password
      ```


## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) и [подключении к БД](operations/connect/index.md).
* Ознакомьтесь с [вопросами и ответами](qa/general.md).

_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._