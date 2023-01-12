# Formulas

You can insert in {{ wiki-name }} formulas created using [TeX]({{ link-about-tex }}) markup.

- Standard formula design, suitable for inserting a separate line:
   ```
   The first line.
   %%(math outline) formula %%
   The second line.
   ```

   {% cut "See the result" %}

   ![](../../_assets/wiki/outline-formula-examp.png)

   {% endcut %}

- Compact formula design, suitable for inserting in the same line with text:
   ```
   Start of the line %%(math inline) formula %% End of the line
   ```

   {% cut "See the result" %}

   ![](../../_assets/wiki/inline-formula-examp.png)

   {% endcut %}


## Examples of formulas {#examples}

| Markup | Result |
----- | -----
| `1. %%(math inline) X^{a+b}_{i-j} %%` | ![](../../_assets/wiki/TeX/1.png) |
| `2. %%(math inline) f+f'+f''+\cdots+f^{(10)}%%` | ![](../../_assets/wiki/TeX/2.png) |
| `3. %%(math inline) A\ast B\times C\cdot D%%` | ![](../../_assets/wiki/TeX/3.png) |
| `4. %%(math inline) \varphi\approx\varepsilon%%` | ![](../../_assets/wiki/TeX/4.png) |
| `5. %%(math inline) \sqrt{x}+\sqrt[10]{y}\leq \frac{1+\|\vec{z}\|}8%%` | ![](../../_assets/wiki/TeX/5.png) |
| `6. %%(math inline) \frac1{ \displaystyle\bar{\xi} + \displaystyle\frac{3}7 }%%` | ![](../../_assets/wiki/TeX/6.png) |
| `7. %%(math inline) \sqrt[6]{\log_3{h(x)}} + \dot{\rho}%%` | ![](../../_assets/wiki/TeX/7.png) |
| `8. %%(math inline) \lim_{n \to \infty} \sum_{k=1}^n \frac{1}{k}%%` | ![](../../_assets/wiki/TeX/8.png) |
| `9. %%(math inline) \int_a^b f(x)\,dx \ne \iint \cos{z}\,dxdy%%` | ![](../../_assets/wiki/TeX/9.png) |
| `10. %%(math inline) (1+\frac{1}{n}) ^n%%` | ![](../../_assets/wiki/TeX/10.png) |
| `11. %%(math inline) \left( 1+\frac{1}{n}\right) ^n%%` | ![](../../_assets/wiki/TeX/11.png) |
| `12. %%(math inline) \forall \, k\geq0 \quad \exists n \Leftrightarrow y\notin X%%` | ![](../../_assets/wiki/TeX/12.png) |
| `13. %%(math inline) \angle ABC = 90^{\circ} \Longleftarrow AB \perp BC%%` | ![](../../_assets/wiki/TeX/13.png) |
| `14. %%(math inline) \overbrace{\underbrace{a+b+\ldots+z}_{n}+1+2+\ldots+9}^k%%` | ![](../../_assets/wiki/TeX/14.png) |
| `15. %%(math inline) \arctan{x}+\max_{1\le n\le m}{x_n}%%` | ![](../../_assets/wiki/TeX/15.png) |