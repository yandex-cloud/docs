# One answer

In this block, the user can select only one response from the suggested options, even if multiple responses may be correct. If the user selects a correct response, they get points only for this response.

![](../../_assets/forms/tutorial-test-single.gif)

>**For example, a test about travelling has the following prompt:** How many times did you travel abroad last year?
>
>**Response options:**
>
>- I didn't go abroad: 0 points.
>- Once: 1 point.
>- Two or three times: 3 points.
>- More than three times: 5 points.
>
>All the suggested responses are correct. The more often the user travels abroad, the more points they get for this prompt.

## Block settings {#sec_settings}

### Question {#question}

Enter your prompt.

{% include [question](../../_includes/forms/question.md) %}

{% include [param-answer](../../_includes/forms/param-answer.md) %}

Under all the responses you think are correct, select **Correct**.

Under the correct responses, specify the number of points that the user gets for each response. It must be a positive integer or fraction with no more than two decimal places.

The user only gets points for the response that they select.

{% include [id-required-hidden](../../_includes/forms/id-required-hidden.md) %}

{% include [sort](../../_includes/forms/sort.md) %}

{% if audience == "internal" %}

{% include [validate-blockrefs](../../_includes/forms/validate-blockrefs.md) %}

{% endif %}

