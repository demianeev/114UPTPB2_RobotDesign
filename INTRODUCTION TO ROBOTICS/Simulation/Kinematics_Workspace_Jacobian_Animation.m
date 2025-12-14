%% ===== WORKSPACE + JACOBIAN ANIMATION (PPP ROBOT) =====
clear; close all; clc;

%% --- Workspace limits (mm)
Xmax = 300;
Ymax = 300;
Zmax = 150;

%% --- Animation parameters
Nsteps = 80;
animation_speed = 0.05;
jac_scale = 25;   % length of Jacobian vectors

%% --- Jacobian (PPP)
J = eye(3);

%% ===== Figure setup =====
figure('Color','w');
axis equal; grid on; hold on;
xlabel('X (mm)'); ylabel('Y (mm)'); zlabel('Z (mm)');
title('Workspace and Jacobian Visualization (Cartesian PPP)');

xlim([0 Xmax]);
ylim([0 Ymax]);
zlim([0 Zmax]);

view(45,30);
camproj('perspective');

%% ===== Video export =====
v = VideoWriter('Workspace_Jacobian_3D.mp4','MPEG-4');
v.FrameRate = 15;
open(v);

%% ===== Animation loop =====
for k = 1:Nsteps
    cla;   % clear axes
    
    % --- Growing workspace
    x = Xmax * k/Nsteps;
    y = Ymax * k/Nsteps;
    z = Zmax * k/Nsteps;
    
    % Workspace vertices
    V = [0 0 0;
         x 0 0;
         x y 0;
         0 y 0;
         0 0 z;
         x 0 z;
         x y z;
         0 y z];
     
    F = [1 2 3 4;
         5 6 7 8;
         1 2 6 5;
         2 3 7 6;
         3 4 8 7;
         4 1 5 8];
     
    patch('Vertices',V,'Faces',F, ...
          'FaceColor','cyan','FaceAlpha',0.15, ...
          'EdgeColor','k','LineWidth',1);
    
    % --- End-effector (camera) position
    ee = [x y z];
    plot3(ee(1), ee(2), ee(3), ...
          'ro','MarkerSize',8,'MarkerFaceColor','r');
    
    % --- Jacobian vectors (columns of J)
    % X direction
    quiver3(ee(1),ee(2),ee(3), ...
            jac_scale*J(1,1),0,0, ...
            'LineWidth',2,'Color','b','MaxHeadSize',0.7);
        
    % Y direction
    quiver3(ee(1),ee(2),ee(3), ...
            0,jac_scale*J(2,2),0, ...
            'LineWidth',2,'Color','g','MaxHeadSize',0.7);
        
    % Z direction
    quiver3(ee(1),ee(2),ee(3), ...
            0,0,jac_scale*J(3,3), ...
            'LineWidth',2,'Color','m','MaxHeadSize',0.7);
    
    % --- Axes from origin
    plot3([0 Xmax],[0 0],[0 0],'r','LineWidth',1.2);
    plot3([0 0],[0 Ymax],[0 0],'g','LineWidth',1.2);
    plot3([0 0],[0 0],[0 Zmax],'b','LineWidth',1.2);
    
    % Labels
    text(Xmax,0,0,'X','FontWeight','bold');
    text(0,Ymax,0,'Y','FontWeight','bold');
    text(0,0,Zmax,'Z','FontWeight','bold');
    
    drawnow;
    
    % Write frame to video
    frame = getframe(gcf);
    writeVideo(v, frame);
    
    pause(animation_speed);
end

%% ===== Finalize =====
close(v);
fprintf('Workspace + Jacobian animation exported as Workspace_Jacobian_3D.mp4\n');
