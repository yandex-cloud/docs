---
title: Работа с отчетами
description: Следуя данной инструкции, вы научитесь работать с отчетами в {{ speechsense-name }}.
---

# Работа с отчетами

Вы можете использовать [отчеты в {{ speechsense-name }}](../../concepts/reports/index.md), чтобы проанализировать диалоги операторов и клиентов и оценить качество работы операторов. Постройте отчет:

* [{{ ui-key.yc-ui-talkanalytics.reports.rating-key-value }}](#build-an-evaluation-form) — чтобы проанализировать несколько параметров оценки.
* [{{ ui-key.yc-ui-talkanalytics.reports.comparison-key-value }}](#build-a-comparison-report) — чтобы сравнить несколько параметров оценки во времени.
* [{{ ui-key.yc-ui-talkanalytics.reports.details-key-value }}](#build-a-details-report) — чтобы проанализировать изменение одного параметра оценки во времени.

Если вы хотите использовать в качестве фильтра или параметра оценки характеристику диалога, например причину, тему или итог разговора, [примените смысловой атрибут в отчете](#apply-sense-attribute).

## Построить отчет «{{ ui-key.yc-ui-talkanalytics.reports.rating-key-value }}» {#build-an-evaluation-form}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите нужный проект.
1. Перейдите во вкладку **{{ ui-key.yc-ui-talkanalytics.reports.reports }}**.
1. Если в проекте еще нет ни одного сохраненного отчета, выберите **{{ ui-key.yc-ui-talkanalytics.reports.rating-key-value }}**. Если в проекте уже есть отчеты, нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.reports.create-report }}** → **{{ ui-key.yc-ui-talkanalytics.reports.rating-key-value }}**.
1. {% include [manage-reports-period](../../../_includes/speechsense/reports/manage-reports-period.md) %}
1. {% include [manage-reports-filters](../../../_includes/speechsense/reports/manage-reports-filters.md) %}
1. {% include [manage-reports-grouping](../../../_includes/speechsense/reports/manage-reports-grouping.md) %}
1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.reports.add-parameter }}**.
1. Задайте настройки параметра оценки:

   1. В поле **{{ ui-key.yc-ui-talkanalytics.reports.parameter.filter }}** выберите нужный параметр и укажите его значение либо диапазон значений.

      Параметры оценки служат критериями, по которым можно оценить качество работы операторов. Подробнее о параметрах и формировании отчета по ним см. в разделе [{#T}](../../concepts/reports/evaluation-form.md#parameters).

      Если вы хотите использовать в качестве параметра оценки характеристику диалога, например причину, тему или итог разговора, [используйте смысловой атрибут](#apply-sense-attribute).

   1. В поле **{{ ui-key.yc-ui-talkanalytics.reports.parameter.weight }}** укажите значение в процентах.

      Вес показывает, насколько параметр важен для оценки работы. Чем больше вес параметра, тем больше значение этого параметра в отчете. В сумме вес всех параметров оценки должен быть равен 100%. Подробнее о весе и его использовании см. в разделе [{#T}](../../concepts/reports/evaluation-form.md#weight).

   1. (Опционально) В поле **{{ ui-key.yc-ui-talkanalytics.reports.parameter.description }}** укажите название, которое будет использовано для подписи параметра на графике и в таблице. По умолчанию это название совпадает со значением поля **{{ ui-key.yc-ui-talkanalytics.reports.parameter.filter }}**.

1. При необходимости добавьте другие параметры оценки с помощью кнопки ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.reports.add-parameter }}**.
1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.reports.generate-report }}**.
1. Чтобы использовать отчет повторно, нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.reports.save-report-key-value }}**. Укажите его название и (опционально) описание.

   Отчет будет доступен в выбранном проекте на вкладке **{{ ui-key.yc-ui-talkanalytics.reports.reports }}**.

## Перейти из отчета «{{ ui-key.yc-ui-talkanalytics.reports.rating-key-value }}» к диалогам {#go-to-a-dialog}

Отчет позволяет напрямую перейти к списку диалогов, для которых выполняются заданные в отчете настройки. Так вы сможете получить больше информации о диалогах и проанализировать найденные в них особенности.

Чтобы перейти из отчета к списку диалогов:

1. [Постройте отчет](#build-an-evaluation-form) **{{ ui-key.yc-ui-talkanalytics.reports.rating-key-value }}**.
1. В графике в отчете нажмите на прямоугольник нужного параметра оценки. Откроется список диалогов, которые соответствуют заданным фильтрам и выбранному параметру.
1. Перейдите к нужному диалогу. На его странице отображается подробная информация о нем. Например, результаты работы оператора в резюме диалога, теги оператора и клиента, текст аудиозаписи, распознанный средствами {{ speechsense-name }}.

## Построить отчет «{{ ui-key.yc-ui-talkanalytics.reports.comparison-key-value }}» {#build-a-comparison-report}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите нужный проект.
1. Перейдите во вкладку **{{ ui-key.yc-ui-talkanalytics.reports.reports }}**.
1. Если в проекте еще нет ни одного сохраненного отчета, выберите **{{ ui-key.yc-ui-talkanalytics.reports.comparison-key-value }}**. Если в проекте уже есть отчеты, нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.reports.create-report }}** → **{{ ui-key.yc-ui-talkanalytics.reports.comparison-key-value }}**.
1. {% include [manage-reports-period](../../../_includes/speechsense/reports/manage-reports-period.md) %}
1. {% include [manage-reports-filters](../../../_includes/speechsense/reports/manage-reports-filters.md) %}
1. {% include [manage-reports-grouping](../../../_includes/speechsense/reports/manage-reports-grouping.md) %}
1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.reports.add-parameter }}** и выберите нужный.

   Подробнее о параметрах и формировании отчета по ним см. в разделе [{#T}](../../concepts/reports/comparison.md#parameter).

1. Укажите, какие данные вы хотите получить: сумма значений параметра оценки, среднее, минимальное или максимальное значение параметра оценки.

   В отчете **{{ ui-key.yc-ui-talkanalytics.reports.comparison-key-value }}** можно выбрать только численные параметры оценки. Если выбрать [тег](../../concepts/tags.md) в качестве параметра, за указанный период считается суммарное, среднее, минимальное или максимальное количество раз, когда тег был назначен на диалоги.

1. Укажите еще параметры оценки с помощью кнопки ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.reports.add-parameter }}**.
1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.reports.generate-report }}**.
1. Чтобы использовать отчет повторно, нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.reports.save-report-key-value }}**. Укажите его название и (опционально) описание.

   Отчет будет доступен в выбранном проекте на вкладке **{{ ui-key.yc-ui-talkanalytics.reports.reports }}**.

## Построить отчет «{{ ui-key.yc-ui-talkanalytics.reports.details-key-value }}» {#build-a-details-report}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите нужный проект.
1. Перейдите во вкладку **{{ ui-key.yc-ui-talkanalytics.reports.reports }}**.
1. Если в проекте еще нет ни одного сохраненного отчета, выберите **{{ ui-key.yc-ui-talkanalytics.reports.details-key-value }}**. Если в проекте уже есть отчеты, нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.reports.create-report }}** → **{{ ui-key.yc-ui-talkanalytics.reports.details-key-value }}**.
1. {% include [manage-reports-period](../../../_includes/speechsense/reports/manage-reports-period.md) %}
1. {% include [manage-reports-filters](../../../_includes/speechsense/reports/manage-reports-filters.md) %}
1. {% include [manage-reports-grouping](../../../_includes/speechsense/reports/manage-reports-grouping.md) %}
1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.reports.add-parameter }}**.
1. Выберите параметр оценки, изменение значений которого вы хотите посмотреть.

   Подробнее о параметре и формировании отчета по нему см. в разделе [{#T}](../../concepts/reports/details.md#parameter).

1. Укажите, какие данные вы хотите получить: сумма значений параметра оценки, среднее, минимальное или максимальное значение параметра оценки.

   В отчете **{{ ui-key.yc-ui-talkanalytics.reports.details-key-value }}** можно выбрать только численные параметры оценки. Если выбрать [тег](../../concepts/tags.md) в качестве параметра, за указанный период считается суммарное, среднее, минимальное или максимальное количество раз, когда тег был назначен на диалоги.

1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.reports.generate-report }}**.
1. Чтобы использовать отчет повторно, нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.reports.save-report-key-value }}**. Укажите его название и (опционально) описание.

   Отчет будет доступен в выбранном проекте на вкладке **{{ ui-key.yc-ui-talkanalytics.reports.reports }}**.

## Применить смысловой атрибут в отчете {#apply-sense-attribute}

[Смысловой атрибут](../../concepts/reports/sense-attributes.md) — это характеристика диалога, которая задает контекст для анализа по поисковому запросу. {{ speechsense-name }} анализирует диалог и определяет, насколько он соответствует по смыслу поисковому запросу в контексте выбранного смыслового атрибута.  

> Например, вы выбрали смысловой атрибут **{{ ui-key.yc-ui-talkanalytics.neuro-tags.themes-key-value }}** и задали поисковый запрос `Отдых в Сочи`. {{ speechsense-name }} проанализирует диалоги и определит, соответствует ли по смыслу их тема запросу `Отдых в Сочи`.

Вы можете применить смысловой атрибут в отчете:

* Как фильтр диалогов (в отчетах **{{ ui-key.yc-ui-talkanalytics.reports.rating-key-value }}**, **{{ ui-key.yc-ui-talkanalytics.reports.comparison-key-value }}** и **{{ ui-key.yc-ui-talkanalytics.reports.details-key-value }}**). В отчет попадут только те диалоги, которые соответствуют или не соответствуют запросу в контексте выбранного смыслового атрибута.

  > Например, вы используете смысловой атрибут **{{ ui-key.yc-ui-talkanalytics.neuro-tags.themes-key-value }}** и поисковый запрос `Отдых в Сочи` в качестве фильтра. Тогда в отчет попадут только те диалоги, тема которых соответствует или не соответствует запросу `Отдых в Сочи`, в зависимости от вашего выбора.

* Как параметр оценки (только в отчете **{{ ui-key.yc-ui-talkanalytics.reports.rating-key-value }}**). Смысловой атрибут будет одним из критериев, по которым оценивается работа оператора.

  > Например, вы используете смысловой атрибут **{{ ui-key.yc-ui-talkanalytics.neuro-tags.results-key-value }}** и поисковый запрос `Клиент забронировал тур` в качестве одного из параметров оценки. В таком случае работа оператора будет оцениваться по тому, соответствует ли итог диалога запросу `Клиент забронировал тур`.

  В каждом отчете **{{ ui-key.yc-ui-talkanalytics.reports.rating-key-value }}** смысловой атрибут можно использовать только один раз: либо в качестве параметра, либо в качестве фильтра.

Чтобы применить смысловой атрибут к диалогам в отчетах:

{% list tabs %}

- В качестве фильтра

  1. В окне создания отчета нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) рядом с полем **{{ ui-key.yc-ui-talkanalytics.common.period }}**. В выпадающем списке выберите **Смысловой атрибут**.
  1. {% include [manage-reports-period](../../../_includes/speechsense/reports/sense-attribute/choose-period.md) %}
  1. {% include [manage-reports-period](../../../_includes/speechsense/reports/sense-attribute/choose-attribute.md) %}
  1. {% include [manage-reports-period](../../../_includes/speechsense/reports/sense-attribute/wait-prompt.md) %}
  1. {% include [manage-reports-period](../../../_includes/speechsense/reports/sense-attribute/choose-prompt.md) %}
  1. {% include [manage-reports-period](../../../_includes/speechsense/reports/sense-attribute/apply.md) %}

  1. Когда группировка диалогов станет подходящей, укажите, какую группу использовать.

     > Например, если вы задали критерий **{{ ui-key.yc-ui-talkanalytics.neuro-tags.themes-key-value }}**, нажмите одну из двух кнопок:
     >
     > * **{{ ui-key.yc-ui-talkanalytics.neuro-tags.apply.theme }}** — чтобы использовать в отчете только диалоги на указанную тему;
     > * **{{ ui-key.yc-ui-talkanalytics.neuro-tags.apply-inverted.theme }}** — чтобы использовать в отчете диалоги на любую тему, кроме указанной.

     {% note info %}

     Представленные в колонках диалоги не обязательно совпадают с теми, которые фактически попадут в отчет. Расхождение может появиться, если при настройке смыслового атрибута и формировании отчета использовались разные периоды или фильтры.

     {% endnote %}

  После этого вы можете добавить дополнительные фильтры и параметры и построить отчет.

- В качестве параметра оценки

  1. В окне создания отчета нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.reports.add-parameter }}**. В выпадающем списке выберите **Смысловой атрибут**.
  1. {% include [manage-reports-period](../../../_includes/speechsense/reports/sense-attribute/choose-period.md) %}
  1. {% include [manage-reports-period](../../../_includes/speechsense/reports/sense-attribute/choose-attribute.md) %}
  1. {% include [manage-reports-period](../../../_includes/speechsense/reports/sense-attribute/wait-prompt.md) %}
  1. {% include [manage-reports-period](../../../_includes/speechsense/reports/sense-attribute/choose-prompt.md) %}
  1. {% include [manage-reports-period](../../../_includes/speechsense/reports/sense-attribute/apply.md) %}

  1. Когда группировка диалогов станет подходящей, укажите, какую группу использовать.

     > Например, если вы задали критерий **{{ ui-key.yc-ui-talkanalytics.neuro-tags.themes-key-value }}**, нажмите одну из двух кнопок:
     >
     > * **{{ ui-key.yc-ui-talkanalytics.neuro-tags.apply.theme }}** — чтобы использовать в качестве критерия оценки соответствие диалога заданной теме.
     > * **{{ ui-key.yc-ui-talkanalytics.neuro-tags.apply-inverted.theme }}** — чтобы использовать в качестве критерия оценки несоответствие диалога заданной теме.

     {% note info %}

     Представленные в колонках диалоги не обязательно совпадают с теми, которые фактически попадут в отчет. Расхождение может появиться, если при настройке смыслового атрибута и формировании отчета использовались разные периоды или фильтры.

     {% endnote %}

  После этого вы можете добавить дополнительные параметры и фильтры и построить отчет.

{% endlist %}

## Использовать смысловые и смысловые Pro-теги для оценки диалога {#use-sense-tags-for-dialog-evaluation}

Смысловые теги помогут оценить качество работы оператора и особенности поведения клиента, например, был ли вежливым оператор, хамил ли клиент и т. д. Для этого:

1. [Создайте смысловой тег](../project/tag/create-sense-tag.md). 

   При создании выберите нужный смысловой атрибут и задайте соответствующий поисковый запрос.

   > Например, если вас интересуют диалоги, в которых клиент хамил оператору, выберите:
   > * Смысловой атрибут — **{{ ui-key.yc-ui-talkanalytics.statements.common_question }}**.
   > * Поисковый запрос — **Клиент проявил грубость или агрессию в разговоре хотя бы один раз?**

1. Примените смысловой тег как параметр в отчете.

Смысловые Pro-теги помогут оценить качество работы оператора и особенности поведения клиента с учетом сложных смысловых критериев, например, смог ли оператор продать тур без предложения скидки клиенту. Для этого:

1. [Создайте смысловой Pro-тег](../project/tag/create-sense-pro-tag.md). 

   При создании задайте соответствующий поисковый запрос.

   > Например, если вас интересуют диалоги, в которых клиент купил тур на Мальдивы без предложения скидки, укажите поисковый запрос — **покупка тура на Мальдивы без предложения скидки**.

1. Примените смысловой Pro-тег как параметр в отчете.
