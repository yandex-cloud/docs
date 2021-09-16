# Cities and countries

In this block, the user can select cities or countries. For example, they can specify the city where they live.

Suggestions are available from the city and country directory.

![](../../_assets/forms/tutorial-cities.gif)

## Block settings {#sec_settings}

### Question {#question}

Enter the field name or the prompt.

{% include [question](../../_includes/forms/question.md) %}

### Responses {#answer}

In the **Responses** section, select which type to use in this block: **Cities** or **Countries**.

To limit response options to a set list of countries:

1. Turn on **Limit list of countries**.

1. In the **Select countries** field, specify one or more countries.

For example, you can limit response options if you use a form to accept mail orders but can only deliver within Russia. In that case, select **Cities**, limit the list of countries, and specify Russia.

{% include [id-required-hidden](../../_includes/forms/id-required-hidden.md) %}

### Multiple choice{#multi}

Turn this on to allow users to select multiple cities or countries, like to specify multiple countries that they visited.

{% if audience == "internal" %}

{% include [validate-blockrefs](../../_includes/forms/validate-blockrefs.md) %}

{% endif %}

