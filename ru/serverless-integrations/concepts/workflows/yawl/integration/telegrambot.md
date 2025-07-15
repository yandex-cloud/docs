# TelegramBot

Обращение к Telegram Bot API.

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- |--- | --- | --- | ---
`token`| `string` | Да | Нет | Да | Токен бота. Подробнее см. [документацию Telegram Bot Features](https://core.telegram.org/bots/features#creating-a-new-bot).
`sendMessage`| [TelegramBotSendMessage](#TelegramBotSendMessage) | Да | Нет | Нет | Описание действия отправки сообщения.

### TelegramBotSendMessage {#TelegramBotSendMessage}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- |--- | --- | --- | ---
`chatId`| `string` | Да | Нет | Да | Идентификатор чата или имя канала в формате `@channelusername`.
`text`| `string` | Да | Нет | Да | Текст сообщения, который нужно отправить.
`parseMode`| `string` | Нет | Нет | Нет | Режим форматирования сообщения. Доступные режимы: `UNSPECIFIED`, `MARKDOWN`, `MARKDOWNV2` и `HTML`. Подробнее см. [документацию Telegram Bot API](https://core.telegram.org/bots/api#formatting-options).
`replyTo`| `string` | Нет | Нет | Да | Идентификатор сообщения, на которое нужно ответить.

## Пример спецификации

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
