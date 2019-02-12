# Instructor guide

## How to create worksheets

The following instructions assume you are using a Mac.

### Get the `.cls` files.

In the Terminal, run
```
mkdir -p ~/Library/texmf/tex/latex
git clone https://github.com/XimeraProject/ximeraLatex ~/Library/texmf/tex/latex/ximeraLatex
```

### Download resources

First, download the book.
```
mkdir ~/linear-algebra
git clone https://github.com/mooculus/laode ~/linear-algebra/laode
```

Then, download the worksheet builder.
```
git clone https://github.com/kisonecat/worksheet-builder ~/linear-algebra/worksheet-builder
```
And install the other software needed to run the worksheet builder.
```
gem install optparse-pathname
```
If you lack permissions to run `gem`, try
```
gem install --user-install optparse-pathname
```
to install it locally.

### Build the book

Compile the book.  This step is needed because various `aux` files are created which will be read by the worksheet builder.

```
cd ~/linear-algebra/laode
lualatex --shell-escape linearAlgebra
lualatex --shell-escape linearAlgebra
```

You can [view a PDF of the textbook](https://osu.box.com/v/laode-labels) which includes the labels that you can use in the `\exercise` command below.

### Try it

Now you are ready to try building a worksheet.

Go to the worksheet builder directory.
```
cd ~/linear-algebra/worksheet-builder
```
Then create a file called `homework0.tex` with the following content:

```
\documentclass{article}

\input{preamble}

\title{Homework 0}\author{Author Name}\date{Jan 1, 2019}

\begin{document}
\maketitle

\exercise{c5.1.4g}

\exercise{c5.1.7b}

\end{document}
```

Now if you run
```
./build-both.sh --root=$HOME/linear-algebra/laode sample.tex
```
two files will be created:
* one with solutions called `homework0s.pdf` and
* one without solutions called `homework0e.pdf`.

## Installing MATLAB

### For Ohio State faculty and students

Computers not only enable the completion of complicated calculations,
but can also improve the conceptual understanding of mathematics.
This course relies on MATLAB, a popular software package for matrix
computations.  MATLAB is available free-of-charge to Ohio State
students.  To download and activate your free copy of MATLAB, please
follow the steps below.

1) Launch Ohio State's IT Self-Service.  Links to an external
site. tool and click Login at the upper right.

2) Click Order Services. It is marked with a shopping cart but MATLAB
will not cost you anything.

3) Click the Software Request link located under the "Software
Services" heading.

4) Complete the Software Request Form, choosing MATLAB.  Agree to
terms and conditions.

5) Click Check Out.

6) Click Submit Order at the lower right. 

7) Your order confirmation page lists your selections and their costs,
as well as provides a Request Number (i.e., REQ12345) for tracking
purposes.

The rest of the instructions for installing MATLAB will automatically
be emailed to your Ohio State email account.  Instructions will vary
as to whether you are on Windows, Mac OS, or Linux.

### Getting the m_files

To produce m_files with filenames coming from the numeric labels in
the textbook, run

```
cd ~/linear-algebra/laode/m_files
ruby numeric-labels.rb
```

Then to see the m_files, run

```
cd ~/linear-algebra/laode/m_files/linearAlgebra
ls
```

## Set up canvas

To set up a course shell in Canvas ("Carmen") populated with linear
algebra content, email fowler@math.osu.edu.

## Syllabus

To receive a sample syllabus and calendar, email fowler@math.osu.edu.

## Old exams

Contact Marty Golubitsky (golubitsky.4@osu.edu) for old Math 2568 exams.

## How to add exercises

In this repository, there is a
[template.tex](https://github.com/mooculus/laode/blob/master/howToContribute/template.tex)
file which can be used as a starting point for creating your own
exercises.

Once you have edited the template, please send the template to
fowler@math.osu.edu so that it can be added to the textbook
repository.
