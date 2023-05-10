# Веб-аналитика с расчетом воронок и когорт на данных Яндекс Метрики

В этом практическом руководстве вы научитесь строить воронки конверсий, проведете когортный анализ и посчитаете Retention пользовательской базы в {{ ml-platform-full-name }} и визуализируете данные в {{ datalens-full-name }}.

В качестве источника данных будут использованы данные из Яндекс Метрики.

1. [Подключите {{ CH }} и {{ ml-platform-short-name }}](#ch-datasphere-connection):
    1. [Подключите {{ CH }}](#ch-connection).
    1. [Подключите {{ ml-platform-short-name }}](#datasphere-connection).
    1. [Клонируйте репозиторий в {{ ml-platform-short-name }}](#clone-repo-to-datasphere).
1. [Получите и загрузите данные в {{ CH }}](#get-download-data-in-ch):
    1. [Яндекс Метрика. Создайте приложение и получите токен доступа](#create-metrica-app-token).
    1. [{{ ml-platform-short-name }}. Выгрузите данные через Logs API Яндекс Метрики](#uploading-data-logs-api).
    1. [{{ ml-platform-short-name }}. Выгрузите данные тестового счетчика через Яндекс Диск](#uploading-data-counter-from-disk).
    1. [{{ CH }}. Получите адрес кластера](#getting-ch-cluster-host).
    1. [{{ ml-platform-short-name }}. Загрузите данные в {{ CH }}](#uploading-data-counter-to-ch).
1. [Подключите {{ datalens-short-name }} и создайте чарты](#datalens-connection-chart-creation):
    1. [Подключитесь к {{ datalens-short-name }}](#datalens-connection).
    1. [Создайте подключение к {{ CH }} в {{ datalens-short-name }}](#creation-datalens-connection-to-ch).
    1. [Создайте датасет на базе подключения](#creating-dataset-based-on-connection).
    1. [Создайте чарт — накопительная диаграмма с областями](#creating-area-chart).
    1. [Создайте чарт — сводная таблица](#creating-pivot-table).
1. [Создайте и настройте дашборд в {{ datalens-short-name }}](#creating-configuring-dashboard):
    1. [Создайте дашборд](#creating-dashboard).
    1. [Настройте дашборд](#configuring-dashboard).
1. [Постройте воронки конверсий](#funnels):
    1. [{{ ml-platform-short-name }}. Постройте воронки](#calculating-funnels-datasphere).
    1. [{{ datalens-short-name }}. Воронки по браузерам. Создайте датасет](#calculating-browser-funnels-dataset).
    1. [{{ datalens-short-name }}. Воронки по браузерам. Создайте чарт](#calculating-browser-funnels-chart).
    1. [{{ datalens-short-name }}. Воронки по браузерам. Добавьте чарт на дашборд](#add-browser-funnels-chart-on-dashboard}).
    1. [{{ datalens-short-name }}. Воронки по браузерам. Настройте дашборд](#setting-browser-funnels-chart-on-dashboard).
1. [Проведите когортный анализ](#cohorts):
    1. [{{ ml-platform-short-name }}. Проведите когортный анализ](#cohort-analysis).
    1. [{{ datalens-short-name }}. Создайте датасет и чарт с визуализацией когорт](#creating-dataset-chart-with-cohort).
    1. [{{ datalens-short-name }}. Настройте чарт с визуализацией когорт](#creating-chart-with-cohort).
    1. [{{ datalens-short-name }}. Создайте чарт с ретеншеном](#creating-chart-with-retention).
    1. [{{ datalens-short-name }}. Добавьте чарты на новую вкладку дашборда](#adding-charts-to-dashboard-tab).
    1. [{{ datalens-short-name }}. Создайте чарты](#creating-chart).
    1. [{{ datalens-short-name }}. Добавьте чарты на дашборд](#adding-chart-to-dashboard).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin-datasphere.md) %}

{% note tip %}

Чтобы {{ datalens-full-name }} и {{ ml-platform-full-name }} могли работать внутри сети {{ yandex-cloud }}, создавайте их экземпляры в рамках одной организации.

{% endnote %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость развертывания инфраструктуры входят:
* плата за вычислительные ресурсы кластера и объем хранилища (см. [тарифы {{ mch-name }}](../../managed-clickhouse/pricing.md));
* плата за время вычислений (см. [тарифы {{ ml-platform-name }}](../../datasphere/pricing.md));
* плата за исходящий трафик (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).

## 1. Подключите {{ CH }} и {{ ml-platform-short-name }} {#ch-datasphere-connection}

### 1.1. Подключите {{ CH }} {#ch-connection}

1. В [консоли управления]({{ link-console-main }}) выберите каталог для создания кластера {{ CH }}.
1. Выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
1. В открывшемся окне нажмите **{{ ui-key.yacloud.clickhouse.button_create-cluster }}**.
1. Укажите настройки кластера {{ CH }}:
   1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}** укажите произвольное имя кластера. 
   1. В блоке **{{ ui-key.yacloud.mdb.forms.new_section_resource }}** выберите платформу `Intel Cascade Lake`, тип `burstable` и класс хоста `b2.medium`.
   
      {% note warning %}
   
      Не рекомендуется использовать конфигурации ВМ типа `burstable` в продакшн-среде. В этом руководстве они используются в качестве примера. Для продакшн-решений используйте конфигурации `standard` или `memory-optimized`.

      {% endnote %}

   1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}** оставьте значение `10 {{ ui-key.yacloud.mdb.forms.label_max-size-units }}`.
   1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** нажмите значок ![pencil](../../_assets/pencil.svg). Включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** и нажмите кнопку **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.
   1. В блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}** выключите управление пользователями через SQL, укажите имя пользователя, пароль и имя БД, например `metrica_data`.
 
   1. В блоке **{{ ui-key.yacloud.mdb.forms.section_service-settings }}** включите опции:
        * **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}**
        * **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}**
        * **{{ ui-key.yacloud.mdb.forms.additional-field-metrika }}**
        * **{{ ui-key.yacloud.mdb.forms.additional-field-serverless }}**
   1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

### 1.2. Подключите {{ ml-platform-short-name }} {#datasphere-connection}

1. Откройте [главную страницу]({{ link-datasphere-main }}) {{ ml-platform-name }}.
1. На панели слева выберите ![image](../../_assets/datasphere/communities.svg) **{{ ui-key.yc-ui-datasphere.common.spaces }}**.
1. Выберите сообщество, в котором вы хотите создать проект.
1. На странице сообщества нажмите кнопку ![image](../../_assets/datasphere/create-project.svg) **{{ ui-key.yc-ui-datasphere.projects.create-project }}**.
1. В открывшемся окне укажите имя и (опционально) описание проекта. Требования к имени:

   {% include [name-format](../../_includes/name-format.md) %}

1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.project-page.project-card.go-to-jupyter }}**.

Перед вами среда разработки {{ jlab }}Lab, в которой вы будете работать дальше.

### 1.3. Клонируйте репозиторий в {{ ml-platform-short-name }} {#clone-repo-to-datasphere}

1. В меню **Git** выберите **Clone**.
1. В открывшемся окне укажите **URI** репозитория `https://github.com/zhdanchik/yandex_metrika_cloud_case.git` и нажмите кнопку **CLONE**.
1. Нажмите кнопку **OK**.

## 2. Получите и загрузите данные в {{ CH }} {#get-download-data-in-ch}

Если у вас нет счетчика Метрики или в нем недостаточно данных, или вы гарантированно хотите пройти все шаги руководства и получить результат, перейдите к разделу [2.3](#uploading-data-counter-from-disk) (пропустите [2.1](#create-metrica-app-token) и [2.2](#uploading-data-logs-api)).

Если у вас есть счетчик Метрики и доступ к нему, перейдите к разделам [2.1](#create-metrica-app-token), [2.2](#uploading-data-logs-api) (пропустите [2.3](#uploading-data-counter-from-disk)). Эти шаги рекомендуем опытному пользователю, так как логика расчета воронок и когорт зависит от самих данных, и может потребоваться самостоятельная доработка скриптов. 

### 2.1. Яндекс Метрика. Создайте приложение и получите токен доступа {#create-metrica-app-token}

1. Для работы с API получите свой [OAuth-токен](https://tech.yandex.ru/oauth/doc/dg/tasks/get-oauth-token-docpage/). 
1. Создайте приложение:
     1. Перейдите на страницу [https://oauth.yandex.ru/client/new](https://oauth.yandex.ru/client/new).
     1. Укажите произвольное название сервиса. 
     1. Перейдите к блоку **Платформы приложения** → **Веб-сервисы**. В поле **Redirect URI** вставьте `https://oauth.yandex.ru/verification_code`.
     1. В блоке **Доступ к данным** введите `metrika` и выберите **Получение статистики, чтение параметров своих и доверенных счётчиков (metrika:read)**.
     1. Нажмите кнопку **Создать приложение**.
     1. В открывшемся окне появится описание нашего приложения. Сохраните ClientID вашего приложения.

1. Перейдите по ссылке `https://oauth.yandex.ru/authorize?response_type=token&client_id=<ID_приложения>`. В качестве `<ID_приложения>` вставьте ClientID вашего приложения.
1. Нажмите кнопку **Войти как**.
1. Сохраните полученный токен доступа.

### 2.2. {{ ml-platform-short-name }}. Выгрузите данные через Logs API Яндекс Метрики {#uploading-data-logs-api}

1. В проекте {{ ml-platform-short-name }} в корне рабочей директории создайте текстовый файл. Для этого нажмите **Text File** в рабочей области.
1. Назовите файл `.yatoken.txt`, в содержимое файла вставьте полученный токен доступа. Сохраните изменения и закройте файл.
1. Откройте папку **yandex_metrika_cloud_case** → ноутбук **1a. get_data_via_logs_api.ipynb**.
1. Укажите идентификатор счетчика Метрики в качестве значения переменной `COUNTER_ID`. Узнать идентификатор счетчика можно в Метрике на странице [Мои счетчики](https://metrika.yandex.ru/list?).
1. Укажите дату начала анализируемого периода в качестве значения переменной `START_DATE`.
1. Укажите дату окончания анализируемого периода в качестве значения переменной `END_DATE`.

   {% note warning %}

   Диапазон дат НЕ будет включать дату окончания. Например, если вы хотите получить данные по 5 декабря 2022 года, вставьте в переменную `END_DATE` значение `2022-12-06`.

   {% endnote %}

1. Выполните все шаги (ячейки с кодом) в ноутбуке **1a. get_data_via_logs_api.ipynb**.

Если не получилось выгрузить данные из Logs API, то данные для демонстрационного счетчика можно [скачать через Яндекс Диск](#uploading-data-counter-from-disk). 

### 2.3. {{ ml-platform-short-name }}. Выгрузите данные тестового счетчика через Яндекс Диск {#uploading-data-counter-from-disk}

{% note info %}

Пропустите этот раздел, если вы работаете с данными своего счетчика.

{% endnote %}

1. Откройте папку **yandex_metrika_cloud_case** → ноутбук **1b. get_data_via_yadisk.ipynb**.
1. Выполните все шаги (ячейки с кодом) в ноутбуке **1b. get_data_via_yadisk.ipynb**.

### 2.4. {{ CH }}. Получите адрес кластера {#getting-ch-cluster-host}

1. В [консоли управления]({{ link-console-main }}) перейдите в уже созданный кластер {{ CH }}. Дождитесь, когда у кластера появится статус `Alive`. После этого откройте кластер, кликнув на сам кластер.
1. Выберите из списка слева ![hosts](../../_assets/datalens/hosts.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
1. На вкладке **{{ ui-key.yacloud.mdb.cluster.hosts.switch_overview }}** скопируйте имя хоста. 

### 2.5. {{ ml-platform-short-name }}. Загрузите данные в {{ CH }} {#uploading-data-counter-to-ch}

1. Откройте папку **yandex_metrika_cloud_case** → ноутбук **2. upload_data_to_{{ CH }}.ipynb**:
    1. Вставьте скопированное имя хоста в переменную `CH_HOST_NAME`.
    1. В переменную `CH_USER` вставьте имя пользователя, которое вы задали при [создании кластера {{ CH }}](#ch-connection).
    1. В переменную `CH_DB_NAME` вставьте имя БД, которое вы задали при [создании кластера {{ CH }}](#ch-connection).
    
1. В корневой директории создайте новый текстовый файл с названием `.chpass.txt`.
1. Запишите в файл `.chpass.txt` пароль заведенного пользователя, который вы задали при [создании кластера {{ CH }}](#ch-connection). Сохраните и закройте файл.
1. Выполните все шаги (ячейки с кодом) в ноутбуке.

## 3. Подключите {{ datalens-short-name }} и создайте чарты {#datalens-connection-chart-creation}

### 3.1. Подключитесь к {{ datalens-short-name }} {#datalens-connection}

1. В [консоли управления]({{ link-console-main }}) откройте страницу созданного кластера {{ CH }}.
1. В списке слева выберите ![datalens](../../_assets/datalens/datalens.svg) **{{ ui-key.yacloud.clickhouse.cluster.switch_datalens }}**.
1. В открывшемся окне выберите каталог, в котором находится ваш {{ datalens-short-name }}, и нажмите кнопку **{{ ui-key.yacloud.mdb.datalens.button-action_activate }}**.

### 3.2. Создайте подключение к {{ CH }} в {{ datalens-short-name }} {#creation-datalens-connection-to-ch}

1. Нажмите кнопку **{{ ui-key.datalens.main.landing.view.button_connect-data-source }}**.
1. Выберите подключение **{{ ui-key.datalens.connections.connectors-list.view.label_connector-clickhouse }}**.
1. Заполните настройки подключения:
   1. Выберите кластер из выпадающего списка **{{ ui-key.datalens.connections.form.field_cluster }}** или создайте новый. Если нужный кластер в списке отсутствует, нажмите **{{ ui-key.datalens.connections.form.button_specify-manually }}** и укажите имя [кластера {{ CH }}](#ch-connection).
   1. Выберите [хост {{ CH }}](#ch-connection) из выпадающего списка **{{ ui-key.datalens.connections.form.field_host-name }}**. 
   1. Выберите [имя пользователя](#ch-connection).
   1. Введите [пароль](#ch-connection) и нажмите **{{ ui-key.datalens.connections.form.button_verify }}**.
   1. После успешной проверки подключения нажмите **{{ ui-key.datalens.connections.form.button_create-connection }}**, затем в открывшемся окне введите имя подключения и нажмите кнопку **{{ ui-key.datalens.connections.form.button_create }}**.

### 3.3. Создайте датасет на базе подключения {#creating-dataset-based-on-connection}

1. В правом верхнем углу нажмите **{{ ui-key.datalens.connections.form.button_create-dataset }}**.
1. Выберите таблицу `metrica_data.hits` в качестве источника. Для этого перетащите таблицу из списка слева в область редактирования.
1. Откройте вкладку **{{ ui-key.datalens.dataset.dataset-editor.modify.value_dataset }}**.
1. В правом верхнем углу нажмите кнопку ![plus](../../_assets/datalens/plus.svg) **{{ ui-key.datalens.dataset.dataset-editor.modify.button_add-field }}**.
1. Для подсчета числа хитов создайте вычисляемое поле: укажите название поля `Хиты`, в рабочей области укажите `1` и нажмите кнопку **{{ ui-key.datalens.component.dl-field-editor.view.button_create }}**. 
1. Для поля `Хиты` выберите значение **{{ ui-key.datalens.dataset.dataset-editor.modify.value_sum }}** в столбце **{{ ui-key.datalens.dataset.dataset-editor.modify.column_aggregation }}**.
1. Переименуйте поле `Browser` в `Браузер`.
1. В правом верхнем углу нажмите кнопку **{{ ui-key.datalens.dataset.dataset-editor.modify.button_save }}**.
1. Назовите датасет `ch_metrica_data_hits` и нажмите кнопку **{{ ui-key.datalens.dataset.dataset-editor.modify.button_create }}**.

### 3.4. Создайте чарт — накопительная диаграмма с областями {#creating-area-chart}

1. В правом верхнем углу нажмите кнопку **{{ ui-key.datalens.dataset.dataset-editor.modify.button_create-widget }}**.
1. В открывшемся окне перетащите поля в области чарта:
    * `EventDate` — в область **{{ ui-key.datalens.wizard.section_x }}**.
    * `Браузер` — в область **{{ ui-key.datalens.wizard.section_colors }}**.
    * `Хиты` — в область **{{ ui-key.datalens.wizard.section_y }}**.
1. Измените тип чарта cо **{{ ui-key.datalens.wizard.label_visualization-column }}** на **{{ ui-key.datalens.wizard.label_visualization-area }}**. 
1. Нажмите кнопку **{{ ui-key.datalens.wizard.button_save }}**. 
1. В появившемся окне укажите имя чарта `ch_metrica_data_hits_area` и нажмите кнопку **{{ ui-key.datalens.component.chartkit-alerts.view.button_save }}**.

### 3.5. Создайте чарт — сводная таблица {#creating-pivot-table}

1. В правом верхнем углу нажмите значок ![save-button](../../_assets/datalens/save-button.svg) → **{{ ui-key.datalens.component.chart-save-controls.button_save-as-new }}**.
1. Укажите новое имя для копии чарта `ch_metrica_data_hits_table` и нажмите кнопку **{{ ui-key.datalens.component.chartkit-alerts.view.button_save }}**.
1. Выберите новый тип чарта **{{ ui-key.datalens.wizard.label_visualization-pivot-table }}**.
1. Добавьте или перетащите поля в области чарта:
    * `Браузер` — в область **{{ ui-key.datalens.wizard.section_rows }}**.
    * `Хиты` — в область **{{ ui-key.datalens.wizard.section_sort }}**.
1. Нажмите кнопку **{{ ui-key.datalens.wizard.button_save }}**.

## 4. Создайте и настройте дашборд в {{ datalens-short-name }} {#creating-configuring-dashboard}

### 4.1. Создайте дашборд {#creating-dashboard}

1. Выберите значок ![dashboards](../../_assets/datalens/dashboard-0523.svg) **{{ ui-key.datalens.component.navigation.view.switch_dashboards }}** на панели слева и нажмите кнопку **{{ ui-key.datalens.component.navigation.view.button_create-dashboard }}**.
1. Укажите название дашборда `ch_metrica_data` и нажмите кнопку **{{ ui-key.datalens.component.navigation.view.button_create }}**.
1. Добавьте первый чарт на дашборд. Для этого в правом верхнем углу нажмите **{{ ui-key.datalens.dash.action-panel.view.button_add }}** ![save-button](../../_assets/datalens/save-button.svg) → **{{ ui-key.datalens.dash.action-panel.view.value_widget }}**:
    1. Из выпадающего списка **{{ ui-key.datalens.dash.widget-dialog.edit.field_widget }}** выберите чарт `ch_metrica_data_hits_area`.
    1. В поле **{{ ui-key.datalens.dash.widget-dialog.edit.field_title }}** укажите имя чарта **Хиты в разбивке на браузеры** и нажмите кнопку **{{ ui-key.datalens.dash.widget-dialog.edit.button_add }}**.
1. По аналогии добавьте чарт `ch_metrica_data_hits_table` с именем **Хиты в разбивке на браузеры за период**.
1. Переместите чарты и измените их размеры на дашборде:
    1. Перетащите чарт с таблицей справа от чарта с диаграммой.
    1. Измените вертикальные размеры чартов, потянув каждый из них за правый нижний угол.
1. В правом верхнем углу нажмите кнопку **{{ ui-key.datalens.dash.widget-dialog.edit.button_save }}**.

### 4.2. Настройте дашборд {#configuring-dashboard}

1. Добавьте фильтрацию, чтобы выбирать определенный браузер. Для этого в правом верхнем углу нажмите **{{ ui-key.datalens.dash.action-panel.view.button_add }}** ![save-button](../../_assets/datalens/save-button.svg) → **{{ ui-key.datalens.dash.action-panel.view.value_widget }}**.
1. Селектор можно привязать к полю из какого-либо датасета. Выберите из списка **{{ ui-key.datalens.dash.control-dialog.edit.field_dataset }}** созданный датасет `ch_metrica_data_hits`.
1. В списке **{{ ui-key.datalens.dash.control-dialog.edit.field_field }}** выберите `Браузер`. 
1. Включите опцию **{{ ui-key.datalens.dash.control-dialog.edit.field_multiselectable }}**.
1. В поле **{{ ui-key.datalens.dash.control-dialog.edit.label_default-value }}** выберите браузеры:
    * `android_browser`
    * `chrome`
    * `chromemobile`
    * `firefox`
    * `opera`
    * `safari`
    * `safari_mobile`
    * `samsung_internet`
    * `yandex_browser`
    * `yandexsearch`
1. В поле **{{ ui-key.datalens.dash.control-dialog.edit.field_title }}** укажите имя селектора и включите опцию.
1. Нажмите кнопку **{{ ui-key.datalens.dash.control-dialog.edit.button_add }}**. 
1. Перетащите селектор на верх дашборда и растяните по горизонтали.
1. В правом верхнем углу нажмите кнопку **{{ ui-key.datalens.dash.control-dialog.edit.button_save }}**. 

## 5. Постройте воронки конверсий {#funnels}
 
### 5.1. {{ ml-platform-short-name }}. Постройте воронки {#calculating-funnels-datasphere}

1. Откройте [главную страницу]({{ link-datasphere-main }}) {{ ml-platform-name }}.
1. Откройте ноутбук **3. funnels.ipynb**. Укажите хост, пользователя и название БД.
1. Выполните ячейки, оцените результаты анализа. 
В {{ CH }} будет создана таблица `metrica_data.funnels_by_bro`, в которой будут посчитаны воронки по браузерам. 

### 5.2. {{ datalens-short-name }}. Воронки по браузерам. Создайте датасет {#calculating-browser-funnels-dataset}

Создайте новый датасет на основе новой таблицы и подключения к {{ CH }}:

1. Откройте главную страницу [{{ datalens-short-name }}]({{ link-datalens-main }}/) (или нажмите ![datalens-console](../../_assets/datalens-console.svg) **{{ ui-key.yacloud.clickhouse.cluster.switch_datalens }}** на панели слева) и нажмите **{{ ui-key.datalens.main.landing.view.button_create-dataset }}**.
1. Перейдите в область **{{ ui-key.datalens.dataset.sources-tab.modify.label_sources }}** и нажмите кнопку ![image](../../_assets/plus-sign.svg) **{{ ui-key.datalens.dataset.sources-tab.modify.button_add-connection }}**.
1. Из списка подключений выберите имя подключения, созданного на шаге [3.2](#creation-datalens-connection-to-ch).
1. Перетащите новую таблицу `metrica_data.funnels_by_bro` в область редактирования.
1. Откройте вкладку **{{ ui-key.datalens.dataset.dataset-editor.modify.value_dataset }}**:
   1. Переименуйте поля `step X` в `Шаг X`, где X — порядковый номер шага.
   1. Выберите значение **{{ ui-key.datalens.dataset.dataset-editor.modify.value_sum }}** в столбце **{{ ui-key.datalens.dataset.dataset-editor.modify.column_aggregation }}** для полей `Шаг X` и нажмите кнопку **{{ ui-key.datalens.dataset.dataset-editor.modify.button_save }}**.
1. Назовите датасет `ch_metrica_data_funnels_by_bro` и нажмите кнопку **{{ ui-key.datalens.dataset.dataset-editor.modify.button_create }}**.

### 5.3. {{ datalens-short-name }}. Воронки по браузерам. Создайте чарт {#calculating-browser-funnels-chart}

Создайте на основе датасета `ch_metrica_data_funnels_by_bro` чарт:

1. Нажмите кнопку **{{ ui-key.datalens.dataset.dataset-editor.modify.button_create-widget }}**.
1. Выберите тип чарта **{{ ui-key.datalens.wizard.label_visualization-pivot-table }}**.
1. Перетащите поля в области чарта:
    * `Браузер` — в область **{{ ui-key.datalens.wizard.section_rows }}**.
    * `Шаг X` — в область **{{ ui-key.datalens.wizard.section_measures }}**, где X — порядковый номер шага.
    * `Шаг 1` — в область **{{ ui-key.datalens.wizard.section_sort }}**.
1. Нажмите кнопку **{{ ui-key.datalens.dataset.dataset-editor.modify.button_save }}**.
1. Укажите название чарта `ch_metrica_data_funnels_by_bro_table` и нажмите кнопку **{{ ui-key.datalens.dataset.dataset-editor.modify.button_save }}**.

### 5.4. {{ datalens-short-name }}. Воронки по браузерам. Добавьте чарт на дашборд {#add-browser-funnels-chart-on-dashboard}

1. Перейдите на созданный дашборд (со страницы [дашбордов]({{ link-datalens-main }}/dashboards)).
1. Добавьте новый чарт. В правом верхнем углу нажмите кнопку **{{ ui-key.datalens.dash.action-panel.view.button_edit }}**:
    1. Нажмите **{{ ui-key.datalens.dash.action-panel.view.button_add }}** ![save-button](../../_assets/datalens/save-button.svg) → **{{ ui-key.datalens.dash.action-panel.view.value_widget }}**.
    1. Из выпадающего списка **{{ ui-key.datalens.dash.widget-dialog.edit.field_widget }}** выберите чарт `ch_metrica_data_funnels_by_bro_table`.
    1. В поле **{{ ui-key.datalens.dash.widget-dialog.edit.field_title }}** укажите имя чарта `Воронки по браузерам` и нажмите кнопку **{{ ui-key.datalens.dash.widget-dialog.edit.button_add }}**.
1. Расположите новый чарт справа от уже имеющихся двух. Растяните чарт так, чтобы он совпадал с остальными по вертикали и доходил справа до края страницы. 
1. Нажмите кнопку **{{ ui-key.datalens.dash.widget-dialog.edit.button_save }}**.

### 5.5. {{ datalens-short-name }}. Воронки по браузерам. Настройте дашборд {#setting-browser-funnels-chart-on-dashboard}

Чтобы селектор влиял на новый чарт из другого датасета, настройте связи: 

1. Нажмите **{{ ui-key.datalens.dash.action-panel.view.button_edit }}** → **{{ ui-key.datalens.dash.action-panel.view.button_connections }}**.
1. В открывшемся окне выберите из списка селектор `Браузер`.
1. На странице с другими элементами дашборда прокрутите вниз до чарта `Воронки по браузерам` и нажмите на список со связью.
1. Выберите тип связи **{{ ui-key.datalens.dash.connections-dialog.edit.value_output }}**.
1. Из каждого списка выберите поля для связи `Браузер`. Нажмите кнопку **{{ ui-key.datalens.dash.connections-dialog.edit.button_add }}**.
1. Нажмите кнопку **{{ ui-key.datalens.dash.connections-dialog.edit.button_save }}**.
1. В левом верхнем углу нажмите значок ![image](../../_assets/datalens/horizontal-ellipsis.svg) → **{{ ui-key.datalens.dash.action-panel.view.value_rename }}**.
1. Укажите название `Supermarket.ru — анализ воронок и когорт`. Нажмите кнопку **{{ ui-key.datalens.component.dialog-rename-entry.view.button_apply }}**.

## 6. Проведите когортный анализ {#cohorts}

### 6.1. {{ ml-platform-short-name }}. Проведите когортный анализ {#cohort-analysis}

1. Откройте ноутбук **4. cohorts.ipynb**. Укажите хост, пользователя и название БД.
1. Выполните ячейки, оцените результаты анализа. 
 
В {{ CH }} создастся таблица `metrica_data.retention_users` с данными, необходимыми для построения визуализации в {{ datalens-short-name }}. 

### 6.2. {{ datalens-short-name }}. Создайте датасет и чарт с визуализацией когорт {#creating-dataset-chart-with-cohort}

Создайте датасет на основе новой таблицы и подключения к {{ CH }}: 

1. Откройте главную страницу [{{ datalens-short-name }}]({{ link-datalens-main }}/) и нажмите **{{ ui-key.datalens.component.navigation.view.button_create-dataset }}**.
1. В области **{{ ui-key.datalens.dataset.sources-tab.modify.label_sources }}** нажмите кнопку **{{ ui-key.datalens.component.navigation.view.button_create-dataset }}** и нажмите кнопку ![image](../../_assets/plus-sign.svg) **{{ ui-key.datalens.dataset.sources-tab.modify.button_add-connection }}**.
1. Выберите из списка созданное [подключение](#creation-datalens-connection-to-ch).
1. Перетащите новую таблицу `metrica_data.retention_users` в рабочую зону, чтобы подключиться к ней.
1. Откройте вкладку **{{ ui-key.datalens.dataset.dataset-editor.modify.value_dataset }}** и создайте новое вычисляемое поле `week_num`, которое равно `([date]-[min_date])/7`.
   Поле будет означать число недель с момента первого посещения пользователя.
1. Нажмите кнопку **{{ ui-key.datalens.dataset.dataset-editor.modify.button_create }}**.
1. Для полей `visits`, `purchases` и `revenue` выберите значение **{{ ui-key.datalens.dataset.dataset-editor.modify.value_sum }}** в столбце **{{ ui-key.datalens.dataset.dataset-editor.modify.column_aggregation }}**.
1. Переименуйте поля в `Визиты`, `Покупки` и `Доход` соответственно. 
1. Сохраните датасет:
    1. Назовите датасет `ch_metrica_data_users_visits`.
    1. Нажмите кнопку **{{ ui-key.datalens.dataset.dataset-editor.modify.button_create }}**.
1. На основе датасета создайте новый чарт: 
    1. Измените тип чарта на **{{ ui-key.datalens.wizard.label_visualization-pivot-table }}**.
    1. Перетащите поле `week_num` в область **{{ ui-key.datalens.wizard.section_columns }}**.
    1. Перетащите поле `min_date` в область **{{ ui-key.datalens.wizard.section_rows }}**.
    1. Перетащите поле `Визиты` в область **{{ ui-key.datalens.wizard.section_measures }}**.

### 6.3. {{ datalens-short-name }}. Настройте чарт с визуализацией когорт {#creating-chart-with-cohort}

Отфильтруйте неполные недели 29.06.2020 и 28.09.2020:

1. Перетащите поле `min_date` в область **{{ ui-key.datalens.wizard.section_filters }}**.
   1. В открывшемся окне выберите начало и конец диапазона дат для фильтрации:
      * Дата начала — `29.06.2020`.
      * Дата завершения — `27.09.2020`.
   1. Нажмите кнопку **{{ ui-key.datalens.wizard.button_apply-filter }}**.
1. Отформатируйте числа в значениях поля `week_num` — уберите знаки после запятой. Для этого в области **{{ ui-key.datalens.wizard.section_rows }}** в поле `week_num` нажмите значок ![image](../../_assets/datalens/mesh.svg). В открывшемся окне выполните настройку:
    1. Установите для показателя **{{ ui-key.datalens.wizard.number-field-formatting.view.field_precision }}** значение `0`. 
    1. Установите для показателя **{{ ui-key.datalens.wizard.number-field-formatting.view.field_rank-delimiter }}** значение `{{ ui-key.datalens.wizard.number-field-formatting.view.value_rank-delimiter-hide }}`.
    1. Нажмите кнопку **{{ ui-key.datalens.wizard.button_apply }}**.
1. Чтобы сделать таблицу цветной, добавьте поле `Визиты` в область **{{ ui-key.datalens.wizard.section_colors }}** и нажмите нажмите ![gear](../../_assets/datalens/gear.svg). В открывшемся окне выполните настройку цвета:
    1. Выберите **{{ ui-key.datalens.wizard.label_gradient-type }}** — `Трехцветный`.
    1. Выберите **{{ ui-key.datalens.wizard.label_bars-color }}** — `Оранжевый-Фиолетовый-Голубой`.
    1. Включите настройку **{{ ui-key.datalens.wizard.label_thresholds }}** и укажите значения `100`, `1000` и `5000`.
    1. Нажмите кнопку **{{ ui-key.datalens.wizard.button_apply }}**.
1. Нажмите кнопку **{{ ui-key.datalens.wizard.button_save }}**.
1. Назовите чарт `ch_metrica_data_users_visits_cohorts_abs` и нажмите **{{ ui-key.datalens.component.dialog-create-editor-chart.view.button_apply }}**.

### 6.4. {{ datalens-short-name }}. Создайте чарт с ретеншеном {#creating-chart-with-retention}

Создайте чарт с ретеншеном на основе чарта `ch_metrica_data_users_visits_cohorts_abs`. Чарт можно открыть с дашборда или найти в [списке чартов]({{ link-datalens-main }}/widgets).

1. В правом верхнем углу нажмите значок ![save-button](../../_assets/datalens/save-button.svg) → **{{ ui-key.datalens.component.chart-save-controls.button_save-as-new }}**.
1. Укажите имя чарта `ch_metrica_data_users_visits_cohorts_rel` и нажмите кнопку **{{ ui-key.datalens.component.chartkit-alerts.view.button_save }}**.
1. Создайте новое вычисляемое поле для расчета ретеншена относительно первой недели:
    1. В левой части экрана нажмите значок ![image](../../_assets/plus-sign.svg), который находится над списком полей датасета, и выберите **{{ ui-key.datalens.wizard.add_field_item }}**.
    1. Назовите поле `Визиты от первой недели`.
    1. Вставьте формулу `SUM([Визиты])/RMAX(SUM([Визиты]) among [week_num])`.
    1. Нажмите кнопку **{{ ui-key.datalens.dataset.dataset-editor.modify.button_create }}**.
1. Перетащите поле `Визиты от первой недели` в секцию **{{ ui-key.datalens.wizard.section_measures }}**.
1. Перетащите поле `Визиты от первой недели` в секцию **{{ ui-key.datalens.wizard.section_colors }}** вместо поля `Визиты`.
1. Настройте формат поля `Визиты от первой недели`. Для этого в секции **{{ ui-key.datalens.wizard.section_measures }}** в поле `Визиты от первой недели` нажмите значок ![image](../../_assets/datalens/mesh.svg). В открывшемся окне выполните настройку:
    1. Установите показатель **{{ ui-key.datalens.wizard.number-field-formatting.view.field_format }}** в значение `{{ ui-key.datalens.wizard.number-field-formatting.view.value_format-percent }}`.
    1. Нажмите кнопку **{{ ui-key.datalens.wizard.button_apply }}**.
1. Отредактируйте пороговые значения для цветов показателя. В секции **{{ ui-key.datalens.wizard.section_colors }}** нажмите значок ![gear](../../_assets/datalens/gear.svg). В открывшемся окне включите опцию **{{ ui-key.datalens.wizard.label_thresholds }}** и укажите пороговые значения `0,01`, `0,025` и `0,1` и нажмите кнопку **{{ ui-key.datalens.wizard.button_apply }}**.
1. Нажмите кнопку **{{ ui-key.datalens.wizard.button_save }}**.

### 6.5. {{ datalens-short-name }}. Добавьте чарты на новую вкладку дашборда {#adding-charts-to-dashboard-tab}

1. Нажмите кнопку ![dashboards](../../_assets/datalens/dashboard-0523.svg) **{{ ui-key.datalens.component.navigation.view.switch_dashboards }}** на панели слева и откройте дашборд.
1. Нажмите кнопку **{{ ui-key.datalens.dash.action-panel.view.button_edit }}** → **{{ ui-key.datalens.dash.action-panel.view.button_tabs }}**.
1. Переименуйте существующую вкладку как `Обзор + Воронки`.
1. Добавьте новую вкладку и назовите ее `Когорты`. Нажмите **{{ ui-key.datalens.dash.control-dialog.edit.button_save }}**.
1. Перейдите на новую вкладку `Когорты`:
    1. Добавьте на дашборд чарт `ch_metrica_data_users_visits_cohorts_abs`.
    1. В поле **{{ ui-key.datalens.dash.widget-dialog.edit.field_title }}** укажите `Визиты по когортам (абсолюты)`.
1. Чтобы добавить новую вкладку, нажмите слева кнопку **{{ ui-key.datalens.dash.widget-dialog.edit.button_add }}**:
    1. В новой вкладке добавьте чарт `ch_metrica_data_users_visits_cohorts_rel`.
    1. Укажите название `Визиты по когортам (относительные)`.
    1. Нажмите кнопку **{{ ui-key.datalens.dash.widget-dialog.edit.button_add }}**.
    1. Нажмите кнопку **{{ ui-key.datalens.dash.widget-dialog.edit.button_save }}**.

Вы получите чарт с двумя вкладками, между которыми можно переключаться.

### 6.6. {{ datalens-short-name }}. Создайте чарты {#creating-chart}

Создайте новый чарт на основе чарта `ch_metrica_data_users_visits_cohorts_abs`. Чарт можно открыть с дашборда или найти в [списке чартов]({{ link-datalens-main }}/widgets).

1. В правом верхнем углу нажмите значок ![image](../../_assets/datalens/save-button.svg) → **{{ ui-key.datalens.component.chart-save-controls.button_save-as-new }}**.
1. Укажите имя чарта `ch_metrica_data_users_revenue_cohorts_abs` и нажмите кнопку **{{ ui-key.datalens.component.chartkit-alerts.view.button_save }}**.
1. Перетащите поле `Доход` в области **{{ ui-key.datalens.wizard.section_measures }}** и **{{ ui-key.datalens.wizard.section_colors }}** поверх поля `Визиты`.
1. В области поля `Доход` нажмите значок ![image](../../_assets/datalens/mesh.svg). Измените форматирование поля: 
    1. Выберите `1` знак после запятой.
    1. Выберите размерность `{{ ui-key.datalens.wizard.number-field-formatting.view.value_unit-m }}`.
    1. Замените пороги градации цветов для нового поля на `500000`, `1500000` и `10000000`.
1. Сохраните чарт.

Создайте еще один чарт на основе чарта `ch_metrica_data_users_visits_cohorts_rel`:

1. В правом верхнем углу нажмите значок ![image](../../_assets/datalens/save-button.svg) → **{{ ui-key.datalens.component.chart-save-controls.button_save-as-new }}**.
1. Укажите имя чарта `ch_metrica_data_users_revenue_cohorts_rel` и нажмите кнопку **{{ ui-key.datalens.component.chartkit-alerts.view.button_save }}**.
1. Измените поле `Визиты от первой недели`:
    1. Переименуйте поле как `Доход от первой недели`.
    1. Измените формулу на `SUM([Доход])/RMAX(SUM([Доход]) among [week_num])`.
    1. Измените пороги градации цветов для нового поля на `0.01`, `0.2` и `0.3`.
1. Сохраните чарт.

### 6.7. {{ datalens-short-name }}. Добавьте чарты на дашборд {#adding-chart-to-dashboard}

Добавьте на дашборд чарты с визуализацией когорт:

1. Нажмите кнопку **{{ ui-key.datalens.dash.action-panel.view.button_edit }}**.
1. Нажмите кнопку **{{ ui-key.datalens.dash.action-panel.view.button_add }}** ![save-button](../../_assets/datalens/save-button.svg) → **{{ ui-key.datalens.dash.action-panel.view.value_widget }}**.
1. Из списка чартов выберите чарт `ch_metrica_data_users_revenue_cohorts_abs`.
1. Укажите имя `Доход по когортам (абсолюты)`.
1. С помощью кнопки ![plus](../../_assets/datalens/plus.svg) **{{ ui-key.datalens.dash.tabs-dialog.edit.button_add-tab }}** создайте новую вкладку:
    1. В новой вкладке в списке чартов выберите чарт `ch_metrica_data_users_revenue_cohorts_rel`.
    1. Укажите имя `Доход по когортам (относительный)`.
    1. В правом верхнем углу нажмите значок **{{ ui-key.datalens.dash.tabs-dialog.edit.button_save }}**.
1. Расположите чарты на одном уровне.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, [удалите кластер](../../managed-clickhouse/operations/cluster-delete.md).