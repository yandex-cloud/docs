# Yandex.Metrica tags

[Yandex.Metrica]({{ link-metrika }}) is a web analytics tool you can use to generate traffic reports and analyze user behavior on your website. You can read more about the service and its features in [Yandex.Metrica documentation]({{ support-metrica }}).

You can use Yandex.Metrica tags to get statistics on page visits in {{ wiki-name }}.

{% if audience == "internal" %}

{% note info %}

Yandex.Metrica tracking tags also work on `{{ wiki-host-name }}`.

{% endnote %}

{% endif %}

## Create a tracking tag {#create-counter}

{% if audience == "internal" %}

1. Log in to your Yandex ID account (on the `yandex.ru` domain).

{% endif %}

1. Go to [Yandex.Metrica]({{ link-metrika }}) home page and click **Add tracking tag**.

1. Fill in the fields:
    * **Tag name**. If not specified, the value is taken from the **Website address** field.
    * **Website address**. The address of the Wiki page you want to analyze.
For more information on the tag settings, see [Yandex.Metrica documentation]({{ support-metrica-cr-counter }}#counter-html__general).

1. Accept the terms of the user agreement and click **Create tag**.

1. To display a widget with traffic statistics on the Wiki page, go to the **Additional settings** block and select **Informer**.

## Adding a tag to {{ wiki-name }} {#add-counter}

Embed the tag code on the Wiki pages where you want to track traffic:

1. [Copy HTML-code]({{ support-metrica-qs }}#install-code) from the tag settings page.

1. Switch to edit mode.

1. Paste the tag code into the Wiki page.

## Getting statistics {#get-statistics}

* You can view brief statistics for page visits in **[My Tags]({{ link-metrika }}/list/)**.

* To open a detailed report, go to **My tags** and click on the name of your tracking tag. The type and content of the report can be [customized]({{ support-metrica-report-general }}).

* If you added an [informer]({{ support-metrica-count-general }}#other) when creating the tracking tag, you'll have a widget with statistics displayed on the Wiki page.

{% note info %}

Traffic tracking on the Wiki page starts immediately after the tag is set up, but the displayed statistics may take several hours to update.

{% endnote %}

