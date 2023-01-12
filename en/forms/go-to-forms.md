# How to choose a version of {{ forms-full-name }}

{% if audience == "external" %}

You can use {{ forms-full-name }} in personal matters, for example, to conduct a survey for your friends and make a menu for a New Year's party. You can also use forms for business, such as to accept orders for your online store.

- To create a [personal form](personal-forms.md) go to the [{{ link-forms-admin }}]({{ link-forms-admin }}) page and [log in to your Yandex account]({{ link-passport }}).

- To create a [form for business](forms-for-org.md), go to the [{{ link-forms-b2b }}]({{ link-forms-b2b }}) page and [log in using the organization's employee account](login.md).

To switch between personal forms and forms for business, click **To personal forms** or **To forms for business** at the top right of the page in {{ forms-full-name }}.

{% else %}

There are three {{ forms-full-name }} admin panels. To create a form, select the appropriate admin panel depending on your survey target audience:

- If you're creating a form for external users, such as a feedback form for a service, use the external [{{ link-forms-ext }}]({{ link-forms-ext }}) admin panel.

   This form will be available to any user on the `forms.yandex.ru` domain.

- If you're creating a form for Yandex employees, use the internal [{{ link-forms-admin }}]({{ link-forms-admin }}) admin panel.

   This form will only be available to Yandex employees on the `forms.yandex-team.ru` domain. Forms created in this admin panel can be used to conduct an anonymous poll. To do this, [publish your form via an anonymous link](publish.md#section_link).

- You can create a form for personal use in the [{{ link-forms-admin }}]({{ link-forms-admin }}) admin panel for external users.

   This form will be available to any user on the `forms.yandex.ru` domain. For more information about {{ forms-full-name }} for external users, see the [{{ yandex-cloud }} documentation](https://cloud.yandex.ru/docs/forms/).

{% endif %}