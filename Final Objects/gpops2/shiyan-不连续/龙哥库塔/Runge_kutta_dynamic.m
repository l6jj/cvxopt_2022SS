function y= Runge_kutta_dynamic(h,x)

K1 = h * dynamic(x);
K2 = h * dynamic(x + 0.5*K1);
K3 = h * dynamic(x + 0.5*K2);
K4 = h * dynamic(x + K3);

y = x+ (1/6) * (K1 + 2*K2 + 2*K3 + K4);

end