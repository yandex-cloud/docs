In the terminal, run the following command, with `<bot_token>` replaced with your Telegram bot token, and `<API_gateway_domain>`, with a link to your API gateway's service domain:

* Linux, macOS:

   ```bash
   curl \
     --request POST \
     --url https://api.telegram.org/bot<bot_token>/setWebhook \
     --header 'content-type: application/json' \
     --data '{"url": "<API_gateway_domain>/fshtb-function"}'
   ```

* Windows (cmd):

   ```bash
   curl ^
     --request POST ^
     --url https://api.telegram.org/bot<bot_token>/setWebhook ^
     --header "content-type: application/json" ^
     --data "{\"url\": \"<API_gateway_domain>/fshtb-function\"}"
   ```

* Windows (PowerShell):

   ```powershell
   curl.exe `
     --request POST `
     --url https://api.telegram.org/bot<bot_token>/setWebhook `
     --header '"content-type: application/json"' `
     --data '"{ \"url\": \"<API_gateway_domain>/fshtb-function\" }"'
   ```

Result:

```text
{"ok":true,"result":true,"description":"Webhook was set"}
```
