# Configuring pre-filling forms

You can configure a form so that when it's opened, specified values are automatically inserted into fields or certain responses are pre-selected.

You can use pre-filling:

- To suggest responses that you think are preferable or most likely.

- To pass auxiliary or technical parameters to [hidden fields in the form](#hidden-query) (for example, for gathering statistics).


To set a field value or select a response option, send the [question ID](question-id.md) and the  response value to the form using [GET parameters in the form URL](get-params.md)

## Configuring pre-filling a hidden field {#hidden-query}

You can use hidden fields to automatically send technical or auxiliary parameters, such as [UTM tags]({{ link-wikipedia-utm }}), to the form. This way, you can add more information to user responses for analytics and statistics.

> Let's say you created a form and posted it on different websites. Now you want to know which website the user filled out the form on. To find this out, use the `utm_source` UTM tag.
>
> Add a hidden field named <q>Response source</q> to the form. Add a GET parameter to the link, and the parameter value will automatically be sent to the hidden field. Then you can see where your user responses came from.

To configure a hidden parameter for this example:

1. Add a [<q>Short text</q>](blocks-ref/short-text.md) prompt named <q>Response source</q> to the form.

1. Turn on **Hidden question** for this prompt.

1. In the **ID of the question** field, specify `utm_source`: [GET parameter](get-params.md) name.

1. [Get a link to the form](publish.md#section_link) and append it to the GET parameter `?utm_source=site_name_1`.

   - Sample link to the form without GET parameter:
      `{{ link-forms }}u/6191b18d99e21b1b45b9c82/`

   - Sample link to the form with GET parameter:
      `{{ link-forms }}u/6191b18d99e21b1b45b9c82?utm_source=site_name_1`

1. Post the form link with the GET parameter on the website.

1. In the same way, create another link to be placed on another website. To do this, append the GET parameter `?utm_source=site_name_2`.

1. When a user follows the link, the `site_name_1` or `site_name_2` value is automatically entered in the <q>Response source</q> hidden field. You can use this value in the response to determine the website the form was filled out on.

To enable pre-filling of a hidden field when [embedding a form in a website with an iframe](publish.md#publlish-site), specify the URL with the configured GET parameters in the iframe embed code.