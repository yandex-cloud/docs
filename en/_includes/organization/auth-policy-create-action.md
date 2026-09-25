Under **{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.section_title }}**, select the policy enforcement action in the **{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.field_access }}** field: **{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.effect_deny }}** or **{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.effect_allow }}** user authentication.

If you selected **{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.effect_allow }}**, define the **{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.field_login-requirements }}**: 
      
* `{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.login-requirement_step-up }}`: To enforce an additional [MFA](*mfa) challenge. Configure its settings:

   * **{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.field_factor-type }}**: `Any methods` (WebAuthn, TOTP, or SMS) or `Phishing-resistant` (only WebAuthn). For more information, see [{#T}](../../organization/concepts/mfa.md#mfa-factors).
      
   * **{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.field_ttl }}**, i.e., the period before step-up verification is required again.

* `{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.login-requirement_skip-mfa }}`: To disable MFA completely or only request it on the user's very first login. To control this behavior, enable or disable **{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.field_require-once }}** accordingly.