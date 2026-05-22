В терминале выполните следующую команду: вместо `<токен_бота>` укажите токен Telegram-бота, вместо `<домен_API-шлюза>` — служебный домен API-шлюза:

* Linux, macOS:

   ```bash
   curl \
     --request POST \
     --url https://api.telegram.org/bot<токен_бота>/setWebhook \
     --header 'content-type: application/json' \
     --data '{"url": "<домен_API-шлюза>/fshtb-function"}'
   ```

* Windows (cmd):

   ```bash
   curl ^
     --request POST ^
     --url https://api.telegram.org/bot<токен_бота>/setWebhook ^
     --header "content-type: application/json" ^
     --data "{\"url\": \"<домен_API-шлюза>/fshtb-function\"}"
   ```

* Windows (PowerShell):

   ```powershell
   curl.exe `
     --request POST `
     --url https://api.telegram.org/bot<токен_бота>/setWebhook `
     --header '"content-type: application/json"' `
     --data '"{ \"url\": \"<домен_API-шлюза>/fshtb-function\" }"'
   ```

Результат:

```text
{"ok":true,"result":true,"description":"Webhook was set"}
```
