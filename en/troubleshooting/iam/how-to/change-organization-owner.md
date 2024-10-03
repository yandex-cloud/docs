# How to change the organization owner


## Scenario description {#case-description}

You need to change the owner of the cloud organization in {{ iam-full-name }}.

## Solution {#case-resolution}

Assign a new owner (the `organization-manager.organizations.owner` role) following this [guide](../../../organization/roles#admin), then remove the current owner from the new owner's account. We provide more details [here](../../../organization/edit-account).

## If nothing helped {#if-issue-still-persists}

If the above actions did not help resolve the issue, the best option is to create a new Yandex ID account (or specify an existing one: username[@yandex.ru](http://staff.yandex-team.ru/yandex.ru)) and link the organization owner to it by sending us an email containing the signature of the authorized person and the organization's stamp.

Be sure to include in your email:
1. Organization ID (`bpfXXXXXXXXXXXXXXXX`)
2. Old owner's username
3. New owner's username.