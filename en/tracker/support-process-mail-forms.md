# Accept requests  via forms

User requests are converted to {{ tracker-name }} issues before they are processed. Most users tend to send their requests  a website. In any case, users outside your organization and don't have access to {{ tracker-name }}.

This is why we recommend setting up your request processing pipeline in a way that lets you receive requests  forms created in [Yandex.Forms]({{ link-forms }}).


Accepting requests via forms is a better choice if you want users to provide specific data. Your forms may include a list of required and optional questions, and the answers may be saved in the issue parameters in {{ tracker-name }}.

1. Go to [Yandex.Forms]({{ link-forms }}) and create a new form.

1. Add questions that let users provide relevant information necessary to register their request.

2. Set up [{{ tracker-name }} integration]({{ support-forms-tracker }}) for the form:

    1. Specify your queue and other issue parameters.

    2. Use the **Issue description** field to add answers to the questions included in your form.

    3. If you want to save a specific answer in your issue parameters, add an issue field, click **Variables** → **Answer**, and choose the corresponding question.

    4. Save your integration settings.

3. [Publish]({{ support-forms-publish }}) your form: embed it in a website or provide a link.

