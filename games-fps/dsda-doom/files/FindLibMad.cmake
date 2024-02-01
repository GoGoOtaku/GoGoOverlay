#[=======================================================================[.rst:
FindLibMad
-------

Finds the LibMad library.

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following imported targets, if found:

``LibMad::libmad``
  The LibMad library

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``LibMad_FOUND``
  True if the system has the LibMad library.
``LibMad_INCLUDE_DIRS``
  Include directories needed to use LibMad.
``LibMad_LIBRARIES``
  Libraries needed to link to LibMad.

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``LibMad_INCLUDE_DIR``
  The directory containing ``LibMad.h``.
``LibMad_DLL``
  The path to the LibMad Windows runtime.
``LibMad_LIBRARY``
  The path to the LibMad library.

#]=======================================================================]

find_package(PkgConfig REQUIRED)

pkg_search_module(LibMad REQUIRED IMPORTED_TARGET mad)
add_library(LibMad::libmad ALIAS PkgConfig::LibMad)

set(LibMad_DLL "")
set(LibMad_INCLUDE_DIR "${LibMad_INCLUDE_DIRS}")
set(LibMad_LIBRARY "${LibMad_LIBRARIES}")

mark_as_advanced(
  LibMad_INCLUDE_DIR
  LibMad_DLL
  LibMad_LIBRARY
)

