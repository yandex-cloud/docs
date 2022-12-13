---
editable: false
---

# Locator API, gRPC: LocatorService

A set of methods for the Locator service.

| Call | Description |
| --- | --- |
| [GetLocation](#GetLocation) | Returns a location and accuracy radius based on information about IP address, cell towers and WiFi access points that the mobile client can detect. |

## Calls LocatorService {#calls}

## GetLocation {#GetLocation}

Returns a location and accuracy radius based on information about IP address, cell towers and WiFi access points that the mobile client can detect.

**rpc GetLocation ([LocationRequest](#LocationRequest)) returns ([LocationResponse](#LocationResponse))**

### LocationRequest {#LocationRequest}

Field | Description
--- | ---
folder_id | **string**<br>ID of the folder to which you have access. Required for authorization with a user account (see `yandex.cloud.iam.v1.UserAccount` resource). Don't specify this field if you make the request on behalf of a service account. The maximum string length in characters is 50.
cell_towers[] | **[CellInfo](#CellInfo)**<br>An array of visible cell towers around device. 
wifi_access_points[] | **[WifiInfo](#WifiInfo)**<br>An array of visible WiFi access points around device. 
ip | **string**<br>User IP address in IPv4 or IPv6 format. 
uuid | **string**<br>Unique user identifier that can be used for debugging. May be empty. Value must match the regular expression ` [A-Za-z0-9._-] `. The maximum string length in characters is 64.


### CellInfo {#CellInfo}

Field | Description
--- | ---
mobile_country_code | **int64**<br>Required. Mobile Country Code ([MCC](https://en.wikipedia.org/wiki/Mobile_country_code)). Acceptable values are 1 to 999, inclusive.
mobile_network_code | **int64**<br>Required. The cell tower's Mobile Network Code: <br><ul><li>For GSM and WCDMA networks - [MNC](https://en.wikipedia.org/wiki/Mobile_country_code). </li><li>For CDMA - System ID (SID).</li></ul> Value must be greater than 0.
cell_id | **int64**<br>Required. Unique identifier of the cell: <br><ul><li>For GSM - Cell ID ([CID](https://en.wikipedia.org/wiki/Cell_ID). </li><li>For CDMA - Base Station ID (BID). </li><li>For WCDMA - UTRAN Cell ID which is a concatenation of the [Radio Network Controller](https://en.wikipedia.org/wiki/Radio_Network_Controller) ID and Cell ID. Specifying only the Cell ID value in WCDMA networks may return inaccurate results.</li></ul> Value must be greater than 0.
location_area_code | **int64**<br>Required. <br><ul><li>For GSM and WCDMA - Location Area Code ([LAC](https://en.wikipedia.org/wiki/Mobility_management#Location_area)). </li><li>For CDMA - Network ID (NID). </li><li>For LTE - [Tracking Area Code](https://en.wikipedia.org/wiki/Mobility_management#Tracking_area).</li></ul> Value must be greater than 0.
signal_strength | **int64**<br>Required. The current signal strength measured in dBm. Value must be less than 0.


### WifiInfo {#WifiInfo}

Field | Description
--- | ---
bssid | **string**<br>Required. The MAC address of the WiFi access point. It's typically called a BSS, BSSID or MAC address. <br>The value is 12 hexadecimal digits without `:` (colon) separators. Value must match the regular expression ` [0-9a-fA-F]{12} `.
signal_strength | **int64**<br>Required. The current signal strength measured in dBm. Value must be less than 0.


### LocationResponse {#LocationResponse}

Field | Description
--- | ---
response | **oneof:** `location` or `location_not_found`<br>
&nbsp;&nbsp;location | **[Location](#Location)**<br>The user's estimated location. 
&nbsp;&nbsp;location_not_found | **[LocationNotFound](#LocationNotFound)**<br>An error description if the user's location was not found. 


### Location {#Location}

Field | Description
--- | ---
latitude | **double**<br>Assumed location latitude in degrees, from -90 to 90. 
longitude | **double**<br>Assumed location longitude in degrees, from -180 to 180. 
precision | **double**<br>Assumed location precision in meters. This represents the radius of a circle around this location. 


### LocationNotFound {#LocationNotFound}

Field | Description
--- | ---
message | **string**<br>Message with the reason. 


