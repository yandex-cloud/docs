```powershell
$ADFS_CERT_PATH = "<path_to_certificate>/adfs_certificate.cer"

$TEMP_CERT = (Get-AdfsCertificate -CertificateType Token-Signing |
                where {$_.IsPrimary -eq $true} | Select-Object -First 1
             ).Certificate.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Cert)

@(
    '-----BEGIN CERTIFICATE-----'
    [System.Convert]::ToBase64String($TEMP_CERT, 'InsertLineBreaks')
    '-----END CERTIFICATE-----'
) | Out-File -FilePath $ADFS_CERT_PATH -Encoding ascii

```

The certificate will be saved as `adfs_certificate.cer`.
