# CvxOpt Homework #2

| 姓名   | 学号       |
| ------ | ---------- |
| 杨思远 | 3120210063 |

> ![image-20220501142953531](/Users/xirhxq/Documents/BIT/2022_Spring_Summer/凸优化/CvxOpt Homework #2.assets/image-20220501142953531.png)

(a)

Let the feasible set of Boolean LP and its LP relaxation be $F_{blp}$ and $F_{lp}$, formally
$$
F_{blp} = \{x|Ax \preceq b, x_i\in \{0, 1\}, i = 1,\dots,n\}\\
F_{lp} = \{x|Ax \preceq b, 0\le x_i \le 1, i = 1,\dots, n\}.
$$
Obviously, $F_{blp}\subset F_{lp}$, so the optimal value of the LP relxation (4.68) is a lower bound on the optimal value of the Bollean LP (4.67).

In addition, if the LP relaxation is infeasible, i.e., $F_{lp} = \emptyset$, then the Boolean LP is infeasible as well, i.e., $F_{blp} = \emptyset$.

(b)

In such case, the optimal value of the LP relaxation is also the optimal value of the Boolean LP.

> ![image-20220501143009240](/Users/xirhxq/Documents/BIT/2022_Spring_Summer/凸优化/CvxOpt Homework #2.assets/image-20220501143009240.png)

(a)

The feasible set is
$$
F = \{x | (x-2)(x-4) \le 0\} = \{x| 2 \le x \le 4\} = [2,4].
$$
The optimal value is $p^* = 5$, meanwhile the optimal solution is $x^* = 2$.

(b)

With Mathematica code (in Appendix A.1) we can get the plot as follows:

<img src="/Users/xirhxq/Documents/BIT/2022_Spring_Summer/凸优化/CvxOpt Homework #2.assets/image-20220501215112134.png" alt="image-20220501215112134" style="zoom:50%;" />

The Lagrangian is
$$
L(x,\lambda) = f_0(x) +\sum_{i= 1}^m\lambda_if_i(x) + \sum_{i = 1}^p\nu_ih_i(x)
\\
=x^2 + 1+\lambda (x-2)(x-4)
\\
=(1+\lambda)x^2-6\lambda x+1+8\lambda.
$$
Setting $\lambda$ as a few values we can get the following plot (code in Appendix A.2)

![image-20220503132913839](/Users/xirhxq/Documents/BIT/2022_Spring_Summer/凸优化/CvxOpt Homework #2.assets/image-20220503132913839.png)

We can see that the minimum value of $L(x,\lambda)$ is always less than $p^*$. The mininum value reaches its maximum value at $\lambda^* = 2$, when $p^* = g(\lambda)$, where $g(\lambda) = \inf_{x\in \mathcal D} L(x,\lambda)$.

For $\lambda>-1$, the Lagrangian is minimal at $x^* =\frac{3\lambda}{1+\lambda}$, for $\lambda\le -1$ there is no minimum value. Hence we get
$$
g(\lambda) = \begin{cases}
-\frac{9\lambda^2}{1+\lambda} + 1+8\lambda & \lambda >-1\\
-\infty & \lambda\le-1,
\end{cases}
$$
which is plotted below (code in Appendix A.3).

<img src="/Users/xirhxq/Documents/BIT/2022_Spring_Summer/凸优化/CvxOpt Homework #2.assets/image-20220501223302041.png" alt="image-20220501223302041" style="zoom:50%;" />

The dual function is concave, and its optimal value is $p^*=5$ for $\lambda=2$, while less than $p^*$ at any other value of $\lambda$.

(c)

The Lagrange dual problem is
$$
\begin{matrix}
{\rm maximize} &
-9\lambda^2 / (1+\lambda) + 1+8\lambda\\
{\rm subject\ to} &
\lambda \ge 0.
\end{matrix}
$$
The dual reaches its optimum $d^* = 5$ at $\lambda=2$, hence strong duality holds.

(d)

The feasible set is notempty when $u \ge 1$, and is the interval $[3-\sqrt{1+u}, 3+\sqrt{1+u}]$. So when the interval contains the unconstrained optimal point $x^* = 0$, i.e., $u\ge 8$, the optimum is as so; otherwise, the optimum is $x^*(u) = 3-\sqrt{1+u}$. Formally,
$$
p^*(u) = \begin{cases}
\infty & u < -1\\
11 + u - 6\sqrt{1+u} & -1\le u \le 8\\
1 & u \ge 8.
\end{cases}
$$
With code in Appendix A.4 we can plot the function as

![image-20220504171609629](/Users/xirhxq/Documents/BIT/2022_Spring_Summer/凸优化/CvxOpt Homework #2.assets/image-20220504171609629.png)

The derivative of $p^*(u)$ at $u=0$ is
$$
\frac{{\rm d}p^*(0)}{{\rm d}u} = 1-\frac{3}{\sqrt{1+u}}\Bigg|_{u=0} = -2=-\lambda^*.
$$

> ![image-20220501143023472](/Users/xirhxq/Documents/BIT/2022_Spring_Summer/凸优化/CvxOpt Homework #2.assets/image-20220501143023472.png)

The Lagranian is
$$
L(x,\lambda,\nu) = c^T x+ \lambda^T (Gx-h) + \nu^T(Ax-b)\\
=(C^T+\lambda^TG+\nu^TA)x-(\lambda^Th+\nu^Tb),
$$
which clearly a affine function of x. Hence the dual function is
$$
g(\lambda,\nu) = \inf_{x\in \mathcal D} L(x,\lambda,\nu) = \begin{cases}
-\lambda^Th-\nu^Tb & c^T + \lambda^TG+\nu^TA = 0\\
-\infty & \text{otherwise.}
\end{cases}
$$
The dual problem
$$
\begin{matrix}
\text{maximize} & g(\lambda,\nu)\\
\text{subject to} & \lambda \succeq 0
\end{matrix}
$$
can be stated as
$$
\begin{matrix}
\text{maximize} & -\lambda^T h - \nu^T b\\
\text{subject to} & c^T + \lambda^T G + \nu^T A =0\\
& \lambda \succeq 0.
\end{matrix}
$$

> ![image-20220501143041886](/Users/xirhxq/Documents/BIT/2022_Spring_Summer/凸优化/CvxOpt Homework #2.assets/image-20220501143041886.png)
>
> ![image-20220501143054910](/Users/xirhxq/Documents/BIT/2022_Spring_Summer/凸优化/CvxOpt Homework #2.assets/image-20220501143054910.png)

(a)

The Lagrangian is
$$
L(x,\mu,\nu) = c^T x + \mu^T (Ax - b) - \nu ^ T x + x^T {\bf diag}(\nu)x\\
= x^T {\bf diag} (\nu) x + (c^T+\mu^T A - \nu^T)x - \mu ^T b,
$$
which minimum value can be given by
$$
g(\mu,\nu)=\begin{cases}
-b^T \mu - \sum_{i=1}^n (c_i + a_i^T \mu - \nu_i) / (4\nu_i) & \nu \succeq 0\\
-\infty & {\rm otherwise}
\end{cases}
$$
where $c_i,\nu_i$ represents the $i{\rm th}$ element of $c, \nu$ and $a_i$ is the $i\rm th$ column of $A$.

So the dual problem is
$$
\begin{matrix}
{\rm maximize} & -b^T \mu - \sum_{i = 1}^n (c_i + a_i^T \mu -\nu_i)^2 / (4\nu_i)\\
{\rm subject\ to} & \nu \succeq 0.
\end{matrix}
$$
To simplify, we can observe that
$$
\sup _{\nu _i \ge 0}\left(-\frac{(c_i + a_i^T \mu - \nu_i)^2}{\nu_i} \right)
=
\begin{cases}
(c_i + a_i^T \mu) & c_i + a_i^T \mu \le 0\\
0 & c_i + a_i^T \mu \ge 0
\end{cases}
\\= \min\{ 0, (c_i + a_i^T \mu)\}.
$$
So the dual problem can be simplified as
$$
\begin{matrix}
{\rm maximize} & -b^T \mu + \sum_{i = 1}^n \min\{0, c_i + a_i^T \mu \}\\
{\rm subject\ to} & \mu \succeq 0.
\end{matrix}
$$
(b)

The Lagrangian and dual function of the LP relaxation are
$$
L(x,u,v,w) = c^T x + u^T (Ax- b) - v^T x + w^T (x - {\bf 1})
\\
= (c + A^T - v + w)^T x - b^T u - {\bf 1}^T w
\\
g(u,v,w) = \begin{cases}
-b^T u - {\bf 1}^T w & A^T u - v + w +c = 0\\
-\infty & {\rm otherwise.}
\end{cases}
$$
So the dual problem is
$$
\begin{matrix}
{\rm maximize} & -b^T u - {\bf 1}^T w\\
{\rm subject\ to} & A^T u - v + w + c = 0\\
& u\succeq0,v\succeq0,w\succeq0,
\end{matrix}
$$
which is clearly equivalent to the Lagrange relaxation problem derived before, hence gives the same value as well.

> ![](/Users/xirhxq/Documents/BIT/2022_Spring_Summer/凸优化/CvxOpt Homework #2.assets/image-20220501143109138.png)

The LP can be expressed as
$$
\begin{matrix}
{\rm minimize} & c^T x\\
{\rm subject\ to} & f_i(x) \le b_i,\quad i = 1,\dots,m
\end{matrix}
$$
where $f_i(x)$ is the optimal value of the following LP
$$
\begin{matrix}
{\rm maximize} & x^T a\\
{\rm subject\ to} & C_i a\preceq d_i
\end{matrix}
$$
with variable $a_i$ in each problem. So the dual problem of such LP is
$$
\begin{matrix}
{\rm minimize} & d_i^T z\\
{\rm subject\ to} & C_i^T z - x = 0\\
& z \succeq 0.
\end{matrix}
$$
Altogether we get the equivalent form of the original LP, which is
$$
\begin{matrix} 
{\rm minimize} & c^T x \\
{\rm subject\ to} & d_i^T z_i \le b_i ,\quad i=1,\dots,m \\
& C_i^T z_i = x,\quad i=1,\dots,m \\
& z_i \succeq 0,\quad i=1,\dots,m.
\end{matrix}
$$

> ![image-20220501143125209](/Users/xirhxq/Documents/BIT/2022_Spring_Summer/凸优化/CvxOpt Homework #2.assets/image-20220501143125209.png)

(a)

Using the code in Appendix A.5 we can sketch the feasible set and level sets of the objective.

![image-20220503131255458](/Users/xirhxq/Documents/BIT/2022_Spring_Summer/凸优化/CvxOpt Homework #2.assets/image-20220503131255458.png)

The feasible set only contains one point, hence the optimal point $x^* = (1, 0)$, the optimal value $p^* = 1$.

(b)

The KKT conditions are
$$
(x_1-1)^2 + (x_2-1)^2 \le 1,\quad (x_1-1)^2 + (x_2+1)^2 \le 1,\\
\lambda_1\ge0,\quad \lambda_2\ge0\\
2x_1 + 2\lambda_1 (x_1-1) + 2\lambda_2 (x_1-1) = 0\\
2x_2 + 2\lambda_1 (x_2-1) + 2\lambda_2 (x_2 + 1) = 0\\
\lambda_1((x_1-1)^2 + (x_2-1)^2 - 1) = \lambda_2 ((x_1-1)^2 + (x_2+1)^2 - 1)=0
$$
At $x^* = (1,0)$ the conditions are
$$
\lambda_1\ge 0,\quad \lambda_2 \ge 0, \quad 2=0, \quad -2\lambda_1 + 2\lambda_2= 0
$$
which obviously have no solution.

(c)

The Lagrange dual function is
$$
g(\lambda_1,\lambda_2) = \inf_{x_1,x_2} L(x_1,x_2,\lambda_1,\lambda_2)
$$
where
$$
L(x_1,x_2,\lambda_1,\lambda_2)
= x_1^2 + x_2^2 + \lambda_1((x_1 - 1)^2 + (x_2-1)^2 - 1) + \lambda_2 ((x_1-1)^2 + (x_2+1)^2 - 1)\\
= (1+\lambda_1+\lambda_2) x_1^2 + (1+\lambda_1+\lambda_2)x_2^2 - 2(\lambda_1+\lambda_2)x_1 - 2(\lambda_1-\lambda_2) x_2 + \lambda_1+\lambda_2.
$$
When $x_1 = \frac{\lambda_1+\lambda_2}{1+\lambda_1+\lambda_2}$ and $x_2=\frac{\lambda_1-\lambda_2}{1+\lambda_1+\lambda_2}$,
$$
g(\lambda_1,\lambda_2)=
\begin{cases}
-\frac{(\lambda_1+\lambda_2)^2+(\lambda_1-\lambda_2)^2}{1+\lambda_1+\lambda_2} & 1+\lambda_1+\lambda_2\ge0\\
-\infty & {\rm otherwise.}
\end{cases}
$$
So the dual problem is
$$
\begin{matrix}
{\rm maximize} & \frac{\lambda_1+\lambda_2-(\lambda_1-\lambda_2)^2}{1+\lambda_1+\lambda_2}\\
{\rm subject\ to} & \lambda_1 \ge0, \lambda_2 \ge 0
\end{matrix}
$$
The maximum is reached when $\lambda_1,\lambda_2\to\infty$, and $d^* = p^* = 1$. So the strong duality does not hold.

### Appendix A. Mathematica Codes

##### A.1

```mathematica
func = Plot[{x^2 + 1, (x - 2) (x - 4)}, {x, -1, 5}, 
   PlotLabels -> {ToExpression["f_0", TeXForm], 
     ToExpression["f_1", TeXForm]}];
feas = RegionPlot[(x - 2) (x - 4) <= 0, {x, 1, 5}, {y, -30, 30}, 
   BoundaryStyle -> {LightRed, Dashed}, 
   PlotStyle -> {Directive[Orange, Opacity[0.2]]}];
opti = Graphics[{PointSize[Large], Pink, Point[{2, 5}]}];
text = Graphics[{Text["Optimal", {2, 4}, {Center, Top}], 
    Text["Feasible Set", {3, 25}]}];
line = Graphics[{Dashed, Brown, Line[{{0, 5}, {2, 5}, {2, 0}}]}];
Show[func, feas, opti, text, line]
```

##### A.2

```mathematica
feas = RegionPlot[(x - 2) (x - 4) <= 0, {x, 1, 5}, {y, -30, 30}, 
   BoundaryStyle -> {LightRed, Dashed}, 
   PlotStyle -> {Directive[Orange, Opacity[0.2]]}];
lagr = Plot[
   Evaluate[Table[(1 + l) x^2 - 6 l x + 1 + 8 l, {l, 0, 3}]], {x, -1, 
    5}, PlotRange -> {0, 30}, 
   PlotLegends -> {ToExpression["f_0", TeXForm], 
     ToExpression["f_0+f_1", TeXForm], 
     ToExpression["f_0+2f_1", TeXForm], 
     ToExpression["f_0+3f_1", TeXForm]}];
Show[lagr, feas]
```

##### A.3

```mathematica
func = Plot[-9*l^2/(1 + l) + 1 + 8 l, {l, -2, 4}];
line = Graphics[{Dashed, Brown, Line[{{-1, -10}, {-1, 10}}]}];
opti = Graphics[{PointSize[Large], Pink, Point[{2, 5}]}];
dsline = Graphics[{Dashed, Brown, Line[{{0, 5}, {2, 5}, {2, 0}}]}];
Show[func, line, opti, dsline]
```

##### A.4

```mathematica
f[x_] = If[x >= 8, 1, 11 + x - 6 Sqrt[1 + x]];
func = Plot[{f[x], f[0] + f'[0] x}, {x, -2, 10}, 
   PlotRange -> {-3, 10}, 
   AxesLabel -> {"u", ToExpression["p^*(u)", TeXForm]}, 
   AxesOrigin -> {-2, -2}];
text = Text[ToExpression["p^*(0)-\lambda^*u", TeXForm], {4, 0}];
line = Line[{{0, -10}, {0, 20}}];
Show[func, Graphics[text], Graphics[{Dashed, line}]]
```

##### A.5

```mathematica
func = Graphics[
   Table[{Dashed, Circle[{0, 0}, Sqrt[r]]}, {r, 0.5, 3, 0.5}]];
fea1 = RegionPlot[(x - 1)^2 + (y - 1)^2 <= 1, {x, -2, 2}, {y, -2, 2}, 
   BoundaryStyle -> {LightRed, Dashed}, 
   PlotStyle -> {Directive[Gray, Opacity[0.2]]}, 
   PlotLabels -> ToExpression["f_1(x)\le0", TeXForm]];
fea2 = RegionPlot[(x - 1)^2 + (y + 1)^2 <= 1, {x, -2, 2}, {y, -2, 2}, 
   BoundaryStyle -> {LightRed, Dashed}, 
   PlotStyle -> {Directive[Gray, Opacity[0.2]]}, 
   PlotLabels -> ToExpression["f_2(x)\le0", TeXForm]];
opti = Graphics[{PointSize[Large], Pink, Point[{1, 0}]}];
Show[fea1, func, fea2, opti]
```