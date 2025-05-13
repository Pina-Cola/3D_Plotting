% Load and filter the data
data = readtable("triangulated_points.csv");
timestamps = data.timestamp;
positions = [data.x, data.y, data.z];

% Keep only reasonable Z values
valid = abs(positions(:,3)) < 1000;
positions = positions(valid, :);
timestamps = timestamps(valid);

% Time binning (1 ms tick steps)
binnedTimestamps = round(timestamps / 1e3);  % round timestamps to 1 ms bins
timeBins = unique(binnedTimestamps);        % list of unique time bins

% Reorder: X stays, Z (height) = Y, Y (depth) = Z
positions = [positions(:,1), positions(:,3), -positions(:,2)];

% Fixed axis limits (update to match reordered axes)
lims = struct('x', [-500, 500], 'y', [-1000, 1000], 'z', [-500, 500]);

% Set up figure
figure;
h = scatter3(nan, nan, nan, 6, 'filled');
xlabel('X (width)'); ylabel('Z (depth)'); zlabel('Y (height)');
xlim(lims.x); ylim(lims.y); zlim(lims.z);
axis manual; view(3); grid on;

% Animate
for i = 1:length(timeBins)
    idx = binnedTimestamps == timeBins(i);  % directly compare integer bins
    pts = positions(idx, :);
    if ~isempty(pts)
        set(h, 'XData', pts(:,1), ...
               'YData', pts(:,2), ...
               'ZData', pts(:,3));
        title(sprintf("Time: %.2f ms", timeBins(i)));  % already in ms
        pause(0.1);
    end
end
