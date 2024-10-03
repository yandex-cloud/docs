---
title: Как подключиться к кластеру {{ dataproc-full-name }}
description: Следуя данной инструкции, вы сможете подключиться к кластеру {{ dataproc-name }}.
---

# Подключение к кластеру {{ dataproc-name }}

После создания кластера {{ dataproc-name }} вы можете подключиться к хостам подкластеров:

* Через интернет, если вы настроили публичный доступ для подкластера.
* С [виртуальной машины](../../compute/operations/vm-create/create-linux-vm.md) {{ yandex-cloud }}, расположенной в той же облачной сети.

## Настройка групп безопасности {#configuring-security-groups}

Группы безопасности могут препятствовать подключению к кластеру — в этом случае внесите изменения в правила групп.

{% note alert %}

При настройке групп безопасности не изменяйте [правила для служебного трафика](./cluster-create.md#change-security-groups). Это может привести к неработоспособности кластера.

{% endnote %}

Настройки правил будут различаться в зависимости от выбранного способа подключения:

{% list tabs %}

- SSH

    * Для подключения к хостам подкластеров с публичным доступом из облачных сетей и интернета [настройте группы безопасности](../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик с любых IP-адресов на порт `{{ port-ssh }}`. Для этого создайте следующее правило для входящего трафика:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-ssh }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

    * Для подключения к кластеру с промежуточной виртуальной машины:

      1. [Настройте группу безопасности](../../vpc/operations/security-group-add-rule.md), в которой находится ВМ, так, чтобы можно было подключаться к ВМ и был разрешен трафик между ВМ и хостами подкластеров. Для этого создайте следующие правила:

          * для входящего трафика:

              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-ssh }}`.
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

          * для исходящего трафика:

              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-ssh }}`.
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — диапазон адресов подсети, в которой находятся хосты кластера. Если подкластеры находятся в разных подсетях, то создайте это правило для каждой подсети.

      1. [Настройте группы безопасности](../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик из группы безопасности, в которой находится ВМ, на порт `{{ port-ssh }}`. Для этого создайте следующее правило для входящего трафика:

          * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-ssh }}`.
          * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
          * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
          * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — диапазон адресов подсети, в которой находятся хосты кластера.

- UI Proxy

    Для использования [**UI Proxy**](../concepts/interfaces.md) [добавьте](../../vpc/operations/security-group-add-rule.md) в группу безопасности хоста подкластера правила, разрешающие входящий трафик через порт `{{ port-https }}`:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-https }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

    Если подключение выполняется через промежуточную ВМ, [добавьте](../../vpc/operations/security-group-add-rule.md) в группу безопасности хоста подкластера правила, разрешающие подключения через нее:

    * для входящего трафика:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-https }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

    * для исходящего трафика:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-https }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — диапазон адресов подсети, в которой находится хост подкластера.

- Подключение с перенаправлением портов

    При использовании [перенаправления портов](../operations/connect-interfaces.md#routing), [добавьте](../../vpc/operations/security-group-add-rule.md) в группу безопасности промежуточной ВМ правила, разрешающие входящий и исходящий трафик через порты требуемых компонентов:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `<порт_компонента>`.

        Номера портов для компонентов {{ dataproc-name }} приведены в таблице:

        {% include [ports-table](../../_includes/data-proc/ports-table.md) %}

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

{% endlist %}

{% note info %}

Вы можете задать более детальные правила для групп безопасности, например, разрешающие трафик только в определенных подсетях.

Группы безопасности должны быть корректно настроены для всех подсетей, в которых будут размещены подкластеры.

{% endnote %}

Подробнее о группах безопасности см. в разделе [{#T}](../concepts/network.md#security-groups).

## FQDN хоста {{ dataproc-name }} {#fqdn}

Для подключения к хосту потребуется его [FQDN](../concepts/network.md#hostname) — доменное имя. Его можно посмотреть в консоли управления:

1. Перейдите на страницу кластера.
1. Перейдите в раздел **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
1. Скопируйте значение в столбце **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}**.

## SSH-подключение к хосту {{ dataproc-name }} {#data-proc-ssh}

Чтобы подключиться к хосту {{ dataproc-name }}, на локальной машине или промежуточной ВМ должен быть доступен SSH-ключ, который вы указали при создании кластера {{ dataproc-name }}. Вы можете скопировать ключ на машину, с которой будет производиться подключение к кластеру, или подключаться к ней с запущенным SSH-агентом.

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к промежуточной виртуальной машине по протоколу SSH, если вы не настраивали публичный доступ для подкластера.

1. Запустите SSH-агент:

    ```bash
    eval `ssh-agent -s`
    ```

1. Добавьте нужный ключ в список доступных агенту:
 
   ```bash
   ssh-add ~/.ssh/example-key
   ```

1. Откройте SSH-соединение с хостом {{ dataproc-name }}, указав его FQDN или IP-адрес, если для хоста включен публичный доступ.  Для образа 2.0 укажите пользователя `ubuntu`, для образа 1.4 — `root`, например:  

   ```bash
   ssh ubuntu@rc1b-dataproc-m-fh4y4nur********.{{ dns-zone }}
   ```

   Результат:

   ```text
   ubuntu@rc1b-dataproc-m-fh4y4nur********:~#
   ```

1. Проверьте, что команды Hadoop выполняются, например:

    ```bash
    hadoop version
    ```

    Результат:

    ```text
    Hadoop 2.8.5
    Subversion https://github.yandex-team.ru/mdb/bigtop.git -r 78508f2a4b4f3dc8b3d295ccb50a45a4********
    Compiled by robot-pgaas-ci on 2019-04-16T10:35Z
    Compiled with protoc 2.5.0
    From source with checksum 9942ca5c745417c14e31883********
    This command was run using /usr/lib/hadoop/hadoop-common-2.8.5.jar
    ```

## Подключение из графических IDE {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

{% list tabs group=ide %}

- DataGrip {#datagrip}

  1. Создайте источник данных:
     1. Выберите в меню **File** → **New** → **Data Source** → **Apache Hive**.

        {% note info %}

        Выберите источник данных в зависимости от компонента {{ dataproc-name }}, к которому вы подключаетесь:

        * Hive — выберите **Apache Hive**;
        * Spark — выберите **Apache Spark**.

        Список настроек не меняется.

        {% endnote %}

     1. Укажите параметры подключения на вкладке **General**:
        * **Host** — FQDN хоста-мастера кластера или его публичный IP-адрес;
        * Если вы подключаетесь впервые, то нажмите ссылку **Download**, чтобы загрузить драйвер соединения.
     1. На вкладке **SSH/SSL**:
        1. Включите настройку **Use SSL** и укажите параметры для SSL-подключения:
           * **CA file** — загруженный ранее SSL-сертификат для подключения;
           * **Client key file**, **Client key password** — файл закрытого ключа для подключения к кластеру {{ dataproc-name }} и пароль к нему.
        1. (Опционально) Для подключения через промежуточную ВМ настройте параметры SSH-туннеля:
           1. Выберите **Use SSH tunnel**, создайте SSH-конфигурацию и укажите параметры:
              * **Host** — IP-адрес ВМ;
              * **User name** — имя пользователя ВМ;
              * **Private key file**, **Passphrase** — файл закрытого ключа для подключения к ВМ и пароль к нему.
           1. Нажмите ссылку **Test Connection** для проверки подключения к ВМ из DataGrip.
           1. Нажмите кнопку **OK**, чтобы сохранить конфигурацию.
  1. Нажмите ссылку **Test Connection** для проверки подключения. При успешном подключении будет выведен статус подключения **OK**, информация о СУБД и драйвере.
  1. Нажмите кнопку **OK**, чтобы сохранить источник данных.

- DBeaver {#dbeaver}

  1. [Загрузите SSH-ключ](#data-proc-ssh) на локальную машину или ВМ для подключения к кластеру {{ dataproc-name }}.
  1. Создайте новое соединение с БД:
     1. Выберите в меню **База данных** пункт **Новое соединение**.
     1. Выберите из списка БД источник данных в зависимости от конфигурации кластера {{ dataproc-name }}, к которому вы подключаетесь:

         * Если в кластере используется Hive — выберите **Apache Hive**.
         * Если в кластере включен только Spark и [включен Thrift-сервер](../concepts/settings-list.md#spark-thrift-server)  — выберите **Apache Spark**.

     1. Нажмите кнопку **Далее**.
     1. На вкладке **SSH** включите настройку **Использовать туннель SSH** и укажите параметры:
        * **Хост/IP** — FQDN (для подключения через промежуточную ВМ) или публичный IP-адрес хоста-мастера;
        * **Имя пользователя** – укажите имя пользователя:
          * для версии 2.0 — `ubuntu`;
          * для версии 1.4 — `root`.
        * **Метод аутентификации** — `Публичный ключ`;
        * **Секретный ключ** — путь к файлу закрытого ключа кластера;
        * **Passphrase** — пароль от закрытого ключа.
        * (Опционально) Для подключения через промежуточную ВМ включите настройку **Использовать jump сервер** и укажите параметры:
            * **Хост/IP** — публичный IP-адрес ВМ для подключения;
            * **Имя пользователя** — логин для подключения к ВМ;
            * **Метод аутентификации** — `Публичный ключ`;
            * **Секретный ключ** — путь к файлу закрытого ключа ВМ;
            * **Passphrase** — пароль от закрытого ключа.
  1. Нажмите кнопку **Тест соединения ...** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
  1. Нажмите кнопку **Готово**, чтобы сохранить настройки соединения с БД.

{% endlist %}
