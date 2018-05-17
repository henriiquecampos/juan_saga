project('com.github.pigdevstudio.juans-saga')

# godot --export Linux build/com.github.pigdevstudio.juans-saga
# Might want to use meson.add_install_script('meson/myscript.sh') and move this to bash?
run_command(
    'godot',
    '--path',
    meson.source_root(),
    '--export',
    'Linux',
    join_paths(meson.current_build_dir (), meson.project_name())
)

install_data (
    join_paths(meson.current_build_dir (), meson.project_name()),
    install_dir: get_option('bindir')
)

install_data(
    join_paths(meson.current_build_dir (), 'com.github.pigdevstudio.pck'),

    # FIXME: Requires meson 0.46+ to fix Godot's .pck naming logic
    # rename: join_paths(meson.current_build_dir (), meson.project_name() + '.pck'),

    install_dir: join_paths(get_option('datadir'), meson.project_name())
)

subdir('data')

