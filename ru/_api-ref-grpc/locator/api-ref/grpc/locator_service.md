---
editable: false
---

# LocatorService

Набор методов для сервиса Yandex Locator.

| Вызов | Описание |
| --- | --- |
| [GetLocation](#GetLocation) | Возвращает местоположение и радиус точности на основе информации об IP-адресе, вышках сотовой связи и точках доступа Wi-Fi, которые доступны мобильному устройству. |

## Вызовы LocatorService {#calls}

## GetLocation {#GetLocation}

Возвращает местоположение и радиус точности на основе информации об IP-адресе, вышках сотовой связи и точках доступа Wi-Fi, которые доступны мобильному устройству.

**rpc GetLocation ([LocationRequest](#LocationRequest)) returns ([LocationResponse](#LocationResponse))**

### LocationRequest {#LocationRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Идентификатор папки, к которой у вас есть доступ. Требуется для авторизации с пользовательским аккаунтом (см. ресурс `yandex.cloud.iam.v1.UserAccount`) . Не используйте это поле, если вы делаете запрос от имени сервисного аккаунта. Максимальная длина строки в символах — 50.
cell_towers[] | **[CellInfo](#CellInfo)**<br>Массив сотовых вышек, видимых устройству. 
wifi_access_points[] | **[WifiInfo](#WifiInfo)**<br>Массив точек доступа WiFi, видимых устройству. 
ip | **string**<br>IP-адрес в формате IPv4 или IPv6. 


### CellInfo {#CellInfo}

Поле | Описание
--- | ---
mobile_country_code | **int64**<br>Обязательное поле. Mobile Country Code ([MCC](https://en.wikipedia.org/wiki/Mobile_country_code)). Допустимые значения — от 1 до 999 включительно.
mobile_network_code | **int64**<br>Обязательное поле. <ul><li>Для сетей GSM и WCDMA — [MNC](https://en.wikipedia.org/wiki/Mobile_country_code). </li><li>Для CDMA — System ID (SID).</li></ul> Значение должно быть больше 0.
cell_id | **int64**<br>Обязательное поле. <ul><li>Для GSM — Cell ID ([CID](https://en.wikipedia.org/wiki/Cell_ID)). </li><li>Для CDMA — Base Station ID (BID). </li><li>Для WCDMA — UTRAN Cell ID, который является объединением [Radio Network Controller](https://en.wikipedia.org/wiki/Radio_Network_Controller) ID и Cell ID. Указание только значения Cell ID в сетях WCDMA может возвращать неточные результаты.</li></ul> Значение должно быть больше 0.
location_area_code | **int64**<br>Обязательное поле. <ul><li>Для GSM и WCDMA — Location Area Code ([LAC](https://en.wikipedia.org/wiki/Mobility_management#Location_area)). </li><li>Для CDMA — Network ID (NID). </li><li>Для LTE — [Tracking Area Code](https://en.wikipedia.org/wiki/Mobility_management#Tracking_area).</li></ul> Значение должно быть больше 0.
signal_strength | **int64**<br>Обязательное поле. Текущая сила сигнала в дБм. Значение должно быть меньше 0.


### WifiInfo {#WifiInfo}

Поле | Описание
--- | ---
bssid | **string**<br>Обязательное поле. MAC-адрес точки доступа WiFi. Обычно он называется BSS, BSSID или MAC-адресом. <br>Значение - 12 шестнадцатеричных цифр без разделителей `:` (двоеточие). Значение должно соответствовать регулярному выражению ` [0-9a-fA-F]{12} `.
signal_strength | **int64**<br>Обязательное поле. Текущая сила сигнала в дБм. Значение должно быть меньше 0.


### LocationResponse {#LocationResponse}

Поле | Описание
--- | ---
response | **oneof:** `location` или `location_not_found`<br>
&nbsp;&nbsp;location | **[Location](#Location)**<br>Примерное местоположение пользователя. 
&nbsp;&nbsp;location_not_found | **[LocationNotFound](#LocationNotFound)**<br>Описание ошибки, если местоположение пользователя не определено. 


### Location {#Location}

Поле | Описание
--- | ---
latitude | **double**<br>Предполагаемая широта в градусах, значение от -90 до 90. 
longitude | **double**<br>Предполагаемая долгота в градусах, значение от -180 до 180. 
precision | **double**<br>Предполагаемая погрешность расположения в метрах. Представляет собой радиус окружности вокруг местоположения. 


### LocationNotFound {#LocationNotFound}

Поле | Описание
--- | ---
message | **string**<br>Сообщение с причиной. 


