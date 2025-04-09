---
title: Построение таблицы на основе датасета в Editor
description: Следуя данной инструкции, вы сможете построить таблицу на основе датасета в Editor.
---

# Построение таблицы на основе датасета

{% include [business-note](../../../../_includes/datalens/datalens-functionality-available-business-note.md) %}

Следуя данной инструкции, вы построите в Editor таблицу на основе датасета. Для удобства в качестве источника данных мы будем использовать подключение и датасет из развернутого демо-воркбука.

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../../../_tutorials/_tutorials_includes/before-you-begin-datalens.md) %}

## Разверните демо-воркбук {#create-template}

1. [Разверните из маркетлейса](../../../operations/marketplace/add-marketplace-product.md) демо-воркбук с названием [Demo Dashboard](https://datalens.yandex.cloud/marketplace/f2eui5ar8omalpcg1j3r).

1. Перейдите в развернутый воркбук и на вкладке **Датасеты** найдите датасет с названием `00: Продажи`.

1. Скопируйте идентификатор датасета: рядом с ним нажмите на ![](../../../../_assets/console-icons/ellipsis.svg) → **Копировать ID**. Идентификатор будет скопирован в буфер обмена.

## Создайте чарт в Editor {#create-chart}

1. В воркбуке в правом верхнем углу нажмите **Создать** → **Чарт в Editor**. На открывшейся странице выберите тип визуализации **Таблица**.

1. Свяжите чарт с датасетом: для этого перейдите на вкладку **Meta** и добавьте ID датасета в `links`:

   ```javascript
   {
       "links": {
           "salesDataset": "<id_датасета>"
   	   }
   }
   ```

   Где:
   * `<id_датасета>` — идентификатор датасета, скопированный на предыдущем шаге.
   * `salesDataset` — произвольное имя-алиас, которое вы присваиваете датасету, с помощью которого запрашиваете данные для чарта из источника.

   {% note info %}
   
   Вкладка **Meta** нужна для описания служебной информации о списке связанных сущностей. Эта информация используется для определения, с какими подключениями и датасетами связан чарт, а также для диалога связанных объектов, при копировании воркбука и при публикации в Public.

   {% endnote %}

1. Получите данные из источника: для этого откройте вкладку **Source** и укажите:

   ```javascript
   const {buildSource} = require('libs/dataset/v2');
   module.exports = {
       'salesSourceData': buildSource({
           datasetId: Editor.getId('salesDataset'),
           columns: ['Тип  оплаты', 'Год заявки', 'Месяц заявки', 'Продажа, ₽'],
       }),
   };
   ```

   `salesSourceData` — произвольное имя-алиас, которое вы присваиваете объекту с запрошенными данными чарта, которое используется для доступа на вкладке **Prepare**.

   В значении поля `columns` перечислены имена полей из датасета.

   {% note info %}
   
   В данном примере используется служебный модуль `const {buildSource} = require('libs/dataset/v2');` для более удобной работы с датасетами.

   {% endnote %}

1. Очистите содержимое вкладок **Params** и **Config**: они содержат шаблон, не относящийся к нашему примеру.

1. На вкладке **Prepare** сформируйте таблицу:

   ```javascript
   const Dataset = require('libs/dataset/v2');
   const loadedData = Editor.getLoadedData();
   // Получаем данные из датасета в удобном формате с помощью служебного модуля
   const data = Dataset.processData(loadedData, 'salesSourceData', Editor);
   
   // Вспомогательная функция для группировки данных по заданному имени поля датасета 
   function groupBy(arr, field) {
       return arr.reduce((acc, item) => {
           const key = item[field];
           if (!acc[key]) {
               acc[key] = [];
           }
           acc[key].push(item);
           
           return acc;
       }, {});
   }
   
   // Массив с уникальными значениями из поля "Год заявки", отсортированное по возрастанию чисел
   const years = Array.from(new Set(data.map(d => String(d['Год заявки'])))).sort();
   
   // Общие стили для ячеек-заголовков таблицы
   const headStyles = {background: 'var(--g-color-base-misc-light)', verticalAlign: 'middle'};
   
   // Конфигурация ячеек-заголовков таблицы
   const head = [
       {
           name: 'Тип оплаты',
           formattedName: Editor.generateHtml({
               tag: 'span',
               content: [
                   {tag: 'span', content: 'Тип оплаты'},
   				// всплывающая подсказка для заголовка ячейки
                   {
                       tag: 'dl-tooltip',
                       content: ' ℹ',
                       style: {
                           display: 'inline-block',
                           margin: '0px 0px 0px 4px',
                           'line-height': '12px',
                           'text-align': 'center',
                           width: '16px',
                           height: '16px',
                           border: '1px solid #ccc',
                           'border-radius': '50%',
                       },
                       attributes : {
                           'data-tooltip-content': {
                               tag: 'i',
                               content: 'Tooltip content',
                           },
                       },
                   }
               ],
           }),
           css: headStyles,
           pinned: true,
       },
       // Формируем колонки по полученному выше массиву со значениями из поля "Год заявки"
       ...years.map(year => ({
           name: year,
           css: headStyles,
       })),
       {
           name: 'Продажи, все года',
           css: headStyles,
       },
   ];
   
   // Вспомогательная функция для отрисовки линии чарта
   function createChart(chartData) {
       const chartWidth = 80;
       const chartHeight = 40;
   
       // Вычисляем минимальное и максимальное значение координат
       const minX = Math.min(...chartData.map(d => d.x));
       const maxX = Math.max(...chartData.map(d => d.x));
       const minY = Math.min(...chartData.map(d => d.y));
       const maxY = Math.max(...chartData.map(d => d.y));
   
       // Вычисляем координаты в зависимости от размеров контейнера чарта (chartWidth, chartHeight)
       const coords = chartData.sort((d1, d2) => d1.x - d2.x).map(d => ([
           (d.x - minX) / (maxX - minX) * chartWidth, 
           (d.y - minY) / (maxY - minY) * chartHeight,
       ]));
       // Создаем путь для svg-линии по сформированным выше координатам
       let d = "";
       coords.forEach((_, x) => {
           d += d === "" ? "M" : " L";
           d += `${coords[x][0]} ${coords[x][1]}`;
       });
       // Создаем svg с цветом линии var(--g-color-base-brand) и толщиной 2px
       return `
           <svg width="${chartWidth}" height="${chartHeight}">
               <path 
                   d="${d}" 
                   style="fill: none; stroke: var(--g-color-base-brand); stroke-width: 2;"
               />
           </svg>`;
   }
   
   const rows = [];
   
   // Вспомогательная функция форматирования чисел
   const formatSalesValue = new Intl.NumberFormat('ru-RU').format;
   const postfix = ', ₽';
   
   // Сгруппированные строки по полю "Тип оплаты"
   const groupedData = groupBy(data, 'Тип  оплаты');
   // Формируем и наполняем строки таблицы для каждого сгруппированного типа оплаты
   Object.entries(groupedData).forEach(([key, items]) => {
       // Сгруппированные строки по полю "Год заявки"
       const salesByYears = groupBy(items, 'Год заявки');
       // Вычисляем сумму по полю "Продажа, ₽" по всем годам 
       const totalSales = items.reduce((sum, d) => sum + d['Продажа, ₽'], 0);
       rows.push({
           cells: [
               {
                   value: key,
               },
               // Формируем колонки по подготовленным ранее значениям "Год заявки"
               ...years.map(year => {
                   const salesByYear = salesByYears[year] ?? [];
                   const yearSales = salesByYear.map(d => ({
                       x: new Date(d['Месяц заявки']).getTime(), 
                       y: d['Продажа, ₽'],
                   }));
                   const maxSales = Math.max(...salesByYear.map(d => d['Продажа, ₽']));
                   const minSales = Math.min(...salesByYear.map(d => d['Продажа, ₽']));
   
                   return {
                       value: maxSales, 
                       formattedValue: Editor.generateHtml(`
                           <div>
                               ${createChart(yearSales)}
                               <div style="margin-top: 8px;">Min: <b>${formatSalesValue(minSales)}${postfix}<b></div>
                               <div>Max: <b>${formatSalesValue(maxSales)}${postfix}</b></div>
                           </div>
                       `),   
                   };
               }),
               {
                   value: totalSales,
                   formattedValue: formatSalesValue(totalSales) + postfix,
                   css: {
                       verticalAlign: 'middle',
                       textAlign: 'center',
                       fontSize: '16px',
                   },
               },
           ],
       });
   });
   
   module.exports = {head, rows};
   ```

1. Вверху чарта нажмите **Выполнить**. В области предпросмотра отобразится таблица с данными из датасета со сгруппированными строками по полю **Тип  оплаты** и сгруппированными колонками по полю **Год заявки** с графиком по значениям продаж по месяцам:

   ![image.png](../../../../_assets/datalens/editor/quick-start-1.png)

1. Чтобы сохранить чарт, в правом верхнем углу нажмите **Сохранить** и введите название чарта.