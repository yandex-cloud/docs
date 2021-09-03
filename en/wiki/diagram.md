# Diagrams and flowcharts

To add a diagram, chart, or graph to a page, you can use one of the supported text markup languages.

## Graphviz (DOT) {#graphviz}

[Graphviz]({{ link-about-graphviz }}) is best suited for styling graphs and trees.

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

![](../_assets/wiki/graphviz.png)

{% endcut %}

You can configure the appearance of your graphs using optional parameters:

- `dot`, `neato`, `circo`, `twopi`, `fdp`: Name of the utility to use
to create graphs. By default, `dot` is used.

- `width`: Maximum graph width in pixels.

- `height`: Maximum graph height in pixels.

## Blockdiag {#blockdiag}

[Blockdiag](http://blockdiag.com/en/) is designed for building flowcharts.

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

![](../_assets/wiki/blockdiag.png)

{% endcut %}

You can configure the appearance of your diagrams using optional parameters:

- `width`: Maximum width of the flowchart in pixels.

- `height`: Maximum height of the flowchart in pixels.

## Seqdiag {#seqdiag}

[Seqdiag](http://blockdiag.com/en/seqdiag/) is designed for building [sequence diagrams]({{ link-about-diagram }}).

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

![](../_assets/wiki/seqdiag.png)

{% endcut %}

You can configure the appearance of your diagrams using optional parameters:

- `width`: Maximum width of the diagram in pixels.

- `height`: Maximum height of the diagram in pixels.

