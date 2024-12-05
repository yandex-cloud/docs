Optionally, if you enabled **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}** when [creating a federation](#create-federation) in {{ org-full-name }}, configure the associated relying party trust parameters:

1. Open the context menu of the relying party trust you created and select **Properties**.

    This will open the window with relying party trust properties.

1. Go to the **Encryption** tab and add the [previously](#create-federation) obtained certificate:

    1. Click **Browse**.
    1. Select the certificate file, such as `YandexCloud.cer`.

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
