Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса {{ objstorage-short-name }}:

Метка | Значение
----|----
service | Идентификатор сервиса: `storage`
resource_id |  Имя [бакета](../../../storage/concepts/bucket.md)
resource_type | Тип ресурса: `bucket`

Метрики сервиса:

| Имя<br>Тип, единицы измерения | Описание |
| --- | --- |
`max_size`<br/>`DGAUGE`, байты | Максимальный размер бакета. Метрика доступна, если в настройках бакета выставлено ограничение на максимальный размер.
`object_count`<br/>`DGAUGE`, штуки | Количество [объектов](../../../storage/concepts/object.md) в бакете. Специальная метка `object_type` — тип объекта.<br/>Возможные значения:<br/><ul><li>`MultiPart` — объекты, загруженные [по частям (multipart)](../../../storage/concepts/multipart.md).</li><li>`Parts` — части объектов, загруженных по частям.</li><li>`Simple` — объекты, загруженные без разбиения на части.</li></ul>
`rps`<br/>`DGAUGE`, запросы/с | Количество запросов в секунду. Специальная метка `method` — тип операции.<br/>Возможные значения:<br/><ul><li>`GetRequests` — `GET`.</li><li>`HeadRequests` — `HEAD`.</li><li>`ListRequests` — `LIST`.</li><li>`OptionsRequests` — `OPTIONS`.</li><li>`PutRequests` — `PUT`.</li><li>`PostRequests` — `POST`.</li><li>`DeleteRequests` — `DELETE`.</li></ul>
`space_usage`<br/>`DGAUGE`, байты | Использованный объем хранилища.<br/>Специальные метки:<br/><ul><li>`object_type` — тип объекта. Возможные значения:<ul><li>`MultiPart` — объекты, загруженные по частям (multipart).</li><li>`Parts` — части объектов, загруженных по частям.</li><li>`Simple` — объекты, загруженные без разбиения на части.</li></ul></li><li>`storage_type` — [класс хранилища](../../../storage/concepts/storage-class.md). Возможные значения:<ul><li>`All` — все классы.</li><li>`ColdStorage` — холодное.</li><li>`IceStorage` — ледяное.</li><li>`StandardStorage` — стандартное.</li></ul></ul>
`traffic`<br/>`DGAUGE`, байты | Объем трафика. Специальная метка `bytes` — направление трафика относительно хранилища.<br/>Возможные значения:<br/><ul><li>`BytesDownloaded` — исходящий.</li><li>`BytesUploaded` — входящий.</li></ul>