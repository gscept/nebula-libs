#
# project: nebula-libs
#
cmake_minimum_required(VERSION 2.8)

# include the fips main cmake file
get_filename_component(FIPS_ROOT_DIR "../fips" ABSOLUTE)
include("${FIPS_ROOT_DIR}/cmake/fips.cmake")

fips_begin_module(nebula-libs)
fips_files_ex(base64/ *.* GROUP base64)
fips_files_ex(jzon-c/ *.* GROUP jzon-c)
fips_files_ex(tinyfiledialogs/ *.c *.h GROUP tinyfiledialogs)
fips_files_ex(minizip/ *.* GROUP minizip)		
fips_end_module()