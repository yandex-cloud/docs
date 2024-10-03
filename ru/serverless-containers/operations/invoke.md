---
title: Как вызвать контейнер в {{ serverless-containers-full-name }}
description: Следуя данной инструкции, вы сможете вызвать контейнер.
---

# Вызвать контейнер

Вызвать контейнер можно:
* через [HTTPS](#https);
* с помощью [триггера](../concepts/trigger/index.md);
* с помощью [расширения {{ api-gw-full-name }}](../../api-gateway/concepts/extensions/containers.md).

{% note info %}

Чтобы любой пользователь мог вызвать контейнер без передачи заголовка авторизации, [сделайте контейнер публичным](./container-public.md).

{% endnote %}

## HTTPS {#https}

После создания контейнера вы получите ссылку для вызова. Сделайте HTTPS-запрос, передав [IAM-токен](../../iam/concepts/authorization/iam-token.md) в заголовке `Authorization`:

```bash
curl \
  --header "Authorization: Bearer $(yc iam create-token)" \
  https://bba3fva6ka5g********.{{ serverless-containers-host }}/hello
```
