project('com.github.pigdevstudio.juan_saga')

# godot --export Linux build/com.github.pigdevstudio.juan_saga
run_command(
    'godot',
    '--path',
    meson.source_root(),
    '--export',
    'Linux',
    join_paths(meson.current_build_dir (), meson.project_name())
)

# Fix Godot's .pck naming logic
run_command(
    'mv',
    join_paths(meson.current_build_dir (), 'com.github.pigdevstudio.pck'),
    join_paths(meson.current_build_dir (), meson.project_name() + '.pck')
)

install_data(
    join_paths(meson.current_build_dir (), meson.project_name() + '.pck'),
    install_dir: join_paths(get_option('datadir'), meson.project_name())
)

subdir('data')

