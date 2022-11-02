# Yandex Metrica tag

[Yandex Metrica]({{ link-metrika }}) is a web analytics tool that enables you to receive reports on your site traffic and user actions on its pages. Read more about the features of the service in [Yandex Metrica documentation]({{ support-metrica }}).

You can add Yandex&#160;Metrica tags to your [Wiki pages](pages-types.md#page)  to collect statistics about sessions on the pages.



## Creating tags {#create-counter}



1. On the [Yandex Metrica]({{ link-metrika }}) home page, click **Add tag**.

1. Fill out the fields:
    * **Tag name**. If the name is omitted, the value in the **URL** field is used.
    * **URL**. The URL of the Wiki page you want to analyze.

For more information about tag settings, see [Yandex Metrica documentation]({{ support-metrica-cr-counter }}#counter-html__general).

1. Accept the terms of the user agreement, then click **Create tag**.

1. To display a widget with traffic statistics on your Wiki page, under **Additional settings**, select **Informer**.

## Add a tag to {{ wiki-name }} {#add-counter}

Paste the tag code in the Wiki pages that you want to track the traffic of:

1. [Copy HTML-code]({{ support-metrica-qs }}#install-code) from the tag settings page.

1. Switch to editing the Wiki page.

1. Paste the tag code in the Wiki page.

## Get statistics {#get-statistics}

* You can see summarized traffic statistics for your page at [**My tags]({{ link-metrika }}/list/)**.

* To open a detailed report, on the **My tags** page click the name of your tag. You can [customize]({{ support-metrica-report-general }}) the layout and data in the report.

* If you added an [informer]({{ support-metrica-count-general }}#other) when creating a page, statistics will also be displayed on your page as a widget.

{% note info %}

A tag on your Wiki page starts running as soon as you add it, but the statistics might be delayed by a couple of hours.

{% endnote %}

