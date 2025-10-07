---
title: Инструкция по настройке эндпоинта-источника {{ ES }} в {{ data-transfer-full-name }}
description: Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-источника {{ ES }} в {{ data-transfer-full-name }}.
---

# Передача данных из эндпоинта-источника {{ ES }}


С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные поиска и аналитики из базы {{ ES }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных {{ ES }}](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных из {{ ES }} {#scenarios}

{% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

* [Миграция со сменой типа хранилища из {{ ES }} в {{ OS }}](../../../tutorials/mes-to-mos.md)

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных источника {#prepare}

{% include [elastic-version](../../../../_includes/data-transfer/elastic-version-note.md) %}

{% include notitle [White IP list](../../../../_includes/data-transfer/configure-white-ip.md) %}

## Настройка эндпоинта-источника {{ ES }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [пользовательской инсталляции](#on-premise). Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

### Пользовательская инсталляция {#on-premise}

Подключение к узлам с явным указанием сетевых адресов и портов.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearch.addresses.title }}** — нажмите на значок ![image](../../../../_assets/console-icons/plus.svg), чтобы добавить новый узел с данными. Для каждого узла укажите:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearchHostPort.host.title }}** — IP-адрес или FQDN хоста с ролью `DATA`, к которому необходимо подключиться.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearchHostPort.port.title }}** — номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения к хосту с ролью `DATA`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearch.ssl_enabled.title }}** — выберите, если используется безопасное соединение SSL.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearch.ca_certificate.title }}** — загрузите файл сертификата или добавьте его содержимое в текстовом виде, если требуется шифрование передаваемых данных, например, для соответствия требованиям PCI DSS.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearch.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md).
      Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchConnection.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к кластеру.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchConnection.password.title }}** — укажите пароль пользователя для доступа к кластеру.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.

     Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее см. в разделе [{#T}](../../../../data-transfer/concepts/network.md).

{% endlist %}

### Дополнительные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchSource.dump_index_with_mapping.title }}** — выберите эту опцию, чтобы перенести типы данных с источника на приемник до начала трансфера. Если опция отключена, а схема индекса на приемнике не задана, то типы данных на приемнике будут определяться автоматически в процессе трансфера.

    {% include [dump-index-warning](../../../../_includes/data-transfer/necessary-settings/ui/dump-index-warning.md) %}

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

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).
