# Viewing service usage details {{ ml-platform-name }}

You can get your usage data in {{ ml-platform-name }} itemized down to a project by building a dashboard in [{{ datalens-full-name }}](../../../datalens/). To do this:

1. Open or create a new instance on the [{{ datalens-name }} home page]({{ link-datalens-main }}).
1. Create a connection with the **Yandex Cloud Billing** connector type.
1. Enter a name for the connection and click **Create**.
1. Open **{{ yandex-cloud }} Billing Dashboard** and go to **Labels**.
1. Select:
   * **Usage date**: The dates that you need.
   * **Billing account name**: One or more payment accounts.
   * **Cloud name (ID)**: Leave this field empty.
   * **Label key**: You can specify several values at the same time.
      * `project_id`: Statistics on projects.
      * `resource_id`: Statistics on communities.
      * `label.user_labels`: Statistics on user [labels](../../../resource-manager/concepts/labels.md).

{% note warning %}

The itemized costs are available only for the projects launched after October 20, 2022.

{% endnote %}

In the resulting table **Costs by label value breakdown**, you will only see itemized costs by {{ ml-platform-name }} communities.

{% note info %}

In the itemized table, you could also see costs from other services, which aren't linked to your cloud ID, for example, from {{ tracker-full-name }}.

{% endnote %}