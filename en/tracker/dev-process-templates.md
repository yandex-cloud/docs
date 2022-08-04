# Configuring issue templates

You can use [templates](user/ticket-template.md) to make it easier to create common issue types, such as bug fixing or testing-related issues. You can use templates to set predetermined issue parameters and add tips that remind users to specify the necessary information and help describe the issue in more detail.

To create an issue template for your queue and grant access rights to it for your team members, do the following:

1. On the top panel in {{ tracker-name }}, click {% if audience == "external" %}![](../_assets/tracker/tracker-settings.png) → **Manage templates**.{% else %}on your profile picture and select **Personal settings**. Then click **Manage templates**.{% endif %}

1. Choose **Issues** and click **Create template**.

1. Set the name and description for the template.

1. If you want the template to only be used in your own queue, enter the name or key of the queue in the **Queue binding** field. In this case, the team members in the queue will automatically gain read-only access to the template.

1. Fill in the template fields and save the template. The specified field values will be automatically filled in for the issues created using this template.

1. To configure template access, click **Access rights** next to the template and add the desired groups or users.

1. To let the members of your team use your template:

    - Make sure the employees have read-only access to the template.

    - They must then enable that template. To do this, go to the template management page and switch on the desired template.

If you need an issue template available to all users by default, [set up an issue creation form](manager/forms-integration.md) in {{ forms-full-name }}. You can use the created [form instead of the standard issue creation page](manager/attach-form.md) in your queue.

