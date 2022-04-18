# Элементы HTML

## Теги {#html-tags}
Чтобы вставить на страницу элементы оформления, которые не предусмотрены разметкой Markdown, вы можете использовать в тексте теги HTML.

Например:

* ```html
  <p style="color: gray; font-weight: bold;">Текст серого цвета</p>
  ```
    {% cut "Как выглядит результат" %}

    <p style="color: gray; font-weight: bold;">Текст серого цвета</p>
    
    {% endcut %}

* ```html
  <p style="border-width: 4px; border-style: double; border-color: orange;">Текст в рамке</p>
  ```

    {% cut "Как выглядит результат" %}

    <p style="border-width: 4px; border-style: double; border-color: orange;">Текст в рамке</p>

    {% endcut %}

* ```html
  <table border="1">
    <tr><td>Значение 1</td><td>Значение 2</td></tr>
    <tr><td>Значение 3</td><td>Значение 4</td></tr>
  </table>
  ```

    {% cut "Как выглядит результат" %}

    <table border="1">
      <tr><td>Значение 1</td><td>Значение 2</td></tr>
      <tr><td>Значение 3</td><td>Значение 4</td></tr>
    </table>

    {% endcut %}

{% if audience == "internal" %}

## Вики-сниппеты {#snippets}

Чтобы добавить на страницу дополнительные элементы форматирования, можно использовать сниппеты — шаблоны HTML-кода. Сниппеты  для {{ wiki-name}} доступны по ссылкам:
* [Разметка страницы в несколько столбцов](https://wiki.yandex-team.ru/wiki/vodstvo/syntax/wiki-snippets/#1.razmetkastranicysetka)
* [Кнопки](https://wiki.yandex-team.ru/wiki/vodstvo/syntax/wiki-snippets/#2.knopki)
* [Алерты](https://wiki.yandex-team.ru/wiki/vodstvo/syntax/wiki-snippets/#3.alerty)
* [Бейджи](https://wiki.yandex-team.ru/wiki/vodstvo/syntax/wiki-snippets/#4.bejjdzhi)
* [Иконки](https://wiki.yandex-team.ru/wiki/vodstvo/syntax/wiki-snippets/#5.ikonki)
* [Блоки с оглавлением и полезными ссылками](https://wiki.yandex-team.ru/wiki/vodstvo/syntax/wiki-snippets/#6.bloksoglavleniemipoleznymissylkami)
* [Изображения с подписями](https://wiki.yandex-team.ru/wiki/vodstvo/syntax/wiki-snippets/#7.izobrazhenijaspodpisjami)
* [Прогрессбары](https://wiki.yandex-team.ru/wiki/vodstvo/syntax/wiki-snippets/#8.progressbary)

{% endif %}

