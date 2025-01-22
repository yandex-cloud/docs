
# Масштабирование группы виртуальных машин по расписанию


В этом руководстве вы создадите [группу ВМ](../../compute/concepts/instance-groups/index.md) с помощью сервиса [{{ compute-full-name }}](../../compute/) и настроите для нее [масштабирование](../../compute/concepts/instance-groups/scale.md) по расписанию. Размером группы ВМ будет управлять [функция](../../functions/concepts/function.md) [{{ sf-full-name }}](../../functions/), запускаемая по [таймеру](../../functions/concepts/trigger/timer.md).

Вы можете настроить масштабирование группы ВМ с помощью одного из инструментов:
