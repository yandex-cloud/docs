---
editable: false
---

# Locator API, REST: Locator.getLocation
Returns a location and accuracy radius based on information about IP address,
cell towers and WiFi access points that the mobile client can detect.
 

 
## HTTP request {#https-request}
```
POST https://locator.{{ api-host }}/locator/v1/getLocation
```
 
## Body parameters {#body_params}
 
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
  "ip": "string",
  "uuid": "string"
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>ID of the folder to which you have access. Required for authorization with a user account (see <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a> resource). Don't specify this field if you make the request on behalf of a service account.</p> <p>The maximum string length in characters is 50.</p> 
cellTowers[] | **object**<br><p>An array of visible cell towers around device.</p> 
cellTowers[].<br>mobileCountryCode | **string** (int64)<br><p>Required. Mobile Country Code (<a href="https://en.wikipedia.org/wiki/Mobile_country_code">MCC</a>).</p> <p>Acceptable values are 1 to 999, inclusive.</p> 
cellTowers[].<br>mobileNetworkCode | **string** (int64)<br><p>Required. The cell tower's Mobile Network Code:</p> <ul> <li>For GSM and WCDMA networks - <a href="https://en.wikipedia.org/wiki/Mobile_country_code">MNC</a>.</li> <li>For CDMA - System ID (SID).</li> </ul> <p>Value must be greater than 0.</p> 
cellTowers[].<br>cellId | **string** (int64)<br><p>Required. Unique identifier of the cell:</p> <ul> <li>For GSM - Cell ID (<a href="https://en.wikipedia.org/wiki/Cell_ID">CID</a>.</li> <li>For CDMA - Base Station ID (BID).</li> <li>For WCDMA - UTRAN Cell ID which is a concatenation of the <a href="https://en.wikipedia.org/wiki/Radio_Network_Controller">Radio Network Controller</a> ID and Cell ID. Specifying only the Cell ID value in WCDMA networks may return inaccurate results.</li> </ul> <p>Value must be greater than 0.</p> 
cellTowers[].<br>locationAreaCode | **string** (int64)<br><p>Required.</p> <ul> <li>For GSM and WCDMA - Location Area Code (<a href="https://en.wikipedia.org/wiki/Mobility_management#Location_area">LAC</a>).</li> <li>For CDMA - Network ID (NID).</li> <li>For LTE - <a href="https://en.wikipedia.org/wiki/Mobility_management#Tracking_area">Tracking Area Code</a>.</li> </ul> <p>Value must be greater than 0.</p> 
cellTowers[].<br>signalStrength | **string** (int64)<br><p>Required. The current signal strength measured in dBm.</p> <p>Value must be less than 0.</p> 
wifiAccessPoints[] | **object**<br><p>An array of visible WiFi access points around device.</p> 
wifiAccessPoints[].<br>bssid | **string**<br><p>Required. The MAC address of the WiFi access point. It's typically called a BSS, BSSID or MAC address.</p> <p>The value is 12 hexadecimal digits without ``:`` (colon) separators.</p> <p>Value must match the regular expression ``[0-9a-fA-F]{12}``.</p> 
wifiAccessPoints[].<br>signalStrength | **string** (int64)<br><p>Required. The current signal strength measured in dBm.</p> <p>Value must be less than 0.</p> 
ip | **string**<br><p>User IP address in IPv4 or IPv6 format.</p> 
uuid | **string**<br><p>Unique user identifier that can be used for debugging. May be empty.</p> <p>The maximum string length in characters is 64. Value must match the regular expression ``[A-Za-z0-9._-]``.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{

  //  includes only one of the fields `location`, `locationNotFound`
  "location": {
    "latitude": "number",
    "longitude": "number",
    "precision": "number"
  },
  "locationNotFound": {
    "message": "string"
  },
  // end of the list of possible fields

}
```

 
Field | Description
--- | ---
location | **object**<br>The user's estimated location. <br> includes only one of the fields `location`, `locationNotFound`<br>
location.<br>latitude | **number** (double)<br><p>Assumed location latitude in degrees, from -90 to 90.</p> 
location.<br>longitude | **number** (double)<br><p>Assumed location longitude in degrees, from -180 to 180.</p> 
location.<br>precision | **number** (double)<br><p>Assumed location precision in meters. This represents the radius of a circle around this location.</p> 
locationNotFound | **object**<br>An error description if the user's location was not found. <br> includes only one of the fields `location`, `locationNotFound`<br>
locationNotFound.<br>message | **string**<br><p>Message with the reason.</p> 