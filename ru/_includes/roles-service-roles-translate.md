Роль | Разрешения
----- | -----
`ai.translate.user` | Позволяет использовать сервис для перевода текста.
`ai.auditor` | Позволяет просматривать квоты для сервисов {{ translate-name }}, {{ vision-name }}, {{ speechkit-name }} и {{ yagpt-name }}, а также читать метаинформацию каталогов.
`ai.viewer` | Позволяет просматривать квоты для сервисов {{ translate-name }}, {{ vision-name }}, {{ speechkit-name }} и {{ yagpt-name }}, а также читать метаинформацию каталогов. Включает в себя все разрешения, предоставляемые ролью `ai.auditor`.
`ai.editor` | Позволяет использовать сервисы {{ translate-name }}, {{ vision-name }}, {{ speechkit-name }} и {{ yagpt-name }}. Включает в себя все разрешения, предоставляемые ролями `ai.viewer`, `ai.speechkit-stt.user`, `ai.speechkit-tts.user`, `ai.vision.user`, `ai.translate.user` и `ai.languageModels.user`.
`ai.admin` | Позволяет использовать сервисы {{ translate-name }}, {{ vision-name }}, {{ speechkit-name }} и {{ yagpt-name }}. Включает в себя все разрешения, предоставляемые ролью `ai.editor`.