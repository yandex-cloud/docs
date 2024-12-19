(Optional) If you enabled **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}** when [creating the federation](#create-federation) in {{ org-full-name }}, configure the associated relying party trust parameters:

1. Open the context menu of the relying party trust you created and select **Properties**.

    This will open the window with relying party trust properties.

1. Go to the **Encryption** tab and add the {{ yandex-cloud }} SAML certificate you downloaded [earlier](#create-federation) to sign authentication requests:

    1. Click **Browse**.
    1. Select the certificate file, such as `YandexCloud.cer`.

         If you did not download a SAML certificate when creating the federation, you can download it on the {{ org-full-name }} federation info page by clicking ![ArrowDownToLine](../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud_org.page.federation.action.download-cert }}** in the **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}** field.

1. Go to the **Signature** tab and add the same certificate:

    1. Click **Add**.
    1. Select the certificate file.

1. Click **OK**.

1. Enable required claim encryption and request signing for the created relying party trust:

    ```powershell
    Set-AdfsRelyingPartyTrust `
        -TargetName "{{ yandex-cloud }}" `
        -EncryptClaims $true `
        -SignedSamlRequestsRequired $true `
        -SamlResponseSignature MessageAndAssertion
    ```
