# Create a status

{% if audience == "external" %}

{% note warning %}

Only the company admin can create new issue statuses.

{% endnote %}

{% endif %}

A status is an issue attribute that reflects the current state of the issue completion process. For example: <q>Open</q>, <q>In progress</q>, <q>Testing</q>, or <q>Closed</q>.

The most popular issue statuses are available in {{ tracker-name }} by default. If you need something different, create a new one:

1. Make sure that you are logged in as the admin.

1. Select ![](../../_assets/tracker/icon-settings.png) → **{{ tracker-name }} settings** on the top panel in {{ tracker-name }}.

1. Go to the **Issue statuses** tab.

1. Click **Create status**.

1. Fill in the fields and click **Create**.

{% if audience == "external" %}

[Contact support](../troubleshooting.md)

{% endif %}

