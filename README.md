# TSA-MATLAB
This is the TSA binding for connecting the MATLAB programming language and the TSA library.

## License
This project is licensed under [MPL-v2](https://www.mozilla.org/en-US/MPL/2.0/).

## What is this repository for?

* Quick summary:
This MATLAB package called 'tsa' provides all the functionalities of the TSA library for time series analytics.
* Version:
0.0.1

## How do I get set up?
* Just copy the *+tsa* folder to your project.

## Executing the tests:
1. Change the MATLAB working directory to the *tests* directory.
2. Execute the following line for running the tests:

```
runtests()
```

## Documentation
This MATLAB package follows the standard way of writing documentation of MATLAB code.

The documentation can be consulted in 2 ways:
1. Using `help tsa.<class>.<method>()`
2. Creating an HTML file that can be visualized in the browser. This generates
   a user-friendlier view of the documentation, especially of the equations.
```
publish('+tsa/Features.m', 'evalCode', false, 'showCode', false)
```

## Contributing

### Branching model

Our branching model has two permanent branches, **develop** and **master**. We aim at using `develop` as the main branch, where all features are merged. In this sense, we use the master branch to push the release versions of the TSA library.

### Contribution process

In order to contribute to the code base, we follow the next process:
1. The main branch is develop, every developer should pull the current status of the branch before stating to develop any new feature.
`git pull`
2. Create a new branch with the following pattern "feature/[name_of_the_feature]"
`git checkout -b feature/exampleFeature`
3. Develop the new feature on the the new branch. It includes testing and documentation.
`git commit -a -m "Bla, Bla, Bla";  git push`
4. Open a Pull Request to merge the feature branch in to develop. Currently, a pull request has to be reviewed at least by one person.
5. Finally, delete the feature branch.
6. Move back to develop branch.
`git checkout develop`
7. Pull the latest changes.
`git pull`
