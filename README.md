# Caravel User Project

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![UPRJ_CI](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml) [![Caravel Build](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml)

This is a simple project connecting a 256x32 SRAM block to the wishbone interface for testing. The SRAM block is directly connected to the wishbone bus at address 0x3000000. An additional perpherial was made to write to the io ports when address 0x30008000 is written to. 


Refer to [README](docs/source/index.rst) for this sample project documentation. 

