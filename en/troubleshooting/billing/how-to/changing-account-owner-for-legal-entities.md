# How to change the owner for a business account


## Case description {#case-description}

You need to change the account owner, e.g., to hand over access permissions to a different employee.

## Solution {#case-resolution}

{% list tabs %}

- If you have access to the account

    To change the account administrator, follow these steps:

    1. Create a new Yandex ID that will take over the permissions.
    1. Contact [our support]({{ link-console-support }}) to get the relevant document template, sign and stamp it, and email back the scanned copy.
    1. Send a document confirming the signatory's authority.
   
    {% note info %}

    When you change the administrator, the system updates the old login to the new one.

    {% endnote %}
    
    We recommend checking out [this guide](../../../resource-manager/concepts/resources-hierarchy.md#owner) if you need to manually change the owner in your cloud environment, and [this one](../../../organization/security/index.md#add-role), if you need to do the same in your organization.
    
    {% note alert %}
    
    The new login must be fully registered in Yandex ID and must not be used to sign in to other Yandex services or linked to any Yandex Balance accounts, i.e., it must be completely new.

    {% endnote %}

    Use this login only to authenticate rather than to create a billing account. To do this:

    1. Click [this link](https://yandex.cloud/en).
    1. Click **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}** → **Log in using Yandex ID**.
    1. Log in with the new Yandex ID and accept the terms of the agreement, but do not create a billing account.

    After you complete these steps and we receive the scanned copy of your signed application, we will update the information in the system.


- If you do not have access to the account

    To change the account administrator, follow these steps:

    1. Create a new Yandex ID that will take over the permissions.
    1. Contact [our support]({{ link-console-support }}) to get the relevant document template, sign and stamp it, and email back the scanned copy.
    1. Send a document confirming the signatory's authority.

    When you change the administrator, the system updates the old login to the new one and adds a new owner to the cloud organizations. After changing the billing account owner, you need to manually revoke the old login's permissions in the resource clouds and cloud organizations by following [this guide](../../../iam/operations/users/delete).

    {% note info %}

    The new login must be fully registered in Yandex ID and must not be used to sign in to other Yandex services or linked to any Yandex Balance accounts, i.e., it must be completely new.

    {% endnote %}

    Use this login only to authenticate rather than to create a billing account. To do this:

    1. Click [this link](https://yandex.cloud/en).
    1. Click **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}** → **Log in using Yandex ID**.
    1. Log in with the new Yandex ID and accept the terms of the agreement, but do not create a billing account.

    After you complete these steps and we receive the scanned copy of your signed application, we will update the information in the system.

{% endlist %}
