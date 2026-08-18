# TelegramBot

{% include [workflows-ai-studio-note](../../../../../_includes/serverless-integrations/workflows-ai-studio-note.md) %}

Accessing the Telegram Bot API

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- |--- | --- | --- | ---
`token`| `string` | Yes | None | Yes | Bot token. For more information, see [this Telegram Bot Features guide](https://core.telegram.org/bots/features#creating-a-new-bot).
`sendMessage`| [TelegramBotSendMessage](#TelegramBotSendMessage) | Yes | None | None | Description of the message sending action.

### TelegramBotSendMessage {#TelegramBotSendMessage}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- |--- | --- | --- | ---
`chatId`| `string` | Yes | None | Yes | Chat ID or channel name in `@channelusername` format.
`text`| `string` | Yes | None | Yes | Text of the message you need to send.
`parseMode`| `string` | None | None | None | Message formatting mode. Available modes: `UNSPECIFIED`, `MARKDOWN`, `MARKDOWNV2`, and `HTML`. For more information, see [this Telegram Bot API guide](https://core.telegram.org/bots/api#formatting-options).
`replyTo`| `string` | None | None | Yes | ID of the message to reply to.

## Specification example

```yaml
yawl: '0.1'
start: step-telegramBot2025
steps:
  step-telegramBot2025:
    telegramBot:
      token: >-
        \(lockboxPayload("fc3upp992gsj********"; "token";
        "fc3d61o0ujks********"))
      sendMessage:
        chatId: '-10027********'
        text: 'Hello world\!'
        parseMode: MARKDOWNV2
```
