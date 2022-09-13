{% list tabs %}

- Cloud Organization

   1. [Log in to an account]({{ link-passport-login }}) that belongs to an organization administrator or owner.
   1. Go to [{{ org-full-name }}]({{ link-org-main }}).
   1. In the left-hand panel, select [Users]({{ link-org-users }}) ![icon-users](../../_assets/organization/icon-users.svg).
   1. In the top right-hand corner, click {% if product == "yandex-cloud" %}**Add user**{% endif %}{% if product == "cloud-il" %}**Invite users**{% endif %}.
   1. Enter the email addresses of the {% if product == "yandex-cloud" %}Yandex{% endif %}{% if product == "cloud-il" %}Google{% endif %} users you want to invite to the organization (such as, `{{ login-example }}`).
{% if product == "cloud-il" %}
   1. Select the invite expiration.
{% endif %}
   1. Click {% if product == "yandex-cloud" %}**Add**{% endif %}{% if product == "cloud-il" %}**Send invite**{% endif %}.

{% if product == "yandex-cloud" %}

    To access the [services](../../organization/manage-services.md#collaboration) enabled for the organization, invited users just need to log in to their Yandex account.

{% endif %}

{% if product == "cloud-il" %}

    To join an organization, invited users must:

    1. Click the invitation link and accept the invitation.
    1. Log in to the organization.

{% endif %}

{% endlist %}