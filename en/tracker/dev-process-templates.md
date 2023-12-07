# Configuring issue templates

You can use [templates](user/ticket-template.md) to make it easier to create common issue types, such as bug fixing or testing-related issues. In the template, you can specify the issue parameters that are known in advance and add tips for issue description so that the users don't forget to specify the required information.

To create an issue template for your queue and allow team members to use it:

1. In the panel on the left, click ![](../_assets/tracker/svg/settings.svg) **{{ ui-key.yacloud.settings.label_settings }}**. Then select ![](../_assets/tracker/svg/interface.svg)&nbsp;**{{ ui-key.startrek.ui_components_NavigationBar.appearance-title }}** and click **{{ ui-key.startrek.ui_components_NavigationBar.templates-settings }}**. You can also follow the link [{{ link-tracker-templates }}]({{ link-tracker-templates }}).

1. Select the **{{ ui-key.startrek.ui_components_NavigationBar.issue-lists-menu-item }}** option and click **{{ ui-key.startrek.ui_components_issue-comments-templates.create-template-item }}**.

1. Set the template's name and description.

1. If you want the template to only be used in your own queue, enter the name or key of the queue in the **Queue binding field**. In this case, the team members in the queue will automatically gain read-only access to the template.

1. Fill out the fields of the template and save it. The field values that you enter will automatically populate the issues created from the template.

1. To configure template access, click **Access control** next to the template and add the desired groups or users.

1. To make sure that your team members can use your template to create issues:

   - Employees need to have read access to the template.

   - Employees need to add the template. To do this, go to the template management page and switch on the desired template.

If you need an issue template available to all users by default, [set up an issue creation form](manager/forms-integration.md) in {{ forms-full-name }}. You can use the created [form instead of the standard issue creation page](manager/attach-form.md) in your queue.

