### How do I set up links between selectors? {#how-to-configure-link-between-selectors}

To set up links:
1. Go to the dashboard creation page.
1. On the top panel, click ![gear](../../_assets/monitoring/gear.svg).
1. Check that the **Dependent selectors** option is enabled. If the option is disabled, enable it.
   Please note that once this option is enabled, you cannot disable it.

Links between selectors or charts are set up using the **Links** button in the dashboard edit section.

The link between selectors based on the same dataset is established automatically and doesn't require additional configuration.

{% note warning %}

Before creating a link, make sure that the field used by the selector as a filter is included in the dataset the chart is built from. For more information, see [{#T}](../../datalens/concepts/data-join.md).

{% endnote %}
