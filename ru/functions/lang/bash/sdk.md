# Использование SDK для функции на Bash

В среду выполнения по умолчанию установлена утилита [{{ yandex-cloud }} CLI](../../../cli/) для работы с API {{ yandex-cloud }}.

Взаимодействие с сервисами {{ yandex-cloud }} происходит с помощью [сервисного аккаунта](../../operations/function-sa.md), указанного в функции на Bash. В этом случае пользователь не совершает дополнительных действий: утилита применяет сервисный аккаунт автоматически.

Например, вы можете получить список каталогов в облаке, используя скрипт:

```shell script
#!/bin/bash
set -e

HOME=/tmp yc --format json resource-manager folder list --cloud-id <идентификатор_облака> | jq -c  '{body:. | tostring}'
```

Чтобы команды {{ yandex-cloud }} CLI выполнялись успешно, указывайте в них идентификатор нужного [каталога](../../../resource-manager/operations/folder/get-id.md) или [облака](../../../resource-manager/operations/cloud/get-id.md) с помощью параметров `--folder-id` или `--cloud-id`.
 
Для работы с [сервисами {{ yandex-cloud }}, которые совместимы с API AWS](../../../iam/concepts/authorization/access-key.md#supported-services), в среду выполнения установлена утилита [AWS CLI version 2](https://docs.aws.amazon.com/cli/index.html). Чтобы использовать ее:
1. [Создайте](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) статический ключ доступа для сервисного аккаунта.
1. [Сохраните](../../../lockbox/operations/secret-create.md) статический ключ доступа в секрет {{ lockbox-full-name }}.
1. [Передайте](../../operations/function/lockbox-secret-transmit.md) секрет {{ lockbox-full-name }} в функцию.

Более подробную информацию с примерами команд можно найти на странице [AWS Command Line Interface](../../../storage/tools/aws-cli.md) и в документации AWS-совместимых сервисов {{ yandex-cloud }}.
