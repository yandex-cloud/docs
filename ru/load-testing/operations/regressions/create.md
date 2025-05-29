---
title: Как создать и настроить дашборд регрессий
description: Следуя данной инструкции, вы сможете создать дашборд и настроить регрессий в {{ load-testing-name }}.
---

# Создать и настроить дашборд регрессий

В {{ load-testing-name }} можно создавать и настраивать дашборды [регрессий](../../concepts/load-test-regressions.md) с графиками метрик [нагрузочных тестов](../../concepts/index.md).
Если у вас еще нет завершенных тестов, [создайте](../create-test-bucket.md) и запустите его несколько раз подряд. Примеры сценариев для тестов см. в разделе [Практические руководства](../../tutorials/index.md). 

## Создать дашборд {#create-dashboard}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. На панели слева выберите ![image](../../../_assets/load-testing/regressions.svg) **{{ ui-key.yacloud.load-testing.label_regressions-title }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.load-testing.button_create-regression-dashboard }}**.
  1. В открывшемся окне введите имя и описание дашборда и нажмите **{{ ui-key.yc-ui-datasphere.common.apply }}**.

{% endlist %}

## Выбрать интервал времени {#choose-interval}

Для просмотра результатов нагрузочных тестов необходимо выбрать интервал.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. На панели слева выберите ![image](../../../_assets/load-testing/regressions.svg) **{{ ui-key.yacloud.load-testing.label_regressions-title }}**.
  1. В списке дашбордов выберите нужный.
  1. Задайте интервал одним из способов:

      * Переместите интервал в нужном направлении с помощью [шкалы времени](../../concepts/load-test-regressions.md).
      * Выберите интервал из выпадающего списка слева над шкалой. В списке также можно выбрать готовый интервал, например `Последние 5 минут`, `Последний час`, `Сегодня`, `Вчера` и т.д.
      * Нажмите одну из кнопок справа от даты и времени:
        * **2w** — две недели.
        * **1M** — один месяц.
        * **2M** — два месяца.
        * **3M** — три месяца.
        * **6M** — полгода.

      * Укажите интервал в выпадающем списке справа от кнопок. Появятся опции с вариантами масштаба интервала:
        * `s` — секунды.
        * `m` — минуты.
        * `h` — часы.
        * `d` — дни.
        * `w` — недели.
        * `M` — месяцы.
        
        Для чисел `1` и `2` также есть опция `y` — год.

      * Переместите интервал с помощью кнопок сдвига границ ![image](../../../_assets/load-testing/shift-left.svg) и ![image](../../../_assets/load-testing/shift-right.svg), справа от даты и времени. Величина сдвига определяется текущей величиной интервала.

  Чтобы сдвинуть интервал к текущему моменту, нажмите кнопку **Сейчас** справа от кнопок сдвига интервала.

  Для изменения масштаба используйте кнопки ![image](../../../_assets/load-testing/minus.svg) и ![image](../../../_assets/load-testing/plus.svg), расположенных справа на шкале времени.

{% endlist %}

## Добавить график регрессии {#add-graph}

На дашборде можно задать графики регрессий с метриками для [времени ответа](../../concepts/load-test-results.md#quantiles), количества [тестирующих потоков](../../concepts/load-test-results.md#test-streams) или RPS разладки. 

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. На панели слева выберите ![image](../../../_assets/load-testing/regressions.svg) **{{ ui-key.yacloud.load-testing.label_regressions-title }}**.
  1. В списке дашбордов выберите нужный.
  1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.edit }}** и выберите ![image](../../../_assets/load-testing/plus.svg) **{{ ui-key.yacloud.load-testing.button_create-chart }}**.
  1. В открывшемся окне:
    * В поле **{{ ui-key.yacloud.load-testing.field_chart-name }}** укажите название графика регрессии.
    * (Опционально) В поле **{{ ui-key.yc-ui-datasphere.common.description }}** укажите описание.
    * В поле **{{ ui-key.yacloud.load-testing.field_test-data-type }}** выберите одну из [метрик](../../concepts/load-test-regressions.md) `{{ ui-key.yacloud.load-testing.value_cumulative-quantiles-chart-type }}`, `{{ ui-key.yacloud.load-testing.value_instances-chart-type }}` или `{{ ui-key.yacloud.load-testing.value_imbalance_rps-chart-type }}`.
  1. Отметьте значения, которые нужно добавить в график.
  1. В блоке **{{ ui-key.yacloud.load-testing.label_test-rules-section }}**:
      * (Опционально) В поле **{{ ui-key.yacloud.load-testing.label_test-text }}** укажите имя для тестов, которые вы хотите включить в выборку. Если не указать имя, все ваши тесты попадут в выборку.
      * В поле **{{ ui-key.yacloud.load-testing.label_test-tags }}** нажмите кнопку **{{ ui-key.yacloud.load-testing.button_add-tag }}** и назначьте метки для тестов в формате `ключ:значение`. Метки должны быть заданы хотя бы для одного из ваших тестов.

        Вы также можете заранее назначить метки для тестов. Для этого перейдите на страницу ![image](../../../_assets/load-testing/test.svg)**{{ ui-key.yacloud.load-testing.label_tests-list }}**, выберите тесты из списка и нажмите кнопку **{{ ui-key.yacloud.load-testing.button_tags-link }}**.

      В блоке **{{ ui-key.yacloud.load-testing.label_tests-example-section }}** отобразятся отфильтрованные тесты.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  На панели появится виджет. Если нужно, настройте его высоту и ширину.

{% endlist %}

## Добавить дополнительную информацию {#add-info}

Чтобы улучшить читаемость графиков, дополните дашборд вспомогательными элементами. Это могут быть заголовки, текст, блоки кода, изображения, таблицы и др. 

### Добавить заголовок {#add-title}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. На панели слева выберите ![image](../../../_assets/load-testing/regressions.svg) **{{ ui-key.yacloud.load-testing.label_regressions-title }}**.
  1. В списке дашбордов выберите нужный.
  1. Нажмите кнопку ![image](../../../_assets/load-testing/header.svg) **Title**.
  1. Укажите заголовок и его размер.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
  1. Расположите заголовок в нужном месте дашборда. При необходимости измените высоту и ширину поля заголовка.

{% endlist %}

### Добавить элемент {#add-element}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. На панели слева выберите ![image](../../../_assets/load-testing/regressions.svg) **{{ ui-key.yacloud.load-testing.label_regressions-title }}**.
  1. В списке дашбордов выберите нужный.
  1. Нажмите кнопку ![image](../../../_assets/load-testing/text.svg) **Text**.
  1. Укажите текст или нажмите ![image](../../../_assets/options.svg) и выберите нужный элемент из списка. 
  1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
  1. Расположите информацию в нужном месте дашборда.

{% endlist %}

#### См. также {#see-also}

* [{#T}](update.md)
* [{#T}](delete.md)