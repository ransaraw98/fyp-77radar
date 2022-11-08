%%set simulation paramaeters
f =1E8;     epsilon_r = 1;  mu_r = 1;
epsilon = 8.85418782e-12;
mu  =   1.25663706e-6;

omega = 2*pi*f;     v_p = 1/sqrt(epsilon *epsilon_r *mu *mu_r);     beta = omega/v_p;
lambda = v_p/f;      eta = sqrt(mu * mu_r/(epsilon * epsilon_r));
T = 1/f;
scaleH = eta; % when plotting, scale H quantities with scaleH for better visualization
t = T/3; % set time of interest; can be changed
z=[0:lambda/20:4*lambda]'; % generate grid points on the z axis

%% compute field quantities using (3-1), (3-2)
Ex=zeros(size(z)); Ey=zeros(size(z)); Ez=zeros(size(z));
Hx=zeros(size(z)); Hy=zeros(size(z)); Hz=zeros(size(z));
Sx=zeros(size(z)); Sy=zeros(size(z)); Sz=zeros(size(z));
E0=0.0001; % assumed peak of the E field
Ex = E0*cos(omega*t-beta*z);
Hy = E0/eta*cos(omega*t-beta*z);
Sz = 1/eta*Ex.^2; % compute the nonzero component of the Poynting vector
%% Plot results
figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,4,[1,2,5,6,9,10]);
plot3(z, Ex, Ey,'r', 'linewidth',2) % plot Ex and Ey components
hold on
plot3(z, scaleH*Hx, scaleH*Hy,'b', 'linewidth',2)
arrow3([z zeros(size(z)) zeros(size(z)) ], [z Ex Ey ]) % plot field vectors using
arrow3.m
arrow3([z zeros(size(z)) zeros(size(z)) ], [z scaleH*Hx scaleH*Hy ])
legend('E field', 'H field'); grid on; xlabel('z'); ylabel('x'); zlabel('y')

% The following plot the 6 field components (Ex, Ey, Ez, Hx, Hy, Hz) for points on the z
axis
subplot(3,4,3);plot(z, Ex, 'linewidth',2); ylabel('Ex')
subplot(3,4,7);plot(z, Ey, 'linewidth',2); ylabel('Ey')
subplot(3,4,11);plot(z, Ez, 'linewidth',2); xlabel('z'); ylabel('Ez')
subplot(3,4,4);plot(z, scaleH*Hx, 'linewidth',2); ylabel('Hx');
subplot(3,4,8);plot(z, scaleH*Hy, 'linewidth',2); ylabel('Hy');
subplot(3,4,12);plot(z, scaleH*Hz, 'linewidth',2); xlabel('z'); ylabel('Hz')