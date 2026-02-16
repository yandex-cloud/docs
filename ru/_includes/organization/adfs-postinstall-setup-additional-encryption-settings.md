(Опционально) Если при [создании федерации](#create-federation) в {{ org-full-name }} вы включили опцию **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}**, настройте связанные с этим параметры для отношения доверия:

1. Откройте контекстное меню созданного отношения доверия и выберите пункт **Properties**.

    Откроется окно со свойствами отношения доверия.

1. Перейдите на вкладку **Encryption** и добавьте скачанный [ранее](#create-federation) SAML-сертификат {{ yandex-cloud }} для подписи запросов аутентификации:

    1. Нажмите кнопку **Browse**.
    1. Выберите файл с сертификатом (например, `YandexCloud.cer`).

         Если вы не скачивали SAML-сертификат при создании федерации, вы можете скачать его на странице сведений о федерации в {{ org-full-name }}, нажав кнопку ![ArrowDownToLine](../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud_org.page.federation.action.download-cert }}** в поле **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}**.

1. Перейдите на вкладку **Signature** и добавьте этот же сертификат:

    1. Нажмите кнопку **Add**.
    1. Выберите файл с сертификатом.

1. Нажмите кнопку **OK**.

1. Включите обязательные шифрование утверждений и подпись запросов для созданного отношения доверия:

    ```powershell
    Set-AdfsRelyingPartyTrust `
        -TargetName "{{ yandex-cloud }}" `
        -EncryptClaims $true `
        -SignedSamlRequestsRequired $true `
        -SamlResponseSignature MessageAndAssertion
    ```
