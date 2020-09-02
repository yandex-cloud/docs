# Постепенное обновление

Чтобы обновить ваш сервис постепенно, выводя из эксплуатации не более *N* машин одновременно:

1. Опишите необходимый [шаблон](../../../concepts/instance-groups/instance-template.md) виртуальной машины.
1. Задайте [политику развертывания](../../../concepts/instance-groups/policies/deploy-policy.md) с ненулевым значением `max_unavailable` — максимальным количеством машин, одновременно выводимых из эксплуатации.
1. Запустите [операцию обновления](../../../operations/instance-groups/update.md) группы.

Например, чтобы обновить группу последовательно, выводя из эксплуатации по одной машине, в `deploy-policy` следует задать следующие параметры:
```
...
deploy-policy:
    max_unavailable: 1
    max_expansion: 0
    ...
...
```

Обновление группы будет выполняться следующим образом:

![Rolling update](../../../../_assets/instance-groups/rolling-update.gif "Rolling update")