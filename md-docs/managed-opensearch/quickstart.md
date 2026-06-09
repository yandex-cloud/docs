# Как начать работать с {{ mos-name }}

Чтобы начать работу с сервисом:
1. [Создайте кластер](#create-cluster).
1. [Настройте группы безопасности](#configure-security-groups).
1. [Подключитесь к кластеру](#connect).
1. [Подключитесь к {{ OS }} Dashboards](#dashboards-connect).


## Перед началом работы {#before-you-begin}

1. Войдите в [консоль управления]({{ link-console-main }}) или зарегистрируйтесь, если вы еще не зарегистрированы.

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

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) и роль [{{ roles.mos.editor }} или выше](security/index.md#roles-list). Эти роли позволяют создать кластер.

    Для привязки сервисного аккаунта к кластеру (например, для [работы с {{ objstorage-full-name }}](operations/s3-access.md)) вашему аккаунту дополнительно нужна роль [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user) или выше.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

1. Подключаться к [кластеру](../glossary/cluster.md) {{ OS }} можно как изнутри {{ yandex-cloud }}, так и из интернета:

    * Чтобы подключиться изнутри {{ yandex-cloud }}, [создайте виртуальную машину](../compute/quickstart/quick-create-linux.md) на основе Linux в той же сети, что и кластер.

    * Чтобы подключиться к кластеру из интернета, [запросите публичный доступ](operations/cluster-create.md) к хостам с [ролью](concepts/host-roles.md#data) `DATA` при создании кластера.

{% note info %}

Эта инструкция предполагает, что подключение к кластеру производится из интернета.

{% endnote %}


## Создайте кластер {#create-cluster}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**. Процесс подробно рассмотрен в разделе [Создание кластера](operations/cluster-create.md).
1. Задайте параметры кластера.

    
    Чтобы получить доступ к веб-интерфейсу {{ OS }} Dashboards, запросите публичный доступ — для этого в блоке **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_virtual-node-group }}** с типом группы **Dashboards** выберите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.

    {% note tip %}
    
    {{ OS }} Dashboards можно воспользоваться, даже если публичный доступ к хостам запросить невозможно (например, из соображений безопасности). Для этого настройте проксирование соединений через виртуальную машину в {{ compute-full-name }}, которая находится в той же [сети](../vpc/concepts/network.md#network), что и кластер. Подробнее см. в разделе [{#T}](operations/connect/clients.md#dashboards).
    
    {% endnote %}


1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.
1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ mos-name }} сменится на **Creating** и далее — на **Alive**. Это может занять некоторое время.


## Настройте группы безопасности {#configure-security-groups}

## Настройка групп безопасности {#configuring-security-groups}

Для подключения к кластеру необходимо, чтобы [группы безопасности](../vpc/concepts/security-groups.md) содержали правила, которые разрешают трафик с определенных портов, IP-адресов или из других групп безопасности.

Настройки правил доступа будут различаться в зависимости от выбранного способа подключения:

{% list tabs group=connection_method %}

- Через интернет {#internet}

  [Настройте все группы безопасности](../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик с любых IP-адресов на порты {{ port-https }} (Dashboards) и {{ port-mos }} ({{ OS }}). Для этого создайте следующие правила для входящего трафика:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-https }}`, `{{ port-mos }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

  На каждый порт создается отдельное правило.

- С ВМ в {{ yandex-cloud }} {#cloud}

    1. [Настройте все группы безопасности](../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик из группы безопасности, в которой находится ВМ, на порты {{ port-https }} (Dashboards) и {{ port-mos }} ({{ OS }}). Для этого создайте в этих группах следующие правила для входящего трафика:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-https }}`, `{{ port-mos }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — если кластер и ВМ находятся в одной и той же группе безопасности, выберите значение `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`). В противном случае укажите группу безопасности ВМ.

       На каждый порт создается отдельное правило.

    1. [Настройте все группы безопасности](../vpc/operations/security-group-add-rule.md), в которых находится ВМ, так, чтобы можно было подключаться к ВМ и был разрешен трафик между ней и хостами кластера.

       Пример правил для ВМ:

        * Для входящего трафика:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-ssh }}`, `{{ port-https }}`, `{{ port-mos }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

          На каждый порт создается отдельное правило.

        * Для исходящего трафика:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

          Это правило разрешает любой исходящий трафик, что позволяет не только подключаться к кластеру, но и устанавливать на ВМ необходимые для этого сертификаты и утилиты.

{% endlist %}

{% note info %}

Вы можете задать более детальные правила для групп безопасности, например, разрешающие трафик только в определенных подсетях.

Группы безопасности должны быть корректно настроены для всех подсетей, в которых будут размещены хосты кластера. При неполных или некорректных настройках групп безопасности можно потерять доступ к кластеру.

{% endnote %}

Подробнее о группах безопасности см. в разделе [{#T}](concepts/network.md#security-groups).


## Подключитесь к кластеру {#connect}

Предполагается, что все перечисленные ниже шаги выполняются на Linux.

Чтобы подключиться к кластеру:

1. Установите SSL-сертификат:

   {% list tabs group=operating_system %}
   
   - Linux (Bash)/macOS (Zsh) {#linux-macos}
   
      ```bash
      mkdir -p ~/.opensearch && \
      wget "{{ crt-web-path }}" \
           --output-document ~/.opensearch/root.crt && \
      chmod 0600 ~/.opensearch/root.crt
      ```
   
      Сертификат будет сохранен в файле `~/.opensearch/root.crt`.
   
   - Windows (PowerShell) {#windows}
   
      ```powershell
      mkdir $HOME\.opensearch; curl.exe -o $HOME\.opensearch\root.crt {{ crt-web-path }}
      ```
   
      Сертификат будет сохранен в файле `$HOME\.opensearch\root.crt`.
   
      Корпоративные политики и антивирус могут блокировать скачивание сертификата. Подробнее читайте в разделе [Вопросы и ответы](qa/index.md#get-ssl-error).
   
   {% endlist %}

1. Подключитесь к кластеру с помощью утилиты [cURL](https://curl.haxx.se/):

   ```bash
   curl \
       --user admin:<пароль> \
       --cacert ~/.opensearch/root.crt \
       --request GET 'https://<FQDN_хоста_{{ OS }}_с_публичным_доступом>:{{ port-mos }}/'
   ```

   Для подключения нужно использовать имя пользователя `admin` и пароль, который был задан при [создании кластера](#create-cluster).

   При успешном подключении будет выведено похожее сообщение:

   ```bash
   {
     "name" : "....{{ dns-zone }}",
     "cluster_name" : "...",
     "cluster_uuid" : "...",
     "version" : {
     "distribution" : "opensearch",
     ...
     },
     "tagline" : "The OpenSearch Project: https://opensearch.org/"
   }
   ```

## Подключитесь к {{ OS }} Dashboards {#dashboards-connect}

1. Подключитесь с помощью браузера к веб-интерфейсу [{{ OS }} Dashboards]({{ os.docs }}/dashboards/index/):

   
   1. Убедитесь, что к хостам с ролью `DASHBOARDS` есть публичный доступ.


   1. Установите [SSL-сертификат]({{ crt-web-path }}) в хранилище доверенных корневых сертификатов браузера ([инструкция](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate) для Mozilla Firefox).
   1. На странице кластера в консоли управления нажмите кнопку **OpenSearch Dashboards** или перейдите в браузере по адресу `https://c-<идентификатор_кластера_{{ OS }}>.rw.{{ dns-zone }}>`.
   1. Введите имя пользователя `admin` и пароль, который был задан при [создании кластера](#create-cluster).

1. Исследуйте набор тестовых данных:

   1. На приветственном экране {{ OS }} Dashboards нажмите кнопку **Add sample data**.
   1. Нажмите кнопку **View data** для интересующего набора данных.

Подробнее о работе с {{ OS }} Dashboards см. в [документации {{ OS }}]({{ os.docs }}/dashboards/index/).

## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) и [подключении к кластеру](operations/connect/index.md).