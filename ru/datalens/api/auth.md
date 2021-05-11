# Аутентификация

Сервис поддерживает аутентификацию следующими способами:
  - Domain Cookie
  - OAuth токен
    - если у вас нет OAuth токена, то вы можете получить его по [этой](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=09cea1cc285845b7b4dc3f409fcacad9) ссылке

Далее в описаниях примеров работы API будет использоваться заголовок авторизации вида:
```bash
-H "Authorization: OAuth $CHARTS_OAUTH_TOKEN"
```
Для корректной работы примеров необходимо выполнить в терминале следующее:
```bash
export CHARTS_OAUTH_TOKEN=AQAD-qKSJyAIABAKs8yk1fuH1kIdr1H5k_ccXDX
```
где после `=` нужно подставить OAuth токен, полученный по ссылке выше.

### Пример (cURL, используя строку path) {#example-string-path}

```bash
curl -X POST "https://charts.yandex-team.ru/api/run" \
  -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN" \
  -H "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
  --data-urlencode "path=/editor/Examples/parametrized-stat-graph"
```

### Пример (cURL, используя хэш path) {#example-hash-path}

```bash
curl -X POST "https://charts.yandex-team.ru/api/run" \
  -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "{\"path\":\"editor/Examples/parametrized-stat-graph\"}"
```
