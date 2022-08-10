# How to choose a version {{ forms-full-name }}

{% if audience == "external" %}

{{ forms-full-name }} can be used for personal matters, for example, to interview friends and make a menu for a New Year's party. Or you can use forms for business, for example, to accept orders for your online store.

- To create [a personal form](personal-forms.md), go to [{{ link-forms-admin }}]({{ link-forms-admin }}) and [log in to your Yandex account]({{ link-passport }}).

- To create [a form for business](forms-for-org.md), go to [{{ link-forms-b2b }}]({{ link-forms-b2b }}) and [log in to the organization employee's account](login.md).

To switch between personal forms and forms for business, go to {{ forms-full-name }} and click **Personal forms** or **Forms for business** in the upper-right corner of the page.

{% else %}

There are three admin panels {{ forms-full-name }}. To create a form, select the admin panel that best matches your target audience:

- If you're creating a form for external users (for example, a feedback form for a service) use the [{{ link-forms-ext-ya }}]({{ link-forms-ext-ya }}) external admin panel.

  This form will be available on the `forms.yandex.ru` domain for all users.

- If you're creating a form for Yandex employees, use the internal admin panel [{{ link-forms-admin-ya }}]({{ link-forms-admin-ya }}).

  The form will be available on the `forms.yandex-team.ru` domain only for Yandex employees.
 Forms created in this admin panel can be used for anonymous surveys. To do that, [publish the form using an anonymous link](publish.md#section_link).

- If you want to create a form for personal purposes, use the admin panel for external users [{{ link-forms-admin }}]({{ link-forms-admin }}).

  The form will be available on the `forms.yandex.ru` domain for all users. You can learn more about {{ forms-full-name }} for external users in the [{{ yandex-cloud }} documentation](https://cloud.yandex.ru/docs/forms/).

{% endif %}

