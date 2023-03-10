# Cookie

## IAM Cookie format {#cookie-format}

It always starts with `c1` and sequences of characters in the following order:

1. Any character, but for a space.
1. Any number of characters, such as:
   * Latin letters.
   * Numbers.
   * `_` and `-`.
1. 0 to 2 `=` symbols.
1. Any character, but for a space.
1. 86 characters, such as:
   * Latin letters.
   * Numbers.
   * `_` and `-`.
1. 0 to 2 `=` symbols.

Sample IAM Cookie: `c1f9eugktrZqYks_a=7Y-TmpGUnUKHz-3rfjrtoDw3_npWay4-SjJ_ghY7KlouMjJ3Kncrl9PcSLTl0-e8rTxrv3fT3Uls2dPnvK08a7w==`