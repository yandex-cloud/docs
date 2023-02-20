---
title: "Organizations in {{ datalens-full-name }}"
description: "Organization is a {{ yandex-cloud }} service that helps manage your employee list, set up single sign-on to {{ yandex-cloud }} services, and assign roles. {{ datalens-full-name }} is now created at the organization level, which makes interfacing with other {{ yandex-cloud }} services easier."
---

# Organizations in {{ datalens-full-name }}

[{{ org-full-name }}](https://cloud.yandex.com/services/organization) is a {{ yandex-cloud }} service that helps manage your employee list, set up single sign-on to {{ yandex-cloud }} services, and assign roles. Read more about {{ org-name }} in the [documentation](../../organization/).

Usually, each {{ yandex-cloud }} user has at least one organization. If you aren't registered in {{ yandex-cloud }} and it's the first time you open {{ datalens-short-name }}, an organization is created for you automatically. All users at the organization level by default have access to [{{ datalens-full-name }}]({{ link-datalens-main }}), [{{ tracker-full-name }}]({{ link-tracker }}), [{{ wiki-full-name }}]({{ link-wiki }}), and [{{ forms-full-name }}]({{ link-forms-b2b }}).

If you do not use any other {{ yandex-cloud }} services except {{ datalens-short-name }}, you only need to have an organization and activate {{ datalens-short-name }}. You can create a cloud if necessary. For example, when you need managed database. At the same time, {{ datalens-short-name }} will have access to the managed databases located in the folders of the cloud connected to the organization.

{% note info %}

Before organizations were introduced, {{ datalens-short-name }} instances were created within folders of a single cloud. If you're using {{ datalens-short-name }} inside a folder, your instance should be [migrated to the organization level](#migration).

{% endnote %}

## Limitations {#restrictions}

* To use {{ datalens-short-name }} within an organization, a user must have the `{{ roles-datalens-creator }}` role for the organization. For more information about roles, see [Roles](../../iam/concepts/access-control/roles.md).
* You can only create new instances of {{ datalens-short-name }} at the organization level. Creating a {{ datalens-short-name }} instance in an existing cloud without an organization is no longer supported. You must first create an organization, and then create {{ datalens-short-name }}.
* An organization can only have a single instance of {{ datalens-short-name }}. If you have a cloud with a previously created instance of {{ datalens-short-name }} in a folder of this cloud, you will no longer be able to create {{ datalens-short-name }} at the organization level when you create an organization and bind your cloud to it. If this is the case, then to use {{ datalens-short-name }}, you will need to select **No organization** mode and then the cloud folder that already contains a {{ datalens-short-name }} instance. For more information, see [{#T}](../operations/organizations/change-organization.md).
* To create {{ datalens-short-name }} in an organization, you will require the `admin` or `owner` roles for it.
* At this time, technical support requests do not support organizations, therefore:

  * To create a technical support ticket, you need to have a cloud. If you only have an organization, a cloud will be created automatically when you create a ticket. The functionality for creating support tickets from an organization without creating a cloud will be added later.
  * For now, technical support plans can only be linked to a cloud and not an organization. If you have several clouds bound to your organization, and each has a different technical support plan, select the cloud with the highest rate when you create your support ticket. This will provide the most robust technical support available to you.

## Migrating an instance from folders to the organization level {#migration}

If you started using {{ datalens-short-name }} before the organizations feature was added, its instances are stored in folders within one cloud. It's more convenient to store them at the organization level: there may be multiple clouds in one organization and it's easier to interact with other {{ yandex-cloud }} services through organizations. For example, you can also use [{{ tracker-full-name }}]({{ link-tracker }}), [{{ wiki-full-name }}]({{ link-wiki }}), and [{{ forms-full-name }}]({{ link-forms-b2b }}).

Since {{ datalens-short-name }} is no longer supported in cloud folders, to make sure your data is not lost, carry out migration from the cloud folder to the organization level.

You can only migrate a single {{ datalens-short-name }} instance. Go to the folder with the most up-to-date instance and proceed to its migration:

1. In the left panel, open the [service settings](https://datalens.yandex.com/settings).
1. Under **Migrating from the folder to the organization**, click **Start migration**.
1. The {{ yandex-cloud }} cloud and folder are displayed in the top-left corner. Check that you opened the folder with the {{ datalens-short-name }} instance you want to migrate to the organization level.
1. Confirm your decision by clicking **Start migration**.
1. Wait for the migration to complete.

{{ datalens-short-name }} is now available at the organization level.


#### See also {#see-also}

* [{#T}](../operations/organizations/change-organization.md)

