%!TEX TS-program = xelatex
%!TEX encoding = UTF-8 Unicode


%Made by Alejandro Gonzalez Recuenco, 2017
% Do not share outside of BFITS
% e-mail safale93@gmail.com

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{skrexam}[2017/06/15 Exam Class With School Format]

\DeclareOption{flushbottom}{%
\flushbottom%
}%
\DeclareOption{noquestionbreak}{%
\widowpenalties 1 10000%Prevents breaking of a question over two pages in multiple choice
}
\PassOptionsToClass{12pt, a4paper}{exam}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{exam}}
 % All other options provided  to skrexam are dumped in the exam class
\ProcessOptions\relax

\LoadClass{exam}


\RequirePackage[a4paper, margin = 2cm, headsep = .5cm, headheight=50pt, twoside]{geometry}
%Add showframe for debugging and seeing the frame
\RequirePackage[main = english, thai]{babel}
\RequirePackage{amssymb,amsmath,amsthm,amsfonts} 
\RequirePackage{xstring} %Detect if something is integer\IfInteger
\RequirePackage{tasks} 
\RequirePackage{forloop}
\RequirePackage{totcount} % Package to count number of short answers
\RequirePackage{tikz}

\RequirePackage[no-math]{fontspec} 
\RequirePackage{xunicode} 
\RequirePackage{xltxtra} 



\def\scale{1.4}

\XeTeXlinebreaklocale "th"
\XeTeXlinebreakskip = 0pt plus 1pt   %


\setmainfont[%
    Path=Fonts/,
    Scale=\scale, %
    BoldFont={THSarabun Bold.ttf},%
    ItalicFont={THSarabun Italic.ttf},%
    BoldItalicFont={THSarabun Bold Italic.ttf}%
    ]{THSarabun}  
 \setsansfont[%
    Path=Fonts/,
    Scale=\scale, %
    BoldFont={THSarabun Bold.ttf},%
    ItalicFont={THSarabun Italic.ttf},%
    BoldItalicFont={THSarabun Bold Italic.ttf}%
    ]{THSarabun}  
 \setmonofont[%
    Path=Fonts/,
    Scale=\scale, %
    BoldFont={THSarabun Bold.ttf},%
    ItalicFont={THSarabun Italic.ttf},%
    BoldItalicFont={THSarabun Bold Italic.ttf}%
    ]{THSarabun}  

%\setmathsfont(Digits){TH Sarabun New}

% nummultiplechoice: 	holds only multiplechoice
% numshortanswer: 	holds only number of short answer
% questionnumber: 	holds the total question number, independantly of the order or anything

\newtotcounter{questionnumber}
\newtotcounter{nummultiplechoice}
%\setcounter{questionnumber}{0}

\newtotcounter{numshortanswer}
%\setcounter{numshortanswer}{0}


\renewenvironment{questions}{%
\renewcommand{\labelitemi}{\arabic{item}}%
  \begin{itemize}%
  \newcommand\question{%
     \refstepcounter{questionnumber}\stepcounter{nummultiplechoice}\item[\thequestionnumber]%
  }%
}{%
  \end{itemize}%
}


\newenvironment{shortanswers}{%
\renewcommand{\labelitemi}{\arabic{item}}%
  \begin{itemize}%
  \newcommand\question{%
     \refstepcounter{questionnumber}\stepcounter{numshortanswer}\item[\thequestionnumber]%
  }%
}{%
  \end{itemize}%
}


\newcommand\CorrectChoice{\relax} %Just a tag, when exam is created it should generate nothing
\RenewTasks[
	label-format = \bfseries,
	counter-format = {tsk[1].},
	item-indent = 3em,
	label-offset = 1em,
	label-align = left,
	after-item-skip = 3pt plus 2em
	]{choices}[\choice](2)

%\makeatletter
\newcommand\noheadingbreakpar{\par\nobreak\@afterheading}
%\makeatother

\newlength{\beforechoicessep}
\setlength{\beforechoicessep}{4mm}

\newlength{\afterchoicessep}
\setlength{\afterchoicessep}{4mm}

\BeforeBeginEnvironment{choices}{\noheadingbreakpar\minipage{\linewidth}\vspace{\beforechoicessep}}
\AfterEndEnvironment{choices}{\vspace{\afterchoicessep}\endminipage\par}




%% Answer sheet at the start 
 %Answer sheet standard
 \newcommand{\answersheetrow}[1][10]{%
 	\begin{tikzpicture}[font=\small, x = 1cm, y = 1cm,
						every node/.style={font=\footnotesize, inner sep = 0.2cm}, baseline = 0]%
		\pgfmathsetmacro{\bubblehsep}{0.2cm}%
		\pgfmathsetmacro{\ylineskip}{1cm}%
		\pgfmathsetlengthmacro{\bubbler}{0.2cm}% measured from center
		\foreach \line in {1,...,#1} {%
			\stepcounter{qnum}%
        	\begin{scope}[yshift = -\line * \ylineskip]%
				\node at (0,0) {\textbf{\theqnum}};%
				\foreach \count/\thecount/\thaicount in {1/a/๑, 2/b/๒, 3/c/๓, 4/d/๔} { %
					\draw ({\count * (2 * \bubbler + \bubblehsep)-\bubbler }, -\bubbler) rectangle ++(2*\bubbler, 2*\bubbler) node[pos = 0.5, label =\thecount] {} node[pos = 0.5, text height = \bubbler, text depth = 0.1ex]{\thaicount};

				}% close foreach
			\end{scope}%
		}% close foreach
	\end{tikzpicture}%
}

\newcommand{\fullanswersheet}[2][10]{%
\newcounter{qnum}%
\setcounter{qnum}{0}%
\pgfmathtruncatemacro{\nrows}{#2 / max(#1,1)}%
\ifnum\nrows>0\relax%
	\foreach \tenquestion in {1,...,\nrows}{%
		\answersheetrow[#1]~%
		%~\answersheetrow[5]~\answersheetrow~\answersheetrow~\answersheetrow
      		}%
\fi%
\pgfmathtruncatemacro{\nlast}{#2-\nrows*#1}%
\ifnum\nlast>0\relax%
	\answersheetrow[\nlast]%
\fi%
}


%\makeatletter
\newcommand\totalvalue[1]{%
\ifnum\value{#1@totc}=-1 0% 
\else%
	\number\value{#1@totc}%
\fi%
}
%\makeatother



\newcommand\ShortAnswerSheetQuestion{%
	Question \theshortanswer:\par%
}

 % Answer sheets
 	% nummultiplechoice: 	holds only multiplechoice
	% numshortanswer: 	holds only number of short answer
	% questionnumber: 	holds the total question number, independantly of the order or anything
	% Commads ->
	%\fullanswersheet[<questions per column>]{<number of columns>}
	%\shortanswersheet[<shoranswerspace(length)>]{<totcounter shortanswer>}{<totcounter previous>}	
\newcommand*\shortanswersheet[3][9cm]{%
% #1: length of fill with dotted lines
% #2: totcounter with number of short answer questions
% #3: totounter with number of questions before the start of short answer. i.e., If the number is 30, it starts at 31
\newcounter{X}%
\newcounter{shortanswer}%
\setcounter{X}{\totalvalue{#2}}%
\setcounter{shortanswer}{\totalvalue{#3}}%
\vspace{1em}
% Short Answers: X is \theX Y is \theY  and we have \numquestions and as ewll \thenumshortanswer%
\forloop[-1]{X}{\value{X}}{\value{X}>0}{%
	\par\noindent\stepcounter{shortanswer}%
	\ShortAnswerSheetQuestion%This command should have the question blablabla thingy
	 \fillwithdottedlines{#1}% 
}%
}


\renewcommand\thesection{Part \Roman{section}.}
\renewcommand{\thequestionnumber}{\arabic{questionnumber}.}
\renewcommand{\thechoice}{\ReadCounterPattern[tasks]{tsk}}  %\thechoice holds the number of the choice number in the choice environment when using it as a tasks environment... this command is here to keep the latex syntax consistent in the document





%<Math Style>%

%\everymath{\displaystyle}
%\DeclareMathSizes{11}{11}{11}{11}  %Math sizing
%</Math Style>%



