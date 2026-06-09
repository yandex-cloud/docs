# Как начать работать с {{ dataproc-name }}

Чтобы начать работу с сервисом:

1. [Создайте кластер](#cluster-create).
1. [Подключитесь к кластеру](#connect).
1. [Подключитесь к интерфейсам компонентов](#connect-components).


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

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роли:

    * [dataproc.editor](security/index.md#dataproc-editor) — чтобы создать кластер;
    * [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../vpc/concepts/network.md#network) кластера;
    * [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user) — чтобы привязать [сервисный аккаунт](../iam/concepts/users/service-accounts.md) к кластеру и создавать ресурсы от имени этого сервисного аккаунта.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

1. [Настройте NAT-шлюз](../vpc/operations/create-nat-gateway.md) в подсети, в которой будет размещен [кластер](../glossary/cluster.md).

1. Если вы используете группы безопасности, [настройте их](operations/cluster-create.md#change-security-groups).

1. Подключаться к кластеру {{ dataproc-name }} можно как изнутри, так и извне {{ yandex-cloud }}:

   * Чтобы подключиться изнутри {{ yandex-cloud }}, создайте виртуальную машину на основе [Linux](../compute/quickstart/quick-create-linux.md) в той же сети, что и кластер.

   * Чтобы подключиться к кластеру из интернета, запросите публичный доступ к подкластерам при создании кластера.

   {% note info %}

   Следующий шаг предполагает, что подключение к кластеру производится с ВМ на основе [Linux](../compute/quickstart/quick-create-linux.md).

   {% endnote %}

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к ВМ по [SSH](../glossary/ssh-keygen.md).


## Создайте кластер {#cluster-create}

Чтобы создать кластер:

1. В консоли управления откройте каталог, в котором нужно создать кластер.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_empty-create }}**.
1. Задайте параметры кластера и нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**. Процесс подробно рассмотрен в разделе [Создание кластера](operations/cluster-create.md).
1. Дождитесь, когда кластер будет готов к работе: его состояние сменится на **Alive**. Это может занять некоторое время.

## Подключитесь к кластеру {#connect}

Чтобы подключиться к кластеру:


1. Если вы используете группы безопасности для облачной сети, [настройте их](operations/security-groups.md) так, чтобы был разрешен весь необходимый трафик между кластером и хостом, с которого выполняется подключение.


1. Скопируйте на ВМ SSL-ключ, который вы указали при создании кластера {{ dataproc-name }}.

1. Подключитесь к кластеру по SSH и проверьте, что команды Hadoop выполняются. В зависимости от версии образа укажите имя пользователя. Для версий 2.* — `ubuntu`.

Подробно процесс подключения к кластеру {{ dataproc-name }} рассмотрен в разделе [Подключение к кластеру](operations/connect.md).

## Подключитесь к интерфейсам компонентов {#connect-components}

Чтобы подключиться к интерфейсам компонентов {{ dataproc-name }} по веб-интерфейсу:

1. [Включите настройку](operations/connect-interfaces.md#ui-proxy-enable) **{{ ui-key.yacloud.mdb.forms.config_field_ui_proxy }}** в кластере.
1. Получите список URL интерфейсов.

Чтобы подключиться к интерфейсам компонентов {{ dataproc-name }} по SSH с перенаправлением портов:

1. Создайте промежуточную ВМ с публичным IP-адресом в одной сети с кластером и с группой безопасности, в которой разрешены входящий и исходящий трафик через порты компонентов.
1. Подключитесь к созданной ВМ по SSH с перенаправлением к нужным портам хоста {{ dataproc-name }}. В зависимости от версии образа укажите имя пользователя. Для версий 2.* — `ubuntu`.

Подробно процесс подключения к интерфейсам компонентов кластера {{ dataproc-name }} рассмотрен в разделе [{#T}](operations/connect-interfaces.md).

## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) и [работе с заданиями](operations/jobs.md).