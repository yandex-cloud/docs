# Roles and access rights

{% if audience == "external" %}

{{  wiki-full-name }} is a [service](../organization/manage-services.md) that can be [enabled](./enable-wiki.md) for your organization in {{ yandex-cloud }}.

{% endif %}

Each {% if audience == "external" %}{{ org-full-name }}{% endif %} employee has the right to create and edit {{wiki-name }} pages. Access rights for a page or cluster can be configured by its [author](./page-management/access-setup.md).

## Page authors{#authors}

A page can have one or more authors:

* The owner of the page. By default, this is the user who created the page. You can [assign](./page-management/edit-owner.md#edit-owner) only one owner per page. The owner's name is indicated above the page title.
* Co-authors. All users [added](./page-management/edit-owner.md#add) to the list of page authors.

All authors have the same rights for the {{ wiki-name }} page. Authors can perform the following actions:

* [Edit](./edit-page.md) pages.
* Set up other users' [access rights](./page-management/access-setup.md) for the page.
* [Change](./page-management/edit-owner.md) a list of authors and assign the page owner.

## Readers {#readers}

Readers in {{wiki-name}} are users who aren't assigned as authors of the page.

The {% if audience == "external" %}organization's administrator and{% endif %} author or owner of the page can [set up rights](./page-management/access-setup.md) for these users:

* Completely restrict viewing of the page.
* Grant access to view the page only.
* Grant access to view and edit the page.

Readers can't set up access to the page, change the list of authors, or assign the page owner.

