---
title: Access management in {{ speechkit-full-name }}
description: 'Access management in {{ speechkit-full-name }}: a speech technology, speech recognition, and synthesis service. Permissions are granted when assigning a role. A role can be assigned for a folder or a cloud: all cloud permissions are inherited. To use the service, you need one of the following roles: editor, admin, or resource-manager.clouds.owner.'
---

# Access management in {{ speechkit-name }}

In this section, you will learn:
* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Which roles exist in the service {#roles-list}

### Service roles {#service-roles}

#### ai.speechkit-stt.user {#ai-speechkit-stt-user}

{% include [speechkit-stt-user](../../_roles/ai/speechkit-stt/user.md) %}

#### ai.speechkit-tts.user {#ai-speechkit-tts-user}

{% include [speechkit-tts-user](../../_roles/ai/speechkit-tts/user.md) %}

#### ai.auditor {#ai-auditor}

{% include [ai-auditor](../../_roles/ai/auditor.md) %}

#### ai.viewer {#ai-viewer}

{% include [ai-viewer](../../_roles/ai/viewer.md) %}

#### ai.editor {#ai-editor}

{% include [ai-editor](../../_roles/ai/editor.md) %}

#### ai.admin {#ai-admin}

{% include [ai-admin](../../_roles/ai/admin.md) %}

For more information about service roles, see [{#T}](../../iam/concepts/access-control/roles.md) in the {{ iam-full-name }} service documentation.


### Roles of other services {#integration-roles}

When working with {{ speechkit-name }}, you may need roles of other services, for example, to upload results and source materials to an {{ objstorage-name }} bucket.

#### resource-manager.clouds.owner {#resource-manager-clouds-owner}

{% include [resourcemanager-clouds-owner](../../_roles/resource-manager/clouds/owner.md) %}

#### storage.uploader {#storage-uploader}

{% include [storage-uploader](../../_roles/storage/uploader.md) %}

#### kms.keys.encrypterDecrypter {#kms-keys-encrypterDecrypter}

{% include [kms.keys.encrypterDecrypter](../../_roles/kms/keys/encrypterDecrypter.md) %}


### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

#### What's next {#what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md)
* [How to revoke a role](../../iam/operations/roles/revoke.md)
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md)
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance)
