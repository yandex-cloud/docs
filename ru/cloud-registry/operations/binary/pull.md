---
title: Скачать binary-артефакт из реестра {{ cloud-registry-full-name }}
description: Следуя данной инструкции, вы скачаете binary-артефакт из реестра {{ cloud-registry-full-name }}.
---

# Скачать binary-артефакт из реестра

Скачайте [binary-артефакт](../../concepts/art-binary.md) с помощью [HTTP](https://{{ lang }}.wikipedia.org/wiki/HTTP)-запроса методом GET. При отправке запроса используйте аутентификацию по [IAM-токену](../../../iam/concepts/authorization/iam-token.md).

Пример запроса:

```bash
curl \
  --request GET \
  --user "iam:<IAM-токен>" \
  --location \
  --output <локальный_путь_к_файлу> \
  https://{{ cloud-registry }}/binaries/<идентификатор_реестра>/<имя_артефакта>/<версия_артефакта>
```

Где:

* В параметре аутентификации `--user` укажите имя пользователя `iam` и значение [IAM-токена](../../../iam/concepts/authorization/iam-token.md).
* В параметре `--output` укажите локальный путь и имя файла, в который будет скачан артефакт.
* URL запроса содержит URL реестра, а также имя и версию артефакта. Например:

    ```bash
    https://{{ cloud-registry }}/binaries/cn15fqbr806r********/sample-package/3.5.4
    ```