% Load and filter the data
data = readtable("triangulated_points_27_05_2025_m.csv");
timestamps = data.timestamp;
positions = [data.x, data.y, data.z];

% Keep only points with valid depth
valid = positions(:,3) > 0 & positions(:,3) < 3.0;
positions = positions(valid, :);
timestamps = timestamps(valid);

% Time binning (1 ms tick steps)
binnedTimestamps = round(timestamps / 1e4);  % 0.01 ms = 10 us
timeBins = unique(binnedTimestamps);       

% Reorder into camera coordinates: Z, X, Y
positions = [positions(:,3), -positions(:,1), -positions(:,2)];

% Fixed axis limits
lims = struct('x', [0, 1], 'y', [-0.5, 0.5], 'z', [-0.5, 0.5]);


% Create figure and lock layout
figure('Units', 'normalized', 'Position', [0.2, 0.2, 0.4, 0.5]); % fixed window size
ax = axes(); hold on;

% Dummy points to freeze axis bounds
scatter3(lims.x, [0 0], [0 0], 1, 'w');
scatter3([0 0], lims.y, [0 0], 1, 'w');
scatter3([0 0], [0 0], lims.z, 1, 'w');

% Actual animated plot
h = scatter3(nan, nan, nan, 16, 'filled');

xlabel('Z (depth)');
ylabel('X (right)');
zlabel('Y (down)');
xlim(lims.x); ylim(lims.y); zlim(lims.z);
axis manual; axis equal;
view(80, 5);  % <- angle
grid on;

% Animate
for i = 1:length(timeBins)
    idx = binnedTimestamps == timeBins(i); 
    pts = positions(idx, :);
    if ~isempty(pts)
        set(h, 'XData', pts(:,1), ... % Z
               'YData', pts(:,2), ... % X
               'ZData', pts(:,3));    % Y
        title(sprintf("Time: %.2f ms", timeBins(i)));
        drawnow;
        pause(0.01);
    end
end
