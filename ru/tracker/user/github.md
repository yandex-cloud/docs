# Системы контроля версий


## {{ GL }} {#gitlab}

В [задачах {{ tracker-name }}](../about-tracker.md#zadacha) можно автоматически добавлять ссылки на [Merge Requests]({{ gl.docs }}/ee/user/project/merge_requests/) из {{ GL }}, указывая [ключ](../glossary.md#key) нужной задачи в названии или описании нового Merge Request. Ссылки будут размещаться в разделе [{{ ui-key.startrek.ui_components_issue-links_ExternalLinksCollapse.external-relations}}](../external-links.md).

Дополнительно можно включить автоматическое создание комментариев в задаче с информацией о Merge Requests. Автоматическое комментирование доступно только для [{{ mgl-name }}](../../managed-gitlab/).

{% include [create hook](../../_includes/managed-gitlab/create-hook.md) %}

{% include [test hook](../../_includes/managed-gitlab/test-hook.md) %}

### См. также {#see-also}

* [Практическое руководство по интеграции {{ GL }} с {{ tracker-full-name }}](../../managed-gitlab/tutorials/tracker-integration.md).

