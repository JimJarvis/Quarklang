QUARK (QUantum Analysis and Realization Kit)
=====

####COMS 4115 Project: Quantum Computing Language

A language and compiler implemented in OCaml to build quantum circuits.

####Instructions
- Install [Vagrant](https://www.vagrantup.com/downloads.html)
- Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- Open the repo directory and run `vagrant up`
- Run `vagrant ssh` to ssh into the Vagrant box running Ubuntu 14.04 LTS with OCaml and g++4.8 installed
- Make sure you are in the `/vagrant` directory by running the command `pwd` and if you are not run `cd /vagrant`.

###Compiling and Running Quark Programs
The following Hello World example Quark program is saved in `/tests/hello_world.qk`.

```
def int main:
{
    print("hello world");

    return 0;
}
```

Before we can compile Quark programs into C++ we must build the Quark compiler `quarkc`. Navigate to `/vagrant/quark/` and run `make`. Ensure `quarkc` was properly built by  checking for error messages then running `./quarkc -h`  to see compilation options.
You should see the following:

```
usage: quarkc -s source.qk [-c output.cpp ] [-o executable] [-static] [-g++ /path/to/g++]
  -s : quark source file
  -c : generated C++ file. If unspecified, print generated code to stdout
  -o : compile to executable. Requires g++ (version >= 4.8)
  -sco : shorthand for -s <file>.qk -c <file>.cpp -o <file>
  -sc : shorthand for -s <file>.qk -c <file>.cpp
  -g++ : shorthand for -s <file>.qk -c <file>.cpp
  -static : compile with static lib (otherwise with dynamic lib). Does NOT work on OSX
  -help  Display this list of options
```

As stated above, to compile `tests/hello_world.qk` into C++ and an executable run `./quark/quarkc -s tests/hello_world.qk -c hello_world.cpp -o hello_world`. You can run the hello_world executable to get output, and the `cat` command shows the generated C++ as follows:

```
vagrant@vagrant-ubuntu-trusty-64:/vagrant$ ./hello_world
hello world

vagrant@vagrant-ubuntu-trusty-64:/vagrant$ cat hello_world.cpp
#include "qureg.h"
#include "qumat.h"
#include "qugate.h"
#include "quarklang.h"

using namespace Qumat;
using namespace Qugate;

int main()
{
std::cout << std::boolalpha << std::setprecision(6) << std::string("hello world") << std::endl;
return 0;
} // end main()
```

The C++ includes are referencing our quantum simulator and these files can be found in the `lib` directory.

You can run `vagrant suspend` to suspend the box (still occupies disk) and `vagrant destroy` to remove it completely


####Team
In lexicographical order:

| Name                 | UNI     | Role                        |
|----------------------|---------|-----------------------------|
| Daria Jung           | djj2115 | Verification and Validation |
| Jamis Johnson        | jmj2180 | System Architect            |
| Jim Fan              | lf2422  | Language Guru               |
| Parthiban Loganathan | pl2487  | Manager                     |
