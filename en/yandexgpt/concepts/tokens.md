# Tokens

Neural networks work with texts by representing words and sentences as _tokens_, i.e., pieces of meaning or frequent sets of characters that are typical of a natural language. Tokens help neural networks detect patterns and process the natural language.

{{ yagpt-name }} uses its own tokenizer for text processing. You can estimate the size of a text field in tokens using the [`Tokenizer.tokenize`](../api-ref/Tokenizer/tokenize.md) REST API method.