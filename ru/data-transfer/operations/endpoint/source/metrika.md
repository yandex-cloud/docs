---
title: "Как настроить эндпоинт-источник {{ metrika-endpoint }}"
description: "Следуя данной инструкции, вы сможете настроить эндпоинт-источник {{ metrika-endpoint }}."
noIndex: true
---

# Передача данных из эндпоинта-источника {{ metrika }}


С помощью сервиса {{ data-transfer-name }} вы можете перенести данные из счетчика [{{ metrika }}]({{ metrika-link }}) в управляемую базу данных {{ yandex-cloud }}.

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Cоздайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](../../../troubleshooting/index.md) по их устранению.

## Сценарии передачи данных из {{ metrika }} {#scenarios}

С помощью сервиса {{ data-transfer-name }} вы можете перенести данные из счетчика [{{ metrika }}]({{ metrika-link }}) в кластер {{ CH }}. Такой перенос обеспечивает полноту переносимых данных из {{ metrika }} и предоставляет возможности для:

* обработки данных средствами {{ CH }};
* стриминга из {{ CH }} в другие локации;
* визуализации с помощью [{{ datalens-full-name }}]({{ link-datalens-main }}) или других сервисов.

См. [практическое руководство](../../../tutorials/metrika-to-clickhouse.md) по переносу данных из счетчика {{ metrika }} в кластер {{ CH }}.

Подробное описание остальных возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка эндпоинта-источника {{ metrika-endpoint }} {#endpoint-settings}

{% include [note-metrica-pro](../../../../_includes/data-transfer/note-metrica-pro.md) %}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта задайте настройки доступа к сервису [{{ metrika }}]({{ metrika-link }}).

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.counter_ids.title }}** — укажите [номера счетчиков](https://yandex.ru/support/metrica/general/tag-id.html), из которых будут поступать данные.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.token.title }}** — укажите токен для подтверждения доступа к счетчикам. Его можно получить по [ссылке](https://oauth.yandex.ru/authorize?response_type=token&client_id=36b7fc9aa96c4fa09158bcacbbdc796a).
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.hits.title }}** — выберите, передавать ли информацию о хитах.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.hits.columns.title }}** — выберите поля хита, которые нужно экспортировать. Помимо выбранных полей, всегда экспортируется несколько обязательных полей.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.visits.title }}** — выберите, передавать ли информацию о визитах.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.visits.columns.title }}** — выберите поля визита, которые нужно экспортировать. Помимо выбранных полей, всегда экспортируется несколько обязательных полей.

{% endlist %}

Подробнее о настройках см. в [документации сервиса]({{ link-yandex }}/support/metrica/index.html).

## Настройка приемника данных {#supported-targets}

Настройте поддерживаемый приемник данных:

* [{{ CH }}](../target/clickhouse.md).

Полный список поддерживаемых источников и приемников в сервисе {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}