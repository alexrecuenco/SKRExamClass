%!TEX TS-program = xelatex
 %!TEX encoding = UTF-8 Unicode


%Made by Alejandro Gonzalez Recuenco, 2017
% Do not share outside of BFITS
% e-mail safale93@gmail.com
% Options for the class:
% systemfonts: If this option is activated it tries to find the fonts for SKR on the system fonts, under the name THH SarabunPSK. Otherwise it will try to find the fonts in the local path Fonts/ with the name THSarabun.
% flushbottom: Self explanatory
% noquestionbreak: Prevents breaks after question and before choices, and prevent any break between paragraphs as a side effect. The whole chunk will be flushed out to the enxt page if it is needed.
% The shortanswer environment works 
%
% v 0.2:
% 	Added support to provide options to exam when in skrexam
%	Improved stability of shortanswers environment
%	Added option to switch between using the fonts in a folder called 
%		Fonts/ In the current path (default behaviour)
%		Or using system fonts installed with the required name 
%			(Add the option systemfonts for this)
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{skrexam}[2017/06/20 Exam Class With SKR School Format]

\newif\ifcoverpagefont
\coverpagefontfalse

\newif\ifflushbottom
\flushbottomfalse

\newif\ifnoquestionbreak
\noquestionbreakfalse


\newcommand*\skr@angs@fontpath{Path=Fonts/,}%
\newcommand*\skr@angs@font{Angsa.TTF}
\newcommand*\skr@angs@boldfont{Angsa Bold.TTF}
\newcommand*\skr@angs@italicfont{Angsa Bold Italic.TTF}
\newcommand*\skr@angs@bolditalicfont{Angsa Italic.TTF}

\newcommand*\skr@fontpath{Path=Fonts/,}%
\newcommand*\skr@font{THSarabun}
\newcommand*\skr@boldfont{THSarabun Bold.ttf}
\newcommand*\skr@italicfont{THSarabun Italic.ttf}
\newcommand*\skr@bolditalicfont{THSarabun Bold Italic.ttf}


\DeclareOption{systemfonts}{%
\renewcommand*\skr@fontpath{}
\renewcommand*\skr@font{TH SarabunPSK}
\renewcommand*\skr@boldfont{TH SarabunPSK Bold}
\renewcommand*\skr@italicfont{TH SarabunPSK Italic}
\renewcommand*\skr@bolditalicfont{TH SarabunPSK Bold Italic}
}%	

\DeclareOption{flushbottom}{%
\flushbottomtrue%
}%

\DeclareOption{noquestionbreak}{%
\noquestionbreaktrue%
}

\DeclareOption{coverpagefont}{%
\coverpagefonttrue%
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
\RequirePackage{xparse}
	\usetikzlibrary{calc}
\ifflushbottom%
	\flushbottom%
\else%
\fi%

\ifnoquestionbreak
\widowpenalties 1 10000%Prevents breaking of a question over two pages in multiple choice
\else%
\fi


%Setting fonts


\def\scale{1.4}

\XeTeXlinebreaklocale "th"
\XeTeXlinebreakskip = 0pt plus 1pt   %


\setmainfont[%
	\skr@fontpath%
	Scale=\scale,%
	BoldFont={\skr@boldfont},%
	ItalicFont={\skr@italicfont},% 
 BoldItalicFont={\skr@bolditalicfont}%
 ]{\skr@font}  
 \setsansfont[%
	\skr@fontpath%
	Scale=\scale,%
	BoldFont={\skr@boldfont},%
	ItalicFont={\skr@italicfont},% 
 BoldItalicFont={\skr@bolditalicfont}%
 ]{\skr@font}  
 \setmonofont[%
	\skr@fontpath%
	Scale=\scale,%
	BoldFont={\skr@boldfont},%
	ItalicFont={\skr@italicfont},% 
 BoldItalicFont={\skr@bolditalicfont}%
 ]{\skr@font}  



\ifcoverpagefont
\newcommand*\scale@angs{1.5}
\newfontfamily\coverpagefont[%
	\skr@angs@fontpath%
	Scale=\scale@angs,%
	BoldFont={\skr@angs@boldfont},%
	ItalicFont={\skr@angs@italicfont},% 
 BoldItalicFont={\skr@angs@bolditalicfont}%
 ]{\skr@angs@font}
\else
\newcommand*\coverpagefont{\normalfont}
\fi



%============================================================================================%
% Set up for cover pages,

\newcommand\asteriskfill{\noindent\leavevmode\xleaders\hbox{$\ast\ $}\hfill\kern0pt}



%Filling information

\newcommand*\ExamName{}
\newcommand*\ExamNameTH{}
\newcommand*\AcademicYear{}
\newcommand*\AcademicYearTH{}
\newcommand*\GradeLevel{}
\newcommand*\GradeLevelTH{}
\newcommand*\Subject{}
\newcommand*\SubjectTH{}
\newcommand*\Code{}
\newcommand*\CodeTH{}
\newcommand*\Time{}
\newcommand*\TimeTH{}
\newcommand*\Score{}
\newcommand*\ScoreTH{}
\newcommand*\HeaderClassTH{}


%English Cover page

\newcommand*\FullExamLine{%
	\ExamName\hfill%
	Academic Year: \AcademicYear\hfill%
	Grade Level: \GradeLevel}
\newcommand*\SubjectExamLine{%
	Subject: \Subject \hfill%
	Code: \Code\hfill%
	Time: \Time\hfill%
	Score: \Score}
\newcommand*\FillNameLine{%
	Name:\hrulefill\ %
	Nickname:\hrulefill\ %
	Class:\hrulefill\ %
	Number:\hrulefill}

\newcommand*\EnglishDescription{
	\noindent%
	\FullExamLine\linebreak%
	\SubjectExamLine\linebreak%
	\FillNameLine%
	
	\asteriskfill%
	}

%Thai cover page 
\newcommand*\AcademicYearTHDescription{ปีการศึกษา}
\newcommand*\GradeLevelTHDescription{ชั้นมัธยมศึกษาปีที่}
\newcommand*\SubjectTHDescription{วิชา}
\newcommand*\CodeTHDescription{รหัสวิชา}
\newcommand*\TimeTHDescription{เวลา}
\newcommand*\ScoreTHDescription{คะแนนเต็ม}

\newcommand*\FullExamTHLine{%
	\ExamNameTH\hfill%
	\AcademicYearTHDescription\ \AcademicYearTH\hfill%
	\GradeLevelTHDescription\ \GradeLevelTH}
\newcommand*\SubjectExamTHLine{%
	\SubjectTHDescription\ \SubjectTH\hfill%
	\CodeTHDescription\ \CodeTH\hfill%
	\TimeTHDescription\ \TimeTH\hfill%
	\ScoreTHDescription\ \ScoreTH}
\newcommand*\FillNameTHLine{%
	ชื่อ-นามสกุล\hrulefill\  %
	ห้อง\hrulefill\  %
	เลขที่\hrulefill\  %
	ห้องสอบเลขที่\hrulefill}

\newcommand*\ThaiDescription{
	\noindent%
	\FullExamTHLine\linebreak%
	\SubjectExamTHLine\linebreak%
	\FillNameTHLine\linebreak%
	
	\asteriskfill%
	}


% Header Exam
\newcommand*\HeaderClassTHDescription{ห้อง ม.}
\newcommand*\PageTHDescription{หน้า}

\newcommand*\HeaderDescription{\ExamNameTH\ \AcademicYearTHDescription\ \AcademicYearTH\ \SubjectTHDescription\ \SubjectTH \CodeTHDescription\ \Code\ \HeaderClassTHDescription \HeaderClassTH \PageTHDescription\ \thepage}


%\setmathsfont(Digits){TH Sarabun New}

% nummultiplechoice: 	holds only multiplechoice
% numshortanswer: 	holds only number of short answer
% questionnumber: 	holds the total question number, independantly of the order or anything

\newtotcounter{questionnumber}
\newtotcounter{nummultiplechoice}
%\setcounter{questionnumber}{0}

\newtotcounter{numshortanswer}
%\setcounter{numshortanswer}{0}

\let\oldquestions\questions
\let\oldendquestions\endquestions

%\renewenvironment{questions}{%
%%\renewcommand{\labelitemi}{\arabic{item}}%
%\begin{oldquestions}%
%\setcounter{question}{\value{questionnumber}}%
%  \begin{itemize}%
%  \newcommand\question{%
%     \refstepcounter{questionnumber}\stepcounter{nummultiplechoice}\item[\thequestionnumber]%
%  }%
%}{%
%  \end{itemize}%
%}


\renewenvironment{questions}{%
\begin{oldquestions}%
\setcounter{question}{\value{questionnumber}}%
  \let\oldquestion\question%
  \def\question{%
     \refstepcounter{questionnumber}\stepcounter{nummultiplechoice}\oldquestion%
  }%
}{%
  \end{oldquestions}%
}
\newenvironment{shortanswers}{%
\begin{oldquestions}%
\setcounter{question}{\value{questionnumber}}%
  \let\oldquestion\question
  \def\question{%
     \refstepcounter{questionnumber}\stepcounter{numshortanswer}\oldquestion%
  }%
}{%
  \end{oldquestions}%
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
\setlength{\beforechoicessep}{1mm}

\newlength{\afterchoicessep}
\setlength{\afterchoicessep}{4mm}

\BeforeBeginEnvironment{choices}{\noheadingbreakpar\minipage{\linewidth}\vspace{\beforechoicessep}}
\AfterEndEnvironment{choices}{\vspace{\afterchoicessep}\endminipage\par}

\AfterEndEnvironment{coverpages}{\setcounter{page}{2}}

\BeforeBeginEnvironment{coverpages}{}

\newcommand\ShortAnswerSheetQuestion{%
	Question \theloop@shortanswer:\par%
}


\setlength\dottedlinefillheight{1cm}
\newlength\newdottedlineheight
\setlength\newdottedlineheight{0.6cm}


\newcounter{q@num}%
\newcounter{loop@X}
\newcounter{loop@shortanswer}
\newcounter{loop@Y}

%% Answer sheet at the start 
 %Answer sheet standard
 \newcommand{\answersheetrow}[1][10]{%
 	\begin{tikzpicture}[font=\small, x = 1cm, y = 1cm,
						every node/.style={font=\footnotesize, inner sep = 0.2cm}, baseline = 0]%
		\pgfmathsetmacro{\bubblehsep}{0.2cm}%
		\pgfmathsetmacro{\ylineskip}{1cm}%
		\pgfmathsetlengthmacro{\bubbler}{0.2cm}% measured from center
		\foreach \line in {1,...,#1} {%
			\stepcounter{q@num}%
        	\begin{scope}[yshift = -\line * \ylineskip]%
				\node at (0,0) {\textbf{\theq@num}};%
				\foreach \count/\thecount/\thaicount in {1/a/๑, 2/b/๒, 3/c/๓, 4/d/๔} { %
					\draw ({\count * (2 * \bubbler + \bubblehsep)-\bubbler }, -\bubbler) rectangle ++(2*\bubbler, 2*\bubbler) node[pos = 0.5, label =\thecount] {} node[pos = 0.5, text height = \bubbler, text depth = 0.1ex]{\thaicount};

				}% close foreach
			\end{scope}%
		}% close foreach
	\end{tikzpicture}%
}

\DeclareDocumentCommand{\fullanswersheet}{O{10} O{0} m}{%
\setcounter{q@num}{#2}%
\pgfmathtruncatemacro{\ntotal}{#3}%
\pgfmathtruncatemacro{\nrows}{\ntotal / max(#1,1)}%
\ifnum\nrows>0\relax%
	\foreach \tenquestion in {1,...,\nrows}{%
		\answersheetrow[#1]~%
		%~\answersheetrow[5]~\answersheetrow~\answersheetrow~\answersheetrow
      		}%
\fi%
\pgfmathtruncatemacro{\nlast}{\ntotal-\nrows*#1}%
\ifnum\nlast>0\relax%
	\answersheetrow[\nlast]%
\fi%
}
%\newcommand{\fullanswersheet}[2][10]{%
%\newcounter{qnum}%
%\setcounter{qnum}{0}%
%\pgfmathtruncatemacro{\nrows}{#2 / max(#1,1)}%
%\ifnum\nrows>0\relax%
%	\foreach \tenquestion in {1,...,\nrows}{%
%		\answersheetrow[#1]~%
%		%~\answersheetrow[5]~\answersheetrow~\answersheetrow~\answersheetrow
%      		}%
%\fi%
%\pgfmathtruncatemacro{\nlast}{#2-\nrows*#1}%
%\ifnum\nlast>0\relax%
%	\answersheetrow[\nlast]%
%\fi%
%}


%\makeatletter
\newcommand\totalvalue[1]{%
\ifnum\value{#1@totc}=-1 1% 1 if the value is not determined yet, otherwise it breaks things
\else%
	\number\value{#1@totc}%
\fi%
}
%\makeatother


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
\setcounter{loop@X}{\totalvalue{#2}}%
\setcounter{loop@shortanswer}{\totalvalue{#3}}%
\vspace{1em}%
% Short Answers: X is \theX Y is \theY  and we have \numquestions and as ewll \thenumshortanswer%
\forloop[-1]{loop@X}{\value{loop@X}}{\value{loop@X}>0}{%
	\par\noindent\stepcounter{loop@shortanswer}%
	\ShortAnswerSheetQuestion%This command should have the question blablabla thingy
	 \fillwithdottedlines{#1}% 
}%
}

%\newcommand*\UnbreakableShortAnswerSheet[3][7cm]{%
%% #1: length of fill with dotted lines
%% #2: totcounter with number of short answer questions
%% #3: totounter with number of questions before the start of short answer. i.e., If the number is 30, it starts at 31
%\let\@openitem\minipage
%\let\@closeitem\relax
%\pgfmathtruncatemacro\@X@totalvalue{#2}%
%\pgfmathtruncatemacro\@shortanswer@startvalue{#3}%
%\setcounter{loop@X}{\@X@totalvalue}%
%\setcounter{loop@shortanswer}{\@shortanswer@startvalue}%
%\vspace{1em}%
%% Short Answers: X is \theX Y is \theY  and we have \numquestions and as ewll \thenumshortanswer%
%\begin{enumerate}%
%\setcounter{enumi}{\@shortanswer@startvalue}%
%\forloop[-1]{loop@X}{\value{loop@X}}{\value{loop@X}>0}{%
%	\@closeitem
%	\minipage{\textwidth}
%	\item \dotfill\vspace{-0.7em}%
%		\fillwithdottedlines{#1}%
%	\let\@closeitem\endminipage%
%	\par%
%}%
%\@closeitem%
%\end{enumerate}%
%}


\newcommand*\UnbreakableShortAnswerSheet[3][5]{%
% #1: length of fill with dotted lines
% #2: number of short answer questions
% #3: number of questions before the start of short answer. i.e., If the number is 30, it starts at 31
\pgfmathtruncatemacro\@X@totalvalue{#2}
\pgfmathtruncatemacro\@Y@value{#1}
\pgfmathtruncatemacro\@shortanswer@startvalue{#3}
\setcounter{loop@X}{\@X@totalvalue}%
\setcounter{loop@Y}{\@Y@value}
%\edef\@shortanswer@totalvalue{\totalvalue{#3}}
% Short Answers: X is \theX Y is \theY  and we have \numquestions and as ewll \thenumshortanswer%
\vspace{1em}%
\begin{enumerate}%
\let\@closeitem\relax
\def\unbreakableitem{\@closeitem\item\minipage[t]{\textwidth}\let\@closeitem\endminipage}
\setcounter{enumi}{\@shortanswer@startvalue}
\forloop[-1]{loop@X}{\value{loop@X}}{\value{loop@X}>0}{%
	\unbreakableitem \dotfill\vspace{\newdottedlineheight}%
	\forloop[-1]{loop@Y}{#1}{\value{loop@Y}>0}{%
	\newline\vspace{\newdottedlineheight}\mbox{}\dotfill%
	} %
}%
\@closeitem
\end{enumerate}%
}

\newcommand*\ShortAnswerSheet[3][5]{%
% #1: length of fill with dotted lines
% #2: number of short answer questions
% #3: number of questions before the start of short answer. i.e., If the number is 30, it starts at 31
\pgfmathtruncatemacro\@X@totalvalue{#2}
\pgfmathtruncatemacro\@Y@value{#1}
\pgfmathtruncatemacro\@shortanswer@startvalue{#3}
\setcounter{loop@X}{\@X@totalvalue}%
\setcounter{loop@Y}{\@Y@value}
%\edef\@shortanswer@totalvalue{\totalvalue{#3}}
% Short Answers: X is \theX Y is \theY  and we have \numquestions and as ewll \thenumshortanswer%
\vspace{1em}%
\begin{enumerate}%
\setcounter{enumi}{\@shortanswer@startvalue}
\forloop[-1]{loop@X}{\value{loop@X}}{\value{loop@X}>0}{%
	\item \dotfill\vspace{\newdottedlineheight}%
	\forloop[-1]{loop@Y}{#1}{\value{loop@Y}>0}{%
	\newline\vspace{\newdottedlineheight}\mbox{}\dotfill%
	} %
}%
\end{enumerate}%
}

\DeclareDocumentCommand{\MultipleChoiceAnswerSheet}{O{10} O{0} m  O{4}}{%
% #1: nrows, nquestions per row
% #2: ntotal questions
% #3: starting value of counter
% #4: sidelength of squares, in fifths of a cm
\begin{tikzpicture}
\pgfmathtruncatemacro{\nrows}{#1}%
\pgfmathtruncatemacro\startingvalue{#2}
\pgfmathtruncatemacro\@nmultiplechoice{#3}
\pgfmathsetmacro{\sidelength}{#4}
\pgfmathtruncatemacro\maxvaluequestionnumber{\@nmultiplechoice+\startingvalue+1}
\pgfmathtruncatemacro{\ncols}{ceil(\@nmultiplechoice/\nrows)}%
\foreach \colnumber in {1,...,\ncols}{
	\path ({(\colnumber - 1)*\sidelength},0) coordinate (start col);
	\path ($(start col) +(\sidelength/5,0)$) coordinate (start draw);
	\fill[draw = black] (start col) rectangle ++(\sidelength/5,-\sidelength/5);
	\draw (start draw) rectangle ++(\sidelength/5,-\sidelength/5)
		node[pos = 0.5] {1.}
		rectangle ++(\sidelength/5,\sidelength/5)
		node[pos = 0.5] {2.}
		rectangle ++(\sidelength/5,-\sidelength/5)
		node[pos = 0.5] {3.}
		rectangle ++(\sidelength/5,\sidelength/5)
		node[pos = 0.5] {4.};
	
	\path (start col) coordinate (start row);
	\foreach \rownumber in {1,...,\nrows}{
		\pgfmathtruncatemacro{\questionnumber}{(\colnumber-1)*\nrows + \rownumber + \startingvalue}
		\path ($(start row) +(0,-\sidelength/5)$) coordinate (start row);
		\draw (start row) rectangle ++(\sidelength/5,-\sidelength/5)%
				node[pos = 0.5] (number) {}%
			rectangle ++(\sidelength/5,\sidelength/5)
			rectangle ++(\sidelength/5,-\sidelength/5)
			rectangle ++(\sidelength/5,\sidelength/5)
			rectangle ++(\sidelength/5,-\sidelength/5);
		\ifnum\questionnumber<\maxvaluequestionnumber\relax%
			\node at (number)  {\questionnumber};
		\else
			\fill[gray] (number) +(-\sidelength/10,-\sidelength/10)
				rectangle +(\sidelength/10,\sidelength/10);
		\fi
	};
};
\end{tikzpicture}%
}

% Down here how to label different things, note that \thechoice can't be change to rename the 1. 2. 3. 4. in the choices environment. 
%To modify the label of the choices environemnt, renewing the environment is required:
%\RenewTasks[
%	label-format = \bfseries,
%	counter-format = {tsk[1].},
%	item-indent = 3em,
%	label-offset = 1em,
%	label-align = left,
%	after-item-skip = 3pt plus 2em
%	]{choices}[\choice](2)


\renewcommand\thesection{Part \Roman{section}.}
%\renewcommand{\thequestionnumber}{\arabic{questionnumber}.}
\renewcommand{\thequestion}{\arabic{question}}
\renewcommand\questionlabel{\thequestion.}
\renewcommand{\thechoice}{\ReadCounterPattern[tasks]{tsk}}  %\thechoice holds the number of the choice number in the choice environment when using it as a tasks environment... this command is here to keep the latex syntax consistent in the document





%<Math Style>%

%\everymath{\displaystyle}
%\DeclareMathSizes{11}{11}{11}{11}  %Math sizing
%</Math Style>%



