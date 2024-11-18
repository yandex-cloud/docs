---
title: '{{ er-full-name }} rule'
description: The {{ er-name }} rule is a routing component consisting of a filter and targets.
keywords:
  - eventrouter
  - event router
  - bus
  - target
  - output
  - rule
  - filter
  - target
---

# Rule

_Rule_ is a routing component that consists of a filter and one to five [targets](#target). A [bus](bus.md) may have a number of rules associated with it. Each event entering a bus is filtered using all the bus rules. Before a rule is triggered, the event is checked against the conditions specified in the [filter](#filter). If the conditions are met, the rule is triggered and the event is forwarded to all the targets specified in the rule.

## Filter {#filter}

_Filter_ is an expression in [jq format](https://jqlang.github.io/jq/) that figures out whether an event should be forwarded to the targets specified in the rule. If the filter is empty, the rule is considered triggered and events are forwarded to all targets. If the event cannot be parsed or its body does not satisfy the conditions specified in the filter, the rule is not triggered. Events in formats other than JSON can be processed, but filter checking is not available for them.

## Target {#target}

_Target_ is the consumer of an event, e.g., a {{ sf-name }} function, a {{ serverless-containers-name }} container, a {{ message-queue-name }} queue, a {{ yds-name }} data stream, etc.

{{ er-name }} supports the `At least once` delivery guarantee. If unable either to deliver an event or get a delivery confirmation, {{ er-name }} will be retrying to send the event before the event lifetime expires. The number of retries and the maximum event lifetime are set in the target settings. An event that could not be processed is moved to the dead-letter queue specified by the client.

For optimization purposes, {{ er-name }} allows you to specify event grouping settings for some types of targets. In a target, a jq pattern may be set, to transform events based on it before forwarding them to the target.
