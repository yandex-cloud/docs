Роль `functions.viewer` позволяет просматривать информацию о функциях, в том числе код и переменные окружения версий функций, а также информацию о триггерах и подключениях к управляемым БД.

Пользователи с этой ролью могут:
* просматривать список [функций](../../functions/concepts/function.md) и информацию о них;
* просматривать переменные [окружения](../../functions/concepts/runtime/environment-variables.md) и программный код [версий](../../functions/concepts/function.md#version) функций;
* просматривать список [триггеров](../../functions/concepts/trigger/index.md) и информацию о них;
* просматривать список подключений к БД и информацию о таких подключениях;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ресурсам сервиса Cloud Functions;
* просматривать информацию о [квотах](../../functions/concepts/limits.md#functions-quotas) сервиса Cloud Functions;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `functions.auditor`.