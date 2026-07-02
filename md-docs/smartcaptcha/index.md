[Документация Yandex Cloud](../index.md) > Yandex SmartCaptcha > SmartCaptcha

# Yandex SmartCaptcha

Yandex SmartCaptcha позволяет определить, кем является пользователь системы: человеком или компьютером.

# Yandex SmartCaptcha

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Создать капчу](operations/create-captcha.md)

 - [Удалить капчу](operations/delete-captcha.md)

 - [Получить ключи](operations/get-keys.md)

 - [Добавить виджет расширенным методом](operations/advanced-method.md)

 - [Проверить капчу](operations/validate-captcha.md)

### Получение информации о капче

 - [Получить список капч](operations/get-list.md)

 - [Получить информацию о капче](operations/get-info.md)

 - [Посмотреть операции с ресурсами сервиса](operations/operation-logs.md)

 - [Миграция на новый формат условий в API, CLI и Terraform](operations/api-migration.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Добавление HTML-страницы для работы Yandex SmartCaptcha](tutorials/mobile-app/website.md)

 - [Капча в приложении Android](tutorials/mobile-app/android/quickstart-android.md)

 - [Невидимая капча в приложении Android](tutorials/mobile-app/android/invisible-captcha-android.md)

 - [Капча в приложении Android на Flutter](tutorials/mobile-app/android/quickstart-android-flutter.md)

 - [Капча в приложении iOS](tutorials/mobile-app/ios/quickstart-ios.md)

## Концепции

 - [Доступность капчи](concepts/accessibility.md)

 - [Валидация пользователя](concepts/validation.md)

 - [Валидация домена](concepts/domain-validation.md)

 - [Типы заданий](concepts/tasks.md)

 - [Варианты заданий](concepts/captcha-variants.md)

 - [Схема проверки капчи с метаданными](concepts/metadata-scheme.md)

 - [Методы подключения виджета](concepts/widget-methods.md)

 - [Ключи капчи](concepts/keys.md)

 - [Невидимая капча](concepts/invisible-captcha.md)

 - [Капча в React](concepts/react.md)

 - [Объект Javascript Interface](concepts/js-interface.md)

 - [Ограниченный режим](concepts/restricted-mode.md)

 - [Публичные IP-адреса](concepts/ips.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### captcha

 - [Overview](cli-ref/captcha/index.md)

 - [create](cli-ref/captcha/create.md)

 - [delete](cli-ref/captcha/delete.md)

 - [get](cli-ref/captcha/get.md)

 - [get-secret-key](cli-ref/captcha/get-secret-key.md)

 - [list](cli-ref/captcha/list.md)

 - [update](cli-ref/captcha/update.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### captcha

 - [Overview](cli-ref/v0/captcha/index.md)

 - [create](cli-ref/v0/captcha/create.md)

 - [delete](cli-ref/v0/captcha/delete.md)

 - [get](cli-ref/v0/captcha/get.md)

 - [list](cli-ref/v0/captcha/list.md)

 - [update](cli-ref/v0/captcha/update.md)

### v1

 - [Overview](cli-ref/v1/index.md)

#### captcha

 - [Overview](cli-ref/v1/captcha/index.md)

 - [create](cli-ref/v1/captcha/create.md)

 - [delete](cli-ref/v1/captcha/delete.md)

 - [get](cli-ref/v1/captcha/get.md)

 - [get-secret-key](cli-ref/v1/captcha/get-secret-key.md)

 - [list](cli-ref/v1/captcha/list.md)

 - [update](cli-ref/v1/captcha/update.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Captcha

 - [Overview](api-ref/grpc/Captcha/index.md)

 - [Get](api-ref/grpc/Captcha/get.md)

 - [GetSecretKey](api-ref/grpc/Captcha/getSecretKey.md)

 - [Create](api-ref/grpc/Captcha/create.md)

 - [Delete](api-ref/grpc/Captcha/delete.md)

 - [Update](api-ref/grpc/Captcha/update.md)

 - [List](api-ref/grpc/Captcha/list.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Captcha

 - [Overview](api-ref/Captcha/index.md)

 - [Get](api-ref/Captcha/get.md)

 - [GetSecretKey](api-ref/Captcha/getSecretKey.md)

 - [Create](api-ref/Captcha/create.md)

 - [Delete](api-ref/Captcha/delete.md)

 - [Update](api-ref/Captcha/update.md)

 - [List](api-ref/Captcha/list.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [История изменений](release-notes.md)