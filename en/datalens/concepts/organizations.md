---
title: "Organizations in {{ datalens-full-name }}"
description: "Organization is a {{ yandex-cloud }} service that helps manage your employee list, set up single sign-on to {{ yandex-cloud }} services, and assign roles. {{ datalens-full-name }} is now created at the organization level, which makes interfacing with other {{ yandex-cloud }} services easier."
---

# Organizations in {{ datalens-full-name }}

[{{ org-full-name }}](https://cloud.yandex.com/services/organization) is a {{ yandex-cloud }} service that helps manage your employee list, set up single sign-on to {{ yandex-cloud }} services, and assign roles. Read more about {{ org-name }} in the [documentation](../../organization/).

The first time you log in to {{ datalens-short-name }}, an organization will be created for you with {{ datalens-short-name }} activated. If you have previously used {{ datalens-short-name }} in a cloud inside a folder, {{ datalens-short-name }} will continue as before.

The ability to migrate {{ datalens-short-name }} from a folder in a cloud to the organization level will be added later.

The difference between an organization and a cloud is that an organization may include several clouds. Also, all users at the organization level by default have access to [{{ datalens-full-name }}]({{ link-datalens-main }}), [{{ tracker-full-name }}]({{ link-tracker }}), [{{ wiki-full-name }}]({{ link-wiki }}), and [{{ forms-full-name }}]({{ link-forms-b2b }}).

With {{ org-name }}, a {{ datalens-short-name }} instance is created at the organization level, which makes interfacing with other {{ yandex-cloud }} services easier. Now, when switching between services on the {{ yandex-cloud }} platform, you no longer need to change folders.

If you do not use any other {{ yandex-cloud }} services except {{ datalens-short-name }}, you only need to have an organization and activate {{ datalens-short-name }}. You can create a cloud if necessary. For example, when you need managed database. At the same time, {{ datalens-short-name }} will have access to the managed databases located in the folders of the cloud connected to the organization.

{% note info %}

In terms of functionality, there is no difference between {{ datalens-short-name }} in a folder and {{ datalens-short-name }} at the organization level. The only difference is the location where you create {{ datalens-short-name }}.

{% endnote %}

## Limitations {#restrictions}

* To use {{ datalens-short-name }} within an organization, a user must have the `{{ roles-datalens-creator }}` role for the organization. For more information about roles, see [Roles](../../iam/concepts/access-control/roles.md).
* You can only create new instances of {{ datalens-short-name }} at the organization level. Creating a {{ datalens-short-name }} instance in an existing cloud without an organization is no longer supported. You must first create an organization, and then create {{ datalens-short-name }}.
* An organization can only have a single instance of {{ datalens-short-name }}. If you have a cloud with a previously created instance of {{ datalens-short-name }} in a folder of this cloud, you will no longer be able to create {{ datalens-short-name }} at the organization level when you create an organization and bind your cloud to it. If this is the case, then to use {{ datalens-short-name }}, you will need to select **No organization** mode and then the cloud folder that already contains a {{ datalens-short-name }} instance. For more information, see [{#T}](../operations/organizations/change-organization.md).
* To create {{ datalens-short-name }} in an organization, you will require the `admin` or `owner` roles for it.
* At this time, technical support requests do not support organizations, therefore:

  * To create a technical support ticket, you need to have a cloud. If you only have an organization, a cloud will be created automatically when you create a ticket. The functionality for creating support tickets from an organization without creating a cloud will be added later.
  * For now, technical support plans can only be linked to a cloud and not an organization. If you have several clouds bound to your organization, and each has a different technical support plan, select the cloud with the highest rate when you create your support ticket. This will provide the most robust technical support available to you.


#### See also {#see-also}

* [{#T}](../operations/organizations/change-organization.md)

