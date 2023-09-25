---
title: "Как настроить эндпоинт-источник {{ metrika-endpoint }}"
description: "Следуя данной инструкции, вы сможете настроить эндпоинт-источник {{ metrika-endpoint }}."
noIndex: true
---

# Настройка эндпоинта-источника {{ metrika-endpoint }}

{% include [note-metrica-pro](../../../../_includes/data-transfer/note-metrica-pro.md) %}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта задайте настройки доступа к сервису [{{ metrika }}]({{ metrika-link }}).

## Настройки {#settings}

{% list tabs %}

- Консоль управления

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.counter_ids.title }}** — укажите [номера счетчиков](https://yandex.ru/support/metrica/general/tag-id.html), из которых будут поступать данные.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.token.title }}** — укажите токен для подтверждения доступа к счетчикам. Его можно получить по [ссылке](https://oauth.yandex.ru/authorize?response_type=token&client_id=36b7fc9aa96c4fa09158bcacbbdc796a).
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.hits.title }}** — выберите, передавать ли информацию о хитах.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.hits.columns.title }}** — выберите поля хита, которые нужно экспортировать. Помимо выбранных полей, всегда экспортируется несколько обязательных полей.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.visits.title }}** — выберите, передавать ли информацию о визитах.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.visits.columns.title }}** — выберите поля визита, которые нужно экспортировать. Помимо выбранных полей, всегда экспортируется несколько обязательных полей.

{% endlist %}

Подробнее о настройках см. в [документации сервиса]({{ link-yandex }}/support/metrica/index.html).

См. [практическое руководство](../../../tutorials/metrika-to-clickhouse.md) по переносу данных из счетчика {{ metrika }} в кластер {{ CH }}.