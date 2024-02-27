#
# project: nebula-libs
#
cmake_minimum_required(VERSION 3.21)

if (NOT FIPS_IMPORT)
# include the fips main cmake file
get_filename_component(FIPS_ROOT_DIR "../fips" ABSOLUTE)
include("${FIPS_ROOT_DIR}/cmake/fips.cmake")
  project(nebula-libs)
  fips_setup()
endif()

fips_begin_lib(nebula-libs)
fips_files_ex(base64/ *.* GROUP base64)
fips_files_ex(jzon-c/ *.* GROUP jzon-c)
fips_files_ex(tinyfiledialogs/ tinyfiledialogs.c tinyfiledialogs.h GROUP tinyfiledialogs)
fips_files_ex(minizip/ zip.h zip.c unzip.h unzip.c crypt.h crypt.c ioapi.h ioapi.c GROUP minizip)
fips_files_ex(ufbx/ ufbx.h ufbx.c GROUP ufbx)
fips_deps(zlib)
if(FIPS_LINUX)
  fips_deps(bsd)
  add_definitions(-D__USE_FILE_OFFSET64)
  add_definitions(-D__USE_LARGEFILE64)
  add_definitions(-D_LARGEFILE64_SOURCE)
  add_definitions(-D_FILE_OFFSET_BIT=64)
endif()
fips_end_lib()