---
title: "How to manage access rights to {{ yandex-cloud }} resources. Step-by-step instructions"
description: "Step-by-step instructions for managing access rights to {{ yandex-cloud }} resources. From the article you will learn how to manage users, service accounts and identity federations, assign roles to them. We will tell you in detail about IAM tokens, authorized and API keys."
---

# Step-by-step instructions for {{ iam-name }}

## Users {#users}

- [{#T}](users/create.md)
- [{#T}](users/get.md)
- [{#T}](users/delete.md)

## Service accounts {#sa}

- [{#T}](sa/create.md)
- [{#T}](sa/update.md)
- [{#T}](sa/assign-role-for-sa.md)
- [{#T}](sa/set-access-bindings.md)
- [{#T}](sa/create-access-key.md)
- [{#T}](sa/get-id.md)
- [{#T}](sa/delete.md)

## Identity federations {#federations}

Instructions for managing identity federations are now included in the {{ org-full-name }} [documentation](../../organization/).

## Roles {#roles}

- [{#T}](roles/grant.md)
- [{#T}](roles/revoke.md)

## IAM tokens {#iam-tokens}

{% if product == "yandex-cloud" %}
- [{#T}](iam-token/create.md)
{% endif %}
- [{#T}](iam-token/create-for-sa.md)
- [{#T}](iam-token/create-for-federation.md)
   {% if product == "yandex-cloud" %}
- [Reissue an IAM token](compromised-credentials.md#iam-reissue)
   {% endif %}

{% if audience == "internal" %}
- [{#T}](iam-token/create-for-robot.md)

{% endif %}

## API keys {#api-keys}

- [{#T}](api-key/create.md)
- [{#T}](api-key/delete.md)

## Authorized keys {#authorized-keys}

- [{#T}](authorized-key/create.md)