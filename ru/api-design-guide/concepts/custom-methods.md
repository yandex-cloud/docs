# Дополнительные методы

Дополнительные методы API позволяют выполнять операции, которые нельзя выполнить средствами
 стандартных методов. Например, запустить или остановить виртуальную машину.

Для каждого сервиса доступен свой набор дополнительных методов. Списки методов приведены в
 справочниках к соответствующим API.
 
> [!NOTE]
>
> Справочники gRPC API находятся в разработке и будут опубликованы в ближайшее время.

Дополнительным методам ставится в соответствие HTTP-метод `POST`. 
Сигнатура дополнительных методов отличается от стандартной сигнатуры
HTTP-методов. Название дополнительного метода указывается в URL ресурса, после знака <q>:</q>. Например:

> gRPC-описание метода `AttachDisk`:
>```protobuf
> rpc AttachDisk (AttachInstanceDiskRequest) returns (operation.Operation) {
>   option (google.api.http) = {
>     post: "/compute/v1/instances/{instance_id}:attachDisk"
>     body: "*"
>   };
>   // Возвращает представление виртуальной машины.
>   option (yandex.api.operation) = {
>     metadata: "AttachInstanceDiskMetadata"
>     response: "Instance"
>   };
> }
> message AttachInstanceDiskRequest {
>   // Идентификатор виртуальной машины, к которой
>   // требуется подключить диск.
>   string instance_id = 1;
> 
>   // Подключаемый диск.
>   AttachedDiskSpec attached_disk_spec = 2;
> }
>```
>Пример подключения диска в REST:
>```json
>POST https://compute.api.cloud.yandex.net/compute/v1/instances/e0m97h0gbq0foeuis03:attachDisk
>
> {
>   "attachedDiskSpec": {
>     ...
>   }
> }
>```

