# Как начать работать с Managed Service for MySQL®

Чтобы начать работу с сервисом:


* [Создайте кластер базы данных](#cluster-create).
* [Подключитесь к БД](#connect).



## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь, если вы еще не зарегистрированы.
1. Если у вас еще нет [каталога](../resource-manager/concepts/resources-hierarchy.md#folder), создайте его:

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

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роль [vpc.user](../vpc/security/index.md#vpc-user) и роль [managed-mysql.editor или выше](security/index.md#roles-list). Эти роли позволяют создать кластер.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

1. Подключаться к [кластерам](concepts/index.md) БД можно изнутри и извне Yandex Cloud:
   * Чтобы подключиться изнутри Yandex Cloud, создайте [виртуальную машину](../compute/concepts/vm.md) в той же [облачной сети](../vpc/concepts/network.md#network), что и кластер БД (на основе [Linux](../compute/quickstart/quick-create-linux.md)).
   * Чтобы подключиться к кластеру Managed Service for MySQL® из интернета, запросите публичный доступ к хостам при создании кластера.

   {% note info %}

   Следующий шаг предполагает, что подключение к кластеру Managed Service for MySQL® производится с ВМ на основе [Linux](../compute/quickstart/quick-create-linux.md).

   {% endnote %}

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к ВМ по [SSH](../glossary/ssh-keygen.md).
1. Установите необходимые зависимости и клиент MySQL®:

   ```bash
   sudo apt update && sudo apt install -y mysql-client
   ```


## Создайте кластер {#cluster-create}

1. В консоли управления выберите каталог, в котором нужно создать кластер БД.
1. Перейдите в сервис **Managed Service for&nbsp;MySQL**.
1. Нажмите кнопку **Создать кластер**.
1. Задайте параметры кластера Managed Service for MySQL® и нажмите кнопку **Создать кластер**. Процесс подробно рассмотрен в разделе [Создание кластера](operations/cluster-create.md).
1. Дождитесь, когда кластер Managed Service for MySQL® будет готов к работе: его статус на панели Managed Service for MySQL® сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.


## Подключитесь к БД {#connect}

1. Если вы используете [группы безопасности](../vpc/concepts/security-groups.md) для облачной сети, [настройте их](operations/connect/index.md#configure-security-groups), чтобы был разрешен весь необходимый трафик между кластером Managed Service for MySQL® и хостом, с которого выполняется подключение.

1. Для подключения к серверу БД получите [SSL-сертификат](../glossary/ssl-certificate.md):

   {% list tabs group=operating_system %}
   
   - Linux (Bash)/macOS (Zsh) {#linux-macos}
   
      ```bash
      mkdir -p ~/.mysql && \
      wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
           --output-document ~/.mysql/root.crt && \
      chmod 0600 ~/.mysql/root.crt
      ```
   
      Сертификат будет сохранен в файле `~/.mysql/root.crt`.
   
   - Windows (PowerShell) {#windows}
   
      ```powershell
      mkdir $HOME\.mysql; curl.exe -o $HOME\.mysql\root.crt https://storage.yandexcloud.net/cloud-certs/CA.pem
      ```
   
      Сертификат будет сохранен в файле `$HOME\.mysql\root.crt`.
   
      Корпоративные политики и антивирус могут блокировать скачивание сертификата. Подробнее в разделе [Вопросы и ответы](qa/connection.md#get-ssl-error).
   
   {% endlist %}

1. Используйте для подключения команду `mysql`:

   ```bash
   mysql --host=<имя_хоста_MySQL®>.mdb.yandexcloud.net \
         --port=3306 \
         --ssl-ca=~/.mysql/root.crt \
         --ssl-mode=VERIFY_IDENTITY \
         --user=<имя_пользователя> \
         --password \
         <имя_БД>
   ```


## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера Managed Service for MySQL®](operations/cluster-create.md) и [подключении к БД](operations/connect/index.md).
* Ознакомьтесь с [вопросами и ответами](qa/general.md).