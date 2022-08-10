# Configure pre-filling forms

You can configure a form so that when it's opened, specified values are automatically inserted into fields or certain responses are pre-selected.

You can use pre-filling forms:

- To suggest responses that you think are preferable or most likely.

- To pass auxiliary or technical parameters to [hidden fields in the form](#hidden-query) (for example, for gathering statistics).

To set a field value or select a response option, send the [question ID](question-id.md) and the response value{% if audience == "external" %} to the form using [GET parameters in the form URL](get-params.md){% else %}. There are two ways to do this:

- Using [GET parameters in the form URL](get-params.md).

- Using the [JavaScript postMessage method](postmessage.md). This method can only be used if the form is embedded using iframe.

{% endif %}

## Configure pre-filling a hidden field {#hidden-query}

You can use hidden fields to automatically send technical or auxiliary parameters, such as [UTM tags]({{ link-wikipedia-utm }}), to the form. This way, you can add more information to user responses for analytics and statistics.

> Let's say you created a form and posted it on different websites. Now you want to know which site the user filled the form out on. To do this, use the UTM tag `utm_source`.
>
> Add a hidden <q>Response source</q> field to the form. Add a GET parameter to the link, and the parameter value will automatically be sent to the hidden field. Then you can see where your user responses came from.

To configure a hidden parameter for this example:

1. Add a [<q>Short text</q>](blocks-ref/short-text.md) prompt with the <q>Response source</q> name to the form.

1. Turn on **Hidden question** for this prompt.

1. In the **Question ID** field, specify `utm_source`: This is the name of the [GET parameter](get-params.md).

1. [Get a link to the form](publish.md#section_link) and append it to the GET parameter `?utm_source=site_name_1`.

    - Example of a link to a form without a GET parameter:
    `{{ link-forms }}u/6191b18d99e21b1b45b9c82/`

    - Example of a link to a form with a GET parameter:
    `{{ link-forms }}u/6191b18d99e21b1b45b9c82?utm_source=site_name_1`

1. Post a link to the form with the GET parameter on the website.

1. In the same way, create another link to be placed on another site. To do this, append the GET parameter `?utm_source=site_name_2`.

1. When a user follows the link, the `site_name_1` or `site_name_2` value is automatically entered in the <q>Response source</q> hidden field. You can use this value in the response to determine the site the form was filled out on.

To enable pre-filling of the hidden field when [embedding a form in a website using iframe](publish.md#section_c21_gdb_42b), specify the URL with the configured GET parameters in the iframe embedding code.

