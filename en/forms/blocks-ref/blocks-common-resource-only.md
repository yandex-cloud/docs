# (resource) General block parameters

> [!WARNING]
Этот блок доступен только пользователям .

Question
: Enter the field name or prompt.
Enter the field name.
Enter your prompt.
- To add an image to the prompt, click ![](../../_assets/forms/add-picture.png).
- To add an image to the title, click ![](../../_assets/forms/add-picture.png).
- To add a comment or hint to the prompt, click **+ Add comment**. The comment is displayed in a small font.
- To format the text for your prompt or comment, use [Markdown](../appearance.md#section_pzm_m1j_j3b).
- To format the field header or comment, use [Markdown](../appearance.md#section_pzm_m1j_j3b).

Responses
: Set the options the user can choose:
- To add a response option, select **Add option** and enter the response text.
- To format the text of the response, use [Markdown](../appearance.md#section_pzm_m1j_j3b).
- To add an image to the response option, click the ![](../../_assets/forms/add-picture.png) icon.
- To move an option to a different position in the list, drag the ![](../../_assets/forms/drag-answer.png) icon.
- To delete a response option, click the ![](../../_assets/forms/remove.png) icon.
- Under all the responses you think are correct, select **Correct**.
- Under the correct responses, specify the number of points that the user gets for each response. It must be a positive integer or fraction with no more than two decimal places.

Question ID
: Use the question ID to [pre-fill forms](../pre-fill.md).
You can edit the ID. All questions in the same form must have unique IDs.

Required prompt
: Turn this option on to mark required prompts with an <q>asterisk</q>. If the user doesn't respond to this prompt, they can't submit the completed form.

Hidden question
: Turn this option on if you don't want to show a prompt on the form. You can use hidden questions to [send technical parameters](../pre-fill.md#hidden-query).
> [!NOTE]
> Не включайте опцию **Hidden question** and **Required prompt** at the same time, otherwise users won't be able to submit completed forms.

Limit the number of characters
: Set a minimum and maximum response length.

Sort responses
: Turn this option on and choose one of the following sorting methods:
- **Alphabetical**.
- **Random for each user**: Select this sorting method if you don't want the user's choice to be affected by the order in which responses are displayed.

Validation
: Use validation if you need to make sure responses match the specified format. For example, you can make sure responses are in Russian or that there aren't any forbidden characters in them. If the response doesn't match the specified format, a warning appears that the field is filled out incorrectly.
Select a validation method:
- **No validation**: The response can contain any characters. If you select this validation method, the prompt type changes to <q>Short text</q>.
- **External validator**: Validate the response using an external service. When selecting this option in the form settings, specify the [validation server address](../validation.md).

- **Validation of fractional numbers**: The response must contain an integer or a decimal. If you select this validation method, the prompt type changes to <q>Number</q>.
- **TIN validation**: The response must contain a valid taxpayer ID. If you select this validation method, the prompt type changes to <q>TIN</q>.
- **Validation of letters from the Cyrillic alphabet**: The response can only contain letters in the Russian alphabet, numbers, and spaces. If you select this validation method, the prompt type changes to <q>Short text</q>.
- **Validation using regular expressions**: You can make your own regular expression for responses. For example:
- A regular expression that only allows Latin letters, numbers, and spaces:
```
^[A-Za-z0-9\s]+$
```
- Регулярное выражение, которое разрешает вводить любые символы, кроме цифр и некоторых спецсимволов:
```
^[^0-9@#$%^&*]+$
```
При выборе этого метода валидации тип вопроса изменится на <q>Short text</q>.

Validation
: Use an external validator if you need to make sure responses match the specified format. When selecting this option in the form settings, specify the [validation server address](../validation.md).

- Yandex
- Yandex.Connect
- General

[Contact support](../feedback.md)

