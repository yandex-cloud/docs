# Использование SDK для функции на Bash

В среду выполнения по умолчанию установлена утилита [YC CLI](../../../cli/) для работы с API {{ yandex-cloud }}.

Взаимодействие с сервисами {{ yandex-cloud }} происходит с помощью [сервисного аккаунта](../../operations/function-sa.md), указанного в функции на Bash. В этом случае пользователь не совершает дополнительных действий: утилита применяет сервисный аккаунт автоматически.

Например, вы можете получить список доступных вам облаков, используя скрипт:

```shell script
#!/bin/bash
set -e

HOME=/tmp yc --format json resource-manager cloud list | jq -c  '{body:. | tostring}'
```
 
Также для работы с совместимыми сервисами {{ yandex-cloud }} — [Yandex Object Storage](../../../storage/) и [Yandex Message Queue](../../../message-queue/) — в среду выполнения установлена утилита [AWS CLI version 2](https://docs.aws.amazon.com/cli/index.html).

В этом случае выпишите [статические ключи доступа для сервисного аккаунта](../../../iam/operations/sa/create-access-key.md) и передайте их, например, через [переменные окружения](../../concepts/runtime/environment-variables.md) функции.

Более подробную информацию с примерами команд можно найти на странице [AWS Command Line Interface](../../../storage/tools/aws-cli.md) и в документации [Yandex Message Queue](../../../message-queue/instruments/index.md).



