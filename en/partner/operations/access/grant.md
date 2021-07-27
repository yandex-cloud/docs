---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Granting a partner access to a customer's cloud

In this section, you'll learn how to grant access and permissions to a cloud and verify the access granted.

## Granting access to a cloud {#grant}

For a partner to have access to a customer's cloud:

1. In the customer console, select the cloud to grant access to.
1. Go to **Access control**.
1. Click **Add user**.
1. In the **Email** field, enter the `@yandex.ru` email address linked to the partner's account in {{ yandex-cloud }}.
1. Refresh the page to make sure that the partner is added.

Once added, partners are only assigned one role by default, which doesn't give the necessary permissions to perform operations. Learn more about [roles in {{ yandex-cloud }}](../../../resource-manager/security/).

## Assigning a role for the cloud {#role}

To assign a role:

1. Click the menu icon ![image](../../../_assets/options.svg) next to the partner's name.
1. Select the desired role.
1. Click **Close**.

## Granting access to a billing account {#check}

To grant access to a billing account:

1. In the customer's account, go to the **Billing** tab.
1. In the panel on the left, select **Access control**.
1. Click **Add user** and add the partner's account.

Now the partner has access both to the cloud and billing account. It may take a few minutes for access to be enabled.

