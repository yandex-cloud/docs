---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Pcre UDF

Pcre UDF is currently an alias to [HyperScan UDF](hyperscan.md).

If you depend on some features of a certain regular expression engine, it's better to internally implement UDF with a given library inside. Use Pcre UDF as the current most-recommended option for simple matching (but it can change in the future).

Currently available engines:

* [HyperScan UDF](hyperscan.md) (Intel).
* [Re2 UDF](re2.md) (Google).
* [Pire UDF](pire.md) (Yandex).

HyperScan and Pire are mainly optimized for Grep and Match. Inside Hyperscan, there are several implementations that use different sets of processor instructions, with the needed instruction automatically selected based on the current processor. Pire is also known for its excellent performance. So, if you need high performance, test-run this library against your data and regular expressions. However, since the library almost hasn't been developed since 2011-2013 and its name says "Perl incompatible", you may need to adapt your regular expressions a bit.

The main benefit of the Re2 is its advanced Capture and Replace functionality. Use this library, if you need those functions.

In HyperScan UDF, some functions support backtracking (referencing the previously found part of the string). Those functions are implemented through hybrid use of the two libraries: HyperScan and libpcre.

