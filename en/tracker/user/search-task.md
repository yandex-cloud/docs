# Searching for issues by key or name

If you know the name of an issue or its key, you can search for it using the {% if audience == "internal" %}search box on the top panel in the {{ tracker-name }}{% else %}query language{% endif %}.

{% list tabs %}

- Web interface

    {% if audience == "internal" %}

    In the upper-right corner, enter the issue key in the search box and press **Enter**. {{ tracker-name }} makes a simple query that will return all the relevant issues. To get more precise results, [use the query language](query-filter.md#query-text).

    {% else %}

    To find issues by their key or name, use the following [query language](query-filter.md) parameters:
    * `Key:` to search for an issue by the exact key value.
    * `Summary:` to search for an issue by [name](query-filter.md#query-text).

    {% endif %}

- Mobile app

    At the top of the screen, enter the issue name or key in the **Search by all issues** field. As a result, you'll see a list with the issues that meet the query criteria. The list shows the first 20 entries. If you didn't find the issue you need, refine your query.

{% endlist %}

