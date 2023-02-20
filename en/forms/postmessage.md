# The postMessage method

Using the postMessage method, you can fill in the fields of a form embedded in a page with an iframe. You can call the method anytime to pass unknown values to a form while uploading the form. For example, an order ID that is automatically generated in an online store.

To pre-fill a form using the postMessage method:

1. [Embed the form in a page using an iframe](publish.md#publlish-site).

1. Get the [question ID and response ID](question-id.md) (for questions with multiple response options).

1. Embed a script in a page that will call the postMessage method and pass parameters for filling out the form to its frame.

{% note info %}

Be sure to only call the postMessage method after receiving a message with a `ping` from the form frame.

{% endnote %}

## The message postMessage format {#sec_format}

Send the parameters for filling out the form using the postMessage method in the following format:

```
postMessage({message: 'set-question-value', slug: '<question ID>', value: '<response>'}, '*');
```

The `value` parameter value depends on the question type:

* For questions with an input field, such as <q>Short text</q> or <q>Email</q>:
   ```
   value: 'response text'
   ```
   For example:
   ```
   value: 'Ivan Ivanov'
   ```

* For questions with response options like <q>One answer</q> or <q>Multiple answers</q>:
   ```
   value: '<response ID>'
   ```
   For example:
   ```
   value: '357603'
   ```

* For questions of the <q>Date</q> type:
   ```
   value: 'YYYY-MM-DD'
   ```
   For example:
   ```
   value: '2020-01-27'
   ```

* For <q>Yes / No</q> questions:
   ```
   value: 'True'
   ```

* For <q>Rate on a scale</q> questions.

   Choose a response by one criterion:
   ```
   value: '<response ID>'
   ```
   Choose a response by multiple criteria:
   ```
   value: {'<X criteria ID>': '<X response ID>', '<Y criteria ID>': '<Y response ID>'}
   ```
   For example:
   ```
   value: '39484_39487'
   ```
   ```
   value: {'39484': '39484_39487', '39483': '39483_39486'}
   ```


## postMessage usage example {#sec_example}

This example contains an HTML page code snippet. The page has a form embedded with an iframe. Once the form is loaded, the `fill_form()` function is invoked to send multiple postMessages to the form to fill in its fields.

```html
<script src="https://yastatic.net/q/forms-frontend-ext/_/embed.js"></script>
<iframe src="https://forms.yandex.ru/u/5e2ac2d850bdb705c38ed14f/?iframe=1" frameborder="0" name="form" width="650" onload=fill_form()></iframe>
<script>
function fill_form(){
   window.frames[0].postMessage({message: 'set-question-value', slug: 'answer_boolean_1685199', value: 'True'}, '*');
   window.frames[0].postMessage({message: 'set-question-value', slug: 'answer_short_text_1685088', value: 'Ivan Ivanov'}, '*');
   window.frames[0].postMessage({message: 'set-question-value', slug: 'answer_date_1685200', value: '2020-01-27'}, '*');
   window.frames[0].postMessage({message: 'set-question-value', slug: 'answer_choices_1685184', value: '1958524'}, '*');
   window.frames[0].postMessage({message: 'set-question-value', slug: 'answer_choices_1686274', value: {'231034': '231034_231037',    '231035': '231035_231038', '231036': '231036_231039'}}, '*');
}
</script>
```

## Inserting dynamic values {#sec_dynamic}

You can use the postMessage method to write data to the form fields that can be fetched automatically using JavaScript. For example, you can insert the current date, an auto generated order or request ID, or a screenshot in the form.

If data that is automatically written to the form fields is technical and of no interest to users, you can hide these fields.

### Pasting the current date into the field

```
postMessage({message: 'set-question-value', slug: 'answer_long_text_1686745', value: new Date()}, '*');
```

### Taking screenshots and attaching to the form

In this example, we use a third-party library named `html2canvas`. Clicking <q>Screenshot</q> invokes the `screenshot()` function that takes a screenshot and attaches it to the form.

```html
  <input type='button' value='Screen capture' onclick='screenshot()'>
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
