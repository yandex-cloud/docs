## Получение OAuth-токена {#get-oauth}

Если у вас нет OAuth-токена, то вы можете получить его по [ссылке](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=09cea1cc285845b7b4dc3f409fcacad9).

Добавьте полученный токен в переменную `CHARTS_OAUTH_TOKEN`:

```bash
export CHARTS_OAUTH_TOKEN=AQAD-qKSJyAIABAKs8yk1fuH1kIdr1H5k_ccXDX
```

В дальнейшем используйте созданную переменную в заголовке запроса:

```bash
-H "Authorization: OAuth $CHARTS_OAUTH_TOKEN"
```
