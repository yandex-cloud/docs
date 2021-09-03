# postMessage method

With the postMessage method, you can fill in the fields of a form embedded in a page using iframe. The method can be called at any time, passing values to the form that are unknown at the time the form is uploaded. That could be an automatically generated order ID in an online store.

To pre-fill the form using the postMessage method:

1. [Insert the form on the page using iframe](publish.md#section_c21_gdb_42b).

1. Get the [question ID and response ID](question-id.md) (for questions with multiple response options).

1. Insert a script on the page that will call the postMessage method and pass the parameters to be filled to the frame with the form.

{% note info %}

Only call the postMessage method once you receive a `ping` message from the frame with the form.

{% endnote %}

## postMessage message format {#sec_format}

The parameters for filling out the form using the postMessage method should be passed in the following format:

```
postMessage({message: 'set-question-value', slug: '<question id>', value: '<response>'}, '*');
```

The `value` parameter value depends on the question type:

* For questions with an input field like <q>Short text</q> or <q>Email</q>:

    ```
    value: 'response text'
    ```

    Examples:

    ```
    value: 'John Smith'
    ```

* For questions with response options like <q>One answer</q> or <q>Several answers</q>:

    ```
    value: '<response id>'
    ```

    Examples:

    ```
    value: '357603'
    ```

* For a <q>Date</q> question:

    ```
    value: 'YYYY-MM-DD'
    ```

    Examples:

    ```
    value: '2020-01-27'
    ```

* For a <q>Yes/No</q> question:

    ```
    value: 'True'
    ```

* For a <q>Rate on a scale</q> question.

  Select a response for one criterion:

    ```
    value: '<response id>'
    ```

  Select responses for multiple criteria:

    ```
    value: {'<criteria id X>': '<question id X>', '<criteria id Y>': '<response id Y>'}
    ```

    Examples:

    ```
    value: '39484_39487'
    ```

    ```
    value: {'39484': '39484_39487', '39483': '39483_39486'}
    ```

## Example of using postMessage {#sec_example}

This example shows a fragment of the HTML page code. The form is embedded in the page using iframe. After the form is uploaded, the `fill_form()` function is called to send several postMessage messages to fill in the form fields.

```html
<script src="https://yastatic.net/q/forms-frontend-ext/_/embed.js"></script>
<iframe src="https://forms.yandex.ru/u/5e2ac2d850bdb705c38ed14f/?iframe=1" frameborder="0" name="form" width="650" onload=fill_form()></iframe>
<script>
function fill_form(){
   window.frames[0].postMessage({message: 'set-question-value', slug: 'answer_boolean_1685199', value: 'True'}, '*');
   window.frames[0].postMessage({message: 'set-question-value', slug: 'answer_short_text_1685088', value: 'John Smith'}, '*');
   window.frames[0].postMessage({message: 'set-question-value', slug: 'answer_date_1685200', value: '2020-01-27'}, '*');
   window.frames[0].postMessage({message: 'set-question-value', slug: 'answer_choices_1685184', value: '1958524'}, '*');
   window.frames[0].postMessage({message: 'set-question-value', slug: 'answer_choices_1686274', value: {'231034': '231034_231037',    '231035': '231035_231038', '231036': '231036_231039'}}, '*');
}
</script>
```

## Inserting dynamic values {#sec_dynamic}

You can use the postMessage method to fill in form fields with data that can be automatically retrieved with JavaScript. For example, you can insert in the form the current date, an automatically generated order or request ID, or a screenshot.

If the data automatically filled in form fields is technical and uninteresting for users, you can hide those fields.

### Insert the current date in the field

```
postMessage({message: 'set-question-value', slug: 'answer_long_text_1686745', value: new Date()}, '*');
```

### Take a screenshot and attach it to the form

This example uses a third-party `html2canvas` library. Clicking the <q>Screenshot</q> button calls the `screenshot()` function which takes a screenshot and attaches it to the form.

```html
  <input type='button' value='Screenshot' onclick='screenshot()'>
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

