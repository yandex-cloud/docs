В блоке **{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.section_title }}** в поле **{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.field_access }}** выберите итоговое действие политики: **{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.effect_deny }}** или **{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.effect_allow }}** аутентификацию пользователей.

Если вы выбрали **{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.effect_allow }}**, задайте **{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.field_login-requirements }}**: 

* `{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.login-requirement_reauth_j8x8i }}` — чтобы запросить полный повторный вход пользователя: ввод пароля и [MFA](*mfa). В поле **{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.field_ttl }}** настройте время, в течение которого не потребуется повторная аутентификация.

* `{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.login-requirement_step-up }}` — чтобы запросить повторную проверку MFA. Настройте для нее:

   * **{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.field_factor-type }}**: `{{ ui-key.yacloud_org.organization.security-settings.acr_any-mfa_j6PdY }}` (WebAuthn, TOTP, SMS) или `{{ ui-key.yacloud_org.organization.security-settings.acr_phr_7hMqk }}` (только WebAuthn). Подробнее о типах факторов MFA в разделе [{#T}](../../organization/concepts/mfa.md#mfa-factors).

   * **{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.field_ttl }}**, в течение которого не потребуется повторная усиленная проверка.

* `{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.login-requirement_skip-mfa }}` — чтобы полностью отключить требование MFA или запрашивать его только при первом входе. Для этого соответственно отключите или включите опцию **{{ ui-key.yacloud_org.organization.security-settings.PolicyResultCard.field_require-once }}**.
