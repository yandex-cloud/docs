---
editable: false
---

# VersionService

Набор методов для управления версиями Kubernetes.

| Вызов | Описание |
| --- | --- |
| [List](#List) | Возвращает список версий в указанном релизном канале. |

## Вызовы VersionService {#calls}

## List {#List}

Возвращает список версий в указанном релизном канале.

**rpc List ([ListVersionsRequest](#ListVersionsRequest)) returns ([ListVersionsResponse](#ListVersionsResponse))**

### ListVersionsRequest {#ListVersionsRequest}



### ListVersionsResponse {#ListVersionsResponse}

Поле | Описание
--- | ---
available_versions[] | **[AvailableVersions](#AvailableVersions)**<br>Версии, доступные в указанном релизном канале. 


### AvailableVersions {#AvailableVersions}

Поле | Описание
--- | ---
release_channel | enum **ReleaseChannel**<br>Релизный канал: `RAPID`, `REGULAR` или `STABLE`. Дополнительные сведения см. в [документации](https://cloud.yandex.ru/docs/managed-kubernetes/concepts/release-channels-and-updates). <ul><li>`RAPID`: На канале часто появляются минорные обновления, содержащие новую функциональность и улучшения. Вы не можете отключить автоматическое обновление на этом канале, но вы можете указать период времени для автоматического обновления.</li><li>`REGULAR`: Новая функциональность и улучшения порциями попадают на канал через некоторое время после того, как были предоставлены на канале `RAPID`.</li><li>`STABLE`: На канале происходят только обновления, касающиеся исправление ошибок или улучшения безопасности.</li><ul/>
versions[] | **string**<br>Версия компонентов Kubernetes. 


