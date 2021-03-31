# Визуализация данных из Metriсa

В качестве источника данных будет использован один из счетчиков Яндекс.Метрики, к которому у вас есть доступ. Просмотреть список доступных вам счетчиков можно по ссылке [https://metrika.yandex.ru/list](https://metrika.yandex.ru/list).
    ![image](../../_assets/datalens/solution-03/01-metrica-list.png)

Если в вашем списке не оказалось доступных счетчиков, то получите доступ к счетчику или используйте демонстрационный дашборд Яндекс.Метрики. Он создается автоматически при создании экземпляра {{ datalens-short-name }}.

Для визуализации и исследования данных [подготовьте облако к работе](#before-you-begin), затем выполните следующие шаги:

1. [Создайте подключение и стандартный дашборд](data-from-metrica-visualization#step1).
1. [Измените стандартный дашборд](data-from-metrica-visualization#step2).
1. [Измените чарт](data-from-metrica-visualization#step3).



## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](includes/before-you-begin-datalens.md) %}

## Шаг 1. Создайте подключение и стандартный дашборд {#step1}

{% note warning %}

Данный шаг доступен для пользователей, у которых есть права на какой-либо счетчик Яндекс.Метрики. Если у вас нет прав на счетчик, то откройте готовый дашборд [**Metriсa Live Demo Dashboard**](https://datalens.yandex.ru/navigation?path=Demo/Metrica/Metrica%20Live%20Demo%20Dashboard) и перейдите к шагу 2.

{% endnote %}

1. Перейдите в [{{ datalens-short-name }}](https://datalens.yandex.ru).
1. Нажмите кнопку **Создать подключение**.

    ![image](../../_assets/datalens/solution-03/02-create-connection.png)

1. Выберите **Metriсa**.

    ![image](../../_assets/datalens/solution-03/03-choose-metrica.png)

1. Введите имя подключения **My Metriсa** и нажмите кнопку **Получить токен**.

    ![image](../../_assets/datalens/solution-03/04-metrica-creation1.png)
    
    Если вы первый раз создаете подключение к счетчику Яндекс.Метрики, то предоставьте сервису необходимые разрешения.
1. Выберите необходимый счетчик из выпадающего списка. 

    ![image](../../_assets/datalens/solution-03/05-metrica-creation2.png)

1. Выберите уровень [точности](https://yandex.ru/dev/metrika/doc/api2/api_v1/sampling-docpage/) из выпадающего списка.

    ![image](../../_assets/datalens/solution-03/06-01-metrica-creation-accuracy.png)

1. Выберите тип подключения **Прямой доступ**.
1. Включите опцию **Автоматически создать дашборд, чарты и датасет над подключением**.
1. Нажмите кнопку **Создать**.

    ![image](../../_assets/datalens/solution-03/06-metrica-creation3.png)

    После создания подключения откроется папка с набором датасетов, чартов и дашборда.
    
1. Перейдите на **Дашборд по данным Метрики**.

    ![image](../../_assets/datalens/solution-03/07-open-dashboard.png)

## Шаг 2. Измените стандартный дашборд {#step2}

{% note warning %}

Если у вас нет счетчика Яндекс.Метрики и вы пропустили шаг 1, используйте дашборд [**Metriсa Live Demo Dashboard**](https://datalens.yandex.ru/navigation?path=Demo/Metrica/Metrica%20Live%20Demo%20Dashboard).

{% endnote %}

Вы можете изменять стандартный [дашборд](../../datalens/concepts/dashboard.md) так, как вам удобно. Например, вы можете удалить ненужный график.

1. В дашборде нажмите кнопку **Редактировать** в верхнем правом углу.

    ![image](../../_assets/datalens/solution-03/09-edit-dashboard.png)

1. Удалите чарт **Глубина просмотров**. Для этого нажмите значок ![image](../../_assets/datalens/horizontal-ellipsis-black.svg)  в верхнем правом углу графика и выберите **Удалить**.

    ![image](../../_assets/datalens/solution-03/10-delete-charts1.png)
    
1. Разместите чарты **Отказы** и **Время на сайте** таким образом, чтобы они заполнили пустое пространство после удаления чарта на предыдущем шаге. Перетащите чарт, кликнув на сам чарт. Измените размер чарта, потянув за треугольник в нижнем правом углу чарта. 

    ![image](../../_assets/datalens/solution-03/11-replace-charts.png)
 
1. Удалите чарты **Доля визитов по браузерам** и **Визиты, просмотры и посетители по браузерам**.

    ![image](../../_assets/datalens/solution-03/12-delete-charts2.png)

1. Нажмите кнопку **Сохранить** в верхнем правом углу и сохраните дашборд.

     ![image](../../_assets/datalens/solution-03/13-save-dashboard.png)

## Шаг 3. Измените чарт {#step3}

Вы можете отредактировать любой чарт на дашборде. Например, поменяйте тип визуализации для диаграммы **Визиты по типам устройств и ОС** из раздела **Технологии**.

1. Нажмите значок ![image](../../_assets/datalens/horizontal-ellipsis-black.svg) в верхнем правом углу графика **Визиты по типам устройств и ОС**.
1. Выберите **Редактировать**.

    ![image](../../_assets/datalens/solution-03/14-edit-chart.png)

1. В открывшемся окне во втором столбце нажмите **Древовидная диаграмма** и выберите другой тип чарта — **Круговая диаграмма**.

    ![image](../../_assets/datalens/solution-03/15-choose-pie.png)

1. Нажмите кнопку **Сохранить** в верхнем правом углу и сохраните чарт.

    ![image](../../_assets/datalens/solution-03/16-save-chart.png)

1. Закройте вкладку с редактированием чарта и вернитесь в окно с дашбордом.

1. Обновите дашборд и убедитесь, что в разделе **Технологии** чарт изменился.

    ![image](../../_assets/datalens/solution-03/17-refresh-dashboard.png)
