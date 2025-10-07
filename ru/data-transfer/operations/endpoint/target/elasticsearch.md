---
title: Инструкция по настройке эндпоинта-приемника {{ ES }} в {{ data-transfer-full-name }}
description: Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-приемника {{ ES }} в {{ data-transfer-full-name }}.
---
# Передача данных в эндпоинт-приемник {{ ES }}


С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные в базу {{ ES }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Подготовьте базу данных {{ ES }}](#prepare) к трансферу.
1. [Настройте эндпоинт-приемник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [{{ KF }}](../source/kafka.md);
* [{{ DS }}](../source/data-streams.md);
* [{{ PG }}](../source/postgresql.md).
* [{{ ES }}](../source/elasticsearch.md);
* [{{ OS }}](../source/opensearch.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

## Подготовка базы данных приемника {#prepare}

{% include [elastic-version](../../../../_includes/data-transfer/elastic-version-note.md) %}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/targets/elasticsearch-prepare.md) %}

## Настройка эндпоинта-приемника {{ ES }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* [Настройки подключения к {{ ES }}](#on-premise). Эти параметры обязательные.
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

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchTarget.cleanup_policy.title }}** — выберите способ очистки данных в приемнике перед переносом:

        * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}` — выберите эту опцию, если будет производиться только репликация без копирования данных.

        * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}` — полное удаление таблиц, участвующих в трансфере (вариант по умолчанию).

            Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия схемы таблиц из источника.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchTarget.sanitize_doc_keys.title }}** — выберите эту опцию, чтобы для полей на приемнике выполнялась автозамена ключей, невалидных для {{ ES }}.

        {% include [sanitize-rules](../../../../_includes/data-transfer/necessary-settings/ui/es-os-sanitize-rules.md) %}

{% endlist %}


После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).
