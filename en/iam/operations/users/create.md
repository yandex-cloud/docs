---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Adding a user to a cloud

To add users to the cloud, you need the [`admin`](../../concepts/access-control/roles.md#admin) or [`resource-manager.clouds.owner`](../../concepts/access-control/roles.md#owner) role for that cloud.

You can add [users with a Yandex account](#passport-user) and [federated users](#federated-user).

## Add a user with a Yandex account {#passport-user}

1. {% include [grant-role-console-first-steps](../../../_includes/iam/grant-role-console-first-steps.md) %}
2. On the **Users and roles** page, click **Add user** in the upper-right corner.
3. Enter the user's Yandex email address.
4. Click **Add**.

{% note info %}

{% include [yandex-account-2fa-warning.md](../../../_includes/iam/yandex-account-2fa-warning.md) %}

{% endnote %}

## Add federated users {#federated-user}

{% include [include](../../../_includes/iam/add-federated-users-before-begin.md) %}

{% include [include](../../../_includes/iam/add-federated-users-instruction.md) %}

#### What's next {#whats-next}

* [Assign roles to the added users](../roles/grant.md).

