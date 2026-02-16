# Работа с сервисным агентом из задания

Вы можете работать с другими сервисами из [заданий](../../concepts/jobs/index.md) при помощи [сервисного агента](../../../iam/concepts/service-control.md#service-agent). Сервисный агент — это специальный сервисный аккаунт, от имени которого проекты {{ ml-platform-name }} будут выполнять действия в других сервисах {{ yandex-cloud }}.

Чтобы работать с другими сервисами из заданий:

1. [Создайте](../community/create-ssa.md) сервисного агента и включите его в [сообществе](../../concepts/community.md).
1. [Запустите](work-with-jobs.md) задание. Токен для использования сервисного агента сохранится в файл и будет доступен из переменной окружения `SA_TOKEN_FILENAME`.
1. Используйте переменную `SA_TOKEN_FILENAME`, чтобы работать с другими сервисами. Например, так можно получить содержимое секрета [{{ lockbox-full-name }}](../../../lockbox/) с помощью API:

   ```bash
   curl --header "Authorization: Bearer $(cat $SA_TOKEN_FILENAME)" \
     https://{{ api-host-lockbox-payload }}/lockbox/v1/secrets/<идентификатор_секрета>/payload
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