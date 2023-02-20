1. Посмотрите описание команды CLI для настройки ограничений:

   ```bash
   yc alb load-balancer autoscale --help
   ```

1. Установите ограничения, выполнив команду:

   ```bash
   yc alb load-balancer autoscale <имя_или_ID_балансировщика> \
     --min-zone-size <минимум_ресурсных_единиц_в_зоне> \
     --max-size <максимум_ресурсных_единиц_в_сумме>
   ```

   Где:

   * `--min-zone-size` — минимальное количество ресурсных единиц в каждой зоне доступности. По умолчанию минимум равен 2. Указать минимальное значение меньше 2 нельзя.
   * `--max-size` — максимальное суммарное количество ресурсных единиц. По умолчанию количество не ограничено. Значение должно быть не меньше, чем количество зон доступности балансировщика, умноженное на минимальное количество ресурсных единиц в каждой зоне.

   Вы можете указать в команде один из параметров или оба сразу.

   Пример:

   ```bash
   yc alb load-balancer autoscale test-balancer2 \
     --min-zone-size 3 \
     --max-size 10
   ```

   Результат:

   ```yaml
   id: a5d88ep483cmbfm63g9t
   name: test-balancer2
   folder_id: aoe197919j8elpeg1lkp
   status: ACTIVE
   region_id: {{ region-id }}
   network_id: c64l1c06d15178sa87k0
   allocation_policy:
     locations:
       - zone_id: {{ region-id }}-a
         subnet_id: buc4gsmpj8hvramg61g8
   created_at: "2022-06-02T12:12:13.624832586Z"
   auto_scale_policy:
     min_zone_size: 3
     max_size: 10
   ```