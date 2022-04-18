# Diagrams and flowcharts

You can use one of the supported text markup languages to add a diagram, a chart, or a graph to your Wiki page.

{% if audience == "internal" %}

{{ wiki-name }} supports [draw.io](https://drawio.yandex-team.ru/) integration. You can create a diagram in a convenient graphics editor and [place it on a page](../actions/drawio.md) using the `iframe` block.

{% endif %}

## Graphviz (DOT) {#graphviz}

[Graphviz]({{ link-about-graphviz }}) is the best option for designing charts and trees.

Markup example:

```
%%(graphviz neato)
 digraph A { 
 a -> b0
 a -> b3
 xb [label="hi",width=.1,style=invis]
 a -> xb [style=invis]
 a -> b1
 {rank=same b0 -> xb -> b1 [style=invis]}
 b0 -> c0
 xc [label="bye",width=.1,style=invis]
 b0 -> xc [style=invis]
 b0 -> c1
 {rank=same c0 -> xc -> c1 [style=invis]}
 b0 -> c2
 }
 %% 
```

{% cut "See the result" %}

![](../../_assets/wiki/graphviz.png)

{% endcut %}

You can customize the appearance of your graphs using optional parameters:

* `dot`, `neato`, `circo`, `twopi`, `fdp` — name of a utility for making graphs. By default, `dot` is used.

* `width` — maximum graph width in pixels.

* `height` — maximum graph height in pixels.

## Blockdiag {#blockdiag}

[Blockdiag](http://blockdiag.com/en/) is used for creating flowcharts.

Markup example:

```
%%(blockdiag)
{
orientation = portrait
   box [shape = "box"];
   roundedbox [shape = "roundedbox"];
   diamond [shape = "diamond"];
   ellipse [shape = "ellipse"];
   box -> roundedbox -> diamond -> ellipse;
}
%%
```

{% cut "See the result" %}

![](../../_assets/wiki/blockdiag.png)

{% endcut %}

You can customize the appearance of your diagrams using optional parameters:

* `width` — maximum flowchart width in pixels.

* `height` — maximum flowchart height in pixels.

## Seqdiag {#seqdiag}

[Seqdiag](http://blockdiag.com/en/seqdiag/) is used for building [sequence diagrams]({{ link-about-diagram }}).

Markup example:

```
%%(seqdiag)
{
   // normal edge and doted edge
   A -> B [label = "normal edge"];
   B --> C [label = "dotted edge"];
 
   B <-- C [label = "return dotted edge"];
   A <- B [label = "return edge"];
 
   // asynchronus edge
   A ->> B [label = "asynchronus edge"];
   B -->> C [label = "asynchronus dotted edge"];
 
   B <<-- C [label = "return asynchronus doted edge"];
   A <<- B [label = "return asynchronus edge"];
 
   // self referenced edge
   A -> A [label = "self reference edge"];
}
%%
```

{% cut "See the result" %}

![](../../_assets/wiki/seqdiag.png)

{% endcut %}

You can customize the appearance of your diagrams using optional parameters:

* `width` — maximum diagram width in pixels.

* `height` — maximum diagram height in pixels.

## PlantUML {#plantuml}

[PlantUML](https://plantuml.com/) is an open source project that supports many notation types and saves you time creating complex diagrams.

Markup example:

```
%%(plantuml)
@startuml
actor Foo1
boundary Foo2
control Foo3
entity Foo4
database Foo5
collections Foo6
queue Foo7
Foo1 -> Foo2 : To boundary
Foo1 -> Foo3 : To control
Foo1 -> Foo4 : To entity
Foo1 -> Foo5 : To database
Foo1 -[#00cc00]> Foo6 : To collections
Foo1 -> Foo7 : To Queue

@enduml
```

{% cut "See the result" %}

![](../../_assets/wiki/plantuml.png)

{% endcut %}

For more information about the PlantUML diagram markup language, see [PlantUML Language Reference Guide]{% if locale == "ru" %}(http://plantuml.com/ru/guide){% else %}(http://plantuml.com/guide){% endif %}.

