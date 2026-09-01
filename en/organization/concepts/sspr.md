---
title: Self-service password reset in {{ org-full-name }}
description: With MFA policy settings, you can enable self-service password reset for local users without administrator involvement.
---

# Self-service password reset in {{ org-full-name }}

You can enable [self-service password reset (SSPR)](https://en.wikipedia.org/wiki/Self-service_password_reset) for [local](../../iam/concepts/users/accounts.md#local) {{ org-full-name }} users. This feature comes in handy when users forget or lose their passwords.

Users can [reset their password](../operations/user-account/reset-password.md) on their own on the {{ yandex-cloud }} login page. At the same time, the user must verify their identity using the verification methods set by the [MFA policy](./mfa.md#mfa-policies).

The option for users to reset their own passwords and the available _reset methods_ are configured in the MFA policy settings. Currently, you can only [configure](../operations/manage-sspr.md) this option in the [{{ cloud-center }} UI]({{ link-org-cloud-center }}). To manage MFA policies, you need the `organization-manager.editor` [role](../security/index.md#organization-manager-editor) or higher.

## Password reset methods {#reset-methods}

To enable self-service password reset for users in the MFA policy settings, you must set at least one password reset method:

{% include [password-reset-mfa-methods](../../_includes/organization/password-reset-mfa-methods.md) %}

You can also enable multiple password reset methods simultaneously in the MFA policy's self-service password reset settings.

#### Useful links {#see-also}

* [{#T}](./mfa.md)
* [{#T}](../operations/manage-sspr.md)
* [{#T}](../operations/user-account/reset-password.md)
