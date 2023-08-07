# Использование SDK для функции на Bash

В среду выполнения по умолчанию установлена утилита [YC CLI](../../../cli/) для работы с API {{ yandex-cloud }}.

Взаимодействие с сервисами {{ yandex-cloud }} происходит с помощью [сервисного аккаунта](../../operations/function-sa.md), указанного в функции на Bash. В этом случае пользователь не совершает дополнительных действий: утилита применяет сервисный аккаунт автоматически.

Например, вы можете получить список каталогов в облаке, используя скрипт:

```shell script
#!/bin/bash
set -e

HOME=/tmp yc --format json resource-manager folder list --cloud-id bqg1a8m7acm******** | jq -c  '{body:. | tostring}'
```

Чтобы команды YC CLI выполнялись успешно, указывайте в них идентификатор нужного [каталога](../../../resource-manager/operations/folder/get-id.md) или [облака](../../../resource-manager/operations/cloud/get-id.md) с помощью флагов `--folder-id` или `--cloud-id`.
 
Также для работы с совместимыми сервисами {{ yandex-cloud }} — [Yandex Object Storage](../../../storage/) и [Yandex Message Queue](../../../message-queue/) — в среду выполнения установлена утилита [AWS CLI version 2](https://docs.aws.amazon.com/cli/index.html).

В этом случае выпишите [статические ключи доступа для сервисного аккаунта](../../../iam/operations/sa/create-access-key.md) и передайте их, например, через [переменные окружения](../../concepts/runtime/environment-variables.md) функции.

Более подробную информацию с примерами команд можно найти на странице [AWS Command Line Interface](../../../storage/tools/aws-cli.md) и в документации [Yandex Message Queue](../../../message-queue/instruments/index.md).



