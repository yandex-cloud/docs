---
title: Индикатор в {{ datalens-full-name }}
description: Из статьи вы узнаете, как в {{ datalens-short-name }} создать и настроить тип визуализации Индикатор.
---

# Индикатор ![](../../_assets/datalens/indicator.svg)

Индикатор отражает значение одного ключевого показателя. Чтобы сделать индикатор более [сложным](#markup-indicator) и информативным, можно использовать несколько показателей.

Индикатор используется, когда на дашборде есть значения, за которыми нужно регулярно следить для понимания общей ситуации. Это может быть, например, количество инцидентов за прошлый день, процент выполнения плана или прирост продаж год к году.

Чаще всего индикаторы располагаются сверху или в правой части дашборда. Чтобы индикаторы не теряли акцент и не путали пользователя, их должно быть не больше шести на одном экране. С помощью индикаторов разного размера можно выстроить иерархию важности разных метрик.

![indicator-chart](../../_assets/datalens/visualization-ref/indicator-chart/indicator-chart.png)

Размер и цвет индикатора можно настраивать.

![indicator-chart-red](../../_assets/datalens/visualization-ref/indicator-chart/indicator-chart-red.png)

{% cut "Исходная таблица" %}

Год |	Продажа|	
-----|---------| 
2022|	6М |	
2021|	28М |	
2020|	18М |	
2019|	9М | 
2018|	1М |

{% endcut %}

## Секции в визарде {#wizard-sections}

Секция<br/> в визарде| Описание
----- | ----
Показатель  | Показатель. Один показатель, который определяет значение индикатора.
Фильтры | Измерение или показатель. Используется в качестве фильтра.

## Создание индикатора {#create-diagram}

Чтобы создать индикатор:


{% include [datalens-workbooks-collections-note](../../_includes/datalens/operations/datalens-workbooks-collections-note-step4.md) %}


1. Перейдите на [главную страницу]({{ link-datalens-main }}) {{ datalens-short-name }}.
1. На панели слева выберите ![chart](../../_assets/console-icons/chart-column.svg) **Чарты**.
1. Нажмите кнопку **Создать чарт** → **Чарт**.
1. Слева вверху нажмите ![image](../../_assets/console-icons/circles-intersection.svg) **Выберите датасет** и укажите датасет для визуализации.
1. Выберите тип чарта **Индикатор**.
1. Перетащите измерение или показатель из датасета в секцию **Показатель**. Значение отобразится в виде числа.

## Дополнительные настройки {#additional-settings}

### Изменение размера и цвета индикатора {#size-color-setting}

Чтобы изменить размер и цвет индикатора:

1. В секции **Показатель** нажмите значок ![](../../_assets/console-icons/gear.svg). Настройка недоступна для поля с типом `Разметка`. В этом случае используйте для форматирования [функции разметки](../function-ref/markup-functions.md), как при [создании сложного индикатора](#markup-indicator).
1. В окне **Настройки индикатора** выберите размер, цветовую палитру, цвет и нажмите **Применить**.

### Настройка отображения заголовка {#indicator-title}

Чтобы настроить отображение заголовка:

1. В верхней части экрана, напротив типа чарта, нажмите значок ![image](../../_assets/console-icons/gear.svg).
1. Выберите отображение заголовка:

   * `Название поля` — отображать название поля в заголовке;
   * `Вручную` — переименовать заголовок;
   * `Скрыть` — не отображать заголовок.

1. Нажмите кнопку **Применить**.

{% cut "Окно настроек чарта" %}

![indicator-chart-settings](../../_assets/datalens/release-notes/preview-disable.png)

{% endcut %}

### Создание сложного индикатора {#markup-indicator}

Чтобы создать сложный индикатор, отображающий значения нескольких показателей, используйте [функции разметки](../function-ref/markup-functions.md). Для этого:

1. Создайте [вычисляемое поле](../concepts/calculations/index.md) с помощью функций разметки.
1. Перетащите поле из раздела **Показатели** в секцию **Показатель** индикатора.

{% cut "Форматирование текста" %}

```markdown
BOLD(SIZE('Оплата по карте: ', '18px')) +
BR() + BR() +
SIZE(COLOR(STR(COUNTD_IF([OrderID], [PaymentType]='Банковская карта')),'blue') + ' / ' + STR(COUNTD([OrderID])), '26px') +
BR() + BR() +
SIZE(STR(ROUND(COUNTD_IF([OrderID], [PaymentType]='Банковская карта')/COUNTD([OrderID])*100, 2)) +
' %  от общего количества', '20px')
```

![indicator-fonts](../../_assets/datalens/visualization-ref/indicator-chart/indicator-fonts.png)

{% endcut %}

{% cut "Индикатор с несколькими показателями" %}

```markdown
SIZE('Количество: ', '18px') +
BR() + BR() +
COLOR(SIZE('- категорий: ' + STR(COUNTD([ProductCategory])), '18px'), '#BE2443') +
BR() +
COLOR(SIZE('- подкатегорий: ' + STR(COUNTD([ProductSubcategory])), '18px'), 'blue') +
BR() +
COLOR(SIZE('- брендов: ' + STR(COUNTD([ProductBrend])), '18px'), 'green') +
BR() +
COLOR(SIZE('- продуктов: ' + STR(COUNTD([ProductName])), '18px'), '#FF7E00')
```

![indicator-some-measures](../../_assets/datalens/visualization-ref/indicator-chart/indicator-some-measures.png)

{% endcut %}

{% cut "Индикатор с отображением показателя по категориям" %}

```markdown
SIZE('Продажи: ' + COLOR(STR([Sales])+ ' ₽', 'green'), '26px') +
BR() +
COLOR(" ▲ ", "green")+" — боле 50000000 ₽  | " + COLOR(" ▼ ", "red") + " — 50000000 ₽ и менее" +
BR() + BR() +
SIZE(
    COLOR('| ' + STR(SUM_IF([Sales],[ProductCategory]='Техника для дома'))+ ' ₽ | ', 'blue') + 
    COLOR(if(SUM_IF([Sales],[ProductCategory]='Техника для дома')>50000000, " ▲ "," ▼ "), if(SUM_IF([Sales],[ProductCategory]='Техника для дома')>50000000,"green", "red")),
    '20px') +
BR() + 'Техника для дома' +
BR() + BR() +
SIZE(
    COLOR('| ' + STR(SUM_IF([Sales],[ProductCategory]='Бытовая химия'))+ ' ₽ | ', 'green') + 
    COLOR(if(SUM_IF([Sales],[ProductCategory]='Бытовая химия')>50000000, " ▲ "," ▼ "), if(SUM_IF([Sales],[ProductCategory]='Бытовая химия')>50000000,"green", "red")),
    '20px') +
BR() + 'Бытовая химия' +
BR() + BR() +
SIZE(
    COLOR('| ' + STR(SUM_IF([Sales],[ProductCategory]='Бытовые товары'))+ ' ₽ | ', 'violet') + 
    COLOR(if(SUM_IF([Sales],[ProductCategory]='Бытовые товары')>50000000, " ▲ "," ▼ "), if(SUM_IF([Sales],[ProductCategory]='Бытовые товары')>50000000,"green", "red")),
    '20px') +
BR() + 'Бытовые товары'
```

![indicator-categories](../../_assets/datalens/visualization-ref/indicator-chart/indicator-categories.png)

{% endcut %}

{% cut "Индикатор с изображением" %}

```markdown
IMAGE('https://storage.yandexcloud.net/dl--********//datalens.jpg', 32, 32, 'alt-text-1') +
COLOR(SIZE('| ' + STR(SUM_IF([Usage],[Service]='DataLens')), '32px'), '#AEC5F3') +
BR()+
COLOR(SIZE('DataLens', '20px'), '#AEC5F3')+
BR()+
BR()+
IMAGE('https://storage.yandexcloud.net/dl--********//powerbi.jpg', 32, 32, 'alt-text-1') +
" " + COLOR(SIZE('| ' + STR(SUM_IF([Usage],[Service]='Power BI')), '32px'), '#B8A754')+
BR()+
COLOR(SIZE('Power BI', '20px'), '#B8A754')+
BR()+
BR()+
IMAGE('https://storage.yandexcloud.net/dl-********/tableu.jpg', 32, 32, 'alt-text-1') +
" " + COLOR(SIZE('| ' + STR(SUM_IF([Usage],[Service]='Tableau')), '32px'), '#4D5DAB')+
BR()+
COLOR(SIZE('Tableau', '20px'), '#4D5DAB')
```

![indicator-some-measures](../../_assets/datalens/visualization-ref/indicator-chart/indicator-image.png)

{% endcut %}

## Рекомендации {#recommendations}

* Используйте Emoji при вычислении значений индикатора, чтобы добавить информативности.

  ![indicator-chart-emoji](../../_assets/datalens/visualization-ref/indicator-chart/indicator-chart-emoji.png)

  В данном чарте-индикаторе используется вычисляемое поле с формулой `IF([Средний чек]>2200, CONCAT("✔️",STR(ROUND([Средний чек]))),CONCAT("🔻",STR(round([Средний чек]))))`.

* Описывайте контекст для понимания, что означает индикатор.

  ![indicator-chart-context](../../_assets/datalens/visualization-ref/indicator-chart/indicator-chart-context.png)

#### См. также {#see-also}

* [{#T}](../operations/dashboard/create.md)
* [{#T}](../operations/dashboard/add-chart.md)
* [{#T}](../operations/dashboard/add-selector.md)