# Создание линейчатой диаграммы

Чтобы создать линейчатую диаграмму:
1. На главной странице сервиса {{ datalens-full-name }} нажмите **Создать чарт**.
1. В разделе **Датасет** выберите датасет для визуализации. Если у вас нет датасета, [создайте его](../dataset/create.md).
1. Выберите тип чарта **Линейчатая диаграмма**.
1. Перетащите одно или несколько измерений из датасета в секцию **Y**. Значения отобразятся по оси Y.
   
   {% include [chart-signature-note](../../../_includes/datalens/operations/datalens-chart-signature-note.md) %}

1. Перетащите один или несколько показателей из датасета в секцию **X**.

По умолчанию отображается диаграмма с накоплением.

Подробное описание секций чарта см. в разделах [{#T}](../../concepts/chart/types.md#horizontal-bar-chart) и [{#T}](../../concepts/chart/types.md#normalized-horizontal-bar-chart).

## Создание линейчатой диаграммы c группировкой {#grouped-bar-chart}

Чтобы отобразить диаграмму с группировкой по оси Y:
1. Перейдите к уже созданной линейчатой диаграмме.
1. В зависимости от количества показателей в секции **X** выполните следующие действия:
    
    {% list tabs %}
    
    - Один показатель
       
        1. Проверьте наличие измерения в секции **Цвета**.
        1. Продублируйте это измерение в секцию **Y**. Порядок измерений будет влиять на порядок группировки.
        
        <iframe src="https://datalens.yandex/5th7z71ms5w6z?_embedded=1&_theme=system" width="600" height="400" frameborder="0"></iframe>
    
    - Два и больше показателей
    
        1. Перетащите измерение `Measure Names` в секцию **Цвета**.
        1. Перетащите измерение `Measure Names` в секцию **Y**. Порядок измерений будет влиять на порядок группировки.
    
        <iframe src="https://datalens.yandex/0oxyakxold4gu?_embedded=1&_theme=system" width="600" height="400" frameborder="0"></iframe>

    {% endlist %}

## Настройка отображения пустых (`null`) значений {#null-settings}

{% include [datalens-chart-null-settings](../../../_includes/datalens/datalens-chart-null-settings.md) %}
