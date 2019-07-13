# HamdoOs
An attempt to make a Toy OS, what I succeeded in doing is to make a first and second stage bootloader. I got stuck with loading the kernel for more than 2 weeks and since I have no human mentoring and tutorials (most of them fetched from the WayBack machine) do things almost totally differently I decided to skip the step of loading the OS, what's really left is reading the sectors, copying them to high memory and jump.

I already enter protected mode (in protected-mode) branch. So, it just one single function left. Now, I'll move to writing a Rust-based OS as my original plan was just to load a Hello-World Kernel in C then move to Rust.

## Resources
- [OS from 0 to 1](https://github.com/tuhdo/os01/) This was my main source
- [NASM tutorial](https://cs.lmu.edu/~ray/notes/nasmtutorial/)
- [Supernovah.com](https://web.archive.org/web/20140706123154/http://www.supernovah.com/Tutorials/index.php)
- [BrokenThorn](http://www.brokenthorn.com/Resources/)
- [Osdever.net](https://web.archive.org/web/20130110203350/http://www.osdever.net/tutorials.php?cat=0&sort=1)
- [Writing an OS in Rust | Philipp Oppermann's blog](https://os.phil-opp.com/)
- [zhu45.org](https://zhu45.org/posts/2017/Jul/30/understanding-how-function-call-works/)
- [OSDev Wiki](https://wiki.osdev.org)
- [The Art of using x86 registers](https://www.swansontec.com/sregisters.html)

## Usage
`make qemu` will compile the code, burn it into a binary file and load it in QEMU, then you'll run `gdb` and watch what's working

### Notes
- I'm using a cross compiler as specified [here](https://wiki.osdev.org/GCC_Cross-Compiler), which is used by my `Makefile`s, I `source` before `shell_init.sh` before calling `make`

