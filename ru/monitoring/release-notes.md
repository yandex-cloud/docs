---
title: История изменений в {{ monitoring-full-name }}
description: В разделе представлена история изменений сервиса {{ monitoring-name }}.
---

# История изменений в {{ monitoring-full-name }}


## Апрель — июнь 2025 {#apr-jun-2025}

* Добавлена возможность строить графики по метрикам из [{{ managed-prometheus-full-name }}](operations/prometheus/querying/monitoring.md) в разделе **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**. Это позволяет работать со всеми метриками {{ monitoring-name }} в едином интерфейсе и более гибко настраивать графики {{ prometheus-name }}. Также графики {{ prometheus-name }} можно добавлять на дашборды и комбинировать с графиками {{ monitoring-name }}.
 
   Для метрик {{ prometheus-name }} доступны все возможности, кроме [параметров](concepts/visualization/metric-explorer.md#repeated-graphs).

* Телефонные звонки и эскалации теперь доступны всем пользователям без обращения в техническую поддержку. Функциональность находится на стадии [Preview](../overview/concepts/launch-stages.md) и работает с [ограничениями](concepts/alerting/escalations.md).

* Оптимизирована обработка временных интервалов метрик. Теперь временной интервал учитывается при запросе метаданных, а не при чтении данных. Это исключает отображение пустых метрик, для которых не было записей на запрошенном интервале. Изменение актуально при временной остановке записи данных в метрику. Например, после релиза или отключения функции.

* Ускорена [разбивка графиков](operations/metric/metric-explorer.md#repeated-graphs) по меткам. Это сокращает время загрузки данных и помогает быстрее выявлять инциденты и аномальные показатели.

* Обновления раздела [Алерты](concepts/alerting.md):
  * В уведомлениях по алертам в Telegram добавлены [цветовые обозначения](concepts/alerting/alert.md#alert-statuses). Это позволяет быстрее определить статус алерта.
  * В уведомлениях по алертам в Telegram и Email теперь передается информация из [аннотаций](concepts/alerting/annotation.md).

* Обновления раздела [Дашборды](concepts/visualization/dashboard.md):
  * Копирование виджетов с помощью горячих клавиш `Ctrl+C` и `Ctrl+V` в пределах одного или разных дашбордов.
  * Добавление на дашборд [секций по параметру](operations/dashboard/add-widget.md#group), которые расширяют возможности [повторения графиков](operations/metric/metric-explorer.md#repeated-graphs). Для каждого значения параметра автоматически создается отдельная секция с одинаковым набором виджетов. Это удобно, например, для отображения аналогичных графиков по разным функциям приложения.
  * Добавление к графику [ссылок](operations/dashboard/add-widget.md#graph) на другой дашборд или внешние ресурсы.

## Январь — март 2025 {#jan-mar-2025}

* Добавлена возможность **разложить графики** по какому-либо параметру для [drill down](https://en.wikipedia.org/wiki/Data_drilling) анализа (детализация данных). Разложение графиков позволяет переходить от общего обзора к анализу метрик конкретных элементов системы, помогая быстрее выявлять причины аномалий или инцидентов.

   Подробнее о возможностях работы с метриками см. раздел [{#T}](operations/metric/metric-explorer.md).

* Добавлена возможность задать количество минимальных, максимальных или средних значений при разложении графиков. Например, при анализе использования процессора можно отобразить 10 всплесков высокой нагрузки на процессор за последние 24 часа.

* В каналы уведомлений для алертов добавлена возможность вызова функции [{{ sf-name }}](../functions/index.yaml). Это позволяет создать webhook для автоматической обработки инцидентов и других событий в вашем облаке.

   Подробнее см. разделы [{#T}](operations/alert/create-channel-function.md) и [{#T}](operations/alert/alert-call-function.md).

* При создании виртуальной машины можно [установить агент](operations/prometheus/ingestion/prometheus-agent.md) для сбора метрик в формате {{ prometheus-name }}. По умолчанию в {{ managed-prometheus-full-name }} передаются системные метрики Linux. Также при создании ВМ или позднее вы можете настроить передачу метрик ваших приложений.

* Обновления раздела [Дашборды](concepts/visualization/dashboard.md):
  
  * Добавлена возможность поделиться скриншотом графика: вы можете скопировать сам скриншот или ссылку на него.
  * Добавлены раскрывающиеся секции, на которых можно группировать любое количество виджетов. Это позволяет компактно расположить информацию на дашборде, скрывать неактуальные в данный момент графики, группировать их по назначению, сервису или типу метрик.

* Обновления раздела [Обзор метрик](concepts/visualization/metric-explorer.md):
  
  * Добавлена история запросов — сохраняются последние 100 запросов. Вы можете выбрать любой из вводимых ранее запросов, найти запрос текстовым поиском, а также добавить запрос в избранное. Избранные запросы всегда сохраняются в истории и отображаются вверху.
  * В настройках цветовой схемы графиков можно автоматически [назначать один цвет](operations/metric/metric-explorer.md#set-graph) линиям с одинаковым названием, но на разных графиках.
  * При создании скриншота графика теперь добавляется легенда.

* Обновление раздела [Алерты](concepts/alerting/alert.md): теперь можно задавать время для вычисления алерта в любых единицах. Например, задать промежуток в `1 неделю` можно как `1w` или `7d`.

* Общие обновления интерфейса: теперь в окне информации длинное название метки можно посмотреть целиком.

* Обновление документации: для {{ managed-prometheus-full-name }} добавили руководство [{#T}](operations/prometheus/ingestion/troubleshooting.md).

## Октябрь — декабрь 2024 {#oct-nov-2024}

* В каналы уведомлений **добавлены телефонные звонки** — при срабатывании алерта система позвонит пользователю (пока только для эскалаций).

* Добавлена функциональность [эскалации](concepts/alerting/escalations.md), которую можно вызвать при переходе алерта в статус **Alarm**. Эскалация запускает последовательность уведомлений с заданным интервалом. Можно настроить отправку уведомлений в различные каналы для одного или нескольких пользователей облака.

  Функциональность доступна на стадии [Preview](../overview/concepts/launch-stages.md).

* Реализована интеграция с сервисом [{{ sf-name }}](../functions/index.yaml). Таким образом в эскалациях можно вызвать функцию на любом из доступных [языков программирования](../functions/concepts/).

* В {{ managed-prometheus-full-name }} добавлена поддержка [правил алертинга](operations/prometheus/alerting-rules.md) — alerting rules. Уведомления по метрикам {{ prometheus-name }} можно отправлять на почту, в Telegram, СМС и другие каналы.
  
  Функциональность доступна на стадии [Preview](../overview/concepts/launch-stages.md).

* Обновлен интерфейс раздела **Обзор метрик** для более последовательного и детализированного анализа данных:

  * Строка запроса теперь находится наверху, что облегчает ввод запросов и просмотр результатов на графиках. Можно добавлять и корректировать несколько запросов — запросы и графики будут видны в пределах одного экрана.
  * Для графиков можно добавить название и описание.
  * В окно легенды для каждой метрики графика добавлена сортировка. Также добавлена возможность подсветить линию графика с конкретной метрикой и открыть график в отдельном окне.
  * При редактировании запроса в [режиме токенов](concepts/visualization/query-string.md) теперь удобнее пользоваться клавиатурой. Добавлены горячие клавиши для управления и перемещения по токенам.
  * Легенда графика вынесена на вкладку **Сводная таблица**. Рядом размещена таблица **Исходные данные** с метриками, поступившими от сервиса.
  
* Обновлен интерфейс раздела [**Дашборды**](concepts/visualization/dashboard.md), добавлены новые возможности:
  * Для добавления элементов на дашборд теперь не нужно переходить в режим редактирования — можно сразу начинать настройку.
  * Для каждого выбранного значения метки в [параметре дашборда](concepts/visualization/dashboard.md#parameterization) можно создавать повторяющиеся графики.
  * На дашборд можно добавить [виджет алерта](operations/dashboard/add-widget.md#alert) и следить за его состоянием.
  * Увеличена скорость загрузки и обновления графиков.
  * Увеличена скорость работы и загрузки виджетов.
  

## Апрель — сентябрь 2024 {#apr-sep-2024}

Обновлена политика [прореживания](concepts/decimation.md) исторических данных мониторинга. Теперь в данных сохраняется не только среднее значение, но максимальное, минимальное, сумма и последнее значение в каждом временном интервале, для которого выполняется агрегация.

Новая политика точнее отражает локальные всплески на графиках и позволяет видеть оригинальные данные. Что помогает более детально анализировать изменения. Графики исторических метрик теперь отображаются плавнее.

Выбрать отображение на графике одного из типов прореживания можно в настройках графика в разделах **Обзор метрик** и **Дашборды**.

Новая политика применяется ко всем данным, начиная с 7 августа 2024 года. Для данных, полученных ранее, доступно только среднее значение.

## Январь — март 2024 {#jan-mar-2024}

### Обновления {#updates}

* {{ managed-prometheus-full-name }} перешел на [стадию General Availability](../overview/concepts/launch-stages.md).
* Добавлена поддержка [отправки уведомлений об алертах](concepts/alerting/notification-channel.md) в Telegram.

### Исправления и улучшения {#fixes-improvements}

* Ускорили [экспорт метрик в формате {{ prometheus-name }}](operations/metric/prometheusExport.md).

{% include [trademark](../_includes/monitoring/trademark.md) %}
