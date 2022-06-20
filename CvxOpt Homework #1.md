# CvxOpt Homework #1

| 姓名   | 学号       |
| ------ | ---------- |
| 杨思远 | 3120210063 |

> ![image-20220419081605030](/Users/xirhxq/Documents/BIT/2022_Spring_Summer/凸优化/CvxOpt Homework #1.assets/image-20220419081605030.png)

First we proof *a set is convex iff. its intersection with any line is convex*.

$\Rightarrow$ Proof: Let set $C$ is convex, then if the intersection of a line $l$ and $C$, $l\cap C$, only contains one point, then it is obvoiusly convex; otherwise, assume $l \cap C$ has at least two points. Then for any two points $A, B$ in $l\cap C$, because the convexity of $C$, for any $\theta$ with $0\le \theta \le 1$ we have $\theta A + (1-\theta)B\in C$. Also because point $\theta A + (1-\theta) B$ belongs to $l$, so point $\theta A + (1-\theta B) \in l\cap C$. So the intersection of the set and any line is convex. 

$\Leftarrow$ Proof: Let set $C$ satisfies that for any line $l$, $l\cap C$ is convex, then if $C$ contains only one point it is obviously convex; otherwise, assume $C$ has at least two points. Then for any two points $A, B$ in $C$, the intersection of line $AB$ and $C$, let it be $D$, is convex, so for any $\theta$ with $0\le\theta\le1$, we have $\theta A + (1-\theta) B\in D$. Plus we have $D\subseteq C$, so $\theta A + (1-\theta B) \in C$, which indicates the convexity of $C$.

Then we proof *a set is affine iff. its intersection with any line is affine*.

$\Rightarrow$ Proof: Let set $C$ is affine, then if the intersection of a line $l$ and $C$, $l\cap C$, only contains one point, then it is obvoiusly affine; otherwise, assume $l \cap C$ has at least two points. Then for any two points $A, B$ in $l\cap C$, because the affinity of $C$, for any $\theta\in \mathbf R$ we have $\theta A + (1-\theta)B\in C$. Also because point $\theta A + (1-\theta) B$ belongs to $l$, so point $\theta A + (1-\theta B) \in l\cap C$. So the intersection of the set and any line is affine. 

$\Leftarrow$ Proof: Let set $C$ satisfies that for any line $l$, $l\cap C$ is affine, then if $C$ contains only one point it is obviously affine; otherwise, assume $C$ has at least two points. Then for any two points $A, B$ in $C$, the intersection of line $AB$ and $C$, let it be $D$, is affine, so for any $\theta\in \mathbf R$ we have $\theta A + (1-\theta) B\in D$. Plus we have $D\subseteq C$, so $\theta A + (1-\theta B) \in C$, which indicates the affinity of $C$.

> ![image-20220419094218379](/Users/xirhxq/Documents/BIT/2022_Spring_Summer/凸优化/CvxOpt Homework #1.assets/image-20220419094218379.png)

Proof: If $C$ only has one element then it is obviously convex; otherwise assume $C$ has at least two elements. Then for any two elements $x_1, x_2 \in C$ and any $\theta$ with $0\le \theta \le 1$, we proof $\theta x_1 + (1-\theta) x_2 \in C$.

Because $x_1, x_2\in C$ we have
$$
\begin{cases}
x_1^TA x_1 + b^T x_1 + c \le 0
\\
x_2^T A x_2 + b^T x_2 + c \le 0
\end{cases}
$$
then we get
$$
\theta(x_1^TA x_1 + b^T x_1 + c)+
(1-\theta)(x_2^T A x_2 + b^T x_2 + c) \le 0
$$
then
$$
\begin{align}
&\theta(x_1^TA x_1 + b^T x_1 + c)+
(1-\theta)(x_2^T A x_2 + b^T x_2 + c)
\\&-
((\theta x_1 + (1-\theta) x_2)^T A(\theta x_1 + (1-\theta) x_2)+ b^T (\theta x_1 + (1-\theta) x_2) + c)
\\
=& \theta x_1^T A x_1 + (1-\theta) x_2^T A x_2 - (\theta x_1 + (1-\theta) x_2)^T A(\theta x_1 + (1-\theta) x_2)
\\
=& \theta x_1^T A x_1 + (1-\theta) x_2^T A x_2 - \theta^2 x_1^T A x_1 -(1-\theta)\theta x_2^T A x_1 - \theta (1-\theta)x_1^T A x_2 - (1-\theta)^2 x_2^T A x_2
\\
=& \theta(1-\theta) (x_1^T A x_1  + x_2^T A x_2 - x_2^TA x_1 - x_1^T A x_2)
\\
=& \theta (1-\theta) (x_1 - x_2)^T A (x_1-x_2)
\\
\ge& 0
\end{align}
$$
The last step is because the semidefiniteness of $A$, so that $(x_1-x_2)^T A (x_1-x_2) \ge 0$.

So we have
$$
\begin{align}
&((\theta x_1 + (1-\theta) x_2)^T A(\theta x_1 + (1-\theta) x_2)+ b^T (\theta x_1 + (1-\theta) x_2) + c)
\\
\le &\ \theta(x_1^TA x_1 + b^T x_1 + c)+
(1-\theta)(x_2^T A x_2 + b^T x_2 + c)
\\
\le &\ 0 
\end{align}
$$
Which indicates $\theta x_1 + (1-\theta)x_2 \in C$, so $C$ is convex.

> ![image-20220419101404655](/Users/xirhxq/Documents/BIT/2022_Spring_Summer/凸优化/CvxOpt Homework #1.assets/image-20220419101404655.png)

Let $C = \{x\in \mathbf R_+^2|x_1 x_2 \ge 1\}$, then $\mathbf {bd} C = \{x\in \mathbf R_+^2|x_1 x_2 = 1\}$, the for any point $x = (t, \frac1t)$ in $\mathbf{bd} C$, the supporting hyperplane is
$$
\{x\in \mathbf R^2|\frac{x_1}{t^2} + x_2 \ge \frac2t\}
$$
then $C$ can be expressed as
$$
C = \bigcap_{t>0}\{x\in \mathbf R^2|\frac{x_1}{t^2} + x_2 \ge \frac2t\}
$$

> ![image-20220419104944140](/Users/xirhxq/Documents/BIT/2022_Spring_Summer/凸优化/CvxOpt Homework #1.assets/image-20220419104944140.png)

The dual cone can be expressed as
$$
 \{y|Ay\succeq 0\}
$$

> ![image-20220419111941956](/Users/xirhxq/Documents/BIT/2022_Spring_Summer/凸优化/CvxOpt Homework #1.assets/image-20220419111941956.png)

Let the set of all *copositive* matrices be $K$ in $\mathbf S^n$. So $K$ can be expressed as infinite halfspaces defined by
$$
z^T X z = \sum_{i}\sum_j z_iz_jX_{ij}\ge 0,
$$
so $K$ is closed convex cone. $K$ has nonempty interior because it includes $\mathbf S^n_+$. $K$ is pointed because $z^T X z\ge 0$ and $z^T(-X)z\ge 0$ gives $z^T X z= 0$ for all $z\succeq 0$, hence $X = 0$. Hence $K$ is a proper cone.

The dual cone of $K$ is the set of normal vectors of all halfspaces supporting $K$. It can be expressed as
$$
K = \{zz^T | z\succeq 0\}
$$

> ![image-20220419134818888](/Users/xirhxq/Documents/BIT/2022_Spring_Summer/凸优化/CvxOpt Homework #1.assets/image-20220419134818888.png)

a) When is the epigraph of a function a halfspace?

Let the epigraph of $f:\mathbf R^n \to \mathbf R$ be $E = \{s=(x,t)|f(x)\le t\}$. Because $E$ is a halfspace, so $\exist A = (a, a^*)$ and $b$, where $a\in \mathbf R^n$, $a^*\in \mathbf R$, and $b\in \mathbf R$, $s.t.$
$$
\begin{align}
E &= \{s|A^T s \le b\}
\\
&= \{(x,t)|a^Tx + a^*t \le b\}
\\
&= \{(x,t)|a^Tx - b \le -a^* t\}
\end{align}
$$
Because $E$ has the form of epigraph, so the coefficient of $t$ must be positive, $i.e.$, $-a^*> 0$.

So $f(x) = \dfrac{a^T}{-a^*} x + \dfrac{b}{a^*}$, which is a affine function.

b) When is the epigraph of a function a convex cone?

Let the epigraph of $f:\mathbf R^n \to \mathbf R$ be $E = \{s=(x,t)|f(x)\le t\}$. By definition for any $x\in \mathbf R^n$ and any $\alpha \in \mathbf R^+$, $(x, f(x)) \in E$ and $(\alpha x, f(\alpha x))\in E$. Then because $E$ is a cone, $(\alpha x, \alpha f(x))\in E$ and $(\dfrac1\alpha(\alpha x), \dfrac1\alpha f(\alpha x)) \in E$, which indicates
$$
\begin{cases}
f(\alpha x) \le \alpha f(x)\\
f(\dfrac1\alpha (\alpha x)) \le \dfrac1\alpha f(\alpha x)
\end{cases}
$$
which is $f(\alpha x) \le \alpha f(x)$ and $f(\alpha x) \ge \alpha f(x)$. So $f(\alpha x) = \alpha f(x)$. In addition, because the epigraph $E$ of $f(x)$ is convex, $f(x)$ is convex function.

So, $f(x)$ is a convex function which holds the property of positively homogeneous, $i.e.$, for any $x\in \mathbf R^n$ and $\alpha \in \mathbf R^+$, $f(\alpha x) = \alpha f(x)$.

c) When is the epigraph of a function a polyhedron?

Let the epigraph of $f:\mathbf R^n \to \mathbf R$ be $E = \{s=(x,t)|f(x)\le t\}$. Because $E$ is a polyhedron, so $\exist A_j = (a_j, a_j^*)$ and $b_j (j = 1,\dots, m)$, where $a_j \in \mathbf R^n$, $a_j^*\in \mathbf R$, and $b\in \mathbf R$, $s.t.$
$$
\begin{align}
E &= \{s|A_j^T s \le b_j, j = 1,\dots, m\}\\
&= \{(x,t) | a_j^T x + a_j^*t \le b_j, j = 1,\dots, m\}\\
&= \{ (x,t)| a_j^T x - b_j \le -a_j^*t, j = 1,\dots, m\}
\end{align}
$$
Because $E$ has the form of epigraph, so the coefficient of $t$ must be positive, $i.e.$, $-a_j^*> 0$ for $j = 1,\dots,m$. So
$$
\begin{align}
E &= \{(x,t) | \dfrac{a_j^T}{-a_j^*} x + \dfrac{b_j}{a_j^*}\le t , j = 1,\dots,m\}\\
&= \{(x,t)| \max_{j = 1,\dots, m} \left(\frac{a_j^T}{-a_j^*} x + \frac{b_j}{a_j^*} \right) \le t\}
\end{align}
$$
So $f(x) = \max_{j = 1,\dots, m} \left(\frac{a_j^T}{-a_j^*} x + \frac{-b_j}{-a_j^*} \right)$, which is a piecewise affine function.

> ![image-20220419134907525](/Users/xirhxq/Documents/BIT/2022_Spring_Summer/凸优化/CvxOpt Homework #1.assets/image-20220419134907525.png)
>
> Using the conclusion of:
>
> ![image-20220419134921718](/Users/xirhxq/Documents/BIT/2022_Spring_Summer/凸优化/CvxOpt Homework #1.assets/image-20220419134921718.png)

a) $f(x)$ is a composition of a norm and an affine function, hence convex;

b) $f(x)$ is a composition of a convex function in 3.18 b) and an affine transformation, hence convex;

c) $f(X)$ is a composition of a convex function in 3.18 a) and an affine transformation, hence convex.

> ![image-20220419134934608](/Users/xirhxq/Documents/BIT/2022_Spring_Summer/凸优化/CvxOpt Homework #1.assets/image-20220419134934608.png)

a) Let $f(x) = \max_{i = 1,\dots,k} f_i(x)$. By 3.20 a) we get $f_i(x) = \Vert A^{(i)} x - b^{(i)}\Vert$ is convex. Hence as pointwise maximum of $k$ convex function, $f(x)$ is also convex.

b) Write $f(x)$ as
$$
f(x) = \sum_{i = 1}^r \vert x\vert ^{[i]} = \max_{1 \le i_1 < i_2 < \cdots < i_r \le n}\vert x_{i_1} \vert + \vert x_{i_2} \vert + \cdots + \vert x_{i_r} \vert
$$
which is the pointwise maximum of $n!/r!(n-r)!$ convex functions, hence convex.