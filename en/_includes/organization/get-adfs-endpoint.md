Get the federation service endpoint:

 ```powershell
 Get-AdfsEndpoint -AddressPath /adfs/ls/ | Select FullUrl
 ```

The endpoint contains the FQDN of the {{ microsoft-idp.adfs-abbreviated }} farm and has the following format:

```text
https://<AD_FS_farm_FQDN>/adfs/ls/
```
