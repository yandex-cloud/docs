# Настройка AWS CLI

Для управления очередями и сообщениями в {{ message-queue-name }} можно использовать [AWS CLI](https://aws.amazon.com/ru/cli/).

Чтобы настроить AWS CLI для работы с {{ message-queue-name }}:

1. [Установите](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) утилиту командной строки AWS CLI.
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт с ролью `editor`.
1. [Создайте](../../iam/operations/sa/create-access-key.md) статические ключи доступа. Надежно сохраните идентификатор и секретный ключ. После того, как вы закроете окно, параметры секретного ключа станут недоступны.
1. Настройте AWS CLI:

   {% include [configure-aws-cli](../../_includes/message-queue/configure-aws-cli.md) %}
