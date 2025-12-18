# How to change the organization owner



## Case description {#case-description}

You need to change the owner of the cloud organization in {{ iam-name }}.

## Solution {#case-resolution}

To change the cloud organization owner, you need to assign the new owner with the `{{ roles-organization-owner }}` role following [this guide](../../../organization/operations/add-org-admin.md), and then, under the new owner account, delete the current owner. For more info, see [this guide](../../../organization/operations/edit-account.md).

## If nothing helped {#if-nothing-worked}

If the above measures did not help, the best option is to create a new Yandex ID account or specify the one you already have, `username@yandex.ru`, and link the organization owner to it. To do this, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:
 
1. Organization ID, in `bpf*****************` format.
1. Old owner username.
1. New owner username.