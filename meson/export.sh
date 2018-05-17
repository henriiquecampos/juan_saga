#!/bin/sh

# Export with godot and the Linux prefix defined in the project
godot --export Linux ${DESTDIR}/${MESON_BUILD_ROOT}/com.github.pigdevstudio.juan_saga

# Fix godot .pck file name
mv ${DESTDIR}/${MESON_BUILD_ROOT}/com.github.pigdevstudio.pck ${DESTDIR}/${MESON_BUILD_ROOT}/com.github.pigdevstudio.juan_saga.pck

