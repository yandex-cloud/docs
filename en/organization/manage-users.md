# Managing user accounts

Use {{org-full-name}} to manage your employees' access to {{yandex-cloud}} services.

{% if product == "yandex-cloud" %}To provide your employees with access to the organization's services, [connect them using their {% if product == "yandex-cloud" %}Yandex{% endif %}{% if product == "cloud-il" %}Google{% endif %}](add-account.md) accounts. If your company already uses a different account management system (such as Active Directory or Google Workspace), [configure an identity federation](add-federation.md){% endif %}{% if product == "cloud-il" %}[Configure an identity federation](add-federation.md){% endif %}, so that your employees can use their work accounts to access {{yandex-cloud}} services.

In {{org-name}}, you can create an identity federation with any credential management service (identity provider) that supports the [SAML]({{link-saml}}) protocol.
{% if product == "yandex-cloud" %}

* {% if product == "yandex-cloud" %}[Add a Yandex user](add-account.md){% endif %}{% if product == "cloud-il" %}[Add a Google user](add-account.md){% endif %}.
{% endif %}
* [Configure an identity federation](add-federation.md).
* [Edit or delete an employee's account](edit-account.md).
