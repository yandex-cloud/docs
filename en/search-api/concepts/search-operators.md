# Search query language and search operators

When searching, Yandex only considers the meaningful words in the query, ignoring _stop words_, such as prepositions, conjunctions, and pronouns, that do not change the meaning of the key phrase. For example, in the phrase "how and when to travel to Mars", only "travel" and "Mars" are indexed. However, if stop words affect the meaning of the phrase, as in "it’s out of friendship", Yandex automatically detects them and includes them in the search phrase. Search results will contain the entire phrase, rather than individual occurrences of "friendship". In statistics, such matches count as word-by-word matches because all words from the phrase are used.

Search results are also affected by _negative phrases_, i.e., words or phrases that, when used in a query, exclude a match from the search results. They are used to filter out irrelevant traffic. If a negative phrase contains stop words, the system automatically detects them.

Along with stop words and negative phrases, you can use _search operators_, i.e., special symbols that affect the meaning of a search phrase. The table below lists all operators and provides examples of key phrases and search results obtained when using these operators.


| **Operator** | **Description** | **Key phrase example** | **Results to show** |
|---|---|---|---|
| `-` | Excludes words from the query. | `delivery -flower` | ![ok](../../_assets/common/yes.svg) food delivery</br>![ok](../../_assets/common/yes.svg) home delivery</br>![no](../../_assets/common/no.svg) flower delivery |
| `!` | Keeps the grammatical form of the word (number, case, and tense). | `buy a !dog` | ![ok](../../_assets/common/yes.svg) buy a dog</br>![no](../../_assets/common/no.svg) buy food for dogs</br>![no](../../_assets/common/no.svg) buy dogs |
| `+` | Includes stop words (any words that do not add semantic meaning). | `work +from home` | ![ok](../../_assets/common/yes.svg) work from home</br>![no](../../_assets/common/no.svg) home work</br>![no](../../_assets/common/no.svg) work at home |
| `" "` | Keeps the word count and returns matches with no extra words. | `"purchase a car"` | ![ok](../../_assets/common/yes.svg) purchase a car</br>![ok](../../_assets/common/yes.svg) a car purchase</br>![no](../../_assets/common/no.svg) purchase a red car |
| `[]` | Forces a particular word order with the given word forms and stop words. | `tickets [from moscow to paris]` | ![ok](../../_assets/common/yes.svg) tickets from moscow to paris</br>![ok](../../_assets/common/yes.svg) plane tickets from moscow to paris</br>![no](../../_assets/common/no.svg) tickets from paris to moscow</br>![no](../../_assets/common/no.svg) moscow paris tickets</br>![no](../../_assets/common/no.svg) moscow to paris cheap tickets |
| `()` and ```\|``` | Group words in complex queries. | ```order (sushi rolls\|pizza)``` | ![ok](../../_assets/common/yes.svg) order sushi rolls</br>![ok](../../_assets/common/yes.svg) order pizza |

[{{ wordstat-name }}](./wordstat.md) supports all operators in the `GetRegionsDistribution` and `GetTop` methods. The `GetDynamics` method supports all operators for daily breakdowns, while for weekly and monthly breakdowns, it only supports `+`.
