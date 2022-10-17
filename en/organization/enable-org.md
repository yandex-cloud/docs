# Creating an organization

To let your employees use {{ yandex-cloud }} services, create an organization and add them to it.{% if product == "yandex-cloud" %} Any Yandex user can create an organization in {{ org-full-name }}.{% endif %}

To create an organization, follow these steps:

1. [Log in]({{ link-passport }}) to your {% if product == "yandex-cloud" %}Yandex{% endif %}{% if product == "cloud-il" %}Google{% endif %} account.{% if product == "yandex-cloud" %} If you don't have an account, [create]({{ support-passport-create }}) one.{% endif %}

1. Go to [{{ org-full-name }}]({{ link-org-main }}).

1. Read the {{ yandex-cloud }} terms of use and click **Log in**.

1. Enter your company name and description.

1. Click **Create organization**.

After registering, you become the organization owner and can manage its settings.
{% if product == "yandex-cloud" %}

To get started:

- [Add](add-account.md) users with a {% if product == "yandex-cloud" %}Yandex{% endif %}{% if product == "cloud-il" %}Google{% endif %} account to the organization.
{% endif %}
{% if product == "yandex-cloud" %}- {% endif %}[Configure an identity federation](add-federation.md), so that your employees can log in to the organization using their work accounts.
