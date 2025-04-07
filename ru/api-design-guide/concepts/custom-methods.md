---
title: Дополнительные методы API
description: Из статьи вы узнаете про дополнительные методы API {{ yandex-cloud }}, а также ознакомитесь с примером дополнительного метода.
---

# Дополнительные методы

Дополнительные методы API позволяют выполнять операции, которые нельзя выполнить средствами стандартных методов. Например, запустить или остановить [виртуальную машину](../../glossary/vm.md).

Для каждого сервиса доступен свой набор дополнительных методов. Списки методов приведены в справочниках к соответствующим API.

Дополнительным методам ставится в соответствие HTTP-метод `POST`. Сигнатура дополнительных методов отличается от стандартной сигнатуры HTTP-методов. Название дополнительного метода указывается в URL ресурса, после знака <q>:</q>.

Пример gRPC-описания метода [AttachDisk](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/instance_service.proto):

```protobuf
 rpc AttachDisk (AttachInstanceDiskRequest) returns (operation.Operation) {
   option (google.api.http) = {
     post: "/compute/v1/instances/{instance_id}:attachDisk" body: "*"
   };
   // В поле `metadata` объекта Operation
   // содержится представление `AttachInstanceDiskMetadata`.
   // В случае успешного завершения операции
   // в поле `response` объекта Operation
   // содержится представление измененной виртуальной машины.
   option (yandex.api.operation) = {
     metadata: "AttachInstanceDiskMetadata"
     response: "Instance"
   };
 }
 message AttachInstanceDiskRequest {
   // Идентификатор виртуальной машины, к которой
   // требуется подключить диск.
   string instance_id = 1;

   // Подключаемый диск.
   AttachedDiskSpec attached_disk_spec = 2;
 }

 message AttachInstanceDiskMetadata {
   // Идентификатор виртуальной машины,
   // к которой подключается диск.
   string instance_id = 1;

   // Идентификатор подключаемого диска.
   string disk_id = 2;
 }
```

Пример подключения диска в REST:
```json
POST https://compute.{{ api-host }}/compute/v1/instances/e0m97h0gbq0foeuis03:attachDisk

 {
   "attachedDiskSpec": {
     ...
   }
 }
```

