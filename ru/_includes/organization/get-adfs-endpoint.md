Получите эндпоинт сервиса федераций:

 ```powershell
 Get-AdfsEndpoint -AddressPath /adfs/ls/ | Select FullUrl
 ```

Эндпоинт содержит в себе FQDN фермы {{ microsoft-idp.adfs-abbreviated }} и имеет следующий вид:

```text
https://<FQDN_фермы_AD_FS>/adfs/ls/
```
