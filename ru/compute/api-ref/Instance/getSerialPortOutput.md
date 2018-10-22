# Метод getSerialPortOutput
Возвращает вывод последовательного порта указанного ресурса
Instance.
 

 
## HTTP-запрос
`GET /compute/v1/instances/{instanceId}:serialPortOutput`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
instanceId | Обязательное поле. Идентификатор виртуальной машины для получения вывода последовательного порта.  Максимальная длина — 50 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
contents | **string**<br><p>Содержимое вывода последовательного порта, начиная с момента начала загрузки экземпляра.</p> 