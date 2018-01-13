##Instructions

To compile the template:

1. XeLaTeX must be used, not pdflatex.

2. For some useful mathematical definitions, maybe you could use the package provided

   ```latex
   \usepackage{mytikzmath}
   ```
   
   It adds and already installs a set list of packages that are normally useful for the course
   
            

##DESCRIPTION:

`FullTemplate.tex` is the file in which you should be writing into.

The content of this template is as follows

1. It contains an answer sheet that is automatically updated (It needs two passes of `xelatex` to show up correctly, using `latexmk` this is done automatically).
2. Then it includes the coverpages
3. Then it contains the start of the exam

    - It contains an example of a multiplechoice section, how different questions can be placed

    - And an example of short answer questions.

