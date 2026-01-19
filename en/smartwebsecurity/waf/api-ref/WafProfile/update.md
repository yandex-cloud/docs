---
editable: false
apiPlayground:
  - url: https://smartwebsecurity.{{ api-host }}/smartwebsecurity/v1/wafProfiles/{wafProfileId}
    method: patch
    path:
      type: object
      properties:
        wafProfileId:
          description: |-
            **string**
            Required field. ID of the WAF profile to update.
          type: string
      required:
        - wafProfileId
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
        name:
          description: |-
            **string**
            Name of the WAF profile. The name is unique within the folder. 1-50 characters long.
          type: string
        description:
          description: |-
            **string**
            Optional description of the WAF profile.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Labels as `` key:value `` pairs. Maximum of 64 per resource.
          type: object
          additionalProperties:
            type: string
        rules:
          description: |-
            **[WafProfileRule](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileRule)**
            Settings for each rule in rule set.
          type: array
          items:
            $ref: '#/definitions/WafProfileRule'
        exclusionRules:
          description: |-
            **[WafProfileExclusionRule](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule)**
            List of exclusion rules. See [Rules](/docs/smartwebsecurity/concepts/waf#exclusion-rules).
          type: array
          items:
            $ref: '#/definitions/WafProfileExclusionRule'
        coreRuleSet:
          description: |-
            **[CoreRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.CoreRuleSet)**
            Core rule set settings. See [Basic rule set](/docs/smartwebsecurity/concepts/waf#rules-set) for details.
            Includes only one of the fields `coreRuleSet`.
          $ref: '#/definitions/CoreRuleSet'
        analyzeRequestBody:
          description: |-
            **[AnalyzeRequestBody](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.AnalyzeRequestBody)**
            Parameters for request body analyzer.
          $ref: '#/definitions/AnalyzeRequestBody'
        ruleSets:
          description: |-
            **[WafProfileRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet)**
            List of rule sets. See [Rules](/docs/smartwebsecurity/concepts/waf#rules-set).
          type: array
          items:
            $ref: '#/definitions/WafProfileRuleSet'
        matchAllRuleSets:
          description: |-
            **boolean**
            Parameter determines should all rule sets be matched.
          type: boolean
      additionalProperties: false
    definitions:
      WafProfileRule:
        type: object
        properties:
          ruleId:
            description: |-
              **string**
              Required field. Rule ID.
            type: string
          isEnabled:
            description: |-
              **boolean**
              Determines is it rule enabled or not.
            type: boolean
          isBlocking:
            description: |-
              **boolean**
              Determines is it rule blocking or not.
            type: boolean
        required:
          - ruleId
      StringMatcher:
        type: object
        properties:
          exactMatch:
            description: |-
              **string**
              The string length in characters must be 0-255.
              Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
            type: string
          exactNotMatch:
            description: |-
              **string**
              The string length in characters must be 0-255.
              Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
            type: string
          prefixMatch:
            description: |-
              **string**
              The string length in characters must be 0-255.
              Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
            type: string
          prefixNotMatch:
            description: |-
              **string**
              The string length in characters must be 0-255.
              Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
            type: string
          pireRegexMatch:
            description: |-
              **string**
              The string length in characters must be 0-255.
              Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
            type: string
          pireRegexNotMatch:
            description: |-
              **string**
              The string length in characters must be 0-255.
              Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
            type: string
        oneOf:
          - required:
              - exactMatch
          - required:
              - exactNotMatch
          - required:
              - prefixMatch
          - required:
              - prefixNotMatch
          - required:
              - pireRegexMatch
          - required:
              - pireRegexNotMatch
      AuthorityMatcher:
        type: object
        properties:
          authorities:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**
              List of authorities. OR semantics implied.
              The maximum number of elements is 20.
            type: array
            items:
              $ref: '#/definitions/StringMatcher'
      HttpMethodMatcher:
        type: object
        properties:
          httpMethods:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**
              List of HTTP methods. OR semantics implied.
              The maximum number of elements is 20.
            type: array
            items:
              $ref: '#/definitions/StringMatcher'
      QueryMatcher:
        type: object
        properties:
          key:
            description: |-
              **string**
              Required field. Key of the query parameter.
              The string length in characters must be 1-255.
            type: string
          value:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**
              Required field. Value of the query parameter.
            $ref: '#/definitions/StringMatcher'
        required:
          - key
          - value
      RequestUriMatcher:
        type: object
        properties:
          path:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**
              Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3).
            $ref: '#/definitions/StringMatcher'
          queries:
            description: |-
              **[QueryMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.QueryMatcher)**
              List of query matchers. AND semantics implied.
              The maximum number of elements is 20.
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
              The string length in characters must be 1-255.
            type: string
          value:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**
              Required field. Value of the header.
            $ref: '#/definitions/StringMatcher'
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
              The maximum number of elements is 10000.
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
              The minimum number of elements is 1.
            uniqueItems: true
            type: array
            items:
              type: string
      IpMatcher:
        type: object
        properties:
          ipRangesMatch:
            description: '**[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher)**'
            $ref: '#/definitions/IpRangesMatcher'
          ipRangesNotMatch:
            description: '**[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher)**'
            $ref: '#/definitions/IpRangesMatcher'
          geoIpMatch:
            description: '**[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher)**'
            $ref: '#/definitions/GeoIpMatcher'
          geoIpNotMatch:
            description: '**[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher)**'
            $ref: '#/definitions/GeoIpMatcher'
      Condition:
        type: object
        properties:
          authority:
            description: |-
              **[AuthorityMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.AuthorityMatcher)**
              Match authority (Host header).
            $ref: '#/definitions/AuthorityMatcher'
          httpMethod:
            description: |-
              **[HttpMethodMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.HttpMethodMatcher)**
              Match HTTP method.
            $ref: '#/definitions/HttpMethodMatcher'
          requestUri:
            description: |-
              **[RequestUriMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.RequestUriMatcher)**
              Match Request URI.
            $ref: '#/definitions/RequestUriMatcher'
          headers:
            description: |-
              **[HeaderMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.HeaderMatcher)**
              Match HTTP headers.
              The maximum number of elements is 20.
            type: array
            items:
              $ref: '#/definitions/HeaderMatcher'
          sourceIp:
            description: |-
              **[IpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpMatcher)**
              Match IP.
            $ref: '#/definitions/IpMatcher'
      ExcludeRules:
        type: object
        properties:
          excludeAll:
            description: |-
              **boolean**
              Set this option true to exclude all rules.
            type: boolean
          ruleIds:
            description: |-
              **string**
              List of rules to exclude.
            type: array
            items:
              type: string
      WafProfileExclusionRule:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of exclusion rule.
            type: string
          description:
            description: |-
              **string**
              Optional description of the rule. 0-512 characters long.
              The maximum string length in characters is 512.
            type: string
          condition:
            description: |-
              **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition)**
              The condition for matching traffic.
            $ref: '#/definitions/Condition'
          excludeRules:
            description: |-
              **[ExcludeRules](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.ExcludeRules)**
              Required field. Exclude rules.
            $ref: '#/definitions/ExcludeRules'
          logExcluded:
            description: |-
              **boolean**
              Records the fact that an exception rule is triggered.
            type: boolean
        required:
          - name
          - excludeRules
      RuleSet:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of rule set.
            type: string
          version:
            description: |-
              **string**
              Required field. Version of rule set.
            type: string
          type:
            description: |-
              **enum** (RuleSetType)
              Type of rule set.
              - `CORE`: Core rule set.
              - `YA`: Yandex rule set.
              - `ML`: Yandex machine learning rule set.
            type: string
            enum:
              - RULE_SET_TYPE_UNSPECIFIED
              - CORE
              - YA
              - ML
          id:
            description: |-
              **string**
              ID of rule set.
            type: string
        required:
          - name
          - version
      CoreRuleSet:
        type: object
        properties:
          inboundAnomalyScore:
            description: |-
              **string** (int64)
              Anomaly score.
              Enter an integer within the range of 2 and 10000.
              The higher this value, the more likely it is that the request that satisfies the rule is an attack.
              See [Rules](/docs/smartwebsecurity/concepts/waf#anomaly) for more details.
              Acceptable values are 2 to 10000, inclusive.
            type: string
            format: int64
          paranoiaLevel:
            description: |-
              **string** (int64)
              Paranoia level.
              Enter an integer within the range of 1 and 4.
              Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection,
              but also the higher the probability of WAF false positives.
              See [Rules](/docs/smartwebsecurity/concepts/waf#paranoia) for more details.
              NOTE: this option has no effect on enabling or disabling rules.
              it is used only as recommendation for user to enable all rules with paranoia_level <= this value.
            type: string
            format: int64
          ruleSet:
            description: |-
              **[RuleSet](#yandex.cloud.smartwebsecurity.v1.waf.RuleSet)**
              Required field. Rule set.
            $ref: '#/definitions/RuleSet'
        required:
          - ruleSet
      AnalyzeRequestBody:
        type: object
        properties:
          isEnabled:
            description: |-
              **boolean**
              Possible to turn analyzer on and turn if off.
            type: boolean
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
              - `IGNORE`: Ignore request.
              - `DENY`: Deny request.
            type: string
            enum:
              - ACTION_UNSPECIFIED
              - IGNORE
              - DENY
      WafProfileCoreRuleSet:
        type: object
        properties:
          ruleSet:
            description: |-
              **[RuleSet](#yandex.cloud.smartwebsecurity.v1.waf.RuleSet)**
              Required field. Rule set.
            $ref: '#/definitions/RuleSet'
          inboundAnomalyScore:
            description: |-
              **string** (int64)
              Anomaly score.
              Enter an integer within the range of 2 and 10000.
              The higher this value, the more likely it is that the request that satisfies the rule is an attack.
              See [Rules](/docs/smartwebsecurity/concepts/waf#anomaly) for more details.
              Acceptable values are 2 to 10000, inclusive.
            type: string
            format: int64
          paranoiaLevel:
            description: |-
              **string** (int64)
              Paranoia level.
              Enter an integer within the range of 1 and 4.
              Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection,
              but also the higher the probability of WAF false positives.
              See [Rules](/docs/smartwebsecurity/concepts/waf#paranoia) for more details.
              NOTE: this option has no effect on enabling or disabling rules.
              it is used only as recommendation for user to enable all rules with paranoia_level <= this value.
            type: string
            format: int64
        required:
          - ruleSet
      RuleGroup:
        type: object
        properties:
          id:
            description: |-
              **string**
              ID of the rule group.
            type: string
          action:
            description: |-
              **enum** (Action)
              Action to perfome on rule group match.
              - `IGNORE`: Ignore request.
              - `DENY`: Deny request.
            type: string
            enum:
              - ACTION_UNSPECIFIED
              - IGNORE
              - DENY
          inboundAnomalyScore:
            description: |-
              **string** (int64)
              Anomaly score.
              Acceptable values are 1 to 10000, inclusive.
            type: string
            format: int64
          isEnabled:
            description: |-
              **boolean**
              Determines is it rule group enabled or not.
            type: boolean
      WafProfileYaRuleSet:
        type: object
        properties:
          ruleSet:
            description: |-
              **[RuleSet](#yandex.cloud.smartwebsecurity.v1.waf.RuleSet)**
              Required field. Rule set.
            $ref: '#/definitions/RuleSet'
          ruleGroups:
            description: |-
              **[RuleGroup](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.RuleGroup)**
              List of rule groups.
            type: array
            items:
              $ref: '#/definitions/RuleGroup'
        required:
          - ruleSet
      WafProfileMlRuleSet:
        type: object
        properties:
          ruleSet:
            description: |-
              **[RuleSet](#yandex.cloud.smartwebsecurity.v1.waf.RuleSet)**
              Required field. Rule set.
            $ref: '#/definitions/RuleSet'
          ruleGroups:
            description: |-
              **[RuleGroup](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.RuleGroup)**
              List of rule groups.
            type: array
            items:
              $ref: '#/definitions/RuleGroup'
        required:
          - ruleSet
      WafProfileRuleSet:
        type: object
        properties:
          coreRuleSet:
            description: |-
              **[WafProfileCoreRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileCoreRuleSet)**
              Core rule set settings. See [Basic rule set](/docs/smartwebsecurity/concepts/waf#rules-set) for details.
              Includes only one of the fields `coreRuleSet`, `yaRuleSet`, `mlRuleSet`.
            $ref: '#/definitions/WafProfileCoreRuleSet'
          yaRuleSet:
            description: |-
              **[WafProfileYaRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileYaRuleSet)**
              Yandex rule set settings.
              Includes only one of the fields `coreRuleSet`, `yaRuleSet`, `mlRuleSet`.
            $ref: '#/definitions/WafProfileYaRuleSet'
          mlRuleSet:
            description: |-
              **[WafProfileMlRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileMlRuleSet)**
              Yandex Machine learning rule set settings.
              Includes only one of the fields `coreRuleSet`, `yaRuleSet`, `mlRuleSet`.
            $ref: '#/definitions/WafProfileMlRuleSet'
          priority:
            description: |-
              **string** (int64)
              Priority of rule set.
              Acceptable values are 1 to 999999, inclusive.
            type: string
            format: int64
          isEnabled:
            description: |-
              **boolean**
              Determines is it rule set enabled or not.
            type: boolean
          action:
            description: |-
              **enum** (RuleSetAction)
              Action to perfome on rule set match.
              - `DENY`: Deny request.
              - `CAPTCHA`: Show captcha.
            type: string
            enum:
              - RULE_SET_ACTION_UNSPECIFIED
              - DENY
              - CAPTCHA
        oneOf:
          - required:
              - coreRuleSet
          - required:
              - yaRuleSet
          - required:
              - mlRuleSet
sourcePath: en/_api-ref/smartwebsecurity/v1/waf/api-ref/WafProfile/update.md
---

# SmartWebSecurity WAF API, REST: WafProfile.Update

Updates the specified WAF profile.

## HTTP request

```
PATCH https://smartwebsecurity.{{ api-host }}/smartwebsecurity/v1/wafProfiles/{wafProfileId}
```

## Path parameters

#|
||Field | Description ||
|| wafProfileId | **string**

Required field. ID of the WAF profile to update. ||
|#

## Body parameters {#yandex.cloud.smartwebsecurity.v1.waf.UpdateWafProfileRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "rules": [
    {
      "ruleId": "string",
      "isEnabled": "boolean",
      "isBlocking": "boolean"
    }
  ],
  "exclusionRules": [
    {
      "name": "string",
      "description": "string",
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
      "excludeRules": {
        "excludeAll": "boolean",
        "ruleIds": [
          "string"
        ]
      },
      "logExcluded": "boolean"
    }
  ],
  // Includes only one of the fields `coreRuleSet`
  "coreRuleSet": {
    "inboundAnomalyScore": "string",
    "paranoiaLevel": "string",
    "ruleSet": {
      "name": "string",
      "version": "string",
      "type": "string",
      "id": "string"
    }
  },
  // end of the list of possible fields
  "analyzeRequestBody": {
    "isEnabled": "boolean",
    "sizeLimit": "string",
    "sizeLimitAction": "string"
  },
  "ruleSets": [
    {
      // Includes only one of the fields `coreRuleSet`, `yaRuleSet`, `mlRuleSet`
      "coreRuleSet": {
        "ruleSet": {
          "name": "string",
          "version": "string",
          "type": "string",
          "id": "string"
        },
        "inboundAnomalyScore": "string",
        "paranoiaLevel": "string"
      },
      "yaRuleSet": {
        "ruleSet": {
          "name": "string",
          "version": "string",
          "type": "string",
          "id": "string"
        },
        "ruleGroups": [
          {
            "id": "string",
            "action": "string",
            "inboundAnomalyScore": "string",
            "isEnabled": "boolean"
          }
        ]
      },
      "mlRuleSet": {
        "ruleSet": {
          "name": "string",
          "version": "string",
          "type": "string",
          "id": "string"
        },
        "ruleGroups": [
          {
            "id": "string",
            "action": "string",
            "inboundAnomalyScore": "string",
            "isEnabled": "boolean"
          }
        ]
      },
      // end of the list of possible fields
      "priority": "string",
      "isEnabled": "boolean",
      "action": "string"
    }
  ],
  "matchAllRuleSets": "boolean"
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
|| name | **string**

Name of the WAF profile. The name is unique within the folder. 1-50 characters long. ||
|| description | **string**

Optional description of the WAF profile. ||
|| labels | **object** (map<**string**, **string**>)

Labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| rules[] | **[WafProfileRule](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileRule)**

Settings for each rule in rule set. ||
|| exclusionRules[] | **[WafProfileExclusionRule](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule)**

List of exclusion rules. See [Rules](/docs/smartwebsecurity/concepts/waf#exclusion-rules). ||
|| coreRuleSet | **[CoreRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.CoreRuleSet)**

Core rule set settings. See [Basic rule set](/docs/smartwebsecurity/concepts/waf#rules-set) for details.

Includes only one of the fields `coreRuleSet`. ||
|| analyzeRequestBody | **[AnalyzeRequestBody](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.AnalyzeRequestBody)**

Parameters for request body analyzer. ||
|| ruleSets[] | **[WafProfileRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet)**

List of rule sets. See [Rules](/docs/smartwebsecurity/concepts/waf#rules-set). ||
|| matchAllRuleSets | **boolean**

Parameter determines should all rule sets be matched. ||
|#

## WafProfileRule {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileRule}

WafProfileRule object. Determines settings for each rule_id in rule set.

#|
||Field | Description ||
|| ruleId | **string**

Required field. Rule ID. ||
|| isEnabled | **boolean**

Determines is it rule enabled or not. ||
|| isBlocking | **boolean**

Determines is it rule blocking or not. ||
|#

## WafProfileExclusionRule {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule}

A WafProfileExclusionRule object. See [Exclusion rules](/docs/smartwebsecurity/concepts/waf#exclusion-rules).

#|
||Field | Description ||
|| name | **string**

Required field. Name of exclusion rule. ||
|| description | **string**

Optional description of the rule. 0-512 characters long.

The maximum string length in characters is 512. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition)**

The condition for matching traffic. ||
|| excludeRules | **[ExcludeRules](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.ExcludeRules)**

Required field. Exclude rules. ||
|| logExcluded | **boolean**

Records the fact that an exception rule is triggered. ||
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

Match HTTP headers.

The maximum number of elements is 20. ||
|| sourceIp | **[IpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpMatcher)**

Match IP. ||
|#

## AuthorityMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.AuthorityMatcher}

AuthorityMatcher object.

#|
||Field | Description ||
|| authorities[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

List of authorities. OR semantics implied.

The maximum number of elements is 20. ||
|#

## StringMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher}

StringMatcher object.

#|
||Field | Description ||
|| exactMatch | **string**

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| exactNotMatch | **string**

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| prefixMatch | **string**

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| prefixNotMatch | **string**

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| pireRegexMatch | **string**

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| pireRegexNotMatch | **string**

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|#

## HttpMethodMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.HttpMethodMatcher}

HttpMethodMatcher object.

#|
||Field | Description ||
|| httpMethods[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

List of HTTP methods. OR semantics implied.

The maximum number of elements is 20. ||
|#

## RequestUriMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.RequestUriMatcher}

RequestUriMatcher object. AND semantics implied.

#|
||Field | Description ||
|| path | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3). ||
|| queries[] | **[QueryMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.QueryMatcher)**

List of query matchers. AND semantics implied.

The maximum number of elements is 20. ||
|#

## QueryMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.QueryMatcher}

QueryMatcher object.

#|
||Field | Description ||
|| key | **string**

Required field. Key of the query parameter.

The string length in characters must be 1-255. ||
|| value | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

Required field. Value of the query parameter. ||
|#

## HeaderMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.HeaderMatcher}

HeaderMatcher object.

#|
||Field | Description ||
|| name | **string**

Required field. Name of header (case insensitive).

The string length in characters must be 1-255. ||
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

List of IP ranges. OR semantics implied.

The maximum number of elements is 10000. ||
|#

## GeoIpMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher}

GeoIpMatcher object.

#|
||Field | Description ||
|| locations[] | **string**

ISO 3166-1 alpha 2. OR semantics implied.

The minimum number of elements is 1. ||
|#

## ExcludeRules {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.ExcludeRules}

Determines list of excluded rules.

#|
||Field | Description ||
|| excludeAll | **boolean**

Set this option true to exclude all rules. ||
|| ruleIds[] | **string**

List of rules to exclude. ||
|#

## CoreRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.CoreRuleSet}

#|
||Field | Description ||
|| inboundAnomalyScore | **string** (int64)

Anomaly score.
Enter an integer within the range of 2 and 10000.
The higher this value, the more likely it is that the request that satisfies the rule is an attack.
See [Rules](/docs/smartwebsecurity/concepts/waf#anomaly) for more details.

Acceptable values are 2 to 10000, inclusive. ||
|| paranoiaLevel | **string** (int64)

Paranoia level.
Enter an integer within the range of 1 and 4.
Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection,
but also the higher the probability of WAF false positives.
See [Rules](/docs/smartwebsecurity/concepts/waf#paranoia) for more details.
NOTE: this option has no effect on enabling or disabling rules.
it is used only as recommendation for user to enable all rules with paranoia_level <= this value. ||
|| ruleSet | **[RuleSet](#yandex.cloud.smartwebsecurity.v1.waf.RuleSet)**

Required field. Rule set. ||
|#

## RuleSet {#yandex.cloud.smartwebsecurity.v1.waf.RuleSet}

A RuleSet object. Determines name and version of rule set.

#|
||Field | Description ||
|| name | **string**

Required field. Name of rule set. ||
|| version | **string**

Required field. Version of rule set. ||
|| type | **enum** (RuleSetType)

Type of rule set.

- `CORE`: Core rule set.
- `YA`: Yandex rule set.
- `ML`: Yandex machine learning rule set. ||
|| id | **string**

ID of rule set. ||
|#

## AnalyzeRequestBody {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.AnalyzeRequestBody}

#|
||Field | Description ||
|| isEnabled | **boolean**

Possible to turn analyzer on and turn if off. ||
|| sizeLimit | **string** (int64)

Maximum size of body to pass to analyzer. In kilobytes. ||
|| sizeLimitAction | **enum** (Action)

Action to perform if maximum size of body exceeded.

- `IGNORE`: Ignore request.
- `DENY`: Deny request. ||
|#

## WafProfileRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet}

#|
||Field | Description ||
|| coreRuleSet | **[WafProfileCoreRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileCoreRuleSet)**

Core rule set settings. See [Basic rule set](/docs/smartwebsecurity/concepts/waf#rules-set) for details.

Includes only one of the fields `coreRuleSet`, `yaRuleSet`, `mlRuleSet`. ||
|| yaRuleSet | **[WafProfileYaRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileYaRuleSet)**

Yandex rule set settings.

Includes only one of the fields `coreRuleSet`, `yaRuleSet`, `mlRuleSet`. ||
|| mlRuleSet | **[WafProfileMlRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileMlRuleSet)**

Yandex Machine learning rule set settings.

Includes only one of the fields `coreRuleSet`, `yaRuleSet`, `mlRuleSet`. ||
|| priority | **string** (int64)

Priority of rule set.

Acceptable values are 1 to 999999, inclusive. ||
|| isEnabled | **boolean**

Determines is it rule set enabled or not. ||
|| action | **enum** (RuleSetAction)

Action to perfome on rule set match.

- `DENY`: Deny request.
- `CAPTCHA`: Show captcha. ||
|#

## WafProfileCoreRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileCoreRuleSet}

#|
||Field | Description ||
|| ruleSet | **[RuleSet](#yandex.cloud.smartwebsecurity.v1.waf.RuleSet)**

Required field. Rule set. ||
|| inboundAnomalyScore | **string** (int64)

Anomaly score.
Enter an integer within the range of 2 and 10000.
The higher this value, the more likely it is that the request that satisfies the rule is an attack.
See [Rules](/docs/smartwebsecurity/concepts/waf#anomaly) for more details.

Acceptable values are 2 to 10000, inclusive. ||
|| paranoiaLevel | **string** (int64)

Paranoia level.
Enter an integer within the range of 1 and 4.
Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection,
but also the higher the probability of WAF false positives.
See [Rules](/docs/smartwebsecurity/concepts/waf#paranoia) for more details.
NOTE: this option has no effect on enabling or disabling rules.
it is used only as recommendation for user to enable all rules with paranoia_level <= this value. ||
|#

## WafProfileYaRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileYaRuleSet}

#|
||Field | Description ||
|| ruleSet | **[RuleSet](#yandex.cloud.smartwebsecurity.v1.waf.RuleSet)**

Required field. Rule set. ||
|| ruleGroups[] | **[RuleGroup](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.RuleGroup)**

List of rule groups. ||
|#

## RuleGroup {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.RuleGroup}

#|
||Field | Description ||
|| id | **string**

ID of the rule group. ||
|| action | **enum** (Action)

Action to perfome on rule group match.

- `DENY`: Deny request.
- `LOG`: Log request.
- `IGNORE`: Ignore request. ||
|| inboundAnomalyScore | **string** (int64)

Anomaly score.

Acceptable values are 1 to 10000, inclusive. ||
|| isEnabled | **boolean**

Determines is it rule group enabled or not. ||
|#

## WafProfileMlRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileMlRuleSet}

#|
||Field | Description ||
|| ruleSet | **[RuleSet](#yandex.cloud.smartwebsecurity.v1.waf.RuleSet)**

Required field. Rule set. ||
|| ruleGroups[] | **[RuleGroup](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.RuleGroup)**

List of rule groups. ||
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
    "wafProfileId": "string"
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
    "cloudId": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "createdAt": "string",
    "rules": [
      {
        "ruleId": "string",
        "isEnabled": "boolean",
        "isBlocking": "boolean"
      }
    ],
    "exclusionRules": [
      {
        "name": "string",
        "description": "string",
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
        "excludeRules": {
          "excludeAll": "boolean",
          "ruleIds": [
            "string"
          ]
        },
        "logExcluded": "boolean"
      }
    ],
    // Includes only one of the fields `coreRuleSet`
    "coreRuleSet": {
      "inboundAnomalyScore": "string",
      "paranoiaLevel": "string",
      "ruleSet": {
        "name": "string",
        "version": "string",
        "type": "string",
        "id": "string"
      }
    },
    // end of the list of possible fields
    "analyzeRequestBody": {
      "isEnabled": "boolean",
      "sizeLimit": "string",
      "sizeLimitAction": "string"
    },
    "ruleSets": [
      {
        // Includes only one of the fields `coreRuleSet`, `yaRuleSet`, `mlRuleSet`
        "coreRuleSet": {
          "ruleSet": {
            "name": "string",
            "version": "string",
            "type": "string",
            "id": "string"
          },
          "inboundAnomalyScore": "string",
          "paranoiaLevel": "string"
        },
        "yaRuleSet": {
          "ruleSet": {
            "name": "string",
            "version": "string",
            "type": "string",
            "id": "string"
          },
          "ruleGroups": [
            {
              "id": "string",
              "action": "string",
              "inboundAnomalyScore": "string",
              "isEnabled": "boolean"
            }
          ]
        },
        "mlRuleSet": {
          "ruleSet": {
            "name": "string",
            "version": "string",
            "type": "string",
            "id": "string"
          },
          "ruleGroups": [
            {
              "id": "string",
              "action": "string",
              "inboundAnomalyScore": "string",
              "isEnabled": "boolean"
            }
          ]
        },
        // end of the list of possible fields
        "priority": "string",
        "isEnabled": "boolean",
        "action": "string"
      }
    ],
    "matchAllRuleSets": "boolean"
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
|| metadata | **[UpdateWafProfileMetadata](#yandex.cloud.smartwebsecurity.v1.waf.UpdateWafProfileMetadata)**

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
|| response | **[WafProfile](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile)**

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

## UpdateWafProfileMetadata {#yandex.cloud.smartwebsecurity.v1.waf.UpdateWafProfileMetadata}

#|
||Field | Description ||
|| wafProfileId | **string**

ID of the WafProfile resource that is being updated. ||
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

## WafProfile {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the WAF profile. ||
|| folderId | **string**

Required field. ID of the folder that the WAF profile belongs to. ||
|| cloudId | **string**

Required field. ID of the cloud that the WAF profile belongs to. ||
|| name | **string**

Required field. Name of the WAF profile. The name is unique within the folder. 1-50 characters long.

The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `. ||
|| description | **string**

Optional description of the WAF profile.

The maximum string length in characters is 512. ||
|| labels | **object** (map<**string**, **string**>)

Labels as `` key:value `` pairs. Maximum of 64 per resource.

No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| rules[] | **[WafProfileRule](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileRule2)**

Settings for each rule in rule set. ||
|| exclusionRules[] | **[WafProfileExclusionRule](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule2)**

List of exclusion rules. See [Rules](/docs/smartwebsecurity/concepts/waf#exclusion-rules). ||
|| coreRuleSet | **[CoreRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.CoreRuleSet2)**

The parameter is deprecated. Core rule set settings.

Includes only one of the fields `coreRuleSet`. ||
|| analyzeRequestBody | **[AnalyzeRequestBody](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.AnalyzeRequestBody2)**

The parameter is deprecated. Parameters for request body analyzer. ||
|| ruleSets[] | **[WafProfileRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet2)**

List of rule sets. ||
|| matchAllRuleSets | **boolean**

Determines ||
|#

## WafProfileRule {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileRule2}

WafProfileRule object. Determines settings for each rule_id in rule set.

#|
||Field | Description ||
|| ruleId | **string**

Required field. Rule ID. ||
|| isEnabled | **boolean**

Determines is it rule enabled or not. ||
|| isBlocking | **boolean**

Determines is it rule blocking or not. ||
|#

## WafProfileExclusionRule {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule2}

A WafProfileExclusionRule object. See [Exclusion rules](/docs/smartwebsecurity/concepts/waf#exclusion-rules).

#|
||Field | Description ||
|| name | **string**

Required field. Name of exclusion rule. ||
|| description | **string**

Optional description of the rule. 0-512 characters long.

The maximum string length in characters is 512. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition2)**

The condition for matching traffic. ||
|| excludeRules | **[ExcludeRules](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.ExcludeRules2)**

Required field. Exclude rules. ||
|| logExcluded | **boolean**

Records the fact that an exception rule is triggered. ||
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

Match HTTP headers.

The maximum number of elements is 20. ||
|| sourceIp | **[IpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpMatcher2)**

Match IP. ||
|#

## AuthorityMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.AuthorityMatcher2}

AuthorityMatcher object.

#|
||Field | Description ||
|| authorities[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher2)**

List of authorities. OR semantics implied.

The maximum number of elements is 20. ||
|#

## StringMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher2}

StringMatcher object.

#|
||Field | Description ||
|| exactMatch | **string**

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| exactNotMatch | **string**

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| prefixMatch | **string**

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| prefixNotMatch | **string**

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| pireRegexMatch | **string**

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| pireRegexNotMatch | **string**

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|#

## HttpMethodMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.HttpMethodMatcher2}

HttpMethodMatcher object.

#|
||Field | Description ||
|| httpMethods[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher2)**

List of HTTP methods. OR semantics implied.

The maximum number of elements is 20. ||
|#

## RequestUriMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.RequestUriMatcher2}

RequestUriMatcher object. AND semantics implied.

#|
||Field | Description ||
|| path | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher2)**

Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3). ||
|| queries[] | **[QueryMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.QueryMatcher2)**

List of query matchers. AND semantics implied.

The maximum number of elements is 20. ||
|#

## QueryMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.QueryMatcher2}

QueryMatcher object.

#|
||Field | Description ||
|| key | **string**

Required field. Key of the query parameter.

The string length in characters must be 1-255. ||
|| value | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher2)**

Required field. Value of the query parameter. ||
|#

## HeaderMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.HeaderMatcher2}

HeaderMatcher object.

#|
||Field | Description ||
|| name | **string**

Required field. Name of header (case insensitive).

The string length in characters must be 1-255. ||
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

List of IP ranges. OR semantics implied.

The maximum number of elements is 10000. ||
|#

## GeoIpMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher2}

GeoIpMatcher object.

#|
||Field | Description ||
|| locations[] | **string**

ISO 3166-1 alpha 2. OR semantics implied.

The minimum number of elements is 1. ||
|#

## ExcludeRules {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.ExcludeRules2}

Determines list of excluded rules.

#|
||Field | Description ||
|| excludeAll | **boolean**

Set this option true to exclude all rules. ||
|| ruleIds[] | **string**

List of rules to exclude. ||
|#

## CoreRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.CoreRuleSet2}

#|
||Field | Description ||
|| inboundAnomalyScore | **string** (int64)

Anomaly score.
Enter an integer within the range of 2 and 10000.
The higher this value, the more likely it is that the request that satisfies the rule is an attack.
See [Rules](/docs/smartwebsecurity/concepts/waf#anomaly) for more details.

Acceptable values are 2 to 10000, inclusive. ||
|| paranoiaLevel | **string** (int64)

Paranoia level.
Enter an integer within the range of 1 and 4.
Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection,
but also the higher the probability of WAF false positives.
See [Rules](/docs/smartwebsecurity/concepts/waf#paranoia) for more details.
NOTE: this option has no effect on enabling or disabling rules.
it is used only as recommendation for user to enable all rules with paranoia_level <= this value. ||
|| ruleSet | **[RuleSet](#yandex.cloud.smartwebsecurity.v1.waf.RuleSet2)**

Required field. Rule set. ||
|#

## RuleSet {#yandex.cloud.smartwebsecurity.v1.waf.RuleSet2}

A RuleSet object. Determines name and version of rule set.

#|
||Field | Description ||
|| name | **string**

Required field. Name of rule set. ||
|| version | **string**

Required field. Version of rule set. ||
|| type | **enum** (RuleSetType)

Type of rule set.

- `CORE`: Core rule set.
- `YA`: Yandex rule set.
- `ML`: Yandex machine learning rule set. ||
|| id | **string**

ID of rule set. ||
|#

## AnalyzeRequestBody {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.AnalyzeRequestBody2}

#|
||Field | Description ||
|| isEnabled | **boolean**

Possible to turn analyzer on and turn if off. ||
|| sizeLimit | **string** (int64)

Maximum size of body to pass to analyzer. In kilobytes. ||
|| sizeLimitAction | **enum** (Action)

Action to perform if maximum size of body exceeded.

- `IGNORE`: Ignore request.
- `DENY`: Deny request. ||
|#

## WafProfileRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet2}

#|
||Field | Description ||
|| coreRuleSet | **[WafProfileCoreRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileCoreRuleSet2)**

Core rule set settings. See [Basic rule set](/docs/smartwebsecurity/concepts/waf#rules-set) for details.

Includes only one of the fields `coreRuleSet`, `yaRuleSet`, `mlRuleSet`. ||
|| yaRuleSet | **[WafProfileYaRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileYaRuleSet2)**

Yandex rule set settings.

Includes only one of the fields `coreRuleSet`, `yaRuleSet`, `mlRuleSet`. ||
|| mlRuleSet | **[WafProfileMlRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileMlRuleSet2)**

Yandex Machine learning rule set settings.

Includes only one of the fields `coreRuleSet`, `yaRuleSet`, `mlRuleSet`. ||
|| priority | **string** (int64)

Priority of rule set.

Acceptable values are 1 to 999999, inclusive. ||
|| isEnabled | **boolean**

Determines is it rule set enabled or not. ||
|| action | **enum** (RuleSetAction)

Action to perfome on rule set match.

- `DENY`: Deny request.
- `CAPTCHA`: Show captcha. ||
|#

## WafProfileCoreRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileCoreRuleSet2}

#|
||Field | Description ||
|| ruleSet | **[RuleSet](#yandex.cloud.smartwebsecurity.v1.waf.RuleSet2)**

Required field. Rule set. ||
|| inboundAnomalyScore | **string** (int64)

Anomaly score.
Enter an integer within the range of 2 and 10000.
The higher this value, the more likely it is that the request that satisfies the rule is an attack.
See [Rules](/docs/smartwebsecurity/concepts/waf#anomaly) for more details.

Acceptable values are 2 to 10000, inclusive. ||
|| paranoiaLevel | **string** (int64)

Paranoia level.
Enter an integer within the range of 1 and 4.
Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection,
but also the higher the probability of WAF false positives.
See [Rules](/docs/smartwebsecurity/concepts/waf#paranoia) for more details.
NOTE: this option has no effect on enabling or disabling rules.
it is used only as recommendation for user to enable all rules with paranoia_level <= this value. ||
|#

## WafProfileYaRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileYaRuleSet2}

#|
||Field | Description ||
|| ruleSet | **[RuleSet](#yandex.cloud.smartwebsecurity.v1.waf.RuleSet2)**

Required field. Rule set. ||
|| ruleGroups[] | **[RuleGroup](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.RuleGroup2)**

List of rule groups. ||
|#

## RuleGroup {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.RuleGroup2}

#|
||Field | Description ||
|| id | **string**

ID of the rule group. ||
|| action | **enum** (Action)

Action to perfome on rule group match.

- `DENY`: Deny request.
- `LOG`: Log request.
- `IGNORE`: Ignore request. ||
|| inboundAnomalyScore | **string** (int64)

Anomaly score.

Acceptable values are 1 to 10000, inclusive. ||
|| isEnabled | **boolean**

Determines is it rule group enabled or not. ||
|#

## WafProfileMlRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileMlRuleSet2}

#|
||Field | Description ||
|| ruleSet | **[RuleSet](#yandex.cloud.smartwebsecurity.v1.waf.RuleSet2)**

Required field. Rule set. ||
|| ruleGroups[] | **[RuleGroup](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.RuleGroup2)**

List of rule groups. ||
|#