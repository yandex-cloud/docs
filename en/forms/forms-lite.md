# Publish a form on Zen

To add a form to Zen, use the [Forms widget]({{ support-zen-widget }}). It lets you create a form using a lite version of the constructor and publish it in an article. You can also insert a [link](publish.md) to your ready-made form in the article draft.

## Create a form in the widget {#lite}

Zen provides a lite version of the form constructor. The lite version only supports the main types of form prompts. For information about what other elements you can add to a form, see [{#T}](blocks-ref/blocks-reference.md).

{% note tip %}

To edit the [appearance of a form](appearance.md), embed [tests and quizzes](tests.md), add [additional prompts](add-questions.md), and configure their display [logic](send-condition.md) , use the [full version of the form constructor](#full).

{% endnote %}

1. In the Zen article editor's **Text** field, click ![](../_assets/forms/zen-add-source-icon.png) and select the **Forms** widget. For more information, see [Zen Help]({{ support-zen-widget-add }}).

1. To add the first prompt, select its type in the form creation space.

1. To add another prompt, hover over the created prompt and click ![](../_assets/forms/add-block.png). The new prompt appears above the current one if you hover over the upper part of the block.

1. To copy or remove a prompt, click ![](../_assets/forms/icon-copy.png) or ![](../_assets/forms/remove.png).

1. To add an image to a prompt or response option, click ![](../_assets/forms/lite-image.png).

1. To split a form into multiple pages, click **Add page** below the form creation space.

1. To display response statistics once the user fills out the form, enable **Show response statistics after submitting the form**. Statistics are displayed for **List** prompts.

1. When everything is ready, tap **Publish**.

## Run a test {#test}

You can use the **Forms** widget to conduct a test or quiz in your article. You can configure additional settings for [tests and quizzes](tests.md) in the [full version of the constructor](#full).

1. In the Zen article editor's **Text** field, click ![](../_assets/forms/zen-add-source-icon.png) and select the **Forms** widget. For more information, see [Zen Help]({{ support-zen-widget-add }}).

1. Add question:

   - **List** to add one or more response options.

   - **Number** to set an integer or fraction.

1. If you choose **List**, specify its type: **Multiple choice — single response** or **Multiple choice — multiple responses**.

1. Enter your prompt.

1. To set up correct and incorrect responses, enable ![](../_assets/forms/lite-test.png) **Points**.

1. Enter response options and the number of points to be given for each of them. For incorrect responses, set 0 points.

1. To add another prompt, hover over the created prompt and click ![](../_assets/forms/add-block.png). The new prompt appears above the current one if you hover over the upper part of the block.

1. At the bottom of the page, click **Scoring the test** and set the rules for [scoring](tests.md#test-result):

   1. Select the scoring method: **Range** to distribute the results across segments or **Pass/Fail**.

   1. To show the user how many points they scored, enable **Show test results**.

   1. To show the user what prompts they gave correct or incorrect responses to, enable **Show correct and incorrect responses**.

   1. Click **Save**.

1. To enable the user to compare their responses to those of other participants, select **Show response statistics after submitting the form** below the list of responses. Statistics are displayed for **List** prompts.

1. When everything is ready, tap **Publish**.

## Advanced form settings {#full}

1. At the bottom of the page, click **To full version**. This opens a window with a link to switch to the full version.

1. Click the link.

1. Edit the form.

1. Go back to the lite version of the constructor and click **Publish**. The widget with the form will be added to your article draft.

## Edit and view responses {#edit}

After the form is published, you can always [edit](forms-settings.md#section_kwd_p5b_tbb) it in the full version of the constructor. Save the changes in the constructor and update the page with the published form: the article is updated automatically.

You can view [responses](answers.md) to the form in the full version of the constructor.