---
editable: false
apiPlayground:
  - url: https://smartwebsecurity.{{ api-host }}/smartwebsecurity/v1/securityProfiles/{securityProfileId}
    method: patch
    path:
      type: object
      properties:
        securityProfileId:
          description: |-
            **string**
            Required field. ID of the security profile to update.
          type: string
      required:
        - securityProfileId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Labels as `` key:value `` pairs. Maximum of 64 per resource.
          type: string
        name:
          description: |-
            **string**
            Name of the security profile. The name is unique within the folder. 1-50 characters long.
          type: string
        description:
          description: |-
            **string**
            Optional description of the security profile.
          type: string
        defaultAction:
          description: |-
            **enum** (DefaultAction)
            Action to perform if none of rules matched.
            - `DEFAULT_ACTION_UNSPECIFIED`
            - `ALLOW`: Pass request to service.
            - `DENY`: Deny request.
          type: string
          enum:
            - DEFAULT_ACTION_UNSPECIFIED
            - ALLOW
            - DENY
        securityRules:
          description: |-
            **[SecurityRule](/docs/smartwebsecurity/api-ref/SecurityProfile/get#yandex.cloud.smartwebsecurity.v1.SecurityRule)**
            List of security rules.
          type: array
          items:
            oneOf:
              - type: object
                properties:
                  ruleCondition:
                    description: |-
                      **[RuleCondition](/docs/smartwebsecurity/api-ref/SecurityProfile/get#yandex.cloud.smartwebsecurity.v1.SecurityRule.RuleCondition)**
                      Rule actions, see [Rule actions](/docs/smartwebsecurity/concepts/rules#rule-action).
                      Includes only one of the fields `ruleCondition`, `smartProtection`, `waf`.
                    $ref: '#/definitions/RuleCondition'
                  smartProtection:
                    description: |-
                      **[SmartProtection](/docs/smartwebsecurity/api-ref/SecurityProfile/get#yandex.cloud.smartwebsecurity.v1.SecurityRule.SmartProtection)**
                      Smart Protection rule, see [Smart Protection rules](/docs/smartwebsecurity/concepts/rules#smart-protection-rules).
                      Includes only one of the fields `ruleCondition`, `smartProtection`, `waf`.
                    $ref: '#/definitions/SmartProtection'
                  waf:
                    description: |-
                      **[Waf](/docs/smartwebsecurity/api-ref/SecurityProfile/get#yandex.cloud.smartwebsecurity.v1.SecurityRule.Waf)**
                      Web Application Firewall (WAF) rule, see [WAF rules](/docs/smartwebsecurity/concepts/rules#waf-rules).
                      Includes only one of the fields `ruleCondition`, `smartProtection`, `waf`.
                    $ref: '#/definitions/Waf'
        captchaId:
          description: |-
            **string**
            Captcha ID to use with this security profile. Set empty to use default.
          type: string
        advancedRateLimiterProfileId:
          description: |-
            **string**
            Advanced rate limiter profile ID to use with this security profile. Set empty to use default.
          type: string
        analyzeRequestBody:
          description: |-
            **[AnalyzeRequestBody](/docs/smartwebsecurity/api-ref/SecurityProfile/get#yandex.cloud.smartwebsecurity.v1.SecurityProfile.AnalyzeRequestBody)**
            Parameters for request body analyzer.
          $ref: '#/definitions/AnalyzeRequestBody'
      additionalProperties: false
    definitions:
      AuthorityMatcher:
        type: object
        properties:
          authorities:
            description: |-
              **[StringMatcher](/docs/smartwebsecurity/api-ref/AdvancedRateLimiterProfile/get#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**
              List of authorities. OR semantics implied.
            type: array
            items:
              oneOf:
                - type: object
                  properties:
                    exactMatch:
                      description: |-
                        **string**
                        Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                      type: string
                    exactNotMatch:
                      description: |-
                        **string**
                        Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                      type: string
                    prefixMatch:
                      description: |-
                        **string**
                        Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                      type: string
                    prefixNotMatch:
                      description: |-
                        **string**
                        Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                      type: string
                    pireRegexMatch:
                      description: |-
                        **string**
                        Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                      type: string
                    pireRegexNotMatch:
                      description: |-
                        **string**
                        Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                      type: string
      HttpMethodMatcher:
        type: object
        properties:
          httpMethods:
            description: |-
              **[StringMatcher](/docs/smartwebsecurity/api-ref/AdvancedRateLimiterProfile/get#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**
              List of HTTP methods. OR semantics implied.
            type: array
            items:
              oneOf:
                - type: object
                  properties:
                    exactMatch:
                      description: |-
                        **string**
                        Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                      type: string
                    exactNotMatch:
                      description: |-
                        **string**
                        Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                      type: string
                    prefixMatch:
                      description: |-
                        **string**
                        Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                      type: string
                    prefixNotMatch:
                      description: |-
                        **string**
                        Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                      type: string
                    pireRegexMatch:
                      description: |-
                        **string**
                        Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                      type: string
                    pireRegexNotMatch:
                      description: |-
                        **string**
                        Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                      type: string
      QueryMatcher:
        type: object
        properties:
          key:
            description: |-
              **string**
              Required field. Key of the query parameter.
            type: string
          value:
            description: |-
              **[StringMatcher](/docs/smartwebsecurity/api-ref/AdvancedRateLimiterProfile/get#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**
              Required field. Value of the query parameter.
            oneOf:
              - type: object
                properties:
                  exactMatch:
                    description: |-
                      **string**
                      Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                    type: string
                  exactNotMatch:
                    description: |-
                      **string**
                      Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                    type: string
                  prefixMatch:
                    description: |-
                      **string**
                      Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                    type: string
                  prefixNotMatch:
                    description: |-
                      **string**
                      Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                    type: string
                  pireRegexMatch:
                    description: |-
                      **string**
                      Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                    type: string
                  pireRegexNotMatch:
                    description: |-
                      **string**
                      Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                    type: string
        required:
          - key
          - value
      RequestUriMatcher:
        type: object
        properties:
          path:
            description: |-
              **[StringMatcher](/docs/smartwebsecurity/api-ref/AdvancedRateLimiterProfile/get#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**
              Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3).
            oneOf:
              - type: object
                properties:
                  exactMatch:
                    description: |-
                      **string**
                      Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                    type: string
                  exactNotMatch:
                    description: |-
                      **string**
                      Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                    type: string
                  prefixMatch:
                    description: |-
                      **string**
                      Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                    type: string
                  prefixNotMatch:
                    description: |-
                      **string**
                      Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                    type: string
                  pireRegexMatch:
                    description: |-
                      **string**
                      Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                    type: string
                  pireRegexNotMatch:
                    description: |-
                      **string**
                      Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                    type: string
          queries:
            description: |-
              **[QueryMatcher](/docs/smartwebsecurity/api-ref/AdvancedRateLimiterProfile/get#yandex.cloud.smartwebsecurity.v1.Condition.QueryMatcher)**
              List of query matchers. AND semantics implied.
            type: array
            items:
              $ref: '#/definitions/QueryMatcher'
      HeaderMatcher:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of header (case insensitive).
            type: string
          value:
            description: |-
              **[StringMatcher](/docs/smartwebsecurity/api-ref/AdvancedRateLimiterProfile/get#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**
              Required field. Value of the header.
            oneOf:
              - type: object
                properties:
                  exactMatch:
                    description: |-
                      **string**
                      Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                    type: string
                  exactNotMatch:
                    description: |-
                      **string**
                      Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                    type: string
                  prefixMatch:
                    description: |-
                      **string**
                      Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                    type: string
                  prefixNotMatch:
                    description: |-
                      **string**
                      Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                    type: string
                  pireRegexMatch:
                    description: |-
                      **string**
                      Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                    type: string
                  pireRegexNotMatch:
                    description: |-
                      **string**
                      Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
                    type: string
        required:
          - name
          - value
      IpRangesMatcher:
        type: object
        properties:
          ipRanges:
            description: |-
              **string**
              List of IP ranges. OR semantics implied.
            type: array
            items:
              type: string
      GeoIpMatcher:
        type: object
        properties:
          locations:
            description: |-
              **string**
              ISO 3166-1 alpha 2. OR semantics implied.
            uniqueItems: true
            type: array
            items:
              type: string
      IpMatcher:
        type: object
        properties:
          ipRangesMatch:
            description: '**[IpRangesMatcher](/docs/smartwebsecurity/api-ref/AdvancedRateLimiterProfile/get#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher)**'
            $ref: '#/definitions/IpRangesMatcher'
          ipRangesNotMatch:
            description: '**[IpRangesMatcher](/docs/smartwebsecurity/api-ref/AdvancedRateLimiterProfile/get#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher)**'
            $ref: '#/definitions/IpRangesMatcher'
          geoIpMatch:
            description: '**[GeoIpMatcher](/docs/smartwebsecurity/api-ref/AdvancedRateLimiterProfile/get#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher)**'
            $ref: '#/definitions/GeoIpMatcher'
          geoIpNotMatch:
            description: '**[GeoIpMatcher](/docs/smartwebsecurity/api-ref/AdvancedRateLimiterProfile/get#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher)**'
            $ref: '#/definitions/GeoIpMatcher'
      Condition:
        type: object
        properties:
          authority:
            description: |-
              **[AuthorityMatcher](/docs/smartwebsecurity/api-ref/AdvancedRateLimiterProfile/get#yandex.cloud.smartwebsecurity.v1.Condition.AuthorityMatcher)**
              Match authority (Host header).
            $ref: '#/definitions/AuthorityMatcher'
          httpMethod:
            description: |-
              **[HttpMethodMatcher](/docs/smartwebsecurity/api-ref/AdvancedRateLimiterProfile/get#yandex.cloud.smartwebsecurity.v1.Condition.HttpMethodMatcher)**
              Match HTTP method.
            $ref: '#/definitions/HttpMethodMatcher'
          requestUri:
            description: |-
              **[RequestUriMatcher](/docs/smartwebsecurity/api-ref/AdvancedRateLimiterProfile/get#yandex.cloud.smartwebsecurity.v1.Condition.RequestUriMatcher)**
              Match Request URI.
            $ref: '#/definitions/RequestUriMatcher'
          headers:
            description: |-
              **[HeaderMatcher](/docs/smartwebsecurity/api-ref/AdvancedRateLimiterProfile/get#yandex.cloud.smartwebsecurity.v1.Condition.HeaderMatcher)**
              Match HTTP headers.
            type: array
            items:
              $ref: '#/definitions/HeaderMatcher'
          sourceIp:
            description: |-
              **[IpMatcher](/docs/smartwebsecurity/api-ref/AdvancedRateLimiterProfile/get#yandex.cloud.smartwebsecurity.v1.Condition.IpMatcher)**
              Match IP.
            $ref: '#/definitions/IpMatcher'
      RuleCondition:
        type: object
        properties:
          action:
            description: |-
              **enum** (Action)
              Action to perform if this rule matched.
              - `ACTION_UNSPECIFIED`
              - `DENY`: Deny request.
            type: string
            enum:
              - ACTION_UNSPECIFIED
              - DENY
          condition:
            description: |-
              **[Condition](/docs/smartwebsecurity/api-ref/AdvancedRateLimiterProfile/get#yandex.cloud.smartwebsecurity.v1.Condition)**
              The condition for matching the rule.
            $ref: '#/definitions/Condition'
      SmartProtection:
        type: object
        properties:
          mode:
            description: |-
              **enum** (Mode)
              Mode of protection.
              - `MODE_UNSPECIFIED`
              - `FULL`: Full protection means that the traffic will be checked based on ML models and behavioral analysis,
              with suspicious requests being sent to SmartCaptcha.
              - `API`: API protection means checking the traffic based on ML models and behavioral analysis without sending suspicious
              requests to SmartCaptcha. The suspicious requests will be blocked.
            type: string
            enum:
              - MODE_UNSPECIFIED
              - FULL
              - API
          condition:
            description: |-
              **[Condition](/docs/smartwebsecurity/api-ref/AdvancedRateLimiterProfile/get#yandex.cloud.smartwebsecurity.v1.Condition)**
              The condition for matching the rule.
            $ref: '#/definitions/Condition'
      Waf:
        type: object
        properties:
          mode:
            description: |-
              **enum** (Mode)
              Mode of protection.
              - `MODE_UNSPECIFIED`
              - `FULL`: Full protection means that the traffic will be checked based on ML models and behavioral analysis,
              with suspicious requests being sent to SmartCaptcha.
              - `API`: API protection means checking the traffic based on ML models and behavioral analysis without sending suspicious
              requests to SmartCaptcha. The suspicious requests will be blocked.
            type: string
            enum:
              - MODE_UNSPECIFIED
              - FULL
              - API
          condition:
            description: |-
              **[Condition](/docs/smartwebsecurity/api-ref/AdvancedRateLimiterProfile/get#yandex.cloud.smartwebsecurity.v1.Condition)**
              The condition for matching the rule.
            $ref: '#/definitions/Condition'
          wafProfileId:
            description: |-
              **string**
              Required field. ID of WAF profile to use in this rule.
            type: string
        required:
          - wafProfileId
      AnalyzeRequestBody:
        type: object
        properties:
          sizeLimit:
            description: |-
              **string** (int64)
              Maximum size of body to pass to analyzer. In kilobytes.
            type: string
            format: int64
          sizeLimitAction:
            description: |-
              **enum** (Action)
              Action to perform if maximum size of body exceeded.
              - `ACTION_UNSPECIFIED`
              - `DENY`: Deny request.
            type: string
            enum:
              - ACTION_UNSPECIFIED
              - DENY
sourcePath: en/_api-ref/smartwebsecurity/v1/api-ref/SecurityProfile/update.md
---

# SmartWebSecurity API, REST: SecurityProfile.Update

Updates the specified security profile.

## HTTP request

```
PATCH https://smartwebsecurity.{{ api-host }}/smartwebsecurity/v1/securityProfiles/{securityProfileId}
```

## Path parameters

#|
||Field | Description ||
|| securityProfileId | **string**

Required field. ID of the security profile to update. ||
|#

## Body parameters {#yandex.cloud.smartwebsecurity.v1.UpdateSecurityProfileRequest}

```json
{
  "updateMask": "string",
  "labels": "object",
  "name": "string",
  "description": "string",
  "defaultAction": "string",
  "securityRules": [
    {
      "name": "string",
      "priority": "string",
      "dryRun": "boolean",
      // Includes only one of the fields `ruleCondition`, `smartProtection`, `waf`
      "ruleCondition": {
        "action": "string",
        "condition": {
          "authority": {
            "authorities": [
              {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string"
                // end of the list of possible fields
              }
            ]
          },
          "httpMethod": {
            "httpMethods": [
              {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string"
                // end of the list of possible fields
              }
            ]
          },
          "requestUri": {
            "path": {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string"
              // end of the list of possible fields
            },
            "queries": [
              {
                "key": "string",
                "value": {
                  // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                  "exactMatch": "string",
                  "exactNotMatch": "string",
                  "prefixMatch": "string",
                  "prefixNotMatch": "string",
                  "pireRegexMatch": "string",
                  "pireRegexNotMatch": "string"
                  // end of the list of possible fields
                }
              }
            ]
          },
          "headers": [
            {
              "name": "string",
              "value": {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string"
                // end of the list of possible fields
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
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string"
                // end of the list of possible fields
              }
            ]
          },
          "httpMethod": {
            "httpMethods": [
              {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string"
                // end of the list of possible fields
              }
            ]
          },
          "requestUri": {
            "path": {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string"
              // end of the list of possible fields
            },
            "queries": [
              {
                "key": "string",
                "value": {
                  // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                  "exactMatch": "string",
                  "exactNotMatch": "string",
                  "prefixMatch": "string",
                  "prefixNotMatch": "string",
                  "pireRegexMatch": "string",
                  "pireRegexNotMatch": "string"
                  // end of the list of possible fields
                }
              }
            ]
          },
          "headers": [
            {
              "name": "string",
              "value": {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string"
                // end of the list of possible fields
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
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string"
                // end of the list of possible fields
              }
            ]
          },
          "httpMethod": {
            "httpMethods": [
              {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string"
                // end of the list of possible fields
              }
            ]
          },
          "requestUri": {
            "path": {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string"
              // end of the list of possible fields
            },
            "queries": [
              {
                "key": "string",
                "value": {
                  // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                  "exactMatch": "string",
                  "exactNotMatch": "string",
                  "prefixMatch": "string",
                  "prefixNotMatch": "string",
                  "pireRegexMatch": "string",
                  "pireRegexNotMatch": "string"
                  // end of the list of possible fields
                }
              }
            ]
          },
          "headers": [
            {
              "name": "string",
              "value": {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string"
                // end of the list of possible fields
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
      // end of the list of possible fields
      "description": "string"
    }
  ],
  "captchaId": "string",
  "advancedRateLimiterProfileId": "string",
  "analyzeRequestBody": {
    "sizeLimit": "string",
    "sizeLimitAction": "string"
  }
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| labels | **object** (map<**string**, **string**>)

Labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| name | **string**

Name of the security profile. The name is unique within the folder. 1-50 characters long. ||
|| description | **string**

Optional description of the security profile. ||
|| defaultAction | **enum** (DefaultAction)

Action to perform if none of rules matched.

- `DEFAULT_ACTION_UNSPECIFIED`
- `ALLOW`: Pass request to service.
- `DENY`: Deny request. ||
|| securityRules[] | **[SecurityRule](#yandex.cloud.smartwebsecurity.v1.SecurityRule)**

List of security rules. ||
|| captchaId | **string**

Captcha ID to use with this security profile. Set empty to use default. ||
|| advancedRateLimiterProfileId | **string**

Advanced rate limiter profile ID to use with this security profile. Set empty to use default. ||
|| analyzeRequestBody | **[AnalyzeRequestBody](#yandex.cloud.smartwebsecurity.v1.SecurityProfile.AnalyzeRequestBody)**

Parameters for request body analyzer. ||
|#

## SecurityRule {#yandex.cloud.smartwebsecurity.v1.SecurityRule}

A SecurityRule object, see [Rules](/docs/smartwebsecurity/concepts/rules).

#|
||Field | Description ||
|| name | **string**

Required field. Name of the rule. The name is unique within the security profile. 1-50 characters long. ||
|| priority | **string** (int64)

Determines the priority for checking the incoming traffic.
Enter an integer within the range of 1 and 999999.
The rule priority must be unique within the entire security profile.
A lower numeric value means a higher priority.
The default_action has the lowest priority. ||
|| dryRun | **boolean**

This mode allows you to test your security profile or a single rule.
For example, you can have the number of alarms for a specific rule displayed.
Note: if this option is true, no real action affecting your traffic regarding this rule will be taken. ||
|| ruleCondition | **[RuleCondition](#yandex.cloud.smartwebsecurity.v1.SecurityRule.RuleCondition)**

Rule actions, see [Rule actions](/docs/smartwebsecurity/concepts/rules#rule-action).

Includes only one of the fields `ruleCondition`, `smartProtection`, `waf`. ||
|| smartProtection | **[SmartProtection](#yandex.cloud.smartwebsecurity.v1.SecurityRule.SmartProtection)**

Smart Protection rule, see [Smart Protection rules](/docs/smartwebsecurity/concepts/rules#smart-protection-rules).

Includes only one of the fields `ruleCondition`, `smartProtection`, `waf`. ||
|| waf | **[Waf](#yandex.cloud.smartwebsecurity.v1.SecurityRule.Waf)**

Web Application Firewall (WAF) rule, see [WAF rules](/docs/smartwebsecurity/concepts/rules#waf-rules).

Includes only one of the fields `ruleCondition`, `smartProtection`, `waf`. ||
|| description | **string**

Optional description of the rule. 0-512 characters long. ||
|#

## RuleCondition {#yandex.cloud.smartwebsecurity.v1.SecurityRule.RuleCondition}

RuleCondition object.

#|
||Field | Description ||
|| action | **enum** (Action)

Action to perform if this rule matched.

- `ACTION_UNSPECIFIED`
- `ALLOW`: Pass request to service.
- `DENY`: Deny request. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition)**

The condition for matching the rule. ||
|#

## Condition {#yandex.cloud.smartwebsecurity.v1.Condition}

Condition object. AND semantics implied.
See [documentation](/docs/smartwebsecurity/concepts/conditions) for matchers description.

#|
||Field | Description ||
|| authority | **[AuthorityMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.AuthorityMatcher)**

Match authority (Host header). ||
|| httpMethod | **[HttpMethodMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.HttpMethodMatcher)**

Match HTTP method. ||
|| requestUri | **[RequestUriMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.RequestUriMatcher)**

Match Request URI. ||
|| headers[] | **[HeaderMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.HeaderMatcher)**

Match HTTP headers. ||
|| sourceIp | **[IpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpMatcher)**

Match IP. ||
|#

## AuthorityMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.AuthorityMatcher}

AuthorityMatcher object.

#|
||Field | Description ||
|| authorities[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

List of authorities. OR semantics implied. ||
|#

## StringMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher}

StringMatcher object.

#|
||Field | Description ||
|| exactMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| exactNotMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| prefixMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| prefixNotMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| pireRegexMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| pireRegexNotMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|#

## HttpMethodMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.HttpMethodMatcher}

HttpMethodMatcher object.

#|
||Field | Description ||
|| httpMethods[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

List of HTTP methods. OR semantics implied. ||
|#

## RequestUriMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.RequestUriMatcher}

RequestUriMatcher object. AND semantics implied.

#|
||Field | Description ||
|| path | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3). ||
|| queries[] | **[QueryMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.QueryMatcher)**

List of query matchers. AND semantics implied. ||
|#

## QueryMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.QueryMatcher}

QueryMatcher object.

#|
||Field | Description ||
|| key | **string**

Required field. Key of the query parameter. ||
|| value | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

Required field. Value of the query parameter. ||
|#

## HeaderMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.HeaderMatcher}

HeaderMatcher object.

#|
||Field | Description ||
|| name | **string**

Required field. Name of header (case insensitive). ||
|| value | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

Required field. Value of the header. ||
|#

## IpMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IpMatcher}

IpMatcher object. AND semantics implied.

#|
||Field | Description ||
|| ipRangesMatch | **[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher)** ||
|| ipRangesNotMatch | **[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher)** ||
|| geoIpMatch | **[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher)** ||
|| geoIpNotMatch | **[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher)** ||
|#

## IpRangesMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher}

IpRangesMatcher object.

#|
||Field | Description ||
|| ipRanges[] | **string**

List of IP ranges. OR semantics implied. ||
|#

## GeoIpMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher}

GeoIpMatcher object.

#|
||Field | Description ||
|| locations[] | **string**

ISO 3166-1 alpha 2. OR semantics implied. ||
|#

## SmartProtection {#yandex.cloud.smartwebsecurity.v1.SecurityRule.SmartProtection}

SmartProtection object.

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode of protection.

- `MODE_UNSPECIFIED`
- `FULL`: Full protection means that the traffic will be checked based on ML models and behavioral analysis,
with suspicious requests being sent to SmartCaptcha.
- `API`: API protection means checking the traffic based on ML models and behavioral analysis without sending suspicious
requests to SmartCaptcha. The suspicious requests will be blocked. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition)**

The condition for matching the rule. ||
|#

## Waf {#yandex.cloud.smartwebsecurity.v1.SecurityRule.Waf}

Waf object.

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode of protection.

- `MODE_UNSPECIFIED`
- `FULL`: Full protection means that the traffic will be checked based on ML models and behavioral analysis,
with suspicious requests being sent to SmartCaptcha.
- `API`: API protection means checking the traffic based on ML models and behavioral analysis without sending suspicious
requests to SmartCaptcha. The suspicious requests will be blocked. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition)**

The condition for matching the rule. ||
|| wafProfileId | **string**

Required field. ID of WAF profile to use in this rule. ||
|#

## AnalyzeRequestBody {#yandex.cloud.smartwebsecurity.v1.SecurityProfile.AnalyzeRequestBody}

#|
||Field | Description ||
|| sizeLimit | **string** (int64)

Maximum size of body to pass to analyzer. In kilobytes. ||
|| sizeLimitAction | **enum** (Action)

Action to perform if maximum size of body exceeded.

- `ACTION_UNSPECIFIED`
- `IGNORE`: Ignore body.
- `DENY`: Deny request. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "securityProfileId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
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
        "dryRun": "boolean",
        // Includes only one of the fields `ruleCondition`, `smartProtection`, `waf`
        "ruleCondition": {
          "action": "string",
          "condition": {
            "authority": {
              "authorities": [
                {
                  // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                  "exactMatch": "string",
                  "exactNotMatch": "string",
                  "prefixMatch": "string",
                  "prefixNotMatch": "string",
                  "pireRegexMatch": "string",
                  "pireRegexNotMatch": "string"
                  // end of the list of possible fields
                }
              ]
            },
            "httpMethod": {
              "httpMethods": [
                {
                  // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                  "exactMatch": "string",
                  "exactNotMatch": "string",
                  "prefixMatch": "string",
                  "prefixNotMatch": "string",
                  "pireRegexMatch": "string",
                  "pireRegexNotMatch": "string"
                  // end of the list of possible fields
                }
              ]
            },
            "requestUri": {
              "path": {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string"
                // end of the list of possible fields
              },
              "queries": [
                {
                  "key": "string",
                  "value": {
                    // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                    "exactMatch": "string",
                    "exactNotMatch": "string",
                    "prefixMatch": "string",
                    "prefixNotMatch": "string",
                    "pireRegexMatch": "string",
                    "pireRegexNotMatch": "string"
                    // end of the list of possible fields
                  }
                }
              ]
            },
            "headers": [
              {
                "name": "string",
                "value": {
                  // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                  "exactMatch": "string",
                  "exactNotMatch": "string",
                  "prefixMatch": "string",
                  "prefixNotMatch": "string",
                  "pireRegexMatch": "string",
                  "pireRegexNotMatch": "string"
                  // end of the list of possible fields
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
                  // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                  "exactMatch": "string",
                  "exactNotMatch": "string",
                  "prefixMatch": "string",
                  "prefixNotMatch": "string",
                  "pireRegexMatch": "string",
                  "pireRegexNotMatch": "string"
                  // end of the list of possible fields
                }
              ]
            },
            "httpMethod": {
              "httpMethods": [
                {
                  // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                  "exactMatch": "string",
                  "exactNotMatch": "string",
                  "prefixMatch": "string",
                  "prefixNotMatch": "string",
                  "pireRegexMatch": "string",
                  "pireRegexNotMatch": "string"
                  // end of the list of possible fields
                }
              ]
            },
            "requestUri": {
              "path": {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string"
                // end of the list of possible fields
              },
              "queries": [
                {
                  "key": "string",
                  "value": {
                    // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                    "exactMatch": "string",
                    "exactNotMatch": "string",
                    "prefixMatch": "string",
                    "prefixNotMatch": "string",
                    "pireRegexMatch": "string",
                    "pireRegexNotMatch": "string"
                    // end of the list of possible fields
                  }
                }
              ]
            },
            "headers": [
              {
                "name": "string",
                "value": {
                  // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                  "exactMatch": "string",
                  "exactNotMatch": "string",
                  "prefixMatch": "string",
                  "prefixNotMatch": "string",
                  "pireRegexMatch": "string",
                  "pireRegexNotMatch": "string"
                  // end of the list of possible fields
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
                  // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                  "exactMatch": "string",
                  "exactNotMatch": "string",
                  "prefixMatch": "string",
                  "prefixNotMatch": "string",
                  "pireRegexMatch": "string",
                  "pireRegexNotMatch": "string"
                  // end of the list of possible fields
                }
              ]
            },
            "httpMethod": {
              "httpMethods": [
                {
                  // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                  "exactMatch": "string",
                  "exactNotMatch": "string",
                  "prefixMatch": "string",
                  "prefixNotMatch": "string",
                  "pireRegexMatch": "string",
                  "pireRegexNotMatch": "string"
                  // end of the list of possible fields
                }
              ]
            },
            "requestUri": {
              "path": {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string"
                // end of the list of possible fields
              },
              "queries": [
                {
                  "key": "string",
                  "value": {
                    // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                    "exactMatch": "string",
                    "exactNotMatch": "string",
                    "prefixMatch": "string",
                    "prefixNotMatch": "string",
                    "pireRegexMatch": "string",
                    "pireRegexNotMatch": "string"
                    // end of the list of possible fields
                  }
                }
              ]
            },
            "headers": [
              {
                "name": "string",
                "value": {
                  // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                  "exactMatch": "string",
                  "exactNotMatch": "string",
                  "prefixMatch": "string",
                  "prefixNotMatch": "string",
                  "pireRegexMatch": "string",
                  "pireRegexNotMatch": "string"
                  // end of the list of possible fields
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
        // end of the list of possible fields
        "description": "string"
      }
    ],
    "createdAt": "string",
    "cloudId": "string",
    "captchaId": "string",
    "advancedRateLimiterProfileId": "string",
    "analyzeRequestBody": {
      "sizeLimit": "string",
      "sizeLimitAction": "string"
    }
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateSecurityProfileMetadata](#yandex.cloud.smartwebsecurity.v1.UpdateSecurityProfileMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[SecurityProfile](#yandex.cloud.smartwebsecurity.v1.SecurityProfile)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateSecurityProfileMetadata {#yandex.cloud.smartwebsecurity.v1.UpdateSecurityProfileMetadata}

#|
||Field | Description ||
|| securityProfileId | **string**

ID of the SecurityProfile resource that is being updated. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## SecurityProfile {#yandex.cloud.smartwebsecurity.v1.SecurityProfile}

A SecurityProfile resource.

#|
||Field | Description ||
|| id | **string**

ID of the security profile. ||
|| folderId | **string**

ID of the folder that the security profile belongs to. ||
|| labels | **object** (map<**string**, **string**>)

Labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| name | **string**

Required field. Name of the security profile. The name is unique within the folder. 1-50 characters long. ||
|| description | **string**

Optional description of the security profile. ||
|| defaultAction | **enum** (DefaultAction)

Required field. Action to perform if none of rules matched.

- `DEFAULT_ACTION_UNSPECIFIED`
- `ALLOW`: Pass request to service.
- `DENY`: Deny request. ||
|| securityRules[] | **[SecurityRule](#yandex.cloud.smartwebsecurity.v1.SecurityRule2)**

List of security rules. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| cloudId | **string**

ID of the cloud that the security profile belongs to. ||
|| captchaId | **string**

Captcha ID to use with this security profile. Set empty to use default. ||
|| advancedRateLimiterProfileId | **string**

Advanced rate limiter profile ID to use with this security profile. Set empty to use default. ||
|| analyzeRequestBody | **[AnalyzeRequestBody](#yandex.cloud.smartwebsecurity.v1.SecurityProfile.AnalyzeRequestBody2)**

Parameters for request body analyzer. ||
|#

## SecurityRule {#yandex.cloud.smartwebsecurity.v1.SecurityRule2}

A SecurityRule object, see [Rules](/docs/smartwebsecurity/concepts/rules).

#|
||Field | Description ||
|| name | **string**

Required field. Name of the rule. The name is unique within the security profile. 1-50 characters long. ||
|| priority | **string** (int64)

Determines the priority for checking the incoming traffic.
Enter an integer within the range of 1 and 999999.
The rule priority must be unique within the entire security profile.
A lower numeric value means a higher priority.
The default_action has the lowest priority. ||
|| dryRun | **boolean**

This mode allows you to test your security profile or a single rule.
For example, you can have the number of alarms for a specific rule displayed.
Note: if this option is true, no real action affecting your traffic regarding this rule will be taken. ||
|| ruleCondition | **[RuleCondition](#yandex.cloud.smartwebsecurity.v1.SecurityRule.RuleCondition2)**

Rule actions, see [Rule actions](/docs/smartwebsecurity/concepts/rules#rule-action).

Includes only one of the fields `ruleCondition`, `smartProtection`, `waf`. ||
|| smartProtection | **[SmartProtection](#yandex.cloud.smartwebsecurity.v1.SecurityRule.SmartProtection2)**

Smart Protection rule, see [Smart Protection rules](/docs/smartwebsecurity/concepts/rules#smart-protection-rules).

Includes only one of the fields `ruleCondition`, `smartProtection`, `waf`. ||
|| waf | **[Waf](#yandex.cloud.smartwebsecurity.v1.SecurityRule.Waf2)**

Web Application Firewall (WAF) rule, see [WAF rules](/docs/smartwebsecurity/concepts/rules#waf-rules).

Includes only one of the fields `ruleCondition`, `smartProtection`, `waf`. ||
|| description | **string**

Optional description of the rule. 0-512 characters long. ||
|#

## RuleCondition {#yandex.cloud.smartwebsecurity.v1.SecurityRule.RuleCondition2}

RuleCondition object.

#|
||Field | Description ||
|| action | **enum** (Action)

Action to perform if this rule matched.

- `ACTION_UNSPECIFIED`
- `ALLOW`: Pass request to service.
- `DENY`: Deny request. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition2)**

The condition for matching the rule. ||
|#

## Condition {#yandex.cloud.smartwebsecurity.v1.Condition2}

Condition object. AND semantics implied.
See [documentation](/docs/smartwebsecurity/concepts/conditions) for matchers description.

#|
||Field | Description ||
|| authority | **[AuthorityMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.AuthorityMatcher2)**

Match authority (Host header). ||
|| httpMethod | **[HttpMethodMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.HttpMethodMatcher2)**

Match HTTP method. ||
|| requestUri | **[RequestUriMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.RequestUriMatcher2)**

Match Request URI. ||
|| headers[] | **[HeaderMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.HeaderMatcher2)**

Match HTTP headers. ||
|| sourceIp | **[IpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpMatcher2)**

Match IP. ||
|#

## AuthorityMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.AuthorityMatcher2}

AuthorityMatcher object.

#|
||Field | Description ||
|| authorities[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher2)**

List of authorities. OR semantics implied. ||
|#

## StringMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher2}

StringMatcher object.

#|
||Field | Description ||
|| exactMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| exactNotMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| prefixMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| prefixNotMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| pireRegexMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| pireRegexNotMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|#

## HttpMethodMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.HttpMethodMatcher2}

HttpMethodMatcher object.

#|
||Field | Description ||
|| httpMethods[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher2)**

List of HTTP methods. OR semantics implied. ||
|#

## RequestUriMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.RequestUriMatcher2}

RequestUriMatcher object. AND semantics implied.

#|
||Field | Description ||
|| path | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher2)**

Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3). ||
|| queries[] | **[QueryMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.QueryMatcher2)**

List of query matchers. AND semantics implied. ||
|#

## QueryMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.QueryMatcher2}

QueryMatcher object.

#|
||Field | Description ||
|| key | **string**

Required field. Key of the query parameter. ||
|| value | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher2)**

Required field. Value of the query parameter. ||
|#

## HeaderMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.HeaderMatcher2}

HeaderMatcher object.

#|
||Field | Description ||
|| name | **string**

Required field. Name of header (case insensitive). ||
|| value | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher2)**

Required field. Value of the header. ||
|#

## IpMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IpMatcher2}

IpMatcher object. AND semantics implied.

#|
||Field | Description ||
|| ipRangesMatch | **[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher2)** ||
|| ipRangesNotMatch | **[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher2)** ||
|| geoIpMatch | **[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher2)** ||
|| geoIpNotMatch | **[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher2)** ||
|#

## IpRangesMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher2}

IpRangesMatcher object.

#|
||Field | Description ||
|| ipRanges[] | **string**

List of IP ranges. OR semantics implied. ||
|#

## GeoIpMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher2}

GeoIpMatcher object.

#|
||Field | Description ||
|| locations[] | **string**

ISO 3166-1 alpha 2. OR semantics implied. ||
|#

## SmartProtection {#yandex.cloud.smartwebsecurity.v1.SecurityRule.SmartProtection2}

SmartProtection object.

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode of protection.

- `MODE_UNSPECIFIED`
- `FULL`: Full protection means that the traffic will be checked based on ML models and behavioral analysis,
with suspicious requests being sent to SmartCaptcha.
- `API`: API protection means checking the traffic based on ML models and behavioral analysis without sending suspicious
requests to SmartCaptcha. The suspicious requests will be blocked. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition2)**

The condition for matching the rule. ||
|#

## Waf {#yandex.cloud.smartwebsecurity.v1.SecurityRule.Waf2}

Waf object.

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode of protection.

- `MODE_UNSPECIFIED`
- `FULL`: Full protection means that the traffic will be checked based on ML models and behavioral analysis,
with suspicious requests being sent to SmartCaptcha.
- `API`: API protection means checking the traffic based on ML models and behavioral analysis without sending suspicious
requests to SmartCaptcha. The suspicious requests will be blocked. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition2)**

The condition for matching the rule. ||
|| wafProfileId | **string**

Required field. ID of WAF profile to use in this rule. ||
|#

## AnalyzeRequestBody {#yandex.cloud.smartwebsecurity.v1.SecurityProfile.AnalyzeRequestBody2}

#|
||Field | Description ||
|| sizeLimit | **string** (int64)

Maximum size of body to pass to analyzer. In kilobytes. ||
|| sizeLimitAction | **enum** (Action)

Action to perform if maximum size of body exceeded.

- `ACTION_UNSPECIFIED`
- `IGNORE`: Ignore body.
- `DENY`: Deny request. ||
|#