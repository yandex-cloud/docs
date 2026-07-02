[Документация Yandex Cloud](../../../index.md) > [Yandex DataSphere](../../index.md) > [Пошаговые инструкции](../index.md) > DataSphere Jobs > Работа с сервисным агентом из задания

# Работа с сервисным агентом из задания

Вы можете работать с другими сервисами из [заданий](../../concepts/jobs/index.md) при помощи [сервисного агента](../../../iam/concepts/service-control.md#service-agent). Сервисный агент — это специальный сервисный аккаунт, от имени которого проекты DataSphere будут выполнять действия в других сервисах Yandex Cloud.

Чтобы работать с другими сервисами из заданий:

1. [Создайте](../community/create-ssa.md) сервисного агента и включите его в [сообществе](../../concepts/community.md).
1. [Запустите](work-with-jobs.md) задание. Токен для использования сервисного агента сохранится в файл и будет доступен из переменной окружения `SA_TOKEN_FILENAME`.
1. Используйте переменную `SA_TOKEN_FILENAME`, чтобы работать с другими сервисами. Например, так можно получить содержимое секрета [Yandex Lockbox](../../../lockbox/index.md) с помощью API:

   ```bash
   curl --header "Authorization: Bearer $(cat $SA_TOKEN_FILENAME)" \
     https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/<идентификатор_секрета>/payload
   ```

   Результат:

   ```text
   {
    "entries": [
     {
      "key": "my-key",
      "textValue": "key-example"
     }
    ],
    "versionId": "e6qlcb7fqtt6********"
   }
   ```