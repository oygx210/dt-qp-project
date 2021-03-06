function out1 = Brachistochrone_Y(f,g,t,t1,t2,theta,w1,w2)
%BRACHISTOCHRONE_Y
%    OUT1 = BRACHISTOCHRONE_Y(F,G,T,T1,T2,THETA,W1,W2)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    21-Jun-2020 00:46:13

t4 = cos(theta);
t5 = sin(theta);
t6 = f.*w2;
t7 = t1.*w1;
t8 = t2.*w2;
t9 = t1.^2;
t10 = w1.^2;
t12 = t.*w1.*2.0;
t15 = -t;
t16 = -t1;
t17 = -t2;
t18 = 1.0./w1;
t20 = 1.0./w2;
t31 = (t.*w2)./2.0;
t11 = t5.^2;
t13 = t7.*2.0;
t14 = sin(t7);
t19 = 1.0./t10;
t21 = t20.^2;
t22 = g.*t1.*t5;
t23 = -t8;
t26 = t1.*t5.*2.0;
t30 = t6./2.0;
t32 = t8./2.0;
t34 = f+t17;
t35 = t+t16;
t36 = t1+t15;
t37 = t+t17;
t38 = t2+t15;
t39 = t5.*t7.*w2;
t40 = t5.*t8.*w1;
t41 = g.*t7.*-2.0;
t46 = g.*t5.*t16;
t47 = t5.*t7.*-2.0;
t48 = -t31;
t54 = g.*t2.*t5.*w1.*2.0;
t24 = cos(t13);
t25 = g.*t13;
t27 = sin(t13);
t28 = t14.*2.0;
t29 = t5.*t13;
t33 = t14.*w2;
t42 = heaviside(t35);
t43 = heaviside(t36);
t44 = heaviside(t37);
t45 = heaviside(t38);
t49 = -t32;
t55 = t34.*w2;
t57 = t5.*t41;
t58 = t5.*t23.*w1;
t61 = t6+t23;
t63 = g.*t14.*t18;
t64 = g.*t4.*t7.*t14.*4.0;
t65 = g.*t5.*t7.*t14.*4.0;
t74 = t30+t48;
t50 = g.*t24;
t51 = g.*t27;
t52 = g.*t28;
t53 = t5.*t25;
t56 = -t33;
t60 = cos(t55);
t62 = cos(t61);
t67 = -t65;
t71 = t7.*t11.*t25;
t72 = t4.*t7.*t57;
t75 = t30+t49;
t76 = cos(t74);
t78 = tan(t74);
t59 = -t50;
t66 = t62.*w1;
t68 = g.*t60.*2.0;
t69 = t4.*t7.*t53;
t77 = cos(t75);
t79 = tan(t75);
t81 = t76.^2;
t83 = t78.^2;
t85 = t52+t54+t57;
t87 = t41+t51+t64+t72;
t89 = (t19.*(t51+t64-g.*t7.*2.0-g.*t4.*t5.*t7.^2.*2.0))./4.0;
t70 = -t68;
t73 = g+t68;
t82 = t77.^2;
t84 = t79.^2;
t86 = g+t59+t67+t71;
t80 = g+t70;
t88 = (t19.*t86)./4.0;
out1 = [-t44.*(t89+(t20.*(t78.*t80-t73.*t78.^3))./(w2+t83.*w2.*2.0+t83.^2.*w2)-(t20.*(t79.*t80-t73.*t79.^3))./(w2+t84.*w2.*2.0+t84.^2.*w2)-(g.*t.*t20)./2.0+(g.*t2.*t20)./2.0+(t20.*t78.*t85)./(w1+t83.*w1)-(t20.*t79.*t85)./(w1+t84.*w1)-(g.*t2.*t4.*t18.*(t28+t47+t2.*t5.*w1))./2.0)-t42.*t45.*(t89-(g.*t.*t4.*t18.*(t28+t47+t.*t5.*w1))./2.0)+(g.*t19.*t43.*(t12-sin(t12)))./4.0,t44.*(t88+t2.*t5.*t63-(g.*t2.*t5.*(t26+t5.*t17))./2.0-g.*t18.*t21.*t81.*(t39+t56+t58+t66+w1-t81.*w1).*2.0+g.*t18.*t21.*t82.*(t39+t56+t58+t66+w1-t82.*w1).*2.0)+t42.*t45.*(t88+t.*t5.*t63-(g.*t.*t5.*(t26-t.*t5))./2.0)+(t19.*t43.*(g-g.*cos(t12)))./4.0,t44.*(t46+t63+g.*t2.*t5-g.*t20.*t62+g.*t20.*cos(t6+t15.*w2))+t42.*t45.*(t46+t63+g.*t.*t5)+g.*t18.*t43.*sin(t.*w1)];
