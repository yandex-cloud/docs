# Вызвать контейнер

Вызвать контейнер можно:
* через [HTTPS](#https);
* с помощью [триггера](../concepts/trigger/index.md);
* с помощью [расширения {{ api-gw-full-name }}](../../api-gateway/concepts/extensions/containers.md).

{% note info %}

Чтобы любой пользователь мог вызвать контейнер без передачи заголовка авторизации, [сделайте контейнер публичным](container-public.md).

{% endnote %}

## HTTPS {#https}

После создания контейнера вы получите ссылку для вызова. Сделайте HTTPS-запрос, передав [IAM-токен](../../iam/concepts/authorization/iam-token.md) в заголовке `Authorization`:

```bash
curl \
  --header "Authorization: Bearer $(yc iam create-token)" \
  https://bba3fva6ka5g********.{{ serverless-containers-host }}/hello
```

{% note info %}

Возможность вызова контейнера может быть ограничена [политиками авторизации](../../iam/concepts/access-control/access-policies.md#supported-policies).

{% endnote %}