# Поиск в лог-группе

## Кто удалил каталог

Поиск по идентификатору:
```json
json_payload.event_type="yandex.cloud.audit.resourcemanager.DeleteFolder" and json_payload.details.folder_id="<идентификатор каталога>"
```
Поиск по названию:
```json
json_payload.event_type="yandex.cloud.audit.resourcemanager.DeleteFolder" and json_payload.details.folder_name="<название каталога>"
```

## Кто создал/остановил/перезапустил/удалил виртуальную машину

Поиск по идентификатору виртуальной машины:
```json
json_payload.details.instance_id="<<идентификатор виртуальной машины>>" and (json_payload.event_type="yandex.cloud.audit.compute.CreateInstance" or json_payload.event_type="yandex.cloud.audit.compute.UpdateInstance" or json_payload.event_type="yandex.cloud.audit.compute.DeleteInstance" or json_payload.event_type="yandex.cloud.audit.compute.StartInstance" or json_payload.event_type="yandex.cloud.audit.compute.StopInstance" or json_payload.event_type="yandex.cloud.audit.compute.RestartInstance")
```

## Какие действия совершал конкретный пользователь за период времени

Поиск по идентификатору пользователя:
```json
json_payload.authentication.subject_id="<идентификатор_пользователя>" and json_payload.event_time>"2021-03-01" and json_payload.event_time<"2021-04-01"
```
Поиск по имени пользователя:
```json
json_payload.authentication.subject_name="<имя_пользователя>" and json_payload.event_time>"2021-03-01" and json_payload.event_time<"2021-04-01"
```

## Поиск событий по объектам определенного каталога

Поиск по идентификатору каталога:
```json
json_payload.resource_metadata.path[1].resource_type="resource-manager.folder" and json_payload.resource_metadata.path[1].resource_id="<идентификатор каталога>") or (json_payload.resource_metadata.path[2].resource_type="resource-manager.folder" and json_payload.resource_metadata.path[2].resource_id="<идентификатор каталога>"
```

Поиск по имени каталога:
```json
json_payload.resource_metadata.path[1].resource_type="resource-manager.folder" and json_payload.resource_metadata.path[1].resource_name="<имя каталога>") or (json_payload.resource_metadata.path[2].resource_type="resource-manager.folder" and json_payload.resource_metadata.path[2].resource_name="<имя каталога>"
```