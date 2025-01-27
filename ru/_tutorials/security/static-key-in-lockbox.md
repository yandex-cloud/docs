Если вы часто используете сервисы с AWS-совместимым API, например [{{ objstorage-full-name }}](../../storage/index.yaml), [{{ yds-full-name }}](../../data-streams/index.yaml) или [{{ message-queue-full-name }}](../../message-queue/index.yaml), вам приходится самостоятельно заботиться о безопасном хранении [статических ключей доступа](../../iam/concepts/authorization/access-key.md).

В данном руководстве рассматривается сценарий, при котором в качестве хранилища для статического ключа доступа используется [секрет](../../lockbox/concepts/secret.md) {{ lockbox-full-name }}. При этом значение ключа доступа не только не хранится локально на компьютере пользователя, но и не выводится на экран.

{% include [index-common](../_tutorials_includes/static-key-in-lockbox/index-common.md) %}