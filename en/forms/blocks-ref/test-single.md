# One answer

In this block, the user can select only one response from the suggested options, even if multiple responses may be correct. If the user selects a correct response, they get points only for this response.

![](../../_assets/forms/tutorial-test-single.gif)

>**For example, a test about travelling has the following prompt:** How many times did you travel abroad last year?
>
>**Response options:**
>
>- I didn't go abroad: 0 points.
>
>- Once: 1 point.
>
>- Two or three times: 3 points.
>
>- More than three times: 5 points.
>
>All the suggested responses are correct. The more often the user travels abroad, the more points they get for this prompt.

## Block settings {#sec_settings}

### Question {#question}

Enter your prompt.

- To add an image to the prompt, click ![](../../_assets/forms/add-picture.png).

- To add a comment or hint to the prompt, click **+ Add comment**. The comment is displayed in a small font.

- To format the text of your prompt or comment, use [Markdown](../appearance.md#section_pzm_m1j_j3b).

### Responses {#answer}

1. Set the response options for the user to select one of them:

   - To add a response option, select **Add option** and enter the text of the response.

   - To format the text of the response, use [Markdown](../appearance.md#section_pzm_m1j_j3b).

   - To add an image to the response option, click ![](../../_assets/forms/add-picture.png).

   - To move an option to a different position in the list, drag it to the ![](../../_assets/forms/drag-answer.png) icon.

1. Under all the responses you think are correct, select **Correct**.

1. Under the correct responses, specify the number of points that the user gets for each response. It must be a positive integer or fraction with no more than two decimal places.
The user only gets points for the response that they select.

### Question ID {#id}

Use the question ID to [pre-fill forms](../pre-fill.md).

You can edit the ID. All questions in the same form must have unique IDs.

### Required prompt {#required}

Turn this option on to mark required prompts with an <q>asterisk</q>. If the user doesn't respond to this prompt, they can't submit the completed form.

### Hidden question {#hidden}

Turn on this option if you don't want to show a prompt on the form. You can use hidden questions to [send technical parameters](../pre-fill.md#hidden-query).

{% note warning %}

Don't turn on **Hidden question** and **Required prompt** at the same time, otherwise users won't be able to submit the completed form.

{% endnote %}

### Sort responses {#sort}

Turn on this option and choose one of the sorting methods:

- **Alphabetical**.

- **Random for each user**: Select this sorting method if you don't want the user's choice to be affected by the order in which responses are displayed.


