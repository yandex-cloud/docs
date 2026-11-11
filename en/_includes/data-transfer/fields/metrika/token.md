`token.raw`: Token required to access the tags. To obtain it, follow [this link](https://oauth.yandex.ru/authorize?response_type=token&client_id=36b7fc9aa96c4fa09158bc*****). The token’s validity period is one year. In this case, the following applies:
  
  * Activated transfers continue to operate after the token expires.
  * Modifying the list of counters you need to transfer will trigger a transfer error if the token has expired or if the token owner lacks access to the counters.
  * Deactivating a transfer deletes the export, so you will need a current token to reactivate it. In the event of a transfer error, the export is preserved, and reactivation does not require a token refresh.