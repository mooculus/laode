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

