* `{{ ui-key.yacloud_org.organization.security-settings.i18n.ts.sspr_two-any_16pJs }}`: Reset method where the user confirms their identity using any two verification methods, e.g., a TOTP and an SMS code.

    To use this method, the user account must have at least two [MFA factors](../../organization/concepts/mfa.md#mfa-factors) configured. Otherwise, only a [user pool](../../organization/concepts/user-pools.md) administrator can reset the password.
* `FIDO2 with mandatory user verification`: Reset method where the user can verify their identity using a [FIDO2](https://en.wikipedia.org/wiki/FIDO_Alliance#FIDO2) key or [Passkey](https://www.passkeys.com/), but only together with local verification, such as a PIN, biometrics, etc.

    To use this password reset method, the user account must have a [WebAuthn](https://en.wikipedia.org/wiki/WebAuthn) MFA factor configured. Otherwise, only a user pool administrator can reset the password.
