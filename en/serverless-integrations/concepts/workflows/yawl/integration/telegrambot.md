# TelegramBot

Accessing the Telegram Bot API

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- |--- | --- | --- | ---
`token`| `string` | Yes | No | Yes | Bot token. For more information, see [this Telegram Bot Features guide](https://core.telegram.org/bots/features#creating-a-new-bot).
`sendMessage`| [TelegramBotSendMessage](#TelegramBotSendMessage) | Yes | No | No | Description of the message sending action.

### TelegramBotSendMessage {#TelegramBotSendMessage}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- |--- | --- | --- | ---
`chatId`| `string` | Yes | No | Yes | Chat ID or channel name in `@channelusername` format.
`text`| `string` | Yes | No | Yes | Text of the message you need to send.
`parseMode`| `string` | No | No | No | Message formatting mode. Available modes: `UNSPECIFIED`, `MARKDOWN`, `MARKDOWNV2`, and `HTML`. For more information, see [this Telegram Bot API guide](https://core.telegram.org/bots/api#formatting-options).
`replyTo`| `string` | No | No | Yes | ID of the message to reply to.

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
