# Датасет в {{ datalens-name }}

_Датасет_ описывает набор данных и его структуру.
Набор данных датасета представлен в виде полей. Подробнее в разделе [{#T}](data-model.md).

{{ datalens-full-name }} создает датасет на основе источника данных, для которого существует подключение.

{% if audience != "internal" %}

Датасет работает с источниками в режиме прямого доступа: все запросы к данным {{ datalens-short-name }} выполняет на стороне источника.

{% endif %}

## Создание датасета {#create-dataset}

Чтобы создать датасет:

{% include [datalens-create-dataset](../../../_includes/datalens/operations/datalens-create-dataset.md) %}