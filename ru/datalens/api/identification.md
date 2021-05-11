# Идентификация

Чтобы идентифицировать себя или свое приложение необходимо использовать заголовок `User-Agent`,
который будет включать в себя:

* имя приложения или ваш логин
* ссылка на ваше приложение или email-адрес

Мы используем эту информацию, чтобы связаться с вами,
если вы что-то делаете не так и предупредить вас об этом.

Вот пару примеров корректного заголовка `User-Agent`:

* `User-Agent: imperator (imperator@yandex-team.ru)`
* `User-Agent: Charts (http://charts.yandex-team.ru)`

Вы также можете добавить соответствующую запись в переменные окружения выполнив в терминале:
```bash
export CHARTS_USER_AGENT="login (login@yandex-team.ru)"
```
Затем использовать заголовок `User-Agent` при выполнении запроса в следующем виде:
```bash
-H "User-Agent: $CHARTS_USER_AGENT"
```


### Пример (cURL, используя строку path) {#example-curl-string-path}

```bash
curl -X POST "https://charts.yandex-team.ru/api/run" \
  -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN" \
  -H "User-Agent: $CHARTS_USER_AGENT" \
  -H "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
  --data-urlencode "path=/editor/Examples/parametrized-stat-graph"
```


### Пример (cURL, используя хэш path) {#example-curl-hash-path}

```bash
curl -X POST "https://charts.yandex-team.ru/api/run" \
  -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN" \
  -H 'User-Agent: $CHARTS_USER_AGENT' \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "{\"path\":\"editor/Examples/parametrized-stat-graph\"}"
```
