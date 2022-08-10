# Variables in integration settings

When you set up integration of your form with other services, you can send responses or other data from the form to the service. For example, you can insert the user's responses into the text of an email or insert data into task fields in {{ tracker-short-name }}.

Use variables to do this:

1. On the **Integration** tab in your form, [add an action](notifications.md#add-integration).

1. Select a field and click the ![](../_assets/forms/add-var.png) icon on the right.

1. Select a variable from the list that you want to add.

1. If you're using <q>Prompt response</q>, <q>Response ID</q>, or other similar variables, then you can choose a [filter](#var-filters) for variable values if needed.

1. Click **Save**.

When data is sent to the service, the variable is automatically converted to a value — the response to a prompt, test result, or technical data.

{% note warning %}

When [integrating the form with {{ tracker-short-name }}](create-task.md), you can add an employee that's specified in a response to the <q>People</q>, prompt to the **Owner**, **Assignee**, or **Followers** fields in Tracker. To do so, add a **Response ID** variable to the field. If you use a **Response to prompt** variable, integration won't work.

{% endnote %}

> For example, this is the text of an email containing all the user's responses to the form prompts.
>
>![](../_assets/forms/variables-example-new.png)

## Filters {#var-filters}

If integration settings contain prompt responses added using variables, errors may occur if responses do not match the format required for integration. For example, if you add a response to the <q>Long text</q> prompt to the HTTP request body and this response contains line breaks, the integration won't work.

To avoid data format errors, use the following filters for variables:

* **Sanitize string**: removes special characters from the text of a response.

* **JSON**: converts the response text to a JSON-compatible format.


## Variable guide {#section_wqx_1j2_p2b}

You can use the following variables in action settings:

| Variable | Description |
| ----- | ----- |
| **User data** | Personal data of the user who filled out the form<br/><br/><br/>Variables from this group are only converted to the user's personal data if the form is created in [{{ forms-full-name }} for business](forms-for-org.md) and the user who filled out the form is an employee of the organization. You can only get data from external users if they provide their data in response to the form prompts. |
| Name | The user's name |
| Login | The user's login |
| Email | The user's email |
| Gender | The user's gender |
| Department | The employee's department (for users of [{{ forms-full-name }} for business](forms-for-org.md)) |
| Phone | The employee's work phone number (for users of [{{ forms-full-name }} for business](forms-for-org.md)) |
| Supervisor | The employee's direct supervisor (for users of [{{ forms-full-name }} for business](forms-for-org.md)) |
| Team | Teams the employee is a member of (for users of [{{ forms-full-name }} for business](forms-for-org.md)) |
| **Data from the organization** | Information from the organization's address book in [{{ org-full-name }}]({{ link-org-main }}) |
| User information | A field from the card of the employee that filled out the form |
| Information from a response to a prompt | For the **People**, **Departments**, and **Teams** is a field from the card of an employee or department specified in the response.  |
| **Test results** | The user's result in a [test or quiz](tests.md) |
| Maximum test points | The maximum number of points that can be scored in the test |
| Total prompts with points | The number of prompts for which the user can get points |
| Points scored | The number of points scored by the user |
| Test results heading | [The heading of a segment](tests.md#test-result) the user's results fit in |
| Description of test results | [The description of a segment](tests.md#test-result) the user's results fit in |
| Points scored for a prompt | The number of points scored for a selected prompt |
| **Form** | The form parameters and prompt responses |
| Form ID | A unique form ID |
| Name | Form name |
| Prompt response | A user response to a specific prompt in the form — select a prompt |
| Responses to prompts | User responses to multiple prompts in the form — select prompts |
| Response ID | A unique ID of a completed form |
| Prompt response option ID | The unique ID of a response option for multiple-choice prompts (such as <q>People</q> or <q>Drop-down list</q>).  |
| Response date | The date when the form was filled out |
| Form author's email | The email of the user who created the form |
| **Browser** | Information about the user's browser and operating system |
| OS family | Operating system type |
| OS name | Operating system name |
| OS version | Operating system version |
| Browser name | Name |
| Browser version | Version |
| **Request** | Technical parameters of the HTTP session |
| Host | User's computer name |
| URL | Form address |
| All GET parameters | The values of all the request parameters.<br/><br/>Learn more about how to [use GET parameters to pre-fill a form](get-params.md). |
| GET parameter | The value of a specific request parameter — specify the parameter name.<br/><br/>Learn more about how to [use GET parameters to pre-fill a form](get-params.md). |
