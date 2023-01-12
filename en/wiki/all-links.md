# Viewing all links to a page

You can view a list of all pages that refer to a Wiki page.

This feature helps you get your page ready for deletion: find and delete all links to it first.

1. Open the page.

1. In the upper-right corner of the page, click ![](../_assets/wiki/svg/actions-icon.svg) **Actions** and select ![](../_assets/wiki/svg/delete-page.svg) **Delete**.

1. Wait a few seconds for the data to load.

{% note warning %}

This method won't find links leading to [anchors](static-markup/links#section-link) on the page. {% if audience == "internal" %}Likewise, it won't find pages that this page is embedded into using the [`include` dynamic block](actions/include).{% endif %}

{% endnote %}