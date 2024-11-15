```powershell
$ADFS_CERT_PATH = "<путь_к_сертификату>/adfs_certificate.cer"

$TEMP_CERT = (Get-AdfsCertificate -CertificateType Token-Signing |
                where {$_.IsPrimary -eq $true} | Select-Object -First 1
             ).Certificate.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Cert)

@(
    '-----BEGIN CERTIFICATE-----'
    [System.Convert]::ToBase64String($TEMP_CERT, 'InsertLineBreaks')
    '-----END CERTIFICATE-----'
) | Out-File -FilePath $ADFS_CERT_PATH -Encoding ascii

```

Сертификат будет сохранен под именем `adfs_certificate.cer`.
