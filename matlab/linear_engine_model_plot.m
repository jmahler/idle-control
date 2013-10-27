clear all;
clf;

linear_engine_model_init;

sim('linear_engine_model');

figure;



subplot(3,1,1);
plot(dout.Time, dout.Data(:,1));
grid on;
axis tight;
title('Idle Duty');
ylabel('idle duty (%)');
xlabel('time (sec)');

subplot(3,1,2);
plot(dout.Time, dout.Data(:,3));
grid on;
axis tight;
title('Torque');
ylabel('torque');
xlabel('time (sec)');

subplot(3,1,3);
plot(dout.Time, dout.Data(:,2));
grid on;
axis tight;
title('RPM');
ylabel('RPM');
xlabel('time (sec)');
