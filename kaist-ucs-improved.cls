% -*- TeX:UTF-8 -*-
%% KAIST Thesis Template for LaTeX
%%
%% @version      0.5
%% @releasedate  Apr 28th, 2007
%%
%% @author       Chae, Seugbyung 채승병
%%               mailto:chess@kaist.ac.kr
%%
%% @requirements
%%    current distribution of TeXLive
%%      + ko.TeX
%%
%% Karnes Kim, converted to ko.TeX version.
%%    2008/10/21
%%
%% Seokwoo Choi, modified according to the 2008 thesis format
%%    2008/12/29
%%
%% Jong Mun Lee, modified according to the 2010 thesis format
%% 2010/11/25
%% This revision was carried out with the support of the Graduate Student Council and the Academic Affairs Office.
%%
%% Jin Hyun Ahn, modified according to the 2016 thesis format
%% 2016/04/08
%% Modified at Professor Song Ik-ho's lab with the support of the Academic Affairs Office.
%% 2016/11/24
%% Min H. Kim, Professor at School of Computing, revised this template to fix several bugs, including the MS degree title in School of Computing, English date formats, etc.

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{kaist-ucs-improved}%
[2008/10/21 v0.4 Standard KAIST Thesis document class, ko.TeX version]

%% Declare boolean variables for option settings
\newif\if@isDoctor
\newif\if@isKorean
\newif\if@isFinal
\newif\if@PDFdoc\@PDFdocfalse
\newif\if@dvips\@dvipsfalse

%% New options collection - doctor|master, korean|english, final|draft
\DeclareOption{doctor} {\@isDoctortrue}
\DeclareOption{master} {\@isDoctorfalse}
\DeclareOption{korean} {\@isKoreantrue}
\DeclareOption{english} {\@isKoreanfalse}
\DeclareOption{final}  {\@isFinaltrue}
\DeclareOption{draft}  {\@isFinalfalse}
\DeclareOption{pdfdoc} {\@PDFdoctrue}
\DeclareOption{dvips}  {\@dvipstrue}

%% Pass the leqno, fleqn, openbib options directly to the report class
\DeclareOption{leqno}  {\PassOptionsToClass{leqno}  {report}}
\DeclareOption{fleqn}  {\PassOptionsToClass{fleqn}  {report}}
\DeclareOption{openbib}{\PassOptionsToClass{openbib}{report}}

\ExecuteOptions{doctor,korean,final}         % doctor, korean, final are default values
\ProcessOptions

%% Load the report class with options: 10pt, a4paper, onecolumn, oneside
\LoadClass[10pt,a4paper,onecolumn,oneside]{report}



%% Indentation
\usepackage{indentfirst}
\setlength\parindent{2.0em}

\RequirePackage{ifthen}       % Additional package settings

%%%% Hangul-ucs preamble.......
\RequirePackage[nonfrench]{dhucs}
%\RequirePackage[default]{dhucs-interword}
\RequirePackage{ifpdf}
\ifpdf
\def\@drivername{pdftex}
\else
\def\@drivername{dvipdfmx}
\fi
\if@dvips
\def\@drivername{dvips}
\fi

%\ifpdf
%  \input glyphtounicode\pdfgentounicode=1
%\fi

\RequirePackage[final,\@drivername]{graphicx} %HOCHEOL MODIFIED: This forces images to show up even with the draft option enabled
\RequirePackage{xcolor}
\usepackage{color}
\definecolor{cyan}{cmyk}{1,0,0,0}
\definecolor{darkgreen}{rgb}{0,0.5,0}
\definecolor{orange}{rgb}{1,0.5,0}
\definecolor{magenta}{cmyk}{0,1,0,0}
\definecolor{darkyellow}{cmyk}{0,0,0.75,0}
\definecolor{darkred}{rgb}{0.4,0,0}
\definecolor{darkgreen}{rgb}{0,0.25,0}
\definecolor{darkblue}{rgb}{0,0,0.55}
\definecolor{darkcyan}{cmyk}{0.75,0,0,0}
\definecolor{darkmagenta}{cmyk}{0,0.75,0,0}
\definecolor{darkyellow}{cmyk}{0,0,0.75,0}

\if@PDFdoc
\RequirePackage[unicode,%
\@drivername,%
bookmarks=true,%
colorlinks=true,%
linkcolor=darkred,      %red
anchorcolor=black,      %black
citecolor=darkgreen,        %green
filecolor=darkmagenta,      %magenta
menucolor=darkred,      %red
urlcolor=darkcyan,          %cyan
pdfpagelabels, %HOCHEOL MODIFIED
]{hyperref}
\else
\RequirePackage[unicode,%
\@drivername,%
bookmarks=false,%
colorlinks=false,%
colorlinks=true,    %remove square
linkcolor=darkred,      %red
anchorcolor=black,      %black
citecolor=darkgreen,        %green
filecolor=darkmagenta,      %magenta
menucolor=darkred,      %red
urlcolor=darkcyan,          %cyan
pdfpagelabels, %HOCHEOL MODIFIED
]{hyperref}
\fi


%% for compatability to HLaTeX
\let\gt\sffamily
\DeclareTextFontCommand{\textgt}{\gt}
%%%% end of Hangul-ucs preamble

\AtBeginDocument{%                           % Execute at \begin{document}
	\checkparameters                        % Check if document variables are correct
	\if@isFinal                             % If final option is set
	\makefrontcover \maketitle         % Generate front cover and inside cover
	\makeapproval                      % Generate submission approval and review approval forms
	\else \fi }
\AtEndDocument{}                             % Execute at \end{document}

%% Set the page margins for printing
\usepackage[left=25.4mm,right=25.4mm,top=30mm,bottom=25.4mm,a4paper]{geometry}


%% Set line spacing
%\renewcommand{\baselinestretch}{1.3}
\linespread{1.3}

%% Set whether the main text is in English or Korean
\newcommand{\@korean}{korean}
\newcommand{\@english}{english}
\newcommand{\@textlang}{}                    % Declare default text language variable
\if@isKorean                                 % If the korean option is set
\let\@textlang\@korean                  % Default text language is Korean
\else                                        % If the english option is set
\let\@textlang\@english                 % Default text language is English
\fi

%% KAIST official English name
\newcommand{\@kaist}{Korea Advanced Institute of Science and Technology}

%% pagestyle
\def\ps@kaist{\let\@mkboth\@gobbletwo
	\let\@oddhead\@empty
	\def\@oddfoot{\reset@font\hfil--\ \thepage\ --
		\hfil}%
	\let\@evenhead\@empty\let\@evenfoot\@oddfoot
}

\pagestyle{kaist}

%%
%% Define document information variables
%%

% @command title Thesis title
% @options [default: (none)]
% - korean: Korean title | english: English title
\renewcommand{\title}[2][korean] {%
	\ifthenelse{\equal{#1}{korean}}%
	{\newcommand{\@titleKor}{#2}}{}%
	\ifthenelse{\equal{#1}{english}}%
	{\newcommand{\@titleEng}{#2}}{}%
}
\@onlypreamble{\title}

% @command author Author name
% @param family_name, given_name Enter last name and first name separately
% @options [default: (none)]
% - korean: Korean name | chinese: Chinese name | english: English name
\renewcommand{\author}[3][korean] {%
	\ifthenelse{\equal{#1}{korean}}
	{\newcommand{\@authorKorFN}{#2}
		\newcommand{\@authorKorGN}{#3}
		\newcommand{\@authorKor}{#2\ #3}}{}%
	\ifthenelse{\equal{#1}{korean2}}
	{\newcommand{\@authorKorHN}{#2}
		\newcommand{\@authorKorIN}{#3}
		\newcommand{\@authorKorCont}{#2#3}}{}%
	\ifthenelse{\equal{#1}{chinese}}
	{\newcommand{\@authorChnFN}{#2}
		\newcommand{\@authorChnGN}{#3}
		\newcommand{\@authorChn}{#2\ #3}}{}%
	\ifthenelse{\equal{#1}{english}}
	{\newcommand{\@authorEngFN}{#2}
		\newcommand{\@authorEngGN}{#3}
		\newcommand{\@authorEng}{#2, #3}}{}%
}

\@onlypreamble{\author}

% @command advisor Advisor's name (multiple allowed)
% @options [default: major]
% - major: Main advisor  | coopr: Co-advisor (in case of joint advisors)
\newcommand{\advisor}[4][major]{%
	\ifthenelse{\equal{#1}{major}} {%       % If main advisor
		\newcommand{\@advisorMajorKor}{#2} % Save Korean name
		\newcommand{\@advisorMajorEng}{#3} % Save English name
		% If "nosign" is not specified, the main advisor is considered to have signed
		\ifthenelse{\equal{#4}{nosign}}{}{%
			\newcommand{\@advisorSigned}{\@advisorMajorEng}} }{}%
	\ifthenelse{\equal{#1}{major2}} {%       % If main advisor (alternative)
		\newcommand{\@advisorMajorKorCont}{#2} % Save Korean name
		\newcommand{\@advisorMajorEngCont}{#3} % Save English name
		% If "nosign" is not specified, the main advisor is considered to have signed
		\ifthenelse{\equal{#4}{nosign}}{}{%
			\newcommand{\@advisorSignedCont}{\@advisorMajorEngCont}} }{}%
	\ifthenelse{\equal{#1}{coopr}} {%       % If co-advisor
		\newcommand{\@advisorCooprKor}{#2} % Save Korean name
		\newcommand{\@advisorCooprEng}{#3} % Save English name
		% Co-advisor is considered to have signed only if "signed" is specified
		\ifthenelse{\equal{#4}{signed}}{%
			\newcommand{\@advisorSigned}{\@advisorCooprEng}}{} }{}%
	\ifthenelse{\equal{#1}{coopr2}} {%       % If co-advisor (alternative)
		\newcommand{\@advisorCooprKorCont}{#2} % Save Korean name
		\newcommand{\@advisorCooprEngCont}{#3} % Save English name
		% Co-advisor is considered to have signed only if "signed" is specified
		\ifthenelse{\equal{#4}{signed}}{%
			\newcommand{\@advisorSignedCont}{\@advisorCooprEngCont}}{} }{}%            
}
\@onlypreamble{\advisor}

%% Command for professor information on the submission approval form
\newcommand{\advisorinfo}[1]{\newcommand{\@advisorinfo}{#1}}

% @command department 
%
\newcommand{\@degreeCode}{}          % Degree English code
\newcommand{\@degreeName}{}          % Degree name
\newcommand{\@degreeversion}{}       % Department version
\newcommand{\@parentDeptNameKor}{}      % Department/Major, first line (Korean)
\newcommand{\@childDeptNameKor}{}       % Department/Major, second line (Korean)
\newcommand{\@parentDeptNameEng}{}      % Department/Major, first line (English)
\newcommand{\@childDeptNameEng}{}       % Department/Major, second line (English)
\newcommand{\@affFullNameKor}{}      % Full department/major name in Korean
\newcommand{\@affFullNameEng}{}      % Full department/major name in English
\newcommand{\@parentAcademNameEng}{} % Academic unit name, first line in English
\newcommand{\@childAcademNameEng}{} % Academic unit name, second line in English
\newcommand{\@appFullAcademName}{}
\newcommand{\@degreeField}{}
\newcommand{\@degreePrefix}{\ifthenelse{\boolean{@isDoctor}}{D}{M}}

% separate file for department names
\input{department_names}


% @command studentid Student ID
\newcommand{\studentid}[1]{\newcommand{\@studentID}{#1}}
\@onlypreamble{\studentid}

% @command referee Reviewer (3 for master's, 5 for doctoral)
\newcommand{\referee}[2][1] {%
	\ifthenelse{\equal{#1}{1}}{\newcommand{\@refereeChief} {#2}} {}%
	\ifthenelse{\equal{#1}{2}}{\newcommand{\@refereeSecond}{#2}} {}%
	\ifthenelse{\equal{#1}{3}}{\newcommand{\@refereeThird} {#2}} {}%
	\ifthenelse{\equal{#1}{4}}{\newcommand{\@refereeFourth}{#2}} {}%
	\ifthenelse{\equal{#1}{5}}{\newcommand{\@refereeFifth} {#2}} {}%
}
\@onlypreamble{\referee}

% @command approvaldate Advisor approval date for thesis
% @param year,month,day Enter year, month, day in order
\newcommand{\approvaldate}[3] {%
	\newcommand{\@approvalYear}{#1}
	\newcommand{\@approvalMonth}{#2}
	\newcommand{\@approvalDay}{#3}
}
\@onlypreamble{\approvaldate}

% @command refereedate Review date by the examiners
% @param year,month,day Enter year, month, day in order
\newcommand{\refereedate}[3] {%
	\newcommand{\@refereeYear}{#1}
	\newcommand{\@refereeMonth}{#2}
	\newcommand{\@refereeDay}{#3}
}
\@onlypreamble{\refereedate}

% @command gradyear Graduation year
\newcommand{\gradyear}[1]{\newcommand{\@gradYear}{#1}}
\@onlypreamble{\gradyear}

%%
%% Check if any necessary information is missing --> Under development. Still incomplete. Leave as is.
%%
\newcommand{\checkparameters}{%
	\@ifundefined{@titleKor}{%
		\ClassError{kaist}{The korean title is not found}{}}{}
	\@ifundefined{@titleEng}{%
		\ClassError{kaist}{The english title is not found}{}}{}
	\@ifundefined{@authorKor}{%
		\ClassError{kaist}{The korean name of the author is not found}{}}{}
	\@ifundefined{@authorChn}{%
		\ClassError{kaist}{The chinese name of the author is not found}{}}{}
	\@ifundefined{@authorEng}{%
		\ClassError{kaist}{The english name of the author is not found}{}}{}
	\@ifundefined{@advisorMajorKor}{%
		\ClassError{kaist}{The korean name of the major advisor is not found}{}}{}
	\@ifundefined{@advisorMajorEng}{%
		\ClassError{kaist}{The english name of the major advisor is not found}{}}{}
}

%%
%% Generate front cover
%% Don't change size of letters.
\newcommand{\makefrontcover}{%
	\renewcommand{\baselinestretch}{1.3}%
	\thispagestyle{empty} \noindent%
	\begin{minipage}[b][10mm][b]{\textwidth}
		\begin{center}
			\if@isDoctor
			\fontsize{17pt}{17pt}\selectfont{박 사 학 위 논 문}\\ \fontsize{15pt}{15pt}\selectfont{Ph.D. Dissertation}
			\else
			\fontsize{17pt}{17pt}\selectfont{석 사 학 위 논 문}\\ \fontsize{15pt}{15pt}\selectfont{Master's Thesis}
			\fi
		\end{center}
	\end{minipage}\\[40mm]
	\begin{minipage}[t][80mm][t]{\textwidth}
		\begin{center}
			\fontsize{21pt}{21pt}\selectfont  \@titleKor \\[21pt]
			\fontsize{18pt}{18pt}\selectfont  \@titleEng \\[18pt]
			\fontsize{18pt}{18pt}\selectfont \@gradYear 
		\end{center}
	\end{minipage}\\[40mm]
	\begin{minipage}[c][70mm][c]{\textwidth}
		\begin{center}
			\fontsize{20pt}{20pt}\selectfont
			\ifthenelse{\equal{\@authorChnFN}{}}
			{\@authorKor\  \hspace{0.5mm} \fontsize{18pt}{18pt}\selectfont  (\@authorEng) \\}
			{\@authorKor\  \hspace{0.5mm} \fontsize{18pt}{18pt}\selectfont   (\@authorChn\
				\@authorEng) \\}[25mm]
			\fontsize{20pt}{20pt}\selectfont 한 국 과 학 기 술 원 %%\\ \@affFullNameKor 
		\end{center}
	\end{minipage}\\[-5mm]
	\begin{minipage}[c][0mm][c]{\textwidth}
		\begin{center}
			%%\Large \@affFullNameEngCover\\ 
			\fontsize{18pt}{18pt}\selectfont \@kaist %% Don't write 'KAIST'. It must be full name.
		\end{center}
	\end{minipage} \newpage
	
}

%%
%% Generate inside cover
%% Don't change size of letters.
\renewcommand{\maketitle}{%
	\thispagestyle{empty} \noindent 
	\renewcommand{\baselinestretch}{1.3}%
	%
	\begin{minipage}[b][12mm][b]{\textwidth}
		\begin{center}
			\if@isDoctor
			\fontsize{17pt}{17pt}\selectfont{박 사 학 위 논 문}
			\else 
			\fontsize{17pt}{17pt}\selectfont{석 사 학 위 논 문}
			\fi
		\end{center}
	\end{minipage}\\[30mm]
	\begin{minipage}[t][70mm][t]{\textwidth}
		\begin{center}
			\fontsize{21pt}{21pt}\selectfont  \@titleKor \\[38pt]
			\fontsize{18pt}{18pt}\selectfont \@gradYear 
		\end{center}
	\end{minipage}\\[40mm]
	\begin{minipage}[c][85mm][c]{\textwidth}
		\begin{center}
			\fontsize{20pt}{20pt}\selectfont
			\ifthenelse{\equal{\@authorKorFN}{}}
			{\@authorEng\ (\@authorChn) \\}
			{\@authorKor\ \\}[27mm]
			%\ifthenelse{\equal{\@authorKorFN}{}}
			%{\@authorEng\ (\@authorChn) \\}
			%{\@authorKor\   (\@authorChn\ \
			%\@authorEng) \\}[7mm]
			한 국 과 학 기 술 원 \\[7mm] \@affFullNameKor
		\end{center}
	\end{minipage} \newpage  
} 

%%
%% Generate thesis review approval sheet and submission approval form
%% Don't change size of letters.
\newcommand{\makeapproval}{%% Thesis review approval sheet
	\thispagestyle{empty} \noindent
	\begin{minipage}[c][80mm][c]{\textwidth}
		\begin{center}
			\fontsize{21pt}{21pt}\selectfont \@titleKor \\          % Thesis title in Korean
		\end{center}
	\end{minipage}\\[-10mm]
	\begin{minipage}[c][0mm][c]{\textwidth}
		\begin{center}
			\fontsize{16pt}{16pt}\selectfont
			\ifthenelse{\equal{\@authorKorFN}{}}
			{\@authorEng}
			{\@authorKor}  % Author's Korean name
		\end{center}
	\end{minipage}\\[0mm]
	\begin{minipage}[c][60mm][c]{\textwidth}
		\begin{center}
			\fontsize{16pt}{16pt}\selectfont The thesis submitted to Korea Advanced Institute of Science and Technology
			\ifthenelse{\boolean{@isDoctor}}{as a Ph.D. dissertation}{as a Master's thesis}\linebreak
			has been approved by the thesis review committee.
		\end{center}
	\end{minipage}\\[13mm]
	\begin{minipage}[t][20mm][b]{\textwidth}
		\begin{center}
			%\fontsize{16pt}{16pt}\selectfont \@refereeYear 년 \@refereeMonth 월 \@refereeDay 일 
			%\begin{flushright}
			
			\begin{tabular}{rcl}
				% (e.g., TOC, LOT, LOF generation)
				\multicolumn{3}{c}{\fontsize{16pt}{16pt}\selectfont \@refereeYear 년 \@refereeMonth 월 \@refereeDay 일 }\mbox{\ }
				\@ifundefined{@refereeChief}{}
				{\\[30pt] \fontsize{16pt}{16pt}\selectfont심사위원장 & \ \makebox[\width][r]{\fontsize{16pt}{16pt}\selectfont\@refereeChief} & \ \makebox[\width][r]{\fontsize{16pt}{16pt}\selectfont (인)} }
				\@ifundefined{@refereeSecond}{}
				{\\[15pt] \fontsize{16pt}{16pt}\selectfont심 사 위 원   & \ \makebox[\width][r]{\fontsize{16pt}{16pt}\selectfont\@refereeSecond} & \ \makebox[\width][r]{\fontsize{16pt}{16pt}\selectfont (인)}}
				\@ifundefined{@refereeThird}{}
				{\\[15pt] \fontsize{16pt}{16pt}\selectfont심 사 위 원   & \ \makebox[\width][r]{\fontsize{16pt}{16pt}\selectfont\@refereeThird} & \ \makebox[\width][r]{\fontsize{16pt}{16pt}\selectfont (인)}}
				\@ifundefined{@refereeFourth}{}
				{\\[15pt] \fontsize{16pt}{16pt}\selectfont심 사 위 원   & \ \makebox[\width][r]{\fontsize{16pt}{16pt}\selectfont\@refereeFourth} & \ \makebox[\width][r]{\fontsize{16pt}{16pt}\selectfont (인)}}
				\@ifundefined{@refereeFifth}{}
				{\\[15pt] \fontsize{16pt}{16pt}\selectfont심 사 위 원   & \ \makebox[\width][r]{\fontsize{16pt}{16pt}\selectfont\@refereeFifth} & \ \makebox[\width][r]{\fontsize{16pt}{16pt}\selectfont (인)}}
			\end{tabular}
			%\end{flushright} 
		\end{center}
	\end{minipage} 
	\newpage
	\renewcommand{\baselinestretch}{1.3}
	\hyphenation{institute department division program} % Prevent word division
	\thispagestyle{empty} \noindent
	\begin{minipage}[c][30mm][c]{\textwidth}
		\begin{center}
			
			\fontsize{20pt}{20pt}\selectfont 
			\@titleEng
			
		\end{center}
	\end{minipage}\\[10mm]
	\begin{minipage}[c][3mm][c]{\textwidth}
		\begin{center}
			\fontsize{14pt}{14pt}\selectfont\@authorEngGN ~\@authorEngFN \\ 
		\end{center}
	\end{minipage}\\[10mm]
	\begin{minipage}[c][8mm][c]{\textwidth}
		\begin{center}
			\fontsize{14pt}{14pt}\selectfont
			\begin{tabular}{lcl}             % Thesis advisor's name in English
				\@ifundefined{@advisorCooprEng}
				% If sole advisor, print only Advisor
				{Advisor:&&\hspace{-0.8cm} \@advisorMajorEng}
				% If joint advisors, print both Major Advisor and Co-Advisor
				{Major Advisor:&&\hspace{-0.8cm} \@advisorMajorEng \\
					Co-Advisor:&&\hspace{-0.8cm} \@advisorCooprEng}
			\end{tabular} \vfill
		\end{center}
	\end{minipage}\\[10mm]
	\begin{minipage}[t][45mm][t]{\textwidth}
		\fontsize{14pt}{14pt}\selectfont
		\hspace*{10mm}
		\begin{center}
			A dissertation submitted to the faculty of\\
			\@kaist\ in\\
			partial fulfillment of the requirements for the degree of\\
			\@degreeName in
			\@appFullAcademName
		\end{center}
	\end{minipage}\\[10mm]
	\mbox{} \hfill
	%\begin{minipage}[t][65mm][t]{.55\textwidth}
	%\linespread{1.4}
	\begin{minipage}[t][0mm][t]{\textwidth}
		\begin{center}
			\fontsize{14pt}{14pt}\selectfont \noindent
			Daejeon, Korea\\
%			\@approvalYear.~\@approvalMonth.~\@approvalDay.\\[24pt] % Submission approval date format: 2016.11.25
       \@dateUSenglish{\@approvalYear}{\@approvalMonth}{\@approvalDay} \\[24pt] % Submission approval date format: June 2, 2016
			Approved by \\
			% If sole or main advisor signed, print as Major Advisor; if co-advisor signed, print as Co-Advisor
			[0pt]
			\vspace*{18mm}
			
			\makebox[.5\textwidth][r]{\hrulefill}\\
			\fontsize{14pt}{14pt}\selectfont \@advisorSigned \\          % Professor's name who signed the submission approval form
			\fontsize{14pt}{14pt}\selectfont \@advisorinfo  % Professor's information on the submission approval form 
			\vspace*{20mm}
			\\
			\fontsize{12pt}{12pt}\selectfont The study was conducted in accordance with Code of Research Ethics\footnotemark[1].
		\end{center}
		
		
	\end{minipage}\\[0mm]
	
	% \end{minipage} 
	\footnotetext[1]{\fontsize{10pt}{10pt} Declaration of Ethical Conduct in Research: I, as a graduate student of Korea Advanced Institute of Science and Technology, hereby declare that I have not committed any act that may damage the credibility of my research.
		This includes, but is not limited to, falsification, thesis written by someone else, distortion of research findings, and plagiarism.
		I confirm that my thesis contains honest conclusions based on my own careful research under the guidance of my advisor.}
	\hfill \newpage
}


%%
%% Generate Korean summary and English abstract, and thesis bibliography page
%% Don't change size of letters. 
\newcounter{pagemarker}                           % Temporary storage for page numbers
\newcommand{\@lastPage}{\pageref{paperlastpagelabel}} % Used for calculating total page count
\newcommand{\@lastRomanPage}{\pageref{paperlastromanpagelabel}} % Used for calculating total Roman numeral page count

\newcommand{\thesisinfo}{
	\pagenumbering{gobble} %This suppresses page numbering
	\pagestyle{plain}%
	\newcommand{\@tempbreak}{}                   % To store the \linebreak command
	\let\@tempbreak\linebreak
	\renewcommand{\linebreak}{\ }                % Replace \linebreak with a space
	\newlength{\@thesisinfowidth}
	\setlength{\@thesisinfowidth}{\textwidth}    % Set thesis information box width
	\addtolength{\@thesisinfowidth}{-30mm}       % 30mm less than the text width
	\noindent
	\parbox[t]{30mm}{\fontsize{14pt}{14pt} \textsf{\@degreeCode \\ \@studentID}}
	\raisebox{3pt}{\begin{minipage}[t]{\@thesisinfowidth}
			\fontsize{12pt}{12pt} \selectfont \sffamily
			\ifthenelse{\equal{\@authorKorFN}{}}
			{}
			{\@authorKorCont.}           % Author's Korean name
			\@titleKor.                 % Thesis title in Korean
			\@affFullNameKor .      % Department/Major name in Korean
			\@gradYear 년.           % Graduation year
			\@lastPage+\@lastRomanPage~쪽.                           % Total page count -> end of bibliography
			\@ifundefined{@advisorCooprEng}         % Check for co-advisor
			{지도교수: \@advisorMajorKorCont.} % If sole advisor, print advisor's Korean name
			{지도교수: \@advisorMajorKorCont, % If joint advisors, print both main and co-advisor's Korean names
				~\@advisorCooprKorCont.}
			\ifthenelse{\boolean{@isKorean}}
			{(한글 논문)}{(영문 논문)} \\              % Indicate if the thesis is in Korean or English
			\@authorEngGN~\@authorEngFN.           % Author's English name
			\@titleEng .                 % Thesis title in English
			\@affFullNameEng .     % Department/Major name in English
			\@gradYear .            % Graduation year
			\@lastPage+\@lastRomanPage~pages.                           % Total page count -> end of bibliography
			\@ifundefined{@advisorCooprEng}         % Check for co-advisor
			{Advisor: \@advisorMajorEng.} % If sole advisor, print advisor's English name
			{Advisor: \@advisorMajorEng, % If joint advisors, print both main and co-advisor's English names
				~\@advisorCooprEng.}
			\ifthenelse{\boolean{@isKorean}}
			{(Text in Korean)}{(Text in English)}               % Specify if the main text is in Korean or English
		\end{minipage}}\\[16pt] \if@PDFdoc\phantomsection\fi}
	
	%%
	%% Generate Korean abstract - applicable only for English theses
	%%
	\newenvironment{summary}{
		\noindent\underline{\textbf{초 록}} 
		% \setlength{\parindent}{0pt} 
		\\
	}{}
	
	\newcommand{\summarykorean}{%           % ver 0.1 Command for generating summary
		\renewcommand{\linebreak}{\ }      % Will be removed in a future version
		\ifx\@textlang\@english
		\chapter*{요 약 문}
		\begin{center}
			\noindent\textsf{\Large \@titleKor} \\[6mm]
		\end{center}% \setlength{\parindent}{0\p@}
		\fi
	}{}
	
	%%
	%% Generate keywords
	%%
	\newenvironment{Korkeyword}{\vspace*{3mm}
		\noindent \underline{\textbf{핵 심 낱 말}} }{}
	
	%%
	%% Generate thesis abstract
	%%
	\renewenvironment{abstract}{\vspace*{9mm} 
		\noindent\underline{\textbf{Abstract}}    % Abstract title -> Abstract
		\\
	}{
}

%%
%% Generate Keywords
%%
\newenvironment{Engkeyword}{\vspace*{3mm}  
	\noindent\underline{\textbf{Keywords}}}
{\let\linebreak\@tempbreak          % Restore the \linebreak command
}






%%
%% Generate table of contents (TOC), list of tables (LOT), and list of figures (LOF) all at once
%%
\newcommand{\makecontents}{%         (e.g., TOC, LOT, LOF generation)
	\setcounter{pagemarker}{\value{page}}        % Save the last page number
	\pagenumbering{roman}                        % Start Roman numeral page numbering
	\tableofcontents
	\listoftables
	\listoffigures}




%%
%% Generate acknowledgments and curriculum vitae (CV)
%%

\newcommand{\acknowledgment}[1][default]{%     % Acknowledgments
	\newcommand{\@acklang}{#1}
	\ifthenelse{\equal{\@acklang}{1}}
	{\chapter*{사 사} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{사 사}}{}                 % When both the main text and acknowledgments are in Korean
	\ifthenelse{\equal{\@acklang}{2}}
	{\chapter*{영 문 사 사} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{영 문 사 사}}{}         % When the main text is in Korean but acknowledgments are in English
	\ifthenelse{\equal{\@acklang}{3}}
	{\chapter*{Acknowledgment} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{Acknowledgments}}{}        % When both the main text and acknowledgments are in English 
	\ifthenelse{\equal{\@acklang}{4}}
	{\chapter*{Acknowledgments in Korean} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{Acknowledgments in Korean}}{}\noindent}         % When the main text is in English but acknowledgments are in Korean

\newcommand{\curriculumvitae}[1][default]{%     % Curriculum Vitae
	\newcommand{\@ccvlang}{#1}
	\ifthenelse{\equal{\@ccvlang}{1}}
	{\chapter*{약 력} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{약 력}}{}                 % When both the main text and CV are in Korean
	
	\ifthenelse{\equal{\@ccvlang}{2}}
	{\chapter*{영 문 약 력} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{영 문 약 력}}{}         % When the main text is in Korean but the CV is in English
	
	\ifthenelse{\equal{\@ccvlang}{3}}
	{\chapter*{Curriculum Vitae} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{Curriculum Vitae}}{}        % When both the main text and CV are in English 
	\ifthenelse{\equal{\@ccvlang}{4}}
	{\chapter*{Curriculum Vitae in Korean} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{Curriculum Vitae in Korean}}{}}% When the main text is in English but the CV is in Korean


%%
%% Generate CV internal elements
%%


\newenvironment{personaldata}{%            % Personal information
	
	\begin{list}{}{%
			\setlength{\labelwidth}{70pt}
			\setlength{\leftmargin}{\labelwidth}
			\addtolength{\leftmargin}{\labelsep}
			\setlength{\parsep}{0pt}
			\renewcommand{\makelabel}[1]{\textgt{##1:\ }}}
		\newcommand{\name}[1]{%               % Name
			\ifthenelse{\equal{\@ccvlang}{1}}
			{\def\@arg{[이\hfill름]}}{}
			\ifthenelse{\equal{\@ccvlang}{4}}
			{\def\@arg{[이\hfill름]}}{}
			\ifthenelse{\equal{\@ccvlang}{2}}
			{\def\@arg{[Name\hfill]}}{}
			\ifthenelse{\equal{\@ccvlang}{3}}
			{\def\@arg{[Name\hfill]}}{}
			\expandafter\item\@arg ##1}
		
		\newcommand{\dateofbirth}[3]{%        % Date of birth
			\ifthenelse{\equal{\@ccvlang}{1}}
			{\def\@arg{[생\hfill년\hfill월\hfill일]}
				\expandafter\item\@arg ##1년 ##2월 ##3일}{}
			\ifthenelse{\equal{\@ccvlang}{4}}
			{\def\@arg{[생\hfill년\hfill월\hfill일]}
				\expandafter\item\@arg ##1년 ##2월 ##3일}{}
			\ifthenelse{\equal{\@ccvlang}{2}}
			{\def\@arg{[Date of Birth\hfill]}    \expandafter\item\@arg \@dateUSenglish{##1}{##2}{##3}
			}{}
			\ifthenelse{\equal{\@ccvlang}{3}}
			{\def\@arg{[Date of Birth\hfill]}
				\expandafter\item\@arg \@dateUSenglish{##1}{##2}{##3}
			}{}
		}
		
		\newcommand{\birthplace}[1]{%         % Place of birth
			\ifthenelse{\equal{\@ccvlang}{1}}
			{\def\@arg{[출\hfill생\hfill지]}}{}
			\ifthenelse{\equal{\@ccvlang}{4}}
			{\def\@arg{[출\hfill생\hfill지]}}{}
			\ifthenelse{\equal{\@ccvlang}{2}}
			{\def\@arg{[Birthplace\hfill]}}{}
			\ifthenelse{\equal{\@ccvlang}{3}}
			{\def\@arg{[Birthplace\hfill]}}{}
			\expandafter\item\@arg ##1}
		
		%%       \newcommand{\domicile}[1]{%           % Place of origin
		%%\ifthenelse{\equal{\@ccvlang}{1}}
		%%            {\def\@arg{[본\hfill적\hfill지]}}{}
		%% \ifthenelse{\equal{\@ccvlang}{4}}
		%% {\def\@arg{[본\hfill적\hfill지]}}{}
		%%      \ifthenelse{\equal{\@ccvlang}{2}}
		%%   {\def\@arg{[Domicile\hfill]}}{}
		%%
		%%   \ifthenelse{\equal{\@ccvlang}{3}}
		%%       {\def\@arg{[Domicile\hfill]}}{}
		%%     \expandafter\item\@arg ##1}
		
		
		\newcommand{\address}[1]{%            % Address
			\ifthenelse{\equal{\@ccvlang}{1}}
			{\def\@arg{[주\hfill소]}}{}
			\ifthenelse{\equal{\@ccvlang}{4}}
			{\def\@arg{[주\hfill소]}}{}
			\ifthenelse{\equal{\@ccvlang}{2}}
			{\def\@arg{[Address\hfill]}}{}
			
			\ifthenelse{\equal{\@ccvlang}{3}}
			{\def\@arg{[Address\hfill]}}{}
			
			\expandafter\item\@arg ##1}
		
		\newcommand{\email}[1]{%              % E-mail
			
			\ifthenelse{\equal{\@ccvlang}{1}}
			{\def\@arg{[전\hfill자\hfill주\hfill소]}}{}
			\ifthenelse{\equal{\@ccvlang}{4}}
			{\def\@arg{[전\hfill자\hfill주\hfill소]}}{}
			\ifthenelse{\equal{\@ccvlang}{2}}
			{\def\@arg{[E-mail\hfill]}}{}
			
			\ifthenelse{\equal{\@ccvlang}{3}}
			{\def\@arg{[E-mail\hfill]}}{}
			\expandafter\item\@arg ##1}
		
		
		% If additional fields are needed for the CV, refer to the above for guidance.
	}{\end{list}}

\newenvironment{education}{%               % Education
	
	\vspace*{5mm} \noindent
	
	\ifthenelse{\equal{\@ccvlang}{1}}{
		\begin{center}
			\makebox[2cm][s]{\textbf{\large 학 력}}
		\end{center}
	}{}
	\ifthenelse{\equal{\@ccvlang}{4}}{
		\begin{center}
			\makebox[2cm][s]{\textbf{\large 학 력}}
		\end{center}
	}{} 
	\ifthenelse{\equal{\@ccvlang}{2}}{
		\textbf{\large Educations}
	}{} 
	\ifthenelse{\equal{\@ccvlang}{3}}{
		\textbf{\large Educations}
	}{}  
	\begin{list}{}{%
			\setlength{\labelwidth}{95pt}
			\setlength{\leftmargin}{\labelwidth}
			\addtolength{\leftmargin}{\labelsep}
			\setlength{\parsep}{0pt}
			\renewcommand{\makelabel}[1]{\textgt{##1\hfill\ }}}
	}{\end{list}}

\newenvironment{career}{%                  % Career
	
	\vspace*{5mm} \noindent
	
	\ifthenelse{\equal{\@ccvlang}{1}}
	{\begin{center}
			\makebox[2cm][s]{\textbf{\large 경 력}}
		\end{center}
	}{ }
	\ifthenelse{\equal{\@ccvlang}{4}}
	{\begin{center}
			\makebox[2cm][s]{\textbf{\large 경 력}}
		\end{center}
	}{ }
	\ifthenelse{\equal{\@ccvlang}{2}}
	{\textbf{\large Career}
	}{ }
	\ifthenelse{\equal{\@ccvlang}{3}}
	{\textbf{\large Career}
	}{ } 
	
	\begin{list}{}{%
			\setlength{\labelwidth}{95pt}
			\setlength{\leftmargin}{\labelwidth}
			\addtolength{\leftmargin}{\labelsep}
			\setlength{\parsep}{\z@}
			\renewcommand{\makelabel}[1]{\textgt{##1\hfill\ }}}
	}{\end{list}}

\newcounter{itemnum1}

\newenvironment{activity}{%                % Academic activities
  
        \vspace*{5mm} \noindent
        
\ifthenelse{\equal{\@ccvlang}{1}}
            {\begin{center}
                \makebox[2cm][s]{\textbf{\large 학 회 활 동}}
            \end{center}
        }{ }
       
\ifthenelse{\equal{\@ccvlang}{4}}
            {\begin{center}
                \makebox[2cm][s]{\textbf{\large 학 회 활 동}}
            \end{center}
        }{ } 
       
\ifthenelse{\equal{\@ccvlang}{2}}
           {\textbf{\large Academic Activities}
        }{ } 
       
\ifthenelse{\equal{\@ccvlang}{3}}
            {\textbf{\large Academic Activities}
        }{ }


 \begin{list}{}{%
            \usecounter{itemnum1}
            \setlength{\labelwidth}{1.5em}
            \setlength{\leftmargin}{\labelwidth}
            \addtolength{\leftmargin}{\labelsep}
            \setlength{\parsep}{\z@}
            \renewcommand{\makelabel}{\textgt{\arabic{itemnum1}.\ }}}
    }{\end{list}}

\newcounter{itemnum2}

\newenvironment{publication}{%             % Research achievements
	 
	\vspace*{5mm} \noindent
	
	\ifthenelse{\equal{\@ccvlang}{1}}{
		\begin{center}
			\makebox[2cm][s]{\textbf{\large 연 구 업 적}}
		\end{center}}
		{}
		
		\ifthenelse{\equal{\@ccvlang}{4}}{
			\begin{center}
				\makebox[2cm][s]{\textbf{\large 연 구 업 적}}
			\end{center}}
			{}
			
			\ifthenelse{\equal{\@ccvlang}{2}}{ \textbf{\large Publications}}
			{}
			
			\ifthenelse{\equal{\@ccvlang}{3}}{ \textbf{\large Publications}}
			{}
			
			
			\begin{list}{}{%
					\usecounter{itemnum2}
					\setlength{\labelwidth}{1.5em}
					\setlength{\leftmargin}{\labelwidth}
					\addtolength{\leftmargin}{\labelsep}
					\setlength{\parsep}{\z@}
					\renewcommand{\makelabel}{\textgt{\arabic{itemnum2}.\ }}}
			}{
		\end{list}}
		
		%%
		%% Reset headings
		%%
		\renewcommand{\contentsname}{
			\if@isKorean 차 례        \else Contents        \fi}
		\renewcommand{\listfigurename}{
			\if@isKorean 그림 차례 \else List of Figures \fi}
		\renewcommand{\listtablename}{
			\if@isKorean 표 차례    \else List of Tables  \fi}
		\renewcommand{\bibname}{%
			\if@isKorean 참 고 문 헌 \else Bibliography      \fi}
		\renewcommand{\abstractname}{
			\if@isKorean 논 문 초 록 \else Abstract      \fi}
		\renewcommand{\figurename}{
			\if@isKorean 그림 \else Figure      \fi}
		\renewcommand{\tablename}{
			\if@isKorean 표 \else Table      \fi}
		%%
		%% Redefine \part - completely disable its usage. Calling this command will produce an error.
		%%
		\renewcommand\part{%
			\secdef\@part\@spart}
		\def\@part[#1]#2{%
			\ClassError{kaist}{The use of \protect\part\space is prohibited.
				\MessageBreak Consider the use of \protect\chapter\space instead}{}
		}
		\def\@spart#1{%
			\ClassError{kaist}{The use of \protect\part\space is prohibited.
				\MessageBreak Consider the use of \protect\chapter\space instead}{}
		}
		
		
		%%
		%% Redefine \chapter - copied from the report class and partially modified
		%%
		\renewcommand\chapter{%
			\if@openright\cleardoublepage\else\clearpage\fi
			%   \thispagestyle{plain}%
			\global\@topnum\z@
			\@afterindentfalse
			%   \if@isKorean \parindent\z@ \else \fi % <-- To consider adding this for Korean
			\secdef\@chapter\@schapter}
		\def\@chapter[#1]#2{%
			\ifnum \c@secnumdepth >\m@ne
			\refstepcounter{chapter}%
			\typeout{\@chapapp\space\thechapter.}%
			\addcontentsline{toc}{chapter}{%
				\if@isKorean
				\protect\numberline{제 \thechapter\ 장}#1
				\else
				\protect\numberline{Chapter \thechapter.}#1
				\fi
			}% <-- Format in the table of contents - modifications
			\else
			\addcontentsline{toc}{chapter}{#1}%
			\fi
			\chaptermark{#1}%
			\addtocontents{lof}{\protect\addvspace{10\p@}}%
			\addtocontents{lot}{\protect\addvspace{10\p@}}%
			\if@twocolumn
			\@topnewpage[\@makechapterhead{#2}]%
			\else
			\@makechapterhead{#2}%
			\@afterheading%
			\fi
		}
		\def\@makechapterhead#1{% <-- Completely modified
			\vspace*{10\p@}
			{\centering \parindent\z@ \fontsize{14pt}{14pt}\selectfont \bfseries
				\ifthenelse{\equal{\@textlang}{korean}}
				{제\hspace{1.4ex}\thechapter\hspace{1.4ex}장\hspace{2ex}}
				{Chapter\hspace{1.4ex}\thechapter.\hspace{1ex}}
				#1\par}
			\vspace*{20\p@}
		}
		\def\@schapter#1{%
			\if@twocolumn
			\@topnewpage[\@makeschapterhead{#1}]%
			\else
			\@makeschapterhead{#1}%
			\@afterheading
			\fi}
		\def\@makeschapterhead#1{% <-- Completely modified
			\vspace*{10\p@}
			{\centering \parindent\z@ \fontsize{14pt}{14pt}\selectfont \bfseries #1\par}
			\vspace*{20\p@}
		}
		
		%%
		%% Redefine \tableofcontents - copied from the report class and partially modified
		%%
		\renewcommand\tableofcontents{%
			\thispagestyle{plain}
			\if@twocolumn
			\@restonecoltrue\onecolumn
			\else
			\@restonecolfalse
			\fi
			\chapter*{\contentsname
				\@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
			\pagenumbering{roman}                         % Restore to Roman numeral page numbering
			\setcounter{page}{\value{pagemarker}}         % Set page counter using the value stored in pagemarker
			\if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\contentsname} % Add to table of contents (TOC)
			\@starttoc{toc}%
			\if@restonecol\twocolumn\fi
			\newpage \setcounter{pagemarker}{\value{page}}% Store the page number again in pagemarker
			\pagenumbering{arabic}                        % Restart page numbering in Arabic numerals
		}
		
		%%
		%% Redefine \listoftables - copied from the report class and partially modified
		%%
		\renewcommand\listoftables{%
			\thispagestyle{plain}
			\if@twocolumn
			\@restonecoltrue\onecolumn
			\else
			\@restonecolfalse
			\fi
			\chapter*{\listtablename}%
			\@mkboth{\MakeUppercase\listtablename}{\MakeUppercase\listtablename}%
			\pagenumbering{roman}                         % Restore to Roman numeral page numbering
			\setcounter{page}{\value{pagemarker}}         % Set page counter using the value stored in pagemarker
			\if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\listtablename}% Add to table of contents (TOC)
			\@starttoc{lot}%
			\if@restonecol\twocolumn\fi
			\newpage \setcounter{pagemarker}{\value{page}}% Store the page number again in pagemarker
			\pagenumbering{arabic}                        % Restart page numbering in Arabic numerals
		}
		
		%%
		%% Redefine \listoffigures - copied from the report class and partially modified
		%%
		\renewcommand\listoffigures{%
			\thispagestyle{plain}
			\if@twocolumn
			\@restonecoltrue\onecolumn
			\else
			\@restonecolfalse
			\fi
			\chapter*{\listfigurename}%
			\@mkboth{\MakeUppercase\listfigurename}{\MakeUppercase\listfigurename}%
			\pagenumbering{roman}                         % Restore to Roman numeral page numbering
			\setcounter{page}{\value{pagemarker}}         % Set page counter using the value stored in pagemarker
			\if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\listfigurename}% Add to table of contents (TOC)
			\@starttoc{lof}%
			\if@restonecol\twocolumn\fi
			\label{paperlastromanpagelabel}     % <-- Added part: specify the location of the last Roman numeral page label
			\newpage \setcounter{pagemarker}{\value{page}}% Store the page number again in pagemarker
			\pagenumbering{arabic}                        % Restart page numbering in Arabic numerals
		}
		
		%%
		%% Format of entries in the table of contents - copied from the report class and partially modified
		%%
		
		\newcommand{\l@content}{\large\bf\@dottedtocline{1}{0em}{0em}}
		
		\renewcommand*\l@chapter[2]{%
			\ifnum \c@tocdepth >\m@ne
			\addpenalty{-\@highpenalty}%
			\vskip 1.0em \@plus\p@
			\if@isKorean                     % <-- Modified part
			\setlength\@tempdima{5.0em} % When the korean option is selected, use 5.0em
			\else
			\setlength\@tempdima{6.5em} % When the english option is selected, use 6.5em
			\fi
			\begingroup
			\parindent \z@ \rightskip \@pnumwidth
			\parfillskip -\@pnumwidth
			\leavevmode \large \sffamily \bfseries
			\advance\leftskip\@tempdima
			\hskip -\leftskip
			#1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
			\penalty\@highpenalty
			\endgroup
			\fi}
		
		
		\if@isKorean % If Korean, adjust various dimensions
		\renewcommand*\l@section{\@dottedtocline{1}{2.7em}{2.3em}}
		\renewcommand*\l@subsection{\@dottedtocline{2}{5.0em}{3.2em}}
		\renewcommand*\l@subsubsection{\@dottedtocline{3}{8.2em}{4.1em}}
		\renewcommand*\l@paragraph{\@dottedtocline{4}{11.2em}{5em}}
		\renewcommand*\l@subparagraph{\@dottedtocline{5}{13.2em}{6em}}
		\else \fi     % If English, leave as is
		
		%%
		%% Redefine thebibliography environment - copied from the report class and partially modified
		%%
		\renewenvironment{thebibliography}[1]{%
			\chapter*{\bibname}%
			\@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
			\if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{\bibname}%
			\list{\@biblabel{\@arabic\c@enumiv}}%
			{\settowidth\labelwidth{\@biblabel{#1}}%
				\leftmargin\labelwidth
				\advance\leftmargin\labelsep
				\@openbib@code
				\usecounter{enumiv}%
				\let\p@enumiv\@empty
				\renewcommand\theenumiv{\@arabic\c@enumiv}}%
			\sloppy
			\clubpenalty4000
			\@clubpenalty \clubpenalty
			\widowpenalty4000%
			\sfcode`\.\@m%
		}{  %% \label{paperlastpagelabel}    % <-- Added part: specify the location of the last page
		\def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
		\endlist
	}
	
	%%
	%% Korean date format -> US English date format
	%%
	\newcommand{\@dateUSenglish}[3]{%  % US English date format
		\newcommand{\@year}{#1}%
		\newcommand{\@month}{#2}%
		\newcommand{\@day}{#3}%
		\ifcase\@month \or
		January \or February \or March \or April \or May \or June \or
		July \or August \or September \or October \or November \or December \fi
		\@day, \@year
	}
	\newcommand{\@dateBRenglish}[3]{%  % British English date format
		\newcommand{\@year}{#1}%
		\newcommand{\@month}{#2}%
		\newcommand{\@day}{#3}%
		\@day\ifcase\@day \or
		st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or
		st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or
		st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or th\fi
		\space\ifcase\@month \or
		January\or February\or March\or April\or May\or June\or
		July\or August\or September\or October\or November\or December\fi,
		\@year
	}
