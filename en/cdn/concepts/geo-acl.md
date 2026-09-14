---
title: Country-based access policy
description: This section describes the CDN resource access policy by country.
---

# Country-based access policy

You can restrict access to content distributed via CDN for users from specified countries using a _country-based access policy_. You can configure such an access policy when [creating](../operations/resources/create-resource.md) or [editing](../operations/resources/configure-geo-acl.md) a CDN resource using the management console or API.

A country-based access policy is determined by the [policy type](#policy-type) and [country list](#country-codes).

{% include [geo-policy-warning](../../_includes/cdn/geo-policy-warning.md) %}

## Policy type {#policy-type}

You can set one of these policy types for a CDN resource:

* `Block specified countries`: Restricts access to the resource from the listed countries and allows access from all other countries.
* `Allow specified countries only`: Allows access to the resource only from the countries on the list and denies access from other countries.

## List of countries {#country-codes}

Countries and territories are specified by uppercase two-letter codes as per the [ISO 3166-1 alpha-2](https://www.iso.org/obp/ui/#search/code/) standard. Multiple codes are separated by commas, e.g., `RU, KZ`.

{% cut "Country and region codes" %}

#|
|| **Country or region** | **Code** | **Country or region** | **Code** ||
|| Andorra | `AD` | United Arab Emirates | `AE` ||
|| Afghanistan | `AF` | Antigua and Barbuda | `AG` ||
|| Anguilla | `AI` | Albania | `AL` ||
|| Armenia | `AM` | Angola | `AO` ||
|| Antarctica | `AQ` | Argentina | `AR` ||
|| American Samoa | `AS` | Austria | `AT` ||
|| Australia | `AU` | Aruba | `AW` ||
|| Åland Islands | `AX` | Azerbaijan | `AZ` ||
|| Bosnia and Herzegovina | `BA` | Barbados | `BB` ||
|| Bangladesh | `BD` | Belgium | `BE` ||
|| Burkina Faso | `BF` | Bulgaria | `BG` ||
|| Bahrain | `BH` | Burundi | `BI` ||
|| Benin | `BJ` | Saint Barthélemy | `BL` ||
|| Bermuda | `BM` | Brunei | `BN` ||
|| Bolivia | `BO` | Bonaire, St. Eustatius and Saba | `BQ` ||
|| Brazil | `BR` | Bahamas | `BS` ||
|| Butane | `BT` | Bouvet Island | `BV` ||
|| Botswana | `BW` | Belarus | `BY` ||
|| Belize | `BZ` | Canada | `CA` ||
|| Cocos Islands | `CC` | Congo (Kinshasa) | `CD` ||
|| Central African Republic | `CF` | Congo (Brazzaville) | `CG` ||
|| Switzerland | `CH` | Côte d'Ivoire | `CI` ||
|| Cook Islands | `CK` | Chile | `CL` ||
|| Cameroon | `CM` | China | `CN` ||
|| Colombia | `CO` | Costa Rica | `CR` ||
|| Cuba | `CU` | Cabo Verde | `CV` ||
|| Curacao | `CW` | Christmas Island | `CX` ||
|| Cyprus | `CY` | Czech Republic | `CZ` ||
|| Germany | `DE` | Djibouti | `DJ` ||
|| Denmark | `DK` | Dominica | `DM` ||
|| Dominican Republic | `DO` | Algeria | `DZ` ||
|| Ecuador | `EC` | Estonia | `EE` ||
|| Egypt | `EG` | Western Sahara | `EH` ||
|| Eritrea | `ER` | Spain | `ES` ||
|| Ethiopia | `ET` | Finland | `FI` ||
|| Fiji | `FJ` | Falkland Islands | `FK` ||
|| Federated States of Micronesia | `FM` | Faroe Islands | `FO` ||
|| France | `FR` | Gabon | `GA` ||
|| Great Britain | `GB` | Grenada | `GD` ||
|| Georgia | `GE` | French Guiana | `GF` ||
|| Guernsey | `GG` | Ghana | `GH` ||
|| Gibraltar | `GI` | Greenland | `GL` ||
|| Gambia | `GM` | Guinea | `GN` ||
|| Guadeloupe | `GP` | Equatorial Guinea | `GQ` ||
|| Greece | `GR` | South Georgia and the South Sandwich Islands | `GS` ||
|| Guatemala | `GT` | Guam | `GU` ||
|| Guinea-Bissau | `GW` | Guyana | `GY` ||
|| Hong Kong | `HK` | Heard and McDonald Islands | `HM` ||
|| Honduras | `HN` | Croatia | `HR` ||
|| Haiti | `HT` | Hungary | `HU` ||
|| Indonesia | `ID` | Ireland | `IE` ||
|| Israel | `IL` | Isle of Man | `IM` ||
|| India | `IN` | British Indian Ocean Territory | `IO` ||
|| Iraq | `IQ` | Iran | `IR` ||
|| Iceland | `IS` | Italy | `IT` ||
|| Jersey | `JE` | Jamaica | `JM` ||
|| Jordan | `JO` | Japan | `JP` ||
|| Kenya | `KE` | Kyrgyzstan | `KG` ||
|| Cambodia | `KH` | Kiribati | `KI` ||
|| Comoros | `KM` | Saint Kitts and Nevis | `KN` ||
|| DPRK | `KP` | South Korea | `KR` ||
|| Kuwait | `KW` | Cayman Islands | `KY` ||
|| Kazakhstan | `KZ` | Laos | `LA` ||
|| Lebanon | `LB` | Saint Lucia | `LC` ||
|| Liechtenstein | `LI` | Sri Lanka | `LK` ||
|| Liberia | `LR` | Lesotho | `LS` ||
|| Lithuania | `LT` | Luxembourg | `LU` ||
|| Latvia | `LV` | Libya | `LY` ||
|| Morocco | `MA` | Monaco | `MC` ||
|| Moldova | `MD` | Montenegro | `ME` ||
|| Saint Martin | `MF` | Madagascar | `MG` ||
|| Marshall Islands | `MH` | North Macedonia | `MK` ||
|| Mali | `ML` | Myanmar (Burma) | `MM` ||
|| Mongolia | `MN` | Macau | `MO` ||
|| Northern Mariana Islands | `MP` | Martinique | `MQ` ||
|| Mauritania | `MR` | Montserrat | `MS` ||
|| Malta | `MT` | Mauritius | `MU` ||
|| Maldives | `MV` | Malawi | `MW` ||
|| Mexico | `MX` | Malaysia | `MY` ||
|| Mozambique | `MZ` | Namibia | `NA` ||
|| New Caledonia | `NC` | Niger | `NE` ||
|| Norfolk Island | `NF` | Nigeria | `NG` ||
|| Nicaragua | `NI` | Netherlands | `NL` ||
|| Norway | `NO` | Nepal | `NP` ||
|| Nauru | `NR` | Niue | `NU` ||
|| New Zealand | `NZ` | Oman | `OM` ||
|| Panama | `PA` | Peru | `PE` ||
|| French Polynesia | `PF` | Papua New Guinea | `PG` ||
|| Philippines | `PH` | Pakistan | `PK` ||
|| Poland | `PL` | Saint Pierre and Miquelon | `PM` ||
|| Pitcairn Islands | `PN` | Puerto Rico | `PR` ||
|| Palestinian territories | `PS` | Portugal | `PT` ||
|| Palau | `PW` | Paraguay | `PY` ||
|| Qatar | `QA` | Reunion | `RE` ||
|| Romania | `RO` | Serbia | `RS` ||
|| Russia | `RU` | Rwanda | `RW` ||
|| Saudi Arabia | `SA` | Solomon Islands | `SB` ||
|| Seychelles | `SC` | Sudan | `SD` ||
|| Sweden | `SE` | Singapore | `SG` ||
|| Saint Helena Island | `SH` | Slovenia | `SI` ||
|| Svalbard and Jan Mayen | `SJ` | Slovakia | `SK` ||
|| Sierra Leone | `SL` | San Marino | `SM` ||
|| Senegal | `SN` | Somalia | `SO` ||
|| Suriname | `SR` | South Sudan | `SS` ||
|| Sao Tome and Principe | `ST` | Salvador | `SV` ||
|| Sint Maarten | `SX` | Syria | `SY` ||
|| Eswatini | `SZ` | Turks and Caicos | `TC` ||
|| Chad | `TD` | French Southern Territories | `TF` ||
|| Togo | `TG` | Thailand | `TH` ||
|| Tajikistan | `TJ` | Tokelau | `TK` ||
|| East Timor | `TL` | Turkmenistan | `TM` ||
|| Tunisia | `TN` | Tonga | `TO` ||
|| Turkey | `TR` | Trinidad and Tobago | `TT` ||
|| Tuvalu | `TV` | Taiwan | `TW` ||
|| Tanzania | `TZ` | Ukraine | `UA` ||
|| Uganda | `UG` | United States Minor Outlying Islands | `UM` ||
|| United States | `US` | Uruguay | `UY` ||
|| Uzbekistan | `UZ` | Vatican | `VA` ||
|| Saint Vincent and the Grenadines | `VC` | Venezuela | `VE` ||
|| Virgin Islands (UK) | `VG` | Virgin Islands (USA) | `VI` ||
|| Vietnam | `VN` | Vanuatu | `VU` ||
|| Wallis and Futuna | `WF` | Samoa | `WS` ||
|| Yemen | `YE` | Mayotte | `YT` ||
|| Republic of South Africa | `ZA` | Zambia | `ZM` ||
|| Zimbabwe | `ZW` |  |  ||
|#

{% endcut %}

#### Useful links {#see-also}

* [{#T}](../operations/resources/configure-geo-acl.md)
* [{#T}](../operations/resources/create-resource.md)
* [{#T}](./ip-address-acl.md)
