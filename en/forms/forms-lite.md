# Publish the form on Yandex.Zen

To add a form to Zen, use [Form widget]({{ support-zen-widget }}). This widget helps create forms using a light version of the form constructor in addition to publishing the forms in articles. You can also insert a [link](publish.md) to the finished form in the draft article.

## Create a form in the widget {#lite}

Yandex.Zen has a light version of the form constructor. The light version only supports the basic types of form prompts. To learn more about what other elements can be added to the form, go to [{#T}](blocks-ref/blocks-reference.md).

{% note tip %}

You can change the [appearance of the form](appearance.md), embed [tests and quizzes](tests.md), add [additional questions](add-questions.md), and set up the [logic](send-condition.md) for their display [in the full version of the form constructor](#full).

{% endnote %}

1. In the Yandex.Zen article editor, click ![](../_assets/forms/zen-add-source-icon.png) in the **Text** field and select the **Forms** widget. To learn more, go to [Yandex.Zen Help]({{ support-zen-widget-add }}).

1. To add the first question, select the question type in the form creation area.

1. To add another question to the page, hover over the question you created and click ![](../_assets/forms/add-block.png). If you hover the mouse over the top of the block, a new question will appear above the current question.

1. To copy or delete a question, click ![](../_assets/forms/icon-copy.png) or ![](../_assets/forms/remove.png).

1. To add an image to the question text or response option, click ![](../_assets/forms/lite-image.png).

1. To split the form into several pages, click **Add a page** under the form creation area.

1. To display response statistics after the user fills out the form, turn on the **Show response statistics after submitting the form** option. Statistics are displayed for **List** question types.

1. When everything is ready, click **Publish**.

## Make a test {#test}

Using the **Forms** widget, you can insert a test or a quiz in your article. Additional settings for [tests and quizzes](tests.md) are available [in the full version of the form constructor](#full).

1. In the Yandex.Zen article editor, click ![](../_assets/forms/zen-add-source-icon.png) in the **Text** field and select the **Forms** widget. To learn more, go to [Yandex.Zen Help]({{ support-zen-widget-add }}).

1. Add a question:

    - **List**: To select one or more response options.

    - **Number**: To specify an integer or fraction.

1. If you chose the **List** question, specify its type: **One answer** or **Multiple answers**.

1. Enter your prompt.

1. To set up correct and incorrect answers, turn on the ![](../_assets/forms/lite-test.png) option **Points**.

1. Enter the response options and the number of points for each of them. Set 0 points for incorrect options.

1. To add another question to the page, hover over the question you created and click ![](../_assets/forms/add-block.png). If you hover the mouse over the top of the block, a new question will appear above the current question.

1. At the bottom of the page, click **Score the test** and set the rules [for scoring the test](tests.md#test-result) in the panel on the right:

    1. Select the **Range** scoring method to distribute the results by segments or select **Pass/Fail**.

    1. To show users the number of points they scored, turn on the **Show the test results** option.

    1. To show users which responses were correct or incorrect, turn on **Show correct and incorrect answers**.

    1. Click **Save**.

1. To give the user the option to compare their results with those of other respondents, turn on the **Show response statistics after submitting the form** option under the list of responses. Statistics are displayed for **List** question types.

1. When everything is ready, click **Publish**.

## Advanced form setup {#full}

1. Click **Switch to full version** at the bottom of the page. This opens a window with a link to the full version.

1. Follow the link.

1. Edit the form.

1. Go back to the page with the light version of the form constructor and click **Publish**. The widget with the form will be added to the draft article.

## Editing and viewing responses {#edit}

After the form is published, you can always [edit](forms-settings.md#section_kwd_p5b_tbb) it in the full version of the form constructor. Save the changes in the form constructor and refresh the page with the published form. The article will be updated automatically.

[You can view the responses](answers.md) to the form in the full version of the form constructor.

