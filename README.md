# Khiva-MATLAB
This is the Khiva binding for connecting the MATLAB programming language and the Khiva library.

## License
This project is licensed under [MPL-v2](https://www.mozilla.org/en-US/MPL/2.0/).

## What is this repository for?

* Quick summary:
This MATLAB package called 'khiva' provides all the functionalities of the Khiva library for time series analytics.
* Version:
0.1.0

## How do I get set up?
* Just copy the *+khiva* folder to your project.

## Executing the tests:
1. Change the MATLAB working directory to the *tests* directory.
2. Execute the following line for running the tests:

```
runtests()
```

## Documentation
This MATLAB package follows the standard way of writing documentation of MATLAB code.

The documentation can be consulted in 2 ways:
1. Using `help khiva.<class>.<method>()`
2. Creating an HTML file that can be visualized in the browser. This generates
   a user-friendlier view of the documentation, especially of the equations.
```
publish('+khiva/Features.m', 'evalCode', false, 'showCode', false)
```

### Contributing
The rules to contribute to this project are described [here](CONTRIBUTING.md)

## Known issues

### Ubuntu
When using the Khiva library in Ubuntu with MATLAB 2016a, the `libstdc++` library included in the MATLAB installation folder causes problems while loading our library. Please run MATLAB with the following command: `LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/local/MATLAB/R2016a/bin/matlab -desktop`.
