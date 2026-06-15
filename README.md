# pairs_octomap_tools

A toolbox for working with the OctoMaps produced by the PAIRS mapping stack: visualizing
them in RViz, interactively editing them, removing a ceiling/roof layer, and saving them to
disk. It supports both plain (`OcTree`) and colored (`ColorOcTree`) maps. These tools support
offline map cleanup and inspection alongside the live `pairs_octomap_server`.

## Contents
Nodelets (each with a plain `octree` and a `color_octree` variant):
- `pairs_octomap_tools/OctomapRvizVisualizer` — converts an OctoMap into RViz markers for
  visualization.
- `pairs_octomap_tools/OctomapEditor` — interactive map editing, exposed through
  dynamic_reconfigure.
- `pairs_octomap_tools/OctomapSaver` — saves an OctoMap to a file.

Also ships an `OctomapCeilingRemover` nodelet/launch for stripping a ceiling layer, launch
files for each tool, and a plain-tmux `editor` session that brings up the editor, RViz and
rqt_reconfigure together.

## Branches
- `ros1` — ROS 1 Noetic (catkin)
- `ros2` — ROS 2 Jazzy (ament_cmake)

## Install (ROS 1 Noetic)
```bash
sudo apt install ros-noetic-pairs-octomap-tools
```

## Usage
Launch an individual tool, e.g. the editor:
```bash
roslaunch pairs_octomap_tools octomap_editor.launch
```
Other launch files: `octomap_rviz_visualizer.launch`, `octomap_saver.launch`,
`octomap_ceiling_remover.launch`.

Or start the full editing workspace (editor + RViz + rqt_reconfigure):
```bash
cd tmux/editor && ./start.sh   # stop with ./kill.sh
```

## License
BSD 3-Clause. Derived from the CTU-MRS `pairs_octomap_tools` package; the original
copyright is retained in [LICENSE](LICENSE).
