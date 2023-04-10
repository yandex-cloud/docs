---
noIndex: true
---

# Удаление сервера {{ metastore-name }}

Вы можете удалить сервер вместе со всеми хранимыми данными.

## Перед удалением сервера {#before-you-delete}

Отключите защиту от удаления для сервера, если она включена.

## Удалить сервер {#delete}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ dataproc-name }}**.
    1. На левой панели нажмите на значок ![image](../../../_assets/data-proc/metastore.svg) **Metastore-сервер**.
    1. Нажмите на значок ![image](../../../_assets/options.svg) для нужного сервера и выберите пункт **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
    1. Подтвердите удаление сервера.

{% endlist %}
