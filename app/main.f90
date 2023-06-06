! This file is part of the von_koch_snowflake Fortran project.
! Copyright (C) 2023 Vincent MAGNIN
!
! This is free software; you can redistribute it and/or modify
! it under the terms of the GNU General Public License as published by
! the Free Software Foundation; either version 3, or (at your option)
! any later version.
!
! This software is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
! GNU General Public License for more details.
!
! You should have received a copy of the GNU General Public License along with
! this program; see the files LICENSE and LICENSE_EXCEPTION respectively.
! If not, see <http://www.gnu.org/licenses/>.
!------------------------------------------------------------------------------
! Contributed by Vincent Magnin
! Pascal version: 1987 ?
! Python version: 2010
! Fortran version: 2023-06-05
! Last modifications: 2023-06-06
!------------------------------------------------------------------------------

program main
    ! Use the cairo-fortran bindings:
    use cairo
    use cairo_enums
    ! Cairo uses C doubles:
    use, intrinsic :: iso_c_binding, only: dp=>c_double, c_ptr
    use von_koch, only: von_koch_segment, ROTATE

    implicit none
    ! Cairo surface and Cairo context:
    type(c_ptr) :: surface, cr
    character(*), parameter :: FILENAME = "von_koch_snowflake.svg"
    ! Size of the surface in mm (landscape A4 paper):
    real(dp), parameter :: IMAGE_WIDTH  = 210._dp
    real(dp), parameter :: IMAGE_HEIGHT = 297._dp

    ! Be very careful, 6 recursions will generate a 2.4 Mio SVG file,
    ! and it grows like 3*4^n...
    integer, parameter  :: MAX_RECURSION = 6
    ! The triangle vertices:
    complex(dp) :: A, B, C

    ! The object will be rendered in a SVG file:
    surface = cairo_svg_surface_create(FILENAME//c_null_char, &
                                      & IMAGE_WIDTH, IMAGE_HEIGHT)
    call cairo_svg_surface_set_document_unit(surface, CAIRO_SVG_UNIT_MM)
    cr = cairo_create(surface)

    ! Initialize parameters:
    call cairo_set_antialias(cr, CAIRO_ANTIALIAS_BEST)
    call cairo_set_line_width(cr, 1._dp / MAX_RECURSION**2)

    ! Remarks: 
    !   * The y axis is oriented downward (and rotation angles are inverted).
    !   * We work in the complex plane.
    !
    ! We start with an equilateral triangle:
    ! C---A
    !  \ /
    !   B

    ! We need margins for printing:
    C = cmplx(IMAGE_WIDTH/10,       IMAGE_HEIGHT/5, dp)
    A = cmplx(IMAGE_WIDTH*9._dp/10, IMAGE_HEIGHT/5, dp)
    B = A + (C - A) * ROTATE

    ! We launch the recursive algorithm on each side of the triangle:
    call von_koch_segment(A, C, 0, MAX_RECURSION, cr)
    call von_koch_segment(B, A, 0, MAX_RECURSION, cr)
    call von_koch_segment(C, B, 0, MAX_RECURSION, cr)

    ! Finalyze:
    call cairo_destroy(cr)
    call cairo_surface_destroy(surface)

    print *, "----------------------------------"
    print *, MAX_RECURSION, "recursions"
    print *, "----------------------------------"
    print *, "Output file: ", FILENAME
    print *, "----------------------------------"
end program main
