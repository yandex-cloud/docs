# Метод postMessage

С помощью метода postMessage можно заполнять поля формы, встроенной на страницу с помощью iframe. Метод можно вызвать в любой момент, это позволяет передать в форму значения, которые неизвестны в момент загрузки формы. Например, автоматически сгенерированный идентификатор заказа в интернет-магазине.

Чтобы предзаполнить форму с помощью метода postMessage:

1. [Вставьте форму на страницу с помощью iframe](publish.md#publlish-site).

1. Получите [идентификатор вопроса и идентификатор варианта ответа](question-id.md) (для вопросов с вариантами ответов).

1. Вставьте на страницу скрипт, который будет вызывать метод postMessage и передавать в фрейм с формой параметры для заполнения формы.
 
{% note info %}

Вызывайте метод postMessage только после того, как от фрейма с формой придет сообщение `ping`.

{% endnote %}

## Формат сообщения postMessage {#sec_format}

Параметры для заполнения формы с помощью метода postMessage следует передавать в формате:

```
postMessage({message: 'set-question-value', slug: '<id вопроса>', value: '<ответ>'}, '*');
```

Значение параметра `value` зависит от типа вопроса:

* Для вопросов с полем ввода, например <q>Короткий текст</q>, <q>Почта</q>:
    ```
    value: 'текст ответа'
    ```
    Например:
    ```
    value: 'Иван Иванов'
    ```

* Для вопросов с вариантами ответов, например <q>Один вариант</q> или <q>Несколько вариантов</q>:
    ```
    value: '<id ответа>'
    ```
    Например:
    ```
    value: '357603'
    ```

* Для вопроса <q>Дата</q>:
    ```
    value: 'YYYY-MM-DD'
    ```
    Например:
    ```
    value: '2020-01-27'
    ```

* Для вопроса <q>Да / Нет</q>:
    ```
    value: 'True'
    ```

* Для вопроса <q>Оценка по шкале</q>.
  
  Выбрать ответ по одному критерию:
    ```
    value: '<id ответа>'
    ```
  Выбрать ответы по нескольким критериям:
    ```
    value: {'<id критерия X>': '<id ответа X>', '<id критерия Y>': '<id ответа Y>'}
    ```
    Например:
    ```
    value: '39484_39487'
    ```
    ```
    value: {'39484': '39484_39487', '39483': '39483_39486'}
    ```


## Пример использования postMessage {#sec_example}

В этом примере приведен фрагмент кода HTML-страницы. В страницу встроена форма с помощью iframe. После загрузки формы вызывается функция `fill_form()`, которая отправляет в форму несколько сообщений postMessage для заполнения полей формы.

```html
<script src="https://yastatic.net/q/forms-frontend-ext/_/embed.js"></script>
<iframe src="https://forms.yandex.ru/u/5e2ac2d850bdb705c38ed14f/?iframe=1" frameborder="0" name="form" width="650" onload=fill_form()></iframe>
<script>
function fill_form(){
   window.frames[0].postMessage({message: 'set-question-value', slug: 'answer_boolean_1685199', value: 'True'}, '*');
   window.frames[0].postMessage({message: 'set-question-value', slug: 'answer_short_text_1685088', value: 'Вася Пупкин'}, '*');
   window.frames[0].postMessage({message: 'set-question-value', slug: 'answer_date_1685200', value: '2020-01-27'}, '*');
   window.frames[0].postMessage({message: 'set-question-value', slug: 'answer_choices_1685184', value: '1958524'}, '*');
   window.frames[0].postMessage({message: 'set-question-value', slug: 'answer_choices_1686274', value: {'231034': '231034_231037',    '231035': '231035_231038', '231036': '231036_231039'}}, '*');
}
</script>
```

## Вставка динамических значений {#sec_dynamic}

Можно использовать метод postMessage, чтобы записать в поля формы данные, которые можно автоматически получить с помощью JavaScript. Например, можно вставлять в форму текущую дату, автоматически сгенерированный идентификатор заказа или обращения, скриншот экрана.

Если данные, которые автоматически записываются в поля формы, носят технический характер и не интересны пользователям, такие поля можно сделать скрытыми.

### Вставить в поле текущую дату

```
postMessage({message: 'set-question-value', slug: 'answer_long_text_1686745', value: new Date()}, '*');
```

### Снять скриншот и прикрепить к форме

В этом примере используется сторонняя библиотека `html2canvas`. При нажатии на кнопку <q>Снимок экрана</q> вызывается функция `screenshot()`, которая снимает скриншот и прикрепляет его к форме. 

```html
  <input type='button' value='Снимок экрана' onclick='screenshot()'>
  <script type="text/javascript" src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>
  <script>
    function screenshot() {
      html2canvas(document.body).then(canvas => {
        window.frames[0].postMessage({
          message: 'set-question-value',
          slug: 'answer_files_1738686',
          value: { format: 'dataUrl', dataUrl: canvas.toDataURL() },
        }, '*');
      }); 
    }
    </script>
```