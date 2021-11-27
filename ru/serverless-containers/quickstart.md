# Начало работы

В этой инструкции вы [подготовите](#prepare) Docker-образ контейнера в {{ container-registry-full-name }} и [добавите](#deploy) его в {{ serverless-containers-name }}.

## Подготовьте Docker-образ контейнера {#prepare}

- [Разработка контейнера на языке Go](lang/golan/index.md)
- [Разработка контейнера на языке JavaScript](lang/nodejs/index.md)

## Добавьте образ в {{ serverless-containers-name }} {#deploy}

### Создайте контейнер {#create-container}

{% include [create-container](../_includes/serverless-containers/create-container.md) %}

### Создайте ревизию контейнера {#create-revision}

{% include [create-revision](../_includes/serverless-containers/create-revision.md) %}

## Вызовите контейнер {#invoke}

После создания контейнера вы получите ссылку для вызова. [Как узнать ее.](./operations/invoke.md#link) Сделайте HTTPS-запрос, передав [IAM-токен](../iam/concepts/authorization/iam-token.md) в заголовке `Authorization`:

```
curl -H "Authorization: Bearer $(yc iam create-token)" https://bba3fva6ka5g********.containers.yandexcloud.net/hello
```

Результат:

```
Hello world!
```
