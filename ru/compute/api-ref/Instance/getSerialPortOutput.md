# Метод getSerialPortOutput
Возвращает вывод последовательного порта указанного ресурса
Instance.
 

 
## HTTP-запрос {#https-request}
`GET https://compute.api.cloud.yandex.net/compute/v1/instances/{instanceId}:serialPortOutput`
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
instanceId | Обязательное поле. Идентификатор виртуальной машины для получения вывода последовательного порта.  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
contents | **string**<br><p>Содержимое вывода последовательного порта, начиная с момента начала загрузки экземпляра.</p> 