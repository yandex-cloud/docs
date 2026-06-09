# Передача данных из эндпоинта-источника {{ OS }}

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные поиска и аналитики из базы {{ OS }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных {{ OS }}](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных из {{ OS }} {#scenarios}

Миграция — перенос данных из одного хранилища в другое. Часто это перенос базы из устаревших локальных баз в управляемые облачные.

* [Миграция кластера {{ OS }}](../../../tutorials/os-to-mos.md).
* [Загрузка данных из {{ OS }} в {{ objstorage-name }}](../../../tutorials/opensearch-to-object-storage.md).
* [Миграция со сменой хранилища: {{ OS }} в {{ ydb-short-name }}](../../../tutorials/opensearch-to-ydb.md).
* [Миграция со сменой хранилища: {{ OS }} в {{ GP }}](../../../tutorials/opensearch-to-greenplum.md).

* [{#T}](../../../tutorials/opensearch-to-clickhouse.md)

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} читайте в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных источника {#prepare}

{% list tabs %}

- {{ OS }}

  
  Если вы не планируете использовать для подключения к внешнему кластеру [сервис {{ interconnect-name }}](../../../../interconnect/concepts/index.md) или [VPN](../../../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом {{ data-transfer-name }}](../../../../overview/concepts/public-ips.md#virtual-private-cloud}).
  
  Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../../../concepts/network.md#source-external).


{% endlist %}

## Настройка эндпоинта-источника {{ OS }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mos-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).


### Кластер {{ mos-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mos.viewer }}`](../../../../managed-opensearch/security/index.md#mos-viewer) или примитивная [роль `viewer`](../../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение с указанием кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите вариант подключения к кластеру:
    
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}** — позволяет задать настройки подключения вручную.
    
        Выберите тип инсталляции **Кластер Managed Service for OpenSearch** и задайте настройки:
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}** — выберите кластер, к которому необходимо подключиться.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к кластеру.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.password.title }}** — укажите пароль пользователя для доступа к кластеру.
    
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет подключиться к кластеру через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):
    
        * Выберите каталог, в котором находится кластер {{ mos-name }}.
        * Выберите тип инсталляции **Кластер управляемой БД** и задайте настройки:
    
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.mdb_cluster_id.title }}** — выберите кластер, к которому необходимо подключиться.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}** — выберите подключение в {{ connection-manager-name }} или создайте его.
    
        {% note warning %}
        
        Чтобы использовать подключение из {{ connection-manager-name }}, у пользователя должны быть [права доступа](../../../../metadata-hub/operations/connection-access.md) не ниже `connection-manager.user` к этому подключению.
        
        {% endnote %}
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.
    
      Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).

{% endlist %}

### Пользовательская инсталляция {#on-premise}

Подключение к узлам с явным указанием сетевых адресов и портов.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите вариант подключения к базе данных:
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}** — позволяет задать настройки подключения вручную.
    
            Выберите тип инсталляции **Пользовательская инсталляция** и задайте настройки:
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearch.addresses.title }}** — нажмите на значок ![image](../../../../_assets/console-icons/plus.svg), чтобы добавить новый узел с данными. Для каждого узла укажите:
    
              * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearchHostPort.host.title }}** — IP-адрес или FQDN хоста с ролью `DATA`, к которому необходимо подключиться.
              * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearchHostPort.port.title }}** — номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения к хосту с ролью `DATA`.
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearch.ssl_enabled.title }}** — выберите, если используется безопасное соединение SSL.
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearch.ca_certificate.title }}** — загрузите файл [сертификата](../../../../managed-opensearch/operations/connect/index.md#ssl-certificate) или добавьте его содержимое в текстовом виде, если требуется шифрование передаваемых данных, например, для соответствия требованиям PCI DSS.
              
              
              {% note warning %}
              
              Если не добавить сертификат, трансфер может [завершиться ошибкой](../../../troubleshooting/index.md#failed-to-connect).
              
              {% endnote %}
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearch.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к базе данных.
    
              Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.
    
              Если не указать подсеть, при активации трансфера может возникнуть [ошибка](../../../../managed-opensearch/qa/index.md#data-transfer-error).
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.password.title }}** — укажите пароль пользователя для доступа к базе данных.
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет подключиться к базе данных через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):
    
            * Выберите каталог, в котором создано подключение {{ connection-manager-name }}.
            * Выберите тип инсталляции **Пользовательская инсталляция** и задайте настройки:
    
              * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}** — выберите подключение в {{ connection-manager-name }} или создайте его.
              * 
                **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearch.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к базе данных.
    
    
                Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.
    
                Если не указать подсеть, при активации трансфера может возникнуть [ошибка](../../../../managed-opensearch/qa/index.md#data-transfer-error).
    
          {% note warning %}
          
          Чтобы использовать подключение из {{ connection-manager-name }}, у пользователя должны быть [права доступа](../../../../metadata-hub/operations/connection-access.md) не ниже `connection-manager.user` к этому подключению.
          
          {% endnote %}
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.
    
      Это позволит применить к ВМ и БД в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и БД. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).

{% endlist %}

### Дополнительные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchSource.dump_index_with_mapping.title }}** — выберите эту опцию, чтобы перенести типы данных с источника на приемник до начала трансфера. Если опция отключена, а схема индекса на приемнике не задана, то типы данных на приемнике будут определяться автоматически в процессе трансфера.

    {% note warning %}
    
    Если в индекс источника входят типы данных, которые не поддерживаются на приемнике, то включение этой опции может привести к ошибке при запуске трансфера. В этом случае отключите опцию и создайте схему индекса на приемнике вручную.
    
    {% endnote %}

{% endlist %}


## Настройка приемника данных {#supported-targets}

Настройте эндпоинт-приемник:

* [{{ OS }}](../target/opensearch.md);
* [{{ CH }}](../target/clickhouse.md);
* [{{ GP }}](../target/greenplum.md);
* [{{ ydb-full-name }}](../target/yandex-database.md);
* [{{ objstorage-full-name }}](../target/object-storage.md);
* [{{ KF }}](../target/kafka.md);
* [{{ DS }}](../target/data-streams.md);

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} читайте в разделе [Доступные трансферы](../../../transfer-matrix.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Решение проблем, возникающих при переносе данных {#troubleshooting}

* [Прерывание трансфера с ошибкой](#ambiguous-resolution-es)
* [Дублирование документов на приемнике](#duplication)
* [Превышение лимита максимального количества полей](#exceeding-fields-limit)
* [Прерывание трансфера с ошибкой mapper_parsing_exception](#data-types)
* [Ошибка SSL is required](#ssl-required)
* [Не удалось найти ни одной таблицы](#no-tables)

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

### Прерывание трансфера с ошибкой {#ambiguous-resolution-os}

Тексты ошибок:

```text
object field starting or ending with a [.] makes object resolution ambiguous <описание_поля>

Index -1 out of bounds for length 0
```

Трансфер прерывается из-за того что ключи в передаваемых документах невалидны для приемника {{ OS }}. К невалидным относятся пустые ключи, а также ключи:

* состоящие из пробелов;
* состоящие из точек;
* с точкой в начале или конце;
* с точками, стоящими друг за другом;
* с точками, разделенными пробелами.

**Решение:**

В [дополнительных настройках эндпоинта-приемника](../target/opensearch.md#additional-settings) включите опцию **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchTarget.sanitize_doc_keys.title }}** и [активируйте](../../transfer.md#activate) трансфер повторно.

### Дублирование документов на приемнике {#duplication}

На приемнике возникают дубли документов при повторной передаче данных.

Все документы, передаваемые из одной таблицы источника, попадают в один индекс с именем `<schemaName.tableName>` на приемнике. При этом по умолчанию приемник автоматически генерирует идентификаторы документов (`_id`). В результате одинаковые документы получают разные идентификаторы и дублируются.

Дублирование не происходит, если в таблице источника или в правилах конвертации эндпоинта заданы первичные ключи. В этом случае идентификаторы документов генерируются на этапе трансфера с использованием значений первичных ключей.

Генерация происходит следующим образом:

1. Если значение ключа содержит `.`, она экранируется `\`: `some.key` --> `some\.key`.
1. Значения всех первичных ключей преобразуются в строку: `<some_key1>.<some_key2>.<...>`.
1. Полученная строка преобразуется функцией [url.QueryEscape](https://pkg.go.dev/net/url#QueryEscape).
1. Если длина итоговой строки не превышает 512 символов, то она используется в качестве `_id`. Если длина больше 512 символов, то она хешируется алгоритмом [SHA-1](https://datatracker.ietf.org/doc/html/rfc3174), и в качестве `_id` используется полученный хеш.

В результате документы с одинаковыми первичными ключами получат одинаковый идентификатор при повторной передаче данных, и последний переданный документ перезапишет существующий.

**Решение:**

1. Установите первичный ключ для одного или нескольких столбцов на источнике или в правилах конвертации эндпоинта.
1. [Запустите](../../transfer.md#activate) трансфер.

### Превышение лимита максимального количества полей {#exceeding-fields-limit}

Текст ошибки:

```text
Limit of total fields [<значение_лимита>] has been exceeded
```

Трансфер прерывается, если количество колонок в базе данных источника превышает максимальное количество полей в индексах {{ OS }} базы данных приемника.

**Решение:** [увеличьте в базе данных приемника](../target/opensearch.md#prepare) максимальное количество полей с помощью параметра `index.mapping.total_fields.limit`.

### Прерывание трансфера с ошибкой mapper_parsing_exception {#data-types}

Текст ошибки:

```text
mapper_parsing_exception failed to parse field [details.tags] of type [text]
```

Трансфер прерывается из-за несовместимости типов данных на источнике и приемнике.

**Решение:** перенесите данные в новый индекс {{ OS }}, в котором тип поля `details` изменен на `flat_object`.

1. Деактивируйте трансфер.

1. Создайте новый индекс в {{ OS }}:

    ```bash
    curl \
    --user <имя_пользователя_{{ OS }}>:<пароль> \
    --header 'Content-Type: application/json' \
    --request PUT 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/<название_нового_индекса>/_settings' \
    --data '{"index.mapping.total_fields.limit": 2000}'
    ```

1. Измените тип поля `details`:

    ```bash
    curl \
    --user <имя_пользователя_{{ OS }}>:<пароль> \
    --header 'Content-Type: application/json' \
    --request PUT 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/<название_нового_индекса>/_mapping' \
    --data '
        {
            "properties": {
                "details": {
                    "type": "flat_object"
                }
            }
        }'
    ```    

1. Перенесите данные из исходного индекса в новый:

    ```bash
    curl \
    --user <имя_пользователя_{{ OS }}>:<пароль> \
    --header 'Content-Type: application/json' \
    --request POST 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/_reindex' \
    --data '
        {
        "source":{
            "index":"<название_исходного_индекса>"
        },
        "dest":{
            "index":"<название_нового_индекса>"
        }
        }'
    ```

1. Удалите исходный индекс:

    ```bash
    curl \
    --user <имя_пользователя_{{ OS }}>:<пароль> \
    --header 'Content-Type: application/json' \
    --request DELETE 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/<название_исходного_индекса>'
    ```

1. Присвойте новому индексу псевдоним:

    ```bash
    curl \
    --user <имя_пользователя_{{ OS }}>:<пароль> \
    --header 'Content-Type: application/json' \
    --request POST 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/_aliases' \
    --data '
        {
        "actions": [
            {
            "add": {
                "index": "<название_нового_псевдонима>",
                "alias": "<название_исходного_псевдонима>"
            }
            }
        ]
        }'
    ```

### Ошибка SSL is required {#ssl-required}

Ошибка возникает при подключении к кластеру {{ mos-name }} как к пользовательской инсталляции через [FQDN](../../../../managed-opensearch/concepts/network.md#hostname) хоста {{ OS }}, если вы не включили опцию **SSL** в настройках эндпоинта. Кластер {{ mos-name }} по умолчанию требует SSL-шифрование для подключений по FQDN хоста. 

Ошибка может также возникнуть, если вы подключаетесь к пользовательской инсталляции {{ OS }}, которая требует SSL.

**Решение:**

В настройках эндпоинта активируйте опцию **SSL**.

Для кластеров MDB и других источников, использующих сертификаты, выданные публичными CA, обычно не требуется загружать CA-сертификат.

Если ваш источник использует самоподписанный сертификат, загрузите CA-сертификат в соответствующее поле в настройках эндпоинта.

### Не удалось найти ни одной таблицы {#no-tables}

Текст ошибки:

```text
Unable to find any tables
```

Ошибка может возникать, если в источнике нет доступных индексов либо у указанного пользователя нет прав на индексы.

**Решение:**

* Проверьте наличие индекса. Убедитесь, что вы верно указали название индекса и в источнике действительно есть индекс, который вы собираетесь переносить.

* Убедитесь, что пользователь имеет нужные права для работы с индексом.