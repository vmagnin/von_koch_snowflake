# The von Koch snowflake

This project generates a SVG file with a von Koch snowflake, using the [cairo-fortran](https://github.com/vmagnin/cairo-fortran) bindings as a fpm (Fortran Package Manager) dependency.

The classical recursive algorithm is used, each line segment being replaced by four segments.

![A von Koch snowflake](figures/von_koch_snowflake.svg)

Be careful with the number of recursions: the SVG file is growing like $3 \times 4^n$ ! Six recursions will generate a 2.4 Mio SVG file. Your SVG viewer may quickly freeze or crash...

## Requirements and dependencies

You need:

* a modern Fortran compiler, for example GFortran or the Intel ifort/ifx compilers. See the [Fortran-lang.org compilers page](https://fortran-lang.org/compilers/) for other compilers.
* The Cairo development files (`libcairo2-dev` package in Ubuntu).
* The Fortran Package Manager [fpm](https://fpm.fortran-lang.org/).

## Running the program

Just type `fpm run` and fpm will manage the dependencies and build and run the program:

```bash
$ fpm run
 + mkdir -p build/dependencies
Initialized empty Git repository in von_koch_snowflake/build/dependencies/cairo-fortran/.git/
remote: Enumerating objects: 23, done.
remote: Counting objects: 100% (23/23), done.
remote: Compressing objects: 100% (22/22), done.
remote: Total 23 (delta 0), reused 14 (delta 0), pack-reused 0
Unpacking objects: 100% (23/23), 82.99 KiB | 2.37 MiB/s, done.
From https://github.com/vmagnin/cairo-fortran
 * branch            HEAD       -> FETCH_HEAD
cairo-enums.f90                        done.
cairo-auto.f90                         done.
von_koch.f90                           done.
libvon_koch_snowflake.a                done.
main.f90                               done.
von_koch_snowflake                     done.
[100%] Project compiled successfully.
 ----------------------------------
           6 recursions
 ----------------------------------
 Output file: von_koch_snowflake.svg
 ----------------------------------
```


## Licenses

This project is licensed under the [GNU General Public License version 3 or later](http://www.gnu.org/licenses/gpl.html).

The documentation is under the [GNU Free Documentation License 1.3 or any later version](http://www.gnu.org/licenses/fdl.html). The figures are under [CC-BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) license.

## Cairo documentation

* https://cairographics.org/documentation/
* API Reference Manual: https://cairographics.org/manual/

## Bibliography

* https://en.wikipedia.org/wiki/Koch_snowflake