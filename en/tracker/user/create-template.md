# Creating a template

To create a template of an issue or comment:

1. {% if audience == "external" %} On the {{ tracker-name }}  top panel, click ![](../../_assets/tracker/tracker-settings.png) → **Manage templates**.{% else %}On the top panel in {{ tracker-name }}, click on your profile picture and choose **Personal settings**. Then click **Manage templates**.{% endif %}

1. Select an option:
    - **Issues** to create a template for issues.
    - **Comments** to create a template for comments.

1. Click **Create template**.

1. Enter a name and description for the template.

1. If you want the template to only be used in a specific queue, enter the queue in the **Queue binding** field.

1. Fill in the template parameters the same way as when creating a [new issue](create-ticket.md) or [comment](comments.md).

1. Click **Save**.

The new template will be available on the [template page]{% if audience == "external" %}({{ link-tracker-templates }}){% else %}({{ link-tracker-templates-ya }}){% endif %}.

{% if audience == "external" %}

[Contact support](../troubleshooting.md)

{% endif %}

