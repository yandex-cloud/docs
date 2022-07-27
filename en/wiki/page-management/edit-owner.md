# Editing a list of page authors

A page can have one or more authors. The main author is the page [owner](#edit-owner). By default, this is the user who created it. The owner's name is indicated above the page title. All other authors are called co-authors and have the same rights as the page owner.

{% note alert %}

A new author of the page can be assigned by its current author or the {% if audience == "external" %}organization administrator{% else %}internal services support team{% endif %}.

{% endnote %}

## Adding a page author {#add}

To add a page author:

  1. Open the page.

  1. In the upper-right corner of the page, click ![](../../_assets/wiki/svg/actions-icon.svg) **Actions** and select **Settings**.

  1. Click the line **Authors** and specify the username of the new author of the page.

  1. Close the author editing window. The changes are saved automatically.

## Removing a user from the list of page authors {#del}

To remove a page author:

  1. Open the page.

  1. In the upper-right corner of the page, click ![](../../_assets/wiki/svg/actions-icon.svg) **Actions** and select **Settings**.

  1. Click the line **Authors**.

  1. Next to the name of the user you want to remove from the list of authors, click ![](../../_assets/wiki/svg/actions-icon.svg) and select **Delete**.

  1. Close the author editing window. The changes are saved automatically.

{% note alert %}

If you remove the page owner from the list of authors, the user whose name is first in the list of authors will be automatically assigned a new owner.

{% endnote %}

## Becoming an author of someone else's page {#addme}

  1. In the upper-right corner of the page, click ![](../../_assets/wiki/svg/actions-icon.svg) **Actions** and select **Settings**.

  1. Click the line **Authors** and view the list of all authors.

  1. Contact one of the current authors and ask them to add you to this list.

{% if audience == "internal" %} 
The internal services support team can edit the list of authors for any page.

If the page author is an active Yandex employee who currently has no access to the intranet or PC:

  1. Send an email to [tools@](mailto:tools@yandex-team.ru) with a copy to the cluster author.

  1. Wait for the team to process your request.

If the author of a page is no longer a Yandex employee:

  1. Click **Become an author**.

  1. Wait for the internal services support team to process your request.

{% endif %}

## Changing the page owner {#edit-owner}

To assign the owner of a page whose author{% if audience == "external" %} or organization administrator{% endif %} you are:

  1. Open the page.

  1. In the upper-right corner of the page, click ![](../../_assets/wiki/svg/actions-icon.svg) **Actions** and select **Settings**.

  1. Click the line **Authors**.

  1. Make sure the user is in the list of authors. If not, [add them](#add).

  1. Next to the name of the user you want to appoint the owner, click ![](../../_assets/wiki/svg/actions-icon.svg) and select **Appoint as owner**. You can only assign one owner for a page.

#### See also

- [{#T}](access-setup.md)

- [{#T}](move-page.md)

- [{#T}](../delete-page.md)

