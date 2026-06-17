# Визуализация данных Yandex Monitoring


Сценарий будет полезен пользователям, у которых уже развернут и запущен один из сервисов Yandex Cloud.

Вы создадите чарт на основе [языка запросов Yandex Monitoring](../../monitoring/concepts/querying.md) и разместите его на дашборде.


Для визуализации и исследования данных [подготовьте DataLens к работе](#before-you-begin), затем выполните следующие шаги:


1. [Создайте подключение](#create-connection).
1. [Создайте QL-чарт](#create-sql-chart).
1. [Создайте дашборд](#create-dashboard).
1. [Добавьте QL-чарт на дашборд](#add-sql-chart-to-dashboard).
1. [Добавьте селекторы на дашборд](#add-selectors-to-dashboard).


## Перед началом работы {#before-you-begin}

Чтобы начать работать с DataLens:

1. [Войдите](https://passport.yandex.ru/auth) в ваш аккаунт на Яндексе.
1. Откройте [главную страницу](https://datalens.ru/?skipPromo=true) DataLens.
1. Нажмите **Открыть DataLens**.
1. Выберите один из вариантов:

   * Если у вас уже есть организация, выберите ее в выпадающем меню на вкладке **Организации** и нажмите **Открыть DataLens**.
      
      {% note info %}

      Для активации экземпляра DataLens пользователю нужна роль `admin` или `owner`. Подробнее про роли смотрите в разделе [Управление доступом в Yandex Identity Hub](../../organization/security/index.md).

      {% endnote %}

   * Если у вас есть облако, но нет организации, нажмите **Добавить новый DataLens**. В открывшемся окне введите название и описание организации и нажмите **Создать организацию и DataLens**. Подробнее о работе с организациями смотрите в разделе [Начало работы с организациями](../../organization/quickstart.md).

   Если у вас возник технический вопрос по работе сервиса, обратитесь в [службу поддержки](https://center.yandex.cloud/support) Yandex Cloud. Чтобы спросить совета, обсудить решение вашей задачи или лучшие практики работы сервиса, напишите в чат [DataLens](https://t.me/YandexDataLens) в Telegram. 


## Создайте подключение {#create-connection}

{% note info %}

Для создания подключения требуется [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с [ролью](../../iam/operations/sa/assign-role-for-sa.md) `monitoring.viewer` (или `viewer`).
Для написания запросов в QL-чартах используйте [язык запросов Yandex Monitoring](../../monitoring/concepts/querying.md).

{% endnote %}

### Подключение к Monitoring {#monitoring-connection}

Чтобы создать подключение к Monitoring:

1. Перейдите на [страницу подключений](https://datalens.ru/connections).
1. Нажмите кнопку **Создать подключение**.
1. Выберите подключение **Monitoring**.
1. Укажите параметры подключения:

   * **Облако и каталог**. Выберите каталог, в котором находится ваш сервисный аккаунт.
   * **Сервисный аккаунт**. Выберите существующий сервисный аккаунт или создайте новый.

1. Нажмите **Создать подключение**.
1. Укажите имя подключения и нажмите **Создать**. Подключение появится в списке.

## Создайте QL-чарт {#create-sql-chart}

1. Перейдите к уже созданному подключению.
1. В правом верхнем углу нажмите **Создать QL-чарт**.
1. На вкладке **Запрос** введите текст запроса. Его можно написать самостоятельно, либо скопировать из Monitoring.

   {% cut "Как скопировать запрос из Monitoring" %}
   
   1. Перейдите на интересующий вас дашборд в сервисе Monitoring. Для доступности дашбордов у вас должен быть запущен один из сервисов Yandex Cloud.
   1. Откройте нужный график в Metric Explorer. Для этого нажмите значок ![image](../../_assets/console-icons/compass.svg) в правом верхнем углу графика.
   
      ![metrica-memory-usage](../../_assets/datalens/monitoring-visualization/metrica-memory-usage.png)

   1. В нижней части экрана перейдите на вкладку **Запросы**.
   1. В строке с нужным запросом нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **Скопировать как текст**. В DataLens запрос нужно вводить без параметра `folderId`.
      
      Пример запроса в Monitoring:
      
      ```sql
      "cpu_usage"{folderId="b1g9r5h41935********", service="compute", resource_id="charts-prod-vla-1"}
      ```
      В DataLens запрос введите без параметра `folderId`:

      ```sql
      "cpu_usage"{service="compute", resource_id="charts-prod-vla-1"}
      ```

   {% endcut %}

1. На вкладке **Параметры** укажите необходимый временной интервал.

   ![monitoring-datetime-parameters](../../_assets/datalens/monitoring-visualization/monitoring-datetime-parameters.png)

1. Нажмите кнопку **Запустить**. Проверьте, что запрос отрабатывает без ошибок и график с данными отображается.
1. В правом верхнем углу нажмите **Сохранить**.
1. Введите название чарта: `Monitoring Data Chart` и нажмите **Сохранить**.

Можете разместить созданный чарт на дашборде. Также на дашборд можно добавить селектор для управления значением параметра `interval` QL-чарта.

## Создайте дашборд {#create-dashboard}

Создайте [дашборд](../concepts/dashboard.md), на который будут добавлены чарты.

1. На панели слева нажмите ![image](../../_assets/console-icons/layout-cells-large.svg) **Дашборды**.
1. Нажмите кнопку **Создать дашборд**.

## Добавьте QL-чарт на дашборд {#add-sql-chart-to-dashboard}

1. В верхней части страницы нажмите кнопку **Добавить** и выберите **Чарт**.
   
   ![image](../../_assets/datalens/monitoring-visualization/add-chart.png)

1. В поле **Чарт** нажмите **Выбрать** и выберите из списка чартов созданный ранее чарт `Monitoring Data Chart`.
   
   ![image](../../_assets/datalens/monitoring-visualization/select-chart.png)

   Нажмите кнопку **Добавить**.

1. Чарт появился на дашборде. Растяните его для улучшения визуализации.
1. Сохраните дашборд:

   1. В правом верхнем углу нажмите кнопку **Сохранить**.
   1. Введите название дашборда `Monitoring Data` и нажмите кнопку **Создать**.

## Добавьте селекторы на дашборд {#add-selectors-to-dashboard}

Добавьте [селектор](../dashboard/selector.md), чтобы выбирать временной промежуток, за который отображаются данные:

1. В верхней части страницы нажмите кнопку **Добавить**.
1. Выберите **Селектор**.

   ![image](../../_assets/datalens/monitoring-visualization/add-selector.png)

1. Выберите тип источника **Ручной ввод**.
1. В **Имя поля или параметра** введите `interval`. В эту переменную запроса будут передаваться выбранные значения из селектора.
1. Выберите тип селектора **Календарь**.
1. Включите опцию **Диапазон**.

   ![image](../../_assets/datalens/monitoring-visualization/add-selector-parameters.png)

1. В поле **Значение по умолчанию** укажите значения в смещениях от текущей даты и нажмите кнопку **Применить**.

   ![image](../../_assets/datalens/monitoring-visualization/selector-default-values.png)

1. Включите опцию **Название** и введите `Date interval`.
1. Нажмите кнопку **Добавить**.
1. Расположите селектор на дашборде над чартом.
1. Сохраните дашборд.
1. Дашборд готов. Теперь можно выбирать временной диапазон с использованием селектора.
   
   ![image](../../_assets/datalens/monitoring-visualization/selector-2-values.png)

#### Полезные ссылки {#see-also}

* [Добавление чарта на дашборд в Yandex DataLens](../operations/dashboard/add-chart.md)
* [Добавление селектора на дашборд в Yandex DataLens](../operations/dashboard/add-selector.md)
* [Создание QL-чарта в Yandex DataLens](../operations/chart/create-sql-chart.md)
* [QL-чарты](../concepts/chart/index.md#sql-charts)