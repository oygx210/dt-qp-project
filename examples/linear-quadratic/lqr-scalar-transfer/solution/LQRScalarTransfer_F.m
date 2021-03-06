function F = LQRScalarTransfer_F(a,b,c,d,f,q,r)
%LQRSCALARTRANSFER_F
%    F = LQRSCALARTRANSFER_F(A,B,C,D,F,Q,R)

%    This function was generated by the Symbolic Math Toolbox version 8.0.
%    15-Mar-2018 19:37:22

t2 = c.^2;
t3 = d.^2;
t4 = 1.0./b.^2;
t5 = a.^2;
t6 = r.^2;
t7 = t5.*t6;
t8 = b.^2;
t9 = q.*r.*t8;
t10 = t7+t9;
t11 = sqrt(t10);
t12 = 1.0./r;
F = t4.*(t11.*(t2+t3)+a.*r.*(t2-t3))+(t4.*t11.*(t2.*2.0+t3.*2.0-c.*d.*exp(f.*t11.*t12).*4.0))./(exp(f.*t11.*t12.*2.0)-1.0);
