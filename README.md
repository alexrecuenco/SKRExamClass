# SKRExamClass
Custom Class Design for SKR.

The intention of this class is to provide an "easy-to-use" template to generate exams automatically.

It automatically creates a short-answer sheet.

It requires the use of `xelatex` for compilation

## File structure
All these templates require the following structure:

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

This folder structure prevents having to explain how to install a new class, and having to worry about different types of installations of fonts that in general are OS dependant.

- To change the location of the `Fonts/` folder, you should use the class option `customfontpath=<custompath>`
- The `images/` folder can be changed by using the `\ graphicspath` command

    ```latex
    \graphicspath{{images/}{subdir1/}{subdir2/}}
    ```
- The skrexam class can be installed in another location by changing the line in the template:

    ```latex
    \documentclass{../skrexam} 
    ```

    Instead, specify the new location, or if you install it adequactely in your system, simply 
    
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

This options can be declared in the options

##Commands
 
### Generating an answer sheet automatically

The commands that are used to generate the answer sheets are:


```latex
\MultipleChoiceAnswerSheet[<c>]{<nquestion>}[<nchoices>]
% c: Number of questions for each columnn. Default value is 10
% nquestion: Total number of questions
% nchoices: Total number of choices. Default value is 4
```

Alternatively, you can use the following command to generate the multiple chocie answer sheet

```latex
\fullanswersheet[<c>][<startq>]{<nquestions>}
% c: Numbe of questions per column. Default value is 10
% startq: Number of the first question minus one. i.e., if the first question is numbered "1", the value of starq should be 0.
%         Defaults to 0
% nquestions: Total number of questions.
%\MultipleChoiceAnswerSheetThai is a pseudonim of the same command... 
%the first name is used for compatibility purposes
```


It assumes that the short answer sheet comes AFTER the multiple choice answer sheet (Which is important for the numbering:

```latex
\ShortAnswerSheet[<nlines>]{<nshort>}{<nmultiple>}
% nlines: Number of lines
% nshortanswer: Number of short answers
% nmultiplechoice: Number of multiple choice questions.
```

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
