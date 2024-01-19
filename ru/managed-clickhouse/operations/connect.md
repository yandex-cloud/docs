---
title: "Как подключиться к базе данных в кластере {{ CH }} в {{ mch-full-name }}"
description: "Следуя данной инструкции, вы сможете подключиться к базе данных в кластере {{ CH }}." 
---

# Подключение к базе данных в кластере {{ CH }}

К хостам кластера {{ mch-short-name }} можно подключиться:

{% include [cluster-connect-note](../../_includes/mdb/mch/cluster-connect-note.md) %}


К кластеру можно подключиться как с использованием шифрования — через порты `{{ port-mch-cli }}` для [clickhouse-client]({{ ch.docs }}/interfaces/cli/) и `{{ port-mch-http }}` для [HTTP-интерфейса]({{ ch.docs }}/interfaces/http/), так и без него — через порты `9000` и `8123` соответственно.



## Настройка групп безопасности {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Настройки правил будут различаться в зависимости от выбранного способа подключения:

{% list tabs %}

- Через интернет

  [Настройте все группы безопасности](../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик с любых IP-адресов на порты 8443, 9440. Для этого создайте следующие правила для входящего трафика:

  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `8443`, `9440`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

  На каждый порт создается отдельное правило.

- С ВМ в {{ yandex-cloud }}

  1. [Настройте все группы безопасности](../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик из группы безопасности, в которой находится ВМ, на порты 8123, 8443, 9000, 9440. Для этого создайте в этих группах следующие правила для входящего трафика:

     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `8123` (или другой порт из перечисленных).
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — если кластер и ВМ находятся в одной и той же группе безопасности, выберите значение `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`). В противном случае укажите группу безопасности ВМ.

     На каждый порт создается отдельное правило.

  1. [Настройте группу безопасности](../../vpc/operations/security-group-add-rule.md), в которой находится ВМ так, чтобы можно было подключаться к ВМ и был разрешен трафик между ВМ и хостами кластера.

     Пример правил для ВМ:

     * Для входящего трафика:
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `22`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

       Это правило позволяет [подключаться](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по протоколу [SSH](../../glossary/ssh-keygen.md).

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

Подробнее о группах безопасности см. в разделе [Сеть и кластеры БД](../concepts/network.md#security-groups).


## Получение SSL-сертификатов {#get-ssl-cert}

Чтобы использовать шифрованное соединение, получите SSL-сертификаты:

{% include [install-certificate](../../_includes/mdb/mch/install-certificate.md) %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## FQDN хоста {{ CH }} {#fqdn}

Для подключения к хосту потребуется его [FQDN](../concepts/network.md#hostname) — доменное имя. Его можно получить несколькими способами:

* [Запросите список хостов в кластере](../operations/hosts.md#list-hosts).
* Скопируйте команду для подключения к кластеру в [консоли управления]({{ link-console-main }}). Команда содержит заполненный FQDN хоста. Чтобы получить команду, перейдите на страницу кластера и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-connect }}**.
* Посмотрите FQDN в консоли управления:

   1. Перейдите на страницу кластера.
   1. Перейдите в раздел **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
   1. Скопируйте значение в столбце **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}**.

Для хостов кластера также используется [особый FQDN](#auto).

### Автоматический выбор доступного хоста {#auto}

Чтобы вручную не подключаться к другому хосту, если текущий станет недоступен, можно использовать особый FQDN. Он может быть представлен в двух видах:

* `c-<идентификатор_кластера>.rw.{{ dns-zone }}` — для подключения к доступному хосту кластера;

* `<имя_шарда>.c-<идентификатор_кластера>.rw.{{ dns-zone }}` — для подключения к доступному хосту [шарда](../concepts/sharding.md).

Если хост, на который указывает FQDN, станет недоступен, может быть небольшая задержка, прежде чем FQDN начнет указывать на другой доступный хост.

{% note warning %}

Если при [обслуживании кластера](../concepts/maintenance.md#maintenance-order) особый FQDN укажет на хост без публичного доступа, подключиться к кластеру из интернета будет невозможно. Чтобы этого избежать, [включите публичный доступ](hosts.md#update) для всех хостов кластера.

{% endnote %}

## Подключение из графических IDE {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

Подключаться из графических IDE можно только к хостам кластера в публичном доступе с использованием SSL-сертификата.

{% include [note-connection-ide](../../_includes/mdb/note-connection-ide.md) %}

{% list tabs %}

- DataGrip

  1. Создайте источник данных:
     1. Выберите в меню **File** → **New** → **Data Source** → **{{ CH }}**.
     1. На вкладке **General**:
        1. Укажите параметры подключения: 
           * **Host** — [FQDN любого хоста {{ CH }}](#fqdn) или один из [особых FQDN](#auto);
           * **Port** — `{{ port-mch-http }}`;
           * **User**, **Password** — имя и пароль пользователя БД;
           * **Database** — имя БД для подключения.
        1. Нажмите ссылку **Download**, чтобы загрузить драйвер соединения.
     1. На вкладке **SSH/SSL**:
        1. Включите настройку **Use SSL**.
        1. Укажите папку с файлом скачанного [SSL-сертификата для подключения](#get-ssl-cert).
  1. Нажмите ссылку **Test Connection** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
  1. Нажмите кнопку **OK**, чтобы сохранить источник данных.

- DBeaver

  1. Создайте новое соединение с БД:
     1. Выберите в меню **База данных** пункт **Новое соединение**.
     1. Выберите из списка БД **{{ CH }}**.
     1. Нажмите кнопку **Далее**.
     1. Укажите параметры подключения на вкладке **Главное**:
        * **Хост** — [FQDN любого хоста {{ CH }}](#fqdn) или один из [особых FQDN](#auto);
        * **Порт** — `{{ port-mch-http }}`;
        * **БД/Схема** — имя БД для подключения;
        * В блоке **Аутентификация** укажите имя и пароль пользователя БД.
     1. На вкладке **Свойства драйвера**:
        1. Нажмите **Скачать** в новом окне с приглашением скачать файлы драйвера.
        1. Укажите параметры [для SSL-соединения](#get-ssl-cert) в списке свойств драйвера:
           * `ssl:true`;
           * `sslrootcert:<путь_к_сохраненному_файлу_SSL-сертификата>`.
  1. Нажмите кнопку **Тест соединения ...** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
  1. Нажмите кнопку **Готово**, чтобы сохранить настройки соединения с БД.

{% endlist %}

## Подготовка к подключению из Docker-контейнера {#connection-docker}

Чтобы подключаться к кластеру {{ mch-name }} из Docker-контейнера, добавьте в Dockerfile строки:

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

   ```bash
   # Подключить DEB-репозиторий.
   RUN apt-get update && \
       apt-get install wget --yes apt-transport-https ca-certificates dirmngr && \
       apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8919F6BD******** && \
       echo "deb https://packages.{{ ch-domain }}/deb stable main" | tee \
       /etc/apt/sources.list.d/clickhouse.list && \
       # Установить зависимости.
       apt-get update && \
       apt-get install wget clickhouse-client --yes && \
       # Загрузить файл конфигурации для clickhouse-client.
       mkdir --parents ~/.clickhouse-client && \
       wget "https://{{ s3-storage-host-doc-files }}/clickhouse-client.conf.example" \
            --output-document ~/.clickhouse-client/config.xml
   ```


- Подключение с SSL {#with-ssl}

   
   ```bash
   # Подключить DEB-репозиторий.
   RUN apt-get update && \
       apt-get install wget --yes apt-transport-https ca-certificates dirmngr && \
       apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8919F6BD******** && \
       echo "deb https://packages.{{ ch-domain }}/deb stable main" | tee \
       /etc/apt/sources.list.d/clickhouse.list && \
       # Установить зависимости.
       apt-get update && \
       apt-get install wget clickhouse-client --yes && \
       # Загрузить файл конфигурации для clickhouse-client.
       mkdir --parents ~/.clickhouse-client && \
       wget "https://{{ s3-storage-host-doc-files }}/clickhouse-client.conf.example" \
            --output-document ~/.clickhouse-client/config.xml && \
       # Получить SSL-сертификаты.
       mkdir --parents {{ crt-local-dir }} && \
       wget "{{ crt-web-path-root }}" \
            --output-document {{ crt-local-dir }}{{ crt-local-file-root }} && \
       wget "{{ crt-web-path-int }}" \
            --output-document {{ crt-local-dir }}{{ crt-local-file-int }} && \
       chmod 655 \
            {{ crt-local-dir }}{{ crt-local-file-root }} \
            {{ crt-local-dir }}{{ crt-local-file-int }} && \
       update-ca-certificates
   ```


{% endlist %}


## Подключение из браузера {#browser-connection}

Для выполнения SQL-запросов из браузера используйте:

* [Консоль управления](#console).

* [Встроенный SQL-редактор](#inline-editor).


* [Сервис {{ websql-full-name }}](#websql).


При подключении из браузера SQL-запросы выполняются отдельно, без создания единой сессии с сервером {{ CH }}. Поэтому запросы, которые действуют в пределах сессии (например, `USE` или `SET`), не имеют эффекта.

### Консоль управления {#console}

{% include [web-sql-warning](../../_includes/mdb/mch/note-web-sql-console.md) %}

Чтобы подключиться к кластеру {{ mch-name }}, войдите в [консоль управления]({{ link-console-main }}), откройте страницу нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_explore }}**.

Для разрешения подключения включите опцию **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}** при [создании кластера](cluster-create.md) или [изменении его настроек](update.md#change-additional-settings).

Подробнее см. в разделе [{#T}](web-sql-query.md)

### Встроенный SQL-редактор {#inline-editor}



Чтобы подключиться к хосту кластера из встроенного SQL-редактора, укажите в браузере адресную строку:

```text
https://<FQDN_любого_хоста_{{ CH }}>:8443/play
```

Подключаться можно только к хостам кластера в публичном доступе. О том, как получить FQDN хоста, см. [инструкцию](#fqdn).

Чтобы подключиться к кластеру с помощью [автоматического выбора доступного хоста](#auto), используйте адрес:

* `https://c-<идентификатор_кластера>.rw.{{ dns-zone }}:8443/play` — для подключения к доступному хосту кластера.
* `https://<имя_шарда>.c-<идентификатор_кластера>.rw.{{ dns-zone }}:8443/play` — для подключения к доступному хосту [шарда](../concepts/sharding.md).

Для выполнения запросов к базе данных укажите имя пользователя и пароль в правом верхнем углу страницы.



### Сервис {{ websql-full-name }} {#websql}

{% include notitle [preview](../../_includes/note-preview.md) %}

В сервисе [{{ websql-full-name }}](../../websql) создайте соединение с кластером {{ CH }} в {{ yandex-cloud }}.

{% include notitle [connect-to-cluster](../../_includes/websql/connect-to-cluster.md) %}

{% include notitle [execute-sql](../../_includes/websql/execute-sql.md) %}


## Примеры строк подключения {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mdb-conn-strings-env.md) %}

Вы можете подключаться к хостам кластера {{ CH }} в публичном доступе только с использованием SSL-сертификатов. Перед подключением [подготовьте сертификаты](#get-ssl-cert).

В примерах ниже предполагается, что сертификаты `{{ crt-local-file-root }}` и `{{ crt-local-file-int }}`:
* расположены в директории `{{ crt-local-dir }}` — для Ubuntu;
* импортированы в хранилище доверенных корневых сертификатов — для Windows.

Подключение без использования SSL-сертификатов поддерживается только для хостов, находящихся не в публичном доступе. В этом случае трафик внутри виртуальной сети при подключении к БД шифроваться не будет.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ CH }}.

{% include [mch-connection-strings](../../_includes/mdb/mch-conn-strings.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
