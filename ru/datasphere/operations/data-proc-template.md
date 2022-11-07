# Работа с шаблонами {{ dataproc-name }}

[Шаблоны {{ dataproc-name }}](../concepts/data-proc-template.md) позволяют заранее подготовить конфигурацию кластера для проекта и упростить развертывание временных кластеров. Список шаблонов доступен на странице проекта в блоке **Ресурсы проекта** → ![data-proc-template](../../_assets/datasphere/data-proc-template.svg) **Data Proc**,  вкладка **Доступные**.

{% include [data-proc-template-presetting](../../_includes/datasphere/settings-for-dataproc.md) %}

## Создать шаблон {{ dataproc-name }} {#create}

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %} 
1. В блоке **Ресурсы проекта** нажмите ![data-proc-template](../../_assets/datasphere/data-proc-template.svg) **{{ dataproc-name }}**.
1. Нажмите кнопку **Создать шаблон**. 
1. В поле **Имя шаблона** задайте имя.

    {% include [name-format](../../_includes/name-format.md) %}

1. Нажмите кнопку **Создать**. Откроется страница с информацией о созданном шаблоне.

## Активировать шаблон {{ dataproc-name }} {#activate}

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **Ресурсы проекта** нажмите ![data-proc-template](../../_assets/datasphere/data-proc-template.svg) **{{ dataproc-name }}**.
1. Выберите нужный шаблон в списке.
1. Нажмите кнопку **Применить**.

Кластер на основе активированного шаблона {{ dataproc-name }} будет создан при запуске проекта в IDE.

## Поделиться шаблоном {{ dataproc-name }} {#share}

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %} 
1. В блоке **Ресурсы проекта** нажмите ![data-proc-template](../../_assets/datasphere/data-proc-template.svg) **{{ dataproc-name }}**.
1. Выберите нужный шаблон в списке.
1. Перейдите на вкладку **Доступ**.
1. Включите опцию видимости напротив названия сообщества, в котором нужно поделиться шаблоном.

## Изменить шаблон {#edit}

Вы можете изменить только имя уже созданного шаблона. Чтобы изменить конфигурацию, [создайте](#create) шаблон заново.

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **Ресурсы проекта** нажмите ![data-proc-template](../../_assets/datasphere/data-proc-template.svg) **{{ dataproc-name }}**.
1. Выберите нужный шаблон в списке, нажмите значок ![options](../../_assets/options.svg) и выберите **Редактировать**.
1. Измените имя и нажмите **Сохранить**.

## Удалить шаблон {{ dataproc-name }} {#delete}

1. {% include [ui-find-project](../../_includes/datasphere/ui-find-project.md) %} 
1. В блоке **Ресурсы проекта** нажмите ![data-proc-template](../../_assets/datasphere/data-proc-template.svg) **{{ dataproc-name }}**.
1. Выберите в списке шаблон, который нужно удалить.
1. Нажмите значок ![options](../../_assets/options.svg) и выберите **Удалить**.
