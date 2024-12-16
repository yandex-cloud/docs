---
title: Organizations in {{ datalens-full-name }}
description: An organization is a {{ yandex-cloud }} service enabling employee list management, single sign-on across {{ yandex-cloud }} services, and roles. {{ datalens-full-name }} is now created at the organization level, which makes interfacing with other {{ yandex-cloud }} services easier.
---

# Organizations in {{ datalens-full-name }}

[{{ org-full-name }}](/services/organization) is a {{ yandex-cloud }} service enabling employee list management, single sign-on across {{ yandex-cloud }} services, and roles. If you want to learn more about {{ org-name }}, see [our relevant documentation](../../organization/).

As a rule, each {{ yandex-cloud }} user has at least one organization. If you do not have a {{ yandex-cloud }} account yet and it is your first time opening {{ datalens-short-name }}, the system will automatically create an organization for you. By default, all users at the organization level have access to [{{ datalens-full-name }}]({{ link-datalens-main }}), [{{ tracker-full-name }}]({{ link-tracker }}), [{{ wiki-full-name }}]({{ link-wiki }}), and [{{ forms-full-name }}]({{ link-forms-b2b }}).

If you do not use any other {{ yandex-cloud }} services except {{ datalens-short-name }}, you only need to have an organization and activate {{ datalens-short-name }}. You can also create a cloud, if required, e.g., when you need a managed database. In this case, {{ datalens-short-name }} will have access to the managed databases located in the folders of the cloud connected to the organization.

## Limitations {#restrictions}

* To use {{ datalens-short-name }} within an organization, a user must have the `{{ roles-datalens-visitor }}` role for the organization. To learn more about roles, see [Roles](../../iam/concepts/access-control/roles.md).
* You can only create new {{ datalens-short-name }} instances at the organization level. Creating a {{ datalens-short-name }} instance in an existing cloud without an organization is no longer supported. You must first create an organization, and then create {{ datalens-short-name }} within it.
* An organization can only have a single {{ datalens-short-name }} instance.
* To create {{ datalens-short-name }} in an organization, you need the `admin` or `owner` role for that organization.
* Currently, technical support requests do not support organizations, therefore:

  * To create a technical support ticket, you need to have a cloud. If you only have an organization, a cloud will be created automatically when you create a ticket. Moving forward, we will add the feature to create support tickets from an organization without creating a cloud.
  * Currently, technical support plans can only be linked to a cloud rather than an organization. If you have multiple clouds linked to your organization, and each has a different technical support plan, select the cloud with the highest rate when you create your support ticket. This will provide you with the best technical support available.


#### See also {#see-also}

* [{#T}](../operations/organizations/change-organization.md)

