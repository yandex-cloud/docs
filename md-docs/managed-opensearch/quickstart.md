# Как начать работать с Managed Service for OpenSearch

Чтобы начать работу с сервисом:
1. [Создайте кластер](#create-cluster).
1. [Настройте группы безопасности](#configure-security-groups).
1. [Подключитесь к кластеру](#connect).
1. [Подключитесь к OpenSearch Dashboards](#dashboards-connect).


## Перед началом работы {#before-you-begin}

1. Войдите в [консоль управления](https://console.yandex.cloud) или зарегистрируйтесь, если вы еще не зарегистрированы.

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

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роль [vpc.user](../vpc/security/index.md#vpc-user) и роль [managed-opensearch.editor или выше](security/index.md#roles-list). Эти роли позволяют создать кластер.

    Для привязки сервисного аккаунта к кластеру (например, для [работы с Yandex Object Storage](operations/s3-access.md)) вашему аккаунту дополнительно нужна роль [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user) или выше.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

1. Подключаться к [кластеру](../glossary/cluster.md) OpenSearch можно как изнутри Yandex Cloud, так и из интернета:

    * Чтобы подключиться изнутри Yandex Cloud, [создайте виртуальную машину](../compute/quickstart/quick-create-linux.md) на основе Linux в той же сети, что и кластер.

    * Чтобы подключиться к кластеру из интернета, [запросите публичный доступ](operations/cluster-create.md) к хостам с [ролью](concepts/host-roles.md#data) `DATA` при создании кластера.

{% note info %}

Эта инструкция предполагает, что подключение к кластеру производится из интернета.

{% endnote %}


## Создайте кластер {#create-cluster}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать кластер.
1. Перейдите в сервис **Managed Service for&nbsp;OpenSearch**.
1. Нажмите кнопку **Создать кластер**. Процесс подробно рассмотрен в разделе [Создание кластера](operations/cluster-create.md).
1. Задайте параметры кластера.

    
    Чтобы получить доступ к веб-интерфейсу OpenSearch Dashboards, запросите публичный доступ — для этого в блоке **Группа виртуальных хостов** с типом группы **Dashboards** выберите опцию **Публичный доступ**.

    {% note tip %}
    
    OpenSearch Dashboards можно воспользоваться, даже если публичный доступ к хостам запросить невозможно (например, из соображений безопасности). Для этого настройте проксирование соединений через виртуальную машину в Yandex Compute Cloud, которая находится в той же [сети](../vpc/concepts/network.md#network), что и кластер. Подробнее в разделе [Подключение к OpenSearch Dashboards](operations/connect/clients.md#dashboards).
    
    {% endnote %}


1. Нажмите кнопку **Создать кластер**.
1. Дождитесь, когда кластер будет готов к работе: его статус на панели Managed Service for OpenSearch сменится на **Creating** и далее — на **Alive**. Это может занять некоторое время.


## Настройте группы безопасности {#configure-security-groups}

## Настройка групп безопасности {#configuring-security-groups}

Для подключения к кластеру необходимо, чтобы [группы безопасности](../vpc/concepts/security-groups.md) содержали правила, которые разрешают трафик с определенных портов, IP-адресов или из других групп безопасности.

Настройки правил доступа будут различаться в зависимости от выбранного способа подключения:

{% list tabs group=connection_method %}

- Через интернет {#internet}

  [Настройте все группы безопасности](../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик с любых IP-адресов на порты 443 (Dashboards) и 9200 (OpenSearch). Для этого создайте следующие правила для входящего трафика:

    * **Диапазон портов** — `443`, `9200`.
    * **Протокол** — `TCP`.
    * **Источник** — `CIDR`.
    * **CIDR блоки** — `0.0.0.0/0`.

  На каждый порт создается отдельное правило.

- С ВМ в Yandex Cloud {#cloud}

    1. [Настройте все группы безопасности](../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик из группы безопасности, в которой находится ВМ, на порты 443 (Dashboards) и 9200 (OpenSearch). Для этого создайте в этих группах следующие правила для входящего трафика:

        * **Диапазон портов** — `443`, `9200`.
        * **Протокол** — `TCP`.
        * **Источник** — `Группа безопасности`.
        * **Группа безопасности** — если кластер и ВМ находятся в одной и той же группе безопасности, выберите значение `Текущая` (`Self`). В противном случае укажите группу безопасности ВМ.

       На каждый порт создается отдельное правило.

    1. [Настройте все группы безопасности](../vpc/operations/security-group-add-rule.md), в которых находится ВМ, так, чтобы можно было подключаться к ВМ и был разрешен трафик между ней и хостами кластера.

       Пример правил для ВМ:

        * Для входящего трафика:

            * **Диапазон портов** — `22`, `443`, `9200`.
            * **Протокол** — `TCP`.
            * **Источник** — `CIDR`.
            * **CIDR блоки** — `0.0.0.0/0`.

          На каждый порт создается отдельное правило.

        * Для исходящего трафика:

            * **Диапазон портов** — `0-65535`.
            * **Протокол** — `Любой` (`Any`).
            * **Назначение** — `CIDR`.
            * **CIDR блоки** — `0.0.0.0/0`.

          Это правило разрешает любой исходящий трафик, что позволяет не только подключаться к кластеру, но и устанавливать на ВМ необходимые для этого сертификаты и утилиты.

{% endlist %}

{% note info %}

Вы можете задать более детальные правила для групп безопасности, например, разрешающие трафик только в определенных подсетях.

Группы безопасности должны быть корректно настроены для всех подсетей, в которых будут размещены хосты кластера. При неполных или некорректных настройках групп безопасности можно потерять доступ к кластеру.

{% endnote %}

Подробнее о группах безопасности в разделе [Группы безопасности](concepts/network.md#security-groups).


## Подключитесь к кластеру {#connect}

Предполагается, что все перечисленные ниже шаги выполняются на Linux.

Чтобы подключиться к кластеру:

1. Установите SSL-сертификат:

   {% list tabs group=operating_system %}
   
   - Linux (Bash)/macOS (Zsh) {#linux-macos}
   
      ```bash
      mkdir -p ~/.opensearch && \
      wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
           --output-document ~/.opensearch/root.crt && \
      chmod 0600 ~/.opensearch/root.crt
      ```
   
      Сертификат будет сохранен в файле `~/.opensearch/root.crt`.
   
   - Windows (PowerShell) {#windows}
   
      ```powershell
      mkdir $HOME\.opensearch; curl.exe -o $HOME\.opensearch\root.crt https://storage.yandexcloud.net/cloud-certs/CA.pem
      ```
   
      Сертификат будет сохранен в файле `$HOME\.opensearch\root.crt`.
   
      Корпоративные политики и антивирус могут блокировать скачивание сертификата. Подробнее читайте в разделе [Вопросы и ответы](qa/index.md#get-ssl-error).
   
   {% endlist %}

1. Подключитесь к кластеру с помощью утилиты [cURL](https://curl.haxx.se/):

   ```bash
   curl \
       --user admin:<пароль> \
       --cacert ~/.opensearch/root.crt \
       --request GET 'https://<FQDN_хоста_OpenSearch_с_публичным_доступом>:9200/'
   ```

   Для подключения нужно использовать имя пользователя `admin` и пароль, который был задан при [создании кластера](#create-cluster).

   При успешном подключении будет выведено похожее сообщение:

   ```bash
   {
     "name" : "....mdb.yandexcloud.net",
     "cluster_name" : "...",
     "cluster_uuid" : "...",
     "version" : {
     "distribution" : "opensearch",
     ...
     },
     "tagline" : "The OpenSearch Project: https://opensearch.org/"
   }
   ```

## Подключитесь к OpenSearch Dashboards {#dashboards-connect}

1. Подключитесь с помощью браузера к веб-интерфейсу [OpenSearch Dashboards](https://opensearch.org/docs/latest/dashboards/index/):

   
   1. Убедитесь, что к хостам с ролью `DASHBOARDS` есть публичный доступ.


   1. Установите [SSL-сертификат](https://storage.yandexcloud.net/cloud-certs/CA.pem) в хранилище доверенных корневых сертификатов браузера ([инструкция](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate) для Mozilla Firefox).
   1. На странице кластера в консоли управления нажмите кнопку **OpenSearch Dashboards** или перейдите в браузере по адресу `https://c-<идентификатор_кластера_OpenSearch>.rw.mdb.yandexcloud.net>`.
   1. Введите имя пользователя `admin` и пароль, который был задан при [создании кластера](#create-cluster).

1. Исследуйте набор тестовых данных:

   1. На приветственном экране OpenSearch Dashboards нажмите кнопку **Add sample data**.
   1. Нажмите кнопку **View data** для интересующего набора данных.

Подробнее о работе с OpenSearch Dashboards в [документации OpenSearch](https://opensearch.org/docs/latest/dashboards/index/).

## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) и [подключении к кластеру](operations/connect/index.md).