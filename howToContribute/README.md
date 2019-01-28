# How to Contribute

Let's learn how to add a new exercise to the textbook.

We assume that you have already followed the instructions in the [GUIDE.md](../GUIDE.md).

## Fork the repository

Go to https://github.com/mooculus/laode and click `Fork`

You should have a copy of the repository at https://github.com/YOUR-GITHUB-USERNAME/laode where **YOUR-GITHUB-USERNAME** is your GitHub username.

Go to your local copy of the master repo with
```
cd ~/linear-algebra/laode
```
and set up the remote to point to your personal copy of the repo by running
```
git remote rm origin
git remote add origin https://github.com/YOUR-GITHUB-USERNAME/laode
git remote add upstream https://github.com/mooculus/laode 
```

You will find it convenient to have symlinks to the numbered sections.  To create such symblinks, run
```
ruby make-links.rb
```
which will populate a subdirectory `by-number` with links to the sections of the textbook.

## Locate the appropriate section of the textbook

Let's suppose you would like to add an exercise to Section 2.2, The
Geoemtry of Low-Dimensional Solutions.

You will find the text for that section in [../solvingLinearEquations/theGeometryOfLowDimensionalSolutions.tex](../solvingLinearEquations/theGeometryOfLowDimensionalSolutions.tex), and a subdirectory of the same name ([../solvingLinearEquations/theGeometryOfLowDimensionalSolutions](../solvingLinearEquations/theGeometryOfLowDimensionalSolutions)) houses the exercise files.

## Copy the template to the appropriate location

Pick a new, unused number, and copy [template.tex](template.tex) to
the appropriate directory with the other exercises for that section.

To do this, copy the file to a new number with
```
cd ../by-number/SECTION.NUMBER
cp ~/linear-algebra/laode/howToContribute/template.tex 9999.tex
```
Here, `SECTION.NUMBER` is the desired textbook section, and `9999` is your chosen unused number.

## Write and save your exercise

Open the template you have copied to the appropriate directory and add
your content.

## Commit your changes

Commit your new exercise with
```
git add 9999.tex
git commit -m 'Description of my new exercise'
git push master origin
```

## Submit a pull request

In order for your exercise to appear in the master copy of the
textbook, submit a pull request.  You can do this by going to
https://github.com/YOUR-GITHUB-USERNAME/laode and clicking on `New Pull
Request`.
