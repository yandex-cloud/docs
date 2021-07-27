---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Unicode UDF

Functions for Unicode strings:

**List of functions**

* ```Unicode::IsUtf(String) -> Bool```

   Checks whether a string is a valid utf-8 sequence. For example, the string ```"\xF0"``` isn't a valid utf-8 sequence, while the string ```"\xF0\x9F\x90\xB1"``` correctly describes a utf-8 cat emoji.

* ```Unicode::GetLength(Utf8{Flags:AutoMap}) -> Uint64```

   Returns the length of a utf-8 string in unicode code points. Surrogate pairs are counted as one character.

* ```Unicode::Substring(Utf8{Flags:AutoMap}, from:Uint64?, len:Uint64?) -> Utf8```

   Returns a substring starting with ```from``` that is ```len``` characters long. If the ```len``` argument is omitted, the substring is taken to the end of the source string.

* ```Unicode::Normalize(Utf8{Flags:AutoMap}) -> Utf8```

* ```Unicode::NormalizeNFD(Utf8{Flags:AutoMap}) -> Utf8```

* ```Unicode::NormalizeNFC(Utf8{Flags:AutoMap}) -> Utf8```

* ```Unicode::NormalizeNFKD(Utf8{Flags:AutoMap}) -> Utf8```

* ```Unicode::NormalizeNFKC(Utf8{Flags:AutoMap}) -> Utf8```

   The above functions convert the passed utf-8 string to one of [normalization forms](https://unicode.org/reports/tr15/#Norm_Forms).

* ```Unicode::Translit(Utf8{Flags:AutoMap}, [String?]) -> Utf8```

   Transliterates with Latin letters the words from the passed string, consisting entirely of characters of the alphabet of the language passed by the second argument. If no language is specified, the words are transliterated from Russian. Available languages: "kaz", "rus", "tur", and "ukr".

* ```Unicode::LevensteinDistance(Utf8{Flags:AutoMap}, Utf8{Flags:AutoMap}) -> Uint64```

   Calculates the Levenshtein distance for the passed strings.

* ```Unicode::Fold(Utf8{Flags:AutoMap}, [Language:String?, DoLowerCase:Bool?]) -> Utf8```

   Performs [case folding](https://www.w3.org/TR/charmod-norm/#definitionCaseFolding) on the passed string. ```The Language``` is set according to the same rules as in ```Unicode::Translit()```. ```DoLowerCase``` converts a string to lowercase letters, defaults to ```true```.

* ```Unicode::ReplaceAll(Utf8{Flags:AutoMap}, Utf8, Utf8) -> Utf8```

   Arguments: ```input```, ```find```, and ```replacement```. Replaces all occurrences of the ```find``` string in the ```input``` with ```replacement```.

* ```Unicode::ReplaceFirst(Utf8{Flags:AutoMap}, Utf8, Utf8) -> Utf8 -- arguments: input, find, replacement```

   Arguments: ```input```, ```findSymbol```, and ```replacementSymbol```. Replaces the first occurrence of the ```findSymbol``` character in the  ```input``` with ```replacementSymbol```. The character can't be a surrogate pair.

* ```Unicode::ReplaceLast(Utf8{Flags:AutoMap}, Utf8, Utf8) -> Utf8 -- arguments: input, find, replacement```

   Arguments: ```input```, ```findSymbol```, and ```replacementSymbol```. Replaces the last occurrence of the ```findSymbol``` character in the ```input``` with ```replacementSymbol```. The character can't be a surrogate pair.

* ```Unicode::RemoveAll(Utf8{Flags:AutoMap}, Utf8) -> Utf8```

   The second argument is interpreted as an unordered set of characters to be removed. Removes all occurrences.

* ```Unicode::RemoveFirst(Utf8{Flags:AutoMap}, Utf8) -> Utf8```

   The second argument is interpreted as an unordered set of characters to be removed. Removes the first occurrence.

* ```Unicode::RemoveLast(Utf8{Flags:AutoMap}, Utf8) -> Utf8```

   The second argument is interpreted as an unordered set of characters to be removed. Removes the last occurrence.

* ```Unicode::Reverse(Utf8{Flags:AutoMap})```

   Reverses the passed string.

**Examples**

```sql
SELECT Unicode::Fold("Eylül", "tur" AS Language); -- "eylul"
SELECT Unicode::GetLength("жніўня");              -- 6
```

