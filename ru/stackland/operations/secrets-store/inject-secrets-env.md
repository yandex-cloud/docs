# Инъекция секретов в переменные окружения (Env mode)

В этом руководстве описано, как настроить подстановку секретов из Secrets Store в переменные окружения пода с помощью Secrets Injector.

## Перед началом {#before-you-begin}

1. Убедитесь, что компонент Secrets Store [установлен и активен](../../concepts/components/secrets-store.md) в кластере.
1. В Secrets Store созданы секреты, к которым должно обращаться приложение.

## Создайте ServiceAccount {#create-sa}

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: myapp-sa
  namespace: myapp-namespace
```

```bash
kubectl apply -f serviceaccount.yaml
```

## Настройте роль в Secrets Store {#configure-role}

[Настройте роль в Secrets Store](../../concepts/components/secrets-store.md#openbao-role) с доступом к нужным путям и привязкой к созданному ServiceAccount.

## Подготовьте Deployment {#create-deployment}

Разместите аннотации в `spec.template.metadata.annotations` шаблона пода:

{% include notitle [Пример Deployment Env mode](../../_includes/yamls/components/secretsstore-env-example.md) %}

Ключевые требования:

* Аннотация `secrets.stackland.yandex.cloud/render-env: "true"` включает Env mode.
* Аннотация `secrets.stackland.yandex.cloud/role` задает роль в Secrets Store.
* В контейнере необходимо задать `command` или `args`, где первый элемент `args` — исполняемый файл. Инжектор использует эти поля для запуска приложения. Если не задано ни одно из этих полей, под не запустится с ошибкой `no command is given`.
* В поле `env` ссылки на секреты имеют формат `secrets:<путь>#<ключ>`.

## Примените манифесты {#apply}

```bash
kubectl apply -f deployment.yaml
```

## Проверьте результат {#verify}

Убедитесь, что под запустился и секреты подставлены:

```bash
# Проверить статус пода
kubectl get pods -n myapp-namespace

# Проверить логи основного контейнера (инжектор работает как обёртка процесса, не как init-контейнер)
kubectl logs <имя_пода> -n myapp-namespace -c app

# Проверить переменные окружения внутри пода
kubectl exec -n myapp-namespace <имя_пода> -- env | grep DB_
```

В логах успешной инъекции в начале вывода должны быть строки:

```
level=INFO msg="found secret references" count=2
level=INFO msg="successfully injected secrets" count=2
level=INFO msg="spawning process" binary=...
```

## Использование нескольких контейнеров {#multi-container}

Если в поде несколько контейнеров и нужно инжектировать секреты только в часть из них, используйте аннотацию `containers`:

```yaml
annotations:
  secrets.stackland.yandex.cloud/render-env: "true"
  secrets.stackland.yandex.cloud/role: "myapp"
  secrets.stackland.yandex.cloud/containers: "app,worker"
```

Если аннотация `containers` не задана и контейнеров несколько, вебхук отклоняет создание пода, Deployment завершается ошибкой.

## Диагностика {#troubleshooting}

Если секреты не подставляются, смотрите раздел [{#T}](troubleshooting.md).
