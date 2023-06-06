// This file is part of the von_koch_snowflake Fortran project.
// Copyright (C) 2023 Vincent MAGNIN
//
// This is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 3, or (at your option)
// any later version.
//
// This software is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along with
// this program; see the files LICENSE and LICENSE_EXCEPTION respectively.
// If not, see <http://www.gnu.org/licenses/>.
//------------------------------------------------------------------------------
// Contributed by Vincent Magnin
// Pascal version: 1987 ?
// Python version: 2010
// Fortran version: 2023-06-05
// Last modifications: 2023-06-06
//------------------------------------------------------------------------------

{$i c:graph.p};
var
   xc,yc,xa,ya,xb,yb:integer;

procedure vonkoch(xe,ye,xf,yf:integer;n:integer);
var xa,ya,xb,yb,xc,yc:integer;
begin
     if n<4 then
     begin
          n:=n+1;
          xc:=round(1/3*(xf+2*xe));
          yc:=round(1/3*(yf+2*ye));
          xa:=round(1/3*(2*xf+xe));
          ya:=round(1/3*(2*yf+ye));
          xb:=round(1/2*(xf+xe)-1/(2*sqrt(3))*(yf-ye));
          yb:=round(1/2*(yf+ye)+1/(2*sqrt(3))*(xf-xe));
          vonkoch(xe,ye,xc,yc,n);
          vonkoch(xc,yc,xb,yb,n);
          vonkoch(xb,yb,xa,ya,n);
          vonkoch(xa,ya,xf,yf,n);
     end
     else
     begin
          draw(round(xe*1/0.43),ye,round(xf*1/0.43),yf,1);
     end;
end;

begin
     hires;
     xc:=100;
     yc:=50;
     xa:=250;
     ya:=50;
     xb:=round(1/2*(xa-xc)-sqrt(3)/2*(ya-yc)+xc);
     yb:=round(1/2*(ya-yc)+sqrt(3)/2*(xa-xc)+yc);
     vonkoch(xa,ya,xc,yc,0);
     vonkoch(xb,yb,xa,ya,0);
     vonkoch(xc,yc,xb,yb,0);
     fillshape(300,100,1,1);
     repeat
     until keypressed;

end.
