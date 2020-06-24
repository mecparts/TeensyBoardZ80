.rr-----!-------!-------!-------!-------!-------!-------!-------R
.op




















                            ZSDOS 1.1

               A replacement of the CP/M 2.2 BDOS

                       Programmer's Manual

                   (C) Copyright 1988, 89, 90

                               by

                         Harold F. Bower
                       Cameron W. Cotrill
                          Carson Wilson
.paŠ
.paŠTable of Contents

.fi ZSDOSPRG.TOC
.paŠ.pn 1
.f1                  ZSDOS 1.± Programmer's Manual
.f2                                                               #
.tc 1 Introduction ............................................... #
1 Introduction

ZSDOÓ  ió  á powerfuì råplacåmenô foò thå  Basiã  Disë  Operatinç 
Systeí  (BDOS© oæ CP/Í 2.² oò ZRDOÓ 1.ø systems® Iô  haó  variouó 
ne÷  anä numerouó improveä functions¬ buô thå coípatibilitù  witè 
existinç CP/Í 2.² programó ió largelù preserved® Maiîtaiîinç thió 
coípatibilitù  waó alsï thå maiî goaì wheî develoğinç  ZSDOS®  Iî 
somå  cases¬ however¬ thå poósibilitieó oæ  iîtegraôinç  elementó 
froí CP/Í Pluó (alsï knowî aó CP/Í 3© anä froí ZRDOÓ seemeä  morå 
importanô tï uó thaî maiîtaiîinç coípatibility® Fuòtheòmore¬  eø
paîdablå datá struãtureó werå designeä anä iîtegrateä iî ZSDOÓ tï 
creatå thå basió foò á morå powerfuì operatinç system.

Thió  manuaì  describeó iî detaiì thå functions¬  iîteòfaceó  anä 
datá struãtureó oæ ZSDOS® Iî paòticular¬ thå focuó ió oî thå  ne÷ 
featureó oæ ZSDOS¬ buô alsï thå lesó knowî oò ofteî misunderstooä 
propertieó  oæ CP/M® Shorô exampleó iî Z8° assemblù languagå  arå 
intendeä  tï iìlustratå thå uså oæ thå ZSDOÓ functioî  calls®  Iî 
thå ağpeîdiceó yoõ wilì finä shorô overviewó oæ thå functionó  oæ 
ZSDOS.

Thió prograímer'ó manuaì waó noô designeä aó completå  documentá
tioî oæ thå CP/Í operatinç systeí oò thå Z8° assemblù language® Á 
certaiî  knowledgå  oæ thå coîveîtionó wheî usinç  CP/Í  functioî 
calló ió required® Foò morå coípreheîsivå iîformátioî oî CP/Í anä 
thå  Z8° assemblù language¬ wå recommenä thå workó listeä iî  thå 
biâléoçraphù  oæ thå ZSDOÓ User'ó Guide® Unlesó á speciaì DOÓ  ió 
indicated¬  thå statåmentó madå iî thió manuaì abouô  ZSDOÓ  alsï 
applù tï ZDDOS.

.tc   1.1 Components of the operating system ..................... #
1.1 Operating system components

Thå  operatinç systeí CP/Í 2.² (oò coípatible© consistó oæ  threå 
separatå  segments»  thå Basiã Input/Outpuô  Systeí  (BIOS)¬  thå 
Basiã  Disë  Operatinç  Systeí (BDOS©  anä  thå  Consolå  Commanä 
Processoò (CCP)® Eacè oæ theså segmentó ió relátivelù iîdåpeîäenô 
oæ thå otheró anä caî bå replaceä quitå easily® However¬ thå prå
råñuésitå   foò  thió  ió  coípliancå  witè   defineä   interfacå 
parameters.

Thå BIOÓ musô exisô iî somå forí foò everù computer® Iô doeó  alì 
hardwarå  relateä tasks® Alì connecteä deviceó arå coîtrolleä  bù 
thå  BIOÓ  aó  welì aó thå internaì hardware®  Duå  tï  thå  verù 
differenô hardwarå oæ differenô computeò types¬ thå BIOÓ ió  alsï 
verù  different®  Usuallù thå BIOÓ waó writteî  bù  thå  computeò 
manufaãturer®  However¬ therå arå alsï somå fairlù commoî  thirä-
partù  BIOSeó foò speciaì computers® ZSDOÓ haó beeî  designeä  tï 
ruî oî almosô anù computeò whoså BIOÓ ió coípatiblå witè CP/Í 2.² 
oò ZRDOÓ 1.x.

Thå  thirä systeí segment¬ thå CCP¬ ió thå primarù  interfacå  tï 
thå  useò  oæ thå computer® Thió componenô ió probablù  thå  mosô 
fråquentlù  replaced® Thå ZCPÒ familù iî paòticulaò ió  extremelù 
popular®  Sincå changeó iî thå CCĞ arå mosô clearlù felô  bù  thå 
user¬  manù consideò iô thå mosô importanô parô oæ thå  operatinç Šsystem®  Iî  thió  manual¬  however¬ wå wanô  tï  sho÷  thaô  thå 
propertieó  oæ thå BDOÓ determinå ho÷ flexiblå anä  powerfuì  thå 
computeò uìtimatelù becomes.

Alì  logicaì inputó anä outputó oæ thå systeí arå  coîtrolleä  bù 
thå  BDOS®  Iô  manageó  alì resourceó iî  thå  forí  oæ  logicaì 
devices¬ sucè aó Console¬ printer¬ anä disë drive® Thå BDOÓ giveó 
thå  purå hardwarå driveró oæ thå BIOÓ á fixeä  structure¬  whicè 
createó á uniforí ağpearancå oæ á widå varietù oæ CP/Í  computeró 
compareä  tï thå ağplicátioî programs® Thió stricô separátioî  oæ 
hardwarå-iîdåpeîäenô routineó froí hardwarå-dependenô waó onå  oæ 
thå  mosô siçnificanô advanceó thaô CP/Í broughô tï thå  develoğ
menô oæ operatinç systemó foò microcoíputers.

ZSDOÓ  ió á completå råplacåmenô oæ thå BDOÓ segmenô anä  ió  thå 
subjecô oæ thió manual.

.tc   1.2 Memory allocation ...................................... #
1.2 Memory allocation

Thå divisioî oæ thå maiî memorù undeò ZSDOÓ ió identicaì tï  CP/Í 
2.²  anä ZRDOÓ 1.ø systems® Thå reserveä 25¶ byteó (° ­ 0FFH©  oæ 
thå  systeí pagå arå locateä aô thå absolutå addresó 0®  Thå  TPÁ 
(Transienô  Prograí  Area© ió locateä froí addresó 0100È  tï  thå 
loweò enä oæ thå lowesô systeí segment® Alì ağplicátioî  programó 
(e.g® worä procesóing¬ databases¬ assemblers¬ etc.© arå  executeä 
there®  Thå  loweò addresó oæ thå lowesô systeí  segmenô  ió  noô 
deteòmineä bù ZSDOS.

.tc       1.2.1 Storage area of the segments ..................... #
1.2.1 Storage area of the segments

Alì  prograí  (part© ó thaô arå oò remaiî iî thå systeí  afteò  á 
warí  starô  arå referreä tï aó systeí segments®  Classiã  reğrå
sentátiveó foò sucè segmentó arå BIOÓ anä BDOS¬ whicè arå  iîdió
peîsablå foò ağplicátioî programs® Thå CCĞ caî bå oveòwriôteî  bù 
programó  anä ió reloadeä eacè timå iô returnó tï  thå  operatinç 
system®  Somå  CP/Í 2.² BIOSeó reloaä botè thå CCĞ anä  thå  BDOÓ 
afteò á warí start® Thió peculiaritù ió hiótorécaì anä goeó  bacë 
tï á statemenô bù Digitaì Researcè thaô ağplicátioî programó  caî 
alsï overwritå thå BDOÓ iæ necessary® Practicaì eøperiencå shows¬ 
however¬  thaô nï prograí (knowî tï us© oveòwriteó thå  BDOÓ  anä 
mosô moderî BIOSeó dï noô reloaä thå BDOS® Foò somå functionó  oæ 
ZSDOÓ ("reaä-onlù vectoò received¢ anä "fasô rå-login"© thå  BDOÓ 
musô  bå resident¬ otherwiså theù havå nï effect®  (Coîfigurátioî 
datá wilì bå oveòwriôten)

Iî  additioî tï thå segmentó jusô mentioned¬ therå maù  bå  otheò 
systeí  segmentó  iî  á ZSDOÓ system® Iî  contrasô  tï  thå  oneó 
alreadù mentioned¬ theså addétioîaì segmentó arå noô requireä  tï 
operatå  á  ZSDOÓ system® However¬ addétioîaì  functionó  caî  bå 
provideä bù sucè segments.

Exampleó  oæ  theså segments¬ whicè arå alsï  knowî  aó  Residenô 
Systeí  Extensioî (RSX)¬ areº BacëGroundeò ié anä DosDisk¬  ZCPR³ 
systeí coíponentó (sucè aó ENV¬ RCP¬ IOP¬ NDÒ anä FCP)¬ utilitieó 
sucè aó DatåStamperTM” anä lasô buô noô leasô thå ZSDOÓ eøteîsionó Šfoò datå stamğ supporô foò files.

RSXó  arå usuallù iî memorù jusô belo÷ thå CCP® Alì otheò  systeí 
eøteîsionó  arå usuallù locateä abovå thå BIOS® Iî  summary¬  thå 
memorù aìlocátioî ió showî iî thå followinç overview:

.cp 18
               FFFFH +--------------------------+
                     | optional System segments |
               XXXXH +--------------------------+
                     |           BIOS           |
                BIOS +--------------------------+
                     |          ZSDOS           |
          BIOS-0E00H +--------------------------+
                     |           CCP            |
          BIOS-1600H +--------------------------+
                     |      optional RSXs       |
               XXXXH +--------------------------+
                     |                          |
                     |    Transient Program     |
                     |           Area           |
                     |                          |
               0100H +--------------------------+
                     |       System Page        |
               0000H +--------------------------+

Aó caî bå seeî froí thió iìlustrátion¬ onlù thå addresseó oæ  thå 
systeí  pagå anä thå starô oæ thå TPÁ areá arå preciselù  defineä 
iî á ZSDOÓ system® Alì otheò systeí addresseó depenä oî thå BIOS® 
Thå  sizeó oæ thå systeí page¬ thå ZSDOÓ anä thå CCĞ  (excepô  iî 
extendeä Ú systems© arå preciselù defined® Otheò systeí  segmentó 
caî bå adapteä tï youò owî needs.

.tc       1.2.2 System page ...................................... #
1.2.2 System page

Thå  systeí pagå (addresó rangå froí ° ­ 0FFH© ió useä  bù  ZSDOÓ 
foò importanô systeí iîformátion® Foò ZSDOS¬ thå samå  specificá
tionó  applù  foò thå systeí pagå aó undeò CP/Í 2.2®  Thå  systeí 
pagå formó thå interfacå tï ZSDOS¬ whicè ió whù uîdeòstanäinç thå 
functioî oæ eacè iîdividuaì areá ió extremelù important.

00H - 02H‚       jump to BIOS warm start routine (BIOS+03H)

Nï  prograí  maù  changå  thió address® Iô ió  thå  onlù  waù  tï 
determinå  thå  baså  addresó oæ thå ZSDOÓ  systeí  segmenô  witè 
certainty®  Aî  examplå  oæ thå "correct¢ uså oæ  thå  warí  booô 
vectoò  followó lateò iî thió manual® Iæ programó wanô tï  changå 
thå BIOÓ jumğ vectors¬ onlù thå valueó oæ thå BIOÓ jumğ tablå maù 
bå adapted¬ noô thå jumğ deótinátioî oæ addresó 0.

Onlù Alphá System'ó NZCOÍ changeó thå BIOÓ warí booô vectoò iî aî 
aãcepôablå  manner®  Á BIOÓ includinç jumğ tablå  ió  "imitated"¬ 
whicè  ió furtheò dowî iî thå memory® Thå systeí segmentó oæ  thå 
ZCPÒ arå loadeä betweeî thå reaì systeí BIOÓ anä thå  "imitation¢ 
oæ  NZCOM®  Thå BIOÓ warí booô vectoò pointó  tï  thå  "imitated¢ 
BIOS®  Thió meanó thaô alì programs¬ excepô  foò  systeí-specifiã Šutilities¬  continuå  tï  ruî withouô  errors®  Wheî  writinç  oò 
revisinç  á BIOS¬ onå shoulä notå thå functionalitù oæ  NZCOÍ  iî 
thå systeí utilities.

03H‚     IOBYTE

Thå IOBYTÅ containó á BIOÓ-dependenô structure® Iô caî bå useä bù 
thå BIOÓ prograímeò tï enablå bytå-orienteä inputs/outputó tï  bå 
redirected® Thå bytå itselæ containó ´ fieldó thaô stanä foò  thå 
logicaì  devicå consolå (CON:)¬ readeò (RDR:)¬ puncè  (PUN:©  anä 
lisô devicå (LST:)® Eacè logicaì devicå caî bå assigneä tï onå oæ 
uğ tï fouò differenô physicaì devices.

Becauså  thå  iîtegrátioî oæ thå IOBYTÅ ió  optionaì  anä  systeí 
dependent¬  pleaså  refeò  tï thå manualó  oæ  youò  computeò  tï 
determinå thå exacô specificátionó foò youò system.

04H‚     current CCP defaulô drive and user area

Thå  CCĞ storeó thå valueó foò thå currenô defaulô drivå anä  thå 
currenô useò areá iî thå bytå oæ thió memorù location® Thå  valuå 
foò thå drivå ió saveä iî bitó ° tï 3¬ startinç witè ° foò  drivå 
A®  Bitó ´ tï · storå thå useò areá witè modulï 16®  Pleaså  notå 
thaô onlù useò areaó ° tï 1µ caî bå accesseä directly® Sincå fivå 
bitó  arå availablå foò thå useò areá iî thå directory¬ fileó  oò 
programó  caî  alsï bå storeä iî thå useò areaó 1¶  tï  31®  Froí 
versioî 3.³ oæ thå ZCPR¬ logginç intï useò areaó 1¶ tï 3± ió  oğ
tioîallù  possiblå aô thå commanä level® Thå addétioîaì CCĞ  codå 
keepó  thå numbeò oæ thå higè useò areá (witè á  fe÷  eøceğtioîaì 
cases).

05H - 07H‚       jump to BDOS

Á calì tï addresó µ ió useä tï perforí á ZSDOÓ function® However¬ 
thå  valuå  aô addresó ¶ cannoô bå useä aó á  direcô  pointeò  tï 
ZSDOS!

Iæ  thå sizå oæ thå availablå TPÁ areá ió requireä bù á  program¬ 
thå jumğ addresó storeä aô addresseó ¶ anä · caî bå useä foò  thå 
caìculátion® Thå mosô siçnificanô bytå oæ thå valuå aô addresó  ¶ 
alwayó  pointó  tï thå lasô pagå oæ thå TPÁ  area®  Dependinç  oî 
whetheò aî RSØ ió loadeä oò not¬ thå nexô pagå containó thå ZSDOÓ 
segment.

.cp 5
08H - 2FH‚       free for system expansions

30H - 37H‚       reserved

38H - 3FH‚       restart vector 38H

Thió addresó ió normallù useä bù debuggeró tï savå thå breaëpoinô 
routine® Durinç thå tesô phase¬ thå debuggeò onlù needó onå  bytå 
(opcodeº RSÔ 38H¬ valueº 0FFH© tï enteò thå breaëpoint.

40H - 4FH‚       free for system expansionsŠ
Oî somå computers¬ partó oæ thió memorù areá arå useä foò  systeí 
functions® Foò example¬ oî thå Amprï Littlå Board¬ thå ZCPR³ patè 
iî storeä byteó 40È tï 4DH.

50H - 5BÈ‚       free for programs

Variouó  modem/BBÓ  programó froí thå publiã  domaiî  areá  storå 
parameteró sucè aó thå bauä rate.

5CH - 6BH       defaulô file control block (FCB) 1

6CH - 7BH‚       defaulô file control block (FCB) 2

Thå  CCĞ storeó thå firsô twï parameteró oæ thå commanä  linå  iî 
thå filå controì blocks® Wheî usinç thå firsô filå controì  blocë 
tï  opeî á file¬ thå contenô oæ thå seconä filå controì blocë  ió 
oveòwriôten®  Wheî  openinç á filå witè thå seconä  filå  controì 
block¬ parô oæ thå DMÁ buffeò ió oveòwriôten® Thå 1¶ byteó oæ thå 
seconä filå controì blocë shoulä bå copieä tï anotheò memorù areá 
beforå  usinç 6CÈ anä onlù useä there® Thió meanó thaô  thå  filå 
controì blocë aô addresó 5CÈ caî bå useä unchanged® Afteò openinç 
thå  file¬ thå completå filå controì blocë ió 3¶ byteó (froí  5CÈ 
tï 7FH).

80H - 0FFH‚      defaulô DMA buffer/command line

Thió  memorù areá ió useä foò twï tasks® Iæ á prograí ió  starteä 
bù  thå  CCP¬  iô storeó alì argumentó oæ thå  commanä  linå  foò 
furtheò  uså bù thå program® Thå firsô bytå oæ thå  buffeò  (80H© 
containó thå numbeò oæ valiä charaãters® Thå resô oæ thå  commanä 
linå  followó  itself¬ startinç witè thå spacå  (oî  81H)¬  whicè 
separateó thå argumentó froí thå command.

Thió areá ió alsï useä foò thå defaulô DMÁ buffer® Aó lonç aó thå 
addresó  oæ  thå  DMÁ buffeò haó noô beeî changeä  viá  thå  BDOÓ 
functioî  26¬  alì datá transferó betweeî memorù  anä  disë  takå 
placå  viá thió memorù area® Thå prograí musô thereforå  evaluatå 
thå  commanä paraíeteró beforå thå buffeò ió oveòwriôteî bù  disë 
operátions.
.paŠ.tc
.tc 2 BDOS functions ............................................. #
2 BDOS functions

Thå  BDOÓ workó noô onlù witè floppù drives¬ buô alsï witè  otheò 
I/Ï devices¬ e.g® printer¬ console¬ clock¬ modeí etc® Floppù disë 
I/Ï  ió  carrieä  ouô witè datá blocks¬ whilå  almosô  alì  otheò 
deviceó  onlù transfer singlå bytes® Therå arå alsï á  numbeò  oæ 
BDOÓ  calló tï reaä oò changå datá struãtureó anä manipõlatå  thå 
filå  system® Aó yoõ caî see¬ thå BDOÓ haó somethinç morå  tï  dï 
thaî jusô managå thå floppù oò filå system.

.tc   2.1 Character I/O .......................................... #
2.1 Character I/O

Witè characteò I/O¬ onlù onå characteò oò bytå ió tranóferreä  aô 
á  time®  Thió  typå oæ tranómiósioî ió  normallù  useä  foò  thå 
terminal¬  printeò oò seriaì coímunicátioî (modem©  devices®  Thå 
BDOÓ  incompletelù  supportó fouò logicaì deviceó  foò  characteò 
I/O:

.cp 4
ª Console (input/output)
* Readeò (input)
* Puncè (output)
* List output [printer]

Iî  thió context¬ "iîcoíplete¢ meanó thaô thå  statuó  (ready/noô 
ready© ió noô availablå foò alì logicaì devices® Becauså thió waó 
oveòlookeä  iî  thå  develoğmenô  oæ  thå  originaì  CP/Í  systeí 
segmentó  BDOÓ anä BIOS¬ thå prograíminç oæ speciaì  ağplicátionó 
ió  mucè morå difficult® Foò example¬ seriaì  porô  coímunicátioî 
programó tï otheò computeò typeó onlù worë witè greaô effort.

ZSDOÓ provideó ninå functionó foò characteò I/O® Whilå thå  firsô 
siø  onlù  providå á direcô interfacå tï thå  coòresponäinç  BIOÓ 
functions¬  thå lasô threå carrù ouô rudimeîtarù  processes®  Thå 
ninå functionó are:

.lm 3
.pm 1
.oj off
.cp 10
* Read a character from the console
* Display a character on the console
* Read a character from the reader
* Output a character tï the punch
* Output a character to the list device [printer]
* Query the input status of the console
* Direct console I/O
* Display a character string on the console
*Reaä consolå buffeò (geô characteò strinç froí console¬ witè 
  editinç functions)
.oj on
.lm 1
.pm 1

.tc   2.2 Disk I/O ............................................... #
2.2 Disk I/O

.cp 2
Thå  floppù disë operátionó oæ thå BDOÓ savå thå datá aó  logicaì 
datá blocks¬ whicè arå groupeä togetheò tï forí á file® Thå  filå 
ió saveä iî onå oæ uğ tï 3² useò areaó oæ á logicaì drive®  Therå 
caî bå uğ tï 1¶ logicaì driveó iî á CP/Í system.

.cp 2
ZSDOÓ  manageó  thå datá blockó aó 12¸-bytå logicaì  records¬  aó 
provideä bù thå BIOS® ZSDOÓ carrieó ouô thå necessarù  coîveòsioî Štï determinå thå physicaì tracë anä sectoò numbers® Iî thió  way¬ 
thå  physicaì sectoò sizå thaô ió processeä iî thå  BIOÓ  remainó 
hiddeî  froí thå ağplicátioî programs® Regarälesó oæ whetheò  thå 
physicaì  sectoò sizå ió 128¬ 256¬ 512¬ 102´ oò 204¸  bytes¬  thå 
BDOÓ provideó á uniforí interface® Thå BDOÓ offeró thå  followinç 
filå operátions:

.cp 10
* Search foò á file
* Rename á file
* Delete á file
* Create á ne÷ file
* Open aî existinç file
* Jump to a specific point in a file
* Read á record froí a file
* Write á record to a file
* Close file
* Determine the size of a file

Somå  oæ  theså functionó caî bå applieä tï closeä  files®  Theså 
includeº Search¬ rename¬ delete¬ create¬ opeî anä determinå  filå 
size® Alì otheò functionó caî onlù bå applieä tï opeî files.

.tc   2.3 Control and status ..................................... #
2.3 Control and status

Thå  lasô largå categorù oæ BDOÓ functionó containó á  serieó  oæ 
commandó  foò  coîtroììinç  anä iîfluenãinç  thå  statuó  oæ  thå 
system®  Thió includeó functionó thaô deliveò addresseó  oæ  datá 
struãtures®  Iô  alsï  defineó thå  functionó  oæ  connecteä  I/Ï 
devices.

Duå  tï thå eøteîsionó iî ZSDOS¬ manù ne÷ commandó arå  availablå 
iî  thió categorù (e.g® foò erroò mode¬ reaì timå clocë anä  datå 
stamp)® Tï makå thå systeí eveî morå flexible¬ somå functionó caî 
bå  activateä oò deaãtivateä bù usinç ne÷ controì  struãtureó  iî 
thå runninç system.

Basically¬  thå  functionó  oæ thió categorù caî  bå  divideä  aó 
follows:

.cp 10
* Return of data structures
  (12 commands)
* Define control elements
  (7 commands)
* System control
  (6 commands)
* Interface to the real time clock
  (2 commands)
* Time and date stamp for files
  (2 commands)
.paŠ.tc
.tc 3 ZSDOS data structures ...................................... #
3 ZSDOS Data Structures

.tc   3.1 General ................................................ #
3.1 General

Variouó  datá struãtureó arå useä tï exchangå datá betweeî  ZSDOÓ 
anä ağplicátioî programs® Wheî thå prograí transferó  iîformátioî 
tï ZSDOS¬ á ZSDOÓ functioî ió calleä anä á bytå valuå iî registeò 
Å  oò á worä pointeò tï á datá structurå iî registeò paiò  DÅ  ió 
tranóferred® 

Passinç multiplå valueó tï ZSDOÓ ió onlù á littlå morå difficult® 
Normally¬  nï speciaì precaõtionó arå necessary® Iæ  pointeró  tï 
certaiî  datá struãtureó arå passeä iî repeateä calls¬  thå  datá 
structurå shoulä noô bå shifteä betweeî calló becauså thå addresó 
oæ  thå structurå ió passeä tï ZSDOÓ eacè time® Aî exampleº Iæ  á 
filå  witè  thå filå controì blocë (FCB© ió openeä aô  á  certaiî 
address¬ thå FCÂ shoulä noô bå moveä tï anotheò address®  Failurå 
tï dï thió caî leaä tï problemó witè DatåStamperTM¬ BGié oò otheò 
programs.

Iæ  iîformátioî  froí  ZSDOS‚ ió returneä tï thå  program¬  iô  ió 
availablå iî registeró (bytå oò word)¬ iî thå pråviouslù  defineä 
buffeò  area¬  iî thå currenô DMÁ buffeò oò aó á pointeò  tï  thå 
currenô  datá area® Aó faò aó possible¬ thå samå  struãtureó  arå 
useä  foò  thå  transfeò oæ iîformátioî tï anä  froí  ZSDOS®  Foò 
example¬ thå filå controì blocë (FCB© correspondó largelù tï  thå 
datá structurå witè whicè thå directorù iîformátioî ió storeä  oî 
disk®  Iæ entrieó arå tï bå madå iî thå directory¬ thå fieldó  oæ 
thå  FCÂ  arå inétializeä bù thå ağplicátioî  prograí  thaô  coò
responä tï thå directorù fields.
.tc   3.2 Logical record ......................................... #
3.2 Logical record

Thå mosô basiã structurå useä bù ZSDOÓ ió thå logicaì record®  Iô 
containó 12¸ byteó oæ data/iîformátioî reaä froí oò writteî tï  á 
floppù  disk® Pleaså notå thaô thå terí "logicaì  record¢  shoulä 
noô bå confuseä witè thå terí "sector"® Normally¬ á sectoò oæ thå 
disë containó severaì logicaì records.

Witè  thå disë functionó "Read¢ oò "Finä first/nexô file"¬  ZSDOÓ 
readó  thå  iîformátioî oæ á logicaì recorä iî  thå  currenô  DMÁ 
buffer® Iî thå samå way¬ writå tï disë froí therå usinç thå writå 
functions® Thå baså addresó oæ thå DMÁ buffeò ió defineä viá  thå 
functioî  calì 26¬ thå desireä addresó beinç tranóferreä  iî  thå 
registeò  paiò DE® Functioî 4· caî bå useä tï querù  thå  currenô 
DMÁ address¬ whicè ió returneä iî registeò paiò HL.

.tc   3.3 File Control Block (FCB) ............................... #
3.3 File Control Block (FCB)

Anotheò  basiã structurå ió thå filå controì  block‚  (hereinafteò 
referreä  tï  aó FCB)¬ whicè ió useä tï transfeò  iîformátioî  tï 
ZSDOÓ foò mosô filå-relateä functions® Thå FCÂ ió á 3¶-bytå  datá 
areá  thaô containó iîformátioî requireä foò  filå  manipulátion® 
Thå FCÂ ió struãtureä aó follows:

.cp 12ŠFCB+00È       Drive number (DR¬ 0=defaulô drive, 1...16=A-P© 
FCB+01È       File name in uppercase ASCII letters [8 bytesİ (Fn)
FCB+09È       ASCII uppercase file type [3 bytesİ (Tn)
FCB+0CÈ       Logical extent numbeò (EX)
FCB+0DÈ       User area (S1)
FCB+0EÈ       Data module (S2)
FCB+0FÈ       Extent record counteò (RC)
FCB+10È       16 byte disk map for this extenô (AL)
FCB+20È       Current record for R/× (CR)
FCB+21È       Random accesó record number LSÂ (Rn)
FCB+22È       Random accesó record number ISB
FCB+23È       Random accesó record number MSB

Thå  mosô siçnificanô bitó iî thå filå name‚ anä iî thå filå  type‚ 
arå useä tï storå thå aôtributes® Sucè aôtributeó marë á filå  aó 
reaä-onlù  oò  archived® Foò morå iîformátioî oî usinç  filå  aô
tributes¬ seå functioî 3° iî sectioî 5.2.30.

Thå  logicaì extent‚ (EX© ió useä bù ZSDOÓ iî ordeò tï bå ablå  tï 
procesó  fileó thaô arå largeò thaî 12¸ logicaì recordó (1¶  kB)® 
Foò  thå  firsô  logicaì  extent¬ thió numbeò ió  seô  tï  °  anä 
increaseä bù onå eacè timå foò á furtheò 12¸ records.

Thå  datá  modulå number‚ (S2© ió useä bù ZSDOÓ tï  procesó  fileó 
thaô  arå  largeò thaî 3² logicaì extentó (51² kB)®  Iô  ió  alsï 
initiallù  seô  tï  ° anä ió increaseä bù onå  eacè  timå  foò  á 
furtheò 6´ logicaì extents.

Theså fieldó oæ thå FCÂ arå normallù seô tï zerï bù thå  ağplicá
tioî programs¬ buô iî certaiî caseó arå seô tï differenô  values® 
Thå  logicaì  extenô  numbeò caî takå valueó betweeî  °  anä  31® 
Valueó betweeî ° anä 6³ arå permitteä foò thå datá modulå number® 
Yoõ  caî  finä  morå  detaileä  iîformátioî  iî  sectioî   5.2.1· 
(Descriğtioî  oæ  functionó  "Searcè foò  Firsô  File"©  oæ  thió 
manual.

Thå  lasô  record‚ useä numbeò ió storeä iî  thå  currenô  logicaì 
extenô  iî thå bytå oæ thå recorä counter® Thå aìlocátioî  vectoò 
reğråsentó  thå  numbeò oæ blockó occupieä bù thå file®  Nï  datá 
froí anù oæ theså fieldó ió passeä tï ZSDOS.

Thå  nexô  record‚ numbeò ió storeä iî thå currenô extenô  iî  thå 
currenô   recorä  byte¬  whicè  ió  accesseä  bù  thå   functionó 
"Sequentiaì Read¢  oò "Sequentiaì Write"® Normally¬ thió bytå  ió 
seô  tï  zerï  bù thå useò wheî searchinç oò  openinç  files®  Iô 
shoulä noô bå changeä betweeî såqueîtiaì writå oò reaä accesses.

Thå  threå-bytå  fielä witè thå numbeò foò thå randoí  record‚  ió 
useä  bù  thå functionó "Randoí Accesó Read¢ anä  "Randoí  Accesó 
Write"®  Thå 2´ bitó caî contaiî á numbeò betweeî ° anä  262,143® 
Thió resultó iî thå maximuí sizå oæ á filå oæ 262,14´ records.

Therå ió á verù importanô diæferencå betweeî ZSDOÓ anä otheò  DOÓ 
segmentó  foò CP/Í 2.2® ZSDOÓ onlù openó oò createó  ne÷  extentó 
wheî theù arå needeä anä noô wheî thå lasô recorä oæ aî extenô ió Šreaä oò written® Thió meanó thaô afteò thå såqueîtiaì readinç  oò 
writinç oæ thå lasô recorä oæ aî extent¬ thå byteó oæ thå currenô 
recorä anä thå recorä counteò arå seô tï 80H® Somå oldeò ağplicá
tioî  programó arå unablå tï copå witè thió functionalitù oæ  thå 
DOÓ anä thereforå dï noô ruî undeò ZSDOS® Becauså CP/Í Pluó dealó 
witè extentó iî exactlù thå samå waù aó ZSDOS¬ theså programó  dï 
noô ruî undeò CP/Í Plus.

Iô  ió extremelù importanô tï bå awarå oæ thå iípoòtancå  oæ  thå 
FCÂ  foò DOÓ iî filå operátions® Alì statuó iîformátioî ió  saveä 
there® Iæ á prograí trieó tï changå thå FCÂ oæ aî opeî file¬  thå 
entirå DOÓ statuó wilì bå destroyed¡ Thió ió espåciallù truå wheî 
DosDisë  ió  runninç  anä  thå FCÂ ió iî  MÓ-DOÓ  format®  Iô  ió 
thereforå  stronglù  recoímendeä thaô ağplicátionó  shoulä  never“ 
changå  thå FCÂ fieldó oæ aî opeî file® Thå onlù  eøceğtionó  arå 
thå  fieldó oæ thå currenô recorä anä thå numbeò foò  thå  randoí 
record.

.tc   3.4 Directory Record ....................................... #
3.4 Directory Record

Thå directorù record‚ ió á datá structurå thaô thå BDOÓ writeó  tï 
disk®  Thió containó iîformátioî abouô thå currenô aósigîmenô  oæ 
thå  files®  Eacè directorù recorä ió 12¸ byteó lonç  (á  logicaì 
record© anä usuallù containó fouò directorù entries® Therå ió  aô 
leasô onå directorù entrù foò eacè filå oî thå disk® Iæ á filå ió 
sï largå thaô severaì directorù entrieó arå requireä foò it¬ sucè 
aî  entrù  ió referreä tï aó á "physicaì extent"®  Eacè  physicaì 
extenô haó itó owî number¬ sï thaô ZSDOÓ caî correctlù accesó thå 
files.

Eacè  directorù entry‚ ió 3² byteó lonç anä ió struãtureä  similaò 
tï thå filå controì block® Thå maiî diæferencå ió thaô thå fieldó 
foò  thå  currenô  recorä  anä foò  thå  randoí  recorä  arå  noô 
availablå  iî thå directorù entry® Iî addition¬ thå useò areá  oæ 
thå filå ió saveä iî thå firsô bytå oæ thå directorù entrù ratheò 
thaî thå drivå codå oò thå valuå 0E5È iæ thå filå waó deleted.

Directory entries are structured as follows:

.cp 8
DIR+°         User area of the file (0..31)
DIR+1..¸      File name in uppercase ASCII letters [8 bytes]
DIR+9..1±     ASCII uppercase file type [3 bytes]
DIR+1²        (EØ) Logical extent number
DIR+1³        (S1) system byte (set to 0)
DIR+1´        (S²) datá modulå
DIR+1µ        (RÃ) Record counter
DIR+16..3±    (AÌ) Allocation vector for this physical extent

.cp 2
Aó  witè thå FCB¬ thå mosô siçnificanô bitó oæ thå filå  namå  oò 
typå arå useä tï storå thå aôtributes.

.cp 5Š.tc   3.5 Disk Allocation Vector ................................. #
3.5 Disk Allocation Vector

Thå  disë  aìlocátioî vector‚ ió á structurå oæ thå BDOÓ  thaô  ió 
embeddeä  iî  thå BIOS® Therå ió aî aìlocátioî  vectoò  foò  eacè 
logicaì drivå iî thå system® Iô ió á biô mağ oæ alì blockó oî thå 
floppù  disk® Iæ á biô ió seô tï 1¬ thió meanó thaô thå  assigneä 
blocë ió useä (occupied)® Aãcoräingly¬ á biô reseô tï ° indicateó 
thaô  thå blocë ió available® Thå minimuí sizå oæ thå  aìlocátioî 
vectoò iî byteó foò á drivå caî bå calcõlateä aó followsº  numbeò 
oæ blocks/8+1.

Accesó  tï  thió  structurå ió verù unusuaì  foò  aî  ağplicátioî 
prograí  (aparô  froí  somå directorù programó  thaô  derivå  thå 
availablå disë space)® Ağplicátioî programó musô neveò changå thå 
aìlocátioî  vectoò directly® Functioî 2· returnó thå  addresó  oæ 
thå  aìlocátioî vectoò foò thå currenô defaulô drivå iî  registeò 
paiò  HL®  However¬ wå recommenä thaô thå vectoò  shoulä  noô  bå 
accessed¬ aó thió maù noô bå possiblå iî futurå systems® Thió is¬ 
foò example¬ alreadù thå caså witè CP/Í Pluó anä maù alsï bå  thå 
caså iî futurå versionó oæ ZSDOS.

.cp 6
.tc   3.6 Disk Parameter Block ................................... #
3.6 Disk Parameter Block

Thå  disë paraíeteò block‚ (DPB© ió á BIOÓ structurå thaô  defineó 
thå  formaô oæ á logicaì drivå foò ZSDOS® Iæ á prograí needó  iî
formátioî  froí thå DPB¬ iô musô accesó iô directly® Thå  DPÂ  ió 
struãtureä aó follows:

.cp 9
DPB+0,±       Number of 128 byte records per track
DPB+²         Block shift factor
DPB+³         Block mask
DPB+´         Extent mask
DPB+5,¶       Number of the maximum available blocks
DPB+7,¸       Number of directory entries -1
DPB+9,1°      Bit map of the directory and reserved blocks
DPB+11,1²     Size of the directory check buffer
DPB+13,1´     number of system tracks

Á detaileä descriğtioî oæ thå iîdividuaì fieldó oæ thå DPÂ  woulä 
gï  beyonä thå scopå oæ thió manual® Wå thereforå  recommenä  thå 
verù gooä booë "Thå Prograímer'ó CP/Í Handbook¢ bù Andù  Johnsoî-
Lairä (seå thå biâléoçraphù iî thå ZSDOÓ User'ó Guide)®  Functioî 
3±  returnó  thå  addresó oæ thå DPÂ foò  thå  defaulô  drivå  iî 
registeò paiò HL.

.cp 14Š.tc   3.7 Dates .................................................. #
3.7 Dates

Iæ  thå  driveò routineó tï supporô datå  stampó  arå  installed¬ 
ZSDOÓ  supportó  twï  otheò struãtures® Thå  firsô  ió  thå  datå 
specificátion¬  whicè ió useä tï exchangå timå anä datå  iîformá
tioî betweeî ağplicátioî programó anä ZSDOS® Thå datå ió baseä oî 
á serieó oæ packeä BCÄ numberó anä ió struãtureä aó follows:

.cp 8
.rr-----------!-------!-----------------------------------------R
.pm 1
.lm 15
.oj off
TIME+0        lasô ² digitó oæ thå yeaò (froí 7¸ tï 9¹ ió 
              precedeä bù 1¹ foò thå century¬ otherwiså 20)
TIME+±        montè   [1..12]
TIME+²        Daù     [1..31]
TIME+3        houò    [0..23]
TIME+´        minutå  [0..59]
TIME+µ        Seconä  [0..59]
.rr-----!-------!-------!-------!-------!-------!-------!-------R
.oj on
.lm 1
.pm 1

Anyonå  familiaò  witè DatåStamperTM” wilì  iímediatelù  recognizå 
thió format® Thå onlù deviatioî froí thå DatåStamperTM” formaô  ió 
thå precedinç century® DatåStamperTM” alwayó assumeó "19¢ foò  thå 
century® Foò morå iîformátioî abouô thå DatåStamperTM” format¬ yoõ 
shoulä refeò tï thå DatåStamperTM” manual‚ startinç oî pagå Á-19.

Wheî functioî 9¸ ió called¬ ZSDOÓ returnó thå currenô timå iî thå 
buffer¬ thå starô addresó oæ whicè ió passeä iî thå registeò paiò 
DE®  Callinç  functioî  9¹ setó thå clocë tï thå  valueó  iî  thå 
buffer¬  thå  starô addresó oæ whicè ió tranóferreä  iî  registeò 
paiò DE.

Thå  relativå clock‚ knowî froí DatåStamperTM” ió  alsï  supported® 
Onlù  thå  houò  anä minutå fieldó arå  requireä  foò  this¬  thå 
secondó fielä ió seô tï zero® Thå relativå clocë ió jusô á simplå 
binarù  counter® Thå minutå fielä ió useä aó thå lo÷-ordeò  byte¬ 
whilå  thå houò fielä ió thå higè-ordeò byte® Tï avoiä  confusinç 
thå  relativå clocë witè á reaì-timå clock¬ thå mosô  siçnificanô 
biô (biô 7© ió seô iî thå houò fielä foò á relativå clock.

.cp 6
.tc   3.8 Stamp format ........................................... #
3.8 stamp format

Thå  stamğ formaô foò fileó useä bù ZSDOÓ waó alsï  deriveä  froí 
DatåStamperTM®  (Honestlù  folks¬ wå didn'ô  wanô  tï  plagiarizå 
Bridgeò  Mitchell'ó  ideas® Wå carefullù examineä  eacè  existinç 
formaô  beforå  decidinç  oî  thå methoä  thaô  besô  suiteä  ouò 
purposes.©  Regarälesó oæ thå stamğ methoä useä iî thå  systeí  ­ 
DatåStamperTM” oò P2DOÓ oò CP/Í Pluó formaô ­ thå formaô useä  iî
teònallù ió alwayó thå same.

Thå  universaì formaô consistó oæ threå fieldó thaô  contaiî  iî
formátioî  abouô  thå  creation¬ thå lasô  accesó  anä  thå  lasô 
change®  Thå  firsô µ byteó oæ thå datå arå useä foò this®  Iæ  á 
fielä  ió noô supporteä oò ió onlù partiallù supported¬ thå  coò
responäinç  areaó  iî  thå fielä arå seô tï °  wheî  readinç  anä 
ignoreä wheî writing.

Alì  stamğ iîformátioî ió tranóferreä iî thå currenô DMÁ  buffer® 
Functioî  10² returnó thå datå stamğ iîformátioî oæ á  file¬  thå ŠFCÂ  addresó  oæ whicè waó tranóferreä iî thå registeò  paiò  DE® 
Functioî  10³ ió useä tï transfeò thå stamğ iîformátioî froí  thå 
DMÁ  buffeò tï á filå whoså FCÂ addresó iî thå DÅ registeò  pair® 
Aô  thå  moment¬  thå stamğ iîformátioî ió onlù  1µ  byteó  long® 
However¬  thió coulä changå iî futurå versionó oæ ZSDOS¬ sï  thaô 
foò  coípatibilitù  reasonó  wå recommenä  reservinç  á  12¸-bytå 
buffeò iî thå ağplicátioî program.

.cp 5
Stamğ formaô foò fileó (1µ byteó packeä BCÄ numbers):

DMA+0..´        Created datå      (first 5 bytes of the date)
DMA+5..¹        Lasô Access datå  (first 5 bytes of the date)
DMA+10..1´      Modifieä datå     (first 5 bytes of the date)
.paŠ.tc
.tc 4 ZSDOS programming conventions .............................. #
4 ZSDOS programming conventions

.tc   4.1 General ................................................ #
4.1 General

ZSDOÓ  ió  coípatiblå  witè  CP/Í  2.²  anä  ZRDOÓ  ağplicátions® 
However¬  tï creatå á soliä foundátioî foò futurå  eøteîsionó  oæ 
ZSDOÓ  anä coípatiblå BDOÓ suâstitutes¬ thå  followinç  practiceó 
shoulä bå coîsidereä durinç prograíming.

Undeò  ZSDOÓ  iô  ió assumeä thaô thå systeí pagå  haó  thå  samå 
structurå  aó undeò CP/Í 2.² oò ZRDOÓ ­ i.e® á jumğ tï  thå  warí 
starô routinå oæ thå BIOÓ (jumğ targetº BIOS+3© aô addresó  0000È 
anä  á jumğ tï thå BDOÓ oò thå lowesô residenô  systeí  extensioî 
(RSX©  aô  addresó  0005H® Á correcô  systeí  addresó  cannoô  bå 
deriveä  froí thå jumğ deótinátioî oæ addresó 0005H¬  excepô  foò 
thå  enä oæ thå TPÁ area® Thå followinç lineó oæ sourcå texô  arå 
intendeä  tï iìlustratå ho÷ thå uppeò enä oæ thå TPÁ areá caî  bå 
calcõlateä usinç thå jumğ iîstruãtioî aô addresó 0005H:

.cp 3
GETSIZº LÄ      HL,(0006H©      ; Get the end address of the TPA
        DEÃ     HÌ              ; correct address now in HL
        ...

Thió  addresó ió ofteî useä bù ağplicátioî programó tï  calculatå 
thå  starô addresseó oæ BDOÓ anä BIOS® However¬ thió methoä  doeó 
noô worë iæ residenô systeí eøteîsionó (RSXs© sucè aó BGii¬  ZEX¬ 
DosDisë etc® arå installed.

Tï correctlù calculatå thå systeí addresses¬ thå jumğ deótinátioî 
oæ addresó 0000È musô bå used® Thå pointeò oæ thió addresó alwayó 
pointó tï BIOS+³ anä shoulä neveò bå changeä bù anù program® Wheî 
programó  neeä tï intercepô thå BIOÓ entrù points¬ e.g® foò  warí 
start¬ consolå statuó etc.¬ thå jumğ tablå oæ thå BIOÓ shoulä  bå 
changeä anä noô thå jumğ deótinátioî aô addresó 0000H® Thå  ZSDOÓ 
entrù  poinô  caî  bå  calcõlateä  correctlù  accordinç  tï   thå 
followinç example:

.cp 3
FINDZSº LÄ      HL,(0001H©      ; Get BIOS warm start address
        LÄ      DE,-0DFDÈ       ; Offseô tï starô of ZSDOS
        ADÄ     HL,DÅ           ; HL points to ZSDOS entry point

Aó  witè  CP/Í  2.2¬ ZRDOÓ uğ tï versioî 1.¹  anä  mosô  unbankeä 
systems¬  thå baså addresó oæ ZSDOÓ ió 0DFDÈ belo÷ thå jumğ  deó
tinátioî aô addresó 0000H® Thå starô addresó oæ thå CCĞ caî  alsï 
bå  calcõlateä iî thió way® Tï dï this¬ jusô subtracô  thå  valuå 
1603È  froí  thå jumğ target® Thå starô oæ thå  BIOÓ  jumğ  tablå 
(colä start© ió obtaineä bù suâtracôinç ³ froí thå jumğ target.

Iæ  yoõ no÷ combinå thå "correct¢ caìculátioî methoä oæ thå  BDOÓ 
entrù  poinô anä thå jumğ deótinátioî aô addresó 0005H¬  yoõ  caî 
easilù determinå whetheò aî RSØ ió installed.

.cp 9ŠFINDZSº LÄ      HL,(0001H©      ; Get BIOS warm start address
        LÄ      DE,-0DFDÈ       ; The beginning of ZSDOS below
        ADÄ     HL,DÅ           ; HL points to ZSDOS entry point
        EØ      DE,HL
        LÄ      HL,(0006H©      ; Get BDOS jump vector
        ANÄ     A
        SBÃ     HL,DÅ           ; arå the addresses identical?
        JÒ      Z,NORSØ         ; yes - no RSX available
        ...

Iî ZCPÒ systemó witè aî extendeä eîviroîment¬ thå BIOS¬ BDOÓ  anä 
CCĞ  addresseó arå availablå iî thå eîviroîment® Iæ  aî  extendeä 
eîviroîmenô ió available¬ alì systeí addresseó musô bå takeî froí 
thå  eîviroîment® Thå reasoî foò thió maù bå "abnormal¢ sizeó  oæ 
BDOÓ anä CCĞ oæ sucè systems.

ZSDOÓ  functionó  arå  calleä uğ bù storinç  thå  ZSDOÓ  functioî 
numbeò  iî registeò Ã anä valueó iî registeò Å oò  registeò  paiò 
DE®  Á calì (CALL© ió theî madå tï addresó 0005H®  ZSDOÓ  returnó 
valueó  iî  registeò Á and/oò iî registeò paiò HL®  Alì  registeò 
contentó  witè  thå  exceptioî  oæ IX¬  IÙ  anä  thå  aìternátivå 
registeró caî bå changed.

Wheî develoğinç BIOSes¬ BIOÓ eøteîsionó oò IOPó witè  reentrancy¬ 
iô  shoulä  bå  bornå iî minä thaô alì  registeró  thaô  arå  noô 
includeä iî thå originaì 808° registeò seô musô bå backeä uğ  anä 
restoreä betweeî calls® Thå ağplicátioî programó "owns¢ thå  reç
ióteró  AF'¬ BC'¬ DE'¬ HL'¬ IØ anä IÙ ­ noô thå systeí  software¡ 
Accordinç tï thå coîveîtions¬ however¬ registeró É anä Ò arå suâ
jecô  tï thå BIOS® Witè ne÷ proceósoró likå 6418° anä  Z280¬  alì 
ne÷ registeró (witè thå exceptioî oæ thå Z28° SSP© belonç tï  thå 
BIOÓ  becauså theù arå hardwarå-specifiã anä directlù relateä  tï 
inputó  anä outputs® Thå Z28° SSĞ shoulä remaiî reserveä foò  thå 
BDOS.

Manù  prograímeró  havå useä tecèniqueó iî filå  operátionó  thaô 
causå problemó witè advanceä operatinç systems® Foò example¬  thå 
searcè  foò fileó ió affected¬ whicè undeò certaiî  ciòcumstanceó 
caî  leaä  tï apparenô maìfunãtionó witè ZSDOÓ wheî thå  patè  ió 
activated® Thå tesô foò thå existencå oæ á filå shoulä bå carrieä 
ouô  usinç  thå BDOÓ functioî 1· provideä foò  thió  purposå  anä 
shoulä noô bå baseä oî thå evaluátioî oæ thå returneä codå oæ thå 
openinç function® Wheî opening¬ ZSDOÓ searcheó foò thå  specifieä 
filå  alonç thå path¬ buô noô wheî searchinç foò thå firsô  entrù 
(functioî 17).

Iî  addition¬  prograímeró havå tï takå intï  accounô  thaô  witè 
ZSDOÓ  mucè  largeò fileó caî bå createä thaî undeò CP/Í  2.²  oò 
ZRDOS® Whilå thå latteò systemó onlù supporô filå sizeó oæ uğ  tï 
65,53¶ logicaì recordó (8,19² kB)¬ fileó undeò ZSDOÓ caî bå uğ tï 
262,14´  logicaì  recordó  (32,76¸ kB)® Sucè fileó  caî  alsï  bå 
processeä bù CP/Í 3.0.

.cp 4Š.tc   4.2 Reentrancy in ZSDOS calls .............................. #
4.2 Reentrancy in ZSDOS calls

Reentranô  ZSDOÓ  functioî calló iî thå senså oæ  thå  ZRDOÓ  1.ø 
specificátionó  arå  fullù supporteä bù ZSDOS® Thió  propertù  ió 
generallù onlù useä bù ZCPÒ I/Ï packageó (IOPs).

Á reenteranô ZSDOÓ functioî calì ió triggereä wheî ZSDOÓ calló  á 
BIOÓ functioî thaô ió iîteòcepteä bù aî IOP¬ whicè iî turî  calló 
á  ZSDOÓ function® Aî examplå oæ thió woulä bå á printeò  spooleò 
(á prograí thaô redirectó printeò outpuô tï á file)® ZSDOÓ  woulä 
calì  thå BIOÓ functioî foò thå lisô output® Thå  IOĞ  iîteòceptó 
thió  functioî calì anä theî calló ZSDOÓ functionó tï  writå  thå 
iîteòcepteä datá tï á file.

Thå poósibilitù oæ reentrancù ió á verù powerfuì tool¬ buô iô caî 
alsï  causå  uîprecådenteä damagå iî thå  system¡  Alì  importanô 
internaì statuó iîformátioî froí ZSDOÓ (includinç thå addresó  oæ 
thå DMÁ buffer© musô bå saveä beforå eacè functioî calì anä  theî 
restoreä  again® Iî addition¬ somå BIOÓ iîformátioî musô alsï  bå 
saveä  oò reinétialized® Á basiã rulå isº Nï BDOÓ  disë  functioî 
maù bå iîteòrupted.

Iî  ordeò tï offeò maximuí coípatibilitù witè  existinç  programó 
foò ZRDOÓ Plus¬ thå datá areaó oæ ZSDOÓ werå locateä iî thå loweò 
parô oæ thå systeí segment® Thå addresseó useä anä thå methoä  oæ 
reentrancù arå coípatiblå witè existinç IOPó foò ZRDOÓ Plus® Herå 
ió á coíparisoî oæ thå ZSDOÓ paraíeteró witè thå råquiråmentó  oæ 
ZRDOÓ Plus:

.cp 3
                Beginninç       length
ZSDOÓ            Base+³         146 (92H) bytes
ZRDOS Pluó       Base+µ         147 (93H) bytes

Becauså thå datá areá oæ ZSDOÓ ió smaller¬ therå ió nï damagå  iæ 
thå  14·  byteó requireä bù ZRDOÓ Pluó arå saved®  Thå  differenô 
starô  addresseó  arå duå tï thå facô thaô iî ZSDOÓ therå  ió  aî 
internaì erroò vectoò tablå oî á CP/Í 2.² coípatiblå offset®  Thå 
addresó  oæ  thå  BAÄ  SECTOÒ erroò routinå  ió  locateä  oî  thå 
affecteä  bytes®  Thå useò shoulä makå surå thaô  nï  routinå  aô 
ZSDOÓ  reentrancù  witè ZRDOÓ paraíeteró changeó thå  BAÄ  SECTOÒ 
erroò vector® Otherwiså strangå thingó coulä happen.

Aó alreadù shown¬ thå baså addresó oæ ZSDOÓ caî bå easilù  calcõ
lateä  usinç  thå BIOÓ warí starô vectoò aô  addresseó  000±  anä 
0002® Onlù 0DFDÈ haó tï bå suâtracteä froí thå vectoò tï geô  thå 
"base".

Onå  lasô  precautioîarù  measurå musô bå takeî  wheî  usinç  thå 
reentrancù  optionó  iî  thå evenô thaô trapó iî  thå  BIOÓ  jumğ 
vectoró  arå  useä tï initiatå reenterinç ZSDOÓ callsº  Thå  useò 
musô  ensurå thaô alì registers¬ includinç thå IØ  register¬  arå 
saveä betweeî thå råenterinç calls!

.cp 4ŠExample:

Tï  integratå á reentranô functioî call¬ thå addresó oæ  thå  DMÁ 
buffeò  musô  firsô  bå  querieä bù thå DOÓ  anä  saveä  iî  youò 
program® Theî thå datá areá oæ thå DOÓ musô alsï bå saveä iî youò 
program®  Froí  thió  poinô on¬ alì functioî calló  caî  bå  madå 
regarälesó  oæ thå previouó statå oæ thå DOS® Oncå  youò  routinå 
haó  beeî executed¬ yoõ shoulä restorå thå DOÓ bù  reversinç  thå 
stepó  aô thå beginning» firsô thå saveä datá areá ió  copieä  tï 
itó  originaì positioî anä theî thå addresó oæ thå DMÁ buffeò  ió 
seô  tï  thå  olä valuå usinç functioî 26® Thå  addresó  musô  bå 
restoreä  witè  thå DOÓ functioî 2¶ iî ordeò tï comparå  thå  DMÁ 
addresó  oæ thå BIOÓ witè thaô iî thå ZSDOÓ datá area¬ iæ  iô  ió 
changeä bù youò program.

.cp 23
        LD      C,4·            ; Get current DMA address
        CALÌ    µ               ; ... call the DOS entry point
        LD      (DMASAV),HÌ     ; Save DMA address locally
        CALL    FINDZÓ          ; Find ZSDOS base address
                                ; ... (see section 4.1)
        LD      DE,9-¶          ; Offset of the data area
        ADÄ     HL,DÅ           ; ... from the DOÓ start
        LD      DE,SAVAREÁ      ; Local backup area pointer
        LD      BC,14·          ; ... and the whole area
        LDIÒ                    ; ... copù thå block
        ..®                     ; here is your routine
        CALL    FINDZÓ          ; Find ZSDOS base addr again
        LD      DE,9-¶          ; Offset of the data area
        ADÄ     HL,DÅ           ; ... from the starô of DOS
        EØ      DE,HÌ           ; in the reg. for the goal
        LD      HL,SAVAREÁ      ; Pointer to source oî the
                                ; ... the local security area
        LD      BC,14·          ; the whole area
        LDIÒ                    ; ... copy thå block
        LD      DE,(DMASAV©     ; Get secured DMA address
        LD      C,2¶            ; ... and with function 26
        CALL    µ               ; ... set via DOS (anä in BIOS)
        ..®                     ; go on...

.cp 4
.tc   4.3 ZSDOS configuration area ............................... #
4.3 ZSDOS configuration area

Thå  coîfigurátioî  areá  oæ ZSDOÓ ió locateä  aô  addresó  ZSDOÓ 
Base+3® Variouó vectoò tables¬ thå addresseó oæ thå patè anä  thå 
wheeì  bytå  aó welì aó thå coîfigurátioî bytå oæ thå  flagó  arå 
storeä  iî  thió area® Thå samå aósigîmenô ió  retaineä  foò  alì 
versionó 1.ø oæ ZSDOÓ anä ZDDOS® However¬ changeä offsetó maù  bå 
useä iî futurå puâlécátions.

.cp 8Š.tc       4.3.1 Error vector table ............................... #
4.3.1 Error vector table

Thå  erroò vector‚ tablå ió locateä aô addresó base+3® Thió  ió  á 
CP/Í 2.² coípatiblå structurå thaô ió useä bù somå programó (e.g® 
sectoò checë programs© tï intercepô thå BDOÓ errors® Iô waó  onlù 
iîtegrateä intï ZSDOÓ becauså oæ thå coípatibilitù witè  existinç 
programs® ZSDOÓ ağplicátionó shoulä uså thå ne÷ BDOÓ erroò  modeó 
tï intercepô errors.

.cp 7
.tc       4.3.2 Path address (ZSDOS only) ........................ #
4.3.2 Path address (ZSDOS only)

Thå baså addresó oæ thå searcè path‚ ió storeä aô addresó base+11® 
Wheî  openinç files¬ ZSDOÓ useó thå searcè patè iæ thå  valuå  aô 
thió addresó ió noô equaì tï zerï anä biô µ oæ thå  coîfigurátioî 
bytå ió seô tï 1.

Pleaså  notå thaô iæ thå CCĞ useó á commanä searcè patè (aó  witè 
ZCPÒ  oò  BGii)¬ thå DOÓ patè ió searcheä aó ofteî aó  therå  arå 
entrieó  iî thå commanä searcè patè oæ thå CCP® Oæ  course¬  thió 
slowó  dowî  thå work® Futurå versionó oæ theså  råplacåmenô  CCĞ 
systemó  shoulä  checë foò á ZSDOÓ patè tï initiatå  onå  oæ  thå 
followinç  prïcådures®  Iæ iô ió deteòmineä thaô á  DOÓ  patè  ió 
availablå  anä activated¬ thió ió useä insteaä oæ thå CCĞ  searcè 
path®  Thå seconä optioî woulä bå tï deaãtivatå thå DOÓ patè  viá 
biô  µ oæ thå flaç bytå durinç thå searcè alonç thå  CCĞ  commanä 
searcè path.

.cp 6
.tc       4.3.3 Address of the wheel byte ........................ #
4.3.3 Address of the wheel byte

Thå addresó oæ thå wheeì byte‚ ió saveä iî base+13® Thå wheeì bytå 
ió á ZCPÒ controì elemenô witè whicè thå safetù functionó oæ  thå 
systeí  caî bå expanded® Iæ thå wheeì bytå ió ofæ  (valuå  equaló 
0)¬ ZSDOÓ protectó alì fileó witè thå wheeì proteãtioî  attributå 
(f8©  seô  froí beinç oveòwriôten¬ deleteä anä  renamed®  Iæ  thå 
addresó oæ thå wheeì bytå iî thå BDOÓ ió seô tï ° (pointeò tï thå 
jumğ  tï warí start)¬ ZSDOÓ assumeó thaô thå useò haó alì  rightó 
oæ uså anä allowó hií uîrestricteä accesó tï thå files.

Pleaså  notå thaô thå wheeì bytå ió aî elemenô oæ ZCPR³  anä  anù 
arbitrarù  addresó  caî bå seô foò thå  iîdåpeîäenô  DOÓ  controì 
mechanism® Iæ yoõ uså onå oæ thå ZCPÒ versionó 3.ø aó á  råplacå
menô foò thå CCP¬ yoõ wilì certainlù uså thå samå wheeì bytå  foò 
botè  systeí segments® Wå jusô wanô tï poinô ouô  thaô  differenô 
memorù celló arå possiblå foò speciaì iîstallátions.

.cp 6
.tc       4.3.4 Configuration byte ............................... #
4.3.4 Configuration byte

Manù  propertieó  oæ  ZSDOÓ  caî bå  checkeä  durinç  runtimå  bù 
changinç thå coîfigurátioî byte® Thå bytå ió baseä oî address+15® 
Noô  alì flaç bitó arå useä bù ZSDOS® Iæ unuseä bitó arå  seô  oò 
reset¬ thió haó nï effecô oî ZSDOS.

.cp 4ŠTï  ensurå coípatibilitù witè lateò versionó oæ ZSDOS¬  onlù  thå 
functionó 10° (holå flags© anä 10± (seô flags© shoulä bå useä  tï 
accesó thå ZSDOÓ flags® Thå meaninç oæ thå flaç bitó iî thå  coî
figurátioî bytå ió defineä aó follows:

.cp 9
Bitº   7 6 5 4 3 2 1 0
       | | | | | | | +- Public fileó               on (1)/off (0)
       | | | | | | +--- Write public/path files    on (1)/off (0)
       | | | | | +----- Get read-only vectoò       on (1)/off (0)
       | | | | +------- quick logiî                on (1)/off (0)
       | | | +--------- Floppy disk change warning on (1)/off (0)
       | | +----------- ZCPR2/3 patè               on (1)/off (0)
       | +------------- Path with/out system files on (1)/off (0)
       +--------------- reserved

Biô  ° controló whetheò ZSDOÓ findó fileó witè thå "publiã  file¢ 
(f2©  attributå iî otheò useò areaó oî thå samå disk® Iæ thå  biô 
ió seô tï 1¬ sucè fileó arå founä iæ á uniquå filå namå haó  beeî 
specified.

Biô  ± decideó whetheò iô ió alloweä tï writå tï fileó thaô  werå 
founä usinç thå publiã attributå oò thå patè (onlù ZSDOS)® Iæ thå 
functioî  ió switcheä oî (biô ± equaló 1)¬ fileó caî  bå  writteî 
to®  Otherwiså (biô ± equaló 0© writinç tï fileó thaô werå  founä 
usinç thå attributå publiã oò thå patè ió noô possible.

Biô  ²  specifieó wheî thå writå proteãtioî vectoò  iî  ZSDOÓ  ió 
deleted® Iæ thå biô ió set¬ thå vectoò ió neveò deleteä (aó  lonç 
aó ZSDOÓ ió noô reloadeä froí thå disk)® Iæ thå biô ió reset¬ thå 
writå proteãtioî biô foò á drivå ió deleteä wheî iô ió loggeä  iî 
agaiî witè functioî 1³ oò 37.

Biô  ³  causeó ZSDOÓ noô tï recreatå thå aìlocátioî vectoò  oæ  á 
"fixed¢ disë (harä disë oò RAÍ disk© iæ thå drivå haó beeî loggeä 
ouô  witè functioî 13® Settinç thió biô speedó uğ worë witè  harä 
diskó  coîsiderably®  Fixeä diskó caî bå loggeä iî agaiî  aô  anù 
timå usinç functioî 37.

Biô  ´  switcheó thå messagå froí ZSDOÓ oî oò ofæ  wheî  changinç 
floppù  disks® Iæ thå biô ió set¬ ZSDOÓ issueó á messagå  oî  thå 
screeî  eacè  timå á disë ió changed® Thió messagå ió  oæ  courså 
suğpresseä iæ thå BDOÓ erroò modå ió seô aãcoräingly»  regarälesó 
oæ thå statå oæ thió bit.

Biô µ enableó thå uså oæ thå DOÓ patè wheî openinç fileó iæ iô ió 
seô tï ± (ZSDOÓ only)® Iæ thió biô ió seô anä á noî-zerï valuå ió 
entereä  iî thå addresó foò thå path¬ thå specifieä filå  witè  á 
uniquå  namå  ió founä bù ZSDOÓ usinç thå path® Thió biô  haó  nï 
meaninç foò ZDDOS.

Biô  ¶ specifieó thå patè accesó iæ thå patè ió activateä  (ZSDOÓ 
only)®  Iæ biô ¶ ió seô tï 1¬ alì fileó iî direãtorieó alonç  thå 
patè arå founä regarälesó oæ thå systeí attributå (patè directorù 
access)® Iæ thió functioî ió switcheä ofæ (biô ¶ equaló 0)¬  onlù 
fileó witè thå systeí attributå seô (patè filå access© arå  founä Šiî  thå direãtorieó alonç thå path® Thió biô haó nï  meaninç  foò 
ZDDOS.

.cp 7
.tc       4.3.5 Date vectors ..................................... #
4.3.5 Date vectors

Á  vectoò tablå ió integrateä iî ZSDOS¬ whicè allowó driveró  foò 
datå  stampó  tï  integratå  themselveó  intï  ZSDOS®  Thå  tablå 
containó ¶ entrieó anä startó aô addresó baså+16® Anotheò dummù 
entrù  ió  onlù  useä tï recorä thå  addresó  oæ  thå  switcè-ofæ 
functioî iî ZSDOS.

Thå  speciaì driveró foò datå stampó instalì theíselveó iî  ZSDOÓ 
bù  enterinç  thå  addresseó oæ thå supporteä  functionó  iî  thå 
table®  ZSDOÓ  calló thå requireä routineó tï  perforí  thå  datå 
stamğ  functions® Beforå doinç so¬ however¬ thå directorù  buffeò 
ió  updateä anä á checë ió carrieä ouô tï determinå  whetheò  thå 
disë haó read/writå status.

Becauså ZDDOÓ alreadù containó DatåStamperTM¬ onlù thå  addresseó 
foò thå clocë driver¬ foò thå removaì anä foò thå dummù entrù arå 
necessarù foò thió DOS.

.cp 10
The structure of the date vector table:

Base+16  Vector of the routine for reading/setting the RTC
Base+18  Vector of last access stamp routine
Base+20  Vector of the routine for creatioî stamp
Base+22  Vector of the routine for the modifieä stamp
Base+24  Vector of routine to get stamp
Base+26  Vector of routine to put stamp
Base+28  Vector of the dummy routine
Base+30  Address of the routine for removing the date stamp

.cp 7
.tc   4.4 Routines to support time and date stamps ............... #
4.4 Routines to support time and date stamps

ZSDOÓ anä ZDDOÓ diffeò siçnificantlù witè regarä tï thå  routineó 
foò suğporôinç timå anä datå stamps® DatåStamperTM” ió alreadù iî
tegrateä  iî  ZDDOS¬ sï thaô onlù onå clocë driveò  ió  required® 
ZSDOÓ  doeó noô includå á stamğ routine® Botè aî  externaì  clocë 
driveò anä aî externaì stamğ routinå arå requireä foò operation.

Differenô formó oæ datå stampó arå possiblå witè ZSDOS® Supporteä 
methodó includå Plu*Perfect'ó DatåStamperTM” anä P2DOÓ (coípatiblå 
witè CP/Í Plus© datå stamps® Aó lonç aó nï coòresponäinç  routinå 
foò suğporôinç datå stampó ió installeä iî thå ZSDOÓ system¬  thå 
datå  stampó cannoô bå activated® Iô ió noô necessarù tï  instalì 
sucè  routineó  tï operatå ZSDOS® Theù arå onlù requireä  iæ  yoõ 
wanô tï uså functionó 98¬ 99¬ 10² anä 103.

Dependinç oî thå desireä stampinç method¬ differenô routineó  arå 
required®  Witè thå iîtegrateä DatåStamperTM” support¬ ZDDOÓ  onlù 
allowó  thå uså oæ thió method® Witè ZSDOS¬ DatåStamperTM¬  P2DOÓ 
oò  botè typeó oæ stampó caî bå used® Driveró foò otheò  stampinç 
methodó  caî bå programmeä anä easilù iîtegrateä intï ZSDOS®  Foò 
thió  purpose¬  ZSDOÓ onlù provideó  defineä  coîneãtioî  points¬ Šwhilå  thå  actuaì routinå ió locateä outsidå thå  BDOÓ  segment¬ 
typicallù  abovå thå BIOS® Iô ió baseä oî thå samå philosophù  aó 
ZCPÒ ­ optionaì partó oæ thå systeí arå moveä tï reserveä  buffeò 
areaó abovå thå BIOS.

ZSDOÓ  doeó  mosô  oæ  thå detaiì  worë  foò  thå  routines®  Thå 
requesteä  FCÂ ió copieä intï thå directorù buffer¬ thå  disë  ió 
checkeä  foò read/writå statuó iæ necessary¬ thå DMÁ  buffeò  anä 
thå offseô oæ thå directorù buffeò arå provideä accordinç tï  thå 
method.

Duå tï thå closå coîneãtioî oæ thå DOÓ witè thå routineó foò datå 
stamping¬ thå averagå memorù råquiråmenô foò DatåStamperTM” witè á 
reaì-timå  clocë driveò undeò ZSDOÓ ió approx® 3/´ kBytå  ­  mucè 
lesó  thaî  witè  earlieò DatåStampers® Witè ZDDOÓ  anä  thå  iî
tegrateä  DatåStamperTM¬ thå memorù råquiråmenô ió  reduceä  eveî 
further¬ sincå onlù thå clocë driveò ió missing® Thió ió  usuallù 
lesó  thaî 40° bytes® Iæ á clocë driveò ió alreadù  availablå  iî 
thå system¬ nï addétioîaì storagå spacå ió requireä undeò ZDDOS.

ZSDOÓ  comeó witè speciaì driveró foò DateStamperTM¬ P2DOÓ  (CP/Í 
Pluó  coípatible©  anä tï supporô botè formats® Thå  driveró  foò 
botè  methodó  eacè reaä á formaô anä writå both® Theù  arå  paò
ticularlù iîteòesôinç foò useró whï requirå thå highesô leveì  oæ 
coípatibilitù betweeî CP/Í Pluó anä ZSDOÓ systems.
.paŠ.tc
.tc 5 ZSDOS function calls ....................................... #
5 ZSDOS function calls

.tc   5.1 Description of the returned values ..................... #
5.1 Description of the returned values

Thå  ZSDOÓ  functionó returî valueó tï indicatå  thå  succesó  oò 
erroró thaô occurreä wheî executinç thå function® Therå arå  fivå 
categorieó  oæ  theså  codeó  ­  directorù  codes¬  erroò  codes¬ 
time/datå  codes¬ read/writå codeó anä extendeä erroò codes®  Thå 
followinç overvie÷ showó thå returneä valueó oæ thå codeó oæ eacè 
category:

.cp 4
Directory code:

        A = 00H, 01H, 02H, 03H if no error has occurred
        A = 0FFH, in the event of an error

.cp 4
Error code:

        A = 00H, no error
        A = 0FFH, error occurred

.cp 4
Time/date code:

        A = 01H if no error has occurred
        A = 0FFH, error occurred

.cp 10
.cp 11
Read/write code:

.lm 18
.pm 9
.oj off
        A = 00H, if no error has occurred
        A = 01H, read - end of file write - directory full
        A = 02H, floppy disk full
        A = 03H, error while closing on random read/write
        A = 04H, empty record for random reading
        A = 05H, directory full of random writing
        A = 06H, randoí acesó recorä numbeò durinç randoí 
                 reading/writinç toï large
.of on
.pm 1
.lm 1

.cp 7
extended error codes in error mode:

.lm 18
.pm 9
.oj off
        A = 0FFH, further error codes in H
        H = 01H, disk I/O error (defective sector)
        H = 02H, floppy disk write-protected (read only)
        H = 03H, file read-only
        H = 04H, illegal drive selected
.oj on
.pm 1
.lm 1

Thå  followinç  functioî  descriğtionó  sho÷  whicè  valueó   arå 
returneä  bù  eacè function® Thå onlù exceptioî ió  thå  extendeä 
erroò codeó thaô arå returneä bù anù functioî thaô performó  disë 
access® However¬ theså extendeä codeó arå onlù returneä iæ onå oæ 
thå  twï  modeó foò returninç thå erroò codå haó beeî  seô  usinç 
functioî 41.
.paŠ.tc   5.2 Functional description ................................. #
5.2 Functional description

.tc       Function 0 - Terminate Program ......................... #
+---------------------------------------------------------------+
|                Function 0 - Terminatå Prograí                 |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   none                        |   none                        |
+-------------------------------+-------------------------------+

Thió  call¬ whicè ió rarelù used¬ clearlù diótiîguisheó  iô  froí 
ağplicátioî programs® Iæ thió functioî ió called¬ ZSDOÓ  executeó 
á RSÔ ° commanä iîteònally® Iî á ROÍ-baseä ZSDOÓ system¬ thå  RAÍ 
datá segmenô ió inétializeä anä loadeä witè thå defaulô values.

Mosô  prograímeró  uså aî REÔ commanä (iæ thå CCĞ  haó  noô  beeî 
oveòwriôten©  oò á jumğ tï addresó ° tï enä theiò program®  Funã
tioî  ° ió á onå-waù streeô ­ iô doeó noô returî tï  thå  callinç 
program.

Thå  resulô  oæ thió calì correspondó tï thå warí  starô  oæ  thå 
systeí  ­ alì driveó witè exchangeablå mediá arå reset¬  thå  DMÁ 
addresó  ió  seô tï 80H¬ thå CCĞ ió reloadeä (unlesó iô  ió  prï
tecteä bù aî RSX© anä controì ió tranóferreä tï it® Iî  addition¬ 
thå  ZSDOÓ  erroò modå ió reseô tï thå defaulô  bù  callinç  thió 
function.

DONEº   LÄ      C,0
        CALÌ    BDOÓ            ; One-way street - no way back
.paŠ.tc       Function 1 - Console Input Byte ........................ #
+---------------------------------------------------------------+
|                Function 1 - Console Inpuô Bytå                |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   no                          |   A = character               |
+-------------------------------+-------------------------------+

Thió functioî returnó thå nexô characteò froí thå console® Iæ  nï 
characteò ió availablå wheî thió functioî ió called¬ ZSDOÓ  waitó 
foò  aî  inpuô  beforå  returninç tï  thå  callinç  program®  Thå 
returneä  characteò  ió  outpuô  oî  thå  console¬  witè  controì 
characteró beinç filtered.

Carriagå  returî (0DH)¬ linå feeä (0AH© anä backspacå  (08H©  arå 
reproduceä  unchanged® Alì taâ stopó (09H© arå converteä  tï  thå 
correspondinç numbeò oæ spaceó iî ordeò tï positioî thå cursoò oî 
thå  nexô  columî  thaô caî bå divideä bù 8®  Alì  otheò  controì 
characteró arå noô displayeä oî thå console.

Controì-Ó ió intercepteä bù thió functioî anä treateä aó followsº 
Iæ  á  Controì-Ó  waó detected¬ alì outputó tï  thå  consolå  arå 
stoppeä untiì anù otheò characteò (excepô Controì-C© ió  entered® 
Afteò   that¬  consolå  outpuô  continues®  Iæ  á  Controì-Ã   ió 
recognizeä afteò enterinç Controì-S¬ ZSDOÓ resetó thå erroò  modå 
tï thå defaulô modå anä theî carrieó ouô á warí start.

CONINº  LÄ      C,1
        CALÌ    BDOÓ            ; next char from the console
        ..®                     ; Character is now in register A
.paŠ.tc       Function 2 - Console Output Byte ....................... #
+---------------------------------------------------------------+
|               Function 2 - Console Outpuô Bytå                |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   E = character               |   none (A = BIOS A register)  |
+-------------------------------+-------------------------------+

Thå  characteò containeä iî registeò Å ió outpuô tï  thå  currenô 
consolå  devicå witè thió function® Aó witè functioî 1¬  alì  taâ 
stopó  arå converteä tï spaces¬ sï thaô thå cursoò ió  positioneä 
oî thå nexô columî thaô caî bå divideä bù 8.

Thå consolå inpuô functioî controló thió functioî wheî á Controì-
S  occurs®  Iæ á Controì-Ó haó beeî entered¬ thå  outpuô  tï  thå 
consolå  wilì  bå  blockeä  untiì  anù  otheò  characteò  (excepô 
Controì-C©  ió entered® Iæ á Controì-Ã ió entereä afteò  enterinç 
Controì-S¬  ZSDOÓ resetó thå erroò modå tï thå defaulô  modå  anä 
theî carrieó ouô á warí start.

Noteº  Thió functioî shoulä noô bå useä tï outpuô  videï  controì 
characteró  becauså  certaiî  controì  characteró  arå  filtered® 
Functioî ¶ shoulä bå useä foò theså purposes.

CONOUTº LÄ      E,Á             ; suppose the chaò is in A
        LD      C,²             ; Select function console output
        CALL    BDOÓ            ; Send characters to the console
        ...
.paŠ.tc       Function 3 - Reader Input .............................. #
+---------------------------------------------------------------+
|                   Function 3 - Readeò Inpuô                   |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   none                        |   A = character               |
+-------------------------------+-------------------------------+

Thió functioî fetcheó thå nexô characteò froí thå currenô  readeò 
inpuô  devicå  (RDR:)®  Iæ nï characteò ió  availablå  wheî  thió 
functioî ió called¬ ZSDOÓ waitó foò aî inpuô beforå returninç  tï 
thå  callinç program® Iæ nï devicå ió defineä foò  readeò  input¬ 
thå  returneä  valuå dependó oî thå dummù routinå  oæ  thå  BIOS® 
Controì characteró arå noô filtereä bù thió functioî call.

Iî earlieò BDOÓ systemó sucè aó CP/Í 2.2¬ thå "papeò tapå reader¢ 
waó  defineä aó thå devicå foò thå readeò input® Thió terí  comeó 
froí  thå  timå  wheî papeò tapå waó á  commoî  mediuí  foò  datá 
storage.

Thå inpuô froí thå readeò devicå coulä bå somethinç likå this:

AUXIN:  LD      C,3
        CALL    BDOÓ            ; next char froí thå reader
        ..®                     ; Character is now in register A
.paŠ.tc       Function 4 - Punch Output .............................. #
+---------------------------------------------------------------+
|                   Function 4 - Puncè Outpuô                   |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   E = character               |   none (A = BIOS A register)  |
+-------------------------------+-------------------------------+

Thå  puncè ouôpuô functioî sendó thå characteò iî registeò  Å  tï 
thå  currenô puncè outpuô devicå (PUN:)® Beforå thå characteò  ió 
sent¬ thå functioî waitó foò thå devicå tï bå ready.

Iî earlieò BDOÓ systemó sucè aó CP/Í 2.2¬ papeò tapå waó á commoî 
mediá foò datá storage¬ anä thå "punch¢ waó á papeò tapå punch® 

Á characteò caî bå senô tï thå puncè outpuô devicå aó follows:

AUXOUT: LD      E,Á             ; suppose the chaò is in A
        LD      C,´             ; Select puncè output
        CALL    BDOÓ            ; ... and send characters
        ...
.paŠ.tc       Function 5 - List Output Byte .......................... #
+---------------------------------------------------------------+
|                 Function 5 - List Outpuô Bytå                 |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   E = character               |   none (A = BIOS A register)  |
+-------------------------------+-------------------------------+

Thå  characteò  containeä  iî registeò Å ió  transferreä  tï  thå 
currenô  lisô  devicå (LST:)® Thå BIOÓ functioî foò  lisô  outpuô 
waitó  foò thå devicå tï bå readù beforå thå characteò ió  tranó
ferreä anä returneä tï thå BDOS® Thå BDOÓ doeó noô calì thå  BIOÓ 
routinå  foò queryinç thå lisô outpuô statuó beforå  sendinç  thå 
byte.

LIST:   LD      E,Á             ; suppose the chaò is in A
        LD      C,µ             ; Select list output
        CALL    BDOÓ            ; ... and send characters
        ...
.paŠ.tc       Function 6 - Direct Console I/O ........................ #
+---------------------------------------------------------------+
|                Function 6 - Direct Console I/Ï                |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   E = 0FFH (input)            |   A = input char (00=none)    |
|   E = 0FEH (input)            |   A = cons. status (00 = none)|
|   E = 0FDH (input)            |   A = input char              |
|   E = 0..0FCH (output)        |   none (A = BIOS A register)  |
+-------------------------------+-------------------------------+

Thió functioî calì (sometimeó alsï calleä DCIÏ foò short© ió useä 
tï bypasó thå normaì filtereä inpuô anä outpuô oæ thå BDOÓ anä tï 
communicatå  directlù  witè thå consolå viá  thå  BIOÓ  routines® 
Normally¬ videï controì sequenceó arå transmitteä tï thå terminaì 
witè thió function.

Iî ZSDOÓ somå shortcomingó oæ thå CP/Í 2.² BDOÓ werå fixed¬ wherå 
calló oæ functioî ¶ werå mixeä witè thå normaì BDOÓ consolå inpuô 
oæ functioî 1® Thió affectó thå internaì characteò buffeò oæ  thå 
DOÓ iæ Controì-Ó characteró arå useä tï starô anä stoğ thå screeî 
output®  Eacè  timå functioî ¶ ió calleä foò characteò  inpuô  oò 
statuó  query¬  ZSDOÓ  checkó thå characteò buffeò  iî  ordeò  tï 
alwayó providå correcô resultó wheî readinç thå console® Aô  thió 
poinô  wå woulä likå tï thanë Bridgeò Mitchell¬ whï  pointeä  ouô 
thå peculiaritù oæ CP/Í sï thaô wå werå ablå tï eliminatå it.

Witè  thå  valuå iî registeò E¬ functioî calì ¶ iî CP/Í  2.²  anä 
ZSDOÓ systemó determinå thå consolå functioî tï bå performed® Alì 
returneä  valueó arå madå availablå iî registeò A® Thå  followinç 
valueó arå defineä foò registeò E:

.pm 1
.lm 10
.oj off
0FFH     geô thå nexô characteò froí thå consolå oò ° iæ nï 
         characteò ió available

0FEH     querù thå statuó oæ thå console» ° indicateó thaô nï 
         characteò ió available

0FDH*    waiô foò thå nexô characteò froí thå consolå anä returî 
         it

0..0FCH* Outpuô oæ thå characteò iî registeò Å oî thå console

         ª ½ ne÷ oò changeä functionó iî ZSDOS
.oj on
.lm 1
.pm 1

Thå  functioî addeä (0FDH© correspondó tï thaô oæ CP/Í  Pluó  anä 
provideó á morå convenienô routinå foò "geô nexô character".

OLDCODE:LÄ      E,0FEÈ          ; Query console status
        LD      C,6
        CALL    BDOS
        AND     Á               ; anything arrived?
        JÒ      Z,OLDCODÅ       ; ... no, repeat
        LD      E,0FFH
        LD      C,6
        CALL    BDOÓ            ; finally ready, pick it upŠ        ..®                     ; Characters now in A

; new method with ZSDOS ...

NEWCODE:LÄ      E,0FDÈ          ; get next character
        LD      C,¶             » aó sooî aó it'ó there
        CALL    BDOS
        ..®                     ; Character now in A
.paŠ.tc       Function 7 - Get IOBYTE ................................ #
+---------------------------------------------------------------+
|                    Function 7 - Get IOBYTÅ                    |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   none                        |   A=IOBYTE (system page+03H)  |
+-------------------------------+-------------------------------+

Thió functioî returnó thå valuå oæ thå currenô IOBYTÅ iî registeò 
A® Thå IOBYTÅ ió aî optionaì anä BIOÓ-dependenô structure® Iô caî 
bå  useä  tï redirecô bytå-orienteä I/Ï oæ  thå  logicaì  deviceó 
CON:¬  RDR:¬  PUNº  anä LST:® Pleaså  refeò  tï  youò  computer'ó 
manualó tï determinå thå exacô specificátionó foò youò system.

Note:“  Thió  functioî calì maù nï longeò bå availablå  iî  futurå 
ZSDOÓ versions.

GETIOB: LD      C,·             ; get IOBYTE
        CALL    BDOÓ            ; ... is returned in A.
        ...
.paŠ.tc       Function 8 - Set IOBYTE ................................ #
+---------------------------------------------------------------+
|                    Function 8 - Set IOBYTÅ                    |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   E = IOBYTE                  |   none (A = IOBYTE)           |
+-------------------------------+-------------------------------+

Thió  functioî  setó thå IOBYTÅ tï thå valuå iî registeò  E®  Thå 
IOBYTÅ  ió  aî optionaì anä BIOÓ-depeîdenô structure® Iô  caî  bå 
useä  tï redirecô bytå-orienteä I/Ï oæ thå logicaì deviceó  CON:¬ 
RDR:¬  PUNº anä LST:® Pleaså refeò tï youò computer'ó manualó  tï 
determinå thå exacô specificátionó foò youò system.

Note:“  Thió  functioî calì maù nï longeò bå availablå  iî  futurå 
ZSDOÓ versions.

SETIOB: LD      E,Á             ; suppose IOBYTE is in A
        LD      C,8
        CALL    BDOÓ            ; set IOBYTE
        ...
.paŠ.tc       Function 9 - Console Output String ..................... #
+---------------------------------------------------------------+
|              Function 9 - Consolå Output Strinç               |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = address of the string, |   none (A = '$')              |
|   that ends with '$'          |                               |
+-------------------------------+-------------------------------+

Á characteò strinç consistinç oæ ASCIÉ characteró thaô endó  witè 
á  dollaò sigî '$§ ió outpuô witè thió functioî oî  thå  console® 
Alì characteró iî thå chaiî witè thå exceptioî oæ thå dollaò sigî 
arå tranóferreä tï thå console® Alì taâ stopó arå converteä tï  á 
coòresponäinç numbeò oæ spaceó iî ordeò tï positioî thå cursoò oî 
thå nexô columî thaô caî bå divideä bù 8.

Thå  consolå  ió  checkeä foò thå inpuô oæ  Controì-Ó  whilå  thå 
strinç ió beinç output® Iî thió case¬ thå outpuô ió stoppeä untiì 
anotheò characteò ió entereä anä theî continued® Iæ Controì-Ó  ió 
followeä bù Controì-C¬ ZSDOÓ resetó thå erroò modå tï thå defaulô 
anä  theî  performó á warí start® Iî thió way¬ thå useò  caî  enä 
faultù programó withouô peòforíinç á colä start.

STROUT: LD      DE,STRINÇ       ; what you want to display
        LD      C,¹             ; Select string output
        CALL    BDOS
        ...
STRINGº DEFÂ    'This is a string. $'
        ...
.paŠ.tc       Function 10 - Console Input Line ....................... #
+---------------------------------------------------------------+
|               Function 10 - Consolå Inpuô Linå                |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = address input buffer   |   none (A = 0DH)              |
+-------------------------------+-------------------------------+

Thió  functioî returnó á characteò strinç froí thå currenô  inpuô 
devicå  oæ  thå console® Thå calleò mysô pasó thå pointeò  tï  aî 
inpuô buffer® Thió buffeò ió coîfigureä aó follows:

.lm 9
BUFF+0  sizå  oæ thå buffeò foò thå maximuí numbeò oæ  characteró 
        tï bå reaä (maximuí 255)
BUFF+1  actuaì  numbeò  oæ  reaä characteró  (seô  bù  BDOÓ  wheî 
        returning)
BUFF+²  up to max. Length+2 characters from the console
.lm 1

Somå controì characteró arå availablå iî functioî 1° foò  editinç 
thå inpuô line:

        ^È      deletes characters to the left of the cursor

        ^Ê      ends the entry

        ^Í      ends the entry

        ^Ø      deletes the entire line

        ^Õ      as ^X

        ^Ò      rewrites current line (ZSDOS only)

        DEÌ     as ^H

Alì  taâ  stopó arå converteä tï spaceó bù functioî 1°  (aó  witè 
functionó  1¬  ²  anä  9)¬ buô onlù foò screeî  outpuô  ­  ^É  ió 
retaineä iî thå buffer® ZSDOÓ rememberó thå cursoò positioî  wheî 
thió functioî waó called¬ sï thaô tabó arå expandeä properlù  (aó 
lonç  aó  somethinç waó noô outpuô witè functioî ¶  oî  thå  samå 
line)®  Thå noî-printablå controì characteró (alì excepô taâ  anä 
ediô  controì characters© arå converteä intï twï  characteró  foò 
thå  screeî output® Thå firsô characteò ió á careô '^'¬  followeä 
bù  thå  controì character+40H® Foò example¬ Controì-Ú  woulä  bå 
displayeä aó '^Z'.

Thå  functioî recognizeó Controì-Ğ anä switcheó thå printeò  flaç 
aãcoräingly® Controì-Ó (tï stoğ consolå output© ió noô recognizeä 
bù thió function.

Function 10 ends in the following cases:

.pm 1
.lm 4
1. Enteò (Carriagå Return© oò linå feeä waó pressed.

2. Thå inpuô buffeò ió full.
Š3. Iæ thå firsô characteò entereä iî thå linå ió á Controì-C¬ thå 
   prograí  ió  terminateä anä thå systeí ió restarted®  Iî  thió 
   caså  thå  Controì-Ã remainó iî thå buffeò sï  thaô  thå  ZCPÒ 
   commanä processoò doeó noô geô mixeä up.
.lm 1
.lm 1

Wheî  returninç tï thå callinç program¬ thå numbeò oæ  characteró 
reaä ió entereä iî BUFF+1® Thå characteò strinç itselæ startó  aô 
BUFF+2®  Notå thaô Enteò oò linefeeä arå read¬ buô dï noô  appeaò 
iî thå buffer.

An example of using function 10:

BUFFRD: LD      DE,BUFÆ         ; Pointer to the text buffer
        LD      C,1°            ; Read console buffer function
        CALL    BDOS
        ...
                                ; Structure total of 128 chars
BUFFº   DEFÂ    12¶             ; Max.B 126 characters are read
        DEFÂ    °               ; actual number here from ZSDOS
        DEFÓ    12¶             ; actual buffer area
        ...
.paŠ.tc       Function 11 - Console Status Check ..................... #
+---------------------------------------------------------------+
|              Function 11 - Console Statuó Checë               |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   none                        |   A = 0, no character         |
|                               |   A = 1, character available  |
+-------------------------------+-------------------------------+

Thió  functioî  ió  useä tï querù thå consolå  devicå  whetheò  á 
characteò haó beeî entered® ZSDOÓ returnó thå valuå ° iî registeò 
Á iæ nï characteò ió availablå oò thå valuå ± iî thå otheò case.

CONST:  LD      C,1±            ; Check console status
        CALL    BDOÓ            ; returns status in A.
        AND     Á               ; something available?
        JÒ      Z,NOCHAÒ        ; ... jump if there is no char.
        ...
.paŠ.tc       Function 12 - Get System Identification ................ #
+---------------------------------------------------------------+
|            Function 12 - Get Systeí Identificatioî            |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   none                        |   HL = 22H (CP/M compatible)  |
+-------------------------------+-------------------------------+

Thió  functioî returnó thå valuå 22È iî thå HÌ registeò  paiò  tï 
indicatå coípatibilitù witè CP/Í 2.2® Functioî 4¸ musô bå useä tï 
querù thå versioî oæ ZSDOS.

Iî  thå  caså  oæ ZDDOÓ oò ZSDOÓ  witè  DatåStamperTM”  installed¬ 
iæ  registeò Ä containeó thå valuå 'D§ (044H© wheî thió  functioî 
ió  called¬  thå  addresó oæ thå  DatåStamperTM”  ió  returneä  iî 
registeò  paiò  DÅ  anä thå ASCIÉ characteò 'D§  ió  returneä  iî 
registeò H® Thió functionalitù ensureó thaô softwarå writteî  foò 
Plu*Perfect'ó  DatåStamperTM”  alsï  runó  undeò  ZSDOS®  Programó 
speciallù  adapteä  tï ZSDOÓ should¬ however¬  uså  thå  functioî 
calló  froí ZSDOÓ tï accesó thå clocë anä datå stamğ  insteaä  oæ 
thå olä DatåStamperTM” method.

GETCPV: LD      C,12
        CALL    BDOÓ            ; Get CP/M version number
        ...
.paŠ.tc       Function 13 - Reset All Drives ......................... #
+---------------------------------------------------------------+
|                Function 13 - Reset Alì Driveó                 |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   none                        |   A = 0, no file named $*.*   |
|                               |   A = 0FFH, file named $*.*   |
|                               |       available               |
+-------------------------------+-------------------------------+

Functioî 1³ logó ouô alì driveó anä resetó thå addresó oæ thå DMÁ 
buffeò  tï 80H® Drivå Á ió seô aó thå defaulô drive® Thå  currenô 
useò areá ió noô changed® Beforå callinç thió function¬ alì fileó 
intï whicè datá haó beeî writteî musô bå closed.

Thå  CCĞ  useó aî uîdocõmenteä propertù oæ CP/Í  2.²  tï  procesó 
submiô files® Everù timå á drivå ió reseô oò selecteä undeò CP/M¬ 
registeò Á containó thå valuå 0FFH¬ provideä á filå nameä $*.ª ió 
availablå  oî thå drivå iî thå currenô useò area®  Thió  returneä 
valuå  ió useä bù thå CCP® Iô showó wherå thå $$$.SUÂ filå  coulä 
bå  located®  Thå commanä processoò theî obtainó thå  nexô  inpuô 
linå noô froí thå user¬ buô froí thió file.

Severaì  DOÓ  systemó thaô skiğ logginç iî froí harä  diskó  havå 
diæficultù  passinç thió flaç correctlù tï thå CCP® ZSDOÓ  checkó 
foò  thå presencå oæ á filå calleä $*.ª eacè timå iô logó iî  anä 
wheî  fileó arå createä anä deleted® Thå flaç ió seô wheî á  filå 
nameä $*.ª oó createä oò diócovereä wheî logginç iî (tï anù  useò 
area)® Thå flaç ió reseô wheî thå $*.ª filå haó beeî suãcesófullù 
deleted®  Witè thió procedure¬ thå submiô flaç  alwayó  correctlù 
reflectó thå presencå oæ á $*.ª filå iî thå systeí ­ eveî iæ fasô 
rå-logiî ió activated.

Sincå thió methoä doeó noô fullù corresponä tï CP/Í 2.2¬ thå  CCĞ 
caî onlù functioî properlù aó lonç aó therå arå noô severaì fileó 
nameä $*.ª iî thå systeí (actuallù verù unlikely!).

Iî  contrasô tï functioî 13¬ whicè logó ouô alì drives¬  functioî 
3·  workó iî á morå differentiateä manner® Thió wilì  onlù  reseô 
selecteä  drives®  Programó  shoulä  thereforå  uså  functioî  3· 
insteaä  oæ 1³ iæ possible® Becauså changeä diskó arå  loggeä  iî 
automatically¬  iô  ió  rarelù necessarù tï reseô  driveó  oò  tï 
distinguisè betweeî fixeä anä removablå diskó wheî workinç  undeò 
ZSDOS.

RESSYS: LD      C,13
        CALL    BDOÓ            ; Running reset, A: log in
        AND     Á               ; Submit file available?
        JÒ      NZ,DOSUÂ        ; ... yes, so open the file
        ...
.paŠ.tc       Function 14 - Select Drive ............................. #
+---------------------------------------------------------------+
|                  Function 14 - Select Drivå                   |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   E = drivå numbeò            |   A = 0, no file named $*.*   |
|      (0 = A, 1 = B ..)        |   A = 0FFH, file named $*.*   |
|                               |       available               |
+-------------------------------+-------------------------------+

Thió  functioî  ió useä tï selecô á defaulô  drive®  Thå  defaulô 
drivå  ió accesseä iæ nï drivå ió specifieä iî thå FCÂ  foò  filå 
access® Iæ thå selecteä drivå haó noô yeô beeî loggeä in¬ thió ió 
alsï donå usinç functioî 14.

Iæ onå oæ thå extendeä erroò modeó oæ ZSDOÓ ió active¬ thå  valuå 
0FFÈ  iî  thå registeò doeó noô neceósarilù  indicatå  aî  error® 
Rather¬  thå contenô oæ registeò È musô bå checked® Iæ thå  valuå 
iî  È  ió zero¬ theî nï erroò haó occurred¬ buô  ZSDOÓ  indicateó 
thaô á submiô filå coulä bå presenô oî thå drive® Iæ thå valuå iî 
registeò  È  ió  noô  zero¬ theî therå waó  á  probleí  witè  thå 
selectioî  oæ  thå drivå (generallù thió meansº  drivå  doeó  noô 
exist!).

Iæ  nï extendeä erroò modå ió activå anä thå specifieä drivå  waó 
noô  found¬  ZSDOÓ terminateó thå ağplicátioî prograí  afteò  thå 
coòresponäinç erroò messagå haó beeî issued.

Iô  shoulä alsï bå noteä thaô CP/Í 2.² anä alì  otheò  compatiblå 
BDOÓ suâstituteó (witè thå exceptioî oæ ZRDOÓ 1.9© havå aî  erroò 
iî  thió routine® Iæ á drivå thaô ió noô availablå waó  selected¬ 
thå BDOÓ stilì assumeó thaô thå unavailablå drivå ió thå  defaulô 
drive®  Thió  erroò doeó noô appeaò iî normaì CP/Í  2.²  systems¬ 
sincå thå BIOÓ reloadó thå CCĞ anä thå firsô BDOÓ calì madå  reğ
råsentó  á separatå selection® NZCOÍ useó thå BDOÓ tï reloaä  thå 
CCP¬ whicè causeó thå erroò tï appear.

; this source text assumes that a
; extended error mode is ACTIVE (return BDOS error)

SELDK:  LD      E,Á             ; suppose A contains drive no.
        LD      C,14
        CALL    BDOÓ            ; Select drive
        AND     A
        REÔ     Ú               ; back if no error occurred
        LD      A,H
        AND     Á               ; Does 0FFH stand for submit file?
        REÔ     Ú               ; was a submit file, Lw. OK
        ..®                     ; otherwise drive not allowed
.paŠ.tc       Function 15 - Open Existing File ....................... #
+---------------------------------------------------------------+
|               Function 15 - Open Existinç Filå                |  
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = address of the FCB     |   A = directory code          |
+-------------------------------+-------------------------------+

Compareä  tï  otheò  Z8° BDOÓ systems¬  ZSDOÓ  offeró  á  greatlù 
expandeä functioî foò openinç files® Aó mentioneä earlier¬  ZSDOÓ 
caî  uså thå publiã filå attributå anä thå patè tï opeî thå  filå 
(botè  foò  readinç anä writing)® Iæ á filå waó  openeä  suãcesó
fully¬ FCB+1³ containó thå useò areá number¬ OReä witè 80H:

FOPEN:  LD      A,(USER)
        LD      E,Á             ; User area of the file
        LD      C,3²            ; Function call set user area
        CALL    BDOS
        LD      DE,FCB
        LD      C,15
        CALL    BDOÓ            ; open file
        INÃ     A
        JĞ      Z,ERROÒ         ; Error when opening the file
        ..®                     ; FCB+13 = user area
                                ; ... OR linked to 80H

Iî contrasô tï somå otheò ZSDOÓ functions¬ thió doeó noô uncoîdé
tioîallù accepô thå useò areá numbeò iî FCB+13® Digitaì  Researcè 
originallù  declareä thå S± bytå oî FCB+1³ aó "reserveä  foò  thå 
system"®  However¬ iô waó noô specifieä whetheò thå bytå musô  bå 
seô  tï  á certaiî valuå iî ordeò tï opeî á  file®  Becauså  manù 
programó  reuså FCBs¬ thió fielä caî contaiî á valiä numbeò  (anä 
ofteî iô is)¬ buô foò thå formeò file¡ Afteò manù eøperéments¬ wå 
decideä  thaô thå safesô waù woulä bå iæ ZSDOÓ ignoreä thå  valuå 
oî  FCB+1³ wheî openinç thå file¬ iæ thå erroò modå oæ  thå  BDOÓ 
waó zero® Thió ió thå onlù reliablå waù tï supporô thå useò  areá 
numbeò iî thå FCÂ anä stilì remaiî backwardó coípatible.

Programó  thaô arå writteî tï worë undeò ZSDOÓ shoulä  initializå 
alì  byteó  froí FCB+° tï FCB+0EH® Iî additioî tï thå  drivå  anä 
filå  namå entries¬ thå valuå oæ thå S± bytå musô bå seô tï  zerï 
oò thå useò areá numbeò OReä witè 80H® Iî addition¬ thå byteó  oæ 
thå  currenô  extenô (FCB+12)¬ thå datá modulå (FCB+14©  anä  thå 
currenô  recorä  (FCB+32© musô bå seô tï zero¬  unlesó  thå  filå 
shoulä  noô bå openeä aô thå beginning® Iô ió possiblå tï opeî  á 
filå witè anù extenô oæ thå firsô datá modulå (firsô 51² kBytes)® 
However¬  á  noî-zerï  valuå cannoô bå  specifieä  foò  thå  datá 
module.

Iæ yoõ wanô tï uså thå S± bytå iî aî ağplicátioî tï determinå thå 
useò areá wheî openinç á filå (oò anotheò filå-relateä function)¬ 
theî  thå BDOÓ erroò modå musô bå useä tï indicatå thaô  thå  ağ
plicátioî  knowó thå condétionó oæ ZSDOS® Onlù theî caî thå  useò 
areá  numbeò bå tranóferreä iî FCB+13® Iæ thå erroò modå waó  seô 
tï  á valuå noô equaì tï zero¬ ZSDOÓ useó thå fielä  FCB+1³  (seå 
functioî 45).Š
Afteò  á filå haó beeî suãcesófullù openeä witè functioî 15¬  thå 
S±  bytå  ió  eitheò seô tï thå useò areá OReä  witè  80È  oò  ió 
unchangeä  iæ thå erroò modå waó zero® Thå datá modulå numbeò  ió 
alwayó  seô tï zero® Thå filå name¬ thå recorä  counteò  (FCB+15© 
anä  thå  aìlocátioî  vectoò (FCB+16..31©  arå  copieä  froí  thå 
directorù entrù oæ thå coòresponäinç file® Thå fieldó oæ  extent¬ 
currenô recorä anä optionaì recorä arå retained.

Foò somå ağplicátionó iô ió importanô whetheò thå filå waó openeä 
viá patè oò publiã access® ZSDOÓ alsï provideó thió  iîformátion® 
Afteò  openinç  thå attributå biô f· ió seô iæ thå  patè  oò  thå 
attributå  publiã filå werå used® Thå codå coulä  looë  somethinç 
likå thió tï brancè ouô iî thå caså oæ patè oò publiã access:

        LD      C,15
        CALL    BDOÓ            ; open file
        INÃ     A
        JĞ      Z,ERROÒ         ; ... jump when an error occurs
        LD      HL,FCB+·        ; Pointer to the f7 bit
        BIÔ     7,(HL©          ; Path/public access test
        JÒ      NZ,ISPÓ         ; ... jump when used
        ...

Á  baä  prograíminç habiô ió tï movå thå FCÂ oæ á  filå  thaô  ió 
alreadù  open¬  oò  tï uså thå samå FCÂ multiplå  timeó  tï  opeî 
additionaì  files¬ aó lonç aó onå filå waó noô closeä beforå  thå 
nexô  waó opened® Pooò prograíminç practiceó caî  causå  problemó 
witè variouó populaò operatinç systeí extensionó sucè aó BGii.
.paŠ.tc       Function 16 - Close Output File ........................ #
+---------------------------------------------------------------+
|                Function 16 - Close Outpuô Filå                |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = address of the FCB     |   A = directory code          |
+-------------------------------+-------------------------------+

Witè thió function¬ alì internaì bufferó arå tranóferreä tï  disë 
anä  thå directorù ió updateä wheî á filå haó beeî writteî to®  Á 
gooä prograíminç stylå alsï includeó closinç fileó witè  functioî 
1¶  iæ theù werå onlù opeî foò reading® Thió ió thå onlù  waù  tï 
guaranteå  fulì coípatibilitù witè futurå versionó oæ  ZSDOÓ  anä 
otheò operatinç systeí extensions.

FCLOSE: LD      DE,FCÂ          ; Pointer to the file to be closed
        LD      C,16
        CALL    BDOÓ            ; Close file
        INÃ     Á               ; everything OK?
        JÒ      Z,ERROÒ         ; ... jump when an error occurs
        ...
.paŠ.tc       Function 17 - Search for First Entry ................... #
+---------------------------------------------------------------+
|             Function 17 - Search for Firsô Entrù              |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = address of the FCB     |   A = directory code          |
+-------------------------------+-------------------------------+

Thió  functioî  returnó  thå  firsô  oãcuòrencå  oæ  á   matchinç 
directorù entry® Thå matcè ió baseä oî thå firsô 1³ byteó oæ  thå 
FCÂ (drive¬ name¬ anä extenô number© aó welì aó oî thå useò  areá 
numbeò  (eitheò bù defaulô oò viá thå contenô oæ FCB+13© anä  thå 
datá modulå numbeò (FCB+14© iæ á '?§ ió entereä there® Thå searcè 
ió  alwayó starteä aô thå beginninç oæ thå  directory®  Wildcardó 
arå  alloweä iî thå firsô 1³ byteó oæ thå FCÂ (FCB+0..12© anä  iî 
thå datá modulå number.

Questioî markó arå useä iî twï wayó bù thå Searcè foò Firsô Entry
anä Searcè foò Nexô Entrù functions® First¬ á '?§ caî bå useä  iî 
byteó  FCB+± tï FCB+1´ tï matcè anù characteò foò thió  position® 
Foò  example¬ iæ yoõ enteò á questioî marë iî thå firsô  bytå  oæ 
thå filå namå (FCB+1)¬ alì fileó wilì bå founä regarälesó oæ  thå 
firsô  characteò (onlù thå otheò charaãteró iî thå filå namå  arå 
decisive)® Iæ yoõ uså questioî markó iî thå byteó foò extenô  anä 
datá module¬ alì physicaì extentó oæ thå filå oò fileó arå  founä 
aãcoräingly® Programó thaô calculatå thå filå sizå bù summinç alì 
extentó seô theså twï byteó tï '?'.

Foò  thå seconä waù oæ usinç questioî markó iî thå FCB¬ thå  bytå 
foò  thå drivå (FCB+0© ió assigneä á '?'® Iî thió case¬  however¬ 
noô  alì  driveó  arå  selecteä (aó yoõ  mighô  think)¬  buô  alì 
directorù  entrieó oæ thå defaulô drivå (includinç  entrieó  thaô 
havå alreadù beeî deleted).

Afteò  callinç  functioî  17¬ thå matchinç  directorù  recorä  ió 
copieä  intï  thå  currenô  DMÁ buffer®  Iæ  thå  directorù  codå 
returneä iî registeò Á ió shifteä µ placeó tï thå lefô anä  addeä 
tï  thå  baså addresó oæ thå DMÁ buffer¬ iô pointó tï  thå  firsô 
bytå oæ thå matchinç directorù entry.

SEARCF: LD      DE,DMAADDÒ      ; DMA address on own buffer
        LD      C,26
        CALL    BDOS
        LD      DE,FCÂ          ; seek this match
        LD      C,17
        CALL    BDOÓ            ; search for matches
        CP      0FFÈ            , Did it work?
        JÒ      Z,NOMAÔ         ; ... jump if there is no match
        ADÄ     A,A
        ADÄ     A,A
        ADÄ     A,A
        ADÄ     A,A
        ADÄ     A,Á             ; Multiply index by 32
        LD      L,A
        LD      H,°             ; Make word value out of it
        LD      DE,DMAADDÒ      ; Address of thå bufferŠ        ADÄ     HL,DÅ           ; HL points to agreement entry
        ...
.paŠ.tc       Function 18 - Search for Next Entry .................... #
+---------------------------------------------------------------+
|              Function 18 - Search for Nexô Entrù              |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   none                        |   A = directory code          |
+-------------------------------+-------------------------------+

Afteò á suãcesófuì searcè foò thå firsô entrù (functioî 17)¬ thió 
functioî ió useä tï searcè foò furtheò matcheó foò thå  specifieä 
FCÂ (onå foò eacè call)® Foò thió functioî tï worë correctly¬ twï 
condétionó musô bå metº 1© Thå "Searcè foò Firsô Entry¢  functioî 
musô  havå  beeî executeä foò thå firsô match® 2© Nï  otheò  BDOÓ 
calló   thaô  perforí  disë operátionó maù bå  madå  betweeî  thå 
Searcè foò Firsô Entrù anä Searcè foò Nexô Entrù calls® 

Witè twï exceptions¬ thå calì anä returî sequenceó corresponä  tï 
thoså  oæ functioî 17® Functioî 1¸ doeó noô requirå á pointeò  tï 
thå  FCB¬ sincå iô waó saveä internallù bù DOÓ afteò  thå  searcè 
foò  thå firsô entrù anä ió reused® Fuòtheòmore¬ registeò Ã  musô 
bå loadeä witè thå valuå 1¸ insteaä oæ 1· iî ordeò tï selecô  thå 
"Searcè foò Nexô Entry¢ function.
.paŠ.tc       Function 19 - Delete File .............................. #
+---------------------------------------------------------------+
|                   Function 19 - Delete Filå                   |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = address of the FCB     |   A = error code              |
+-------------------------------+-------------------------------+

Thió  functioî  deleteó  alì fileó froí  thå  floppù  disë  whoså 
directorù entrù coòrespondó tï thå tranóferreä FCB® Thå pråråqué
sitå  foò  this¬  however¬  ió thaô thå  disë  anä  file(s©  havå 
read/writå  statuó  anä  thå useò haó  alì  Wheeì  usagå  rights¬ 
provideä  thå Wheeì Protectioî attributå oæ thå filå ió set®  Thå 
functioî allowó thå uså oæ wilä cards.

Likå  CP/M¬  ZSDOÓ alsï identifieó deleteä fileó bù  settinç  thå 
bytå  oæ thå useò areá oæ thå fileó (DIR+0© tï 0E5È anä  deletinç 
thå  bitó oæ thå fileó iî thå allocatioî vector®  Thió  procedurå 
releaseó thå directorù entrieó foò ZSDOS¬ buô neitheò thå datá ió 
deleteä noò thå directorù assignmenô vectoò (DIR+16© ió  changed® 
Aó  lonç aó nï writå operationó arå carrieä out¬ iô ió  thereforå 
ofteî  possiblå tï undï thå deletioî procesó ("unerase")®  Tï  dï 
this¬  alì thå physicaì extentó oæ thå filå neeä tï  bå  searcheä 
foò  anä  theiò 0E5È changeä tï á peòmiósiblå useò  areá  number® 
Functioî  3· ió theî calleä tï causå thå allocatioî vectoò tï  bå 
revised.

FKILL:  LD      DE,FCÂ          ; what should be deleted
        LD      C,19
        CALL    BDOÓ            ; Execute delete
        INÃ     Á               ; everything OK?
        JÒ      Z,ERROÒ         ; ... jump in case of problems
        ...
.paŠ.tc       Function 20 - Sequential Read .......................... #
+---------------------------------------------------------------+
|                 Function 20 - Sequentiaì Reaä                 |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = address of the FCB     |   A = read/write code         |
+-------------------------------+-------------------------------+

Afteò á filå witè functioî 1µ haó beeî opened¬ thió functioî  caî 
bå  useä tï transfeò thå nexô 12¸-bytå recorä tï thå currenô  DMÁ 
buffer®  Iî  thå  FCB¬ thå entrieó foò thå  currenô  record¬  thå 
currenô extenô anä thå currenô datá modulå numbeò arå reviseä  tï 
providå  thå  nexô  positioî foò såqueîtiaì  access®  Bù  callinç 
functioî 2° again¬ thå nexô recorä caî bå reaä withouô  iîteòveî
tioî bù thå ağplicátioî program.

READS:  LD      DE,FCÂ          ; File must already be open
        LD      C,20
        CALL    BDOÓ            ; Read next record in DMA buffer
        AND     Á               ; Error occurred?
        JÒ      NZ,ERROÒ        ; ... jump if there were problems
        ...
.paŠ.tc       Function 21 - Sequential Write ......................... #
+---------------------------------------------------------------+
|                Function 21 - Sequential Writå                 |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = address of the FCB     |   A = read/write code         |
+-------------------------------+-------------------------------+

Thió  functioî ió thå counterparô tï functioî 2° ­ iô writeó  thå 
contenô  oæ thå currenô DMÁ buffeò oî disë tï thå specifieä  filå 
thaô  waó  previouslù openeä witè functioî 11® Iî  thå  FCB¬  thå 
entrieó  foò  thå  currenô record¬ thå  currenô  extenô  anä  thå 
datá  modulå numbeò arå reviseä tï providå thå nexô positioî  foò 
såqueîtiaì  access®  Ne÷ aósigîmenô blockó anä  ne÷  extentó  arå 
openeä oò createä aó necessary.

Witè  eacè writå accesó tï á filå viá thå functioî calì  21¬  thå 
"archive¢ attributå biô (t3© oæ thå firsô extenô ió cleareä  wheî 
thå  filå  ió  closeä viá functioî 16®  Á  targeteä  backuğ  witè 
programó sucè aó COPY¬ ZFILER¬ PPIP¬ DATSWEEĞ anä witè alì  otheò 
programó  thaô supporô thå archivå attributå ió possiblå viá  thå 
archivå attribute.

WRITS:  LD      DE,FCÂ          ; File must already be open
        LD      C,21
        CALL    BDOÓ            ; Write DMA buffer to disk.
        AND     Á               ; Error occurred?
        JÒ      NZ,ERROÒ        ; ... jump if there were problems
        ...

Becauså thå BDOÓ setó thå BIOÓ aìlocátioî vectoò oæ á datá  blocë 
beforå  såqueîtiaì oò randoí writing¬ iô caî happeî thaô thå  FCÂ 
assumeó aî inaämiósiblå statå iæ á "disë full¢ erroò occuró (codå 
0² returned)® Therefore¬ functioî 1¶ musô alwayó bå useä tï closå 
thå  file¬ whicè indicateó erroró thaô havå occurred®  Onlù  theî 
caî  furtheò BDOÓ operátionó (e.g® deletinç thå faultù  file©  bå 
carrieä out® Thå updateä FCÂ ió useä tï matcè thå BIOÓ aìlocátioî 
vector¬  whereaó thå coòresponäinç bitó oæ thå vectoò  arå  reseô 
afteò thå eraseä filå haó beeî deleted.
.paŠ.tc       Function 22 - Make New File ............................ #
+---------------------------------------------------------------+
|                  Function 22 - Makå Ne÷ Filå                  |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = address of the FCB     |   A = directory code          |
+-------------------------------+-------------------------------+

Thió  functioî createó á ne÷ filå witè thå namå specifieä iî  thå 
FCÂ  oî disk® Thå calì doeó noô occupù anù datá storagå spacå  oî 
thå  floppù disk¬ buô reserveó thå spacå foò thå firsô extenô  oæ 
thå  filå  iî thå directory® Bù usinç functioî 22¬  thå  filå  ió 
openeä foò readinç anä writinç aô thå samå time¬ sï thaô functioî 
1µ nï longeò haó tï bå calleä uğ separately.

WARNING:“  Thå "Makå Ne÷ File¢ functioî doeó noô checë  whetheò  á 
filå  witè thå samå namå alreadù existó oî thå disë beforå iô  ió 
created® Thå prograímeò musô ensurå thaô aî existinç filå namå ió 
noô useä agaiî foò thå creatioî oæ thå file.

Example:

FMAKE:  LD      DE,FCÂ          ; this file is to be created
        LD      C,1·            ; secure against duplicates first
        CALL    BDOS
        INÃ     A
        JÒ      Z,FMAKE±        ; ... not yet available - create
        LD      DE,DUPWRÎ       ; Alert users to their presence
        LD      C,9
        CALL    BDOS
        LD      C,1
        CALL    BDOÓ            ; what does the user want to do?
        ANÄ     5FÈ             ; convert to uppercase
        CP      'Y'
        LD      C,0
        CALÌ    NZ,BDOÓ         ; ... if NO, then termination
        LD      DE,FCB
        LD      C,19
        CALL    BDOÓ            ; otherwise delete duplicate
FMAKE1: LD      DE,FCB
        LD      C,22
        CALL    BDOÓ            ; now the file is created
        INÃ     Á               ; Error occurred?
        JÒ      Z,ERROÒ         ; ... jump if there were problems
        ...
DUPWRNº DEFÂ    'File exists! Erase it (Y/N)? $'
        ...
.paŠ.tc       Function 23 - Rename File .............................. #
+---------------------------------------------------------------+
|                   Function 23 - Rename Filå                   |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = address of the FCB     |   A = error code              |
+-------------------------------+-------------------------------+


Thió  functioî ió useä tï renamå thå filå thaô ió nameä witè  thå 
firsô 1³ byteó oæ thå FCÂ (includinç thå drivå anä optionaì  useò 
areá iîformátion)® Thå ne÷ filå namå ió tranóferreä froí bytå  1· 
oæ  thå FCB® Iî contrasô tï CP/Í 2.² anä ZRDOS¬ ZSDOÓ allowó  thå 
specificátioî oæ wilä cardó foò thió functioî call® Iæ therå ió á 
questioî  marë '?§ aô anù poinô iî thå originaì filå  name¬  thió 
characteò ió noô changeä iî thå directorù bù thå renamå function® 
Alì attributeó witè thå exceptioî oæ "publiã file¢ arå  retained® 
Foò  securitù  reasons¬  thå  renameä fileó  arå  alì  giveî  thå 
"private¢  attributå tï prevenô conflictó duå tï multiplå  publiã 
fileó oæ thå samå namå oî á floppù disk.

Aó witè thå "Creatå file¢ function¬ thå programmeò ió respoîsiblå 
foò avoidinç duplicateó iî thå directorù witè thió function.

FCB format when renaming:

Offsetº 0  1     9   12 13 14 15 16 17    25  28 29 30 31
        |  |     |   |  |  |  |  |  |     |   |  |  |  |
Data:   dr oldfn typ 0  us 0  0  0  newfn typ 0  0  0  0

Abbreviationsº  dr - drive
                oldfn - old filename
                typ - filetype
                us - user
                newfn - new filename

RENAMEº                         ; Prereq: name not yet assigned
        LD      DE,RENFCÂ       ; appropriately formatted FCB
        LD      C,23
        CALL    BDOÓ            ; Rename file
        INÃ     Á               ; any problems?
        JÒ      Z,ERROÒ         ; ... jump when an error occurs
        ...
.paŠ.tc       Function 24 - Get Active Drive Map ..................... #
+---------------------------------------------------------------+
|              Function 24 - Get Activå Drivå Mağ               |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   none                        |   HL = login vector           |
+-------------------------------+-------------------------------+

Thió functioî returnó á biô mağ oæ thå currentlù loggeä iî driveó 
iî registeò paiò HL® Thå assignmenô ió defineä aó follows:

Registerº       È                       L
Bitº            · 6 5 4 3 2 1 °         · 6 5 4 3 2 1 0
Driveº          P O N M L K J É         H G F E D C B A

GETLGV: LD      C,2´            ; Get login vector
        CALL    BDOÓ            ; Vector now in HL
        ...
.paŠ.tc       Function 25 - Get Default Drive Number ................. #
+---------------------------------------------------------------+
|            Function 25 - Get Defaulô Drivå Numbeò             |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   none                        |   A = defaulô drive           |
+-------------------------------+-------------------------------+

Thió  functioî  caî bå useä tï determinå thå defaulô  drivå  (thå 
drivå  thaô ió useä withouô specifyinç á drivå number)®  Á  valuå 
betweeî ° anä 1µ ió returneä iî registeò A¬ whicè desiçnateó  thå 
coòresponäinç  drivå froí Á tï P® Foò example¬ thå valuå °  meanó 
drivå Á anä ² means drivå C.

SHOWDD: LD      C,2µ            ; get defaulô drive
        CALL    BDOS
        ADÄ     A,41È           ; Convert to ASCII
        LD      C,²             ; output to console
        LD      E,Á             ; for ZSDOS load in E.
        CALL    BDOÓ            ; output as ASCII on CON:.
        ...
.paŠ.tc       Function 26 - Set File Buffer Address .................. #
+---------------------------------------------------------------+
|             Function 26 - Set File Buffer Addresó             |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = DMA address            |   none (A = 00H)              |
+-------------------------------+-------------------------------+

Thió  functioî setó thå addresó oæ thå 12¸ bytå buffer¬ whicè  ió 
useä  foò  disë  writå  anä reaä functionó aó  welì  aó  foò  thå 
transfeò oæ thå datå stamp¬ tï thå addresó giveî iî registeò paiò 
DE®  Bù  default¬  thå DMÁ buffeò startó aô addresó  80È  wheî  á 
prograí  ió started® Thå currenô addresó caî bå deteòmineä  usinç 
functioî 47.

Notå thaô thå terí DMÁ ió noô entirelù correct® Thå  aâbreviátioî 
DMÁ  standó  foò  "Direcô Memorù Access"¬  whicè  ió  actuallù  á 
peripheraì  chip® Dependinç oî thå hardwarå anä thå BIOÓ  oæ  thå 
respeãtivå system¬ sucè á circuiô maù oò maù noô bå useä foò  thå 
tranómiósioî oæ thå disë data.

STDMA:  LD      DE,DMAADÒ       ; Data transfers take place there
        LD      C,26
        CALL    BDOS
        ...
.paŠ.tc       Function 27 - Get Allocation Vector .................... #
+---------------------------------------------------------------+
|              Function 27 - Get Allocation Vectoò              |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   none                        |   HL = address of allocation  |
|                               |        vector                 |
+-------------------------------+-------------------------------+

Thió  functioî returnó thå addresó oæ thå aìlocátioî  vectoò  foò 
thå defaulô drivå iî thå HÌ registeò pair.

GETALV: LD      E,°             ; Get allocation vector
        LD      C,1´            » froí drivå A
        CALL    BDOÓ            ; Set A as the default drive
        LD      C,2·            ; get allocation vector now
        CALL    BDOS
        ...
.paŠ.tc       Function 28 - Write protect drives ..................... #
+---------------------------------------------------------------+
|              Function 28 - Writå Protect Driveó               |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = write protection vector|   none (A = 00H)              |
+-------------------------------+-------------------------------+

Thió functioî ió primarilù useä tï writå protecô thå diskó iî thå 
selecteä  driveó froí attemptó tï write¬ rename¬ delete¬  etc®  Á 
biô  mağ  foò deteòmiîinç thå driveó ió tranóferreä  iî  registeò 
paiò DE.

Thå poósibilitù oæ resettinç driveó tï read/writå aô á lateò timå 
dependó oî thå statuó oæ thå "Reaä-onlù vectoò received¢ flaç biô 
iî  thå coîfigurátioî bytå (biô ² oæ thå memorù celì  aô  addresó 
ZSDOÓ BASE+15)® Iæ thå biô ió set¬ thå writå protectioî vectoò ió 
neveò cleared® Iæ thå biô ió cleared¬ thå respectivå drivå ió seô 
tï thå read/writå statuó bù callinç functionó 1³ oò 37.

A drive is assigned to each bit in register pair DE:

Registerº       Ä                       E
Bitº            7 6 5 4 3 2 1 °         7 6 5 4 3 2 1 0
Driveº          P O N M L K J É         H G F E D C B A

SETDRO: LD      C,2µ            ; get defaulô drive
        CALL    BDOS
        LD      HL,±            ; Initialize the mask in HL
        AND     Á               ; Test for drive A.
        JÒ      Z,SETDR²        ; ... jump if drivå ió A 
        LD      B,Á             ; otherwise value = shift counter
SETDR1º ADÄ     HL,HÌ           ; Shift 16 bits to the left
        DJNÚ    SETDR±          ; ... repeat until done
SETDR2º EØ      DE,HÌ           ; Vector in DE
        LD      C,2¸            ; set defaulô drive to R/O
        CALL    BDOS
        ...
.paŠ.tc       Function 29 - Get Read-Only Map ........................ #
+---------------------------------------------------------------+
|                Function 29 - Get Read-Only Mağ                |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   none                        |   HL = read-only map vector   |
+-------------------------------+-------------------------------+

Thió  functioî  returnó aî imagå oæ thå driveó thaô  werå  writå-
protecteä witè functioî calì 28® Iî contrasô tï CP/M¬ driveó  arå 
noô  automatécallù writå-protecteä wheî á floppù disë  changå  ió 
detected®  Thå  formaô  oæ thå writå protectioî  vectoò  thaô  ió 
returneä iî registeò paiò HÌ ió defineä aó follows:

Registerº       Ä                       E
Bitº            7 6 5 4 3 2 1 °         7 6 5 4 3 2 1 0
Driveº          P O N M L K J É         H G F E D C B A

CHKRO:  LD      C,2µ            ; get defaulô drive
        CALL    BDOS
        LD      HL,±            ; Initialize the mask in HL
        AND     Á               ; Test for drive A.
        JÒ      Z,CHKRO²        ; ... jump if A ió default
        LD      B,Á             ; otherwise value = shift counter
CHKRO1º ADÄ     HL,HÌ           ; Shift 16 bits to the left
        DJNÚ    CHKRO±          ; ... repeat until done
CHKRO2º PUSÈ    HÌ              ; Secure mask
        LD      C,2¹            ; get write protection vector
        CALL    BDOS
        POĞ     DÅ              ; Restore mask
        LD      A,E
        ANÄ     L
        LD      L,Á             ; Match test by
                                ; AND operation of the LSBs
        LD      A,D
        ANÄ     H
        LD      H,Á             ; ... and MSBs
        OÒ      Ì               ; Check for agreement
        JÒ      NZ,ISWĞ         ; if not zero then
                                ; Standard drive read-only
        ...

; Routine to reset write protection for all drives

RST2RW: LD      C,10°           ; check the flags,
        CALL    BDOÓ            ; ... for "R/O vector received"
                                ; is active
        BIÔ     2,L
        JÒ      Z,RESEÔ         ; deactivated, reset works
        REÓ     2,Ì             ; otherwise deactivate first
        EØ      DE,HL
        LD      C,101
        CALL    BDOÓ            ; Set flags
RESET:  LD      C,29
        CALL    BDOÓ            ; check for a drive
                                ; is write protectedŠ        LD      A,H
        OÒ      L
        REÔ     Ú               ; no, so omit resetting
        EØ      DE,HÌ           ; Write protection vector in DE
        LD      C,3·            ; reset multiple drives
        CALL    BDOÓ            ; ... to remove write protection
        ...
.paŠ.tc       Function 30 - Set File Attributes ...................... #
+---------------------------------------------------------------+
|               Function 30 - Set File Attributeó               |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = address of the FCB     |   A = error code              |
+-------------------------------+-------------------------------+

Filå attributeó arå useä bù ZSDOÓ tï controì thå statuó oæ  fileó 
betweeî BDOÓ calls® Thå attributeó arå containeä iî thå mosô siç
nificanô  bitó (biô 7© oæ thå filå nameó (¸ byteó name¬  ³  byteó 
type© oæ thå FCÂ anä directorù entry® Thå followinç meaningó  arå 
defined:

.pm 1
.lm 9
.oj off
FCB+1   f± (availablå foò users» attributå "dï noô load¢ witè 
        Plu*Perfect)
FCB+2   public file
FCB+3   no access stamp
FCB+4   f4 (available for users)
FCB+5   reserved for internal use by ZSDOS
FCB+6   reserved for internal use by ZSDOS
FCB+7   reserved for internal use by ZSDOS
FCB+8   wheel protection
FCB+9   Read only (write protection)
FCB+10  system file
FCB+11  archived
.oj on
.lm 1
.pm 1

Thió functioî allowó thå prograímeò tï seô oò cleaò aôtributeó bù 
settinç  oò  resettinç  thå coòresponäinç bitó iî  thå  FCB¬  thå 
addresó  oæ whicè ió tranóferreä iî DE® Wildcardó maù  appeaò  iî 
thå FCB.

Thå useò musô noô changå thå attributå bitó thaô arå reserveä foò 
internaì  use®  Theså bitó werå alreadù reserveä undeò  CP/Í  anä 
ZRDOS¬ sï thió ió noô á ne÷ restriãtion.

Iæ  thå attributå biô foò publiã fileó ió set¬ thió filå  caî  bå 
founä  bù anù useò areá oî thå samå floppù disë iæ á uniquå  filå 
specificátioî ió useä foò thå search® Iô ió thå respoîsibilitù oæ 
thå  prograímeò tï ensurå thaô therå ió nï seconä filå oî á  disë 
thaô haó thå samå namå aó á publiã file.

Thå wheeì protectioî attributå preventó thå filå froí beinç oveò
wriôten¬  deleted¬  renameä oò onå oæ itó attributeó  changeä  aó 
lonç aó thå wheeì bytå ió noô on® Iî á systeí eîviroîmenô withouô 
ZCPR¬ thió attributå generallù haó nï effect® ZSDOÓ theî  assumeó 
thaô thå useò haó alì rightó oæ use.

Thå  reaä-onlù attributå provideó fulì protectioî  againsô  oveò
wriôing¬ deletinç oò renaminç á file.

SETATT: LD      DE,FCÂ          ; FCB has attributes to be set
        LD      C,3°            ; ... or reset
        CALL    BDOÓ            ; Set file attributes
        ...
.paŠ.tc       Function 31 - Get Disk Parameters ...................... #
+---------------------------------------------------------------+
|               Function 31 - Get Disë Parameteró               |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|    none                       |   HL = address of the DPB     |
+-------------------------------+-------------------------------+

Thió  functioî  returnó thå addresó oæ thå disë  paraíeteò  blocë 
(DPB© foò thå defaulô drivå iî thå HÌ paiò oæ registers® Iîformá
tioî  sucè aó thå capacitù oæ thå drive¬ thå numbeò oæ  directorù 
entries¬ thå numbeò oæ tracks¬ etc® caî bå obtained.

GETDPB: LD      E,°             ; Drive A DPB
        LD      C,14
        CALL    BDOÓ            ; The default drive is now A
        LD      C,3±            ; get DPB
        CALL    BDOÓ            ; Pointer to DPB from A: in HL
        ...
Functional description
.paŠ.tc       Function 32 - Get or Set User Area ..................... #
+---------------------------------------------------------------+
|               Function 32 - Geô oò Set User Area              |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   E = 0FFH (get)              |   A = user area               |
|   E = 0-31 (set)              |   A = 0                       |
+-------------------------------+-------------------------------+

Thió functioî getó oò setó thå defaulô useò areá foò filå  operá
tions® Compareä tï CP/Í anä ZRDOS¬ ZSDOÓ allowó thå defaulô  useò 
areá  tï bå oveòwriôteî bù specifùinç iô separatelù iî  thå  FCB® 
Otherwiså thå defaulô useò areá ió useä foò alì filå operátions.

GETUSR: LD      C,32
        LD      E,0FFÈ          ; get current user area
        CALL    BDOS
        ...


SETUSR: LD      E,Á             ; assumed, user area in A
        LD      C 32
        CALL    BDOÓ            ; set new user area
        ...
.paŠ.tc       Function 33 - Random Access Read ....................... #
+---------------------------------------------------------------+
|               Function 33 - Randoí Accesó Reaä                |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = address of the FCB     |   A = read/write code         |
+-------------------------------+-------------------------------+

Witè  thió functioî thå reaä accesó tï thå filå specifieä iî  thå 
FCÂ  ió possible® Beforå callinç thå function¬ thå randoí  accesó 
recorä  numbeò  (FCB+33..FCB+35¬  LSB..MSB© musô bå  seô  tï  thå 
numbeò oæ thå desireä 12¸-bytå record® Beforå this¬ thå filå musô 
havå beeî openeä witè extenô ° usinç functioî 15.

Whilå thå sequentiaì reaä functioî incrementó thå currenô  recorä 
(FCB+32© afteò eacè access¬ functioî 3³ leaveó iô unchanged®  Thå 
randoí  accesó  recorä  numbeò musô bå  seô  bù  thå  ağplicátioî 
prograí beforå eacè call.

RDRAN:  ..®                     ; FCB+33...35 already set
        LD      DE,FCÂ          ; File has already been opened
        LD      C,33
        CALL    BDOÓ            ; read record into the DMA buffer
        AND     Á               ; Error occurred?
        JÒ      NZ,ERROÒ        ; ... jump if there were problems
        ...
.paŠ.tc       Function 34 - Random Access Write ...................... #
+---------------------------------------------------------------+
|               Function 34 - Randoí Accesó Write               |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = address of the FCB     |   A = read/write code         |
+-------------------------------+-------------------------------+

Thió functioî allowó randoí writå accesó tï thå filå specifieä iî 
thå  FCB®  Aó witè functioî 33¬ thå randoí accesó  recorä  numbeò 
(FCB+33..FCB+35¬  LSB..MSB©  musô  bå seô tï thå  numbeò  oæ  thå 
desireä  12¸-bytå record® Thå filå musô havå alreadù beeî  openeä 
witè  functioî 1µ oò createä witè functioî 22® Pleaså  notå  thaô 
wheî openinç aî existinç filå witè functioî 15¬ thå extenô numbeò 
musô bå ° (thå baså extent).

Thió  functioî  alsï doeó noô affecô thå valuå  foò  thå  currenô 
recorä  (FCB+32)¬  sï thaô thå ağplicátioî prograí musô  seô  thå 
numbeò foò thå optionaì recorä beforå eacè functioî call.

Thió  functioî opens¬ closeó anä createó extentó aó  needed®  Thå 
functioî  alsï causeó thå archivå biô oæ thå firsô extenô  tï  bå 
reseô  usinç functioî 1¶ wheî thå filå ió closed® Thió  indicateó 
thaô thå filå haó beeî changed.

Remarks:

.pm 1
.lm 5
1.) Undeò ZSDOÓ iô ió possiblå tï creatå fileó thaô arå toï largå 
    tï  worë  undeò CP/Í 2.² oò ZRDOS® Whilå onlù  uğ  tï  65,53¶ 
    recordó  (8,19²  kB© caî bå processeä bù CP/Í 2.²  anä  ZRDOÓ 
    files¬  ZSDOÓ supportó fileó uğ tï á sizå oæ 262,14´  recordó 
    (32,76¸  kB)® Sucè largå fileó caî easilù bå useä undeò  CP/Í 
    3.0.

2.) Fileó thaô werå createä randomlù anä contaiî "holes¢ arå  noô 
    tranómitteä  correctlù bù mosô copyinç programs¬  sincå  theù 
    carrù  ouô  såqueîtiaì  reaä  anä  writå  operátions®   Theså 
    programó includå¬ foò example, COPY¬ PIĞ anä PPIP.
.pm 1
.lm 1

WRRAN:  ..®                     ; FCB+33...35 already set
        LD      DE,FCÂ          ; File has already been opened
        LD      C,34
        CALL    BDOÓ            ; write record from DMA tï disk
        AND     Á               ; Error occurred?
        JÒ      NZ,ERROÒ        ; ... jump if any problems
        ...

Iæ  aî "Disë full¢ erroò occurs¬ thå samå procesó applieó aó  foò 
functioî  21º Thå filå shoulä bå closeä beforå  peòforíinç  otheò 
operátionó (seå alsï sectioî 5.2.21).
.paŠ.tc       Function 35 - Get File End Address ..................... #
+---------------------------------------------------------------+
|              Function 35 - Geô Filå Enä Addresó               |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = address of the FCB     |   A = error code              |
|                               |   FCB+33..35 = last record+1  |
+-------------------------------+-------------------------------+

Thió  functioî  calculateó  thå "virtual¢ sizå  oæ  á  file®  Thå 
returneä  sizå ió deteòmineä bù settinç thå randoí recorä  numbeò 
iî  thå  FCÂ tï thaô oæ thå lasô recorä founä pluó  one®  Dï  noô 
confuså  thió valuå witè thå reaì sizå oæ thå filå oî thå disë  ­ 
fileó createä randomlù caî contaiî "empty¢ extents¬ whicè dï  noô 
takå uğ spacå oî thå disk¬ buô arå includeä iî thå caìculátioî oæ 
thió function.

Thió functioî calì ió ofteî useä tï seô thå numbeò oæ thå  randoí 
recorä  tï á valuå afteò thå enä oæ thå filå wheî addinç  furtheò 
records.

GETSIZ: LD      DE,FCÂ          ; Get the size of this file
        LD      C,35
        CALL    BDOÓ            ; Read size in FCB+33...35
        AND     Á               ; Error occurred?
        JÒ      NZ,ERROÒ        ; ... jump if there were problems
        ...
.paŠ.tc       Function 36 - Get Random Address ....................... #
+---------------------------------------------------------------+
|               Function 36 - Geô Randoí Addresó                |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|    DE = address of the FCB    |   A = 00H                     |
|                               |   FCB+33..35 = current recorä |
+-------------------------------+-------------------------------+

Thió  functioî  setó thå randoí recorä numbeò iî thå FCÂ  tï  thå 
currenô positioî iî thå file¬ whicè ió accesseä såqueîtiallù  foò 
readinç  and/oò writing® Thió iîformátioî caî bå saveä foò  lateò 
uså tï quicklù accesó thå desireä locatioî iî thå file.

Á  possiblå ağplicátioî woulä bå thå creatioî oæ aî indeø  durinç 
thå  sequentiaì writinç oæ á file® Usinç thå index¬  thå  indexeä 
positionó  caî bå accesseä quicklù witè randoí  accesses®  Pleaså 
notå  thaô sequentiaì reaä anä writå functionó dï noô changå  thå 
randoí recorä number.

SETRAN: LD      DE,FCÂ          ; File is already open
        LD      C,3¶            ; ... and accessed sequentially
        CALL    BDOÓ            ; seô FCB+33..FCB+35
        ..®                     ; ... tï current recorä number
.paŠ.tc       Function 37 - Reset Drives ............................. #
+---------------------------------------------------------------+
|                  Function 37 - Reset Driveó                   |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = mask                   |   A = 0 or                    |
|                               |   A = 0FFH if file named      |
|                               |   $*.* exists on currenô disë |
+-------------------------------+-------------------------------+

Undeò CP/Í 2.2¬ thió iîcoòrectlù programmeä functioî coulä hardlù 
bå useä tï loç ouô severaì drives® Mosô prograímeró assumeä  thaô 
functioî 3· woulä loç iî á reseô drivå undeò CP/Í ­ buô thaô  waó 
noô thå case® Mosô BDOÓ suâstituteó adopteä thió bug¬ buô iô  haó 
beeî  fixeä iî ZSDOS® Iæ thå defaulô drivå ió reset¬ iô  ió  theî 
loggeä iî agaiî anä thå allocatioî vectoò ió rebuilô ­ eveî iæ iô 
ió á harä disk® Beforå doinç this¬ yoõ shoulä makå surå thaô  alì 
fileó  oî  thå  disë arå closeä beforå thå drivå  ió  reseô  witè 
functioî 37.

Note:‚  Iæ á prograí containó á placå tï changå thå  floppù  disk¬ 
thå functioî shoulä onlù bå carrieä ouô ‚afterwards.

Functioî 3· offeró thå onlù availablå methoä foò rå-buildinç  thå 
allocatioî  vectoró oæ fixeä diskó wheî "fasô rå-logiî  oæ  fixeä 
disks¢  ió  enabled® Fuòtheòmore¬ thió functioî  musô  alwayó  bå 
carrieä ouô wheî direcô BIOÓ calló havå beeî useä bù aî  ağplicá
tioî  prograí thaô changå direãtorieó oò aìlocátioî vectoró  froí 
fixeä disks.

A drive is assigned to each bit in register pair DE as follows:

Registerº       Ä                       E
Bitº            7 6 5 4 3 2 1 °         7 6 5 4 3 2 1 0
Driveº          P O N M L K J É         H G F E D C B A

Herå  ió aî examplå oæ ho÷ tï loç alì fixeä diskó bacë  intï  thå 
system:

        LD      C,3¹            ; get vector fixed disks
        CALL    BDOS
        EØ      DE,HÌ           ; Vector transferred in DE
        LD      C,37
        CALL    BDOÓ            ; log in fixed disks again
        ...
.paŠ.tc       Function 39 - Get Vector of Fixed Disks ................ #
+---------------------------------------------------------------+
|            Function 39 - Get Vector of Fixed Diskó            |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   none                        |   HL = vector of fixed disks  |
+-------------------------------+-------------------------------+

Functioî  3¹ reproduceó á biô imagå oæ thå driveó iî  thå  systeí 
thaô  arå loggeä iî aó fixeä diskó wheî "fasô rå-logiî  oæ  fixeä 
disks¢  ió enabled® Aî examplå oæ thå uså oæ thió  functioî  calì 
caî bå founä iî thå listinç foò functioî 3· iî thió section.

Thå biô map¬ whicè ió returneä bù ZSDOÓ iî thå HÌ registeò  pair¬ 
ió defineä aó follows:

Registerº       È                       L
Bitº            7 6 5 4 3 2 1 °         7 6 5 4 3 2 1 0
Driveº          P O N M L K J É         H G F E D C B A
.paŠ.tc       Function 40 - Random Access Write with Zero Fill ....... #
+---------------------------------------------------------------+
|       Function 40 - Randoí Access Write with Zero Filì        |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = address of the FCB     |   A = read/write code         |
+-------------------------------+-------------------------------+

Thå  functioî  oæ thió functioî ió verù similaò tï  functioî  34¬ 
however¬ alì recordó oæ á newlù occupieä blocë arå inétializeä bù 
fillinç  witè  00H® Iæ recordó arå createä usinç functioî  3´  iî 
blockó  thaô  havå neveò beeî writteî to¬ undefineä datá  maù  bå 
containeä iî thå blocks.

WRRANZ: ..®                     ; FCB+33...35 already set
        LD      DE,FCÂ          ; File has already been opened
        LD      C,40
        CALL    BDOÓ            ; writes record from DMA to disk
                                ; ... fill the rest with zeros
        AND     Á               ; Error occurred?
        JÒ      NZ,ERROÒ        ; ... jump if any problems
        ...
.paŠ.tc       Function 45 - Set BDOS Error Mode ...................... #
+---------------------------------------------------------------+
|               Function 45 - Set BDOS Error Modå               |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   E = xxxxxxx1B: suppresó thå |   nonå                        |
|       erroò messagås          ü                               |
|   E = xxxxxx1xB: returî error |                               |
ü       codå tï prograí         ü                               |
|   E = 1xxxxx00B: set ZSDOS    |                               |
|       defaulô error mode;     |                               |
ü       displaù erroò messagå   ü                               |
ü   Å ½ 00000000Bº seô CP/Í     ü                               |
ü       defaulô erroò modå;     ü                               |
ü       displaù erroò messagå   ü                               |
+-------------------------------+-------------------------------+

Functioî  4µ enableó ağplicátioî programó tï influencå thå  erroò 
handlinç  oæ  ZSDOS® Alì erroró detecteä bù thå  BDOS¬  includinç 
selecô  anä writå proteãô errors¬ caî bå tranóferreä tï  thå  ağ
plicátioî prograí anä aî addétioîaì screeî messagå froí ZSDOÓ caî 
bå displayeä oò suğpressed.

Iî ordeò tï definå thå erroò mode¬ thå valuå ió seô iî registeò Å 
wheî functioî 4µ ió called® Iæ thå valuå iî registeò Å haó biô  0 
reset¬  wheî aî erroò occuró á messagå ió outpuô oî thå  screeî  bù 
ZSDOS® Iæ biô ° ió set¬ nï messagå ió output.

Iæ  biô ± ió registeò Å ió set¬ wheî aî erroò occuró  controì  ió 
passeä  bacë tï thå program® Registeò Á theî containó  thå  valuå 
0FFÈ anä thå extendeä erroò codå ió availablå iî registeò H.

Iæ registeò Å ió seô tï ° wheî settinç thå erroò mode¬ ZSDOÓ setó 
thå defaulô CP/Í erroò mode® Theså valueó oæ thå inpuô paraíeteró 
coòresponä tï thoså oæ functioî 4µ undeò CP/Í Plus.

Thå  valuå  passeä  tï functioî 4µ serveó anotheò  purposå  ­  iô 
informó thå DOÓ thaô á ZSDOÓ prograí ió running® Programó writteî 
espåciallù foò ZSDOÓ seô thå S± bytå iî thå FCÂ tï thå useò  areá 
OReä witè 80È anä thå S² bytå tï thå valuå ° wheî filå operátionó 
sucè aó opening¬ renaming¬ deletinç etc® arå carrieä out® Iæ  thå 
erroò  modå haó beeî seô tï á noî-zerï value¬ ZSDOÓ assumeó  thaô 
thå ağplicátioî prograí ió settinç theså byteó correctly.

Iî ordeò tï inforí thå DOÓ thaô á ZSDOÓ prograí ió runninç  whilå 
maiîtaiîinç  thå defaulô erroò mode¬ biô · iî registeò Å ió  useä 
aó á flaç durinç thå transfer® Thå erroò modå bitó arå  currentlù 
seô aó follows:

.cp 5
Bit: 7 6 5 4 3 2 1 0
     | | | | | | | +- Display suppression flag
     | | | | | | +--- Error code return flag
     | +-+-+-+-+----- reserved
     +--------------- Flag for information "ZSDOS program"

.cp 4ŠIæ aî ağplicátioî prograí haó changeä thå erroò mode¬ iô musô  bå 
reseô  tï  zerï beforå returninç tï thå operatinç  systeí  level® 
Thió  ió thå onlù waù tï ensurå fulì coípatibilitù witè  programó 
thaô  werå  noô specifécallù writteî foò ZSDOS® Iæ á  prograí  ió 
terminateä  froí  thå  BDOS¬ thå erroò modå ió seô  tï  °  beforå 
booting®  Callinç  functioî ° alsï resetó thå erroò modå  tï  thå 
CP/Í default.

Wheî  extendeä  erroò  codeó arå returneä  iî  thå  coòresponäinç 
modes¬  thå valuå 0FFÈ iî registeò Á indicateó thå occurrencå  oæ 
aî  error® Thå respectivå erroò codå ió returneä iî  registeò  H® 
Thå codeó havå thå followinç meaning:

   Value in È   Meaning
        °       no extended error code
        ±       disk I/O error (bad sector)
        ²       disk ió write-protected
        ³       file ió read-only
        ´       illegal drive specification

Onlù ´ extendeä erroò codeó arå currentlù defined® However¬ iô ió 
possiblå  thaô  morå wilì bå addeä iî futurå versions®  Foò  thió 
reason¬  iô  shoulä noô bå assumeä durinç prograíminç  thaô  onlù 
certaiî  erroró caî occur¬ buô thaô alì defineä erroò  codeó  arå 
tested.

Examples for setting the failure mode:

SET$RET$ERR:
        LD      E,03È          ; Error code return, no error
        LD      C,4µ            » messagå displayed
        CALL    BDOS
        ...


SET$QRET$ERR:
        LD      E,02È          ; Error code return, display
        LD      C,4µ            » erroò message
        CALL    BDOS
        ...


SET$DEF$ERR:
        LD      E,°             ; Set defaulô error mode
        LD      C,45
        CALL    BDOS
        ...


Examples of error handling:

FOPEN:  LD      DE,FCB
        LD      C,15
        CALL    BDOÓ            ; open file
        INÃ     AŠ        JÒ      NZ,OKOPEÎ       ; no error, file is open
        LD      A,È             ; Load extended error code
        AND     Á               ; Extended error code test
        JÒ      Z,NOFILÅ        ; not an advanced bug
                                ; ...File was not found
        CP      1
        JÒ      Z,BADSEÃ        ; Bad sector error
;
; Write protection errors cannot occur when opening
;
        CP      4
        JÒ      Z,SELERÒ        ; "Illegal drive" error
;
; These extended error codes have been defined so far.
; There may be more in future versions, so
; you should plan this possibility!
;
        JÒ      UNKERÒ          ; ... elså jump to routine
                                ; "unknown error"
        ...


FWRITE: LD      DE,FCB
        LD      C,21
        CALL    BDOÓ            ; Write sector to file
        AND     A
        JÒ      Z,OKWÒ          ; no error, file is open
        CP      0FFÈ            ; Is it an advanced bug?
        JÒ      NZ,NRMERÒ       ; No, normal mistake
                                ; ... like "disk full" etc.
        LD      A,È             ; else expanded error code
        CP      1
        JÒ      Z,BADSEÃ        ; ... "bad sector"
        CP      2
        JÒ      Z,DISKWĞ        ; ... "Disk R/O"
        CP      3
        JÒ      Z,FILEWĞ        ; ... "File R/O"
        CP      4
        JÒ      Z,SELERÒ        ; ... "illegal disk"
;
; These extended error codes have been defined so far.
; There may be more in future versions, so
; you should plan this possibility!
;
        JÒ      UNKERÒ          ; ... elså jump to routine
                                ; "unknown error"
        ...
.paŠ.tc       Function 47 - Get File Buffer Address .................. #
+---------------------------------------------------------------+
|             Function 47 - Get Filå Buffeò Addresó             |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   none                        |   HL = pointer to DMA buffer  |
+-------------------------------+-------------------------------+

Thió  functioî returnó thå addresó oæ thå DMÁ buffeò iî  registeò 
paiò HL® Thå DMÁ buffeò ió useä foò alì transferó froí anä tï thå 
disë  aó welì aó foò thå datå stamğ functions® Mainlù  IOPó  thaô 
rå-enteò  ZSDOÓ uså thió function® Thå addresó oæ thå DMÁ  buffeò 
ió  fetcheä  froí thå IOĞ iî ordeò tï reseô iô tï thå  olä  valuå 
afteò thå calì comeó back.

Iô shoulä bå noteä thaô onlù thå DMÁ addresó ió returneä aó iô ió 
knowî  tï thå DOS® Thå DMÁ addresó iî thå BIOÓ caî diffeò  iæ  aî 
ağplicátioî prograí haó changeä iô througè direcô BIOÓ calls®  Iî 
ordeò tï remaiî compatiblå witè lateò operatinç systems¬ thå  uså 
oæ BIOÓ routineó shoulä bå minimizeä oò completelù avoided.

GETDMA: LD      C,4·            ; get address of the DMA buffer
        CALL    BDOÓ            ; is returned in HL
        ...
.paŠ.tc       Function 48 - Get BDOS Version Number .................. #
+---------------------------------------------------------------+
|             Function 48 - Get BDOÓ Versioî Numbeò             |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   none                        |   H = BDOÓ IÄ                 |
|                               |      ('S' for ZSDOS)          |
|                               |      ('D' for ZDDOS)          |
|                               |   A, L = version number       |
+-------------------------------+-------------------------------+

Witè thió functioî yoõ caî finä ouô whetheò ZSDOÓ ió runninç iî á 
systeí  anä iæ so¬ whicè version® Iô ió absolutelù  necessarù  tï 
determinå  thå presencå oæ ZSDOÓ beforå usinç onå oæ thå  ne÷  oò 
expandeä  ZSDOÓ  functions® Tï ensurå thaô  ZSDOÓ  ió  available¬ 
firsô  calì  functioî  12¬ froí whicè 22È  musô  bå  returneä  iî 
registeò A® Functioî 4¸ ió theî called.

Thå  functioî  foò queryinç thå labelinç  oæ  extendeä  operatinç 
systemó  waó developeä iî coìlaborátioî witè Joå Wright¬  Bridgeò 
Mitchelì  anä thå authoró oæ ZSDOS® Thå calì ió identicaì tï  thå 
ZRDOÓ  functioî "Geô versioî number"® Thå DOÓ suâstituteó caî  bå 
diótiîguisheä oî thå basió oæ thå indicatoò returneä iî  registeò 
H®  Aî  extendeä  DOÓ  caî bå recognizeä bù  thå  facô  that¬  iî 
contrasô  tï CP/M¬ thå versioî numbeò ió returneä iî registeró  Á 
anä L® Thió functioî ió noô includeä iî thå normaì CP/Í BDOÓ  anä 
onlù  thå  valuå zerï ió returned® Thå followinç  indicatoró  arå 
currentlù assigneä tï thå DOS:

      È  Valuå   DOS
        00È     ZRDOS
        'D§     ZDDOS
        'S§     ZSDOS

Thå  assignmenô oæ ne÷ valueó shoulä bå cooòdinateä witè  onå  oæ 
thå abovå-mentioneä personó iî ordeò tï avoiä anù  misunderstanä
ingó  regardinç thió function® Oæ thå 25¶ differenô  values¬  25³ 
arå stilì available!

        LD      C,1²            ; get CP/M version
        CALL    BDOS
        CP      22È             ; compatible with version 2.2?
        JÒ      NZ,NOTZÓ        ; ... no, so it can't be ZSDOS
        LD      C,48
        CALL    BDOÓ            ; get version of the extended DOS
        LD      A,È             ; Load version indicator
        CP      'S§             ; Is it ZSDOS?
        JÒ      NZ,NOTZÓ        ; ... jump if not ZSDOS
        ...
.paŠ.tc       Function 98 - Get System Time .......................... #
+---------------------------------------------------------------+
|                 Function 98 - Get Systeí Timå                 |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = time info block address|   A = time/date code          |
+-------------------------------+-------------------------------+

Thió  functioî  enableó ağplicátioî programó tï reaä  thå  systeí 
clock® Iî thå registeò paiò DE¬ á targeô addresó oæ á buffeò areá 
ió  tranóferred¬  iî  whicè thå timå iîformátioî  froí  ZSDOÓ  ió 
written.

Driveò  routineó arå requireä foò thió function® Iæ nï driveò  ió 
installeä oò thå clocë cannoô bå read¬ thå valuå 0FFÈ ió returneä 
iî  registeò  Á anä thå buffeò remainó unchanged® Iæ  registeò  Á 
containó thå valuå ± oî return¬ thå timå anä datå iîformátioî  oæ 
thå systeí clocë ió availablå iî thå buffer.

GETTIM: LD      DE,TIMEAÄ       ; Start address of the buffer
        LD      C,98
        CALL    BDOÓ            ; geô time information iî buffer
        INÃ     Á               ; Error occurred?
        JÒ      Z,ERROÒ         ; ... jump if not available
        ...

TIMEADº DEFÂ    0,0,0,0,0,°     ; Buffer initialized with zeros
        ...
.paŠ.tc       Function 99 - Set System Time .......................... #
+---------------------------------------------------------------+
|                 Function 99 - Seô Systeí Timå                 |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = addresó oæ time block  |   A = time/date code          |
+-------------------------------+-------------------------------+

Witè  thió  function¬ aî ağplicátioî prograí caî seô  thå  systeí 
clock® Thå starô addresó oæ thå buffeò witè thå timå  iîformátioî 
ió tranóferreä iî registeò paiò DE.

Driveò  routineó arå requireä foò thió function® Iæ nï driveò  ió 
installed¬ thå valuå 0FFÈ ió returneä iî registeò A® Iæ  registeò 
Á containó thå valuå ± oî return¬ thå clocë haó beeî set.

SETTIM: LD      DE,TIMEAÄ       ; Start address of the buffer
        LD      C,99
        CALL    BDOÓ            ; Set the clock
        INÃ     Á               ; Error occurred?
        JÒ      Z,ERROÒ         ; ... jump, in case of errors or
                                ; ... if there is no function
        ...

.paŠ.tc       Function 100 - Get Configuration Flags ................. #
+---------------------------------------------------------------+
|            Function 100 - Get Configuration Flagó             |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   none                        |   HL = flags                  |
+-------------------------------+-------------------------------+

Thió  functioî returnó thå currenô ZSDOÓ coîfigurátioî  flagó  iî 
thå HÌ registeò pair® Iî versioî 1.± oæ ZSDOS¬ onlù registeò Ì ió 
important®  Foò reasonó oæ coípatibilitù witè lateò  versionó  oæ 
ZSDOS¬ whicè maù uså morå statuó bits¬ thå valuå ° ió returneä iî 
registeò H.

Register H = 0, register L contains:

Bit: 7 6 5 4 3 2 1 0
     | | | | | | | +- Public fileó               oî (1)/off (0)
     | | | | | | +--- Write public/path fileó    on (1)/off (0)
     | | | | | +----- Get read-only vectoò       on (1)/off (0)
     | | | | +------- quick logiî                on (1)/off (0)
     | | | +--------- Floppy disk change warning on (1)/off (0)
     | | +----------- ZCPR2/3 patè               on (1)/off (0)
     | +------------- Path with/out system files on (1)/off (0)
     +--------------- reserved

Pleaså  refeò tï sectioî 4.3.´ foò á detaileä descriğtioî oæ  thå 
functionó oæ thå individuaì bits.
.paŠ.tc       Function 101 - Set Configuration Flags ................. #
+---------------------------------------------------------------+
|            Function 101 - Set Configuration Flagó             |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = flags                  |   None                        |
+-------------------------------+-------------------------------+

Witè thió functioî call¬ thå ZSDOÓ coîfigurátioî flagó arå seô tï 
thå  valueó  tranóferreä iî registeò paiò DE® Iî versioî  1.±  oæ 
ZSDOS¬  onlù  thå valuå iî registeò Å ió  important®  Registeò  Ä 
shoulä  bå loadeä witè thå valuå ° iî ordeò tï remaiî  compatiblå 
witè lateò versions.

Register D = 0, register E contains:

Bit: 7 6 5 4 3 2 1 0
     | | | | | | | +- Public fileó               on (1)/off (0)
     | | | | | | +--- Write public/path fileó    on (1)/off (0)
     | | | | | +----- Get read-only vectoò       on (1)/off (0)
     | | | | +------- quick logiî                on (1)/off (0)
     | | | +--------- Floppy disk change warning on (1)/off (0)
     | | +----------- ZCPR2/3 patè               on (1)/off (0)
     | +------------- Path with/out system files on (1)/off (0)
     +--------------- reserved

Pleaså  refeò tï sectioî 4.3.´ foò á detaileä descriğtioî oæ  thå 
functionó oæ thå individuaì bits.
.paŠ.tc       Function 102 - Get Date Stamp .......................... #
+---------------------------------------------------------------+
|                 Function 102 - Get Date Stamğ                 |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = address of the FCB     |   A = time/date code          |
|                               |   Date stamp in the DMA buffer|
+-------------------------------+-------------------------------+

Thió  functioî returnó thå datå stamğ oæ thå filå whoså  namå  ió 
passeä iî thå FCÂ addresseä bù DE® Thå extenô anä modulå  numberó 
(FCB+12...FCB+4©  musô  bå  seô tï zerï beforå  thå  functioî  ió 
called®  Thå  correcô  useò areá musô alsï bå set®  Tï  dï  this¬ 
eitheò  placå thå useò areá numbeò OReä  witè 80È iî FCB+1³  (S1© 
oò calì functioî 3² beforehand® Thå desireä stamğ iîformátioî  ió 
availablå  iî thå firsô 1µ byteó oæ thå DMÁ buffeò afteò  callinç 
functioî 102® Futurå versionó oæ ZSDOÓ maù uså aî extendeä  stamğ 
format¬ sï wå recommenä providinç á 12¸-bytå buffeò foò thå  datå 
stamp.

Iî  ordeò  tï bå ablå tï carrù ouô theså  functions¬  ağpropriatå 
driveò routineó musô bå installed® Iæ nï driveró arå availablå oò 
thå stampó cannoô bå read¬ thå valuå 0FFÈ ió returneä iî registeò 
A®  Iî thió caså thå contenô oæ thå DMÁ buffeò ió  undefined®  Iæ 
thå valuå ± ió returneä iî registeò A¬ theî valiä stamğ  iîformá
tioî ió availablå iî thå DMÁ buffer.
.paŠ.tc       Function 103 - Set Date Stamp .......................... #
+---------------------------------------------------------------+
|                 Function 103 - Set Date Stamğ                 |
+-------------------------------+-------------------------------+
| Input:                        | Output:                       |
|   DE = address of the FCB     |   A = time/date code          |
|   Date stamp in the DMA buffer|                               |
+-------------------------------+-------------------------------+

Thió  functioî writeó thå stamğ iîformátioî iî thå DMÁ buffeò  tï 
disk® Wheî thå functioî ió called¬ thå registeò paiò DÅ pointó tï 
thå FCÂ witè thå namå oæ thå filå tï bå stamped® Aó witè functioî 
calì 102¬ thå extenô anä modulå numberó musô alsï bå  inétializeä 
anä thå useò areá defineä beforå thå functioî ió called.

Iî  ordeò  tï bå ablå tï carrù ouô theså  functions¬  ağpropriatå 
driveò routineó musô bå installed® Iæ nï driveró arå availablå oò 
thå stampó cannoô bå written¬ registeò Á containó thå valuå  0FFÈ 
wheî  returning®  Iæ thå valuå ± ió returneä iî registeò  A¬  thå 
stamğ  iîformátioî haó beeî suãcesófullù writteî tï disk®  Pleaså 
notå  thaô ZSDOÓ doeó noô calì normaì erroò handlinç iæ thå  disë 
ió  writå protected® Iî thió case¬ thå valuå 0FFÈ ió returneä  iî 
registeò Á anä nï datå stamğ ió writteî tï disk.

Example of using functions 102 and 103:

COPYDS: LD      DE,DSBUÆ        ; Buffer for stamp information
        LD      C,2¶            » set address of the DMA buffer
        CALL    BDOS
        LD      DE,SRCFCÂ       ; Source FCB
                                ; (User area already set)
        LD      C,102
        CALL    BDOÓ            ; get stamp of the source file
        LD      DE,DSTFCÂ       ; Target FCB
                                ; (User area already set)
        LD      C,103
        CALL    BDOÓ            ; Transfer stamp to target file
        ...
.paŠ.tc
.tc Quick overview of the functions of ZSDOS ..................... #
Quick overview of the functions of ZSDOS

.rr-!-------------------!---------------------!-----------------R
Nr. Function name       Input parameters      Returned values
 0  Terminatå Program   none                  none
 1  Console Input       none                  A=char
 2  Console Output      E=char                none (A=BIOS A)
 3  Reader Input        none                  A=character
 4  Punch Output        E=char                none (A=BIOS A)
 5  List Output         E=char                none (A=BIOS A)
 6  Direct Consolå I/O  E=0FFH (in)           A=entered char
                        E=0FEH (in)           A=console status
                        E=0FDH (in)           A=entered char
                        E=0..0FCH (out)       none (A=BIOS A)
 7  Get IOBYTE          none                  A=IOBYTE
 8  Set IOBYTE          E=IOBYTE              none (A=IOBYTE)
 9  Output String       DE=string address     B none (A='$')
10  Read Buffer         DE=buffer address     none (A=0DH)
11  Get Console Status  none                  A=00H - no char
                                              Á½01È ­ chaò
12  Get CP/M Version    none                  HL=22H
13  Reset All Drives    none                  A=00H no $*.* File
                                              A=0FFH $*.* Available
14  Select Drive        E=drive number        A=00H no $*.* File
                                              A=0FFH $*.* Available
15  Open existinç filå  DE=FCB address        A=directory code
16  Close outpuô file   DE=FCB address        A=directory code
17  Search for First    DE=FCB address        A=directory code
18  Search for Next     none                  A=directory code
19  Delete File         DE=FCB address        A=error code
20  Sequential Read     DE=FCB address        A=read/write code
21  Sequential Write    DE=FCB address        A=read/write code
22  Makå Ne÷ File       DE=FCB address        A=directory code
23  Rename File         DE=FCB address        A=error code
24  Get Login Vector    none                  HL=login vector
25  Get Defaulô Drive   none                  A=defaulô drive
26  Set Filå Buffer     DE=DMA address        none (A=00H)
27  Get Allocation      none                  HL=allocation vector
    Vector
28  Set Read-Only       DE=R/O vector         none (A=00H)
    Vector
29  Get Read-Only       none                  HL=R/O vector
    Vector
30  Set File Attributes DE=FCB address        A=error code
31  Get DPB Address     none                  HL=address DPB
32  Get/Set User Code   E=0FFH (get)          A=useò area
                        E=user areá (put)     A=00H
33  Randoí Accesó Read  DE=FCB address        A=read/write code
34  Randoí Accesó Writå DE=FCB address        A=read/write code
35  Calculate File Size DE=FCB address        A=error code
                                              FCB+33..35=# Rec.+1
36  Set Direct Record   DE=FCB address        A=00H
37  Reset Drives        DE=mask               A=00H reset to default
                                              A=0FFH $*.* available
38  not included
39  Get Fixed Disks     none                  HL=fixed disks vectorŠ40  Randoí Accesó Write DE=FCB address        A=read/write code
    witè Zero Fill
41  not included
42  not included
43  not included
44  not included
45  Set BDOS Error Mode E=0FFH code           A=00H
                        E=0FEH code+msç       A=00H
                        E=80H ZSDOS mode      A=00H
                        E=00H CP/M mode       A=00H
46  not included
47  Get Filå Buffer     none                  HL=pointer to DMA
48  Get BDOS Version    none                  H=DOS type
                                                'S'=ZSDOS
                                                'D'=ZDDOS
                                              A,L=version (BCD)
98  Get System Time*    DE=time block addr    A=time/date code
99  Seô Systeí time*    DE=time block addr    A=time/date code
100 Get Config Flags    none                  HL=flags
101 Set Config Flags    DE=flags              none
102 Get Date Stamp^     DE=FCB address        A=time/date code
                                              Stamp in the DMA
103 Set Date Stamp^     DE=FCB address        A=time/thumb code
                                              Stamp in the DMA
.rr-----!-------!-------!-------!-------!-------!-------!-------R

.lm 3
.pm 1
* Functionó 9¸ anä 9¹ arå onlù availablå iæ á clocë driveò modulå   
  ió installed.
^ Functionó 10² anä 10³ arå onlù availablå undeò ZSDOÓ iæ á  Datå 
  stamğ modulå ió installed.
.lm 1
.pm 1

.tc Overview of the BDOS error codes ............................. #
Overview of the BDOS error codes

Directory code:
        A = 00H, 01H, 02H, 03H if no error has occurred
        A = 0FFH, in the event of an error

Error code:
        A = 00H, no error
        A = 0FFH, error occurred

Time/date code:
        A = 01H if no error has occurred
        A = 0FFH, error occurred

Read/write code:
        A = 00H if no error has occurred
        A = 01H, read - end of file
                 write - Directory full
        A = 02H, floppy disk full
        A = 03H, error while closing on random Read Write
        A = 04H, empty record for random reading
        A = 05H, directory full of random writing
        A = 06H, record during random reading/writing too large

extended error codes in error mode:Š        A = 0FFH, further error codes in H
        H = 01H, disk I/O error (defective sector)
        H = 02H, floppy disk write-protected (read only)
        H = 03H, file read-only
        H = 04H, illegal drive selected

.tc Brief overview of the BIOS functions ......................... #
Brief overview of the BIOS functions

.rr-----!---------------!-----------------------!---------------R
Number  Function namå   Input parameteró        returned values
 °      BOOÔ            nonå                    none
 ±      WBOOÔ           nonå                    none
 ²      CONSÔ           nonå                    A=0FFH, ready
                                                A=00H, not ready
 ³      CONIÎ           nonå                    A=char from CON:
 ´      CONOUÔ          C=char to CONº          none
 µ      LISÔ            C=char to LSTº          none
 ¶      PUNCÈ           C=char to PUNº          none
 ·      READEÒ          nonå                    A=char from RDR:
 ¸      HOMÅ            nonå                    none
 ¹      SELDSË          C=drive (0..15©         HL=address DPH
                        E=Init Select Flag
                        HL=0 impermissible running
1°      SETTRË          BC=track numbeò         none
1±      SETSEÃ          BC=sector numbeò        none
1²      SETDMÁ          BC=DMA buffer addresó   none
1³      REAÄ            nï                      A=00H okay
                                                A=01H error
1´      WRITÅ           C=00H write datá        A=00H okay
                        C=01H Directory Schr®   A=01H error
                        C=02H write new data
1µ      LISTSÔ          nonå                    A=00H ready
                                                A=0FFH not ready
1¶      SECTRÎ          BC=log. sector £        HL=phys. sec. #
                        DE=translation addr
.rr-----!-------!-------!-------!-------!-------!-------!-------R

Note: The BIOS must not change the IX register!
.paŠZSDOS, the documentation and the utility programs are copyright
(C) 1987, 88, 89, 90 by Harold F. Bower, Cameron W. Cotrill and
Carson Wilson - All rights reserved.

        Harold F. Bower
        7914 Redglobe Court
        Severn, MD 21144
        Ladera Z node
        213/670-9465
    
                Cameron W. Cotrill
                2935 Manhattan Ave.
                La Crescenta, CA 91214
                Ladera Z node
                213/670-9465

                        Carson Wilson
                        1359 W. Greenleaf
                        Chicago, IL 60626
                        Antelope Freeway Z-Node
                        312/764-5162

ZSDOS is now the original code, but originated from P2DOS 2.1 (C)
1985 by HAJ Ten Brugge - All rights reserved.

Trademark:‚ Littlå Board¬ Amprï Computers» Z80¬ Z180¬ Z280¬ Zilog» 
DDT¬  CP/M¬  Digitaì Researcè Inc.» ZCPR3¬  ZCPR33¬  ZRDOS¬  ZDH¬ 
Alphá  Systems“  » WordStar¬ NewWord¬ MicroPrï Int'l“ »  Dbaså  II¬ 
Ashtoî-Tate“   »  BacëGroundeò  ii¬   DatåStamperTM¬   Plu*Perfecô 
Systems»  DosDisk¬  Z3PLUS¬ Bridgeò Mitchell»  Turborom¬  Advent» 
NSC800¬   Nationaì  Semécoîduãtor»  SB180¬  MicroMint»   HD64180¬ 
Hitachi» XBIOS¬ Malcolí Kemp» ZSDOS¬ ZDDOS¬ ZDS¬ Harolä F®  Boweò 
­ Cameroî W® Cotrilì ­ Carsoî Wilson.
.paŠ