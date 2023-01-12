# Yandex Metrica tags

[Yandex&#160;Metrica]({{ link-metrika }}) is a web analytics tool that lets you get reports on your website traffic and user actions performed on its pages. To learn more about the service features, see the [Yandex&#160;Metrica documentation]({{ support-metrica }}).

You can add Yandex&#160;Metrica tags to [Wiki pages](pages-types.md#page) to obtain statistics on their traffic.

{% if audience == "internal" %}

{% note info %}

Yandex&#160;Metrica tags can also be integrated with `{{ wiki-host-name }}` pages.

{% endnote %}

{% endif %}


## Creating a tag {#create-counter}

{% if audience == "internal" %}

1. Log in to your Yandex ID account (on the `yandex.ru` domain).

{% endif %}

1. Open the [Yandex&#160;Metrica]({{ link-metrika }}) homepage and click **Add tag**.

1. Complete the fields below:
   * **Tag name**. If omitted, the **Site address** field value is used.
   * **Site address**. URL of the Wiki page to be analyzed.
      For more information about tag settings, see the [documentation for Yandex&#160;Metrica]({{ support-metrica-cr-counter }}#counter-html__general).

1. Accept the terms of the User Agreement and click **Create tag**.

1. To have a widget with statistics displayed on your Wiki page, open **Additional settings** and select **Informer**.

## Adding a tag to {{ wiki-name }}{#add-counter}

Embed the tag code in the Wiki pages you want to track traffic for:

1. [Copy the HTML code]({{ support-metrica-qs }}#install-code) from the tag settings page.

1. Proceed to editing the Wiki page.

1. Embed the tag code in the Wiki page.

## Get statistics {#get-statistics}

* You can see a summary of traffic statistics on the **[My tags]({{ link-metrika }}/list/)** page.

* To open a detailed report, click your tag's name on the **My tags** page. You can [customize]({{ support-metrica-report-general }}) the appearance and contents of the report.

* If you added the [informer]({{ support-metrica-count-general }}#other) when creating your tag, you can also see statistics as a widget on the Wiki page.

{% note info %}

The tag embedded in the Wiki page starts running immediately after you install it. However, the statistics may be displayed with a delay of a few hours.

{% endnote %}