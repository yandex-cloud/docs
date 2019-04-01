# Удалить сетевой балансировщик

---

**[!TAB Консоль управления]**

Чтобы удалить [сетевой балансировщик](../concepts/index.md): 
1. Откройте раздел **Yandex Load Balancer** в каталоге, где требуется удалить балансировщик.
1. Нажмите значок ![image](../../_assets/vertical-ellipsis.svg) в строке балансировщика, который требуется удалить.
1. В открывшемся меню нажмите кнопку **Удалить**.
1. В открывшемся окне нажмите кнопку **Удалить**.

**[!TAB CLI]**

Если у вас еще нет интерфейса командной строки Яндекс.Облака, [установите его](https://cloud.yandex.ru/docs/cli/quickstart#install).

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

1. Посмотрите описание команды CLI для удаления сетевого балансировщика:

   ```
   $ yc load-balancer network-load-balancer delete --help
   ```

1. Получите список всех балансировщиков:

   ```
   $ yc load-balancer network-load-balancer list
   +----------------------+--------------------+-------+
   |          ID          | NAME               |  ...  |
   +----------------------+------+-------------+-------+
   ...
   | b7r97ah2jn5rmo6k1dsk | test-load-balancer |  ...  |
   ...
   +----------------------+------+-------------+-------+
   ```

1. Выберите `ID` или `NAME` нужного балансировщика.
1. Удалите балансировщик:

   ```
   $ yc load-balancer network-load-balancer delete b7r97ah2jn5rmo6k1dsk
   ```


**[!TAB API]**

Удалить балансировщик можно с помощью метода API [delete](../api-ref/NetworkLoadBalancer/delete.md).

---

## Примеры

### Удаление сетевого балансировщика из указанного каталога

---
**[!TAB CLI]**

Чтобы удалить сетевой балансировщик из другого каталога, используйте флаги `--folder-id` или `--folder-name`.

```
$ yc load-balancer network-load-balancer delete test-load-balancer --folder-id b1gnbfd11bq5g5vnjgr4
```
```
$ yc load-balancer network-load-balancer delete test-load-balancer --folder-name test-folder
```

---