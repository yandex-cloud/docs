(Опционально) Если при [создании федерации](#create-federation) в {{ org-full-name }} вы включили опцию **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}**, настройте связанные с этим параметры для отношения доверия:

1. Откройте контекстное меню созданного отношения доверия и выберите пункт **Properties**.

    Откроется окно со свойствами отношения доверия.

1. Перейдите на вкладку **Encryption** и добавьте сертификат, полученный [ранее](#create-federation):

    1. Нажмите кнопку **Browse**.
    1. Выберите файл с сертификатом (например, `YandexCloud.cer`).

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
