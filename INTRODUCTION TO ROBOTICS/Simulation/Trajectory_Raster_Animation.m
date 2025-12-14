%% ===== USER PARAMETERS =====

% --- PCB dimensions (mm)
PCB_size_x = 200;     % PCB width (X)
PCB_size_y = 200;     % PCB height (Y)

% --- Camera parameters
cam.Nx = 2048;        % horizontal pixels
cam.Ny = 1536;        % vertical pixels
cam.hFOV = deg2rad(40); % horizontal field of view
cam.vFOV = deg2rad(30); % vertical field of view

% --- Desired spatial resolution
desired_mm_per_pixel = 0.04;  % 40 microns / pixel

% --- Image overlap (for stitching / safety)
overlap = 0.20;   % 20%
%% ===== AUTOMATIC WORKING DISTANCE =====
WD = desired_mm_per_pixel * cam.Nx / (2*tan(cam.hFOV/2));
fprintf('Computed working distance: %.1f mm\n', WD);
%% ===== CAMERA FOOTPRINT =====
img_width  = 2*WD*tan(cam.hFOV/2);
img_height = 2*WD*tan(cam.vFOV/2);

step_x = img_width  * (1 - overlap);
step_y = img_height * (1 - overlap);

fprintf('Image footprint: %.1f x %.1f mm\n', img_width, img_height);
%% ===== NUMBER OF IMAGES =====
Nx = ceil(PCB_size_x / step_x);
Ny = ceil(PCB_size_y / step_y);

fprintf('Images required: %d x %d = %d\n', Nx, Ny, Nx*Ny);
%% ===== TRAJECTORY GENERATION =====
x_positions = linspace(img_width/2, PCB_size_x - img_width/2, Nx);
y_positions = linspace(img_height/2, PCB_size_y - img_height/2, Ny);

trajectory = [];
direction = 1;

for i = 1:Nx
    if direction == 1
        ylist = y_positions;
    else
        ylist = fliplr(y_positions);
    end
    
    for y = ylist
        trajectory = [trajectory; x_positions(i), y, WD];
    end
    
    direction = -direction;
end
%% ===== PLOT =====
figure; hold on; axis equal; grid on;
xlabel('X (mm)'); ylabel('Y (mm)');
title('AOI Raster Scan Trajectory');

% PCB
rectangle('Position',[0 0 PCB_size_x PCB_size_y], ...
          'EdgeColor','k','LineWidth',2);

% Trajectory
plot(trajectory(:,1), trajectory(:,2), '-o');

% Image footprints
for k = 1:size(trajectory,1)
    rectangle('Position', ...
      [trajectory(k,1)-img_width/2, trajectory(k,2)-img_height/2, ...
       img_width, img_height], ...
      'EdgeColor',[1 0 0 0.15]);
end
% ===== EXPORT GRID IMAGE =====
exportgraphics(gcf, 'AOI_scan_grid.jpg', 'Resolution', 300);
fprintf('Grid image exported as AOI_scan_grid.jpg\n');

%% ===== 2D ANIMATION (TOP VIEW) =====
figure; hold on; axis equal; grid on;
xlabel('X (mm)'); ylabel('Y (mm)');
title('2D Camera Scan Animation (Top View)');

% PCB
rectangle('Position',[0 0 PCB_size_x PCB_size_y], ...
          'EdgeColor','k','LineWidth',2);

% Full trajectory (gray)
plot(trajectory(:,1), trajectory(:,2), '--', 'Color',[0.7 0.7 0.7]);

% Camera marker
cam_dot = plot(trajectory(1,1), trajectory(1,2), ...
               'ro', 'MarkerSize',8, 'MarkerFaceColor','r');

% Camera footprint rectangle
cam_rect = rectangle('Position',[0 0 img_width img_height], ...
                     'EdgeColor','r');

% ===== EXPORT 2D ANIMATION =====
v2D = VideoWriter('AOI_scan_2D.mp4', 'MPEG-4');
v2D.FrameRate = 5;   % frames per second
open(v2D);

for k = 1:size(trajectory,1)
    % Update camera position
    set(cam_dot, 'XData', trajectory(k,1), ...
                 'YData', trajectory(k,2));
             
    set(cam_rect, 'Position', ...
        [trajectory(k,1)-img_width/2, ...
         trajectory(k,2)-img_height/2, ...
         img_width, img_height]);

    drawnow;
    frame = getframe(gcf);
    writeVideo(v2D, frame);
    pause(1);   % animation speed
end
close(v2D);
fprintf('2D animation exported as AOI_scan_2D.mp4\n');


%% ===== 3D ANIMATION =====
figure; hold on; grid on; axis equal;
xlabel('X (mm)'); ylabel('Y (mm)'); zlabel('Z (mm)');
title('3D Cartesian AOI Robot Motion');

xlim([0 PCB_size_x]);
ylim([0 PCB_size_y]);
zlim([0 WD+50]);

% Draw PCB plane
patch([0 PCB_size_x PCB_size_x 0], ...
      [0 0 PCB_size_y PCB_size_y], ...
      [0 0 0 0], ...
      'g','FaceAlpha',0.15);

% Trajectory
plot3(trajectory(:,1), trajectory(:,2), trajectory(:,3), ...
      '--', 'Color',[0.6 0.6 0.6]);

% Camera position marker
cam3D = plot3(trajectory(1,1), trajectory(1,2), trajectory(1,3), ...
              'ro','MarkerSize',8,'MarkerFaceColor','r');

% Simple vertical column (Z axis)
z_line = plot3([trajectory(1,1) trajectory(1,1)], ...
               [trajectory(1,2) trajectory(1,2)], ...
               [0 trajectory(1,3)], 'b','LineWidth',2);
% ===== EXPORT 3D ANIMATION =====
view(45, 30);    % Isometric view
camproj('perspective');

v3D = VideoWriter('AOI_scan_3D.mp4', 'MPEG-4');
v3D.FrameRate = 5;
open(v3D);

for k = 1:size(trajectory,1)
    % Update camera position
    set(cam3D, 'XData', trajectory(k,1), ...
               'YData', trajectory(k,2), ...
               'ZData', trajectory(k,3));
    
    % Update Z column
    set(z_line, 'XData',[trajectory(k,1) trajectory(k,1)], ...
                'YData',[trajectory(k,2) trajectory(k,2)], ...
                'ZData',[0 trajectory(k,3)]);
    
    drawnow;
    frame = getframe(gcf);
    writeVideo(v3D, frame);
    pause(1);
end
close(v3D);
fprintf('3D animation exported as AOI_scan_3D.mp4\n');

