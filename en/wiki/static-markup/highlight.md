# Syntax highlighting in code

You can format source code with syntax highlighting on {{wiki-name}} pages. To do this, use the following markup:

```
%%(<language label> nomark nohighlight)
software code
%%
```

| Parameter | Description |
| ----- | ----- |
| Language label | [Programming language](#formatters-name) for syntax highlighting |
| `nomark` | Optional parameter, disables line numbering |
| `nohighlight` | Optional parameter, disables line numbering and syntax highlighting |


By default, to display code with syntax highlighting in {{wiki-name}}, the font set in the browser as <q>monospaced</q> is used. You can change this font in your browser settings.

## Supported programming languages {#formatters-name}

{% cut "List of the supported programming languages" %}

| Programming language | Label |
| ----- | ----- |
| 1C | 1c, 1c |
| ActionScript | actionscript |
| Apache | apache |
| Applescript | applescript |
| Bash | bash, sh |
| C# | c#, csharp, c-sharp |
| C++ | c, cpp, c++ |
| Closure | closure |
| CMake | cmake |
| Coffeescript | coffeescript |
| CSP | csp |
| Css | css |
| D | d |
| Delphi | delphi |
| Diff | diff |
| DOS | .bat bat, dos |
| Django | django |
| Dockerfile | dockerfile |
| Erlang | erlang |
| Erlang-repl | erlang-repl |
| Go | go |
| Haskell | haskell |
| HTTP | http |
| Ini | ini |
| json | json |
| Java | java |
| Javascript | js, javascript |
| Lisp | lisp |
| Matlab | matlab |
| Nginx | nginx |
| ObjectiveC | objc, objectivec, obj-c, objective-c |
| PHP | php |
| Perl | perl |
| Python | py, python |
| Python | profile profile, profiler, python-profile, python-profiler |
| R | r |
| Ruby | ruby |
| Rust | rust |
| Scala | scala |
| Smalltalk | smalltalk |
| SQL | mysql, sql |
| Swift | swift |
| TeX | tex |
| VBScript | vbscript |
| XML | xml |
| YAML | yaml, yml |
| YQL | yql |

{% endcut %}

## Sample source code formatting {#examples}

#### Standard formatting {#examples-standart}

```
%%(php)
<?
phpinfo();
$s = "Hello, World!\n";
print $s;
%% 
```

{% cut "See the result" %}

![](../../_assets/wiki/formatter-example.png)

{% endcut %}

#### Without line numbering {#examples-without-line-numbering}

   ```
   %%(python nomark)
   @requires_authorization
   def somefunc(param1, param2):
       r'''A docstring'''
       if param1 > param2: # interesting
          print 'Gre\'ater'
          print ''
       return (param2 - param1 + 1) or None

   class SomeClass:
     pass
   %%
   ```

   {% cut "See the result" %}

   ![](../../_assets/wiki/formatter-example-nomark.png)

   {% endcut %}

#### Without syntax highlighting {#examples-without-highlighting}

   ```
    %%(code nohighlight)
   @requires_authorization
   def somefunc(param1, param2):
       r'''A docstring'''
       if param1 > param2: # interesting
           print 'Gre\'ater'
           print ''
       return (param2 - param1 + 1) or None

   class SomeClass:
     pass
   %%
   ```

   {% cut "See the result" %}

   ![](../../_assets/wiki/formatter-example-nohighlight.png)

   {% endcut %}

#### One-line code {#examples-one-string}

  Software code written in one line, remains one-line after formatting.

   ```
   %%(css)body {display: none;}%%
   ```

   {% cut "See the result" %}

   ![](../../_assets/wiki/formatter-example-string.png)

   {% endcut %}


