# Variables in integration settings

When you set up integration of your form with other services, you can send responses or other data from the form to the service. For example, you can insert the user's responses into the text of an email or insert data into task fields in {{ tracker-short-name }}.

Use variables to do this:

1. On the **Integration** tab in your form, [add an action](notifications.md#add-integration).

1. Select a field and click **Variables** on the right.

1. Select a variable from the list that you want to add.

When data is sent to the service, the variable is automatically converted to a value — the response to a prompt, a test result, or technical data.{% if audience == "internal" %} If necessary, you can set [filters to additionally transform variables](send-request.md#filters).{% endif %}

{% note warning %}

When [integrating the form with {{ tracker-short-name }}](create-task.md), you can add an employee that's specified in a response to the {% if audience == "external" %}<q>People</q>,{% else %}<q>Staff data</q>{% endif %} prompt to the **Owner**, **Assignee**, or **Followers** fields in Tracker. To do so, add a **Response ID** variable to the field. If you use a **Response to prompt** variable, integration won't work.

{% endnote %}

{% if audience == "draft" %} >For example, this is the text of an email containing all the user's responses to the form prompts.

>![](../_assets/forms/variables-example.png) {% endif %}

You can use the following variables in action settings:

| Variable | Description |
| ----- | ----- |
| **User data** | The personal data of the user who filled out the form<br/>{% if audience == "external" %}<br/><br/>Variables from this group are only converted to the user's personal data if the form is created in [{{ forms-full-name }} for business](forms-for-org.md) and the user who filled out the form is an employee of the organization. You can only get data from external users if they provide their data in response to the form prompts.{% endif %} |
| Name | The user's name |
| Login | The user's login |
{% if audience == "internal" %}| UID | The user's UID |{% endif %}
| Email | The user's email |
| {% if audience == "external" %}Gender | The user's gender{% endif %} |
| {% if audience == "external" %}Department | The employee's department (for users of [{{ forms-full-name }} for business](forms-for-org.md)){% endif %} |
| {% if audience == "external" %}Phone | The employee's work phone number (for users of [{{ forms-full-name }} for business](forms-for-org.md)){% endif %} |
| {% if audience == "external" %}Supervisor | The employee's direct supervisor (for users of [{{ forms-full-name }} for business](forms-for-org.md)){% endif %} |
| {% if audience == "external" %}Team | Teams the employee is a member of (for users of [{{ forms-full-name }} for business](forms-for-org.md)){% endif %} |
| {% if audience == "external" %}**Data from the organization** | Information from the organization's address book in [{{ org-full-name }}]({{ link-org-main }}){% else %}**Staff data** | Information from the employee directory{% endif %} |
| User information | A field from the card of the employee that filled out the form |
| Information from a response to a prompt | For the {% if audience == "external" %}**People**, **Departments**, and **Teams**{% else %} question types, **Staff data**{% endif %} is a field from the card of an employee or department specified in the response. {% if audience == "internal" %}If the response contains the user's login, you can also use the variable for other question types.{% endif %} |
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
| Response option ID | The unique ID of a response option for multiple-choice prompts (such as <q>People</q> or <q>Drop-down list</q>). {% if audience == "internal" %}Response IDs can only be viewed in the [old admin panel {{ forms-name }}](https://admin-int.forms.yandex-team.ru/?force_old).{% endif %} |
| Response date | The date when the form was filled out |
| Form author's email | The email of the user who created the form |
{% if audience == "internal" %}| Validation status | Status value for [external validation](https://doc.yandex-team.ru/forms/external/validation.html) |{% endif %}
{% if audience == "internal" %}| **Geobase** | Information about the user's geographical location |{% endif %}
{% if audience == "internal" %}| Region code | The user's region code |{% endif %}
{% if audience == "internal" %}| Region name | The user's region |{% endif %}
| **Browser** | Information about the user's browser and operating system |
{% if audience == "internal" %}| All data | All available browser parameters |{% endif %}
| OS family | Operating system type |
| OS name | Operating system name |
| OS version | Operating system version |
| Browser name | Name |
| Browser version | Version |
{% if audience == "internal" %}| Engine | Browser engine |{% endif %}
| **Request** | Technical parameters of the HTTP session |
{% if audience == "internal" %}| IP address | The IP address of the user's computer |{% endif %}
| Host | User's computer name |
| URL | Form address |
{% if audience == "internal" %}| All headings | The values of all request headings |{% endif %}
{% if audience == "internal" %}| Heading | The value of a specific request parameter — specify the heading name |{% endif %}
| All GET parameters | The values of all the request parameters.<br/><br/>Learn more about how to [use GET parameters to pre-fill a form](get-params.md). |
| GET parameter | The value of a specific request parameter — specify the parameter name.<br/><br/>Learn more about how to [use GET parameters to pre-fill a form](get-params.md). |
{% if audience == "internal" %}| All cookies | The values of all cookies in the request |{% endif %}
{% if audience == "internal" %}| Cookie | The value of a specific cookie — specify the name of the cookie |{% endif %}
{% if audience == "internal" %}| **Session**<br/>Referer | The address of the page from which the user got to the form |{% endif %}

