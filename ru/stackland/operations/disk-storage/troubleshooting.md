# Диагностика дисковой подсистемы

На этой странице описаны типовые проблемы дисковой подсистемы {{ stackland-name }} и способы их устранения.

## Диагностика состояния {#diagnostics}

Проверьте состояние Volume Groups на всех узлах:

```bash
kubectl get volumegroups -A -o wide
```

Проверьте условия синхронизации:

```bash
kubectl get volumegroups -A -o custom-columns="NAME:.metadata.name,NODE:.spec.nodeName,REASON:.status.conditions[0].reason,STATUS:.status.conditions[0].status"
```

Для детальной диагностики подключитесь к поду topovgm-operator на нужном узле. В поде доступны все утилиты LVM:

```bash
kubectl -n stackland-volumes exec -it <имя_пода_topovgm> -- sh
```

Внутри пода выполните команды LVM:

```bash
pvs   # список физических томов
vgs   # список Volume Groups
lvs   # список логических томов
```

## Типовые проблемы {#common-issues}

В разделе перечислены типовые проблемы дисковой подсистемы и меры для их исправления.

### VolumeGroupSyncedOnNode = False {#vg-not-synced}

Условие `VolumeGroupSyncedOnNode` в статусе ресурса `VolumeGroup` имеет значение `False`.

* Диск отсутствует или недоступен. Проверьте физическое подключение диска. Выполните `pvs` в поде topovgm-operator и убедитесь, что все физические тома видны.
* Ошибка инициализации Volume Group. Проверьте логи оператора:

  ```bash
  kubectl -n stackland-volumes logs -l app.kubernetes.io/name=topovgm-operator --tail=100
  ```

* Диск содержит данные и не прошел автоматическое обнаружение. Проверьте поле `status.discoveredDevices` ресурса `VolumeGroup` — там указана причина исключения диска.

### PhantomDeviceDetected {#phantom-device}

На узле установлено условие `PhantomDeviceDetected`. Это означает, что диск, ранее входивший в Volume Group, временно недоступен, но его метаданные сохранились в LVM.

1. Проверьте физическое подключение диска.
1. Если диск переподключен, оператор автоматически обновит таблицы device-mapper и восстановит Volume Group.
1. Если диск заменен, следуйте процедуре [замены поврежденного диска](#disk-replacement).

### PVC зависает в состоянии Pending {#pvc-pending}

`PersistentVolumeClaim` долго находится в состоянии `Pending`.

* Недостаточно свободного места в Volume Group нужного типа. Проверьте свободное место:

  ```bash
  kubectl get volumegroups -A -o custom-columns="NAME:.metadata.name,NODE:.spec.nodeName,FREE:.status.free,SIZE:.status.size"
  ```

* Указан несуществующий Storage Class. Проверьте имя Storage Class в манифесте PVC. Допустимые значения: `stackland-nvme`, `stackland-ssd`, `stackland-hdd`, `stackland-other`.
* На узлах нет дисков нужного типа. Например, если указан `stackland-nvme`, но NVMe-дисков нет, Volume Group для этого типа не создается.

### Ошибки I/O на диске {#io-errors}

В [мониторинге оборудования](../../concepts/hardware-monitoring.md) срабатывает алерт `DiskIOErrors`. Приложения сообщают об ошибках записи или чтения.

1. Определите проблемный диск по дашборду **Hardware Monitoring** в Grafana.
1. Если  по данным [SMART-мониторинга](../../concepts/hardware-monitoring.md) диск неисправен, следуйте процедуре [замены поврежденного диска](#disk-replacement).

## Замена поврежденного диска {#disk-replacement}

{% note warning %}

Перед заменой диска убедитесь, что данные на нем защищены резервной копией или реплицированы. Если на диске есть логические тома с данными, которые не реплицированы, данные будут потеряны.

{% endnote %}

### Шаг 1. Определите поврежденный диск {#identify-disk}

Найдите Volume Group с проблемным диском:

```bash
kubectl get volumegroups -A -o wide
```

Получите детальный статус Volume Group:

```bash
kubectl describe volumegroup <имя_vg> -n stackland-volumes
```

В поле `status.physicalVolumes` найдите диск с атрибутом `attributes`, содержащим признак отсутствия (`m` — missing).

Подключитесь к поду topovgm-operator на нужном узле и проверьте состояние физических томов:

```sh
kubectl -n stackland-volumes exec -it <имя_пода_topovgm> -- pvs
```

### Шаг 2. Перенесите данные с диска (если возможно) {#move-data}

Если диск еще доступен и на нем есть данные, перенесите их на другие диски Volume Group:

```sh
kubectl -n stackland-volumes exec -it <имя_пода_topovgm> -- pvmove /dev/<имя_диска>
```

Если диск полностью недоступен, пропустите этот шаг.

### Шаг 3. Удалите диск из Volume Group {#remove-from-vg}

Если диск недоступен, установите политику удаления в ресурсе `VolumeGroup`. Для удаления без данных:

```bash
kubectl patch volumegroup <имя_vg> -n stackland-volumes --type=merge \
  -p '{"spec":{"deviceLossSynchronizationPolicy":"Remove"}}'
```

Оператор автоматически выполнит `vgreduce --removemissing` и удалит отсутствующий физический том из Volume Group.

После завершения верните политику в исходное значение:

```bash
kubectl patch volumegroup <имя_vg> -n stackland-volumes --type=merge \
  -p '{"spec":{"deviceLossSynchronizationPolicy":"Fail"}}'
```

### Шаг 4. Замените физический диск {#replace-physical}

Выполните физическую замену диска на сервере согласно документации производителя оборудования.

### Шаг 5. Убедитесь, что новый диск обнаружен {#verify-discovery}

После замены диска оператор topovgm-operator автоматически обнаружит новый диск при следующем цикле согласования.

Если используется автоматический режим обнаружения (`physicalVolumeSelector` не задан), новый диск будет добавлен в Volume Group автоматически.

Если используется явный селектор (`physicalVolumeSelector` с конкретными путями), обновите ресурс `VolumeGroup`, указав путь к новому диску:

```bash
kubectl edit volumegroup <имя_vg> -n stackland-volumes
```

### Шаг 6. Проверьте восстановление {#verify-recovery}

Убедитесь, что Volume Group синхронизирована:

```bash
kubectl get volumegroup <имя_vg> -n stackland-volumes -o jsonpath='{.status.conditions[0]}'
```

Условие `VolumeGroupSyncedOnNode` должно принять значение `True`.

Проверьте состояние Volume Group в LVM:

```sh
kubectl -n stackland-volumes exec -it <имя_пода_topovgm> -- vgs
```
