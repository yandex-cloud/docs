# Оформление текста

## Выделение текста {#inline}

{% note alert %}

Выделение работает правильно, только если символы разметки вплотную прилегают к тексту.

{% endnote %}

Разметка | Результат
--- | ---
`**Полужирный текст**` | ![](../../_assets/wiki/bold.png)
`*Курсив*` | ![](../../_assets/wiki/italic.png)
`_Курсив_` | ![](../../_assets/wiki/italic.png)
`//Курсив//` | ![](../../_assets/wiki/italic.png)
`__Подчеркнутый текст__` | ![](../../_assets/wiki/underlined.png)
`~~Зачеркнутый текст~~` | ![](../../_assets/wiki/crossed.png)
`--Зачеркнутый текст--` | ![](../../_assets/wiki/crossed.png)
`##Моноширинный текст##` | ![](../../_assets/wiki/monospaced.png)
`++Мелкий текст++` | ![](../../_assets/wiki/small.png)
Верхний индекс: `E=mc^^2^^` | ![](../../_assets/wiki/sup.png)
Нижний индекс: `Hvv2vvO` | ![](../../_assets/wiki/sub-no-spaces.png)
`??Выделенный текст??` | ![](../../_assets/wiki/red-background.png)
`!!Красный текст!!` | ![](../../_assets/wiki/red-colored.png)
`!!(син)Текст синего цвета!!`<br>Поддерживаются цвета:<ul><li>`red`{% if locale == "ru" %}/`крас`/`красный`{% endif %};</li><li>`green`{% if locale == "ru" %}/`зел`/`зеленый`{% endif %};</li><li>`blue`{% if locale == "ru" %}/`син`/`синий`{% endif %};</li><li>`grey`/`gray`{% if locale == "ru" %}/`сер` /`серый`{% endif %};</li><li>`yellow`{% if locale == "ru" %}/`жел`/`желтый`{% endif %};</li><li>`cyan`{% if locale == "ru" %}/`голуб`/`голубой`{% endif %};</li><li>`orang`{% if locale == "ru" %}/`оранж`/`оранжевый`{% endif %};</li><li>`violet`{% if locale == "ru" %}/`фиолет`/`фиолетовый`{% endif %}.</li></ul> | ![](../../_assets/wiki/colored.png)

## Сочетание элементов оформления {#sec_combine}

К одному фрагменту текста можно применить сразу несколько элементов оформления:

Разметка | Результат
--- | ---
`_**Полужирный курсив**_` | ![](../../_assets/wiki/bold-italic.png)
`*!!Красный курсив!!*` | ![](../../_assets/wiki/red-italic.png)

Элементы оформления текста можно использовать совместно с другими элементами разметки:

Разметка | Результат
--- | ---
`**[Полужирная ссылка](http://example.com)**` | ![](../../_assets/wiki/bold-link.png)
`>Цитата с *курсивом*` | ![](../../_assets/wiki/quote-italic.png)

## Прочая разметка {#other-formatting}

Элемент | Разметка | Результат
--- | --- | ---
Перевод строки | `первая строка---вторая строка` | ![](../../_assets/wiki/line-break.png)
Всплывающая подсказка |`(?Термин Определение термина?)` | ![](../../_assets/wiki/Term-with-definition.png)
Всплывающая подсказка (термин с пробелами)|`(?Термин с пробелами==Определение термина?)` | ![](../../_assets/wiki/long-term-with-definition.png)
Цветовой код (длинный) | `#ff0000` | ![](../../_assets/wiki/color-code-long.png)
Цветовой код (короткий) | `#F00` | ![](../../_assets/wiki/color-code-short.png)
Скрытый комментарий | `%%(comments) Скрытый текст%% ` | 