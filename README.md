# Event-Based 3D Point Visualization

This MATLAB project loads and animates 3D points that were recorded using a DAVIS346 stereo camera setup and then triangulated. Those points are stored in `.csv`-files.

## Project Structure

- `CSV_Input_Files/triangulated_points_*.csv`
  Contains pre-triangulated 3D point data (X, Y, Z) and timestamps in microseconds.

- `visualize_triangulated_points.m`
  Loads, filters and animates the 3D points.

## Data Format

Each CSV file contains these columns:
- `timestamp` (in microseconds)
- `x`, `y`, `z` (in meters, in world coordinates)

## How to Use

1. Open `visualize_triangulated_points.m` in MATLAB.
2. Make sure the correct CSV file path is set.
3. Run the script to view an animated 3D plot of the points over time.
