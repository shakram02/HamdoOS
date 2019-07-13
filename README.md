# HamdoOs
An attempt to make a Toy OS, what I succeeded in doing is to make a first and second stage bootloader. I got stuck with loading the kernel for more than 2 weeks and since I have no human mentoring and tutorials (most of them fetched from the WayBack machine) do things almost totally differently I decided to skip the step of loading the OS, what's really left is reading the sectors, copying them to high memory and jump.

I already enter protected mode (in protected-mode) branch. So, it just one single function left. Now, I'll move to writing a Rust-based OS as my original plan was just to load a Hello-World Kernel in C then move to Rust.

### Notes
- I'm using a cross compiler as specified [here](https://wiki.osdev.org/GCC_Cross-Compiler), which is used by my `Makefile`s, I `source` before `shell_init.sh` before calling `make`