# "Multiple answers" test block

In this block, the user can choose multiple responses from the options suggested. One or more responses may be correct. The user will be given points for this prompt only if they select all the correct responses and don't pick incorrect ones.

![](../../_assets/forms/tutorial-test-multiple.gif)

> **Sample prompt:** Which of the listed cities are in Italy?
>
> **Answers options:**
>
> - Nice: 0 point.
> - Naples: 1 point.
> - Valencia: 0 point.
> - Milan: 1 point.
>
> There are two correct responses among those suggested: Naples and Milan. If the user selects these two cities and doesn't select Nice or Valencia, they'll get 2 points.

## Block settings {#sec_settings}

### Question {#question}

Enter your prompt.

{% include [question](../../_includes/forms/question.md) %}

{% include [param-answer](../../_includes/forms/param-answer.md) %}

Under all the responses you think are correct, select **Correct**.

Under the correct responses, specify the number of points that the user gets for each response. It must be a positive integer or fraction with no more than two decimal places.
Points for all the correct responses are summed up. The user will get the sum of points only if they select all the correct responses to the prompt.

{% include [id-required-hidden](../../_includes/forms/id-required-hidden.md) %}

{% include [sort](../../_includes/forms/sort.md) %}

