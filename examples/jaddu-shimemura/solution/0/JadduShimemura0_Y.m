function out1 = JadduShimemura0_Y(t)
%JADDUSHIMEMURA0_Y
%    OUT1 = JADDUSHIMEMURA0_Y(T)

%    This function was generated by the Symbolic Math Toolbox version 8.3.
%    22-Oct-2019 14:50:36

t2 = exp(1.0);
t3 = exp(2.0);
t4 = exp(t);
t5 = t.*2.0;
t7 = -t;
t8 = sqrt(2.0);
t6 = t4.^2;
t9 = t8.*1.0e+1;
t10 = t8.*2.0e+1;
t11 = t3.*1.9901e+4;
t17 = t.*t8.*-1.0e+1;
t20 = t8.*2.0e+3;
t12 = exp(t9);
t13 = exp(t10);
t14 = t.*t9;
t15 = t.*t10;
t16 = t3.*t9;
t21 = -t20;
t22 = t7+t17;
t18 = exp(t14);
t19 = exp(t15);
t23 = t13.*2.01e+4;
t25 = exp(t22);
t26 = t2.*t12.*8.0e+2;
t28 = t11.*t13;
t30 = t13.*t16;
t31 = t13.*t20;
t32 = t3.*t8.*t13.*-1.0e+1;
t33 = t4.*t8.*t13.*1.0e+3;
t24 = t3.*t18.*9.9e+1;
t27 = -t26;
t29 = t6.*t18.*1.0e+2;
t34 = t4.*t8.*t19.*1.0e+3;
t35 = t3.*t8.*t18.*1.0e+3;
t36 = t6.*t8.*t18.*1.0e+3;
t38 = t2.*t12.*t18.*2.0e+2;
t42 = t2.*t6.*t12.*t18.*-2.0e+2;
t37 = t13.*t24;
t39 = -t36;
t40 = t13.*t29;
t41 = t6.*t38;
t43 = t13.*t35;
t44 = t13.*t36;
t45 = t11+t16+t21+t23+t27+t28+t31+t32+2.01e+4;
t46 = 1.0./t45;
out1 = [-t25.*t46.*(t24+t29-t33+t34-t35+t38+t39+t40+t42+t43+t44-t4.*t13.*1.0e+2-t4.*t19.*1.0e+2+t3.*t34-t3.*t4.*t13.*9.9e+1-t3.*t4.*t19.*9.9e+1+t3.*t13.*t18.*9.9e+1+t2.*t4.*t8.*t12.*1.0e+1-t3.*t4.*t8.*t13.*1.0e+3-t2.*t4.*t9.*t12.*t19),t25.*t46.*(t24-t29-t33+t34-t35+t36+t38+t41+t43-t4.*t13.*2.0e+4-t4.*t19.*2.0e+4+t2.*t4.*t12.*2.0e+2-t3.*t4.*t13.*2.0e+4-t3.*t4.*t19.*2.0e+4+t3.*t13.*t18.*9.9e+1-t6.*t13.*t18.*1.0e+2-t3.*t4.*t8.*t13.*9.9e+2+t3.*t4.*t8.*t19.*9.9e+2+t2.*t4.*t12.*t19.*2.0e+2-t6.*t8.*t13.*t18.*1.0e+3)];