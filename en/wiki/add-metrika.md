# Yandex Metrica tags

[Yandex&#160;Metrica]({{ link-metrika }}) is a web analytics tool that lets you get reports on your website traffic and user actions performed on its pages. To learn more about the service features, see the [Yandex&#160;Metrica documentation]({{ support-metrica }}).

You can add Yandex&#160;Metrica tags to pages created in the [old editor](pages-types.md#page) to obtain statistics on their traffic.



## Creating a tag {#create-counter}


1. Open the [Yandex&#160;Metrica]({{ link-metrika }}) homepage and click **Add tag**.

1. Fill out the fields below:
   * **Tag name**. If it is not specified, the **Site address** field value is used.
   * **Site address**. URL of the page to analyze.
      For more information about tag settings, see the [for Yandex&#160;Metrica documentation]({{ support-metrica-cr-counter }}#counter-html__general).

1. Accept the terms of the User Agreement and click **Create tag**.

1. To have a widget with statistics displayed on your page created in the old editor, open **Additional settings** and select **Informer**.

## Adding a tag to {{ wiki-name }}{#add-counter}

Embed the tag code in the pages you want to track traffic for:

1. [Copy the HTML code]({{ support-metrica-qs }}#install-code) from the tag settings page.

1. Proceed to editing the page.

1. Embed the tag code in the page.

## Get statistics {#get-statistics}

* You can see a summary of traffic statistics on the **[My tags]({{ link-metrika }}/list/)** page.

* To open a detailed report, click your tag's name on the **My tags** page. You can [customize]({{ support-metrica-report-general }}) the appearance and contents of the report.

* If you added an [informer]({{ support-metrica-count-general }}#other) when creating your tag, you can also see statistics as a widget on the page.

{% note info %}

The tag embedded in the page starts running immediately after you install it. However, the statistics may be displayed with a delay of a few hours.

{% endnote %}