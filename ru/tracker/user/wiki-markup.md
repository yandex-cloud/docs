# Форматировать текст в задаче

Чтобы форматировать текст в описании задачи и в комментариях, используйте вики-разметку. Например, вы можете выделять текст курсивом или полужирным шрифтом, вставлять списки и таблицы.

Чтобы увидеть, как будет выглядеть текст описания задачи или комментарий с форматированием, под полем ввода текста нажмите кнопку **Предпросмотр**. Чтобы продолжить форматирование, нажмите кнопку **Правка**.

Основные элементы разметки перечислены в таблице.

Элемент | Разметка | Результат
----- | ----- | -----
Заголовки | {% if locale == "ru" %}```== Заголовок первого уровня```<br/>```=== Заголовок второго уровня```<br/>```==== Заголовок третьего уровня```{% else %}```== The first level header```<br/>```=== The second level header```<br/>```The third level header```{% endif %} | ![](../../_assets/tracker/format/h1-h3.png)
Горизонтальная линия | ``` ---- ``` | ![](../../_assets/tracker/format/hr.png)
Полужирный текст | {% if locale == "ru" %}```**Полужирный текст**```{% else %}```**Bold text**```{% endif %} | ![](../../_assets/tracker/format/bold.png)
Курсив | {% if locale == "ru" %}```*Курсив*```{% else %}`*Italic text*`{% endif %} | ![](../../_assets/tracker/format/italic.png)
Подчеркнутый текст | {% if locale == "ru" %}```__Подчеркнутый текст__```{% else %}```__Underlined text__```{% endif %} | ![](../../_assets/tracker/format/underlined.png)
Зачеркнутый текст | {% if locale == "ru" %}```--Зачеркнутый текст--```{% else %}```--Strikethrough text--```{% endif %} | ![](../../_assets/tracker/format/crossed.png)
Мелкий текст | {% if locale == "ru" %}```++Мелкий текст++```{% else %}```++Small font++```{% endif %} | ![](../../_assets/tracker/format/small-text.png)
Выделенный текст | {% if locale == "ru" %}```??Выделенный текст??```{% else %}```??Highlighted text??```{% endif %} | ![](../../_assets/tracker/format/red-background.png)
Цветной текст.<br/><br/>Поддерживаются цвета:<br/><br/>`red` / `крас` / `красный`;<br/>`green` / `зел` / `зеленый`;<br/>`blue` / `син` / `синий`;<br/>`grey` / `gray` / `сер`;<br/>`yellow` / `жел` | {% if locale == "ru" %}```!!(син)Текст синего цвета!!```{% else %}```!!(blue)Blue text!!```{% endif %} | ![](../../_assets/tracker/format/colored.png)
Нумерованный список | {% if locale == "ru" %}```1. Пункт списка.```<br/>```2. Пункт списка.```<br/>&nbsp;&nbsp;&nbsp;&nbsp;`1. Подпункт.`<br/>&nbsp;&nbsp;&nbsp;&nbsp;`2. Подпункт.`<br/>&nbsp;&nbsp;&nbsp;&nbsp;`3. Подпункт.`<br/>```3. Пункт списка.```{% else %}```1. list item;```<br/>```2. list item;```<br/>&nbsp;&nbsp;&nbsp;&nbsp;`1. nested list item;`<br/>&nbsp;&nbsp;&nbsp;&nbsp;`2. nested list item;`<br/>&nbsp;&nbsp;&nbsp;&nbsp;`3. nested list item;`<br/>```3. list item.```{% endif %} | ![](../../_assets/tracker/format/numerated-list-exampe.png)
Маркированный список | {% if locale == "ru" %}```* пункт списка;```<br/>```* пункт списка:```<br/>&nbsp;&nbsp;&nbsp;&nbsp;`* подпункт;`<br/>&nbsp;&nbsp;&nbsp;&nbsp;`* подпункт;`<br/>```* пункт списка.```{% else %}```* list item;```<br/>```* list item:```<br/>&nbsp;&nbsp;&nbsp;&nbsp;`* nested list item;`<br/>&nbsp;&nbsp;&nbsp;&nbsp;`* nested list item;`<br/>```* list item.```{% endif %} | ![](../../_assets/tracker/format/unordered-list-exampe.png)
Ссылка | {% if locale == "ru" %}```((http://example.com/ текст ссылки))```{% else %}```((http://example.com/ link text))```{% endif %} | ![](../../_assets/tracker/format/hyperlink.png)
Ссылка на задачу | ``` TEST-123 ``` | ![](../../_assets/tracker/format/tracker-magic-link.png)
Цитирование текста | {% if locale == "ru" %}```<[Цитирование текста,```<br/>```длинного,```<br/>```с переносами]>```{% else %}```<[Quoting of long```<br/>```text```<br/>```with linebreaks]>```{% endif %} | ![](../../_assets/tracker/format/quote.png)
Однострочное цитирование | {% if locale == "ru" %}```>Однострочное цитирование```<br/>```>>Цитата второго уровня```{% else %}```>Single-line quoting```<br/>```>>Second-level quote```{% endif %} | ![](../../_assets/tracker/format/inline-quote.png)
Текст под катом | {% if locale == "ru" %}```<{Прочитать целиком```<br/>```Этот текст можно увидеть, кликнув```<br/>```по ссылке "прочитать целиком".```<br/>```}>```{% else %}```<{Read the entire text```<br/>```This text can be seen by clicking```<br/>```the link "Read the entire text".```<br/>```}>```{% endif %} | ![](../../_assets/tracker/format/cut.png)
Таблица | ```#|```<br/>```||cell 11|cell 12|cell 13||```<br/>```||cell 21|cell 22||```<br/>```#|``` | ![](../../_assets/tracker/format/table.png)
Исходный код | {% if locale == "ru" %}```%%фрагмент кода%%```{% else %}```%%piece of code%%```{% endif %} | ![](../../_assets/tracker/format/source-code-2.png)
Экранирование элементов вики-разметки | {% if locale == "ru" %}```""**Экранирование всех элементов**```<br/>```//разметки в тексте//""```<br/>```~**Экранирование одного** //элемента разметки//```{% else %}```""**Escaping all markup**```<br/>```//elements in this text//""```<br/>```~**Escaping single** //markup element//```{% endif %} | ![](../../_assets/tracker/format/escaping.png)

