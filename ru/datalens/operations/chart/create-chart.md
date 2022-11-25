# Создание чарта

Чтобы создать чарт:

{% if product == "yandex-cloud" %}

{% if audience != "internal" %}

1. Перейдите на главную страницу [{{ datalens-short-name }}]({{ link-datalens-main }}).
1. Нажмите кнопку **Создать чарт**.

{% else %} 

1. Перейдите на главную страницу [{{ datalens-short-name }}](https://datalens.yandex-team.ru).
1. На рабочей панели слева нажмите ![image](../../../_assets/datalens/chart.svg).
1. В открывшемся окне нажмите кнопку **Cоздать чарт** -> **Чарт в Wizard**.

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

1. Откройте [главную страницу]({{ link-datalens-main }}) {{ datalens-short-name }}.
1. Перейдите в [воркбук](../../concepts/index.md#workbooks-and-collections), внутри которого вы хотите создать чарт.
1. На странице воркбука, в правом верхнем углу, нажмите **Создать** → **Чарт в Wizard**.

{% endif %}

1. На верхней панели выберите [тип визуализации](../../visualization-ref/index.md).


##### См. также

- [{#T}](../../concepts/chart/index.md).


