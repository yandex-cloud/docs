---
title: "Organizations in {{ datalens-full-name }}"
description: "Yandex Cloud Organization is a {{ yandex-cloud }} service that helps manage your employee list, set up single sign-on to {{ yandex-cloud }} services, and assign roles. {{ datalens-full-name }} is now created at the organization level, which makes interfacing with other {{ yandex-cloud }} services easier."
---

# Organizations in {{ datalens-full-name }}

[{{ org-full-name }}](/services/organization) is a {{ yandex-cloud }} service that helps manage your employee list, set up single sign-on to {{ yandex-cloud }} services, and assign roles. If you want to learn more about {{ org-name }}, see [our relevant documentation](../../organization/).

As a rule, each {{ yandex-cloud }} user has at least one organization. If you do not have a {{ yandex-cloud }} account yet and it is your first time opening {{ datalens-short-name }}, the system will automatically create an organization for you. By default, all users at the organization level have access to [{{ datalens-full-name }}]({{ link-datalens-main }}), [{{ tracker-full-name }}]({{ link-tracker }}), [{{ wiki-full-name }}]({{ link-wiki }}), and [{{ forms-full-name }}]({{ link-forms-b2b }}).

If you do not use any other {{ yandex-cloud }} services except {{ datalens-short-name }}, you only need to have an organization and activate {{ datalens-short-name }}. You can also create a cloud, if required, e.g., when you need a managed database. In this case, {{ datalens-short-name }} will have access to the managed databases located in the folders of the cloud connected to the organization.

{% note info %}

Before organizations were introduced, {{ datalens-short-name }} instances were created within folders of a single cloud. If you are using {{ datalens-short-name }} inside a folder, you need to [migrate your instance to the organization level](#migration).

{% endnote %}

## Limitations {#restrictions}

* To use {{ datalens-short-name }} within an organization, a user must have the `{{ roles-datalens-visitor }}` role for the organization. To learn more about roles, see [Roles](../../iam/concepts/access-control/roles.md).
* You can only create new {{ datalens-short-name }} instances at the organization level. Creating a {{ datalens-short-name }} instance in an existing cloud without an organization is no longer supported. You must first create an organization, and then create {{ datalens-short-name }} within it.
* An organization can only have a single {{ datalens-short-name }} instance. If you have a cloud with a previously created {{ datalens-short-name }} instance in a folder of this cloud, you will no longer be able to create {{ datalens-short-name }} at the organization level when you create an organization and link your cloud to it. In this case, to use {{ datalens-short-name }}, you will need to select **No organization** mode and then the cloud folder that already contains a {{ datalens-short-name }} instance. For more information, see [{#T}](../operations/organizations/change-organization.md).
* To create {{ datalens-short-name }} in an organization, you will require the `admin` or `owner` roles for it.
* Currently, technical support requests do not support organizations, therefore:

   * To create a technical support ticket, you need to have a cloud. If you only have an organization, a cloud will be created automatically when you create a ticket. Moving forward, we will add the feature to create support tickets from an organization without creating a cloud.
   * Currently, technical support plans can only be linked to a cloud rather than an organization. If you have multiple clouds linked to your organization, and each has a different technical support plan, select the cloud with the highest rate when you create your support ticket. This will provide you with the best technical support available.

## Migrating an instance from folders to the organization level {#migration}

If you started using {{ datalens-short-name }} before we added the organization feature, its instances are stored in folders within a single cloud. It is more convenient to store them at the organization level, as there may be multiple clouds in a single organization and it is easier to work with other {{ yandex-cloud }} services through organizations. For example, you can also use [{{ tracker-full-name }}]({{ link-tracker }}), [{{ wiki-full-name }}]({{ link-wiki }}), and [{{ forms-full-name }}]({{ link-forms-b2b }}).

Since {{ datalens-short-name }} is no longer supported in cloud folders, to make sure your data is not lost, you need to migrate your instances from the cloud folder to the organization level.

You can only migrate a single {{ datalens-short-name }} instance. Go to the folder with the most up-to-date instance and proceed to its migration:

1. In the left-hand panel, open the [{{ datalens-short-name }} settings]({{ link-datalens-settings }}).
1. Under **Migrating from the folder to the organization**, click **Start migration**.
1. The {{ yandex-cloud }} cloud and folder will be displayed in the top-left corner. Make sure you opened the folder with the {{ datalens-short-name }} instance you want to migrate to the organization level.
1. Confirm your decision by clicking **Start migration**.
1. Wait for the migration to complete.

{{ datalens-short-name }} is now available at the organization level.


#### See also {#see-also}

* [{#T}](../operations/organizations/change-organization.md)

