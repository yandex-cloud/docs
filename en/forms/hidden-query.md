# Configuring pre-filling of a hidden field

You can use hidden fields to automatically send technical or auxiliary parameters, such as [UTM tags]({{ link-wikipedia-utm }}), to the form. This way, you can add more information to user responses for analytics and statistics.

> Let's say you created a form and posted it on different websites. Now you want to know which website the user filled out the form on. To find this out, use the `utm_source` UTM tag.
>
> Add a hidden field named <q>Response source</q> to the form. Add a GET parameter to the link, and the parameter value will automatically be sent to the hidden field. Then you can see where your user responses came from.

To configure a hidden parameter for this example:

1. Add a [**Short text**](blocks-ref/short-text.md) question named _Response source_ to the form.

1. Enable **Hidden question** for this question.

1. In the **ID of the question** field, specify `utm_source`: [GET parameter](get-params.md) name.

1. [Get a link to the form](publish.md#section_link) and append it to the `?utm_source=site_name_1` GET parameter.

   - Sample link to the form without the GET parameter:
      `{{ link-forms }}u/6191b18d99e21b1********/`

   - Sample link to the form with the GET parameter:
      `{{ link-forms }}u/6191b18d99e21b1********?utm_source=site_name_1`

1. Post the form link with the GET parameter on the website.

1. In the same way, create another link to be placed on another website. To do this, append the GET parameter `?utm_source=site_name_2`.

1. When a user follows the link, the `site_name_1` or `site_name_2` value is automatically entered in the <q>Response source</q> hidden field. You can use this value in the response to determine the website the form was filled out on.

To enable pre-filling of a hidden field when [embedding a form in a website with an iframe](publish.md#publlish-site), specify the URL with the configured GET parameters in the iframe embed code.