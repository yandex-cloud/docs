# Creating an issue in {{ tracker-full-name }}


{% note warning %}

Integration with {{ tracker-short-name }} can be configured by users of [{{ forms-full-name }} for business](forms-for-org.md).

{% endnote %}


You can integrate your form with [{{ tracker-short-name }}]({{ link-tracker }}) to automatically create issues when users submit responses. User responses are sent from the form to {{ tracker-short-name }}, where an issue is created based on them. For example, these forms are useful for accepting service requests or collecting error messages. To learn more about issue, see [Help {{ tracker-full-name }}](../tracker/user/create-ticket.md).

## Set up issue creation in {{ tracker-short-name }} {#setup}

1. Select the form and open the **Integration** tab.

1. Select a [group of actions](notifications.md#add-integration) for which you want to create an issue and click ![](../_assets/forms/tracker-notification-new.png) **{{ tracker-short-name }}** at the bottom of the group.

1. Enter the [queue](../tracker/queue-intro.md) key to create your issue in.

1. To create a [sub-issue](../tracker/user/create-ticket.md#subtask), enable **Convert to sub-issue** and enter the parent issue key.

   <!--{% note info %}
   
    In this case, the task from the form is created in the same queue as the parent task.

    {% endnote %}
    -->
1. Set up the type, issue priority and other parameters.

   **Format of data input**. No suggestions appear when entering values in the fields such as **Reporter**, **Assignee**, **Tags**, or **Components**.

   - Specify a username in the **Reporter**, **Assignee**, and **Followers** fields.
      To enter multiple usernames in the **Followers** field, separate them with commas (for example, `smith,johnson`).

   - Enter the values of the other fields exactly as they are specified in {{ tracker-short-name }}.

   - To add multiple values to the **Components** or **Tags** field, separate them with commas.

   **Adding issue fields**. You can also create a new field if the one you need isn't available in the issue parameters. Click **Add task parameter** and start typing its name. In the suggestion that appears, select the appropriate parameter.<!-- --> To learn more about issue parameters, see [Help {{ tracker-full-name }}](../tracker/user/create-param.md).


   **Add form data to a field**. You can insert a response to a prompt or other form data in issue fields:

   - Select the field and click **Variables** button to the right.

   - Select a [variable](vars.md) from the list to add to the field.

   {% note warning %}

   You can add the employee who's specified in a response to the <q>People</q>, to the **Reporter**, **Assignee**, and **Followers** fields in Tracker. To do so, add a **Response ID** variable to the field. If you use a **Response to prompt** variable, integration won't work.

   {% endnote %}

   For example, if you collect error messages through a form, you can add a user's message and technical details to the issue description.

   ![](../_assets/forms/tracker-var-example-new.png)

1. For the user to get a link to the created issue after filling out the form, enable the **Show messages about the results of actions** option under the action name.

1. Click **Save**.

To create multiple issues at once, add new actions by clicking ![](../_assets/forms/tracker-notification-new.png) **{{ tracker-short-name }}** at the bottom of the page.

If you want an issue to only be created for users who give certain responses, [set your conditions](notifications.md#section_xlw_rjc_tbb).

> Example of integration with {{ tracker-short-name }} for a request form for buying equipment. Employees can use this form to make equipment requests as tasks for the purchasing department.
>
> ![](../_assets/forms/tracker-example-new.png)


## Troubleshooting {#troubles}

If issues aren't created in {{ tracker-short-name }} or if they're created incorrectly after the form is filled out, check for integration errors:

1. Open the form where you couldn't create an issue and click **Integration** at the top of the page.

1. Check for an error message in the {{ tracker-short-name }} integration settings.

1. Check if a solution to your problem is provided below. After resolving the problem, try [creating an issue again](notifications.md#status).

1. If the problem persists, [contact support](feedback.md).

### Error in the Reporter, Assignee, and Follower fields

The error may be caused by invalid data being sent from the form to the **Reporter**, **Assignee**, or **Followers** issue field. Fill in these fields in the following way:

- To add an employee manually, enter a username like `smith`.

- To enter multiple usernames in the **Followers** field, separate them with commas (for example, `smith,johnson`).

- To add the employee who's specified in a response to the <q>People</q>,, insert a **Response ID** [variable](vars.md) in the field. If you use a **Response to prompt** variable, integration won't work.

- To add the employee who's specified in a response to the <q>Drop-down list</q> or <q>Multiple answers</q> prompt, set usernames (such as `smith`) as response options and use the **Response to prompt** [variable](vars.md).

If an error occurs in the **Reporter** field although it's filled in correctly, make sure the user who filled out the form is [allowed to create issues in the specified {{ tracker-short-name }} queue](#access).

### Error: No rights to add issues to queue {#access}

This error occurs because the user who filled out the form doesn't have the rights to create issues in the specified {{ tracker-short-name }} queue. Ask the queue owner to [check access rights](../tracker/manager/queue-access.md).


<!-- ### Error in the Type field This error may occur if you enabled the **Make subtask** option. When this option is on, a task from a form is always created in the same queue as the parent task. If this queue isn't the one in the **Queue** field, it may not contain the specified task type.

To resolve the issue, make sure the parent task in the **Make subtask** option is in the queue specified in the **Queue** field.-->

