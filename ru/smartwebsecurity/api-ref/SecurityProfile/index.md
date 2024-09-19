---
editable: false
sourcePath: en/_api-ref/smartwebsecurity/v1/api-ref/SecurityProfile/index.md
---

# SmartWebSecurity API, REST: SecurityProfile methods
A set of methods for managing SecurityProfile resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
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

      // `securityRules[]` includes only one of the fields `ruleCondition`, `smartProtection`, `waf`
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
      "waf": {
        "mode": "string",
        "condition": {
          "authority": {
            "authorities": [
              {

                // `securityRules[].waf.condition.authority.authorities[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                // end of the list of possible fields`securityRules[].waf.condition.authority.authorities[]`

              }
            ]
          },
          "httpMethod": {
            "httpMethods": [
              {

                // `securityRules[].waf.condition.httpMethod.httpMethods[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                // end of the list of possible fields`securityRules[].waf.condition.httpMethod.httpMethods[]`

              }
            ]
          },
          "requestUri": {
            "path": {

              // `securityRules[].waf.condition.requestUri.path` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              // end of the list of possible fields`securityRules[].waf.condition.requestUri.path`

            },
            "queries": [
              {
                "key": "string",
                "value": {

                  // `securityRules[].waf.condition.requestUri.queries[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                  "exactMatch": "string",
                  "exactNotMatch": "string",
                  "prefixMatch": "string",
                  "prefixNotMatch": "string",
                  "pireRegexMatch": "string",
                  "pireRegexNotMatch": "string",
                  // end of the list of possible fields`securityRules[].waf.condition.requestUri.queries[].value`

                }
              }
            ]
          },
          "headers": [
            {
              "name": "string",
              "value": {

                // `securityRules[].waf.condition.headers[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                // end of the list of possible fields`securityRules[].waf.condition.headers[].value`

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
        },
        "wafProfileId": "string"
      },
      // end of the list of possible fields`securityRules[]`

    }
  ],
  "createdAt": "string",
  "cloudId": "string",
  "captchaId": "string",
  "advancedRateLimiterProfileId": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the security profile.</p> 
folderId | **string**<br><p>ID of the folder that the security profile belongs to.</p> 
labels | **object**<br><p>Labels as ``key:value`` pairs. Maximum of 64 per resource.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
name | **string**<br><p>Required. Name of the security profile. The name is unique within the folder. 1-50 characters long.</p> <p>The string length in characters must be 1-50. Value must match the regular expression ``[a-zA-Z0-9][a-zA-Z0-9-_.]*``.</p> 
description | **string**<br><p>Optional description of the security profile.</p> <p>The maximum string length in characters is 512.</p> 
defaultAction | **string**<br><p>Required. Action to perform if none of rules matched.</p> <p>Action to perform if none of rules matched.</p> <ul> <li>ALLOW: Pass request to service.</li> <li>DENY: Deny request.</li> </ul> 
securityRules[] | **object**<br><p>List of security rules.</p> 
securityRules[].<br>name | **string**<br><p>Required. Name of the rule. The name is unique within the security profile. 1-50 characters long.</p> <p>The string length in characters must be 1-50. Value must match the regular expression ``[a-zA-Z0-9][a-zA-Z0-9-_.]*``.</p> 
securityRules[].<br>priority | **string** (int64)<br><p>Determines the priority for checking the incoming traffic. Enter an integer within the range of 1 and 999999. The rule priority must be unique within the entire security profile. A lower numeric value means a higher priority. The default_action has the lowest priority.</p> <p>Acceptable values are 1 to 999999, inclusive.</p> 
securityRules[].<br>dryRun | **boolean** (boolean)<br><p>This mode allows you to test your security profile or a single rule. For example, you can have the number of alarms for a specific rule displayed. Note: if this option is true, no real action affecting your traffic regarding this rule will be taken.</p> 
securityRules[].<br>description | **string**<br><p>Optional description of the rule. 0-512 characters long.</p> <p>The maximum string length in characters is 512.</p> 
securityRules[].<br>ruleCondition | **object**<br>Rule actions, see [Rule actions](/docs/smartwebsecurity/concepts/rules#rule-action). <br>`securityRules[]` includes only one of the fields `ruleCondition`, `smartProtection`, `waf`<br>
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
securityRules[].<br>smartProtection | **object**<br>Smart Protection rule, see [Smart Protection rules](/docs/smartwebsecurity/concepts/rules#smart-protection-rules). <br>`securityRules[]` includes only one of the fields `ruleCondition`, `smartProtection`, `waf`<br>
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
securityRules[].<br>waf | **object**<br>Web Application Firewall (WAF) rule, see [WAF rules](/docs/smartwebsecurity/concepts/rules#waf-rules). <br>`securityRules[]` includes only one of the fields `ruleCondition`, `smartProtection`, `waf`<br>
securityRules[].<br>waf.<br>mode | **string**<br><p>Mode of protection.</p> <p>Mode of protection.</p> <ul> <li>FULL: Full protection means that the traffic will be checked based on ML models and behavioral analysis, with suspicious requests being sent to SmartCaptcha.</li> <li>API: API protection means checking the traffic based on ML models and behavioral analysis without sending suspicious requests to SmartCaptcha. The suspicious requests will be blocked.</li> </ul> 
securityRules[].<br>waf.<br>condition | **object**<br><p>The condition for matching the rule.</p> <p>Condition object. AND semantics implied. See <a href="/docs/smartwebsecurity/concepts/conditions">documentation</a> for matchers description.</p> 
securityRules[].<br>waf.<br>condition.<br>authority | **object**<br><p>Match authority (Host header).</p> <p>AuthorityMatcher object.</p> 
securityRules[].<br>waf.<br>condition.<br>authority.<br>authorities[] | **object**<br><p>List of authorities. OR semantics implied.</p> <p>The maximum number of elements is 20.</p> 
securityRules[].<br>waf.<br>condition.<br>authority.<br>authorities[].<br>exactMatch | **string** <br>`securityRules[].waf.condition.authority.authorities[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>authority.<br>authorities[].<br>exactNotMatch | **string** <br>`securityRules[].waf.condition.authority.authorities[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>authority.<br>authorities[].<br>prefixMatch | **string** <br>`securityRules[].waf.condition.authority.authorities[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>authority.<br>authorities[].<br>prefixNotMatch | **string** <br>`securityRules[].waf.condition.authority.authorities[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>authority.<br>authorities[].<br>pireRegexMatch | **string** <br>`securityRules[].waf.condition.authority.authorities[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>authority.<br>authorities[].<br>pireRegexNotMatch | **string** <br>`securityRules[].waf.condition.authority.authorities[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>httpMethod | **object**<br><p>Match HTTP method.</p> <p>HttpMethodMatcher object.</p> 
securityRules[].<br>waf.<br>condition.<br>httpMethod.<br>httpMethods[] | **object**<br><p>List of HTTP methods. OR semantics implied.</p> <p>The maximum number of elements is 20.</p> 
securityRules[].<br>waf.<br>condition.<br>httpMethod.<br>httpMethods[].<br>exactMatch | **string** <br>`securityRules[].waf.condition.httpMethod.httpMethods[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>httpMethod.<br>httpMethods[].<br>exactNotMatch | **string** <br>`securityRules[].waf.condition.httpMethod.httpMethods[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>httpMethod.<br>httpMethods[].<br>prefixMatch | **string** <br>`securityRules[].waf.condition.httpMethod.httpMethods[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>httpMethod.<br>httpMethods[].<br>prefixNotMatch | **string** <br>`securityRules[].waf.condition.httpMethod.httpMethods[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>httpMethod.<br>httpMethods[].<br>pireRegexMatch | **string** <br>`securityRules[].waf.condition.httpMethod.httpMethods[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>httpMethod.<br>httpMethods[].<br>pireRegexNotMatch | **string** <br>`securityRules[].waf.condition.httpMethod.httpMethods[]` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>requestUri | **object**<br><p>Match Request URI.</p> <p>RequestUriMatcher object. AND semantics implied.</p> 
securityRules[].<br>waf.<br>condition.<br>requestUri.<br>path | **object**<br><p>Path of the URI <a href="https://datatracker.ietf.org/doc/html/rfc3986#section-3.3">RFC3986</a>.</p> <p>StringMatcher object.</p> 
securityRules[].<br>waf.<br>condition.<br>requestUri.<br>path.<br>exactMatch | **string** <br>`securityRules[].waf.condition.requestUri.path` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>requestUri.<br>path.<br>exactNotMatch | **string** <br>`securityRules[].waf.condition.requestUri.path` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>requestUri.<br>path.<br>prefixMatch | **string** <br>`securityRules[].waf.condition.requestUri.path` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>requestUri.<br>path.<br>prefixNotMatch | **string** <br>`securityRules[].waf.condition.requestUri.path` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>requestUri.<br>path.<br>pireRegexMatch | **string** <br>`securityRules[].waf.condition.requestUri.path` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>requestUri.<br>path.<br>pireRegexNotMatch | **string** <br>`securityRules[].waf.condition.requestUri.path` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>requestUri.<br>queries[] | **object**<br><p>List of query matchers. AND semantics implied.</p> <p>The maximum number of elements is 20.</p> 
securityRules[].<br>waf.<br>condition.<br>requestUri.<br>queries[].<br>key | **string**<br><p>Required. Key of the query parameter.</p> <p>The string length in characters must be 1-255.</p> 
securityRules[].<br>waf.<br>condition.<br>requestUri.<br>queries[].<br>value | **object**<br><p>Required. Value of the query parameter.</p> <p>StringMatcher object.</p> 
securityRules[].<br>waf.<br>condition.<br>requestUri.<br>queries[].<br>value.<br>exactMatch | **string** <br>`securityRules[].waf.condition.requestUri.queries[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>requestUri.<br>queries[].<br>value.<br>exactNotMatch | **string** <br>`securityRules[].waf.condition.requestUri.queries[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>requestUri.<br>queries[].<br>value.<br>prefixMatch | **string** <br>`securityRules[].waf.condition.requestUri.queries[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>requestUri.<br>queries[].<br>value.<br>prefixNotMatch | **string** <br>`securityRules[].waf.condition.requestUri.queries[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>requestUri.<br>queries[].<br>value.<br>pireRegexMatch | **string** <br>`securityRules[].waf.condition.requestUri.queries[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>requestUri.<br>queries[].<br>value.<br>pireRegexNotMatch | **string** <br>`securityRules[].waf.condition.requestUri.queries[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>headers[] | **object**<br><p>Match HTTP headers.</p> <p>The maximum number of elements is 20.</p> 
securityRules[].<br>waf.<br>condition.<br>headers[].<br>name | **string**<br><p>Required. Name of header (case insensitive).</p> <p>The string length in characters must be 1-255.</p> 
securityRules[].<br>waf.<br>condition.<br>headers[].<br>value | **object**<br><p>Required. Value of the header.</p> <p>StringMatcher object.</p> 
securityRules[].<br>waf.<br>condition.<br>headers[].<br>value.<br>exactMatch | **string** <br>`securityRules[].waf.condition.headers[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>headers[].<br>value.<br>exactNotMatch | **string** <br>`securityRules[].waf.condition.headers[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>headers[].<br>value.<br>prefixMatch | **string** <br>`securityRules[].waf.condition.headers[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>headers[].<br>value.<br>prefixNotMatch | **string** <br>`securityRules[].waf.condition.headers[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>headers[].<br>value.<br>pireRegexMatch | **string** <br>`securityRules[].waf.condition.headers[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>headers[].<br>value.<br>pireRegexNotMatch | **string** <br>`securityRules[].waf.condition.headers[].value` includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`<br><br><p>The string length in characters must be 0-255.</p> 
securityRules[].<br>waf.<br>condition.<br>sourceIp | **object**<br><p>Match IP.</p> <p>IpMatcher object. AND semantics implied.</p> 
securityRules[].<br>waf.<br>condition.<br>sourceIp.<br>ipRangesMatch | **object**<br><p>IpRangesMatcher object.</p> 
securityRules[].<br>waf.<br>condition.<br>sourceIp.<br>ipRangesMatch.<br>ipRanges[] | **string**<br><p>List of IP ranges. OR semantics implied.</p> <p>The maximum number of elements is 10000.</p> 
securityRules[].<br>waf.<br>condition.<br>sourceIp.<br>ipRangesNotMatch | **object**<br><p>IpRangesMatcher object.</p> 
securityRules[].<br>waf.<br>condition.<br>sourceIp.<br>ipRangesNotMatch.<br>ipRanges[] | **string**<br><p>List of IP ranges. OR semantics implied.</p> <p>The maximum number of elements is 10000.</p> 
securityRules[].<br>waf.<br>condition.<br>sourceIp.<br>geoIpMatch | **object**<br><p>GeoIpMatcher object.</p> 
securityRules[].<br>waf.<br>condition.<br>sourceIp.<br>geoIpMatch.<br>locations[] | **string**<br><p>Required. ISO 3166-1 alpha 2. OR semantics implied.</p> <p>The minimum number of elements is 1. The string length in characters for each value must be equal to 2.</p> 
securityRules[].<br>waf.<br>condition.<br>sourceIp.<br>geoIpNotMatch | **object**<br><p>GeoIpMatcher object.</p> 
securityRules[].<br>waf.<br>condition.<br>sourceIp.<br>geoIpNotMatch.<br>locations[] | **string**<br><p>Required. ISO 3166-1 alpha 2. OR semantics implied.</p> <p>The minimum number of elements is 1. The string length in characters for each value must be equal to 2.</p> 
securityRules[].<br>waf.<br>wafProfileId | **string**<br><p>Required. ID of WAF profile to use in this rule.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
cloudId | **string**<br><p>ID of the cloud that the security profile belongs to.</p> 
captchaId | **string**<br><p>Captcha ID to use with this security profile. Set empty to use default.</p> 
advancedRateLimiterProfileId | **string**<br><p>Advanced rate limiter profile ID to use with this security profile. Set empty to use default.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a security profile in the specified folder using the data specified in the request.
[delete](delete.md) | Deletes the specified security profile.
[get](get.md) | Returns the specified SecurityProfile resource.
[list](list.md) | Retrieves the list of SecurityProfile resources in the specified folder.
[update](update.md) | Updates the specified security profile.