# Удаление кластера {{ metastore-full-name }}

Вы можете удалить кластер {{ metastore-name }} вместе со всеми хранимыми данными.

## Перед удалением кластера {#before-you-delete}

Отключите защиту от удаления для кластера, если она включена.

## Удалите кластер {#delete}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ dataproc-name }}**.
    1. На левой панели выберите страницу ![image](../../../_assets/data-proc/metastore.svg) **Metastore-сервер**.
    1. Нажмите на значок ![image](../../../_assets/options.svg) для нужного кластера и выберите пункт **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
    1. В открывшемся окне нажмите кнопку **Удалить**.

{% endlist %}
