# Диагностика Secrets Store

В этом разделе описаны типичные проблемы при использовании Secrets Injector и способы их решения.

## Секреты не подставляются в переменные окружения {#env-not-injected}

### Симптом

Под запускается, но переменные окружения содержат исходные значения-ссылки (`secrets:secret/data/...`) вместо реальных значений.

### Причины и решения

#### Аннотации не попали в шаблон пода {#wrong-annotations-place}

Основное место настройки инъекции — аннотации в шаблоне пода. Для `Deployment`, `StatefulSet`, `DaemonSet` и `Job` рекомендуется указывать аннотации в `spec.template.metadata.annotations`. Для `CronJob` используйте `spec.jobTemplate.spec.template.metadata.annotations`.

Для `Deployment`, `StatefulSet`, `DaemonSet` и `Job` вебхук также может скопировать аннотации из `metadata.annotations` ресурса, если они не заданы в шаблоне пода. Если одна и та же аннотация задана в обоих местах, используется значение из шаблона пода. Но шаблон пода остается самым понятным и переносимым местом для настройки инъекции.

Примеры:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  template:
    metadata:
      annotations:
        secrets.stackland.yandex.cloud/render-env: "true"
        secrets.stackland.yandex.cloud/role: "myapp"
```

#### Пространство имен исключено из инъекции {#namespace-disabled}

Проверьте метки пространства имен:

```bash
kubectl get namespace <имя_пространства_имен> --show-labels
```

Если на пространство имен установлена метка `secrets.stackland.yandex.cloud/injection=disabled`, вебхук не мутирует поды в нем. Удалите метку:

```bash
kubectl label namespace <имя_пространства_имен> secrets.stackland.yandex.cloud/injection-
```

#### Не задана аннотация `role` {#missing-role}

Аннотация `secrets.stackland.yandex.cloud/role` обязательна. Без нее инжектор не сможет аутентифицироваться в Secrets Store.

#### Неправильный формат ссылки на секрет {#wrong-secret-format}

Проверьте формат: `secrets:<путь>#<ключ>`. Слеш перед `#` не нужен, символ `#` обязателен.

Примеры:

* Правильно: `secrets:secret/data/myapp/database#password`.
* Неправильно: `vault:secret/data/myapp/database#password` (устаревший префикс `vault:`).
* Неправильно: `secrets:secret/data/myapp/database` (нет `#ключ`).

## Под не запускается: `no command is given` {#no-command}

### Симптом

```
level=ERROR msg="no command is given, stackland-secrets-injector can't determine the entrypoint"
```

Основной контейнер не стартует. В Env mode инжектор подменяет команду контейнера на себя, получает секреты, а затем заменяет себя процессом приложения. Если не заданы ни `command`, ни `args`, инжектор не знает, что запускать.

### Решение

Явно задайте `command` в спецификации контейнера или `args`, где первый элемент — исполняемый файл. ENTRYPOINT из Docker-образа автоматически не используется.

Пример для Java-приложения:

```yaml
containers:
  - name: app
    image: myapp:latest
    command:
      - /bin/sh
      - -c
      - "java -jar app.jar"
    env:
      - name: DB_PASSWORD
        value: "secrets:secret/data/myapp/database#password"
```

Пример для Go/бинарного приложения:

```yaml
containers:
  - name: app
    image: myapp:latest
    command:
      - /app/myapp
    args:
      - --config=/config/app.yaml
    env:
      - name: API_KEY
        value: "secrets:secret/data/myapp/api#key"
```

## Инъекция не происходит для некоторых контейнеров {#multi-container}

### Симптом

В поде несколько контейнеров, но мутация не применяется ни к одному из них.

### Решение

Если в поде несколько контейнеров и аннотация `containers` не задана, вебхук отклоняет создание пода, Deployment завершается ошибкой. Укажите явный список контейнеров:

```yaml
annotations:
  secrets.stackland.yandex.cloud/render-env: "true"
  secrets.stackland.yandex.cloud/role: "myapp"
  secrets.stackland.yandex.cloud/containers: "app,worker"
```

## Секрет не найден в Secrets Store {#secret-not-found}

### Симптом

В **ConfigMap mode**: инжектор (init-контейнер) завершается с ошибкой о том, что секрет не найден, под переходит в `Init:Error`.

В **Env mode**: основной контейнер завершается с ошибкой, под переходит в `Error` или `CrashLoopBackOff`.

### Причины и решения

#### Путь к секрету указан неверно {#wrong-secret-path}

Проверьте путь. В Secrets Store KV v2 данные находятся по пути `secret/data/<имя>`, а не `secret/<имя>`:

* KV v2: `secrets:secret/data/myapp/database#password`.
* KV v1: `secrets:secret/myapp/database#password`.

#### Роль не имеет доступа к этому пути {#role-no-access}

Проверьте policy, привязанную к роли. Она должна разрешать `read` для нужного пути:

```hcl
path "secret/data/myapp/*" {
  capabilities = ["read"]
}
```

#### Роль не привязана к ServiceAccount пода {#role-not-bound}

Проверьте привязку роли:

```bash
bao read auth/kubernetes/role/myapp
```

В выводе должны быть ServiceAccount и пространство имен пода.

#### Продолжить работу при отсутствующих секретах {#ignore-missing}

Если часть секретов может отсутствовать и это допустимо, используйте:

```yaml
annotations:
  secrets.stackland.yandex.cloud/ignore-missing-secrets: "true"
```

## Проверка работы вебхука {#check-webhook}

Убедитесь, что вебхук работает и обрабатывает запросы:

```bash
# Проверить наличие подов webhook
kubectl get pods -n stackland-secrets-store -l app.kubernetes.io/name=stackland-secrets-webhook

# Проверить логи webhook при создании пода
kubectl logs -n stackland-secrets-store -l app.kubernetes.io/name=stackland-secrets-webhook --tail=50
```

В логах вебхука при успешной обработке должна быть строка:

```
level=INFO msg="Admission review request handled" ... duration=...ms
```

Если вебхук недоступен и `failurePolicy: Fail` (значение по умолчанию), поды в пространствах имен с включенной инъекцией не запустятся. Проверьте статус вебхука и подов в пространстве имен `stackland-secrets-store`.

## Ошибка TLS при подключении к Secrets Store {#tls-error}

### Симптом

```
level=ERROR msg="failed to connect to vault" error="x509: certificate signed by unknown authority"
```

### Решение

Если сертификат Secrets Store не входит в доверенные, используйте аннотацию `skip-tls-verify`:

```yaml
annotations:
  secrets.stackland.yandex.cloud/skip-tls-verify: "true"
```

{% note warning %}

Использование `skip-tls-verify: "true"` в production небезопасно.

{% endnote %}