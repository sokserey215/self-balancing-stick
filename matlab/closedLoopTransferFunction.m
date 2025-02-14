% start by computing the open loop transfer function with feedback
openLoopTransferFunction;

% Let's calculate the response of the pendulum angle to a step change
%  in the applied force.
opt = stepDataOptions('StepAmplitude',0.05);
fprintf('--> Closed-loop model with feedback <-- \n')
T = feedback(sysForward,sysBackward*gain,-1)
fprintf('--> Closed-loop model poles <-- \n')
pole(T)
fprintf('--> Closed-loop state-space model <-- \n')
stateSpace = ss(T)
t = 0:0.01:10;
r =0.105*ones(size(t)); % roughly the torque from spare motor
lsim(stateSpace,r,t)
%bongo = tf2ss(T);
%[num,den] = tfdata(T);
%stateSpace = tf2ss(num{1}, den{1})


%{
t = 0:0.01:6;
figure(1)
step(T,t,opt)
myTitle = title(['Step, Parameters: p=' num2str(p) ', q=' num2str(q) ', Kw=' num2str(Kw)]); 
myTitle.FontSize = 12;
ylabel('Pendulum angle (radians)');

% Now, the response to a shove
figure(2)
impulse(T)
myTitle = title(['Impulse, Parameters: p=' num2str(p) ', q=' num2str(q) ', Kw=' num2str(Kw)]); 
myTitle.FontSize = 12;
ylabel('Pendulum angle (radians)');

% Let's reconfigure and look at the step response of the rotor velocity
%sysForward = Ptf*Ctf*Mtf;
%sysBackward = Rtf;
%T = feedback(sysForward,sysBackward*gain,-1)

%figure(3)
%step(T,t,opt)
%myTitle = title(['Step, Parameters: p=' num2str(p) ', q=' num2str(q) ', Kw=' num2str(Kw)]); 
%myTitle.FontSize = 12;
%ylabel('Rotor Velocity (radians/sec)');

%figure(4)
%impulse(T)
%myTitle = title(['Impulse, Parameters: p=' num2str(p) ', q=' num2str(q) ', Kw=' num2str(Kw)]); 
%myTitle.FontSize = 12;
%ylabel('Rotor Velocity (radians/sec)');
%}
