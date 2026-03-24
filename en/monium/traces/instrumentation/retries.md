# Retries

Each retry attempt is recorded as an individual child span. This means a trace will show how many attempts were taken, which of them failed with an error, and which one was successful.

## Markup pattern {#pattern}

The parent span covers the entire operation. Each attempt is a separate child span with the same name. Unsuccessful attempts get the `ERROR` status, and successful ones, `OK`. The `http.resend_count` attribute indicates the sequence number of the retry, starting with `1` for the first retry.

## Attributes {#attributes}

#|
|| Attribute | Description ||
|| `http.resend_count` | Sequence number of the retry attempt. The initial request has no sequence number; `1` is for the first retry, `2` for the second one, etc. ||
|#

Populate request attributes (HTTP, RPC, etc.) in alignment with the conventions for each operation type; see [{#T}](http.md), [{#T}](rpc.md).

## Example {#example}

`payment-service` processes the payment and requests the exchange rate from an external service. The initial request fails, but the second attempt succeeds:

#|
|| Attribute | `process_payment` | `GET` (attempt 1) | `GET` (attempt 2) ||
|| Kind | `SERVER` | `CLIENT` | `CLIENT` ||
|| Status | `OK` | `ERROR` | `OK` ||
|| `http.resend_count` | — | — | `1` ||
|#
