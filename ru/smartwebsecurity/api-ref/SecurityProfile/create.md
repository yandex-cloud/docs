---
editable: false
sourcePath: en/_api-ref/smartwebsecurity/v1/api-ref/SecurityProfile/create.md
---

# SmartWebSecurity API, REST: SecurityProfile.create
Creates a security profile in the specified folder using the data specified in the request.
 

 
## HTTP request {#https-request}
```
POST https://smartwebsecurity.{{ api-host }}/smartwebsecurity/v1/securityProfiles
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "labels": "object",
  "name": "string",
  "description": "string",
  "defaultAction": "string",
  "securityRules": [
    {
      "name": "string",
      "priority": "string",
      "dryRun": true,
      "description": "string",

      // `securityRules[]` includes only one of the fields `ruleCondition`, `smartProtection`
      "ruleCondition": {
        "action": "string",
        "condition": {
          "authority": {
            "authorities": [
              {

                // `securityRules[].ruleCondition.condition.authority.authorities[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                // end of the list of possible fields`securityRules[].ruleCondition.condition.authority.authorities[]`

              }
            ]
          },
          "httpMethod": {
            "httpMethods": [
              {

                // `securityRules[].ruleCondition.condition.httpMethod.httpMethods[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                // end of the list of possible fields`securityRules[].ruleCondition.condition.httpMethod.httpMethods[]`

              }
            ]
          },
          "requestUri": {
            "path": {

              // `securityRules[].ruleCondition.condition.requestUri.path` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              // end of the list of possible fields`securityRules[].ruleCondition.condition.requestUri.path`

            },
            "queries": [
              {
                "key": "string",
                "value": {

                  // `securityRules[].ruleCondition.condition.requestUri.queries[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                  "exactMatch": "string",
                  "exactNotMatch": "string",
                  "prefixMatch": "string",
                  "prefixNotMatch": "string",
                  "pireRegexMatch": "string",
                  "pireRegexNotMatch": "string",
                  // end of the list of possible fields`securityRules[].ruleCondition.condition.requestUri.queries[].value`

                }
              }
            ]
          },
          "headers": [
            {
              "name": "string",
              "value": {

                // `securityRules[].ruleCondition.condition.headers[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                // end of the list of possible fields`securityRules[].ruleCondition.condition.headers[].value`

              }
            }
          ],
          "sourceIp": {
            "ipRangesMatch": {
              "ipRanges": [
                "string"
              ]
            },
            "ipRangesNotMatch": {
              "ipRanges": [
                "string"
              ]
            },
            "geoIpMatch": {
              "locations": [
                "string"
              ]
            },
            "geoIpNotMatch": {
              "locations": [
                "string"
              ]
            }
          }
        }
      },
      "smartProtection": {
        "mode": "string",
        "condition": {
          "authority": {
            "authorities": [
              {

                // `securityRules[].smartProtection.condition.authority.authorities[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                // end of the list of possible fields`securityRules[].smartProtection.condition.authority.authorities[]`

              }
            ]
          },
          "httpMethod": {
            "httpMethods": [
              {

                // `securityRules[].smartProtection.condition.httpMethod.httpMethods[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                // end of the list of possible fields`securityRules[].smartProtection.condition.httpMethod.httpMethods[]`

              }
            ]
          },
          "requestUri": {
            "path": {

              // `securityRules[].smartProtection.condition.requestUri.path` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              // end of the list of possible fields`securityRules[].smartProtection.condition.requestUri.path`

            },
            "queries": [
              {
                "key": "string",
                "value": {

                  // `securityRules[].smartProtection.condition.requestUri.queries[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                  "exactMatch": "string",
                  "exactNotMatch": "string",
                  "prefixMatch": "string",
                  "prefixNotMatch": "string",
                  "pireRegexMatch": "string",
                  "pireRegexNotMatch": "string",
                  // end of the list of possible fields`securityRules[].smartProtection.condition.requestUri.queries[].value`

                }
              }
            ]
          },
          "headers": [
            {
              "name": "string",
              "value": {

                // `securityRules[].smartProtection.condition.headers[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                // end of the list of possible fields`securityRules[].smartProtection.condition.headers[].value`

              }
            }
          ],
          "sourceIp": {
            "ipRangesMatch": {
              "ipRanges": [
                "string"
              ]
            },
            "ipRangesNotMatch": {
              "ipRanges": [
                "string"
              ]
            },
            "geoIpMatch": {
              "locations": [
                "string"
              ]
            },
            "geoIpNotMatch": {
              "locations": [
                "string"
              ]
            }
          }
        }
      },
      // end of the list of possible fields`securityRules[]`

    }
  ],
  "captchaId": "string"
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create a security profile in.</p> 
labels | **object**<br><p>Labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
name | **string**<br><p>Name of the security profile. The name is unique within the folder. 1-50 characters long.</p> 
description | **string**<br><p>Optional description of the security profile.</p> 
defaultAction | **string**<br><p>Action to perform if none of rules matched.</p> <p>Action to perform if none of rules matched.</p> <ul> <li>ALLOW: Pass request to service.</li> <li>DENY: Deny request.</li> </ul> 
securityRules[] | **object**<br><p>List of security rules.</p> 
securityRules[].<br>name | **string**<br><p>Required. Name of the rule. The name is unique within the folder. 1-50 characters long.</p> <p>The string length in characters must be 1-50. Value must match the regular expression ``[a-zA-Z0-9][a-zA-Z0-9-_.]*``.</p> 
securityRules[].<br>priority | **string** (int64)<br><p>Determines the priority for checking the incoming traffic. Enter an integer within the range of 1 and 999999. The rule priority must be unique within the entire security profile. A lower numeric value means a higher priority. The default_action has the lowest priority.</p> <p>Acceptable values are 1 to 999999, inclusive.</p> 
securityRules[].<br>dryRun | **boolean** (boolean)<br><p>This mode allows you to test your security profile or a single rule. For example, you can have the number of alarms for a specific rule displayed. Note: if this option is true, no real action affecting your traffic regarding this rule will be taken.</p> 
securityRules[].<br>description | **string**<br><p>Optional description of the rule. 0-512 characters long.</p> <p>The maximum string length in characters is 512.</p> 
securityRules[].<br>ruleCondition | **object**<br>Rule actions, see [Rule actions](/docs/smartwebsecurity/concepts/rules#rule-action). <br>`securityRules[]` includes only one of the fields `ruleCondition`, `smartProtection`<br>
securityRules[].<br>ruleCondition.<br>action | **string**<br><p>Action to perform if this rule matched.</p> <p>Type of action to perform if this rule matched.</p> <ul> <li>ALLOW: Pass request to service.</li> <li>DENY: Deny request.</li> </ul> 
securityRules[].<br>ruleCondition.<br>condition | **object**<br><p>The condition for matching the rule.</p> <p>Condition object. AND semantics implied. See <a href="/docs/smartwebsecurity/concepts/conditions">documentation</a> for matchers description.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>authority | **object**<br><p>Match authority (Host header).</p> <p>AuthorityMatcher object.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>authority.<br>authorities[] | **object**<br><p>List of authorities. OR semantics implied.</p> <p>The maximum number of elements is 20.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>authority.<br>authorities[].<br>exactMatch | **string** <br>`securityRules[].ruleCondition.condition.authority.authorities[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>authority.<br>authorities[].<br>exactNotMatch | **string** <br>`securityRules[].ruleCondition.condition.authority.authorities[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>authority.<br>authorities[].<br>prefixMatch | **string** <br>`securityRules[].ruleCondition.condition.authority.authorities[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>authority.<br>authorities[].<br>prefixNotMatch | **string** <br>`securityRules[].ruleCondition.condition.authority.authorities[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>authority.<br>authorities[].<br>pireRegexMatch | **string** <br>`securityRules[].ruleCondition.condition.authority.authorities[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>authority.<br>authorities[].<br>pireRegexNotMatch | **string** <br>`securityRules[].ruleCondition.condition.authority.authorities[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>httpMethod | **object**<br><p>Match HTTP method.</p> <p>HttpMethodMatcher object.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>httpMethod.<br>httpMethods[] | **object**<br><p>List of HTTP methods. OR semantics implied.</p> <p>The maximum number of elements is 20.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>httpMethod.<br>httpMethods[].<br>exactMatch | **string** <br>`securityRules[].ruleCondition.condition.httpMethod.httpMethods[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>httpMethod.<br>httpMethods[].<br>exactNotMatch | **string** <br>`securityRules[].ruleCondition.condition.httpMethod.httpMethods[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>httpMethod.<br>httpMethods[].<br>prefixMatch | **string** <br>`securityRules[].ruleCondition.condition.httpMethod.httpMethods[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>httpMethod.<br>httpMethods[].<br>prefixNotMatch | **string** <br>`securityRules[].ruleCondition.condition.httpMethod.httpMethods[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>httpMethod.<br>httpMethods[].<br>pireRegexMatch | **string** <br>`securityRules[].ruleCondition.condition.httpMethod.httpMethods[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>httpMethod.<br>httpMethods[].<br>pireRegexNotMatch | **string** <br>`securityRules[].ruleCondition.condition.httpMethod.httpMethods[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>requestUri | **object**<br><p>Match Request URI.</p> <p>RequestUriMatcher object. AND semantics implied.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>requestUri.<br>path | **object**<br><p>Path of the URI <a href="https://datatracker.ietf.org/doc/html/rfc3986#section-3.3">RFC3986</a>.</p> <p>StringMatcher object.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>requestUri.<br>path.<br>exactMatch | **string** <br>`securityRules[].ruleCondition.condition.requestUri.path` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>requestUri.<br>path.<br>exactNotMatch | **string** <br>`securityRules[].ruleCondition.condition.requestUri.path` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>requestUri.<br>path.<br>prefixMatch | **string** <br>`securityRules[].ruleCondition.condition.requestUri.path` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>requestUri.<br>path.<br>prefixNotMatch | **string** <br>`securityRules[].ruleCondition.condition.requestUri.path` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>requestUri.<br>path.<br>pireRegexMatch | **string** <br>`securityRules[].ruleCondition.condition.requestUri.path` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>requestUri.<br>path.<br>pireRegexNotMatch | **string** <br>`securityRules[].ruleCondition.condition.requestUri.path` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>requestUri.<br>queries[] | **object**<br><p>List of query matchers. AND semantics implied.</p> <p>The maximum number of elements is 20.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>requestUri.<br>queries[].<br>key | **string**<br><p>Required. Key of the query parameter.</p> <p>The string length in characters must be 1-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>requestUri.<br>queries[].<br>value | **object**<br><p>Required. Value of the query parameter.</p> <p>StringMatcher object.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>requestUri.<br>queries[].<br>value.<br>exactMatch | **string** <br>`securityRules[].ruleCondition.condition.requestUri.queries[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>requestUri.<br>queries[].<br>value.<br>exactNotMatch | **string** <br>`securityRules[].ruleCondition.condition.requestUri.queries[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>requestUri.<br>queries[].<br>value.<br>prefixMatch | **string** <br>`securityRules[].ruleCondition.condition.requestUri.queries[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>requestUri.<br>queries[].<br>value.<br>prefixNotMatch | **string** <br>`securityRules[].ruleCondition.condition.requestUri.queries[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>requestUri.<br>queries[].<br>value.<br>pireRegexMatch | **string** <br>`securityRules[].ruleCondition.condition.requestUri.queries[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>requestUri.<br>queries[].<br>value.<br>pireRegexNotMatch | **string** <br>`securityRules[].ruleCondition.condition.requestUri.queries[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>headers[] | **object**<br><p>Match HTTP headers.</p> <p>The maximum number of elements is 20.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>headers[].<br>name | **string**<br><p>Required. Name of header (case insensitive).</p> <p>The string length in characters must be 1-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>headers[].<br>value | **object**<br><p>Required. Value of the header.</p> <p>StringMatcher object.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>headers[].<br>value.<br>exactMatch | **string** <br>`securityRules[].ruleCondition.condition.headers[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>headers[].<br>value.<br>exactNotMatch | **string** <br>`securityRules[].ruleCondition.condition.headers[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>headers[].<br>value.<br>prefixMatch | **string** <br>`securityRules[].ruleCondition.condition.headers[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>headers[].<br>value.<br>prefixNotMatch | **string** <br>`securityRules[].ruleCondition.condition.headers[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>headers[].<br>value.<br>pireRegexMatch | **string** <br>`securityRules[].ruleCondition.condition.headers[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>headers[].<br>value.<br>pireRegexNotMatch | **string** <br>`securityRules[].ruleCondition.condition.headers[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>sourceIp | **object**<br><p>Match IP.</p> <p>IpMatcher object. AND semantics implied.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>sourceIp.<br>ipRangesMatch | **object**<br><p>IpRangesMatcher object.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>sourceIp.<br>ipRangesMatch.<br>ipRanges[] | **string**<br><p>List of IP ranges. OR semantics implied.</p> <p>The maximum number of elements is 10000.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>sourceIp.<br>ipRangesNotMatch | **object**<br><p>IpRangesMatcher object.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>sourceIp.<br>ipRangesNotMatch.<br>ipRanges[] | **string**<br><p>List of IP ranges. OR semantics implied.</p> <p>The maximum number of elements is 10000.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>sourceIp.<br>geoIpMatch | **object**<br><p>GeoIpMatcher object.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>sourceIp.<br>geoIpMatch.<br>locations[] | **string**<br><p>Required. ISO 3166-1 alpha 2. OR semantics implied.</p> <p>The minimum number of elements is 1. The string length in characters for each value must be equal to 2.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>sourceIp.<br>geoIpNotMatch | **object**<br><p>GeoIpMatcher object.</p> 
securityRules[].<br>ruleCondition.<br>condition.<br>sourceIp.<br>geoIpNotMatch.<br>locations[] | **string**<br><p>Required. ISO 3166-1 alpha 2. OR semantics implied.</p> <p>The minimum number of elements is 1. The string length in characters for each value must be equal to 2.</p> 
securityRules[].<br>smartProtection | **object**<br>Smart Protection rule, see [Smart Protection rules](/docs/smartwebsecurity/concepts/rules#smart-protection-rules). <br>`securityRules[]` includes only one of the fields `ruleCondition`, `smartProtection`<br>
securityRules[].<br>smartProtection.<br>mode | **string**<br><p>Mode of protection.</p> <p>Mode of protection.</p> <ul> <li>FULL: Full protection means that the traffic will be checked based on ML models and behavioral analysis, with suspicious requests being sent to SmartCaptcha.</li> <li>API: API protection means checking the traffic based on ML models and behavioral analysis without sending suspicious requests to SmartCaptcha. The suspicious requests will be blocked.</li> </ul> 
securityRules[].<br>smartProtection.<br>condition | **object**<br><p>The condition for matching the rule.</p> <p>Condition object. AND semantics implied. See <a href="/docs/smartwebsecurity/concepts/conditions">documentation</a> for matchers description.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>authority | **object**<br><p>Match authority (Host header).</p> <p>AuthorityMatcher object.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>authority.<br>authorities[] | **object**<br><p>List of authorities. OR semantics implied.</p> <p>The maximum number of elements is 20.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>authority.<br>authorities[].<br>exactMatch | **string** <br>`securityRules[].smartProtection.condition.authority.authorities[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>authority.<br>authorities[].<br>exactNotMatch | **string** <br>`securityRules[].smartProtection.condition.authority.authorities[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>authority.<br>authorities[].<br>prefixMatch | **string** <br>`securityRules[].smartProtection.condition.authority.authorities[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>authority.<br>authorities[].<br>prefixNotMatch | **string** <br>`securityRules[].smartProtection.condition.authority.authorities[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>authority.<br>authorities[].<br>pireRegexMatch | **string** <br>`securityRules[].smartProtection.condition.authority.authorities[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>authority.<br>authorities[].<br>pireRegexNotMatch | **string** <br>`securityRules[].smartProtection.condition.authority.authorities[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>httpMethod | **object**<br><p>Match HTTP method.</p> <p>HttpMethodMatcher object.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>httpMethod.<br>httpMethods[] | **object**<br><p>List of HTTP methods. OR semantics implied.</p> <p>The maximum number of elements is 20.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>httpMethod.<br>httpMethods[].<br>exactMatch | **string** <br>`securityRules[].smartProtection.condition.httpMethod.httpMethods[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>httpMethod.<br>httpMethods[].<br>exactNotMatch | **string** <br>`securityRules[].smartProtection.condition.httpMethod.httpMethods[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>httpMethod.<br>httpMethods[].<br>prefixMatch | **string** <br>`securityRules[].smartProtection.condition.httpMethod.httpMethods[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>httpMethod.<br>httpMethods[].<br>prefixNotMatch | **string** <br>`securityRules[].smartProtection.condition.httpMethod.httpMethods[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>httpMethod.<br>httpMethods[].<br>pireRegexMatch | **string** <br>`securityRules[].smartProtection.condition.httpMethod.httpMethods[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>httpMethod.<br>httpMethods[].<br>pireRegexNotMatch | **string** <br>`securityRules[].smartProtection.condition.httpMethod.httpMethods[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>requestUri | **object**<br><p>Match Request URI.</p> <p>RequestUriMatcher object. AND semantics implied.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>requestUri.<br>path | **object**<br><p>Path of the URI <a href="https://datatracker.ietf.org/doc/html/rfc3986#section-3.3">RFC3986</a>.</p> <p>StringMatcher object.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>requestUri.<br>path.<br>exactMatch | **string** <br>`securityRules[].smartProtection.condition.requestUri.path` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>requestUri.<br>path.<br>exactNotMatch | **string** <br>`securityRules[].smartProtection.condition.requestUri.path` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>requestUri.<br>path.<br>prefixMatch | **string** <br>`securityRules[].smartProtection.condition.requestUri.path` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>requestUri.<br>path.<br>prefixNotMatch | **string** <br>`securityRules[].smartProtection.condition.requestUri.path` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>requestUri.<br>path.<br>pireRegexMatch | **string** <br>`securityRules[].smartProtection.condition.requestUri.path` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>requestUri.<br>path.<br>pireRegexNotMatch | **string** <br>`securityRules[].smartProtection.condition.requestUri.path` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>requestUri.<br>queries[] | **object**<br><p>List of query matchers. AND semantics implied.</p> <p>The maximum number of elements is 20.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>requestUri.<br>queries[].<br>key | **string**<br><p>Required. Key of the query parameter.</p> <p>The string length in characters must be 1-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>requestUri.<br>queries[].<br>value | **object**<br><p>Required. Value of the query parameter.</p> <p>StringMatcher object.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>requestUri.<br>queries[].<br>value.<br>exactMatch | **string** <br>`securityRules[].smartProtection.condition.requestUri.queries[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>requestUri.<br>queries[].<br>value.<br>exactNotMatch | **string** <br>`securityRules[].smartProtection.condition.requestUri.queries[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>requestUri.<br>queries[].<br>value.<br>prefixMatch | **string** <br>`securityRules[].smartProtection.condition.requestUri.queries[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>requestUri.<br>queries[].<br>value.<br>prefixNotMatch | **string** <br>`securityRules[].smartProtection.condition.requestUri.queries[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>requestUri.<br>queries[].<br>value.<br>pireRegexMatch | **string** <br>`securityRules[].smartProtection.condition.requestUri.queries[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>requestUri.<br>queries[].<br>value.<br>pireRegexNotMatch | **string** <br>`securityRules[].smartProtection.condition.requestUri.queries[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>headers[] | **object**<br><p>Match HTTP headers.</p> <p>The maximum number of elements is 20.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>headers[].<br>name | **string**<br><p>Required. Name of header (case insensitive).</p> <p>The string length in characters must be 1-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>headers[].<br>value | **object**<br><p>Required. Value of the header.</p> <p>StringMatcher object.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>headers[].<br>value.<br>exactMatch | **string** <br>`securityRules[].smartProtection.condition.headers[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>headers[].<br>value.<br>exactNotMatch | **string** <br>`securityRules[].smartProtection.condition.headers[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>headers[].<br>value.<br>prefixMatch | **string** <br>`securityRules[].smartProtection.condition.headers[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>headers[].<br>value.<br>prefixNotMatch | **string** <br>`securityRules[].smartProtection.condition.headers[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>headers[].<br>value.<br>pireRegexMatch | **string** <br>`securityRules[].smartProtection.condition.headers[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>headers[].<br>value.<br>pireRegexNotMatch | **string** <br>`securityRules[].smartProtection.condition.headers[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>sourceIp | **object**<br><p>Match IP.</p> <p>IpMatcher object. AND semantics implied.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>sourceIp.<br>ipRangesMatch | **object**<br><p>IpRangesMatcher object.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>sourceIp.<br>ipRangesMatch.<br>ipRanges[] | **string**<br><p>List of IP ranges. OR semantics implied.</p> <p>The maximum number of elements is 10000.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>sourceIp.<br>ipRangesNotMatch | **object**<br><p>IpRangesMatcher object.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>sourceIp.<br>ipRangesNotMatch.<br>ipRanges[] | **string**<br><p>List of IP ranges. OR semantics implied.</p> <p>The maximum number of elements is 10000.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>sourceIp.<br>geoIpMatch | **object**<br><p>GeoIpMatcher object.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>sourceIp.<br>geoIpMatch.<br>locations[] | **string**<br><p>Required. ISO 3166-1 alpha 2. OR semantics implied.</p> <p>The minimum number of elements is 1. The string length in characters for each value must be equal to 2.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>sourceIp.<br>geoIpNotMatch | **object**<br><p>GeoIpMatcher object.</p> 
securityRules[].<br>smartProtection.<br>condition.<br>sourceIp.<br>geoIpNotMatch.<br>locations[] | **string**<br><p>Required. ISO 3166-1 alpha 2. OR semantics implied.</p> <p>The minimum number of elements is 1. The string length in characters for each value must be equal to 2.</p> 
captchaId | **string**<br><p>Captcha ID to use with this security profile. Set empty to use default.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 