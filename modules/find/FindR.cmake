# Copyright (c) 2017-2023 King Abdullah University of Science and Technology,
# Copyright (c) 2023 by Brightskies inc,
# All rights reserved.

# - Find the R and Rcpp library
#
# Usage:
#   find_package(R [REQUIRED] [QUIET] )
#
# It sets the following variables:
#   R _FOUND               ... true if R and Rcpp is found on the system
#   R_LIBRARIES            ... full path to R and Rcpp library
#   R_INCLUDE_DIRS         ... R and Rcpp include directory
#
# The following variables will be checked by the function
#   R_ROOT_PATH          ... if set, the libraries are exclusively searched
#                               under this path

#If environment variable RDIR is specified, it has same effect as R_ROOT_PATH


if (NOT R_ROOT_PATH AND DEFINED ENV{RDIR})
    set(R_ROOT_PATH $ENV{RDIR})
endif ()

if (R_ROOT_PATH)

    #find libs
    find_library(
            R_LIB_BLAS
            REQUIRED
            NAMES "libRblas.so"
            PATHS ${R_ROOT_PATH}
            PATH_SUFFIXES "lib" "lib64" "bin"
            NO_DEFAULT_PATH
    )

    #find libs
    find_library(
            R_LIB
            REQUIRED
            NAMES "libR.so"
            PATHS ${R_ROOT_PATH}
            PATH_SUFFIXES "lib" "lib64" "bin"
            NO_DEFAULT_PATH
    )
    #find libs
    find_library(
            R_LIB_LAPACK
            REQUIRED
            NAMES "libRlapack.so"
            PATHS ${R_ROOT_PATH}
            PATH_SUFFIXES "lib" "lib64" "bin"
            NO_DEFAULT_PATH
    )
    #find libs
    find_library(
            RCPP_LIB
            REQUIRED
            NAMES "Rcpp.so"
            PATHS ${R_ROOT_PATH}
            PATH_SUFFIXES "library/Rcpp/libs" "library/Rcpp/lib64" "library/Rcpp/bin"
            NO_DEFAULT_PATH
    )



    # find includes
    find_path(
            R_INCLUDE_DIRS
            REQUIRED
            NAMES "Rconfig.h" "Rembedded.h" "R.h" "Rinternals.h" "Rversion.h"
            "Rdefines.h" "Rinterface.h" "Rmath.h" "S.h"
            PATHS ${R_ROOT_PATH}
            PATH_SUFFIXES "include"
            NO_DEFAULT_PATH
    )
    # find includes
    find_path(
            R_INCLUDE_DIRS_TWO
            REQUIRED
            NAMES "R_ext"
            PATHS ${R_ROOT_PATH}
            PATH_SUFFIXES "include"
            NO_DEFAULT_PATH
    )
    # find includes
    find_path(
            RCPP_INCLUDE_DIRS_ONE
            REQUIRED
            NAMES "RcppCommon.h" "Rcpp.h"
            PATHS ${R_ROOT_PATH}
            PATH_SUFFIXES "library/Rcpp/include"
            NO_DEFAULT_PATH
    )
    # find includes
    find_path(
            RCPP_INCLUDE_DIRS_TWO
            REQUIRED
            NAMES "Rcpp"
            PATHS ${R_ROOT_PATH}
            PATH_SUFFIXES "library/Rcpp/include"
            NO_DEFAULT_PATH
    )



else ()

    #find libs
    find_library(
            R_LIB_BLAS
            REQUIRED
            NAMES "libRblas.so"
            PATHS ${LIB_INSTALL_DIR}
    )

    #find libs
    find_library(
            R_LIB
            REQUIRED
            NAMES "libR.so"
            PATHS ${LIB_INSTALL_DIR}
    )
    #find libs
    find_library(
            R_LIB_LAPACK
            REQUIRED
            NAMES "libRlapack.so"
            PATHS ${LIB_INSTALL_DIR}
    )

    #find libs
    find_library(
            RCPP_LIB
            REQUIRED
            NAMES "Rcpp.so"
            PATHS ${LIB_INSTALL_DIR}
    )
    #find includes
    find_path(
            R_INCLUDE_DIRS
            REQUIRED
            NAMES "Rconfig.h" "Rembedded.h" "R.h" "Rinternals.h" "Rversion.h"
            "Rdefines.h" "Rinterface.h" "Rmath.h" "S.h"
            PATHS ${INCLUDE_INSTALL_DIR}
    )

    #find includes
    find_path(
            R_INCLUDE_DIRS_TWO
            REQUIRED
            NAMES "R_ext"
            PATHS ${INCLUDE_INSTALL_DIR}
    )
    #find includes
    find_path(
            RCPP_INCLUDE_DIRS_ONE
            REQUIRED
            NAMES "RcppCommon.h" "Rcpp.h"
            PATHS ${INCLUDE_INSTALL_DIR}
    )
    #find includes
    find_path(
            RCPP_INCLUDE_DIRS_TWO
            REQUIRED
            NAMES "Rcpp"
            PATHS ${INCLUDE_INSTALL_DIR}
    )

endif (R_ROOT_PATH)

set(R_LIBRARIES
        ${R_LIBRARIES}
        ${R_LIB_BLAS}
        ${R_LIB_LAPACK}
        ${R_LIB}
        )



set(R_INCLUDE
        ${R_INCLUDE}
        ${R_INCLUDE_DIRS}
        ${R_INCLUDE_DIRS_TWO}
        ${RCPP_INCLUDE_DIRS_ONE}
        ${RCPP_INCLUDE_DIRS_TWO}
        )

add_library(R INTERFACE IMPORTED)
set_target_properties(R
        PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${R_INCLUDE}"
        INTERFACE_LINK_LIBRARIES "${R_LIBRARIES}"
        IMPORTED_LOCATION ${RCPP_LIB}
        )


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(R DEFAULT_MSG
        R_INCLUDE R_LIBRARIES)

include_directories(${R_INCLUDE})
mark_as_advanced(
        R_INCLUDE R_INCLUDE_DIRS R_INCLUDE_DIRS_TWO RCPP_INCLUDE_DIRS_ONE RCPP_INCLUDE_DIRS_TWO
        R_LIBRARIES R_LIB_BLAS R_LIB_LAPACK R_LIB RCPP_LIB
)

