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

module von_koch
    ! Cairo uses C doubles:
    use, intrinsic :: iso_c_binding, only: dp=>c_double, c_ptr
    ! Use the cairo-fortran bindings:
    use cairo

    implicit none
    private
    public :: von_koch_segment, ROTATE

    ! The y axis going downward in Cairo, the 60° rotation must be inverted:
    complex(dp), parameter :: ROTATE = cmplx(0.5_dp, -sqrt(3._dp) / 2, dp)

contains

    subroutine draw_segment(P1, P2, r, g, b, cr)
        complex(dp), intent(in) :: P1, P2
        real(dp), intent(in)    :: r, g, b
        ! Cairo context:
        type(c_ptr), intent(in) :: cr

        call cairo_set_source_rgb(cr, r, g, b)
        call cairo_move_to(cr, P1%re, P1%im)
        call cairo_line_to(cr, P2%re, P2%im)
        call cairo_stroke(cr)
    end subroutine draw_segment


    recursive subroutine von_koch_segment(E, F, n, nmax, cr)
        complex(dp), intent(in) :: E, F
        integer, intent(in)     :: n, nmax
        type(c_ptr), intent(in) :: cr
        complex(dp) :: A, B, C

        ! F---A---C---E
        !      \ /
        !       B

        if (n < nmax) then      ! Recursion case
            C = (F + 2*E) / 3
            A = (2*F + E) / 3
            B = A + (C - A) * ROTATE
            call von_koch_segment(E, C, n+1, nmax, cr)
            call von_koch_segment(C, B, n+1, nmax, cr)
            call von_koch_segment(B, A, n+1, nmax, cr)
            call von_koch_segment(A, F, n+1, nmax, cr)
        else                    ! Terminating case
            call draw_segment(E, F, 0._dp, 0._dp, 0._dp, cr)
        end if
    end subroutine

end module von_koch
