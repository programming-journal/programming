\NeedsTeXFormat{LaTeX2e}[2005/12/01]
\def\P@banner{The Art, Science, and Engineering of Programming}
\ProvidesClass{programming}
    [2016/08/11 v0.1 ^^J Articles for \P@banner^^J]

\RequirePackage{etexcmds,hardwrap}
\GenerateLogMacros{class}[P]{programming}

\RequirePackage{etoolbox}
\RequirePackage{scrbase}[2014/10/28]
\@ifpackagelater{scrbase}{2014/10/28}{}{%
  \P@error{KOMA-Script too old}{Please upgrade to at least TeXLive 2015 or similar, or upgrade your MiKTeX 2.9 packages.}}
%%
\RequirePackage{ifthen,ifpdf,ifluatex,ifxetex}
\ifthenelse{\boolean{luatex}}%
  {\IfFileExists{luatex85.sty}{\RequirePackage{luatex85}}{}}%
  {}

%%%%
%% DATA
%%%%
\newcommand*\P@@DOI@Prefix{10.22152/programming-journal.org/}
\providecommand*\P@DOI{}
\newcommand*\P@@DOI@Setup{%
  \xdef\P@DOI{\P@@DOI@Prefix \P@Year/\P@Volume/\P@ArticleNumber}}



%% OPTIONS
% from scrkbase
\DefineFamily{programming}
\def\P@Family{\DefineFamilyMember{programming}}
\P@Family%

\newcommand*{\P@Key}[1][.\@currname.\@currext]{%
  \DefineFamilyKey[#1]{programming}}
\newcommand*{\P@ExecuteOptions}[1][.\@currname.\@currext]{%
  \FamilyExecuteOptions[#1]{programming}}

\newcommand*{\P@Options}{\FamilyOptions{programming}}
\let\paperdetails\P@Options
\newcommand*{\AfterP@Options}{}
\let\AfterP@Options\AtEndOfFamilyOptions
\newcommand*{\P@Option}{\FamilyOption{programming}}

\newcommand*{\P@newif}{\P@Family\FamilyBoolKey{programming}}
\newcommand*{\P@setif}{\FamilySetBool{programming}}
\newcommand*{\P@newnum}{\P@Family\FamilyNumericalKey{programming}}
\newcommand*{\P@setnum}{\FamilySetNumerical{programming}}

\newcommand*{\P@newifStd}[1]{%
  \newbool{P@#1}
  \P@newif{#1}{P@#1}}

\newcommand*{\P@curropt}{}
\newcommand*{\P@StdOption}[3][]{%
  \let\P@curropt\CurrentOption
  \DeclareOption{#2}{
    #1%
    \P@ExecuteOptions{#3}}
  \let\CurrentOption\P@curropt
}

\newbool{P@submission}
\P@Key{phase}[final]{%
  \ifstr{#1}{final}{\boolfalse{P@submission}}{}
  \ifstr{#1}{submission}{\booltrue{P@submission}}{}
  \FamilyKeyStateProcessed}
\P@StdOption{submission}{phase=submission}
\P@StdOption{crc}{phase=final}

\providecommand*{\P@SubmissionKey}{}
\def\P@SubmissionKey#1#2{\P@Key{#1}{%
    \AfterP@Options{\ifthenelse{\boolean{P@submission}}%
      {#2}{}}}}
\providecommand*{\P@CRCKey}{}
\def\P@CRCKey#1#2{\P@Key{#1}{%
    \AfterP@Options{\ifthenelse{\boolean{P@submission}}%
      {}{#2}}}}


\providecommand*\P@codefont{sf}
\P@Key{code}{
  \P@setnum{code}{@tempa}{%
    {sf}{0},{sans}{0},{sansserif}{0},%
    {tt}{1},{mono}{1},{monospace}{1},%
    {ttx}{2},{monoextended}{2},{monospaceexended}{2},%
  }{#1}
  \ifcase \@tempa\relax
      \renewcommand*\P@codefont{sf}
  \or \renewcommand*\P@codefont{tt}
  \or \renewcommand*\P@codefont{ttx}
  \fi
  \FamilyKeyStateProcessed}


% for paperdetails

\providecommand*\P@area{%
  \P@warning@noline{No area specified}%
  {\larger\textbf{No area specified. Please add a \texttt{\string\area\{...\}} before \string\maketitle.}}}
\P@SubmissionKey{area}{\gdef\P@area{#1}\FamilyKeyStateProcessed}

\providecommand*\P@perspective{%
  \P@warning@noline{No perspective selected}%
  {\larger\textbf{No perspective selected. Please add a \texttt{perspective=...} document option.}}}%
\P@SubmissionKey{perspective}{
  \P@setnum{perspective}{@tempa}{%
    {art}{0},{theart}{0},%
    {sciencetheoretical}{1},{theoreticalscience}{1},%
        {theoretical}{1},{science-theoretical}{1},%
        {theoretical-science}{1},%
    {scienceempirical}{2},{empiricalscience}{2},%
        {empirical}{2},{science-empirical}{2},%
        {empirical-science}{2},%
    {engineering}{3},%
  }{#1}
  \ifcase \@tempa\relax
    \renewcommand*\P@perspective{The Art of Programming}
  \or
    \renewcommand*\P@perspective{The Theoretical Science of Programming}
  \or
    \renewcommand*\P@perspective{The Empirical Science of Programming}
  \or
    \renewcommand*\P@perspective{The Engineering of Programming}
  \fi
  \FamilyKeyStateProcessed}

\P@StdOption{art}{perspective=art}
\P@StdOption{theart}{perspective=theart}
\P@StdOption{empirical}{perspective=empirical}
\P@StdOption{science-empirical}{perspective=science-empirical}
\P@StdOption{empirical-science}{perspective=empirical-science}
\P@StdOption{theoretical}{perspective=theoretical}
\P@StdOption{science-theoretical}{perspective=science-theoretical}
\P@StdOption{theoretical-science}{perspective=theoretical-science}
\P@StdOption{engineering}{perspective=engineering}

\providecommand*\P@Year{}
\providecommand*\P@Volume{}
\providecommand*\P@Issue{}
\providecommand*\P@ArticleNumber{}

\P@CRCKey{year}{\renewcommand*\P@Year{#1}\P@@DOI@Setup\FamilyKeyStateProcessed}
\P@CRCKey{volume}{\renewcommand*\P@Volume{#1}\P@@DOI@Setup\FamilyKeyStateProcessed}
\P@CRCKey{issue}{\renewcommand*\P@Issue{#1}\P@@DOI@Setup\FamilyKeyStateProcessed}
\P@CRCKey{articlenumber}{\renewcommand*\P@ArticleNumber{#1}\P@@DOI@Setup\FamilyKeyStateProcessed}
\P@CRCKey{submitted}{\DTMsavedate{P@date@submitted}{#1}\FamilyKeyStateProcessed}
\P@CRCKey{published}{\DTMsavedate{P@date@published}{#1}\FamilyKeyStateProcessed}

\P@ExecuteOptions{phase=final,code=sf}


\FamilyProcessOptions{programming}\relax

%%

%% CLASS LOADING
% \PassOptionsToPackage{latest}{latexrelease} 
\IfFileExists{latexrelease.sty}%
   % % Hack. we want the latest, but it spits out a warning that should be an info.
   % {\bgroup\let\PackageWarningNoLine\@gobbletwo\relax
   %   \RequirePackage{latexrelease}\egroup}%
   {\PreventPackageFromLoading*[%
     \typeout{avoid fixltx2e if it does nothing in the first place}]%
   {fixltx2e}}
   {\RequirePackage{fixltx2e}}%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fixes for intermediate versions.
% TL 2015
\@ifpackagelater{scrbase}{2015/09/29}%
 {}% newer, ok
 {\def\set@pdftextpagesize{\set@pdftexpagesize}}

% TL 2016
\@ifpackagelater{scrbase}{2015/11/22}%
  {\@ifpackagelater{scrbase}{2016/06/09}%
     {}% new enough, ok.
     {% There's a bug in tocbasic that got fixed post TL2016.
       % see https://sourceforge.net/p/koma-script/code/2475/
       % workaround by specifying tocdepths manually.
       \@namedef{subsectiontocdepth}{2}%
       \@namedef{subsubsectiontocdepth}{3}%
       \@namedef{subparagraphtocdepth}{5}}}%
  {}% old enough, ok

\LoadClass{scrartcl}

\KOMAoptions{
  fontsize=11pt,
  paper=a4,
  pagesize=automedia,
  DIV=9,
  twoside=semi,
  twocolumn=false,
  titlepage=false,
  footinclude=false,
  headinclude=false,
  headings=normal,
  headheight=10pt,
  numbers=noenddot,
}
\AfterCalculatingTypearea{\setlength{\footheight}{16pt}}
\AfterSettingArea{\setlength{\footheight}{16pt}}
\AtBeginDocument{\setlength{\footskip}{12pt}}
\KOMAoption{captions}{nooneline,tableheading}

\AtEndPreamble{
  \areaset[current]{\textwidth}{1.61803399\textwidth}
  \addtolength{\topmargin}{\dimexpr \headsep + \headheight\relax}
  \addtolength{\marginparwidth}{-1.5em}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[LGR,OT1,LY1,T1]{fontenc}
\ifthenelse{\boolean{xetex}\OR\boolean{luatex}}{}{%
  \RequirePackage[utf8]{inputenc}
  \RequirePackage{alphabeta}}
\RequirePackage{textcomp,textcase,relsize}

%%% Clashes with mathdesign
\PreventPackageFromLoading{amssymb,amsfont}
\RequirePackage[charter,expert]{mathdesign}
\ifthenelse{\boolean{xetex}\OR\boolean{luatex}}%
  {\RequirePackage{fontspec}[2013/05/20]
    \ifthenelse{\boolean{xetex}}%
      {\setmainfont[SmallCapsFeatures={Letters=SmallCaps,LetterSpace=5}]{XCharter}\relax}%
      {\setmainfont{XCharter}\relax}
    \def\P@fontscale{MatchLowercase}}%
  {\RequirePackage[osf,sups]{XCharter}
    \def\P@fontscale{.92}}
\linespread{1.05}
\RequirePackage[scaled=\P@fontscale,semibold]{FiraSans}
\ifdefstring{\P@codefont}{sf}%
 {\global\let\ttfamily\sffamily}
 {\ifdefstring{\P@codefont}{tt}%
   {\RequirePackage[scaled=\P@fontscale,lining,nomap]{FiraMono}}
   {}}

\RequirePackage{babel}
\defcaptionname{english}{\figureautorefname}{figure}
\defcaptionname{english}{\figureautorefname}{figure}
\defcaptionname{english}{\tableautorefname}{table}
\defcaptionname{english}{\lstlistingautorefname}{listing}
\defcaptionname{english}{\lstnumberautorefname}{line}
\defcaptionname{english}{\subsectionautorefname}{\sectionautorefname}
\defcaptionname{english}{\subsubsectionautorefname}{\sectionautorefname}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\ifthenelse{\boolean{luatex}}%
  {\RequirePackage[final]{microtype}[2013/05/23]}%
  {\RequirePackage[final,babel=true]{microtype}[2013/05/23]}
\ifthenelse{\boolean{xetex}}%
  {\let\textls\undefined
    \DeclareRobustCommand{\textls}[2][80]{%
      {{\addfontfeature{LetterSpace=\the\numexpr#1/10\relax}#2}}}}%
  {}

\ifthenelse{\boolean{xetex}}%
 {}% see above
 {\microtypesetup{tracking,letterspace=50}
  \DisableLigatures{encoding = *, family = tt* }}

\newcommand*\P@CodeSetup{%
  \ifthenelse{\boolean{xetex}\or\boolean{luatex}}%
    {\addfontfeatures{Ligatures={NoCommon}}}%
    {}}

\AtBeginEnvironment{verbatim}{\microtypesetup{activate=false}\P@CodeSetup}


\AfterPackage{url}{
  \urlstyle{sf}
  % path is tt-only and actually, urls are better.
  \DeclareUrlCommand\path{}% fool emacs: }
}

\PassOptionsToPackage{hyphens}{url}
\PassOptionsToPackage{all}{hypcap}
\PassOptionsToPackage{%
  final,%
  unicode=true,%
  plainpages=false,%
  pdfpagelabels=true,%
  breaklinks=true,
  pdfborder={0 0 0},
  bookmarksnumbered = true,
  pdfpagemode = UseOutlines,
}{hyperref}
\AtEndPreamble{%
  \RequirePackage{hyperref}%
  \RequirePackage{hyperxmp}
  \RequirePackage{hypcap}
  \RequirePackage{accsupp}
}


\RequirePackage[table,svgnames,dvipsnames,x11names]{xcolor}
\definecolor{P@Blue}{named}{RoyalBlue}
\definecolor{P@ColorOnBlue}{gray}{.95}
\definecolor{P@GrayFG}{named}{darkgray}
\definecolor{P@GrayBG}{gray}{.90}

\newlength{\doclicenseimagewidth}
\setlength{\doclicenseimagewidth}{2.7cm}
\RequirePackage[
  type={CC},
  modifier={by-nd},
  version={4.0},
  imagewidth=\doclicenseimagewidth,
]{doclicense}

% Fixes for intermediate versions.
% TL 2015
% this is actually an installation bug for TL 2015,
% but we cannot reliably test that, so we resort to the check
% if the package is new enough for TL 2016.
\@ifpackagelater{doclicense}{2016/04/24}%
  {\let\P@doclicenseImage\doclicenseImage}% we're good.
  {\def\P@doclicenseImage{%
      \makebox[\doclicenseimagewidth]{%
        \setlength{\fboxsep}{5pt}%
        \raisebox{.5\baselineskip}{\colorbox{P@GrayBG}{\Huge\selectfont\doclicenseIcon}}}}}

\RequirePackage[tbtags,fleqn]{amsmath}
\PassOptionsToPackage{graphicx}{final}
\RequirePackage{graphicx}
\RequirePackage{multirow,tabularx,booktabs,threeparttable}
\RequirePackage[figuresright]{rotating}
\RequirePackage{caption,subcaption} % subfig
\RequirePackage{totpages}
\RequirePackage[useregional]{datetime2}


\ifthenelse{\boolean{xetex}\or\boolean{luatex}}%
  {\newfontfamily\firaoldstylemono
      [ Numbers = {Monospaced,OldStyle},
        UprightFont    = *-Book ,
        ItalicFont     = *-BookItalic ,
        BoldFont    = *-Bold ,
        BoldItalicFont     = *-Bold Italic ,
      ]
      {FiraSans}}{}


\newcommand*\P@listingnumbersfont{%
  \sffamily\small\color{P@GrayFG!40}%
  \ifthenelse{\boolean{xetex}\or\boolean{luatex}}%
    {\firaoldstylemono}
    {\tbfigures}}%


\RequirePackage{listings}
\lstset{%
  basicstyle=\small\ttfamily,%
  % basicstyle=\small\ttfamily,%
  columns=fullflexible,
  inputencoding=utf8,
  upquote=true,
  captionpos=t,
  backgroundcolor=\color{P@GrayBG},%
  breaklines=true,
  postbreak=\raisebox{0ex}[0ex][0ex]{\ensuremath{\color{P@Blue}\hookrightarrow\space}},
  numbers=left,
  numberstyle=\P@listingnumbersfont,
  numbersep=.5em,
  frame=single,framerule=0pt}
\lst@AddToHook{FontAdjust}{\P@CodeSetup}
\lst@AddToHook{DisplayStyle}{\def\baselinestretch{1}\@currsize}
\lst@AddToHook{TextStyle}{\lstset{breaklines=false}}

\AtEndPreamble{\RequirePackage{siunitx}}
\AfterPackage{siunitx}{%
  \sisetup{
    binary-units,
    detect-all,
    free-standing-units,
    space-before-unit,
    use-xspace,
    unit-optional-argument,
    parse-units = false}
  \AtEndPreamble{
    \@ifpackageloaded{pgf}{\SendSettingsToPgf }{}
    \addto\extrasenglish{\sisetup{locale = US}}}}

\PassOptionsToPackage{style=numeric,sortcites}{biblatex}
\AfterPackage{biblatex}{
  \setcounter{biburllcpenalty}{7000}
  \setcounter{biburlucpenalty}{8000}
  \ExecuteBibliographyOptions{
    url=true,%
    urldate=iso8601,%
    abbreviate=false,%
    maxnames=20,%
  }
  \PreventPackageFromLoading[\message{%
    ^^J^^JERROR: You tried to load  the cite package that is not compatible
    with biblatex.^^J^^J%
  }]{cite}
}
\AtEndPreamble{
  \@ifpackageloaded{biblatex}{}{
    % normal bibtex
    \bibliographystyle{plainurl}}}


\setfootnoterule{4cc}
\setkomafont{footnoterule}{\color{P@GrayFG}}
\setlength{\skip\footins}{2\baselineskip}
\setlength{\footskip}{0pt}
\addtokomafont{footnote}{\small}
\RequirePackage{fnpct}
\setfnpct{after-punct-space={-.2em}}

% koma-hacks
\RequirePackage{scrhack}

\setkomafont{pageheadfoot}{\firamedium}
\setkomafont{pagenumber}{\large\firamedium}

\newkomafont{listlabel}{\sffamily\mdseries\color{P@GrayFG}}
\addtokomafont{descriptionlabel}{\sffamily\color{P@GrayFG}}

\setlength\leftmargini  {1.2\parindent}
\setlength\leftmarginii {1.2em}
\setlength\leftmarginiii{1.2em}
\setlength\leftmarginiv {1.2em}
\setlength\leftmarginv  {1.2em}
\setlength\leftmarginvi {1.2em}
\setlength{\leftmargin}{\leftmargini}

\newcommand*\P@Bullet{\color{P@GrayFG}\rule[1.5pt]{3pt}{3pt}}
\renewcommand*\labelenumi{\usekomafont{listlabel}\theenumi.}
\renewcommand*\labelenumii{\usekomafont{listlabel}\theenumii.}
\renewcommand*\labelenumiii{\usekomafont{listlabel}\theenumiii.}
\renewcommand*\labelenumiv{\usekomafont{listlabel}\theenumiv.}
\renewcommand*\labelitemi{\usekomafont{listlabel}\P@Bullet}%
\renewcommand*\labelitemii{\usekomafont{listlabel}--}%
\renewcommand*\labelitemiii{\usekomafont{listlabel}\raisebox{-0.3ex}{\textasteriskcentered}}%
\renewcommand*\labelitemiv{\usekomafont{listlabel}\textperiodcentered}%

\renewcommand*{\@list@extra}{%
  \topsep 2pt\parsep\parskip\itemsep 2pt
}


\AtEndPreamble{%
  \RedeclareSectionCommand[%
    beforeskip=-2\baselineskip,
    afterskip=1\baselineskip]{section}
  \RedeclareSectionCommand[%
    beforeskip=-1\baselineskip,
    afterskip=1\baselineskip]{subsection}
  \RedeclareSectionCommand[%
    beforeskip=-1\baselineskip,
    afterskip=1sp plus -1sp minus 1sp]{subsubsection}
  \RedeclareSectionCommand[%
    beforeskip=1\baselineskip]{paragraph}
  \RedeclareSectionCommand[%
    beforeskip=1\baselineskip]{subparagraph}
}

\providecommand*\hairspace{\ifmmode\mskip1mu\else\kern0.08em\fi}
\providecommand*\email[1]{\href{mailto:#1}{\nolinkurl{#1}}\xspace}
\newenvironment{wide}
    {\list{}{%
            \leftmargin-1.5cm
            \rightmargin\leftmargin}
        \item\relax}
    {\endlist}

\newcommand*\acks{\paragraph*{Acknowledgements}}


\renewcommand*{\sectionformat}{% 
  \colorbox{P@Blue}{%
    {\hspace*{.15em}%
      \color{P@ColorOnBlue}%
      \large\thesection\autodot%
      \hspace*{.17em}}}%
  \quad}

\usepackage{scrlayer-scrpage}
\pagestyle{scrheadings}
\clearpairofpagestyles


\newlength{\pagemarkbaselineskip}
\setlength{\pagemarkbaselineskip}{\baselineskip}
\newcommand*\P@pagemarkseparator{-}

\newcommand*\pagemarkbox[2][P@Blue]{%
    \setlength{\fboxsep}{0pt}%
    \colorbox{#1}{%
      \parbox[c][\layerheight][c]{\layerwidth}{
        \centering
          \color{P@ColorOnBlue}\textls[120]{#2}
        }}}

% floatornonfloatpage was introduced post-TL2015..
\@ifpackagelater{scrbase}{2015/07/02}%
  {\DeclareNewLayer[floatornonfloatpage]{pagemarkbase}}
  {\DeclareNewLayer{pagemarkbase}}
  
\DeclareNewLayer[clone=pagemarkbase,
  voffset=1in+\topmargin+\headheight+\headsep+10\pagemarkbaselineskip,
  width=5em,
  height=2.3\pagemarkbaselineskip,
  contents={\pagemarkbox{%
      \ifdefvoid\P@ArticleNumber{}{%
      \usekomafont{pagenumber}\P@ArticleNumber\P@pagemarkseparator}%
      \pagemark}}
]{pagemarkall}
\DeclareNewLayer[clone=pagemarkall,
  evenpage,
  align=tl,
  hoffset=0pt,
]{pagemarkeven}
\DeclareNewLayer[clone=pagemarkall,
  oddpage,
  hoffset=\paperwidth,
  align=tr,
]{pagemarkodd}

\AddLayersToPageStyle{@everystyle@}{pagemarkodd,pagemarkeven}

\RequirePackage{comment}
\excludecomment{CCSXML}

\let\@ACMccs\@empty
\newcommand*\ccsdesc[2][100]{%
  \@@ACMccs#2[#1]}
\def\@@ACMccs#1~#2[#3]{%
  \def\@tempa{\relax}%
  \ifnum#3>299\def\@tempa{\itshape}\fi%
  \ifnum#3>499\def\@tempa{\bfseries}\fi%
%
  \ifcsdef{@ACMccs@#1}{}{%
    \def\@tempb{\item{}\begingroup}
    \eappto{\@tempb}{\expandonce\@tempa}
    \appto{\@tempb}{#1 → }
    \global\cslet{@ACMccs@#1}\@tempb
    \gappto\@ACMccs{\csuse{@ACMccs@#1}\endgroup}}%
  \csgappto{@ACMccs@#1}{#2; }}

\let\P@keywords\@empty
\newcommand*\keywords[1]{\gdef\P@keywords{#1}}

\addtokomafont{caption}{\small}
\addtokomafont{captionlabel}{\sffamily\bfseries}
\renewcommand*{\captionformat}{\quad}

\newcommand*\P@BlueBox{%
  \kern0.05em{\color{P@Blue}\rule{0.73em}{0.73em}}%
  \hspace*{0.67em}}
\DeclareCaptionLabelFormat{withbox}{%
  \P@BlueBox\bothIfFirst{#1}{~}#2}
\captionsetup{labelformat=withbox}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Authors and Affiliation
\newkomafont{affiliation}{\footnotesize}

\providecommand*\P@last@author{}
\providecommand*\P@authors{}
\newcounter{P@authors}
\providecommand*\P@affiliations{}
\newcounter{P@affiliations}
\providecommand*\P@authorinfos{}


\newcommand*\P@author@link[1]{%
  \texorpdfstring%
    {\hyperlink{P:authorinfo:#1}{#1}}%
    {#1}}%

\renewcommand*\author[2][]{%
  \begingroup
  \def\@tempa{#1}
  \ifdefempty{\@tempa}{%
    \addtocounter{P@affiliations}{1}%
    \edef\@tempa{\alph{P@affiliations}}%
    \addtocounter{P@affiliations}{-1}}{}%
  \xdef\P@last@author{#2}
  \listxadd\P@authors{%
    \noexpand\P@author@link{#2}\ignorespaces%
    \noexpand\P@affil{\@tempa}}%
  \stepcounter{P@authors}%
  \P@author@serialize%
  \endgroup}

% Long.
\newcommand\authorinfo[2][]{%
  \expandafter\listgadd%
  \expandafter\P@authorinfos%
  \expandafter{%
    \expandafter{\P@last@author}{#1}{#2}}}


\newlength{\P@authorinfo@imagewidth}
\newlength{\P@current@parindent}
\setlength{\P@authorinfo@imagewidth}{2.5cm}
\newcommand\P@makeauthorinfo[3]{%
  \begingroup%
  \setlength\P@current@parindent\parindent
  \noindent%
  \begin{minipage}[t]{\dimexpr\linewidth - \P@authorinfo@imagewidth - 2\columnsep\relax}
    \setlength\parindent\P@current@parindent
    \vspace*{0pt}%
    \noindent%
    \strut\hypertarget{P:authorinfo:#1}{\textbf{#1}}\space\ignorespaces #3\par
  \end{minipage}%
  \hspace*{1.5\columnsep}%
  \begin{minipage}[t]{\P@authorinfo@imagewidth}%
    \vspace*{0pt}
    \ifstrempty{#2}{\hfil}{%
      \includegraphics[width=\P@authorinfo@imagewidth]{#2}}%
  \end{minipage}%
  \par\vspace{\baselineskip}
  \endgroup}

\providecommand*\abouttheauthorsname{%
  About the author\ifnum 1<\value{P@authors}s\fi}

\newcommand*\P@printauthorinfos{%
  \ifdefvoid{\P@authorinfos}{}\P@@printauthorinfos}
\newcommand*\P@@printauthorinfos{%
  \begingroup
  \clearpage%
  \phantomsection
  \addcontentsline{toc}{section}{\abouttheauthorsname}
  \section*{\abouttheauthorsname}
  \renewcommand\do[1]{\P@makeauthorinfo##1}
  \dolistloop{\P@authorinfos}
  \endgroup}
\AtEndDocument{\P@printauthorinfos}

\newcommand*\affiliation[2][]{%
  \begingroup
  \def\@tempa{#1}
  \stepcounter{P@affiliations}%
  \ifdefempty{\@tempa}{\edef\@tempa{\alph{P@affiliations}}}{}%
  \expandafter\listgadd%
  \expandafter\P@affiliations%
  \expandafter{%
    \expandafter{\@tempa}{#2}}
  \endgroup}

\newcommand*\printaffiliations{%
  \begin{list}{}{%
      \setlength{\topsep}{0pt}%
      \setlength{\partopsep}{0pt}%
      \setlength{\parskip}{0pt}%
      \setlength{\labelsep}{0pt}%
      \setlength{\labelwidth}{1.5em}%
      \setlength{\leftmargin}{\labelwidth}}
    \def\makelabel##1{\rlap{##1}\hss}
    \def\@tempa##1##2{\item[##1]{##2}}
    \renewcommand*{\do}[1]{\@tempa##1}
    \dolistloop{\P@affiliations}
  \end{list}\ignorespaces}


\newcommand*\P@and{,\space}
\newcommand*\P@midand{\space and\space}
\newcommand*\P@lastand{, and\space}
\let\and\P@and
\let\midand\P@midand
\let\lastand\P@lastand
\let\P@affil\@gobble

\newcommand\P@author@serialize{%
  \gdef\@author{}
  \def\P@i{1}
  \forlistloop{%
    \ifnumequal{1}{\P@i}%
      {}% nothing
      {\ifnumless{\P@i}{\value{P@authors}}%
        {\xappto\@author\and}%
        {\ifnumequal{2}{\P@i}%
          {\xappto\@author\midand}%
          {\xappto\@author\lastand}}}
    \edef\P@i{\number\expandafter\numexpr\P@i + 1\relax}
    \gappto\@author}{\P@authors}}


\newtoks\authorrunning
\newtoks\titlerunning
\providecommand*\@authorrunning{\@author}
\providecommand*\@titlerunning{\@title}
\rohead{\usekomafont{pageheadfoot}\@authorrunning}
\lehead{\usekomafont{pageheadfoot}\@titlerunning}

%%
%%
\newcommand*\P@firstpage{\pageref{P:firstpage}}
\newcommand*\P@lastpage{\pageref{TotPages}}

\defpagestyle{P@titlepage}{{}{}{}}{%
{}{%
  \begin{minipage}[b][0pt][b]{\textwidth}
    \null\noindent%
    \normalfont%
    \P@doclicenseImage%
    \hfill%
    \begin{minipage}[b]%
      {\dimexpr\linewidth - \doclicenseimagewidth - 1\columnsep\relax}
      \scriptsize%
      \textcopyright\ {\@author}\\
      \doclicenseText\\
      \ifthenelse{\boolean{P@submission}}%
        {Submitted to \textit{\P@banner}.}%
        {In \textit{\P@banner}\ignorespaces%
          \ifcsvoid{P@Volume}{}{, vol.\,\P@Volume\ignorespaces}%
          \ifcsvoid{P@Issue}{}{, no.\,\P@Issue\ignorespaces}%
          \ifcsvoid{P@Year}{}{, \P@Year\ignorespaces}%
          \ifcsvoid{P@ArticleNumber}%
          {, pages \P@firstpage--\P@lastpage}%
          {, pages \P@ArticleNumber:\P@firstpage--\P@lastpage}.}
    \end{minipage}%
  \end{minipage}
}{}
}
\renewcommand*{\titlepagestyle}{P@titlepage}

\addtokomafont{title}{\Large\sffamily\bfseries\mathversion{bold}}
\addtokomafont{author}{\large}

\renewcommand*\@maketitle{%
  \label{P:firstpage}%
  \unskip% just in case
  \begingroup
  \parindent\z@ \raggedright%
  \normalfont%
  \raggedright%
  {\usekomafont{title}\@title\par}%
  \vskip\baselineskip%
  \ifdefvoid\@subtitle{}{%
    {\usekomafont{subtitle}\@subtitle \par}%
    \vskip\baselineskip}%
  %
  {\let\P@affil\textsuperscript
    \usekomafont{author}\@author \par}
  \vskip\baselineskip
  %
  {\usekomafont{affiliation}%
    \printaffiliations}%
  \endgroup
  % 
  \if!\the\authorrunning!\relax\else
    \xdef\@authorrunning{\the\authorrunning}\fi
  \if!\the\titlerunning!\else\relax
    \xdef\@titlerunning{\the\titlerunning}\fi
  \begingroup
  \let\@@author\@author
  \def\and{, }\def\midand{, }\def\lastand{, }
  \P@author@serialize
  \hypersetup{pdfauthor=\@author}
  \global\let\@author\@@author
  \hypersetup{pdfkeywords = {\P@keywords}}
  \ifdefvoid{\@subtitle}%
    {\hypersetup{pdftitle={\@title}}}
    {\hypersetup{pdftitle={\@title: \@subtitle}}}
  % %
  \endgroup%
  \global\let\P@affil\@gobble%
}

\newcommand*\P@headersection[1]{%
  \par\vspace*{.5\baselineskip}%
  \footnotesize\sffamily%
  \noindent{\bfseries\sffamily\color{P@GrayFG} #1}\enspace}

\newkomafont{abstract}{\small}
\renewenvironment{abstract}{%
  \par%
  \begingroup
  {\P@headersection{\abstractname}}
  \usekomafont{abstract}
  \noindent\ignorespaces%
}{%
  \begingroup
  \raggedright
  \ifcsvoid{@ACMccs}{}{%
    {\P@headersection{ACM CCS 2012}
    \begin{itemize}\@ACMccs\end{itemize}}}%
  \ifcsvoid{P@keywords}{}{%
    {\P@headersection{Keywords}
    \P@keywords}}%
  \ifcsvoid{P@DOI}{}{%
    {\P@headersection{Digital Object Identifier}
    \href{http://dx.doi.org/\P@DOI}{\P@DOI}}}%
  \vfill%
  \noindent\begin{minipage}[t][10\baselineskip]{\linewidth}\vspace*{0pt}
  {\microtypesetup{activate=false}%
    \Large\selectfont \P@banner\par}
  {\color{P@Blue}\rule{\linewidth}{.5\baselineskip}\par}
    \ifthenelse{\boolean{P@submission}}{%
      {{\P@headersection{Perspective}}{\large\P@perspective}}%
      {{\P@headersection{Area of Submission}}{\large\P@area}}%
    }{%
      \DTMifsaveddate{P@date@submitted}{%
        {{\P@headersection{Submitted}
            \DTMUsedate{P@date@submitted}}}}{}%
      \DTMifsaveddate{P@date@published}{%
        {{\P@headersection{\rlap{Published}\phantom{Submitted}}
            \DTMUsedate{P@date@published}}}}{}%
    }
  \end{minipage}
  \setlength{\skip\footins}{.5\baselineskip}
  \endgroup
  \endgroup
  \clearpage
  \ignorespaces}

% From the TeX FAQ
\renewcommand{\topfraction}{.85}
\renewcommand{\bottomfraction}{.7}
\renewcommand{\textfraction}{.15}
\renewcommand{\floatpagefraction}{.66}
\renewcommand{\dbltopfraction}{.66}
\renewcommand{\dblfloatpagefraction}{.66}
\setcounter{topnumber}{9}
\setcounter{bottomnumber}{9}
\setcounter{totalnumber}{20}
\setcounter{dbltopnumber}{9}

% \emergencystretch=1em
\clubpenalty10000
\widowpenalty10000
\displaywidowpenalty=10000
\frenchspacing
\raggedbottom

\tolerance=100
\emergencystretch=2pt

\endinput