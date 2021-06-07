---
editable: false
---

# Метод getLocation
Возвращает местоположение и радиус точности на основе информации об IP-адресе,
вышках сотовой связи и точках доступа Wi-Fi, которые доступны мобильному устройству.
 

 
## HTTP-запрос {#https-request}
```
POST https://locator.api.cloud.yandex.net/locator/v1/getLocation
```
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "folderId": "string",
  "cellTowers": [
    {
      "mobileCountryCode": "string",
      "mobileNetworkCode": "string",
      "cellId": "string",
      "locationAreaCode": "string",
      "signalStrength": "string"
    }
  ],
  "wifiAccessPoints": [
    {
      "bssid": "string",
      "signalStrength": "string"
    }
  ],
  "ip": "string"
}
```

 
Поле | Описание
--- | ---
folderId | **string**<br><p>Идентификатор папки, к которой у вас есть доступ. Требуется для авторизации с пользовательским аккаунтом (см. ресурс <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a> ). Не используйте это поле, если вы делаете запрос от имени сервисного аккаунта.</p> <p>Максимальная длина строки в символах — 50.</p> 
cellTowers[] | **object**<br><p>Массив сотовых вышек, видимых устройству.</p> 
cellTowers[].<br>mobileCountryCode | **string** (int64)<br><p>Обязательное поле. Mobile Country Code (<a href="https://en.wikipedia.org/wiki/Mobile_country_code">MCC</a>).</p> <p>Допустимые значения — от 1 до 999 включительно.</p> 
cellTowers[].<br>mobileNetworkCode | **string** (int64)<br><p>Обязательное поле. Mobile Network Code сотовой вышки:</p> <ul> <li>Для сетей GSM и WCDMA — <a href="https://en.wikipedia.org/wiki/Mobile_country_code">MNC</a>.</li> <li>Для CDMA — System ID (SID).</li> </ul> <p>Значение должно быть больше 0.</p> 
cellTowers[].<br>cellId | **string** (int64)<br><p>Обязательное поле. Уникальный идентификатор соты:</p> <ul> <li>Для GSM — Cell ID (<a href="https://en.wikipedia.org/wiki/Cell_ID">CID</a>).</li> <li>Для CDMA — Base Station ID (BID).</li> <li>Для WCDMA — UTRAN Cell ID, который является объединением <a href="https://en.wikipedia.org/wiki/Radio_Network_Controller">Radio Network Controller</a> ID и Cell ID. Указание только значения Cell ID в сетях WCDMA может возвращать неточные результаты.</li> </ul> <p>Значение должно быть больше 0.</p> 
cellTowers[].<br>locationAreaCode | **string** (int64)<br><p>Обязательное поле.</p> <ul> <li>Для GSM и WCDMA — Location Area Code (<a href="https://en.wikipedia.org/wiki/Mobility_management#Location_area">LAC</a>).</li> <li>Для CDMA — Network ID (NID).</li> <li>Для LTE — <a href="https://en.wikipedia.org/wiki/Mobility_management#Tracking_area">Tracking Area Code</a>.</li> </ul> <p>Значение должно быть больше 0.</p> 
cellTowers[].<br>signalStrength | **string** (int64)<br><p>Обязательное поле. Текущая сила сигнала в дБм.</p> <p>Значение должно быть меньше 0.</p> 
wifiAccessPoints[] | **object**<br><p>Массив точек доступа WiFi, видимых устройству.</p> 
wifiAccessPoints[].<br>bssid | **string**<br><p>Обязательное поле. MAC-адрес точки доступа WiFi. Обычно он называется BSS, BSSID или MAC-адресом.</p> <p>Значение - 12 шестнадцатеричных цифр без разделителей ``:`` (двоеточие).</p> <p>Значение должно соответствовать регулярному выражению ``[0-9a-fA-F]{12}``.</p> 
wifiAccessPoints[].<br>signalStrength | **string** (int64)<br><p>Обязательное поле. Текущая сила сигнала в дБм.</p> <p>Значение должно быть меньше 0.</p> 
ip | **string**<br><p>IP-адрес в формате IPv4 или IPv6.</p> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{

  //  включает только одно из полей `location`, `locationNotFound`
  "location": {
    "latitude": "number",
    "longitude": "number",
    "precision": "number"
  },
  "locationNotFound": {
    "message": "string"
  },
  // конец списка возможных полей

}
```

 
Поле | Описание
--- | ---
location | **object**<br>Примерное местоположение пользователя. <br> включает только одно из полей `location`, `locationNotFound`<br><br>
location.<br>latitude | **number** (double)<br><p>Предполагаемая широта в градусах, значение от -90 до 90.</p> 
location.<br>longitude | **number** (double)<br><p>Предполагаемая долгота в градусах, значение от -180 до 180.</p> 
location.<br>precision | **number** (double)<br><p>Предполагаемая погрешность расположения в метрах. Представляет собой радиус окружности вокруг местоположения.</p> 
locationNotFound | **object**<br>Описание ошибки, если местоположение пользователя не определено. <br> включает только одно из полей `location`, `locationNotFound`<br><br>
locationNotFound.<br>message | **string**<br><p>Сообщение с причиной.</p> 