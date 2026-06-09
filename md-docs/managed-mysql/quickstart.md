# Как начать работать с {{ mmy-name }}

Чтобы начать работу с сервисом:


* [Создайте кластер базы данных](#cluster-create).
* [Подключитесь к БД](#connect).



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

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) и роль [{{ roles.mmy.editor }} или выше](security/index.md#roles-list). Эти роли позволяют создать кластер.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

1. Подключаться к [кластерам](concepts/index.md) БД можно изнутри и извне {{ yandex-cloud }}:
   * Чтобы подключиться изнутри {{ yandex-cloud }}, создайте [виртуальную машину](../compute/concepts/vm.md) в той же [облачной сети](../vpc/concepts/network.md#network), что и кластер БД (на основе [Linux](../compute/quickstart/quick-create-linux.md)).
   * Чтобы подключиться к кластеру {{ mmy-name }} из интернета, запросите публичный доступ к хостам при создании кластера.

   {% note info %}

   Следующий шаг предполагает, что подключение к кластеру {{ mmy-name }} производится с ВМ на основе [Linux](../compute/quickstart/quick-create-linux.md).

   {% endnote %}

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к ВМ по [SSH](../glossary/ssh-keygen.md).
1. Установите необходимые зависимости и клиент {{ MY }}:

   ```bash
   sudo apt update && sudo apt install -y mysql-client
   ```


## Создайте кластер {#cluster-create}

1. В консоли управления выберите каталог, в котором нужно создать кластер БД.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Задайте параметры кластера {{ mmy-name }} и нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**. Процесс подробно рассмотрен в разделе [Создание кластера](operations/cluster-create.md).
1. Дождитесь, когда кластер {{ mmy-name }} будет готов к работе: его статус на панели {{ mmy-name }} сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.


## Подключитесь к БД {#connect}

1. Если вы используете [группы безопасности](../vpc/concepts/security-groups.md) для облачной сети, [настройте их](operations/connect/index.md#configure-security-groups), чтобы был разрешен весь необходимый трафик между кластером {{ mmy-name }} и хостом, с которого выполняется подключение.

1. Для подключения к серверу БД получите [SSL-сертификат](../glossary/ssl-certificate.md):

   {% list tabs group=operating_system %}
   
   - Linux (Bash)/macOS (Zsh) {#linux-macos}
   
      ```bash
      mkdir -p ~/.mysql && \
      wget "{{ crt-web-path }}" \
           --output-document ~/.mysql/root.crt && \
      chmod 0600 ~/.mysql/root.crt
      ```
   
      Сертификат будет сохранен в файле `~/.mysql/root.crt`.
   
   - Windows (PowerShell) {#windows}
   
      ```powershell
      mkdir $HOME\.mysql; curl.exe -o $HOME\.mysql\root.crt {{ crt-web-path }}
      ```
   
      Сертификат будет сохранен в файле `$HOME\.mysql\root.crt`.
   
      Корпоративные политики и антивирус могут блокировать скачивание сертификата. Подробнее см. в разделе [Вопросы и ответы](qa/connection.md#get-ssl-error).
   
   {% endlist %}

1. Используйте для подключения команду `mysql`:

   ```bash
   mysql --host=<имя_хоста_{{ MY }}>.{{ dns-zone }} \
         --port={{ port-mmy }} \
         --ssl-ca=~/.mysql/root.crt \
         --ssl-mode=VERIFY_IDENTITY \
         --user=<имя_пользователя> \
         --password \
         <имя_БД>
   ```


## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера {{ mmy-name }}](operations/cluster-create.md) и [подключении к БД](operations/connect/index.md).
* Ознакомьтесь с [вопросами и ответами](qa/general.md).