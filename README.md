# SKRExamClass
Custom Class Design for SKR.

It requires the use of `xelatex` for compilation. Using `latexmk` you can use the option `-xelatex`

```bash
latexmk -xelatex
```

The intention of this class is to provide an "easy-to-use" template to generate exams automatically. Generating automatically the answer sheets for the students.

The templates provide examples of how this answer sheets 

## File structure
Most of these templates require the following structure:

``` 
    - skrexam.cls
    - ExamFolder/
      |
      | - - Fonts/
      |
      | - - images/
      |
      | Exam.tex
```

Although with the newer version, using the option `customfontpath=../Fonts/` it can be changed to

``` 
    - skrexam.cls
    - Fonts/
    - images/
    - ExamFolder/
      |
      | - - images/
      |
      | Exam.tex
```

Which looks a lot cleaner


Using a folder structure, isntead of explaining how to install a class file on latex provides an easier time for people using ShareLaTeX and other platforms. 

- The `images/` folder can be changed by using the `\ graphicspath` command on the templates:

    ```latex
    \graphicspath{{images/}{newsubdir1/}{newsubdir2/}}
    ```
- The skrexam class can be placed in another relative file location by changing the documentclass line in the template:

    ```latex
    \documentclass{../skrexam} 
    ```

    Instead, specify the new location, or if you installed the class file in your latex installation, use 
    
    ```latex
    \documentclass{skrexam} 
    ```

## Templates


There are two types of templates provided in this folder. Midterm and "informal" templates.

   
### Midterm templates.

The midterm templates are based on the school requirements as of 2017. 

These templates provide the needed functionality to update names both in Thai and English of the subject requirements. They are listed at the start of the template


### Informal templates

These templates are provided to function on a less formal type of exam. They don't have any type of Thai text on them.


    
 
 
# Description of the options for the class  


## General options

This options can be declared in the `\documentclass[...]{skrexam}` options at the start of the document

1. `systemfonts` If this option is activated, it tries to find the fonts for SKR on the system fonts, under the name "SarabunPSK". This option currently is fairly unstable.

    If this option is not provided it will try to find the fonts in the local path `Fonts/`
2. `flushbottom` Self-explanatory, flushes the page to the bottom by increasing spaces.
3. `noquestionbreak` Prevents breaks after a question and before the choices of that question. As a side effect, it prevents breaks between paragraphs as well. If the whole quesiton doesn't fit at the end of the line, it will be flushed to the next apge.
4. `customfontpath=<new path>` Instead of searching in the local path `Fonts/` for the fonts, you can provide a custom path.

    This option is very useful when you are going to create multiple exams. You place each exam in a folder, and you place an outer folder with the fonts like this:
    
    ``` 
    MainFolder
     |
     | - skrexam.cls
     | - Fonts/
     | - images/
     |
     | - Exam1/exam1.tex
     | - Exam2/exam2.tex
    ``` 
    
    And in each exam you use the option `customfontpath=../Fonts/`. That way you need to keep only one copy of the fonts.


## Environments

This are the environments relevant to creating an exam using this class

### questions

Use

```latex
\begin{questions}
    \question Question text
    \question Question text for second question, maybe an image
    ...
\end{questions}
```

Each question counts towards the `nummultiplechoice` count.

### choices

Use 

```latex
\begin{questions}
    \question Question text
    \begin{choices}(2)
        \choice Choice 1
        \choice Choice 2
        \choice Choice 3
        \choice Choice 4
    \end{choices}
    
    \question Question text for second question, maybe an image
    \begin{choices}(1)
        \choice Long choice that i want Choice 1
        \choice Long choice that i want Choice 2
        \choice Long choice that i want Choice 3
        \choice Long choice that i want Choice 4
    \end{choices}
     ...
\end{questions}
```
The number in parenthesis identifies the number of columns. The default value is 2 if it is not written.

It is recommended to write a command that does nothing but identifies the correct choice. Using the exam class "standard" I use `\CorrectChoice`. (If you use a program like TexExamRandomizer, this can be used to identify the correct answer and generate answer sheets automatically)

_NOTE that there can't be anything between the number in parenthesis and the first `\choice` command. In fact, you shouldn't have either an empty line... (That is related to the way the task package works)_ 


### shortanswersheet

Use 

```latex
\begin{shortanswersheet}
    \question Question text
    \question Question text for second question, maybe an image
    ...
\end{shortanswersheet}
```

It works identically to a `questions` environment. However each question is counted in the counter `numshortanswer`.
##Commands
 
### Generating an answer sheet automatically

The commands that are used to generate the answer sheets are:


```latex
\MultipleChoiceAnswerSheet[<c>]{<nquestion>}[<nchoices>]
% c: Number of questions for each columnn. Default value is 10
% nquestion: Total number of questions
% nchoices: Total number of choices. Default value is 4
```

Alternatively, you can use the following command to generate the multiple choice answer sheet

```latex
\InformalAnswerSheet[<c>][<startq>]{<nquestions>}
% c: Numbe of questions per column. Default value is 10
% startq: Number of the first question minus one. 
%         i.e., If the first question is numbered "1", the value of starq should be 0.
%         Defaults to 0
% nquestions: Total number of questions.
% \fullanswersheet is a pseudonim of the same command... 
% but it will be deprecated in future versions
% the first name is used for compatibility purposes
```


It assumes that the short answer sheet comes AFTER the multiple choice answer sheet (Which is important for the numbering:

```latex
\ShortAnswerSheet[<nlines>]{<nshort>}{<nmultiple>}
% nlines: Number of lines. Default is 5
% nshortanswer: Number of short answers
% nmultiplechoice: Number of multiple choice questions.
% Using \UnbreakableShortAnswerSheet it prevents that ilnes for the same question are broken between lines
```


TODO: Add pictures of how all these answer sheets look.

###
## Counters

To count the total number of questions and sections, it uses the `totcount` package. This is the list of counters that are defined:

- `nummultiplechoice` Number of multiple choice questions (These are questions inside a `questions` environment)
- `questionnumber` Total number of questions.

- `numshortanswer` This is the number of shortanswer questions
- `totalpages`	Total number of pages of the document.

    This is obtained by writing at the end of the document
    
    ```latex
    \setcounter{totalpages}{\value{page}}
    ```
- `totalsections` Total number of sections

    This is obtained by writing at the end of the document
    
    ```latex
    \setcounter{totalpages}{\value{section}}
    ```


In addition to this counters, the following commands are defined at the start of the document storing the value of them, 



- `\ntotalquestions`: Total number of questions.
- `\nmultiplechoice`: Number of multiple choice questions (These are questions inside a `questions` environment)
- `\nshortanswer`: This is the number of shortanswer questions

_If they are not defined, it returns the value "1", to prevent breaking commands that depend on obtaining an integer number as a result_

For the advanced user:

They are defined using

```latex
\global\edef\nmultiplechoice{\totalvalue{nummultiplechoice}}
\global\edef\ntotalquestion{\totalvalue{questionnumber}}
\global\edef\nshortanswer{\totalvalue{numshortanswer}}
% \totalvalue is defined by the skrexam class.
% TODO: Add all of those inside a BeforeBeginDocument macro
```

Don't touch that, if you don't know what it is
