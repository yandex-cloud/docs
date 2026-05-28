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
        coreRuleSet:
          description: |-
            **[CoreRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.CoreRuleSet)**
            Core rule set settings. See [Basic rule set](/docs/smartwebsecurity/concepts/waf#rules-set) for details.
            Includes only one of the fields `coreRuleSet`.
          $ref: '#/definitions/CoreRuleSet'
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
            The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `.
          pattern: '[a-zA-Z0-9][a-zA-Z0-9-_.]*'
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
          value:
            description: |-
              **string**
              String value to match against.
            type: string
          caseSensitive:
            description: |-
              **boolean**
              Whether the match is case sensitive.
            type: boolean
      AuthorityMatcher:
        type: object
        properties:
          authorities:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**
              List of authorities. OR semantics implied.
              The maximum number of elements is 20.
            deprecated: true
            type: array
            items:
              $ref: '#/definitions/StringMatcher'
          authorityMatcher:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**
              Authority matcher.
            $ref: '#/definitions/StringMatcher'
      HttpMethodMatcher:
        type: object
        properties:
          httpMethods:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**
              List of HTTP methods. OR semantics implied.
              The maximum number of elements is 20.
            deprecated: true
            type: array
            items:
              $ref: '#/definitions/StringMatcher'
          httpMethodMatcher:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**
              HTTP method matcher.
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
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**
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
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**
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
          headerNames:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**
              List of request header names to match. Up to 20 entries.
              The maximum number of elements is 20.
            type: array
            items:
              $ref: '#/definitions/StringMatcher'
      IpRangesMatcher:
        type: object
        properties:
          ipRanges:
            description: |-
              **string**
              List of IP ranges. OR semantics implied.
              The string length in characters for each value must be greater than 0. The maximum number of elements is 10000.
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
      ListsMatcher:
        type: object
        properties:
          listIds:
            description: |-
              **string**
              List of list IDs to match against. OR semantics implied.
              The number of elements must be in the range 1-10.
            uniqueItems: true
            type: array
            items:
              type: string
      AsnRangesMatcher:
        type: object
        properties:
          asnRanges:
            description: |-
              **string** (int64)
              List of ASN values to match against. OR semantics implied.
              The maximum number of elements is 10000. Acceptable values are 0 to 4294967295, inclusive.
            type: array
            items:
              type: string
              format: int64
      IpMatcher:
        type: object
        properties:
          ipRangesMatch:
            description: |-
              **[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher)**
              IP ranges to match with.
            $ref: '#/definitions/IpRangesMatcher'
          ipRangesNotMatch:
            description: |-
              **[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher)**
              IP ranges to not match with.
            $ref: '#/definitions/IpRangesMatcher'
          geoIpMatch:
            description: |-
              **[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher)**
              Geo locations to match with.
            $ref: '#/definitions/GeoIpMatcher'
          geoIpNotMatch:
            description: |-
              **[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher)**
              Geo locations to not match with.
            $ref: '#/definitions/GeoIpMatcher'
          ipListsMatch:
            description: |-
              **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**
              IP lists to match with.
            $ref: '#/definitions/ListsMatcher'
          ipListsNotMatch:
            description: |-
              **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**
              IP lists to not match with.
            $ref: '#/definitions/ListsMatcher'
          asnRangesMatch:
            description: |-
              **[AsnRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.AsnRangesMatcher)**
              ASN ranges to match with.
            $ref: '#/definitions/AsnRangesMatcher'
          asnRangesNotMatch:
            description: |-
              **[AsnRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.AsnRangesMatcher)**
              ASN ranges to not match with.
            $ref: '#/definitions/AsnRangesMatcher'
          asnListsMatch:
            description: |-
              **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**
              ASN lists to match with.
            $ref: '#/definitions/ListsMatcher'
          asnListsNotMatch:
            description: |-
              **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**
              ASN lists to not match with.
            $ref: '#/definitions/ListsMatcher'
      CookieMatcher:
        type: object
        properties:
          cookieNames:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**
              List of cookie names to match. Up to 20 entries.
              The maximum number of elements is 20.
            type: array
            items:
              $ref: '#/definitions/StringMatcher'
      BotCategoryMatcher:
        type: object
        properties:
          botCategoryListsMatch:
            description: |-
              **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**
              Bot category lists to match with.
            $ref: '#/definitions/ListsMatcher'
          botCategoryListsNotMatch:
            description: |-
              **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**
              Bot category lists to not match with.
            $ref: '#/definitions/ListsMatcher'
      BotNameMatcher:
        type: object
        properties:
          botNameListsMatch:
            description: |-
              **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**
              Bot name lists to match with.
            $ref: '#/definitions/ListsMatcher'
          botNameListsNotMatch:
            description: |-
              **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**
              Bot name lists to not match with.
            $ref: '#/definitions/ListsMatcher'
      IntLEMatcher:
        type: object
        properties:
          value:
            description: |-
              **string** (int64)
              Upper bound value (inclusive).
            type: string
            format: int64
      IntGEMatcher:
        type: object
        properties:
          value:
            description: |-
              **string** (int64)
              Lower bound value (inclusive).
            type: string
            format: int64
      IntEQMatcher:
        type: object
        properties:
          value:
            description: |-
              **string** (int64)
              Value to match against.
            type: string
            format: int64
      IntNEMatcher:
        type: object
        properties:
          value:
            description: |-
              **string** (int64)
              Value to not match against.
            type: string
            format: int64
      IntMatcher:
        type: object
        properties:
          leMatch:
            description: |-
              **[IntLEMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IntLEMatcher)**
              Less than or equal condition.
              Includes only one of the fields `leMatch`, `geMatch`, `eqMatch`, `neMatch`.
            $ref: '#/definitions/IntLEMatcher'
          geMatch:
            description: |-
              **[IntGEMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IntGEMatcher)**
              Greater than or equal condition.
              Includes only one of the fields `leMatch`, `geMatch`, `eqMatch`, `neMatch`.
            $ref: '#/definitions/IntGEMatcher'
          eqMatch:
            description: |-
              **[IntEQMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IntEQMatcher)**
              Equal condition.
              Includes only one of the fields `leMatch`, `geMatch`, `eqMatch`, `neMatch`.
            $ref: '#/definitions/IntEQMatcher'
          neMatch:
            description: |-
              **[IntNEMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IntNEMatcher)**
              Not equal condition.
              Includes only one of the fields `leMatch`, `geMatch`, `eqMatch`, `neMatch`.
            $ref: '#/definitions/IntNEMatcher'
        oneOf:
          - required:
              - leMatch
          - required:
              - geMatch
          - required:
              - eqMatch
          - required:
              - neMatch
      BotScoreMatcher:
        type: object
        properties:
          value:
            description: |-
              **[IntMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IntMatcher)**
              List of integer matchers for bot score. OR semantics implied.
              The maximum number of elements is 4.
            type: array
            items:
              $ref: '#/definitions/IntMatcher'
      BoolMatcher:
        type: object
        properties:
          match:
            description: |-
              **boolean**
              Boolean value to match against.
            type: boolean
      VerifiedBotMatcher:
        type: object
        properties:
          verified:
            description: |-
              **[BoolMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.BoolMatcher)**
              Matches if the bot is verified or not.
            $ref: '#/definitions/BoolMatcher'
      FingerPrintMatcher:
        type: object
        properties:
          ja3Ranges:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**
              List of JA3 fingerprint matchers. OR semantics implied.
              The maximum number of elements is 20.
            deprecated: true
            type: array
            items:
              $ref: '#/definitions/StringMatcher'
          ja4Ranges:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**
              List of JA4 fingerprint matchers. OR semantics implied.
              The maximum number of elements is 20.
            deprecated: true
            type: array
            items:
              $ref: '#/definitions/StringMatcher'
          ja3Matcher:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**
              JA3 fingerprint matcher.
            $ref: '#/definitions/StringMatcher'
          ja4Matcher:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**
              JA4 fingerprint matcher.
            $ref: '#/definitions/StringMatcher'
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
              **[HeaderMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.HeaderMatcher)**
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
          cookies:
            description: |-
              **[CookieMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.CookieMatcher)**
              Match cookies.
              The maximum number of elements is 20.
            type: array
            items:
              $ref: '#/definitions/CookieMatcher'
          botCategory:
            description: |-
              **[BotCategoryMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.BotCategoryMatcher)**
              Match bot category.
            $ref: '#/definitions/BotCategoryMatcher'
          botName:
            description: |-
              **[BotNameMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.BotNameMatcher)**
              Match bot name.
            $ref: '#/definitions/BotNameMatcher'
          botScore:
            description: |-
              **[BotScoreMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.BotScoreMatcher)**
              Match bot score.
            $ref: '#/definitions/BotScoreMatcher'
          verifiedBot:
            description: |-
              **[VerifiedBotMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.VerifiedBotMatcher)**
              Match verified bot.
            $ref: '#/definitions/VerifiedBotMatcher'
          fingerPrint:
            description: |-
              **[FingerPrintMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.FingerPrintMatcher)**
              Match fingerprint.
            $ref: '#/definitions/FingerPrintMatcher'
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
      RequestParamMatcher:
        type: object
        properties:
          paramNames:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**
              List of request query parameter names to match. Up to 20 entries.
              The maximum number of elements is 20.
            type: array
            items:
              $ref: '#/definitions/StringMatcher'
      BodyMatcher:
        type: object
        properties:
          bodyValues:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**
              List of request body values to match. Up to 20 entries.
              The maximum number of elements is 20.
            type: array
            items:
              $ref: '#/definitions/StringMatcher'
      RequestCondition:
        type: object
        properties:
          paramMatcher:
            description: |-
              **[RequestParamMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.RequestParamMatcher)**
              Matcher for request query parameters.
            $ref: '#/definitions/RequestParamMatcher'
          headerMatcher:
            description: |-
              **[HeaderMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.HeaderMatcher)**
              Matcher for request headers.
            $ref: '#/definitions/HeaderMatcher'
          cookieMatcher:
            description: |-
              **[CookieMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.CookieMatcher)**
              Matcher for request cookies.
            $ref: '#/definitions/CookieMatcher'
          bodyMatcher:
            description: |-
              **[BodyMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.BodyMatcher)**
              Matcher for request body.
            $ref: '#/definitions/BodyMatcher'
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
          requestCondition:
            description: |-
              **[RequestCondition](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition)**
              Additional condition applied to specific parts of the request to refine when the exclusion is triggered.
            $ref: '#/definitions/RequestCondition'
        required:
          - name
          - excludeRules
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
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              "defined": "boolean",
              "listsMatchers": {
                "strListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "strListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          ],
          "authorityMatcher": {
            // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
            "exactMatch": "string",
            "exactNotMatch": "string",
            "prefixMatch": "string",
            "prefixNotMatch": "string",
            "pireRegexMatch": "string",
            "pireRegexNotMatch": "string",
            "defined": "boolean",
            "listsMatchers": {
              "strListsMatch": {
                "listIds": [
                  "string"
                ]
              },
              "strListsNotMatch": {
                "listIds": [
                  "string"
                ]
              },
              "regExpListsMatch": {
                "listIds": [
                  "string"
                ]
              },
              "regExpListsNotMatch": {
                "listIds": [
                  "string"
                ]
              }
            }
            // end of the list of possible fields
          }
        },
        "httpMethod": {
          "httpMethods": [
            {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              "defined": "boolean",
              "listsMatchers": {
                "strListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "strListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          ],
          "httpMethodMatcher": {
            // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
            "exactMatch": "string",
            "exactNotMatch": "string",
            "prefixMatch": "string",
            "prefixNotMatch": "string",
            "pireRegexMatch": "string",
            "pireRegexNotMatch": "string",
            "defined": "boolean",
            "listsMatchers": {
              "strListsMatch": {
                "listIds": [
                  "string"
                ]
              },
              "strListsNotMatch": {
                "listIds": [
                  "string"
                ]
              },
              "regExpListsMatch": {
                "listIds": [
                  "string"
                ]
              },
              "regExpListsNotMatch": {
                "listIds": [
                  "string"
                ]
              }
            }
            // end of the list of possible fields
          }
        },
        "requestUri": {
          "path": {
            // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
            "exactMatch": "string",
            "exactNotMatch": "string",
            "prefixMatch": "string",
            "prefixNotMatch": "string",
            "pireRegexMatch": "string",
            "pireRegexNotMatch": "string",
            "defined": "boolean",
            "listsMatchers": {
              "strListsMatch": {
                "listIds": [
                  "string"
                ]
              },
              "strListsNotMatch": {
                "listIds": [
                  "string"
                ]
              },
              "regExpListsMatch": {
                "listIds": [
                  "string"
                ]
              },
              "regExpListsNotMatch": {
                "listIds": [
                  "string"
                ]
              }
            }
            // end of the list of possible fields
          },
          "queries": [
            {
              "key": "string",
              "value": {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                "defined": "boolean",
                "listsMatchers": {
                  "strListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "strListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            }
          ]
        },
        "headers": [
          {
            "name": "string",
            "value": {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              "defined": "boolean",
              "listsMatchers": {
                "strListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "strListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                }
              }
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
          },
          "ipListsMatch": {
            "listIds": [
              "string"
            ]
          },
          "ipListsNotMatch": {
            "listIds": [
              "string"
            ]
          },
          "asnRangesMatch": {
            "asnRanges": [
              "string"
            ]
          },
          "asnRangesNotMatch": {
            "asnRanges": [
              "string"
            ]
          },
          "asnListsMatch": {
            "listIds": [
              "string"
            ]
          },
          "asnListsNotMatch": {
            "listIds": [
              "string"
            ]
          }
        },
        "cookies": [
          {
            "name": "string",
            "value": {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              "defined": "boolean",
              "listsMatchers": {
                "strListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "strListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          }
        ],
        "botCategory": {
          "botCategoryListsMatch": {
            "listIds": [
              "string"
            ]
          },
          "botCategoryListsNotMatch": {
            "listIds": [
              "string"
            ]
          }
        },
        "botName": {
          "botNameListsMatch": {
            "listIds": [
              "string"
            ]
          },
          "botNameListsNotMatch": {
            "listIds": [
              "string"
            ]
          }
        },
        "botScore": {
          "value": [
            {
              // Includes only one of the fields `leMatch`, `geMatch`, `eqMatch`, `neMatch`
              "leMatch": {
                "value": "string"
              },
              "geMatch": {
                "value": "string"
              },
              "eqMatch": {
                "value": "string"
              },
              "neMatch": {
                "value": "string"
              }
              // end of the list of possible fields
            }
          ]
        },
        "verifiedBot": {
          "verified": {
            "match": "boolean"
          }
        },
        "fingerPrint": {
          "ja3Ranges": [
            {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              "defined": "boolean",
              "listsMatchers": {
                "strListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "strListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          ],
          "ja4Ranges": [
            {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              "defined": "boolean",
              "listsMatchers": {
                "strListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "strListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          ],
          "ja3Matcher": {
            // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
            "exactMatch": "string",
            "exactNotMatch": "string",
            "prefixMatch": "string",
            "prefixNotMatch": "string",
            "pireRegexMatch": "string",
            "pireRegexNotMatch": "string",
            "defined": "boolean",
            "listsMatchers": {
              "strListsMatch": {
                "listIds": [
                  "string"
                ]
              },
              "strListsNotMatch": {
                "listIds": [
                  "string"
                ]
              },
              "regExpListsMatch": {
                "listIds": [
                  "string"
                ]
              },
              "regExpListsNotMatch": {
                "listIds": [
                  "string"
                ]
              }
            }
            // end of the list of possible fields
          },
          "ja4Matcher": {
            // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
            "exactMatch": "string",
            "exactNotMatch": "string",
            "prefixMatch": "string",
            "prefixNotMatch": "string",
            "pireRegexMatch": "string",
            "pireRegexNotMatch": "string",
            "defined": "boolean",
            "listsMatchers": {
              "strListsMatch": {
                "listIds": [
                  "string"
                ]
              },
              "strListsNotMatch": {
                "listIds": [
                  "string"
                ]
              },
              "regExpListsMatch": {
                "listIds": [
                  "string"
                ]
              },
              "regExpListsNotMatch": {
                "listIds": [
                  "string"
                ]
              }
            }
            // end of the list of possible fields
          }
        }
      },
      "excludeRules": {
        "excludeAll": "boolean",
        "ruleIds": [
          "string"
        ]
      },
      "logExcluded": "boolean",
      "requestCondition": {
        "paramMatcher": {
          "paramNames": [
            {
              "value": "string",
              "caseSensitive": "boolean"
            }
          ]
        },
        "headerMatcher": {
          "headerNames": [
            {
              "value": "string",
              "caseSensitive": "boolean"
            }
          ]
        },
        "cookieMatcher": {
          "cookieNames": [
            {
              "value": "string",
              "caseSensitive": "boolean"
            }
          ]
        },
        "bodyMatcher": {
          "bodyValues": [
            {
              "value": "string",
              "caseSensitive": "boolean"
            }
          ]
        }
      }
    }
  ],
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
|| coreRuleSet | **[CoreRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.CoreRuleSet)**

Core rule set settings. See [Basic rule set](/docs/smartwebsecurity/concepts/waf#rules-set) for details.

Includes only one of the fields `coreRuleSet`. ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

Name of the WAF profile. The name is unique within the folder. 1-50 characters long.

The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `. ||
|| description | **string**

Optional description of the WAF profile. ||
|| labels | **object** (map<**string**, **string**>)

Labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| rules[] | **[WafProfileRule](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileRule)**

Settings for each rule in rule set. ||
|| exclusionRules[] | **[WafProfileExclusionRule](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule)**

List of exclusion rules. See [Rules](/docs/smartwebsecurity/concepts/waf#exclusion-rules). ||
|| analyzeRequestBody | **[AnalyzeRequestBody](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.AnalyzeRequestBody)**

Parameters for request body analyzer. ||
|| ruleSets[] | **[WafProfileRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet)**

List of rule sets. See [Rules](/docs/smartwebsecurity/concepts/waf#rules-set). ||
|| matchAllRuleSets | **boolean**

Parameter determines should all rule sets be matched. ||
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
|| requestCondition | **[RequestCondition](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition)**

Additional condition applied to specific parts of the request to refine when the exclusion is triggered. ||
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
|| cookies[] | **[CookieMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.CookieMatcher)**

Match cookies.

The maximum number of elements is 20. ||
|| botCategory | **[BotCategoryMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.BotCategoryMatcher)**

Match bot category. ||
|| botName | **[BotNameMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.BotNameMatcher)**

Match bot name. ||
|| botScore | **[BotScoreMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.BotScoreMatcher)**

Match bot score. ||
|| verifiedBot | **[VerifiedBotMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.VerifiedBotMatcher)**

Match verified bot. ||
|| fingerPrint | **[FingerPrintMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.FingerPrintMatcher)**

Match fingerprint. ||
|#

## AuthorityMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.AuthorityMatcher}

AuthorityMatcher object.

#|
||Field | Description ||
|| authorities[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

List of authorities. OR semantics implied.

The maximum number of elements is 20. ||
|| authorityMatcher | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

Authority matcher. ||
|#

## StringMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher}

StringMatcher object.

#|
||Field | Description ||
|| exactMatch | **string**

Exact match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|| exactNotMatch | **string**

Exact not match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|| prefixMatch | **string**

Prefix match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|| prefixNotMatch | **string**

Prefix not match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|| pireRegexMatch | **string**

PIRE regex match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|| pireRegexNotMatch | **string**

PIRE regex not match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|| defined | **boolean**

Matches if the field is defined.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|| listsMatchers | **[ListsMatchers](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatchers)**

Matches against string and regular expression lists.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|#

## ListsMatchers {#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatchers}

ListsMatchers object.

#|
||Field | Description ||
|| strListsMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

String lists to match with. ||
|| strListsNotMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

String lists to not match with. ||
|| regExpListsMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

Regular expression lists to match with. ||
|| regExpListsNotMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

Regular expression lists to not match with. ||
|#

## ListsMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher}

ListsMatcher object.

#|
||Field | Description ||
|| listIds[] | **string**

List of list IDs to match against. OR semantics implied.

The number of elements must be in the range 1-10. ||
|#

## HttpMethodMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.HttpMethodMatcher}

HttpMethodMatcher object.

#|
||Field | Description ||
|| httpMethods[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

List of HTTP methods. OR semantics implied.

The maximum number of elements is 20. ||
|| httpMethodMatcher | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

HTTP method matcher. ||
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
|| ipRangesMatch | **[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher)**

IP ranges to match with. ||
|| ipRangesNotMatch | **[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher)**

IP ranges to not match with. ||
|| geoIpMatch | **[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher)**

Geo locations to match with. ||
|| geoIpNotMatch | **[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher)**

Geo locations to not match with. ||
|| ipListsMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

IP lists to match with. ||
|| ipListsNotMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

IP lists to not match with. ||
|| asnRangesMatch | **[AsnRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.AsnRangesMatcher)**

ASN ranges to match with. ||
|| asnRangesNotMatch | **[AsnRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.AsnRangesMatcher)**

ASN ranges to not match with. ||
|| asnListsMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

ASN lists to match with. ||
|| asnListsNotMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

ASN lists to not match with. ||
|#

## IpRangesMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher}

IpRangesMatcher object.

#|
||Field | Description ||
|| ipRanges[] | **string**

List of IP ranges. OR semantics implied.

The string length in characters for each value must be greater than 0. The maximum number of elements is 10000. ||
|#

## GeoIpMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher}

GeoIpMatcher object.

#|
||Field | Description ||
|| locations[] | **string**

ISO 3166-1 alpha 2. OR semantics implied.

The minimum number of elements is 1. ||
|#

## AsnRangesMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.AsnRangesMatcher}

AsnRangesMatcher object.

#|
||Field | Description ||
|| asnRanges[] | **string** (int64)

List of ASN values to match against. OR semantics implied.

The maximum number of elements is 10000. Acceptable values are 0 to 4294967295, inclusive. ||
|#

## CookieMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.CookieMatcher}

CookieMatcher object.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the cookie parametr.

The string length in characters must be 1-255. ||
|| value | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

Required field. Value of the cookie parametr. ||
|#

## BotCategoryMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.BotCategoryMatcher}

BotCategoryMatcher object. AND semantics implied.

#|
||Field | Description ||
|| botCategoryListsMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

Bot category lists to match with. ||
|| botCategoryListsNotMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

Bot category lists to not match with. ||
|#

## BotNameMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.BotNameMatcher}

BotNameMatcher object. AND semantics implied.

#|
||Field | Description ||
|| botNameListsMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

Bot name lists to match with. ||
|| botNameListsNotMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

Bot name lists to not match with. ||
|#

## BotScoreMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.BotScoreMatcher}

BotScoreMatcher object.

#|
||Field | Description ||
|| value[] | **[IntMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IntMatcher)**

List of integer matchers for bot score. OR semantics implied.

The maximum number of elements is 4. ||
|#

## IntMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IntMatcher}

IntMatcher object.

#|
||Field | Description ||
|| leMatch | **[IntLEMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IntLEMatcher)**

Less than or equal condition.

Includes only one of the fields `leMatch`, `geMatch`, `eqMatch`, `neMatch`. ||
|| geMatch | **[IntGEMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IntGEMatcher)**

Greater than or equal condition.

Includes only one of the fields `leMatch`, `geMatch`, `eqMatch`, `neMatch`. ||
|| eqMatch | **[IntEQMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IntEQMatcher)**

Equal condition.

Includes only one of the fields `leMatch`, `geMatch`, `eqMatch`, `neMatch`. ||
|| neMatch | **[IntNEMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IntNEMatcher)**

Not equal condition.

Includes only one of the fields `leMatch`, `geMatch`, `eqMatch`, `neMatch`. ||
|#

## IntLEMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IntLEMatcher}

IntLEMatcher object.

#|
||Field | Description ||
|| value | **string** (int64)

Upper bound value (inclusive). ||
|#

## IntGEMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IntGEMatcher}

IntGEMatcher object.

#|
||Field | Description ||
|| value | **string** (int64)

Lower bound value (inclusive). ||
|#

## IntEQMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IntEQMatcher}

IntEQMatcher object.

#|
||Field | Description ||
|| value | **string** (int64)

Value to match against. ||
|#

## IntNEMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IntNEMatcher}

IntNEMatcher object.

#|
||Field | Description ||
|| value | **string** (int64)

Value to not match against. ||
|#

## VerifiedBotMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.VerifiedBotMatcher}

VerifiedBotMatcher object.

#|
||Field | Description ||
|| verified | **[BoolMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.BoolMatcher)**

Matches if the bot is verified or not. ||
|#

## BoolMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.BoolMatcher}

BoolMatcher object.

#|
||Field | Description ||
|| match | **boolean**

Boolean value to match against. ||
|#

## FingerPrintMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.FingerPrintMatcher}

FingerPrintMatcher object.

#|
||Field | Description ||
|| ja3Ranges[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

List of JA3 fingerprint matchers. OR semantics implied.

The maximum number of elements is 20. ||
|| ja4Ranges[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

List of JA4 fingerprint matchers. OR semantics implied.

The maximum number of elements is 20. ||
|| ja3Matcher | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

JA3 fingerprint matcher. ||
|| ja4Matcher | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

JA4 fingerprint matcher. ||
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

## RequestCondition {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition}

#|
||Field | Description ||
|| paramMatcher | **[RequestParamMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.RequestParamMatcher)**

Matcher for request query parameters. ||
|| headerMatcher | **[HeaderMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.HeaderMatcher)**

Matcher for request headers. ||
|| cookieMatcher | **[CookieMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.CookieMatcher)**

Matcher for request cookies. ||
|| bodyMatcher | **[BodyMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.BodyMatcher)**

Matcher for request body. ||
|#

## RequestParamMatcher {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.RequestParamMatcher}

#|
||Field | Description ||
|| paramNames[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**

List of request query parameter names to match. Up to 20 entries.

The maximum number of elements is 20. ||
|#

## StringMatcher {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher}

#|
||Field | Description ||
|| value | **string**

String value to match against. ||
|| caseSensitive | **boolean**

Whether the match is case sensitive. ||
|#

## HeaderMatcher {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.HeaderMatcher}

#|
||Field | Description ||
|| headerNames[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**

List of request header names to match. Up to 20 entries.

The maximum number of elements is 20. ||
|#

## CookieMatcher {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.CookieMatcher}

#|
||Field | Description ||
|| cookieNames[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**

List of cookie names to match. Up to 20 entries.

The maximum number of elements is 20. ||
|#

## BodyMatcher {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.BodyMatcher}

#|
||Field | Description ||
|| bodyValues[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**

List of request body values to match. Up to 20 entries.

The maximum number of elements is 20. ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| metadata | **object**

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
|| response | **object**

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