---
title: Загрузить binary-артефакт в реестр {{ cloud-registry-full-name }}
description: Следуя данной инструкции, вы загрузите binary-артефакт в реестр {{ cloud-registry-full-name }}.
---

# Загрузить binary-артефакт в реестр

Загрузите [binary-артефакт](../../concepts/art-binary.md) с помощью [HTTP](https://{{ lang }}.wikipedia.org/wiki/HTTP)-запроса методом POST. При отправке запроса используйте аутентификацию по [IAM-токену](../../../iam/concepts/authorization/iam-token.md). Максимальный размер загружаемого файла — 100 МБ.

Пример запроса:

```bash
curl \
  --request PUT \
  --user "iam:<IAM-токен>" \
  --header "X-Checksum-SHA256: <хеш_файла>" \
  --upload-file <локальный_путь_к_файлу> \
  https://{{ cloud-registry }}/binaries/<идентификатор_реестра>/<имя_артефакта>/<версия_артефакта>/<имя_файла_в_реестре>
```

Где:

* В параметре аутентификации `--user` укажите имя пользователя `iam` и значение [IAM-токена](../../../iam/concepts/authorization/iam-token.md).
* В заголовке `X-Checksum-SHA256` вы можете передать хеш загружаемого файла, чтобы после загрузки сервис проверил его целостность. Необязательный заголовок.

    Сгенерировать хеш можно, например, с помощью команды:
    
    ```bash
    openssl dgst -sha256 <путь_к_файлу> | awk '{print $2}'
    ```
* В параметре `--upload-file` укажите локальный путь к загружаемому файлу.
* URL запроса содержит URL реестра, имя и версию артефакта, а также имя файла в реестре. Например:

    ```bash
    https://{{ cloud-registry }}/binaries/cn15fqbr806r********/sample-package/3.5.4/agent-installer.sh
    ```