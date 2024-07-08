---
title: "How to delete a user from a cloud in {{ iam-full-name }}"
description: "Follow this guide to delete a user from your cloud."
---

# Deleting a user from the cloud

To delete a user, exclude them from the [organization](../../../overview/roles-and-resources.md):

{% include [edit-account.md](../../../_includes/organization/remove-user.md) %}

To preclude the use of particular resources, [revoke](../roles/revoke.md) the relevant roles from the user.
