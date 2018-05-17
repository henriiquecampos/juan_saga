project('com.github.pigdevstudio.juan_saga')

# godot --export Linux build/com.github.pigdevstudio.juan_saga
# Might want to use meson.add_install_script('meson/myscript.sh') and move this to bash?
run_command(
    'godot',
    '--path',
    meson.source_root(),
    '--export',
    'Linux',
    join_paths(meson.current_build_dir (), meson.project_name())
)

meson.add_install_script('meson/export.sh')

# FIXME: Requires meson 0.46+
# install_data(
#     join_paths(meson.current_build_dir (), 'com.github.pigdevstudio.pck'),
#     # Fix Godot's .pck naming logic
#     rename: join_paths(meson.current_build_dir (), meson.project_name() + '.pck'),
#     install_dir: join_paths(get_option('datadir'), meson.project_name())
# )

# FIXME: Hack to fix Godot's .pck naming logic, use above with meson 0.46
# run_command(
#     'mv',
#     join_paths(meson.current_build_dir (), 'com.github.pigdevstudio.pck'),
#     join_paths(meson.current_build_dir (), meson.project_name() + '.pck')
# )

# install_data(
#     join_paths(meson.current_build_dir (), meson.project_name() + '.pck'),
#     install_dir: join_paths(get_option('datadir'), meson.project_name())
# )

subdir('data')

