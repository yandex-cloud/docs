# Использование SDK для функции на Bash

В среду выполнения по умолчанию установлена утилита [{{ yandex-cloud }} CLI](../../../cli/) для работы с API {{ yandex-cloud }}.

Взаимодействие с сервисами {{ yandex-cloud }} происходит с помощью [сервисного аккаунта](../../operations/function-sa.md), указанного в функции на Bash. В этом случае пользователь не совершает дополнительных действий: утилита применяет сервисный аккаунт автоматически.

Например, вы можете получить список каталогов в облаке, используя скрипт:

```shell script
#!/bin/bash
set -e

HOME=/tmp yc --format json resource-manager folder list --cloud-id <идентификатор_облака> | jq -c  '{body:. | tostring}'
```

Чтобы команды {{ yandex-cloud }} CLI выполнялись успешно, указывайте в них идентификатор нужного [каталога](../../../resource-manager/operations/folder/get-id.md) или [облака](../../../resource-manager/operations/cloud/get-id.md) с помощью флагов `--folder-id` или `--cloud-id`.
 
Также для работы с совместимыми сервисами {{ yandex-cloud }} — [{{ objstorage-full-name }}](../../../storage/index.yaml) и [{{ message-queue-full-name }}](../../../message-queue/index.yaml) — в среду выполнения установлена утилита [AWS CLI version 2](https://docs.aws.amazon.com/cli/index.html).

В этом случае выпишите [статические ключи доступа для сервисного аккаунта](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) и передайте их, например, через [переменные окружения](../../concepts/runtime/environment-variables.md) функции.

Более подробную информацию с примерами команд можно найти на странице [AWS Command Line Interface](../../../storage/tools/aws-cli.md) и в документации [{{ message-queue-full-name }}](../../../message-queue/instruments/index.md).



