# Веб-аналитика с подключением к Яндекс Метрике


{% include [datalens-metrica-pro-note](../../_includes/datalens/datalens-metrica-pro-note.md) %}


В качестве источника данных будет использован один из счетчиков Яндекс Метрики, к которому у вас есть доступ. Просмотреть список доступных вам счетчиков можно по ссылке [https://metrika.yandex.ru/list](https://metrika.yandex.ru/list).

![image](../../_assets/datalens/solution-03/01-metrica-list.png)

Если в вашем списке не оказалось доступных счетчиков, то получите доступ к счетчику или используйте демонстрационный дашборд Яндекс Метрики. Он создается автоматически при создании экземпляра {{ datalens-short-name }}.

Для визуализации и исследования данных [подготовьте {{ datalens-short-name }} к работе](#before-you-begin), затем выполните следующие шаги:

1. [Создайте подключение и стандартный дашборд](#step1).
1. [Измените стандартный дашборд](#step2).
1. [Измените чарт](#step3).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../includes/before-you-begin-datalens.md) %}


## Шаг 1. Создайте подключение и стандартный дашборд {#step1}

{% note warning %}

Данный шаг доступен для пользователей, у которых есть права на какой-либо счетчик Яндекс Метрики. Если у вас нет прав на счетчик, разверните [дашборд из {{ datalens-short-name }} {{ marketplace-short-name }}](https://datalens.yandex.ru/marketplace/f2e5hpq5mc7bscsjc6jr) и перейдите к шагу 2.

{% endnote %}

1. Перейдите на [главную страницу]({{ link-datalens-main }}) {{ datalens-short-name }}.
1. На панели слева выберите ![image](../../_assets/datalens/connections.svg) **Подключения** и нажмите кнопку **Создать подключение**.
1. Выберите **Metrica**.

   ![image](../../_assets/datalens/solution-03/03-choose-metrica.png)

1. Нажмите кнопку **Получить токен**.

   ![image](../../_assets/datalens/solution-03/04-metrica-creation1.png)

   Если вы первый раз создаете подключение к счетчику Яндекс Метрики, то предоставьте сервису необходимые разрешения.

1. Выберите необходимый счетчик из выпадающего списка.

   ![image](../../_assets/datalens/solution-03/05-metrica-creation2.png)

1. Выберите уровень [точности](https://yandex.ru/dev/metrika/doc/api2/api_v1/sampling-docpage/) из выпадающего списка.

   ![image](../../_assets/datalens/solution-03/06-01-metrica-creation-accuracy.png)

1. Включите опцию **Автоматически создать дашборд, чарты и датасет над подключением**.
1. Нажмите кнопку **Создать подключение**.

   ![image](../../_assets/datalens/solution-03/06-metrica-creation3.png)

   После создания подключения откроется папка с набором датасетов, чартов и дашбордом.

   {% include [datalens-metrica-note](../../_includes/datalens/datalens-metrica-note.md) %}

1. Перейдите на **Дашборд по данным Метрики**.

   ![image](../../_assets/datalens/solution-03/07-open-dashboard.png)

## Шаг 2. Измените стандартный дашборд {#step2}

{% note warning %}

Если у вас нет счетчика Яндекс Метрики и вы пропустили шаг 1, разверните [дашборд из {{ datalens-short-name }} {{ marketplace-short-name }}](https://datalens.yandex.ru/marketplace/f2e5hpq5mc7bscsjc6jr).

{% endnote %}

Вы можете изменять стандартный [дашборд](../../datalens/concepts/dashboard.md) так, как вам удобно. Например, вы можете удалить ненужный график.

1. В правом верхнем углу дашборда нажмите кнопку **Редактировать**.

   ![image](../../_assets/datalens/solution-03/09-edit-dashboard.png)

1. Удалите чарт **Глубина просмотров**. Для этого в правом верхнем углу графика нажмите значок ![image](../../_assets/datalens/horizontal-ellipsis-black.svg) и выберите **Удалить**.

   ![image](../../_assets/datalens/solution-03/10-delete-charts1.png)

1. Разместите чарты **Отказы** и **Время на сайте** таким образом, чтобы они заполнили пустое пространство после удаления чарта на предыдущем шаге. Перетащите чарт, нажав на сам чарт. Измените размер чарта, потянув за треугольник в нижнем правом углу чарта.

   ![image](../../_assets/datalens/solution-03/11-replace-charts.png)

1. Удалите чарты **Доля визитов по браузерам** и **Визиты, просмотры и посетители по браузерам**.

   ![image](../../_assets/datalens/solution-03/12-delete-charts2.png)

1. В правом верхнем углу нажмите кнопку **Сохранить**.

   ![image](../../_assets/datalens/solution-03/13-save-dashboard.png)

## Шаг 3. Измените чарт {#step3}

Вы можете отредактировать любой чарт на дашборде. Например, поменяйте тип визуализации для диаграммы **Визиты по типам устройств и ОС** из раздела **Технологии**.

1. В правом верхнем углу графика **Визиты по типам устройств и ОС** нажмите значок ![image](../../_assets/datalens/horizontal-ellipsis-black.svg).
1. Выберите **Редактировать**.

   ![image](../../_assets/datalens/solution-03/14-edit-chart.png)

1. Выберите другой тип чарта — **Круговая диаграмма**.

   ![image](../../_assets/datalens/solution-03/15-choose-pie.png)

1. В правом верхнем углу нажмите кнопку **Сохранить**.

   ![image](../../_assets/datalens/solution-03/16-save-chart.png)

1. Закройте вкладку с редактированием чарта и вернитесь в окно с дашбордом.
1. Обновите дашборд и убедитесь, что в разделе **Технологии** чарт изменился.

   ![image](../../_assets/datalens/solution-03/17-refresh-dashboard.png)
