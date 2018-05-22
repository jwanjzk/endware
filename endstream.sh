#! /bin/sh
######################################################################
# Title: endstream.sh
# Description:  Clearnet streaming from youtube of selected news 
#               stations using mpv and youtube-dl
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team, 
# All Rights Reserved
# Creation Date: February 21, 2017
# Version: 0.610
# Revision Date: May 22, 2018
#
# Recent Changes: - Use shell functions to reduce redundancy
#####################################################################
# Dependencies: youtube-dl, mpv, read , firejail, curl
#####################################################################
# Instructions:  make a directory ~/bin and copy this file there, add this to the $PATH
#                then make the file executable and run it.
# $ mkdir ~/bin
# $ cp endstream.sh ~/bin/endstream
# $ cd ~/bin
# $ chmod u+wrx endstream
# $ export PATH=~/bin:"$PATH"
#
# Run ENDSTREAM
# $ endstream
#
####################################################################
#############################################################################################################################################################################
#                                         ACKNOWLEDGMENTS
#############################################################################################################################################################################
#  The Endware Development Team would like to acknowledge the work and efforts of OdiliTime, Balrog and SnakeDude who graciously hosted and promoted this software project. 
#  We would also like to acknowledge the work and efforts of Stephen Lynx, the creator and maintainer of LynxChan.  
#  Without their efforts and their wonderful web site www.endchan.xyz, The Endware Suite would not exist in the public domain at all in any form. 
#
#  So thanks to OdiliTime, Balrog, SnakeDude, and Stephen Lynx for inspiring this work and for hosting and promoting it. 
#  
#  The Endware Suite including Endwall,Endsets,Endlists,Endtools,Endloads and Endtube are named in honor of Endchan.
#
#  The Endware Suite is available for download at the following locations:
#  https://gitgud.io/Endwall/ , https://github.com/endwall2/, https://www.endchan.xyz/os/, http://42xlyaqlurifvvtq.onion,
#
#  Special thanks to the designer of the current EndWare logo which replaces the previous logo. It looks great!
#  Thank you also to early beta testers including a@a, and to other contributors including Joshua Moon (for user_agents.txt split and other good suggestions) 
#  as well as to the detractors who helped to critique this work and to ultimately improve it.  
#  
#  We also acknowledge paste.debian.net, ix.io, gitgud and github for their hosting services, 
#  without which distribution would be limited, so thank you.
#
#  https://www.endchan.xyz, http://paste.debian.net, https://gitgud.io, https://github.com, http://ix.io  
#
#  We salute you! 
#  
#  In the end, may it all end well.
#
#  The Endware Development Team
##############################################################################################################################################################################
##############################################################################################################################################################################
#                                                              LICENSE AGREEMENT  
##############################################################################################################################################################################
#  BEGINNING OF LICENSE AGREEMENT
#  TITLE:  THE ENDWARE END USER LICENSE AGREEMENT (EULA) 
#  CREATION DATE: MARCH 19, 2016
#  VERSION: 1.16
#  VERSION DATE: MARCH 30, 2018
#  COPYRIGHT: THE ENDWARE DEVELOPMENT TEAM, 2016-2017
#  ALL RIGHTS RESERVED
#      
#  WHAT CONSTITUTES "USE"? WHAT IS A "USER"?
#  0) a) Use of this program means the ability to study, possess, run, copy, modify, publish, distribute and sell the code as included in all lines of this file,
#        in text format or as a binary file constituting this particular program or its compiled binary machine code form, as well as the the performance 
#        of these aforementioned actions and activities. 
#  0) b) A user of this program is any individual who has been granted use as defined in section 0) a) of the LICENSE AGREEMENT, and is granted to those individuals listed in section 1.
#  WHO MAY USE THIS PROGRAM ?
#  1) a) This program may be used by any living human being, any person, any corporation, any company, and by any sentient individual with the willingness and ability to do so.
#  1) b) This program may be used by any citizen or resident of any country, and by any human being without citizenship or residency.
#  1) c) This program may be used by any civilian, military officer, government agent, private citizen, government official, sovereign, monarch, head of state,
#        dignitary, ambassador, legislator,congressional representative, member of parliament, senator, judicial official, judge, prosecutor, lawyer 
#        noble, commoner, clergy, laity, and generally all classes and ranks of people, persons, and human beings mentioned and those not mentioned.
#  1) d) This program may be used by any human being of any gender, including men, women, and any other gender not mentioned.       
#  1) e) This program may be used by anyone of any affiliation, political viewpoint, political affiliation, religious belief, religious affiliation, and by those of non-belief or non affiliation.
#  1) f) This program may be used by any person of any race, ethnicity, identity, origin, genetic makeup, physical appearance, mental ability, and by those of any other physical 
#        or non physical characteristics of differentiation.
#  1) g) This program may be used by any human being of any sexual orientation, including heterosexual, homosexual, bisexual, asexual, or any other sexual orientation not mentioned.
#  1) h) This program may be used by anyone. 
#  WHERE MAY A USER USE THIS PROGRAM ?
#  2) a) This program may be used in any country, in any geographic location of the planet Earth, in any marine or maritime environment, at sea, sub-sea, in a submarine, underground,
#        in the air, in an airplane, dirigible, blimp, or balloon, and at any distance from the surface of the planet Earth, including in orbit about the Earth or the Moon,
#        on a satellite orbiting about the Earth, the Moon, about any Solar System planet and its moons, on any space transport vehicle, and anywhere in the Solar System including the Moon, Mars, and all other Solar System planets not listed.  
#  2) b) This program may be used in any residential, commercial, business, and governmental property or location and in all public and private spaces. 
#  2) c) This program may be used anywhere.
#  IN WHAT CONTEXT OR CIRCUMSTANCES MAY A USER USE THIS PROGRAM?
#  3)  This program may be used by any person, human being or sentient individual for any purpose and in any context and in any setting including for personal use, academic use,
#      business use, commercial use, government use, non-governmental organization use, non-profit organization use, military use, civilian use, and generally any other use 
#      not specifically mentioned.
#  WHAT MAY A "USER" DO WITH THIS PROGRAM ?
#  4) Any user of this program is granted the freedom to study the code.
#  5) a) Any user of this program is granted the freedom to distribute, publish, and share the code with any neighbor of their choice electronically or by any other method of transmission. 
#  5) b) The LICENCSE AGREEMENT, ACKNOWLEDGMENTS, Header and Instructions must remain attached to the code in their entirety when re-distributed.
#  5) c) Any user of this program is granted the freedom to sell this software as distributed or to bundle it with other software or salable goods.
#  6) a) Any user of this program is granted the freedom to modify and improve the code.
#  6) b) When modified or improved, any user of this program is granted the freedom of re-distribution of their modified code if and only if the user attatchs the LICENSE AGREEMENT
#        in its entirety to their modified code before re-distribution.
#  6) c) Any user of this software is granted the freedom to sell their modified copy of this software or to bundle their modified copy with other software or salable goods.
#  7) a) Any user of this program is granted the freedom to run this code on any computer of their choice.
#  7) b) Any user of this program is granted the freedom to run as many simultaneous instances of this code, on as many computers as they are able to and desire, and for as long as they desire and are
#        able to do so with any degree of simultaneity in use. 
#  WHAT MUST A "USER" NOT DO WITH THIS PROGRAM ?
#  8) Any user of this program is not granted the freedom to procure a patent for the methods presented in this software, and agrees not to do so.
#  9) Any user of this program is not granted the freedom to arbitrarily procure a copyright on this software as presented, and agrees not to do so.
#  10) Any user of this program is not granted the freedom to obtain or retain intellectual property rights on this software as presented and agrees not to do so.
#  11) a) Any user of this program may use this software as part of a patented process, as a substitutable input into the process; however the user agrees not to attempt to patent this software as part of their patented process. 
#      b) This software is a tool, like a hammer, and may be used in a process which applies for and gains a patent, as a substitutable input into the process;
#         however the software tool itself may not be included in the patent or covered by the patent as a novel invention, and the user agrees not to do this and not to attempt to do this.
#  WHO GRANTS THESE FREEDOMS ?
#  12) The creators of this software are the original developer,"Endwall", and anyone listed as being a member of "The Endware Development Team", as well as ancillary contributors, and user modifiers and developers of the software. 
#  13) The aforementioned freedoms of use listed in sections 4),5),6),and 7) are granted by the creators of this software and the Endware Development Team to any qualifying user listed in section 1) and 
#      comporting with any restrictions and qualifications mentioned in sections 2), 3), 8), 9), 10) and 11) of this LICENSE AGREEMENT.
#  WHAT RELATIONSHIP DO THE USERS HAVE WITH THE CREATORS OF THE SOFTWARE ?
#  14)  This software is distributed "as is" without any warranty and without any guaranty and the creators do not imply anything about its usefulness or efficacy.
#  15)  If the user suffers or sustains financial loss, informational loss, material loss, physical loss or data loss as a result of using, running, or modifying this software 
#       the user agrees that they will hold the creators of this software, "The Endware Development Team", "Endwall", and the programmers involved in its creation, free from prosecution, 
#       free from indemnity, and free from liability, and will not attempt to seek restitution, compensation, or payment for any such loss real or imagined.
#  16)  If a user makes a significant improvement to this software, and if this improvement is included in a release, the user agrees not to seek remuneration or payment 
#       from the creators of this software or from Endwall or from the Endware Development Team, for any such work contribution performed, and the user understands 
#       that there will be no such remuneration or payment rendered to them for any such contribution. 
#  END OF LICENSE AGREEMENT
##################################################################################################################################################################################
#  ADDITIONAL NOTES:
#  17)  If a user finds a significant flaw or makes a significant improvement to this software, please feel free to notify the original developers so that we may also
#       include your user improvement in the next release; users are not obligated to do this, but we would enjoy this courtesy tremendously.
#
#  18)  Sections 0) a) 0) b) and 1) a) are sufficient for use; however sections 1) b) through 1) h) are presented to clarify 1 a) and to enforce non-discrimination and non-exclusion of use.  
#       For example some people may choose to redefine the meaning of the words "person" "human being" or "sentient individual" to exclude certain types of people.
#       This would be deemed unacceptable and is specifically rejected by the enumeration presented.  If the wording presented is problematic please contact us and suggest a change,
#       and it will be taken into consideration.  
#################################################################################################################################################################################
######################################## BEGINNING OF PROGRAM    ##########################################################

###############  VERSION INFORMATION  ##############
version="0.610"
rev_date="22/05/2018"
branch="gnu/linux"
product="ENDSTREAM"
##################################################
temp_pl="$HOME/tmp/master.m3u8"
USERAGENTS="$HOME/bin/user_agents.txt"
chan_columns="$HOME/bin/streams.txt"
cookie="$HOME/bin/cookies.txt"
cache_size="4096"
use_cookies="no"
# define the current tor browser user agent
UA_torbrowser="Mozilla/5.0 (Windows NT 6.1; rv:52.0) Gecko/20100101 Firefox/52.0"
# define default headers
HEAD1="Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
HEAD2="Accept-Language: en-US,en;q=0.5"
HEAD3="Accept-Encoding: gzip, deflate"
HEAD4="Connection: keep-alive"
HEAD5="Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7"
uamode="off"
headmode="off"

### Define function for displaying channels  CHANGE MENU HERE
channel_matrix_0()
{ 
   echo "============================================================    "$product"  "$version"   ======================================================================"
   echo "||      ENGLISH       ||     FRANCAIS      ||      ESPANOL     ||      ASIAN     ||     INDIAN      || URDU/FARSI/ARABIC || TR/GR/IT/DE/NL/MD/UA ||"
   echo "======================================================================================================================================================="
   echo "1)SKY News London     41)France 24 FR      81)RT Espanol       121)CCTV 4 China  161)News 9 Bangalore*201)Aaj Tak PK      241)TRT Haber Turkey"    
   echo "2)BBC News London     42)BFM TV FR         82)DW Espanol       122)ECB 51 TW     162)CVR English      202)SAMAA PK        242)NTV Turkey" 
   echo "3)RT UK               43)BFM Business FR   83)CGTN Espanol     123)ECB Finance TW163)CVR NEWS         203)DIN News PK     243)HaberTurk TV"  
   echo "4)RTE News NOW IE     44)RT France         84)Hispan TV        124)TTV TW        164)Shaski India     204)Dawn PK         244)Star TV Turkey"             
   echo "5)France 24 English   45)France Info TV    85)France24 Espanol 125)CTV TW        165)SunNews          205)Bol TV PK       245)CNN Turk"  
   echo "6)DW English          46)CGTN Francais     86)Antena 3 ES      126)FTV TW        166)TV9 India        206)Waqt News PK    246)KRT Kulture"  
   echo "7)Russia Today        47)i24 France IL     87)Magala TV ES     127)CTS World TW  167)Rajya Sabha      207)Geo News PK     247)Number1 TV"
   echo "8)Euronews English    48)Euronews FR       88)Guada TV ES      128)SET News TW   168)TV9 Gujarat      208)TOLO NEWS AF    248)Number1 Turk TV"
   echo "9)CBSN USA            49)Africa News       89)GRANADA TV ES    129)CTI TW        169)Tv9 Marathi      209)BBC Persian     249)La Legul TV"
   echo "10)MSNBC USA          50)Vedia BE          90)c5n AR           130)SET iNews TW  170)News 7 Tamil     210)RT Arabic       250)TGRT Haber"
   echo "11)Bloomberg USA      51)RTS UN CH         91)A24 AR           131)Formosa TW    171)T News Telegu    211)ON E Live Egypt 251)TVNET Canali"
   echo "12)RT America         52)France 2          92)Todo Noticias AR 132)TzuChi DaAi TW172)News 18 India    212)ON Live Egypt   252)Show TV Turkey"
   echo "13)CGTN America       53)France 3          93)La Nacion AR     133)DaAiVideo TW  173)Aaj Tak          213)Al Jazeera Qatar253)Number1 Turk FM"
   echo "14)Newsy USA          54)TV7 France        94)TV Publica AR    134)DaAi Live TW  174)NTV Telugu       214)France 24 Arabic254)Number1 Radyo"
   echo "15)ABC News USA       55)ARTE Francais     95)KZO AR           135)TLTV TW       175)ABN Telugu       215)BBC Arabic      255)Star Lamia Greece"  
   echo "16)TRT World TK       56)IL TV FR          96)Canal 6 AR       136)FLTV TW **    176)Vanitha TV       216)Al Arabiya      256)Blue Sky TV Athens"
   echo "17)i24 News Israel    57)BFM Paris FR      97)Canal 7 AR       137)Sinda TV      177)HMT Telugu       217)Al Mayadeen     257)Action 24 Greece"
   echo "18)Al Jazeera English 58)Alsace 20 FR      98)Canal 8 AR       138)Cheng Sin TV  178)India TV IN      218)Syrian News     258)SKY Folk MK"	
   echo "19)Press TV Iran      59)Mosaik TV FR      99)Canal 13 AR      139)CTS 2 TW      179)Channel 24 IN    219)Syrian El Shalam259)SkyTG 24 Italy"
   echo "20)India Today        60)Journal TVLandes  100)Showsport AR    140)SJTV TW       180)Survana News     220)PAL TV PS       260)Lombardia Italy"  
   echo "21)NEWS X India       61)TV7 Bordeaux FR   101)SuperCanal 3 AR 141)SITTI 1 TW ** 181)i News Telugu    221)Bedya TV        261)Teletuto Brecia Italy"
   echo "22)NDTV IN            62)8 Monte Blanc FR  102)CN23 AR         142)SITTI 2 TW ** 182)News 1 Kannada   222)Belqees TV      262)QVC Italy"       
   echo "23)CGTN Beijing       63)Azur TV Nice FR   103)Telemax AR      143)SITTI 3 TW ** 183)Image Channel IN 223)DMC Live        263)RSI CH"  
   echo "24)NHK World JP       64)RTS DEUX CH       104)Vorterix AR     144)Da Li TW      184)PTTV Tamil IN    224)Sky Arabic      264)SRF CH"
   echo "25)CNN PH             65)LCP FR            105)TV Camara PY    145)SDTV TW       185)DD News          225)Alghad          265)W24 Wein AT" 
   echo "26)ABC AU             66)Public Senate FR  106)Bolivia TV BO   146)FANS TV TW    186)REPORTER LIVE    226)Extra News Egypt266)Tirol TV AT"
   echo "27)Arise News NG      67)Canal Savoir CA   107)Mega CL         147)Hong Kong TV  187)AsiaNet News     227)CBC Sofra Egypt 267)WDR DE"
   echo "28)VOA USA            68)CPAC 1 CA         108)CNN CL          148)Arirang Korea 188)V6 News          228)CBC Drama Egypt 268)DW Deutsch"
   echo "29)RT Documentary     69)Assemblee QC CA   109)Telemedeline CO 149)SBS IN KR     189)ETV AndhraPradesh229)DW Arabic       269)ZDK InfoKanal"
   echo "30)CGTN Documentary   70)TVA CA            110)-------------   150)TBS KR        190)News 18 Tamil    230)AFAQ TV Iraq    270)Tagesschau/MOMA DE"    
   echo "31)BYUTV USA          71)Gong Cinema       111)CTV CO          151)YTN DMB KR    191)Aaj News IN      231)CGTN Arabic     271)EuroNews Deutsch"
   echo "32)TWIT USA           72)GONG MAX          112)TeleSUR VE      152)SBS News KR   192)Jaya Plus        232)Al Hayha 1      272)AT5 NL"
   echo "33)NEWSMAX USA        73)TV5 Monde         113)Globovision VE  153)YTN Sci KR    193)TEZ TV           233)Al Hayha 2      273)TV Publica Moldova" 
   echo "34)Free Speech TV USA 74)BX1 BE            114)NTN24 VE        154)Channel 23 KR 194)Dili Aaj Tak     234)Saudi Green     274)UA TV Ukraine"  
   echo "35)Infowars USA       75)France Info Radio 115)Conciencia VE   155)KBS World24 KR195)ATN Bangladesh   235)Saudi Blue      275)Thromadske UA"
   echo "36)United Nations TV  76)Europe 1 FR       116)VPItv VE        156)YTN 27 KR     196)Somoy TV BD      236)Saudi Red       276)Espresso UA"
   echo "37)C-SPAN 1 USA       77)RFI FR            117)Tu Canal PA     157)ANN24 JP      197)Sagarmatha Nepal 237)Saudi Orange    277)News 1 UA"
   echo "38)CPAC 1 CA          78)RTL FR            118)Guatevision GT  158)Sol!ve 24 JP  198)Derana LK        238)Saudi Gold      278)Ukraine 112"	
   echo "39)Oireachtas TV IE   79)France Inter      119)Excelsior MX    159)KBS 24 JP     199)Swarnavahini LK  239)Saudi Silver    279)Ukraine 5"
   echo "40)BBC Parliament UK  80)RMC INFO FR       120)Telesur Yucatan 160)QVC Japan     200)Kaliagnar News IN240)Saudi Kids      280)Euronews Russian "
   echo "======================================================================================================================================================"
}	                   
 
channel_matrix_1()	
{
   echo "============================================================    "$product"  "$version"   ==================================================================="
   echo "||   UA/RU/PH/ID     ||     AFRICA      ||    USA LOCAL NEWS   ||     EXTRA          ||    ENTERTAINMENT   ||    RELIGIOUS       ||    MIXED     ||"
   echo "======================================================================================================================================================"
   echo "281)POCCNR 24          321)Channels 24 NG 361)RSBN Auburn USA    401)WSJ Live        441)MLB Network      481)Vatican Media     521)Vatican Media Eng"    
   echo "282)RBC TV Russia      322)TVC News NG    362)News 12 Brooklyn   402)CNN Live 1      442)106.7 The Fan    482)EWTN Americas     522)DW Deutsch + **" 
   echo "283)CGTN Russian       323)TVC Continental363)News 12 Long Island403)CNN Live 2      443)106.7 The Fan    483)EWTN Ireland      523)Quaran English"  
   echo "284)Vesti FM Russia    324)NTV Uganda     364)WGN 9 Chicago      404)CPAC 2 CA ***   444)Heart TV         484)EWTN Africa       524)ABC 3 Louisiana"             
   echo "285)Current Time VOA   325)KTN Kenya      365)ABC 9 Orlando      405)CNN USA         445)Capital TV       485)EWTN Asia         525)WPLG 10 Miami"  
   echo "286)RTR Planeta        326)Joy News Ghana 366)Fox 10 Phoenix**   406)CNN USA         446)California Music 486)Salt&Light TV     526)WJXT 4 Jacksonville"  
   echo "287)Perviy RU          327)ADOM Ghana     367)Fox 2 Bay Area     407)DIVIDs          447)Music Choice Play487)Catholic TV       527)NBC 6 South Florida"
   echo "288)Music Box RU       328)Bukedde TV     368)ATXN Austin        408)America Thinks  448)538 Netherlands  488)CTND Detroit      528)WBLZ Bangor Maine"
   echo "289)MOCKBA 24 RU       329)Qaranka Somalia369)Seminole Florida   409)NASA TV Educate 449)О2 ТВ Russia     489)Shalom USA        529)TTB Network"
   echo "290)1TV HD RU          330)EBC Ethiopia   370)Florida Channel    410)NASA TV Media   450)MTV AM Russia    490)Shalom World      530)Vatican Deutsch"
   echo "291)POCCNR 1 HD RU     331)SPARK Uganda   371)Weather Nation     411)C-SPAN 2 USA    451)DJ Animation     491)Shalom Europe     531)Vatican Italiano"
   echo "292)Planeta 4 RU       332)Biafra TV **   372)Weather Channel    412)C-SPAN 3 USA    452)DJ Classic       492)EWTN Espanol      532)Dail Eireann IE"
   echo "293)Planeta 6 RU       333)Walf Senegal   373)CBS 2 New York     413)Bloomberg Europe453)DJ Dancefloor    493)EWTN Deutsch      533)Senad Eireann IE"
   echo "294)ТВ-TPEANEP RU      334)EriTV Eritrea  374)CBS 4 Boston       414)Bloomberg Asia  454)DJ Underground   494)KtO Catholique    534)Dail CR 1 IE"
   echo "295)5 Live RU          335)EbruTV Kenya   375)WVIT 30 Hartford   415)-----------     455)M2O Music        495)Shalom America    535)Dail CR 2 IE" 
   echo "296)------------       336)KTN Home       376)NBC 10 Philadelphia416)BYUTV Int       456)Virgin 1         496)Shalom India      536)Dail CR 3 IE"
   echo "297)------------       337)SABC ZA        377)CBS 3 Michigan     417)Arirang Radio   457)Virgin 2         497)CBN               537)Dail CR 4 IE"
   echo "298)NTV RU             338)Africa News    378)CBS 2 Salt Lake    418)HSN             458)Clubbing TV      498)CBN News          538)-------------"	
   echo "299)TNT RU             339)ANN7 ZA        379)CBS 5 Colorado     419)HSN 2           459)Radio Monte Carlo499)NRB               539)-------------"
   echo "300)POCCNR K  RU       340)Africa24       380)NBC 11 Bay Area    420)QVC             460)KPOP Idol KR     500)Church Channel    540)-------------"  
   echo "301)REN TV RU          341)SIKKA Afrique  381)CBS 13 Stockton    421)TSC             461)Adult Swim       501)TBN               541)------------"
   echo "302)Domanshiniy RU     342)-------------  382)KCAL 9 Los Angeles 422)CTV Live Event  462)Insight TV       502)God TV            542)BSC 24 1 JP "       
   echo "303)TV3 RU             343)-------------  383)WXXV Mississippi   423)CPAC Senate CA  463)Yes TV           503)Amazing Facts     543)BSC 24 2 JP"  
   echo "304)TVC RU             344)-------------  384)NBC 13 Albany NY   424)RUPTLY          464)Smile of a Child 504)It's Supernatural 544)Earthquake 24"
   echo "305)OTR RU             345)-------------  385)NBC 2 Florida      425)Made in Leeds   465)PJ Masks         505)Sheppard's Chapel 545)Arirang News TV "  
   echo "306)Karusel RU         346)-------------  386)WCCB Charlotte     426)Made in Tyne    466)Talking Tom      506)IHOP              546)Arirang TV KR"
   echo "307)Zvezda RU          347)-------------  387)7 News Boston      427)Made in Cardiff 467)Talking Tom Mini 507)BVOVN             547)OnTV HK"
   echo "308)MuzTV RU           348)-------------  388)ABC News 1         428)Saudi 2 English 468)Fashion Europe   508)3ABN              548)Planeta 2 RU"
   echo "309)MIR RU             349)-------------  389)ABC News 2         429)Bloomberg Aus   469)Fashion 1 TV ES  509)3ABN Latino       549)Planeta 3 RU"
   echo "310)ORT 3 RU           350)-------------  390)ABC News 3         430)Bloomberg USvnt 470)Jasmin TV USA    510)Salt and Light    550)919FM TV Trinidad"    
   echo "311)-------------      351)-------------  391)ABC News 4         431)Bloomberg Pol   471)TYT USA          511)LLBN TV           551)EBS European Commission"
   echo "312)VietTV VN          352)-------------  392)ABC News 5         432)Bloomberg EUvnt 472)DMC Sports       512)Hillsong          552)EBS Plus"
   echo "313)DZMM ABS-CBN       353)-------------  393)ABC News 6         433)Bloomberg APvnt 473)Pitchoun         513)St. Mary's Coptic 553)-----------" 
   echo "314)DZRH Philippeans   354)-------------  394)ABC News 7         434)Jupiter Broad   474)NRJ Hits FR      514)Word of God Greek 554)UN Trustship"  
   echo "315)PTV Philippines    355)-------------  395)ABC News 8         435)----------      475)Steven Universe  515)Heaven TV         555)UN EOSOC"
   echo "316)Net TV Jakarta ID  356)-------------  396)ABC News 9         436)----------      476)Nature Vision    516)Powervision TV    556)----------"
   echo "317)-------------      357)-------------  397)ABC News 10        437)PBS NewsHour    477)Pursuit Channel  517)KJV Bible         557)----------"
   echo "318)-------------      358)-------------  398)KY3 IL USA         438)CBC The National478)Music Vox TV     518)Harbor Light      558)----------"	 
   echo "319)-------------      359)-------------  399)KNBC 4 Los Angeles 439)AP Top Stories  479)H!T Music Channel519)JUCE TV           559)----------"
   echo "320)-------------      360)-------------  400)--------------     440)Democracy Now   480)Now Music TV     520)Temple Institute  560)----------"
   echo "==================================================================================================================================================="
}

channel_matrix_2()	
{
   echo "============================================================    "$product"  "$version"   ==================================================================="
   echo "|| Latino Extra    ||     Latino Mucho Mas ||    Francais Extra  ||    USA Local 2     ||     USA Local 3   ||    LiveStream 1   ||   LiveStream 2   ||"
   echo "======================================================================================================================================================"
   echo "561)VIVE VE          601)Euronews PT       641)Crime District   681)FOX News Preview 721)KTVB               761)Karbarla IRAQ     801)ONE Malta MT"    
   echo "562)Vatican Media ES 602)TV Assemblelia BR 642)ACTION           682)Fox News Talk    722)Key TV             762)PTN               802)Miramar Mozambique" 
   echo "563)Televen VE       603)TV Canaco Nova    643)ANIMAUX          683)STADIUM          723)KOB4 News          763)Obieqtivi TV      803)Zimbo Online Angola"  
   echo "564)Impacto USA      604)Igreja de Graca   644)Vatican Media FR 684)NFL Now          724)KPNX Breaking      764)Teleantioquia     804)TV5 Argentina"             
   echo "565)UCVTV CL         605)Assemblelia Ales  645)CNEWS FR         685)RED BULL TV      725)KXAN News          765)WIPR Puerto Rico  805)TV UNAM MX"  
   echo "566)UCVTV 2 CL       606)Boas Nova         646)AB3              686)Olympics Channel 726)Laurel TV          766)------------      806)Ezekiel TV"  
   echo "567)Univision USA-   607)Fundacao Nazzare  647)Science et Vie   687)Olympics 2       727)Miami TV           767)AMMAN TV Jordan   807)RedeSuper BR"
   echo "568)Canal 2 AR       608)STF Brazil        648)Polar            688)Olympics 3       728)KNTV-TV            768)Safeer TV IRAQ    808)KVZK TV AS"
   echo "569)ABC Paraguay     609)TV Estúdio Brasil 649)RTL 9            689)Olympics 4       729)Traffic KNTV       769)Al Quaran TV      809)Canal Telecafé CO"
   echo "570)Abya Yala BO     610)Rádio Justiça     650)Antena Centre BE 690)Olympics 5       730)NBC2 News KTUU     770)Suryoyo Sat SE    810)Fiji One"
   echo "571)UFROVision CL    611)EXA FM Brasil     651)QVC Francais     691)NBC News         731)News2 WCBD         771)Cosmovision BO    811)SescTV HD BR"
   echo "572)Campo Abierto CL 612)RIT TV BR         652)France O         692)Shepard Smith    732)News4 WRC          772)Holiday & Cruise  812)MNN NY USA"
   echo "573)UNITV AR         613)Vatican Media PT  653)------------     693)WUSA9 Breaking   733)News4 White House  773)Canal Acequia AR  813)------------"
   echo "574)TelePacifico CO  614)EVTV Miami        654)Tout L'Histoire  694)WCNC Breaking    734)News5 WCYB         774)MNN New York, USA 814)EsteCanal TV"
   echo "575)Canal 8 MarPlata 615)-------------     655)M6               695)WCCB News        735)NewsWest 9 KWES TX 775)GETV Chinese      815)Italia channel" 
   echo "576)Venevision VE    616)-------------     656)W9               696)UGA TV           736)New Orleans TV     776)Z1 Televizija HR  816)Native Media NM USA"
   echo "577)Telediario AR    617)-------------     657)Cstar            697)TVW Washington   737)NBC4 WNBC          777)Vision Cruise AU  817)Mediaon BergamoTV IT"
   echo "578)TVeo Cordoba AR  618)-------------     658)TLM Lyon FR      698)TVW2 Washington  738)NBC4 WNBC Traffic  778)Vision Cruise UK  818)Lake Tahoe TV"	
   echo "579)PSN Tijuana MX   619)-------------     659)SYTRAL Rhone FR  699)Action News KNVN 739)NBC5 WMAQ          779)Lifestyle AZ USA  819)Cinevision DO"
   echo "580)CNN Espanol      620)-------------     660)Bidtween FR      700)Alaska ASD       740)NBC 10 KTEN        780)------------      820)Wisconsin Channel"  
   echo "581)Paraguay Noticias621)-------------     661)--------------   701)Atlanta Channel  741)NBC 12 WWBT        781)WHLT USA          821)Emmanuel TV"
   echo "582)Canal Tr3ce CO   622)-------------     662)MABI CA          702)Beach TV         742)NBC 29 WVIR        782)Medalhão Persa BR 822)Shalom World"       
   echo "583)Canal 12 CO      623)-------------     663)----------       703)Panama City      743)NBC 13 WNYT        783)LRPATV CH25 NH USA823)WDIO Duluth"  
   echo "584)Euronews ES      624)-------------     664)------------     704)Pawleys Island   744)News 12 KTVZ7      784)Santa Fe NM USA   824)KHNL Honolulu"
   echo "585)Imagen Radio MX  625)-------------     665)------------     705)Bowie TV         745)NewsWest 9 KWES DC 785)RIDE TV USA       825)news24.city IT"  
   echo "586)-------------    626)-------------     666)--------------   706)Buffalo TV       746)Orange TV          786)------------      826)WBNS Columbus"
   echo "587)-------------    627)------------      667)--------------   707)Capital City     747)PGCPS              787)Gem Shopping USA  827)WTTG Fox 5 DC "
   echo "588)-------------    628)------------      668)-------------    708)Daytona Beach    748)RyeTV              788)Tomix TV Wein AT  828)WJBK FOX 2 Detroit"
   echo "589)-------------    629)------------      669)-------------    709)DC Knowledge     749)Seattle Channel    789)Radio 21 DE       829)KSL NOW Salt Lake"
   echo "590)Teleamazonas     630)------------      670)-------------    710)DC Network       750)Southeastern       790)Rockland Radio TV 830)KSLA News 12"    
   echo "591)Azteca Uno       631)------------      671)------------     711)Escambia TV      751)Temple TV          791)102.3 NOW! TV CA  831)WSFA 12 Montgomory"
   echo "592)Azteca 7         632)------------      672)-------------    712)FiOS1New Jersey  752)Vienna HQ          792)La Mega 90.9 CO   832)Fox 8 Cleveland"
   echo "593)-------------    633)------------      673) -------------   713)FiOS1Long Island 753)TSTV               793)RTV Posavina HR   833)KELO Keloland " 
   echo "594)-------------    634)------------      674)------------     714)FiOS1HudsonValley754)Escambia           794)skynet MNTV MM    834)HU16 Harding"  
   echo "595)-------------    635)------------      675)------------     715)FOX 5 DC (WTTG)  755)CBS Sports         795)skynet Buddha MM  835)KTVK 3TV AZ"
   echo "596)-------------    636)------------      676)------------     716)Garland TV       756)WYCW Carolinas     796)skynet UpToDate MM836)FOX 26 Houston"
   echo "597)-------------    637)------------      677)------------     717)Greenbelt TV     757)FOX 10 News        797)skynet HLUTTAW MM 837)WAFB 9 CBS Baton Rouge"
   echo "598)-------------    638)------------      678)------------     718)House Represent  758)------------       798)Musig24 TV CH     838)WCSC Charleston"	
   echo "599)-------------    639)------------      679)------------     719)KRBC-TV          759)------------       799)TourbusTV USA     839)WTXF FOX 29"
   echo "600)-------------    640)------------      680)-------------    720)KBVR TV          760)------------       800)Talenu TV TPA     840)WFLA NBC 8 Tampa Bay"
   echo "==================================================================================================================================================="
}	        

channel_matrix_3()	
{
   echo "============================================================    "$product"  "$version"   ==================================================================="
   echo "||  LiveStream 3        ||    LiveStream 4   ||   LiveStream 5     ||   LiveStream 6       ||  LiveStream 7         ||    LiveStream 8      ||   LiveStream 9  ||"
   echo "====================================================================================================================================================================="
   echo "841)WFIE NBC 14          881)YTV Korea CA USA  921)WSAV NBC3 Savannah961)Western Chicopee   1001)WBTV CBS3 Charlotte 1041)GUATEVISIONGuatemala1081)Poder de Dios TV La Paz"    
   echo "842)KOIN Portland OR     882)44 Bolivar MI     922)WSPA CBS7 Spartan 962)KIMT 3 Mason       1002)KPHO CBS5 Pheonix   1042)KY3 Springfield     1082)WYKE TV 47 Hormosassa" 
   echo "843)WTVT FOX 13 Tampa    883)WAND Decatur IL   923)WCMH NBC4 Columbus963)KXAN NBC Austin    1003)WDIO ABC 13 Duluth  1043)710 ESPN Seattle    1083)St. Helena Chapel"  
   echo "844)KUSI San Diego       884)KOAAColoradoSpring924)CBS 17 Rahliegh   964)WKRG CBS5 Mobile   1004)KMSP FOX9Minneapolis1044)Iran Aryaee         1084)Luigi Pellegrini IT"             
   echo "845)Canal 2 AR           885)Enid OK           925)Channel5+Las Vegas965)Lex 18 Lexington   1005)KSBY NBC6 St Barbara1045)DidgahNew TV        1085)St Patrick's Dumbarton"  
   echo "846)Joe Pags Show        886)ThinkTech Hawaii  926)KSNW NBC3 Witchita966)WBNS 10 Radar      1006)KOLD 13 Tucson      1046)Onda Cádiz RTV      1086)Canal 27 Esperanza"  
   echo "847)WBRC FOX6 Mobil      887)WFLX FOX 29       927)WPRIFox12Providen 967)WBNS 10 Columbus   1007)KLTV ABC7 Tyler     1047)NYXT Manhattan      1087)VTNTV VICTORY"
   echo "848)WNYW Fox 5  New York 888)WPS-TV Wichita    928)WWAY Willmington  968)KYMA NBC11 Yuma    1008)WBRC FOX6 Birmingham1048)KingCountyPreston   1088)FGTV Frecuencias"
   echo "849)KMOV 4 St. Louis     889)BelqeesTV Yemen   929)AtlantaRadioKorean969)WOIO CBS19Clevland 1009)Radio TV Rome       1049)Señal Nacional      1089)MNN Channel 3 New York"
   echo "850)WFLD Fox 32  Chicago 890)KAAL Rochester MN 930)OsjeckaTV Zagreb  970)KESQ Palm Springs  1010)K57 Fox 6 Guam      1050)Westerville.TV      1090)CGNTV America Korean"
   echo "851)KHSL Action          891)KRCR Redding CA   931)KIFI ABC 8 Idaho  971)KRDO Colorado Spr  1011)WTVT FOX13 Tampa    1051)Kingdom Access      1091)TMN WORD TV"
   echo "852)WVUE FOX8 New Orleans892)KION Salinas CA   932)Fox26 KNPN SJoseph972)Al-Fallujah IRAQ   1012)WFLA NBC8 Tampa     1052)KCLV FOX2 Las Vegas 1092)Parkside Radio"
   echo "853)KLTV 7 Tyler TX      893)KMVP Phoenix AZ   933)KAUZ CBS6 Winters 973)WFMZ 69 Allen Town 1013)WTNH 8 New Haven    1053)Plaistow Access     1093)Buddha Myanmar"
   echo "854)K24 Nairobi          894)KTAR Phoenix AZ   934)KXXV ABC 25 Waco  974)WTOC 11 Savannah   1014)WMBF Myrtle Beach   1054)Topeka City Kansas  1094)ABHPTV Vietnamese"
   echo "855)KEYT ABC 3 StBarbara 895)Yuma Colombia     935)KATC Lafayette    975)WGCL CBS46 Atlanta 1015)WSFA NBC12Montgomery1055)TeleBahia StDomingo 1095)FGTV Jacksonville" 
   echo "856)ET Today Taiwan      896)WPSD Paducah KT   936)WFLD Fox32 Chicago976)KQTV 2 St.Joseph   1016)WNYW Fox5 New York  1056)Aryen TV Iran       1096)TELEAMIGA"
   echo "857)WAKA  ALABAMA        897)KVRR Fargo ND     937)KPLC NBC7LkCharles977)CGTN America       1017)KVVU FOX5 Las Vegas 1057)Shelby County       1097)Sangat Birmingham"
   echo "858)WJZY Charlotte NC    898)KDLT SiouxFallsSD 938)KOIN 6 Portland   978)KVIA ABC-7 El Paso 1018)KHON CBS2 Ala Mona  1058)Provincetown        1098)El Evangelio Eterno"	
   echo "859)WCCB Charlotte NC    899)GovTV Watertown SD939)WCCB Charlotte    979)KCBD NBC 11 Lubbock1019)WFIE NBC14Evansville1059)MNN-FSTV Manhattan  1099)HJTV Healing Jesus"
   echo "860)WCYB NBC 5 VA        900)KFDXWitchita Falls940)WDAM 7 Hattiesburg980)WALB NBC 10 Albany 1020)WTXF FOX29 Philli   1060)Brunswick TV3       1100)ANB TV"  
   echo "861)WYCW 62 Carolinas    901)Freeway Cams TX   941)WLOX Mississippi  981)KFVE 9 Honolulu    1021)WFLD Fox32 Chicago  1061)Bermuda Government  1101)Apocalypse APTV"
   echo "862)WNCT CBS9 Greenville 902)KQDS Duluth MN    942)WTVM Columbus     982)WWBT NBC12 Richmond1022)KTVK 3 Pheonix      1062)Minhaj TV Pakistan  1102)Sikh Channel"       
   echo "863)WJBF Augusta         903)KOLR SpringfieldMO943)TVMEIO Teresina BR983)WJTV CBS12 Jackson 1023)KRIV FOX26 Houston  1063)Freedom Solar TV    1103)Marytown Chapel"  
   echo "864)KLFY 10 Acadiana     904)WROC Rochester NY 944)WRBL CBS3 Columbus984)WWLP 22 Springfield1024)WVUE FOX8 NewOrleans1064)Shalom Media KIDS   1104)Enlacetv Espanol"
   echo "865)---------------      905)WBRE WilkesBarrePA945)WJHL CBS11 Johnson985)CBS 42 Birmingham  1025)KPTV FOX12 Portland 1065)Faith LutheranChurch1105)VSiN Vegas Stats"  
   echo "866)MNN Channel 1        906)Cumulus NYC       946)KCTV CBS5 Kansas  986)WNYT NBC13 Sandusky1026)KIRO Seattle        1066)Gott24.TV           1106)Guaranty Media"
   echo "867)MNN Channel 4        907)KTVQ Lexington KY 947)WTHI 10TerreHaute 987)TVDIÁRIO 145 MX    1027)BoliviaTV La Paz    1067)TV Fátima Paróquia  1107)ESPN 97.5 Houston"
   echo "868)WWOR Secaucus        908)Dominio Radio MX  948)WBBJ ABC7 Tennesee988)KEYT ABC3 StBarbara1028)KUSI San Diego      1068)-----------------   1108)TV Udine Italy"
   echo "869)KSNT                 909)TV RAIAR          949)KTVZ 21 BendOregon989)WLBT FOX40 Jackson 1029)Fox 8 Cleveland     1069)JesusTV Guatemala   1109)Football Hall of Fame"
   echo "870)WANE Ft. Wayne       910)WFFT FOX 55 IN    950)Nuevolaredo MX    990)WSMV NBC4 Nashville1030)KSLA CBS12Shreveport1070)Whole Life Ministry 1110)Lance Hope RSL"    
   echo "871)KTXS 12 ABC          911)WAAY News ABC 31  951)Señal 13 CR       991)DayTraderRockStar  1031)K24 Nairobi Kenya   1071)Second Presbyterian 1111)DiTV Canale 89"
   echo "872)Island TV            912)50 Versilia IT    952)KEZI ABC9 Eugene  992)WALA FOX10 Mobile  1032)KELO CBS Sioux Falls1072)iTV Networks ZA     1112)XBTV Rosecroft"
   echo "873)KSNT Kansas          913)Iberia TV Georgia 953)news24.city Milan 993)KMOV CBS4 St.Louis 1033)KSL Salt Lake City  1073)Iglesia Advenimiento1113)LIfeTOnicNET Korea" 
   echo "874)Emisora CO           914)50 Canale Pisa IT 954)WDEF 12Chattanooga994)Lex & Terry Lufkin 1034)Up To Date Myanmar  1074)St. Catharine       1114)Park City PCTV"  
   echo "875)TV MONARCA MX        915)SPC-TV S.Petrberg 955)KCOY CBS12 StMaria995)KVOA NBC4 Tuscon   1035)WTTG Fox5 Wash DC   1075)Rede Gênesis Europa 1115)BoliviaTV La Paz"
   echo "876)KMIZ Missouri        916)Señal UNTREF      956)WTOL CBS11 Toledo 996)Mike Malloy Show   1036)WCSC CBS5 Charleston1076)Dashmesh Culture    1116)Cosmovision TV"
   echo "877)KFDA Amarillo TX     917)WWTV 9            957)WIS NBC10 Columbia997)KHSL CBS12 Redding 1037)WBNS 10 Columbus    1077)Expande TV Puebla   1117)WHLT 12 Whitehall"
   echo "878)KZTVCorpusChristi TX 918)WPHL TV ABC 6     958)WMC NBC5 Memphis  998)KSTP ABC5 St.Paul  1038)WJBK FOX2 Detroit   1078)Tv Universal MX     1118)OUBN - Oakwood"	
   echo "879)Tampa TV FL          919)WCCB Charlotte    959)HTV10 Houma       999)MNTV Myanmar       1039)WAFB CBS9 BatonRouge1079)Glory to God        1119)Nasdaq Bell"
   echo "880)WMGT Macon Georgia   920)WCBD NBC2 Charles 960)WRIC ABC8 Peters  1000)KSWO ABC7 Winters 1040)WFMZ 69 TrafficAllen1080)BethelTV Bethel Pana1120)AAA Guayama"
   echo "================================================================================================================================================================="
}	

channel_matrix_4()	
{
   echo "============================================================    "$product"  "$version"   ==================================================================="
   echo "||  LiveStream 10      ||     LiveStream 11  ||    Column 3       ||   Column      4     ||  Column 5         ||    Column 6        ||   Locations    ||"
   echo "======================================================================================================================================================"
   echo "1121)AWCATV - Education1161)KCOH TV Houston   1201)------------      1241)------------     1281)------------      1321)------------     1361)NASA ISS 1 "    
   echo "1122)Branson Visitor   1162)Lake Tahoe TV     1202)------------      1242)------------     1282)------------      1322)------------     1362)Venice Bridge " 
   echo "1123)Politv Bogota     1163)TV Arcana         1203)------------      1243)------------     1283)------------      1323)------------     1363)JacksonHole Sq "  
   echo "1124)98 Live Brasil    1164)BergamoTV Italy   1204)------------      1244)------------     1284)------------      1324)------------     1364)JacksonHole Rust"             
   echo "1125)TMN Hays Kansas   1165)Ariana Live       1205)------------      1245)------------     1285)------------      1325)------------     1365)Aosta Sarre Italy"  
   echo "1126)Telelibertà Italy 1166)Telecafé Bogota   1206)------------      1246)------------     1286)------------      1326)------------     1366)Buenos Aires  "  
   echo "1127)MNN Channel 5     1167)SescTV Sao Paulo  1207)------------      1247)------------     1287)------------      1327)------------     1367)Amsterdam NL "
   echo "1128)TV39 WIVM Canton  1168)KVZK A. Samoa     1208)------------      1248)------------     1288)------------      1328)------------     1368)Shibua Japan"
   echo "1129)EPlusTV6 Jackson  1169)TVUNAM 20         1209)------------      1249)------------     1289)------------      1329)------------     1369)Akiba Japan"
   echo "1130)St.CloudTimes UTVS1170)Florida Gaming    1210)------------      1250)------------     1290)------------      1330)------------     1370)Yahoo Japan "
   echo "1131)Milford TV        1171)TV Miramar Brasil 1211)------------      1251)------------     1291)------------      1331)------------     1371)Steamy Mountain"
   echo "1132)EKBTV Pikeville   1172)Rede Super Brasil 1212)------------      1252)------------     1292)------------      1332)------------     1372)Naman Seoul "
   echo "1133)Milford Education 1173)Kidd Kraddick     1213)------------      1253)------------     1293)------------      1333)------------     1373)Shizuoka Japan"
   echo "1134)Native Media      1174)TalenuLuandaAngola1214)------------      1254)------------     1294)------------      1334)------------     1374)Yokohama Japan "
   echo "1135)Evangel EUTV      1175)ONE Malta         1215)------------      1255)------------     1295)------------      1335)------------     1375)Mount Fuji Japan" 
   echo "1136)rtm tv Arcevia IT 1176)RMG-TV Cleavland  1216)------------      1256)------------     1296)------------      1336)------------     1376)Hart Beach NL"
   echo "1137)UNTREF UN3 AR     1177)------------      1217)------------      1257)------------     1297)------------      1337)------------     1377)Port Du Quebec "
   echo "1138)RUAV Univalle     1178)------------      1218)------------      1258)------------     1298)------------      1338)------------     1378)Durango Colorado"	
   echo "1139)ONE TV NBC 112 IT 1179)------------      1219)------------      1259)------------     1299)------------      1339)------------     1379)StarDot 1"
   echo "1140)Viet Sky TV       1180)------------      1220)------------      1260)------------     1300)------------      1340)------------     1380)Youing Japan "  
   echo "1141)Granbury Media    1181)------------      1221)------------      1261)------------     1301)------------      1341)------------     1381)StarDot 4  "
   echo "1142)ETSU Fine Arts    1182)------------      1222)------------      1262)------------     1302)------------      1342)------------     1382)StarDot 5  "       
   echo "1143)WDFL 18 SC        1183)------------      1223)------------      1263)------------     1303)------------      1343)------------     1383)StarDot 6  "  
   echo "1144)auftanken Austria 1184)------------      1224)------------      1264)------------     1304)------------      1344)------------     1384)London 1  "
   echo "1145)MCAET Salinas     1185)------------      1225)------------      1265)------------     1305)------------      1345)------------     1385)London 2"  
   echo "1146)Bidtween FR       1186)-------------     1226)------------      1266)------------     1306)------------      1346)------------     1386)London 3  "
   echo "1147)BlabTV            1187)------------      1227)------------      1267)------------     1307)------------      1347)------------     1387)Berlin Airport "
   echo "1148)Essex County      1188)------------      1228)------------      1268)------------     1308)------------      1348)------------     1388)Los Angeles Port"
   echo "1149)CNPTV Caribbean   1189)------------      1229)------------      1269)------------     1309)------------      1349)------------     1389)ITS COM Japan"
   echo "1150)LOBO STATION      1190)------------      1230)------------      1270)------------     1310)------------      1350)------------     1390)China Shoreline"    
   echo "1151)Mediatext Italia  1191)------------      1231)------------      1271)------------     1311)------------      1351)------------     1391)------------"
   echo "1152)Maricopa MCTV     1192)------------      1232)------------      1272)------------     1312)------------      1352)------------     1392)------------"
   echo "1153)St.Moritz CH      1193)------------      1233)------------      1273)------------     1313)------------      1353)------------     1393)------------" 
   echo "1154)NRT 4 monclova    1194)------------      1234)------------      1274)------------     1314)------------      1354)------------     1394)------------"  
   echo "1155)ortonville        1195)------------      1235)------------      1275)------------     1315)------------      1355)------------     1395)------------"
   echo "1156)Este Canal Tv     1196)------------      1236)------------      1276)------------     1316)------------      1356)------------     1396)------------"
   echo "1157)CharmTV Baltimore 1197)------------      1237)------------      1277)------------     1317)------------      1357)------------     1397)------------"
   echo "1158)KVVB CH.33        1198)------------      1238)------------      1278)------------     1318)------------      1358)------------     1398)------------"	
   echo "1159)Arcana Barkat     1199)------------      1239)------------      1279)-----------      1319)------------      1359)------------     1399)------------"
   echo "1160)WLTH AM 1370      1200)------------      1240)------------      1280)-----------      1320)------------      1360)------------     1400)------------"
   echo "==================================================================================================================================================="
}	


for arg in $@
do 
 if [ "$arg" == "--help" ]
 then
   echo "ENDSTREAM: watch news live-streams in CLEARNET from youtube using youtube-dl mpv using"
   echo "Type in the terminal $ endstream "
   echo "Now read the list and pick a number,input it and press enter."
   echo ""
   echo "USAGE:"
   echo "$ endstream --help         # usage messages"
   echo "$ endstream --version      # print version information"
   echo "$ endstream --list-matrix  # channel list in matrix format"
   echo "$ endstream --list-all     # channel list in column format"
   echo "$ endstream --ua-tor       # use tor-browser user-agent"
   echo "$ endstream --ua-rand      # use random user-agent from user_agents.txt "
   echo "$ endstream --ua-ranstr    # use a random string as the user agent"
   echo "$ endstream  55            # use channel number in command line"  
   echo "$ endstream  "
   shift
   exit 0
   elif [ "$arg" == "--version" ]
   then
   echo "ENDSTREAM: version: "$version", branch: "$branch" , revision date: "$rev_date" " 
   echo "Copyright: The Endware Development Team, 2016"
   shift
   exit 0
   elif [ "$arg" == "--list-matrix" ]
   then 
   channel_matrix_0
   sleep 2
   channel_matrix_1
   sleep 2
   channel_matrix_2
   sleep 2
   channel_matrix_3
   exit 0
   elif [ "$arg" == "--list-all" ]
   then
   more "$chan_columns"
   exit 0
   elif [ "$arg" == "--ua-rand" ]
   then
   uastate="rand"
   uamode="on"
   shift
   elif [ "$arg" == "--ua-ranstr" ]
   then
   uastate="ranstr"
   uamode="on"
   shift
   elif [ "$arg" == "--ua-tor" ]
   then
   uastate="tor"
   uamode="on"
   shift
   elif [ "$arg" == "--ua-row1" ]
   then
   uastate="row1"
   uamode="on"
   shift
   elif [ "$arg" == "--no-agent" ]
   then
   uamode="off"
   shift 
   elif [ "$arg" == "--no-header" ]
   then
   headmode="off"
   shift   
 fi
done

############################  FUNCTIONS ##################################################################

## Channel Selection function  (ADD CHANNELS HERE)
channel_select()
{

chan_num=$1

case $chan_num in 
################    ENGLISH     ##################################
################      EUROPE    #################################
# 1) Sky News
1)
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/07.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/06.m3u8
link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/05.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/04.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/03.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/02.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/01.m3u8
keyword="Sky"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCd6knJkq4XBNHZATKWFNmGQ/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Sky News" ;;
# 2) BBC News London
2) 
keyword=":"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/bbcnews/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=https://www.filmon.com/tv/bbc-news
use_cookies="yes"
chan_name="BBC News London" ;; 
# 3) RT UK
3)
#link=https://www.rt.com/on-air/rt-uk-air/ 
#link=https://secure-streams.akamaized.net/rt-uk/index.m3u8
#link=https://secure-streams.akamaized.net/rt-uk/index2500.m3u8
link=https://secure-streams.akamaized.net/rt-uk/index1600.m3u8
#link=https://secure-streams.akamaized.net/rt-uk/index800.m3u8
#link=https://secure-streams.akamaized.net/rt-uk/index400.m3u8
#link=https://secure-streams.akamaized.net/rt-uk/indexaudio.m3u8
#link=https://www.filmon.com/tv/russia-today-2
use_cookies="no"
chan_name="RT UK" ;;
# 4)  RTE News NOW
4)    
link=http://wmsrtsp1.rte.ie/live/android.sdp/playlist.m3u8
use_cookies="no"
chan_name="RTE News NOW" ;;
# 5) France 24 Anglais 
5) 
keyword="FRANCE 24 Live"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/france24english/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
#link=http://f24hls-i.akamaihd.net/hls/live/221193-b/F24_EN_LO_HLS/master.m3u8
link=http://f24hls-i.akamaihd.net/hls/live/221193-b/F24_EN_LO_HLS/master_900.m3u8
#link=http://static.france24.com/live/F24_EN_LO_HLS/live_web.m3u8
# link=http://static.france24.com/live/F24_EN_LO_HLS/live_ios.m3u8
# link=http://www.dailymotion.com/video/xigc8z
use_cookies="no"
chan_name="France 24 English";;
# 6) DW English
6) 
keyword="DW"
#link=http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/master.m3u8
#EXTM3U
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=163000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_5_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=163000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_5_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_4_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_4_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_3_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_3_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_2_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_2_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1664000,RESOLUTION=720x400,CODECS="avc1.77.30, mp4a.40.2"
link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1664000,RESOLUTION=720x400,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_1_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_5_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_5_a-b.m3u8?sd=10&rebase=on"
#link= http://dwstream1-lh.akamaihd.net/i/dwstream1_live@120422/master.m3u8
# link=https://www.filmon.com/tv/dw-english
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/deutschewelleenglish/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="DW English" ;;
# 7) Russia Today
7)
#link=https://www.rt.com/on-air/ 
#link=https://secure-streams.akamaized.net/rt/index.m3u8
#link=https://secure-streams.akamaized.net/rt/index2500.m3u8
link=https://secure-streams.akamaized.net/rt/index1600.m3u8
#link=https://secure-streams.akamaized.net/rt/index800.m3u8
#link=https://secure-streams.akamaized.net/rt/index400.m3u8
#link=https://secure-streams.akamaized.net/rt/indexaudio.m3u8
## link=https://www.filmon.com/tv/russia-today-1
use_cookies="no"
chan_name="Russia Today" ;;
# 8) EuroNews English
8) 
keyword="euronews"
link=http://www.dailymotion.com/video/x2j4h4m
#format=hls-1080
#format=hls-720
format=hls-480 
#format=hls-380 
#format=hls-240
#link=http://fr-par-iphone-2.cdn.hexaglobe.net/streaming/euronews_ewns/ipad_en.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewspe/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=https://www.youtube.com/watch?v=$(curl -A "$UA" "https://www.youtube.com/user/Euronews/videos?&view=2" | grep "watch?v=" | grep "$keyword" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/playlist.m3u8
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/ewnsabrenpri_eng_720p.m3u8
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/ewnsabrenpri_eng_540p.m3u8
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/ewnsabrenpri_eng_360p.m3u8
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/ewnsabrenpri_eng_224p.m3u8
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/ewnsabrenpri_eng_180p.m3u8
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/ewnsabrenpri_eng_90p.m3u8
use_cookies="no"
chan_name="Euronews English" ;; 
########################## USA MAINSTREAM ###################################################
# 9) CBSN 
9)
keyword="LIVE"
#wget -O "$temp_pl" https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8
#link=$( grep "84" "$temp_pl"| head -n 2 | tail -n 1 )
#rm "$temp_pl"
#link=https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8?iu=/8264/vaw-can/mobile_web/cbsnews_mobile
link=https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8?RESOLUTION=1280x720
#link=https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8?#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1390400,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=960x540
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/ecda85b07d04103f3ca263c0ba45447a/bandwidth/2050400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2490400,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1280x720
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/d2d912cba6f550796732975cdced5d96/bandwidth/2490400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1390400,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=960x540
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/8e1f7a0b0b497a068d03deb47580e51f/bandwidth/1390400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=840400,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=640x360
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/4d0b0dfc2918a3cc7f47a0a730929d96/bandwidth/840400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=466400,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x360
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/b50367378267629c864cd89d88c8fd95/bandwidth/466400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=202400,CODECS="avc1.4d400d,mp4a.40.2",RESOLUTION=320x180
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/3ccfbd78e5563dc27b4b641ea47d57df/bandwidth/202400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2050400,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1280x720
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/d775971050601257bb7c76251d270815/bandwidth/2050400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2490400,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1280x720
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/5c306911638efba6b41a97aace92a9b8/bandwidth/2490400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1390400,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=960x540
#link=https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/d448eed23b33ac60ea2c306497c19b82/bandwidth/1390400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=840400,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=640x360
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/08bc2b629496b8a03063028ed25a08b3/bandwidth/840400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=466400,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x360
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/bf31306f9670a41fe087269c2f6eb576/bandwidth/466400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=202400,CODECS="avc1.4d400d,mp4a.40.2",RESOLUTION=320x180
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/977e885c0d735a9b92ae9a4ef4d6c2ea/bandwidth/202400.m3u8

#link=https://www.cbsnews.com/common/video/dai_prod.m3u8
#
#link=http://cbsnewshd-lh.akamaihd.net/i/CBSNHD_7@199302/master.m3u8
#link=http://cbsnewshd-lh.akamaihd.net/i/CBSNHD_7@199302/index_2200_av-b.m3u8?sd=10&rebase=on
#
#link=https://www.youtube.com/watch?v=$(curl -A "$UA" "https://www.youtube.com/user/CBSNewsOnline/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)
use_cookies="no"
chan_name="CBSN" ;;

# 10) # MSNBC
10)
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/master.m3u8"
#link=http://msnbclive-lh.akamaihd.net/i/msnbc_live01@180610/master.m3u8
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_1296_av-p.m3u8?sd=10&rebase=on"  

#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=296000,RESOLUTION=416x236,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_296_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=296000,RESOLUTION=416x236,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_296_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=496000,RESOLUTION=416x236,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_496_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=496000,RESOLUTION=416x236,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_496_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=796000,RESOLUTION=640x360,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_796_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=796000,RESOLUTION=640x360,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_796_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1296000,RESOLUTION=960x540,CODECS="avc1.64001f, mp4a.40.2"
link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_1296_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1296000,RESOLUTION=960x540,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_1296_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1896000,RESOLUTION=960x540,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_1896_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1896000,RESOLUTION=960x540,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_1896_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2596000,RESOLUTION=1280x720,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_2596_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2596000,RESOLUTION=1280x720,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_2596_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=4296000,RESOLUTION=1920x1080,CODECS="avc1.640028, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_4296_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=4296000,RESOLUTION=1920x1080,CODECS="avc1.640028, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_4296_av-b.m3u8?sd=10&rebase=on"

use_cookies="no"
chan_name="MSNBC";;  

# 11) Bloomberg Business USA
11) 
keyword="Bloomberg"
#link=https://www.bloomberg.com/live/us
#link="http://cdn3.videos.bloomberg.com/btv/us/master.m3u8?b?b*t$"
#link=http://cdn-videos.akamaized.net/btv/desktop/akamai/europe/live/primary.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Bloomberg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
link=https://liveproduseast.akamaized.net/us/Channel-USTV-AWS-virginia-1/Source-USTV-1000-1_live.m3u8
use_cookies="no"
chan_name="Bloomberg Business USA";;  
# 12) RT America
12)
#link=https://www.rt.com/on-air/rt-america-air/
#link=https://secure-streams.akamaized.net/rt-usa/index.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/index.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/index2500.m3u8
link=https://secure-streams.akamaized.net/rt-usa/index1600.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/index800.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/index400.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/indexaudio.m3u8
use_cookies="no"
chan_name="RT America" ;;
# 13) CGTN America
13)
link="https://api.new.livestream.com/accounts/7082210/events/7115682/live.m3u8?BANDWIDTH=1756000"
use_cookies="no"
chan_name="CGTN America" ;;
# 14) Newsy
14) 
#link=http://www.newsy.com/live/
link=https://content.jwplatform.com/players/hBmO7M6k
#link=https://www.filmon.com/tv/newsy
use_cookies="no"
chan_name="Newsy" ;;
# 15)ABC News USA 
15)
#link="https://abclive2-lh.akamaihd.net/i/abc_live11@423404/master.m3u8"
link="https://abclive2-lh.akamaihd.net/i/abc_live11@423404/index_2500_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive2-lh.akamaihd.net/i/abc_live11@423404/index_4000_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive2-lh.akamaihd.net/i/abc_live11@423404/index_1200_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC News USA" ;;
############################# MIDDLE EAST ##############################################################
# 16) TRT World
16) 
keyword="TRT"
#link=http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=664000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_360p_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=654000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_360p_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=818000,RESOLUTION=852x480,CODECS="avc1.77.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_480p_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=776000,RESOLUTION=852x480,CODECS="avc1.77.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_480p_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=972000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_720p_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=871000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_720p_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=4564000,RESOLUTION=1920x1080,CODECS="avc1.77.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_1080p_av-p.m3u8?sd=10&rebase=on"

#link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_1080p_av-p.m3u8?sd=10&rebase=on"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC7fWeaHhqgM4Ry-RMpM2YYw/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="TRT World";;   
# 17) i24 News Israel
17) 
keyword="Live"  
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/i24News/videos?view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
link="https://www.dailymotion.com/video/x29atae"
#link=https://stream-01.dc3.dailymotion.com/44/dm/3/x29atae/live-4.m3u8
#link=https://stream-01.dc3.dailymotion.com/44/dm/3/x29atae/live-3.m3u8
#link=https://stream-01.dc3.dailymotion.com/44/dm/3/x29atae/live-2.m3u8
#link=https://stream-01.dc3.dailymotion.com/44/dm/3/x29atae/live-1.m3u8
#format=hls-1080
format=hls-720
#format=hls-480 
#format=hls-380 
#format=hls-240
use_cookies="no"
chan_name="i24 News Israel English" ;;
# 18) Al Jazeera
18) 
keyword="Al Jazeera English - Live" 
link=https://players.brightcove.net/665003303001/SkrZHHcl_default/index.html?videoId=4865263685001
#link=http://aljazeera-eng-apple-live.adaptive.level3.net/apple/aljazeera/english/800.m3u8
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/AlJazeeraEnglish/videos?view=2" | grep "$keyword"  | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Al Jazeera English" ;;  
# 19) Press TV
19)
#link=https://www.filmon.com/tv/press-tv
link=http://107.189.40.49:1935/live/ptven/playlist.m3u8
use_cookies="no"
chan_name="Press TV" ;;  
################### INDIA  ########################################
# 20) India TODAY
20)
keyword="IndiaToday Live TV"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCYPvAwZP8pZhSMW8qs7cVCw/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link="https://feeds.intoday.in/hltapps/api/master.m3u8"
link="https://feeds.intoday.in/hltapps/api/master.m3u8?BANDWIDTH=2128000"
use_cookies="no"
chan_name="India TODAY English" ;;  
# 21) NEWS X INDIA English
21) 
keyword="Live"
link=http://newsx.live-s.cdn.bitgravity.com/cdn-live/_definst_/newsx/live/newsxnew.smil/playlist.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/newsxlive/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NEWS X INDIA English" ;; 
# 22) NDTV IN
22)
link=http://ndtv.live-s.cdn.bitgravity.com/cdn-live-b7/_definst_/ndtv/live/ndtv247live.smil/playlist.m3u8
use_cookies="no"
chan_name="NDTV India" ;;  
###########################  ASIA-OCEANIA   ############################################
# 23) CGTN China English
23) 
keyword="Live"
link=https://live.cgtn.com/manifest.m3u8
#link=https://www.filmon.com/tv/cctv-news
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CCTVNEWSbeijing/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="CGTN China English" ;;
# 24)NHK World Japan 
24) 
link=https://nhkwtvglobal-i.akamaihd.net/hls/live/263941/nhkwtvglobal/index_1180.m3u8
use_cookies="no"
chan_name="NHK World Japan" ;;
# 25) CNN PHILIPPINES
25)
link=rtmp://54.251.134.121/live/15273.sdp
use_cookies="no"
chan_name="CNN PHILIPPINES";;
########################## AUSTRALIA ###########################################
# 26)  ABC News Australia 
26) 
keyword="ABC" 
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NewsOnABC/videos?&view=2" | grep "$keyword"  | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
#link=https://abcnews24mha-lh.akamaihd.net/i/abcnews24nospe_1@70019/master.m3u8
#link="https://abcnews24mha-lh.akamaihd.net/i/abcnews24nospe_1@70019/index_250_av-p.m3u8?sd=10&rebase=on"
#link="https://abcnews24mha-lh.akamaihd.net/i/abcnews24nospe_1@70019/index_450_av-p.m3u8?sd=10&rebase=on"
#link="https://abcnews24mha-lh.akamaihd.net/i/abcnews24nospe_1@70019/index_650_av-p.m3u8?sd=10&rebase=on"
link="https://abcnews24mha-lh.akamaihd.net/i/abcnews24nospe_1@70019/index_750_av-p.m3u8?sd=10&rebase=on"
#BANDWIDTH=295680
#link=http://iphonestreaming.abc.net.au/news24/news24_vlo.m3u8
#BANDWIDTH=398944
#link=http://iphonestreaming.abc.net.au/news24/news24_lo.m3u8
#BANDWIDTH=553888
#link=http://iphonestreaming.abc.net.au/news24/news24_med.m3u8
#0BANDWIDTH=708832
#link=http://iphonestreaming.abc.net.au/news24/news24_hi.m3u8
#BANDWIDTH=64000
#link=http://iphonestreaming.abc.net.au/news24/news24_vloaudio.m3u8
use_cookies="no"
chan_name="ABC News Australia" ;;

########################### AFRICA ############################################
# 27) Arise News Nigeria/London
27) 
keyword="Arise"
link=http://contributionstreams.ashttp9.visionip.tv/live/visiontv-contributionstreams-arise-tv-hsslive-25f-16x9-SD/chunklist.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCyEJX-kSj0kOOCS7Qlq2G7g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Arise News Nigeria/London";; 
##################    DOCUMENTARY   ##################################################
# 28)VOA
28)
link=http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=857000,RESOLUTION=512x288,CODECS="avc1.77.30, mp4a.40.2"
#link="http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0288_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=613000,RESOLUTION=524x288,CODECS="avc1.77.30, mp4a.40.2"
#link="http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0288_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1589000,RESOLUTION=720x404,CODECS="avc1.77.30, mp4a.40.2"
#link="http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0404_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1101000,RESOLUTION=734x404,CODECS="avc1.77.30, mp4a.40.2"
link="http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0404_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2078000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0540_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1101000,RESOLUTION=734x404,CODECS="avc1.77.30, mp4a.40.2"
#link=http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0540_av-b.m3u8?sd=10&rebase=on"
#link=https://www.filmon.com/tv/voa-english
use_cookies="no"
chan_name="VOA" ;;
# 29) RT Documentary
29) 
#link=https://rtd.rt.com/on-air/
#link="https://secure-streams.akamaized.net/rt-doc/index.m3u8"
#link="https://secure-streams.akamaized.net/rt-doc/index2500.m3u8"
#link="https://secure-streams.akamaized.net/rt-doc/index1600.m3u8"
link="https://secure-streams.akamaized.net/rt-doc/index800.m3u8"
#link="https://secure-streams.akamaized.net/rt-doc/index400.m3u8"
#link=https://rt-usa-live-hls.secure.footprint.net/rt/doc/index1600.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/doc/index2500.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/doc/index800.m3u8
use_cookies="no"
chan_name="RT Documentary" ;;
# 30) CGTN Documentary
30)
link=https://live.cgtn.com/cctv-d.m3u8
use_cookies="no"
chan_name="CGTN Documentary" ;;
# 31) Bringham Young University TV BYUTV Mormon 
31)
#link=https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master.m3u8
#EXT-X-MEDIA:TYPE=CLOSED-CAPTIONS,GROUP-ID="CC",LANGUAGE="eng",NAME="EN",INSTREAM-ID="CC1"
#EXT-X-STREAM-INF:BANDWIDTH=290400,AVERAGE-BANDWIDTH=290400,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=400x224,FRAME-RATE$
#link=https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master_264.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=510400,AVERAGE-BANDWIDTH=510400,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=400x224,FRAME-RATE$
#link=https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master_464.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=950400,AVERAGE-BANDWIDTH=950400,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=640x360,FRAME-RAT$
#link=https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master_864.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1830400,AVERAGE-BANDWIDTH=1830400,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=960x540,FRAME-R$
link=https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master_1664.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2820400,AVERAGE-BANDWIDTH=2820400,CODECS="avc1.640028,mp4a.40.5",RESOLUTION=1280x720,FRAME-$
#link=https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master_2564.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=4470400,AVERAGE-BANDWIDTH=4470400,CODECS="avc1.640028,mp4a.40.5",RESOLUTION=1280x720,FRAME-$
#link=https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master_4064.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=70400,AVERAGE-BANDWIDTH=70400,CODECS="mp4a.40.5",CLOSED-CAPTIONS="CC"
#link=https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master_64.m3u8
use_cookies="no"
chan_name="Bringham Young University BYU TV USA" ;;
################################### TECHNOLOGY ##############################
# 32)  TWiT USA
32) 
keyword="TWiT Live"
#Twitch
link=https://www.twitch.tv/twit 
#USTREAM
#https://r46932538-1-1524-channel-wss-live.ums.ustream.tv/1/ustream
#https://www.ustream.tv/channel/1524
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/twit/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TWiT USA" ;;

##################    ALTERNATIVE MEDIA   ##################################################
# 33) NEWSMAX USA
33) 
keyword="Newsmax"
#link=http://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/a.m3u8
link=http://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/index_720.m3u8
#link=http://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/index_480.m3u8
#link=http://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/index_360.m3u8
# "http://www.newsmaxtv.com/"
# link=https://nmxlive.akamaized.net/hls/live/529965/Live_1/index.m3u8
#link="http://ooyalahd2-f.akamaihd.net/i/newsmax02_delivery@119568/master.m3u8"
# link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NewsmaxTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NEWSMAX USA";;
# 34)Free Speech TV
34)
#link=https://edge.free-speech-tv-live.top.comcast.net/out/u/fstv.m3u8
link=https://edge.free-speech-tv-live.top.comcast.net/out/u/27153_3.m3u8
#link=https://edge.free-speech-tv-live.top.comcast.net/out/u/27153_4.m3u8
#link=https://edge.free-speech-tv-live.top.comcast.net/out/u/27153_5.m3u8
#link=https://edge.free-speech-tv-live.top.comcast.net/out/u/27153_6.m3u8
use_cookies="no"
chan_name="Free Speech TV" ;;   
# 35)  Infowars
35) 
keyword="Infowars"
#link=http://infowarslive-lh.akamaihd.net/i/infowarslivestream_1@353459/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=720x406,CODECS="avc1.77.30, mp4a.40.2"
link="http://infowarslive-lh.akamaihd.net/i/infowarslivestream_1@353459/index_800_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=928000,RESOLUTION=720x406,CODECS="avc1.77.30, mp4a.40.2"
#link="http://infowarslive-lh.akamaihd.net/i/infowarslivestream_1@353459/index_800_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://infowarslive-lh.akamaihd.net/i/infowarslivestream_1@353459/index_800_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=128000,CODECS="mp4a.40.2"
#link="http://infowarslive-lh.akamaihd.net/i/infowarslivestream_1@353459/index_800_a-b.m3u8?sd=10&rebase=on"

#link=http://www.infowars.com/show
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCUJNY4nfdomMppNDZNZc4nA/videos?&view=2" |grep "watch?v=" | head -n 1 | cut -d = -f 4 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Infowars" ;; 
############################# GOVERNMENT#####################################################
############### UNITED NATIONS #################################################
# 36) United Nations UN Web TV
36) 
keyword="LIVE"
### UN WEB TV
#link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5689257377001
link="https://bcliveunivsecure-lh.akamaihd.net/i/un150_1@575439/index_1328_av-p.m3u8?sd=10&rebase=on"
##Trustship Chamber
#link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5701485575001
##ECOSOC 
#link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5701459952001
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/unitednations/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="United Nations UN Web TV" ;; 
########################## AMERICAN GOVERNMENT ####################################################
# 37) C-SPAN 1 HD
37)
link="http://cspan1-lh.akamaihd.net/i/cspan1_1@304727/index_1000_av-p.m3u8?sd=10&rebase=on"
#link=http://cspan1nontve-lh.akamaihd.net/i/CSpan1NonTVE_1@312667/master.m3u8
use_cookies="no"
chan_name="C-SPAN 1" ;;
########################## CANADIAN GOVERNMENT ###################################################
# 38) CPAC 1 Canada  
38)
link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5027924874001
#link=http://bcoveliveios-i.akamaihd.net/hls/live/248521/1242843915001_1/master.m3u8
# Original Language
#link=http://bcoveliveios-i.akamaihd.net/hls/live/248521/1242843915001_3/master.m3u8
#link=http://bcoveliveios-i.akamaihd.net/hls/live/248521/1242843915001_3//Assets_1518231308621/Layer1_master.m3u8
use_cookies="no"1
chan_name="CPAC 1 Canada" ;;
########################## IRELAND ##############################################
# 39) OIreachtas TV IE
39)  
link=https://oirlive.heanet.ie/oireachtas/ngrp:oireachtas.stream_all/playlist.m3u8
#link=https://oirlive.heanet.ie/oireachtas/ngrp:oireachtas.stream_all/chunklist_b1228000.m3u8
#link=https://media.heanet.ie/oirlive/oireachtas/ngrp:oireachtas.stream_all/playlist.m3u8
use_cookies="no"
chan_name="Oireachtas TV IE" ;; 

######################### GREAT BRITAIN ####################################
# 40) BBC Parliamnet 
40) 
#keyword=":"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/bbcnews/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=https://www.filmon.com/tv/bbc-parliament
use_cookies="yes"
chan_name="BBC Parliament" ;; 
#################    FRENCH   ###################################
# 41) France 24 
41)
keyword="FRANCE 24 en Direct" 
link=http://f24hls-i.akamaihd.net/hls/live/221192-b/F24_FR_LO_HLS/master.m3u8
#link=http://f24hls-i.akamaihd.net/hls/live/221192/F24_EN_LO_HLS/master_900.m3u8
#link=http://www.dailymotion.com/video/xigbvx_live-france-24_news
# link=http://static.france24.com/live/F24_FR_LO_HLS/live_ios.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/france24/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
#format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="France 24" ;;                                               
# 42) BFM TV
42) 
link=https://players.brightcove.net/876450610001/HJeY2afE_default/index.html?videoId=5615950982001
#link=https://bfmtvalive1-a.akamaihd.net/8a3483ffeb9d40f0a738c1392f2bcc14/eu-central-1/876450610001/profile_1/87cd96eea0644453bd913833950774b0/chunklist_ssaiM.m3u8
#link=http://csm-e.dai.bfmtv.com/csm/live/109797390.m3u8
#link=https://www.dailymotion.com/video/xgz4t1_live-bfmtv_news
#link=link=https://www.filmon.com/tv/bfm-tv
use_cookies="no"
#format=hls-1080@60-0 
#format=hls-1080@60-1
#format=hls-720@60-0 
#format=hls-720@60-1 
#format=hls-480-0
#format=hls-480-1
#format=hls-380-0
#format=hls-380-1
#format=hls-240-0
#format=hls-240-1
chan_name="BFM TV";;
## 43) BFM BFM BUSINESS
43) 
link="https://players.brightcove.net/876450612001/HycrnmXI_default/index.html?videoId=1920204345001"
#link=https://bfmbusisecure-i.akamaihd.net/hls/live/265375/876450612001/BFMBusinessS//audio_0_fra/audio_0_fra.m3u8
#link=https://bfmbusisecure-i.akamaihd.net/hls/live/265375/876450612001/BFMBusinessS//video_0/video_0.m3u8
## link=https://bfmbusisecure-i.akamaihd.net/hls/live/265375/876450612001/BFMBusinessS//audio_4_fra/audio_4_fra.m3u8
#link=https://bfmbusisecure-i.akamaihd.net/hls/live/265375/876450612001/BFMBusinessS//video_19/video_19.m3u8
format=""
use_cookies="no"
chan_name="BFM Busineess France" ;;
# 44) RT Francais
44)
#link=https://secure-streams.akamaized.net/rt-fr/index.m3u8
#link=https://secure-streams.akamaized.net/rt-fr/index2500.m3u8
#link=https://secure-streams.akamaized.net/rt-fr/index1600.m3u8
link=https://secure-streams.akamaized.net/rt-fr/index800.m3u8
#link=https://secure-streams.akamaized.net/rt-fr/index400.m3u8
#link=https://secure-streams.akamaized.net/rt-fr/indexaudio.m3u8
use_cookies="no"
chan_name="RT France" ;;
# 45) France Info TV
45) 
keyword="franceinfo"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/franceinfo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
#link=https://www.dailymotion.com/video/x4rdeu6_live-franceinfo-tv_news
#link=https://livefrancetv.akamaized.net/simulcast/France_Info/dash_monde/ZXhwPTE1MjUxODIxMzZ+YWNsPSUyZnNpbXVsY2FzdCUyZkZyYW5jZV9JbmZvJTJmZGFzaF9tb25kZSp+aG1hYz1mZDU1NmM2NmE5ODExZWNlOGI5YjQ1MDc3ZDA2ZTQ4YTg1Y2FmNTkyNTdiY2Q4MWI1YzU4YjRiMWE0M2MxYmUw/France_Info.mpd
link="http://videos.francetv.fr/video/SIM_Franceinfo"
#format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
format="best"
use_cookies="no"
chan_name="France Info TV" ;;  
# 46) CGTN Francais 
46)
link=https://live.cgtn.com/cctv-f.m3u8
use_cookies="no"
chan_name="CGTN Francais" ;; 
# 47) i24 News en Direct
47) link=https://www.dailymotion.com/video/x10358o_i24news-le-direct_tv
use_cookies="no"
format=hls-1080
#format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="i24 Francais";; 
# 48) Euronews Francais
48) 
keyword="direct"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewsfr/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Euronews Francais" ;;  
# 49) Africa News Francais
49) 
keyword="africanews (en français) EN DIRECT"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC25EuGAePOPvPrUA5cmu3dQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Africa News Francais" ;;
# 50) Vedia BE
50)
link=https://5a0b00d270652.streamlock.net/live/vedia-live/chunklist_w665478860.m3u8
use_cookies="no"
chan_name="Vedia BE" ;;
# 51) RTS UN
51) 
#link=http://par-3.firstone.tv/hls/22797bb2-c681-91ce-2f29-fd5690f82b91.m3u8
link=https://www.filmon.com/tv/rts-un
use_cookies="no" 
chan_name="RTS UN" ;;
# 52) FRANCE 2
52) 
#link=http://par-4.firstone.tv/hls/1f181ce3-b1d5-70a2-8cc7-9f6ef5df7d89.m3u8
link=https://www.filmon.com/tv/france-2
use_cookies="no"
chan_name="France 2" ;;
# 53) France 3 
53) 
#link=http://par-4.firstone.tv/hls/f5d676d6-692f-eb8c-8c3c-34f741a0f7b3.m3u8
link=https://www.filmon.com/tv/france-3-rhone-alpes
use_cookies="no"
chan_name="France 3" ;;
# 54) TV 7 Francais
54)  
link=http://tv7.hdr-tv.com:1935/live/tv7/livestream/playlist.m3u8
use_cookies="no"
chan_name="TV 7 Francais" ;;  
# 55) ARTE FRANCAIS
55) 
link=https://www.filmon.com/tv/arte-francais
use_cookies="yes" 
chan_name="ARTE Francais" ;;
# 56) IL TV France
56)
link=rtmp://str81.creacast.com:80/iltv/high
use_cookies="no"
chan_name="IL TV" ;;
# 57) BFM Paris Francais
57)   
link=https://players.brightcove.net/5132998232001/H1bPo8t6_default/index.html?videoId=5152968636001
#link=http://bfmparishdslive-lh.akamaihd.net/i/DVMR_PARIS@429747/master.m3u8
use_cookies="no"
chan_name="BFM Paris Francais" ;;
# 58) Alsace 20 France
58)
link="http://live.alsace20.fr/live/alsace20/ngrp:alsace20_all/master.m3u8"
use_cookies="no"
chan_name="Alsace 20 France" ;;
# 59) Mosaik TV Francais
59)
keyword="Diffusion en direct de mosaiktv"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/mosaiktv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no" 
chan_name="Mosaik TV" ;;
# 60) Direct Journal TVLandes    
60) link=https://www.dailymotion.com/video/x1z2d07_direct-journal-tvlandes_news
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="Direct Journal Tvlandes"  ;;    
# 61) TV7 Bordeaux
61)
#link=http://62.210.204.108:1935/livtv7vo/myStream.smil/playlist.m3u8
link=http://62.210.204.108:1935/livtv7vo/myStream.smil/chunklist_w126434099_b828000_slfra.m3u8
#link=http://62.210.204.108:1935/livtv7vo/myStream.smil/chunklist_w126434099_b328000_slfra.m3u8
use_cookies="no"
chan_name="TV7 Bordeaux" ;;
# 62) 8 Mont Blanc FR
62)
link="http://www.dailymotion.com/video/x3wqv8b"
use_cookies="no"
chan_name="8 Mont Blanc FR" ;;
# 63) Azur TV Nice
63)
link=http://www.dailymotion.com/video/x13x1q2 
use_cookies="no"
chan_name="Azur TV Nice" ;;
# 64) RTS DEUX
64) 
#link=http://par-4.firstone.tv/hls/f1074899-4ce9-5908-4f1f-25aee6dc0ef7.m3u8
link=https://www.filmon.com/tv/rts-deux
use_cookies="no" 
chan_name="RTS DEUX" ;;
# 65) LCP Assemblee National France
65)
link=http://www.dailymotion.com/video/xji3qy
use_cookies="no"
#format=hls-720
format=hls-480
#format=hls-380
#format=hls-240
chan_name="LCP Assemblee National France" ;;
# 66) Public Senate France
66)
link=http://www.dailymotion.com/video/xkxbzc
use_cookies="no"
#format=hls-720
format=hls-480	
#format=hls-380
#format=hls-240
chan_name="Public Senate France" ;;
# 67)Canal Savoir Francais
67)
link=http://stream.canalsavoir.tv/livestream/stream.m3u8
use_cookies="no"
chan_name="Canal Savoir Canada" ;;
# 68) CPAC 1 Francais
68)
#link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5027941315001
link=http://bcoveliveios-i.akamaihd.net/hls/live/248520/1242843915001_2/master.m3u8
use_cookies="no"
chan_name="CPAC 1 Francais Canada" ;;
# 69) Assemblee Nationale du Quebec Francais
69)
link=http://diffusionm4.assnat.qc.ca/canal9/250.sdp/playlist.m3u8
use_cookies="no"
chan_name="Assemblee Nationale du Quebec Francais Canada" ;;
# 70) TVA CA
70) 
link="https://players.brightcove.net/5481942443001/r1t0JFRjG_default/index.html?videoId=5536901934001"
use_cookies="no"
chan_name="TVA CA";;
# 71) GONG Asian Cinema Francais
71)
link=http://ec.playmedia.fr/gong-base/live/playlist.m3u8
use_cookies="no"
chan_name="GONG Asian Cinema Francais" ;;
# 72) GONG MAX
72)
link=http://51.254.215.79/appflux/gongmax/GONGMAX/gongmax_1280/chunks.m3u8 
use_cookies="no"
chan_name="GONG MAX" ;;
# 73)TV5 Monde
73)
link=https://tv5infohls-i.akamaihd.net/hls/live/631613/tv5infohls/v3plusinfo247hls_1_3.m3u8
use_cookies="no"
chan_name="TV5 Monde BE" ;;
# 74) BX1 BE
74)
link=http://149.202.81.107:1935/stream/live/chunklist_w1279780159.m3u8 
use_cookies="no"
chan_name="BX1 BE" ;;
# 75) France Info Radio
75) link=https://www.dailymotion.com/video/x26eox4_live-franceinfo-direct-radio_news
format=hls-380
use_cookies="no"
chan_name="France Info Radio" ;;
# 76) Europe 1
76) link=https://www.dailymotion.com/video/xqjkfz_europe-1-live_news
use_cookies="no"
#format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="Europe 1" ;;
# 77) RFI
77) 
keyword="RFI en Direct"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/rfivideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"  
chan_name="RFI Francais" ;;
# 78) RTL En direct
78) link=https://www.dailymotion.com/video/xl1km0_regardez-rtl-en-direct-et-en-video_news
# link=http://www.dailymotion.com/video/xl1km0
use_cookies="no"
format=hls-1080
#format=hls-720
#format=hls-480
chan_name="RTL En Direct" ;;
# 79) France Inter
79) 
keyword="France Inter en direct"
#link=https://www.dailymotion.com/video/x17qw0a_video-regardez-france-inter-en-direct_newsc
#format=hls-720
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/videofranceinter/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="France Inter" ;; 
# 80) RMC INFO TALK SPORT RADIO FRANCE
80)  
link=https://players.brightcove.net/876630703001/SkKvZlxI_default/index.html?videoId=2623007265001
use_cookies="no"
chan_name="RMC INFO TALK SPORT France" ;;

# 80) TVM FR
# 80)
# link=https://cineplume.vedge.infomaniak.com/livecast/cineplume/chunklist_w1158771188.m3u8
# use_cookies="no"
# chan_name="TVM FR" ;;

###################  SPANISH  #################################
# 81) RT Espanol
81) 
keyword="EN VIVO"
#link=https://secure-streams.akamaized.net/rt-esp/index.m3u8
#link=https://secure-streams.akamaized.net/rt-esp/index2500.m3u8
#link=https://secure-streams.akamaized.net/rt-esp/index1600.m3u8
link=https://secure-streams.akamaized.net/rt-esp/index800.m3u8
#link=https://secure-streams.akamaized.net/rt-esp/index400.m3u8
#link=https://secure-streams.akamaized.net/rt-esp/indexaudio.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ActualidadRT/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCEIhICHOQOonjE6V0SLdrHQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=https://actualidad.rt.com/en_vivo2
use_cookies="no"
chan_name="RT Espanol" ;;
# 82) DW Espanol
82) 
keyword="DW Español en VIVO"
link=http://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/master.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DeutscheWelleEspanol/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="DW Espanol" ;;
# 83) CGTN Espanol
83)
link=https://live.cgtn.com/cctv-e.m3u8
use_cookies="no"
chan_name="CGTN Espanol" ;;
# 84) Hispan TV
84) 
keyword="HispanTV"
link=http://107.189.40.49:1935/live/hispantv/playlist.m3u8
#link=http://178.32.255.199:1935/live/hispantv/playlist.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/hispantv/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no" 
chan_name="HispanTV" ;;
###################### FRANCIA ##########################################
# 85) France 24 Espanol
85) 
keyword="Vivo"
link=http://f24hls-i.akamaihd.net/hls/live/520844/F24_ES_LO_HLS/master.m3u8
#link=http://static.france24.com/live/F24_ES_LO_HLS/live_web.m3u8
#link=http://f24hls-i.akamaihd.net/hls/live/520844/F24_ES_LO_HLS/master_900.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCUdOoVWuWmgo1wByzcsyKDQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="France 24 Espanol" ;;
############## ESPANIA ######################################
# 86) Le Zap  ES
86)
link=https://atresplayerp-i.akamaized.net/antena3mpp/bitrate_4.m3u8
use_cookies="no"
chan_name="Le Zap ES" ;;
# 87) Magala TV Spain  Malaga,Andalusia,Spain
87)  
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Malaga24h/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Magala TV Spain" ;;  
# 88)  GUADA TV Guadalajara (España)
88) 
keyword="Guada"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC4oPWmhiUTekfM5vcWsORLg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Guada TV Spain" ;; 
# 89) GRANADA TV ES
89)  
keyword="GRANADA"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Steadycamline/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="GRANADA TV ES" ;; 
######################### ARGENTINA ##############################################
# 90) c5n Argentina
90) 
keyword="en VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/c5n/videos?&view=2" | grep "watch?v=" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
# link=http://www.c5n.com/
use_cookies="no"
chan_name="c5n Argentina" ;;
# 91) A24 Argentina
91) 
keyword="A24"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCR9120YBAqMfntqgRTKmkjQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="A24 Argentina";;
# 92) Todo Noticias Argentina
92) 
keyword="TN en Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCj6PcyLvpnIRT_2W_mwa9Aw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Todo Noticias Argentina";;
# 93) La Nacion TV Argentina
93) 
keyword="LN+"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/LaNacionTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="La Nacion TV Argentina";;
# 94) TV Publica Argentina
94)  
keyword="Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TVPublicaArgentina/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="TV Publica Argentina" ;;  
# 95) KZO En Vivo Canal 30
95) 
keyword="VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCv0zRACOVWmhu1Ilufm40-w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KZO Canal 30 Cablevision" ;; 
# 96) Canal 6 San Rafael Argentina
96) 
keyword="RAFAEL"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCwq0epWuoVUDbuBz3hpgGeg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"   
chan_name="Canal 6 San Rafael Argentina" ;;
# 97) Canal 7 Mendoza Argentina
97) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/webcanal7mendoza/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Canal 7 Mendoza Argentina" ;;
# 98) Canal 8 San Juan Argentina
98) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC5UKMEIoqvNDMSDz2_6Sn9g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Canal 8 San Juan Argentina" ;;
# 99) Canal 13 San Juan Argentina  
99)  
keyword="Juan"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCnfpjpEMfxPXAI3Nc23MTWA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Canal 13 San Juan Argentina" ;; 
# 100) Showsport Cordoba Argentina
100)  
keyword="Showsport"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CanalShowsport/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Showsport Argentina" ;;  
# 101) Canal 3 SuperCanal Argentina
101)  
keyword="SuperCanal"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/supercanal3oeste/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Canal 3 SuperCanal Argentina" ;;  
# 102) CN23 Argentina
102)  
keyword="CN23"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCC05qIa00qEB06CtCi01NbQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="CN23 Argentina" ;;   
# 103) Telemax Argentina
103)
link="http://live-edge01.telecentro.net.ar/live/smil:tlx.smil/master.m3u8"
use_cookies="no"
chan_name="Telemax Argentina" ;; 
# 104) VORTERIX AR
104)  
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCvCTWHCbBC0b9UIeLeNs8ug/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="VORTERIX AR" ;;
################# PARAGUAY  #############################
# 105) TV Camara Paraguay
105) 
keyword="DIRECTO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCRVeQhiqhUAxRRUod7F-K3A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TV Camara Paraguay" ;;
################ BOLIVIA ###################################
## 106) Bolivia TV BO
106)
link=https://livestream.com/accounts/10468276/boliviatv
use_cookies="no"
chan_name="Bolivia TV BO" ;; 
######################       CHILE       #################################
# 107)Senal Internacional Mega Chile
107)  
keyword="en vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/programasmega/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Senal Internacional Mega Chile" ;;
# 108)  CNN Chile CNN Chile
108)
link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream1/playlist.m3u8
#link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream2/playlist.m3u8
#link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream3/playlist.m3u8
use_cookies="no"
chan_name="CNN Chile" ;;
################## Colombia ###################
# 109)Telemedellin CO
109)  
keyword="Telemedellin"
link=https://livestream.com/accounts/4608897/events/7111788/
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCW_16ow2scNATL0NSxlBtPg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Telemedellin CO" ;; 
# 110) 
# 111) CTV Barranquilla Colombia
111) 
keyword="CTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCJWpMkOWNk3wlj565Q0lpzg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CTV Barranquilla Colombia" ;;
################# VENEZUELA
# 112) TeleSUR Venezuela
112) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/telesurtv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"   
# link=http://cdn2.telesur.ultrabase.net/livecf/telesurLive/master.m3u8
use_cookies="no"
chan_name="TeleSUR Venezuela" ;;
# 113) Globovision Venezeula
113) 
keyword="Globovisión"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCfJtBtmhnIyfUB6RqXeImMw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
#link=http://www.dailymotion.com/video/xio7e2_senal-en-vivo_news
use_cookies="no" 
chan_name="Globovision Venezeula" ;;
# 114) NTN24 Venezuela
114) 
keyword="SEÑAL EN VIVO DE NTN24"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/canalNTN24/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NTN24 Venezuela" ;;
# 115) CONSCIENCIA TV
115)  
keyword="VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClUdUKaJ6qBoqe4o8qN9Bdw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="CONCIENCIA TV" ;;
# 116) VPItv Venezuela
116) 
keyword="VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCVFiIRuxJ2GmJLUkHmlmj4w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="VPItv Venezuela" ;;
#################### CENTRAL AMERICA    ########################
# 117) Tu Canal Panama PA
117)  
keyword="VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/elcanaldepanamatv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Tu Canal Panama PA" ;; 
## 118) Guatevision GT
118)
link=https://livestream.com/accounts/25697071/en-vivo
use_cookies="no"
chan_name="Guatevision GT" ;; 
#################### MEXICO #########################################################
# 119) Excelsior TV Mexico
119) 
keyword="Transmisión en directo de Excélsior TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClqo4ZAAZ01HQdCTlovCgkA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Excelsior TV Mexico" ;;
## 120) Telesur Yucatan 
120)
link=https://livestream.com/accounts/1003100/events/4130805
use_cookies="no"
chan_name="Telesur Yucatan" ;; 

################ CHINESE MANDARIN CANTONESE  ####################
# 121) CCTV 4 Chinese
121) 
keyword="CCTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ChineseInternatioify/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CCTV 4 China" ;;
############## TAIWAN TAIWANESE ##############################
# 122) EBC 51 News Taiwan
 122) 
keyword="EBC" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/newsebc/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="EBC 51 News Taiwan" ;;
# 123) EBC Finance Taiwan
 123) 
keyword="EBC" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/57ETFN/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="EBC Finance News Taiwan" ;;
# 124) TTV News Taiwan  
 124) 
keyword="TTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCzZe-zMu-YgVFQfDmsFG_VQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TTV News Taiwan"  ;;
# 125) CTV Taiwan 
125) 
keyword="中視新聞台 LIVE直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCmH4q-YjeazayYCVHHkGAMA/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="CTV Taiwan" ;;
# 126) FTV Taiwan
126) 
keyword="台灣民視新聞HD直播 | Taiwan Formosa live news HD"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClIfopQZlkkSpM1VgCFLRJA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="FTV Taiwan Live";;
# 127) CTS World News HD Taiwan
127) 
keyword="國會頻道１ | Live直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCA_hK5eRICBdSOLlXKESvEg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CTS World News HD" ;;
# 128) SET News Taiwan
128) 
keyword="SET"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/setnews159/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SET News Taiwan" ;;
# 129) CTI Taiwan 
129) 
keyword="CTI"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ctitv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="CTI Taiwan" ;;
# 130) SET iNEWS Taiwan
130) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/setmoney159/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="SET iNEWS Taiwan" ;; 
# 131) Formosa News HD Taiwan
131) 
keyword="Formosa"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClIfopQZlkkSpM1VgCFLRJA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Formosa News HD Taiwan";;
#  132) TzuChi DaAi World Taiwan 
132) 
keyword="DaAi World HD"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DaAiVideo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Tzu Chi DaAi World Taiwan" ;; 
# 133) 大愛電視 Tzu Chi DaAiVideo 
133) 
keyword="大愛一臺HD Live 直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DaAiVideo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="Tzu Chi DaAiVideo 1" ;; 
# 134) 大愛一臺HD Live 直播
134)
keyword="大愛二臺HD Live直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DaAiVideo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="Tzu Chi DaAiVideo 2" ;;  
# 135) TLTV
135) 
keyword="天良電視台即時串流"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCVDgvpdyy8VbpsiXjc-kdGQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="TLTV";;
# 136) FLTV Taiwan   ****
136) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCfXY08An6l_o44W5PpkCApg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="FLTV Taiwan";;
# 137) Sinda Television
137) 
keyword="信大電視台"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCZIvbuuP-xGgMG-_0tLLadg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Sinda Television" ;; 
# 138) Cheng Sin TV
138) 
keyword="誠心衛星電視台"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCiqQ09Js9wGNUo3QNNaiYgg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Cheng Sin TV";;
# 139) CTS World News HD 2 Taiwan
139) 
keyword="國會頻道２ | Live直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCA_hK5eRICBdSOLlXKESvEg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CTS World News HD 2" ;;
# 140) SJTV TW
140) 
keyword="SJTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SJTVonline/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="SJTV TW";;
# 141) SITTI 1 **
141)  
keyword="桐瑛二臺"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCV0ICYFwH29CVCWpYtGfdlw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="SITTI 1";;
# 142) SITTI 2 **
142) 
keyword="桐瑛二台"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCV0ICYFwH29CVCWpYtGfdlw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="SITTI 2";;
# 143) SITTI 3  **
143) 
keyword="桐瑛三臺"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCV0ICYFwH29CVCWpYtGfdlw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="SITTI 3";;
# 144) 119 Live 電視台大立  Da Li Taiwan  
144)
keyword="119"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC2nRKndta05aZZbjFUAcoFg/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="119 Live 電視台大立 Da Li Taiwan" ;;
# 145) SDTV 04CH Taiwan  
145)
keyword="04CH"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCBWzi-vMywDa05QYA2jHxwQ/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="SDTV 04CH TW" ;;
# 146) Fanstelevision Taiwan  
146)
keyword="番薯衛星電視台現場直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC2UCHUxTWVkSqP6MILU5Bqw/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Fans TV TW" ;;
# 147) Hong Kong TV
147)
link=rtmp://live.hkstv.hk.lxdns.com/live/hks
use_cookies="no"
chan_name="Hong Kong TV" ;;
# 148) Arirang TV Korea English
148) 
keyword="Arirang" 
#link=http://www.filmon.com/tv/arirang-tv
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/arirang/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
#BANDWIDTH=1728000,RESOLUTION=1280x720
#link=http://amdlive.ctnd.com.edgesuite.net/arirang_1ch/smil:arirang_1ch.smil/chunklist_b1728000_sleng.m3u8
#BANDWIDTH=1328000,RESOLUTION=960x540
#link=http://amdlive.ctnd.com.edgesuite.net/arirang_1ch/smil:arirang_1ch.smil/chunklist_b1328000_sleng.m3u8
#BANDWIDTH=928000,RESOLUTION=850x480
#link=http://amdlive.ctnd.com.edgesuite.net/arirang_1ch/smil:arirang_1ch.smil/chunklist_b928000_sleng.m3u8
#BANDWIDTH=528000,RESOLUTION=640x360
#link=http://amdlive.ctnd.com.edgesuite.net/arirang_1ch/smil:arirang_1ch.smil/chunklist_b528000_sleng.m3u8
#link=http://worldlive-ios.arirang.co.kr/arirang/arirangtvworldios.mp4.m3u8
#link=http://worldlive-ios.arirang.co.kr/cdnlive-hls/arirangwlive/_definst_/liveevent/tvworld2.m3u8
use_cookies="no"
chan_name="Arirang TV Korea" ;; 
# 149)SBS IN  **
149) 
keyword="SBS-IN" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/channel/UCBzkVegsFusO7ZMa_J8MZ7Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SBS-IN" ;;
# 150) TBS Live Korea  
150) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC5HSw5OY2vfVFSihpiB-AVQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TBS Live Korea" ;; 
# 151) YTN DMB Korea  
151) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ytndmb/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="YTN DMB Korea" ;; 
# 152) SBS News Live Korea   **
152) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/sbsnews8/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SBS News Korea" ;; 
# 153) YTN Science Korea  
153) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ytnscience/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="YTN Science Korea" ;; 
# 154) Channel 23 Korea  
154) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCTHCOPwqNfZ0uiKOvFyhGwg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Channel 23 Korea" ;; 
# 155) KBS World 24 Korea
155) 
keyword="On-Air"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/kbsworld/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KBS World 24 News" ;;
# 156) YTN 27 Korea 
156)
keyword="YTN LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ytnnews24/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="YTN LIVE Korea" ;;   
# 157) ANN JapaNews 24 Japan
157) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ANNnewsCH/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="ANN News 24 Japan" ;;
# 158) Sol!ve 24 Japan
158) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCNsidkYpIAQ4QaufptQBPHQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Sol!ve 24 Japan";; 
# 159) KBS Live 24 Japan  
159) 
keyword="KBSLIVE24"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UChSodm7QfwnUqD63BpqZC6Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KBS Live 24 Japan" ;; 
#  160) QVC JAPAN SHOPPING CHANNEL
160) 
keyword="QVC"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/QVCJapan/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="QVC JAPAN SHOPPING CHANNEL" ;;

############## BROKEN / OFFLINE #########################
# 154) KBS World Korea  ***
# 154) 
# link=rtmp://118.97.183.196/jhos//kbs
# use_cookies="no"
# chan_name="KBS World Korea" ;;
# 153)CTS Korea   ***
# 153) 
# link=http://ctsnanum.rtsp.vercoop.com:1935/CTS/CTS_34312_200.sdp/playlist.m3u8
#link=http://ctsnanum.rtsp.vercoop.com:1935/CTS/_definst_/CTS_34312_100.sdp/playlist.m3u8
# use_cookies="no"
# chan_name="CTS Korea" ;;
###### INDIAN, HINDI, URDU, DARI, PASHTUN##################
# 161) News 9 Bangalore Karnataka
161)
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/news9tv/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="News 9 Bangalore Karnataka" ;;  
# 162) CVR English India
162) 
keyword="CVR" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CVREnglishOfficial/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="CVR English India" ;;   
# 163) CVR News India
163) 
keyword="CVR" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CVRNewsOfficial/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="CVR News India" ;;  
# 164) Shaski India
164) 
keyword="Sakshi"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCQ_FATLW83q-4xJ2fsi8qAw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Shaski India" ;;
# 165) SunNews 
165) 
keyword="SUN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCYlh4lH762HvHt6mmiecyWQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="SunNews" ;; 
# 166) TV9 India Live
166) 
keyword="TV9"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tv9telugulive/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="TV9 Live India";;    
# 167) Rajya Sabha TV
167) 
keyword="Rajya"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/rajyasabhatv/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Rajya Sabha" ;;
# 168) TV9 Gujarat
168) 
keyword="Tv9 Gujarati LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tv9gujaratlive/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="TV 9 Gujarat" ;; 
# 169) Tv9 Marathi
169) 
keyword="TV9"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tv9maharashtra/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Tv9 Marathi" ;; 
# 170) News 7 Tamil
170) 
keyword="Tamil"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/news7tamil/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="News 7 Tamil" ;;
# 171) T News Telegu 
171)
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com//channel/UCFv8Oq8IXdUGoeryZtcqJ3A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="T News Telegu" ;;
# 172) News 18 India
172) 
keyword="News18 India Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ibn7/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="News 18 India" ;;
# 173) Aaj Tak 
173) 
keyword="Aaj"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/aajtaktv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Aaj Tak" ;; 
# 174) NTV Telugu
174) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ntvteluguhd/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="NTV Telugu" ;;
# 175) ABN Telugu
175) 
keyword="ABN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/abntelugutv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="ABN Telugu" ;;
# 176) Vanitha TV 
176) 
keyword="Vanitha TV Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/VanithaTvChannel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="Vanitha TV" ;;
# 177) HMT Telugu
177) 
keyword="HMTV Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/hmtvlive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 3 | cut -d \" -f 1)"
use_cookies="no"
chan_name="HMT Telugu" ;;
# 178) India TV IN
178)    
link=http://indiatvnews-lh.akamaihd.net/i/ITV_1@199237//master.m3u8
keyword="Live"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/IndiaTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="India TV IN" ;; 
# 179) Channel 24 India
179) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHLqIOMPk20w-6cFgkA90jw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Channel 24 India";;
# 180) Suvarna News
180)
keyword="SUVARNA"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/suvarnanews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Suvarna News" ;;     
# 181)i News Telugu
181) 
keyword="iNews"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/inews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="iNews Telugu" ;; 
# 182) News 1 Kannada 
182)
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCTvL-zDcTSHSxEVZ6N3Kn1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="News 1 Kannada" ;; 
# 183) Image Channel IN
183) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ImgTVchannel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Imaage Channel IN" ;;  
# 184) Puthiyah Thalimurai Tamil Live News
184) 
keyword="LIVE" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/PTTVOnlineNews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Puthiyah Thalimurai Tamil Live News";;
## 185) DD News
185) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DDNewsofficial/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
 chan_name="DD News" ;; 
# 186) REPORTER LIVE
186) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCFx1nseXKTc1Culiu3neeSQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Reporter Live" ;;
# 187) AsiaNet News
187) 
keyword="LIVE" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/asianetnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="AsiaNet News" ;;     
# 188)V6 News
188) 
keyword="Telugu Live News"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/V6NewsTelugu/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="V6 News" ;;
# 189) Aaj Tak TV IN
189) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/aajtaktv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Aaj Tak TV IN" ;;  
# 190) ETV Andhra Pradesh
190) 
keyword="ETV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/newsetv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="ETV Andhra Pradesh" ;;
# 191) News 18 Tamilnadu
191) 
keyword="News18"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCat88i6_rELqI_prwvjspRA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="News 18 Tamilnadu" ;;
# 192) Jaya Plus
192) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/jayapluschennai/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 ) "  
use_cookies="no"
chan_name="Jaya Plus" ;;
# 193) TEZ TV
193) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/teztvnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TEZ TV" ;;
# 194) Dilli Aaj Tak
194) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DilliAajtak/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Dilli Aaj Tak";;
# 195) ATN News Bangladesh
195) 
keyword="ATN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCKlhfq1ILoAFav7iw5iCnfA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ATN News Bangladesh";;  
# 196)  Somoy TV Bangladesh
196) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCNUFterLJ9vpFZZ0try7sLA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Somoy TV Bangladesh" ;;  
# 197) Sagarmatha Nepal
197) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/sagarmathatvnepal/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Sagramatha Nepal" ;;  
# 198) Derana Sri Lanka  
198)
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tvderanavideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Derana Sri Lanka" ;;  
# 199) Swarnavahini Sri Lanka 
199)
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCAH7R88V7gz7RqJv78nNOzg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Swarnavahini Sri Lanka " ;;  
# 200) Kalaignar News
200) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCcVF2Fth-qEA4T1Lhn3CgKg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 ) " 
use_cookies="no"
chan_name="Kalaignar News" ;;
################### BROKEN / Offline
# Media One News
# 185)
# keyword="Live"
# link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCpt10lzibN9Ux-tFGVAnrBw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
# use_cookies="no"
# chan_name="Media One";;
### 188)  Desi TV
# 188)  
# link=http://www.dailymotion.com/video/x5lt6jg
# use_cookies="no"
# chan_name="Desi TV" ;; 
# 185) Pilupu TV Telugu America
# 185) 
#link=http://www.dailymotion.com/video/x60vptw
#use_cookies="no"
#chan_name="Pilupu TV Telugu America" ;; 
#

##################### PAKISTAN  ############################
# 201)Aaj News PK
201) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCdHy-hnyIEZBHkPJecz9RtA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Aaj News PK" ;;  
# 202) SAMAA TV Pakistan
202) 
keyword="SAMAA"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/samaatvnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="SAMAA TV Pakistan" ;;    
# 203)Din News PK
203) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCKh7t3sgs671fSeqsXjlN0A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=http://www.dailymotion.com/video/x5ubgo9 
use_cookies="no"
chan_name="Din News PK" ;;  
## 204) Dawn News PAKISTAN
204) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/dawnnewspakistan/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Dawn News" ;;
# 205) BOL PK
205) 
keyword="BOL"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCV6-CUNsfe2-STYfYkd7bBQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="BOL PK" ;; 
# 206) Waqt News PK
206) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/waqtnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Waqt News PK" ;;   
# 207) Geo News PK
207) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/geonews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Geo News PK" ;;   
################# AFGHANISTAN ######################################
# 207) Lemar TV Afghanistan   *** REMOVE on next check
# 207)
# link=http://www.dailymotion.com/video/x5disog 
# use_cookies="no"
#chan_name="Lemar TV Afghanistan" ;; 
# 209)Tolo TV Afghanistan 
# 209)
#link=http://www.dailymotion.com/video/x5dtety 
#use_cookies="no"
#chan_name="Tolo TV Afghanistan" ;; 

## 208) TOLO NEWS AFGHANISTAN
208) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TOLOnewsLive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TOLO NEWS AFGHANISTAN";; 

################################## FARSI / PERSIAN  ###########################################################
# 209)  BBC Persian
209) 
keyword="پخش زنده"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/BBCPersian/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="BBC Persian";;
################## ARABIC  ##########################################
# 210) RT Arabic 
210) 
keyword="RT ARABIC"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/RTarabic/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
quse_cookies="no"
chan_name="RT Arabic" ;;
# 211) ON E Live 
211) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ONtveg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ON E";;
# 212) ON Live
212) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCZghOmDezc6OCMzdPaL-j2Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ON Live" ;;
# 213) Al Jazeera Arabic Qatar
213) 
keyword="Live Stream"
link=http://aljazeera-ara-apple-live.adaptive.level3.net/apple/aljazeera/arabic/800.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/user/aljazeerachannel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Jazeera Arabic" ;; 
# 214) France 24 Arabic
214) 
keyword="الأخبار "
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/france24arabic/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="France 24 Arabic" ;;
# 215) BBC Arabic
215) 
keyword="BBC Arabic Live"
link=http://bbcwshdlive01-lh.akamaihd.net/i/atv_1@61433/master.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/BBCArabicNews/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="BBC Arabic" ;;
# 216) Al Arabiya
216) 
keyword="قناة"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/AlArabiya/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Arabiya" ;;
# 217) Al Mayadeen
217) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Mayadeentv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Al Mayadeen" ;;   
# 218)  Syrian News Channel
218) 
keyword="البث المباشر"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCbgHr_YjqIvfeAJTgtJDMBg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Syrian News Channel Syria" ;; 
# 219) Syrian Nour-Elsham Channel
219) 
keyword="البث المباشر"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC7otUzUQJkr9MsQ-MeAsvGQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Syrian Nour-Elsham Channel Syria" ;;
# 220) PAL TV Palistine
220) 
keyword="PalLive"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHswbrumSJUEgCY5NRrl6Ng/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="PAL TV Palistine" ;; 
# 221) Bedya TV Arabic
221) 
keyword="Bedaya TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tvbedaya/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Bedya TV Arabic" ;;
# 222) Belqees TV Arabic
222)
keyword="قناة بلقيس "
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCxA_zZwALQMmVMSZyLKC-Nw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Belqees TV Arabic" ;;
# 223) DMC Live
223) 
keyword="dmc"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClWxVmz6anf2M58vK_LHZJg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DMC LIVE" ;;
# 224) SKY Arabic
224) 
keyword="البث المباشر"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/skynewsarabia/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SKY Arabic" ;;
# 225)Alghad
225) 
keyword="Alghad"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCaJykDM6rs776xPgzVvLkzg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Ghad" ;; 
# 226) eXtra News Egypt Arabic
226) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC65F33K2cXk9hGDbOQYhTOw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="eXtra News Egypt" ;;    
# 227) CBC Egypt Sofra Arabic
227) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CBCSofraStream/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC Egypt Sofra" ;;
# 228) CBC Egypt Arabic Drama 
228) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CBCDramaStream/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC Egypt Arabic Drama" ;;
# 229)  DW Arabic
229) 
keyword="DW عربية مباشر"
link=http://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/master.m3u8
#link=http://www.metafilegenerator.de/DWelle/tv-arabia/ios/master.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/deutschewellearabic/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="DW Arabic" ;;
# 230) AFAQ TV IRAQ
230) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/afaqiraq/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="AFAQ TV IRAQ" ;; 
# 231) CGTN Arabic
231)
link=https://live.cgtn.com/cctv-a.m3u8
use_cookies="no"
chan_name="CGTN Arabic" ;;
# 232)Alhayah 1
232) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCeP1MABuqrn98hHjDoo3V-g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Alhayah 1" ;;
# 233)Alhayah 2
233) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCFc3vCJ02oy0JglKm8dn8Rg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Alhayah 2" ;;
############################## SAUDI TV   #########################################
# 234) Saudi Channel 1 Green 
234) 
keyword="القناة"
#link=https://www.filmon.com/tv/saudi-arabian-tv-1
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel1/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel1/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel1/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel1/3.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiChannelOne/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="yes"
chan_name="Saudi Channel 1 Green" ;;
# 235) Saudi Channel 3 Blue
235) 
keyword="القناة" 
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel3/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel3/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel3/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel3/3.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiNewsTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Channel 3 Blue" ;;  
# 236) Saudi Sports Channel 4 Red
236) 
keyword="القنوات"
#link=https://www.filmon.com/tv/saudi-arabian-tv-sports
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel4/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel4/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel4/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel4/3.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/AlMalabTube/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Sports Channel 4 Red" ;;
# 237) Saudi Cultural Channel 6 Orange
237) 
keyword="بث مباشر"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiCulturalTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel6/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel6/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel6/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel6/3.m3u8
use_cookies="no"
chan_name="Saudi Cultural Channel 6 Orange" ;;
# 238) Saudi TV Channel 7 Gold  Mecca Kabba
238) 
keyword="Live Stream"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiQuranTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel7/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel7/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel7/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel7/3.m3u8
use_cookies="no"
chan_name="Saudi Channel 7 Gold" ;; 
# 239) Saudi Sliver Educational Channel 8
239) 
keyword="بث مباشر"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiSunnahTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel8/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel8/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel8/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel8/3.m3u8
use_cookies="no"
chan_name="Saudi Silver Channel 8" ;; 
# 240) Saudi Ajyal Kids TV Channel 9
240) 
keyword="بث مباشر"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiAjyalTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel9/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel9/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel9/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel9/3.m3u8
use_cookies="no"
chan_name="Saudi Ajyal Kids Tv Channel 9" ;; 
################### TURKEY  ########################  
## 241) TRT Haber Turkey 
241) 
keyword="TRT"
link=http://trtcanlitv-lh.akamaihd.net/i/TRTHABERHD_1@181942/master.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/trthaber/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TRT Haber Turkey";;
## 242) NTV Turkey
242) 
keyword="NTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ntv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NTV Turkey";;
## 243) HaberTurk TV
243) 
keyword="Habertürk"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TVhaberturk/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="HaberTurk TV";;
# 244) Star TV  Turkish
244) 
keyword="Star"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/STARTVSTAR/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star TV Turkey";;
# 245) CNN Turk 
245) 
keyword="CNN TÜRK CANLI YAYINI"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/cnnturk/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="CNN Turk";;
# 246) KRT Kulture TV
246) 
keyword="KRT"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCVKWwHoLwUMMa80cu_1uapA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="KRT Kulture TV";;
# 247)Number1 TV Canlı Yayın
247)
keyword="4K"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 TV";;
# 248) Number1 Turk TV
248)
keyword="Türk TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 Türk TV";;
# 249) La Legul TV
249) 
keyword="Lâlegül TV Canlı Yayın Akışı"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC4oXxmnXX0EMlDCm18X2szw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="La Legul TV";;
# 250) TGRT Haber TV
250) 
keyword="TGRT Haber TV - Canlı Yayın - Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCzgrZ-CndOoylh2_e72nSBQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TGRT Haber TV";;
# 251) TVNET Canali Yayin
251) 
keyword="TVNET Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tvnethaber/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TVNET Canali Yayin";;
# 252) Show TV Turkey
252) 
keyword="Show"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ShowTVShowTV/videos?flow=grid&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Show TV Turkey" ;;
# 253) Number1 Turk FM
253)
keyword="Türk Slow"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 Turk FM";;
# 254) Number1 Radyo Canlı Yayın 
254)
keyword="Türk Slow"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 FM Radyo Canlı Yayın";;
################### GREEK ######################################
## 255) Star Lamia
255) link=http://www.dailymotion.com/video/xqjey2_star-lamia-live-streaming_news
use_cookies="no"
chan_name="Star Lamia Greek" ;;
# 256) Blue Sky TV Athens Greece
256) 
keyword="BLUE SKY TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/blueskyathens/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Blue Sky TV Athens Greece";;
# 257) Action 24 Greece HD
257) 
link=http://www.dailymotion.com/video/x61fbhs
use_cookies="no"
chan_name="Action 24 Greece HD" ;;
# 258) Sky TV Folk Skopje, Macedonia
258) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCz69ZZjQ_9TnZPCgfVUQjxQ/videos?flow=grid&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Sky TV Folk Skopje, Macedonia MK";;
##########################  Italian  ####################################################### 
# 259) SkyTG 24 Italian
259)
link=http://skyianywhere2-i.akamaihd.net/hls/live/200275/tg24/playlist.m3u8
use_cookies="no"
chan_name="Sky TG 24 Italian" ;;
# 260) Telecolor Lombardia Italy
260)
link=http://telecolor.econcept.it/live/telecolor.isml/manifest\(format=m3u8-aapl\).m3u8
use_cookies="no"
chan_name="Telecolor Lombardia" ;;
# 261) Teletutto Brescia Italy
261)
link="https://livestream.com/accounts/701633/events/4147166"
use_cookies="no"
chan_name="Teletutto Brescia Italy" ;;
# 262) QVC Itallian
262) 
keyword="QVC in diretta"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/qvcitalia/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="QVC Italian" ;; 
################ SWISS
# 263) RSI LA CH
263)
link=http://www.filmon.com/tv/rsi-la-1
use_cookies="yes"
chan_name="RSI LA CH" ;;
# 264) SRF CH
264)
link=http://www.filmon.com/tv/srf-1
use_cookies="yes"
chan_name="SRF CH" ;;
################  Austria
# 265) W24 Wein Austria
265)
link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream3.m3u8
#link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream1.m3u8
#link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream2.m3u8
use_cookies="no"
chan_name="W24 Wein, Austria" ;; 
# 266) Tirol TV Austria
266)
link=http://lb.hd-livestream.de:1935/live/TirolTV/playlist.m3u8
use_cookies="no"
chan_name="Tirol TV Austria" ;;
################  GERMAN   #######################################
# 267) WDR Germany
267)
link=http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/master.m3u8
use_cookies="no"
chan_name="WDR Germany" ;;
# 268)DW Deutsch Welle 
268) 
keyword="DW"
#link="http://dwstream6-lh.akamaihd.net/i/dwstream6_live@123962/master.m3u8"   
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/deutschewelle/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="DW Deutsch Welle";;
# 269) ZDK InfoKanal
269)
link=http://www.filmon.com/tv/zdf-infokanal
use_cookies="yes"
chan_name="ZDK InfoKanal Deutsch";;
# 270)  Tagessschau 24 Germany
270)
link=http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/master.m3u8
use_cookies="no"
chan_name="Tagessschau 24 Germany" ;;
# 271) EuroNews Deutsch
271) 
keyword="LIVE" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewsde/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="EuroNews Deutsch" ;;

# TV OOST BE German
# link=https://urtmpkal-f.akamaihd.net/i/156m2vpg5_1@322941/index_1_av-p.m3u8?sd=10&rebase=on


################## DUTCH
# 272)AT5 NETHERLANDS
272)
link=http://lb-at5-live.cdn.streamgate.nl/at5/video/at5.smil/playlist.m3u8
use_cookies="no"
chan_name="AT5 TV NETHERLANDS" ;;

## RTV OSST NL
## link=https://ngx.cr2.streamzilla.xlcdn.com/session/e718af643ae8eef6c9f79f411cc9feb1/sz/rtv_oost/wowza4/live/tvoost.smil/chunklist_b2560000.m3u8

################# Moldova
# 273) TV Publica Moldova
273)
link=http://livebeta.publika.md/LIVE/P/6810.m3u8
use_cookies="no"
chan_name="TV Publica Moldova" ;;
############# 
######################### UKRAINE  ##################################
# 274) UA TV Ukraine 
274) 
keyword="UATV"
link=https://ua-tv-hls3.cosmonova.net.ua/hls/ua-tv_ua_mid/index.m3u8
use_cookies="no"
chan_name="UA TV Ukraine" ;;
# 275) Thromadske Ukraine
275) 
keyword="#Громадське (Наживо)"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/HromadskeTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Thromadske Ukraine" ;;
# 276) Еспресо Ukraine
276) 
keyword="Еспресо.TV - LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/espresotv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ecnpeco Ukraine" ;;
# 277) News 1 Ukraine
277) 
keyword="эфир NewsOne"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC9oI0Du20oMOlzsLDTQGfug/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="News 1 Ukraine" ;;
# 278) Ukraine 112
278)
keyword="канала"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCu-YOzNvZpU6KRoSrgsru2Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ukraine 112" ;;
# 279) Ukraine Channel 5 
279) 
keyword="5.ua"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/5channel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ukraine 5" ;;
# 280) UA TV Ukraine Tartar
# 280) 
# keyword="UATV"
# link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC-ni_mzd-eCHgkIMY2jOEoA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
# use_cookies="no"
# chan_name="UA TV Qirimatarca Ukraine" ;;
############### RUSSIAN ################################
# 280)  Euronews Russian
280)
link=http://evronovosti.mediacdn.ru/sr1/evronovosti/playlist.m3u8
#link=http://evronovosti.mediacdn.ru/sr1/evronovosti/chunklist_b2658304.m3u8
use_cookies="no"
chan_name="Euronews Russian" ;;
################################ MENU 2 ########################################################
# 281) Россия 24
281) 
keyword="24"
link=http://live.russia.tv/index/index/channel_id/3
#link=http://www.filmon.com/tv/rossiya-24
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Russia24TV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="POCCNR 24 Russia" ;;
# 282) RBC TV RUSSIA
282)
link=http://online.video.rbc.ru/online/rbctv_480p/index.m3u8
use_cookies="no"
chan_name="RBC TV Russia" ;;
# 283) CGTN Russian
283)
link=https://live.cgtn.com/cctv-r.m3u8
use_cookies="no"
chan_name="CGTN Russian" ;;
# 284) Vesti FM Russia
284) 
keyword="Вести ФМ"
link=http://live.russia.tv/index/index/channel_id/199
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vestifm/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Vesti FM Russia" ;;
# 285)  Current Time VOA
285)
keyword="НАСТОЯЩЕЕ ВРЕМЯ"
link=http://www.filmon.com/tv/current-time-tv
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/currenttimetv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="yes"
chan_name="Current Time VOA" ;;
# 286) RTR Planeta
286)
#link=http://live.russia.tv/index/index/channel_id/82
link=http://www.filmon.com/tv/rtr-planeta
use_cookies="yes"
chan_name="RTR Planeta" ;;
# 287) Perviy Kanal Europa
287)
link=http://www.filmon.com/tv/perviy-kanal-europa
use_cookies="yes"
chan_name="Perviy Kanal Europa" ;;
# 288) Music Box Russia
288)
link=http://www.filmon.com/tv/music-box-russia
use_cookies="yes"
chan_name="Music Box Russia" ;;
# 289) MOSCKVA 24 RU
289)
link=http://live.russia.tv/index/index/channel_id/76
#link=http://www.ontvtime.ru/live/moskva24.html
use_cookies="no"
chan_name="MOSCKVA 24 RU" ;; 
# 290) 1TV HD RU
290)
link=https://edge1.1internet.tv/dash-live11/streams/1tv/1tvdash.mpd?e=1520910459
use_cookies="no"
chan_name="1TV HD RU" ;; 
# 291) POCCNR 1 HD RU
291)
link=http://live.russia.tv/index/index/channel_id/86
#link=http://live.russia.tv/index/index/channel_id/1
use_cookies="no"
chan_name="POCCNR 1 HD RU" ;; 
# 292) Planeta Channel 4 Russia
292)
link=http://wse.planeta-online.tv:1935/live/channel_4/chunklist.m3u8
use_cookies="no"
chan_name="Planeta Channel 4 Russia" ;;
# 293) Planeta Channel 6 Russia
293)
link=http://wse.planeta-online.tv:1935/live/channel_6/chunklist.m3u8
use_cookies="no"
chan_name="Planeta Channel 6 Russia" ;;
# 294) ТВ-ТРЕЙЛЕР Russia
294)
link=http://wse.planeta-online.tv:1935/live/channel_5/chunklist.m3u8
use_cookies="no"
chan_name="ТВ-ТРЕЙЛЕР 2 Russia" ;;
# 295) 5 RU
295)
keyword="Пятого канала"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCGM8ZTtduKll7X8RiGe6N8g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=http://www.ontvtime.ru/general/channel5.html
use_cookies="no"
chan_name="5 Live RU" ;;

############# Broken
# 298) NTV RU
298)
link=www.ntv.ru
use_cookies="no"
chan_name="NTV RU" ;;
# 299)  TNT RU  
299)
link=http://www.ontvtime.ru/general/tnt.html
use_cookies="no"
chan_name="TNT RU" ;;
# 300)  POCCNR K RU
300)m
link=http://www.ontvtime.ru/live/russiak-2.html
use_cookies="no"
chan_name="POCCNR K RU" ;;
# 301)  REN TV RU
301)
link=http://www.ontvtime.ru/general/rentv.html
use_cookies="no"
chan_name="REN TV RU" ;;
# 302)  Domanshiniy RU
302)
link=http://www.ontvtime.ru/general/domashniy.html
use_cookies="no"
chan_name="Domanshiniy RU" ;;
# 303)  TV3 RU
303)
link=http://www.ontvtime.ru/general/tv3.html
use_cookies="no"
chan_name="TV3 RU" ;;
# 304)  TVC RU
304)
link=http://www.ontvtime.ru/general/tvc.html
use_cookies="no"
chan_name="TVC RU" ;;
# 305)  OTR RU
305)
link=http://www.ontvtime.ru/live/otr.html
use_cookies="no"
chan_name="OTR RU" ;;
# 306)  Karusel RU
306)
link=http://www.ontvtime.ru/live/karusel-2.html
use_cookies="no"
chan_name="Karusel RU" ;;
# 307) Zvezda RU
307)
link=http://www.ontvtime.ru/live/zvezda.html
use_cookies="no"
chan_name="Zvezda RU" ;;
# 308) Muztv RU
308)
link=http://www.ontvtime.ru/live/muztv.html
use_cookies="no"
chan_name="Muztv RU" ;;
# 309) MIR RU
309)
link=http://www.ontvtime.ru/live/mir.html
use_cookies="no"
chan_name="MIR RU" ;;
# 310) ORT 3 RU
310)
link=http://www.ontvtime.ru/general/ort-3.html
use_cookies="no"
chan_name="ORT 3 RU" ;;

# 311)
# http://tv.life.ru/lifetv/720p/index.m3u8

############### Viet Nam  #####################################
# 312) VietTV VN
312)
link=http://www.filmon.com/tv/vtc-10
use_cookies="yes"
chan_name="VietTV VN" ;;
################# TAGALOG FILIPINO #############################       
# 313) DZMM ABS-CBN Philippeans Radio
313) 
keyword="DZMM Audio Streaming"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCs_VNu-FQ0WcJnD4QkmIL5w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DZMM Philippeans" ;;
# 314) DZRH Philippeans
314) 
keyword="DZRH"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCcTiBX8js_djhSSlmJRI99A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DZRH Philippeans" ;;
# 315) PTV Philippines
315)
keyword="PTV Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/PTVPhilippines/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="PTV Philippines";;
################ Indonesia  #########################################
# 316) Net TV Jakarta Indonesia
316) 
keyword="Net" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/user/NetTVInsight/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="yes"
chan_name="Net TV Jakarta Indonesia" ;;
###################   AFRICA    ##############################################
# 321) Channels 24 Nigeria
321) 
keyword="Channels Television"
#link=http://31.24.231.140/mchannels/channelstv.m3u8
#link=http://31.24.228.207:1935/live/smil:channelstv.smil/playlist.m3u8
#link=http://31.24.228.207:1935/live/mobile_240p/playlist.m3u8
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/channelsweb/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"    
use_cookies="no"
chan_name="Channels 24 Nigeria";;
# 322)TVC News Nigeria
322) 
keyword="TVC News Nigeria"
#link=http://77.92.76.135:1935/tvcnews/livestream/playlist.m3u8
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCgp4A6I8LCWrhUzn-5SbKvA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TVC News Nigeria";;
# 323) TVC Continental Nigeria
323) 
keyword="TVC Continental Nigeria"
link=http://77.92.76.135:1935/tvce/livestream/playlist.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCgp4A6I8LCWrhUzn-5SbKvA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TVC Continental Nigeria";;
# 324) NTV Uganda
324) 
keyword="NTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ntvuganda/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NTV Uganda" ;; 
# 325)  KTN Kenya
325) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/standardgroupkenya/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KTN Kenya" ;; 
# 326) Joy News Ghana
326) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/myjoyonlinetube/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Joy News Ghana";;
# 327)  ADOM TV 
327) 
keyword="Adom"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/adomtvtube/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ADOM TV Ghana" ;;    
# 328) Bukedde TV
328) 
keyword="Bukedde"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/bukeddetv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Bukedde TV";;
# 329)Telefishinka Qaranka Somalia
329) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCi5fZhV7tPitSjnhEHJirGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Telefishinka Qaranka Somalia";;
# 330) EBC Ethiopia 
330) 
keyword="live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCOhrz3uRCOHmK6ueUstw7_Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="EBC Ethiopia";;
# 331) SPARK TV Uganda
331) 
keyword="TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ntvuganda/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SPARK TV Uganda" ;;  
# 332) Biafra TV Africa 
332) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG1mxHbW_qvMfrNLj3D2ffA/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Biafra TV";;
# 333) Walf TV Senegal
333)  
link=http://www.dailymotion.com/video/x5s5vw3
use_cookies="no"
chan_name="Walf TV Senegal" ;; 
# 334) EriTV Eritrea
334)
link=http://www.filmon.com/tv/eri-tv
use_cookies="yes"
chan_name="EriTV Eritrea" ;;  
# 335) EbruTV Kenya  
335)
link=http://www.dailymotion.com/video/x67n3k1
use_cookies="no"
#format=hls-720
#format=hls-480
#format=hls-380
format=hls-240
chan_name="EbruTV Kenya" ;;
# 336)KTN Home Kenya
336)
link=http://www.dailymotion.com/video/x67ck0p
use_cookies="no"
format=hls-1080
#format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="KTN Home Kenya" ;;
# 337)SABC Digital News South Africa
337) 
keyword="Newsroom"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/sabcdigitalnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SABC News South Africa" ;;  
# 338) Africa News Live
338)
keyword="africanews Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC1_E8NeF5QHY2dtdLRBCCLA/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Africa News English";;
# 339)ANN7 South Africa
339) 
keyword="ANN7 TV Live Stream"
#link="http://196.33.130.34:1935/live-ann7/ann7.smil/playlist.m3u8"
#link=rtmp://196.33.130.34/live-ann7/ann7-mid.stream
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=550000,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=640x360
#link=http://196.33.130.34:1935/live-ann7/ann7.smil/chunklist-b550000.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=250000,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=480x270
#link=http://196.33.130.34:1935/live-ann7/ann7.smil/chunklist-b250000.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1300000,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=1280x720
#link=http://196.33.130.34:1935/live-ann7/ann7.smil/chunklist-b1300000.m3u8
#link=http://46.4.25.213:1935/live-ann7/ann7.smil/playlist.m3u8
#link=rtmp://46.4.25.213/live-ann7/ann7-mid.stream
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6gciFMFztxlRrO5f4K1xbQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ANN7 News South Africa" ;; 
# 340) Africa24
340) 
keyword="Africa24 Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Africa24/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no" 
chan_name="Africa24" ;; 
# 341) SIKKA TV Afrique
341) 
keyword="en Direct "
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCplwKOWLV8s2XZBMsimOjvg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SIKKA TV Afrique" ;; 


##################################### LOCAL NEWS USA #################################################################### 
# 361) RSBN Auburn Alabama USA
361) 
keyword="RSBN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/rightsideradio/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="RSBN Right Side Broadcasting Auburn Alabama USA" ;;    
############################ LOCAL NEWS USA#############################################
# 362) News 12 Brooklyn @
362) 
link=http://hls.iptv.optimum.net/news12/nipadlive/index_new.m3u8?callsign=N12KN
use_cookies="no"
chan_name="News 12 Brooklyn" ;;
# 363) News 12 Long Island @
363) 
link=http://hls.iptv.optimum.net/news12/nipadlive/index_new.m3u8?callsign=N12LI_WEST
use_cookies="no"
chan_name="News 12 Long Island" ;;
# 364) WGN 9 Chicago   @
364) 
link=http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/master.m3u8
use_cookies="no"
chan_name="WGN 9 Chicago" ;;
# 365) ABC News 9 Orlando 
365) 
link=http://cmghlslive-i.akamaihd.net/hls/live/224711/WFTV/master.m3u8
use_cookies="no"
chan_name="ABC News 9 Orlando" ;;
# 366) Fox News 10 Phoenix Arizona USA **** REMOVE
366) 
keyword="\:"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCJg9wBPyKMNA5sRDnvzmkdg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fox News 10 Phoenix Arizona USA";; 
# 367) FOX 2 News KTVU  Bay Area
367) 
link=http://play-prod1.live.anvato.net/server/play/ktvutestctg/master.m3u8
use_cookies="no"
chan_name="Fox 2 News KTVU Bay Area" ;;
# 368) ATXN Austin Texas
368) 
link=http://oflash.dfw.swagit.com/livecc02/austintx/smil:atx-16x9-1-b/chunklist_w1826702480_b878000.m3u8
use_cookies="no"
chan_name="ATXN Austin Texas" ;;
# 369) Seminole TV Florida
369) 
link=http://video.seminolecountyfl.gov:1935/live/SGTV/chunklist.m3u8
use_cookies="no"
chan_name="Seminole TV (Florida)" ;;
# 370)The Florida Channel
370) 
#link=rtmp://webcasting.thefloridachannel.org/live/tvweb1
link=http://webcasting.thefloridachannel.org/live/tvweb1/playlist.m3u8
use_cookies="no"
chan_name="The Florida Channel" ;;
#################### NATIONAL / LOCAL Weather #####################################################
# 371) Weather Nation
371) 
link=http://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/a.m3u8
use_cookies="no"
chan_name="Weather Nation" ;; 
# 372) The Weather Channel
372)
link=http://weather-lh.akamaihd.net/i/twc_1@92006/master.m3u8
use_cookies="no"
chan_name="The Weather Channel" ;;
############################  TRANSIENT BROADCAST NEWS #############################################
# 373) CBS 2 News New York
373) 
link=http://play-prod1.live.anvato.net/server/play/cbslocal-wcbsx-dfp/master.m3u8
use_cookies="no"
chan_name="CBS 2 News New York" ;;
# 374) CBS 4 News Boston
374) 
link=http://cbslocaltv-i.akamaihd.net/hls/live/221461/WBZTV/master.m3u8
#link=http://54.163.107.81/server/play/cbslocal-wbzx-dfp/master.m3u8
use_cookies="no"
chan_name="CBS 4 News, WBZ, Boston, Massachusetts" ;;
# 375) WVIT 30 News Hartford
375) 
link=http://wvitlive-f.akamaihd.net/i/wvitb2_1@71164/master.m3u8
use_cookies="no"
chan_name="WVIT 30 News Hartford" ;;
# 376) NBC 10 News (Philadelphia)
376) 
link=http://wcaulive-f.akamaihd.net/i/wcaua1_1@13991/master.m3u8
use_cookies="no"
chan_name="NBC 10 News Philadelphia" ;;
# 377) CBS 3 News Michigan 
377) 
link=http://wjmn-apple-live.hls.adaptive.level3.net/stream0/master.m3u8
use_cookies="no"
chan_name="CBS 3 News Michigan" ;;
# 378) CBS 2 Salt Lake City
378) 
link=http://ktvx-apple-live.hls.adaptive.level3.net/stream0/master.m3u8
use_cookies="no"
chan_name="CBS 2 Salt Lake City" ;;
# 379) CBS 5 News Colorado/ FOX 4 Kansas 
379) 
link=http://krex-apple-live.hls.adaptive.level3.net/stream0/master.m3u8
use_cookies="no"
chan_name="CBS 5 Colorado" ;;
# 380) NBC 11 Bay Area
380) 
link=http://kntvlive-f.akamaihd.net/i/kntvb2_1@15530/index_1286_av-p.m3u8
use_cookies="no"
chan_name="NBC 11 Bay Area" ;;
# 381) CBS 13 News Stockton California USA
381) 
link=http://play-prod1.live.anvato.net/server/play/cbslocal-kovrx-dfp/master.m3u8
use_cookies="no"
chan_name="CBS 13 News Stockton California USA" ;;
# 382) KCAL 9 News Los Angeles
382) 
link=http://play-prod1.live.anvato.net/server/play/cbslocal-kcal-dfp/master.m3u8
use_cookies="no"
chan_name="KCAL 9 News Los Angeles" ;;
# 383) WXXV25 24/7 Mississippi
383)
link=http://api.new.livestream.com/accounts/22998687/events/6864865/live.m3u8
use_cookies="no"
chan_name="WXXV25 24/7 Mississippi" ;; 
# 384) NBC News Channel 13 (WNYT-TV)
384)
link=http://api.new.livestream.com/accounts/12240447/events/3818578/live.m3u8
use_cookies="no"
chan_name="NBC News Channel 13 WNYT-TV";;
# 385) NBC2 South West Florida
385)  
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NBC2swfl/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="NBC2 South West Florida" ;;  
# 386) WCCB Charlotte, South Carolina
386)
link=http://api.new.livestream.com/accounts/8522553/events/live/live.m3u8
use_cookies="no"
chan_name="WCCB Charlotte, South Carolina" ;;
# 387)7 News (WHDH-TV) Boston
387)
link=http://bcoveliveios-i.akamaihd.net/hls/live/246496/4744899807001/livestream/master.m3u8
use_cookies="no"
chan_name="7 News (WHDH-TV) Boston" ;; 

# 388)ABC News USA  1
388)
link="https://abclive1-lh.akamaihd.net/i/abc_live01@423395/index_4000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 1" ;;
# 389)ABC News USA 2
389)
link="https://abclive1-lh.akamaihd.net/i/abc_live02@423396/index_4000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 2" ;;
# 390)ABC News USA 3
390)
link="https://abclive1-lh.akamaihd.net/i/abc_live03@423397/index_4000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 3" ;;
# 391)ABC News USA 4
391)
link="https://abclive1-lh.akamaihd.net/i/abc_live04@423398/index_4000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 4" ;;
# 392)ABC News USA 5
392)
link="https://abclive1-lh.akamaihd.net/i/abc_live05@423399/index_2500_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 5" ;;
# 393)ABC News USA 6
393)
link="https://abclive1-lh.akamaihd.net/i/abc_live06@423400/index_2500_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 6" ;;
# 394)ABC News USA 7
394)
link="https://abclive1-lh.akamaihd.net/i/abc_live07@423401/index_4000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 7" ;;
# 395)ABC News USA 8
395)
link="https://abclive1-lh.akamaihd.net/i/abc_live08@423402/index_1200_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 8" ;;
# 396)ABC News USA 9
396)
link="https://abclive1-lh.akamaihd.net/i/abc_live09@423403/index_1200_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 9" ;;
# 397)ABC News USA 10
397)
link="https://abclive1-lh.akamaihd.net/i/abc_live10@420897/index_4000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 10" ;;

# 398)KY3 Springfield IL USA
398)
link=https://livestream.com/accounts/4699618/live
use_cookies="no"
chan_name="KY3 Springfield IL USA" ;;



# 399) KNBC 4 News (Los Angeles)
399) 
link=http://knbclive-f.akamaihd.net/i/knbca1_1@13988/index_1286_av-p.m3u8
use_cookies="no"
chan_name="KNBC 4 News Los Angeles" ;;
# 400)


#### ABC LIVE STREAMS
#link="https://abclive1-lh.akamaihd.net/i/abc_live01@423395/index_4000_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive1-lh.akamaihd.net/i/abc_live02@423396/index_4000_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive1-lh.akamaihd.net/i/abc_live03@423397/index_4000_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive1-lh.akamaihd.net/i/abc_live04@423398/index_4000_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive1-lh.akamaihd.net/i/abc_live04@423398/index_2500_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive1-lh.akamaihd.net/i/abc_live05@423399/index_2500_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive1-lh.akamaihd.net/i/abc_live06@423400/index_2500_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive1-lh.akamaihd.net/i/abc_live07@423401/index_4000_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive1-lh.akamaihd.net/i/abc_live08@423402/index_1200_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive1-lh.akamaihd.net/i/abc_live09@423403/index_1200_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive1-lh.akamaihd.net/i/abc_live10@420897/index_4000_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive2-lh.akamaihd.net/i/abc_live11@423404/index_1200_av-p.m3u8?sd=10&rebase=on"
#https://abclive1-lh.akamaihd.net/i/abc_live10@420897/master.m3u8
#EXTINF:0, tvg-logo="" group-title="",ABC News Digital 2
#https://abclive1-lh.akamaihd.net/i/abc_live02@423396/master.m3u8
#EXTINF:0, tvg-logo="" group-title="",ABC News Digital 3
#https://abclive1-lh.akamaihd.net/i/abc_live03@423397/master.m3u8
#EXTINF:0, tvg-logo="" group-title="",ABC News Digital 4
#https://abclive1-lh.akamaihd.net/i/abc_live04@423398/master.m3u8
#EXTINF:0, tvg-logo="" group-title="",ABC News Digital 5
#https://abclive1-lh.akamaihd.net/i/abc_live05@423399/master.m3u8
#EXTINF:0, tvg-logo="" group-title="",ABC News Digital 6
#https://abclive1-lh.akamaihd.net/i/abc_live06@423400/master.m3u8
#EXTINF:0, tvg-logo="" group-title="",ABC News Digital 7
#https://abclive1-lh.akamaihd.net/i/abc_live07@423401/master.m3u8
#EXTINF:0, tvg-logo="" group-title="",ABC News Digital 8
#https://abclive1-lh.akamaihd.net/i/abc_live08@423402/master.m3u8
#EXTINF:0, tvg-logo="" group-title="",ABC News Digital 9
#https://abclive1-lh.akamaihd.net/i/abc_live09@420891/master.m3u8
#EXTINF:0, tvg-logo="" group-title="",ABC News Digital 11
#https://abclive2-lh.akamaihd.net/i/abc_live11@423404/master.m3u8
####PREVIEW STREAMS
#link="https://abclive1-lh.akamaihd.net/i/abc_preview02@425077/master.m3u8"
#link="https://abclive1-lh.akamaihd.net/i/abc_preview06@425081/index_100_av-p.m3u8?sd=10&rebase"
#link="https://abclive1-lh.akamaihd.net/i/abc_preview09@425084/index_100_av-p.m3u8?sd=10&rebase=on"

################# EXTRA ###################################
# 401) WSJ Live
401)
link=http://wsjlivehls-lh.akamaihd.net/i/events1_1@174990/master.m3u8
use_cookies="no"
chan_name="WSJ Live" ;;
# 402) CNN Livestream 1
402)
link=http://cnn-i.akamaihd.net/hls/live/253953/dotcomlive_1/index_Layer8.m3u8
#link=http://cnn-i.akamaihd.net/hls/live/253953/dotcomlive_1/master.m3u8
use_cookies="no"
chan_name="CNN Livestream 1" ;;
# 403) CNN Livestream 2
403)
link=http://cnn-i.akamaihd.net/hls/live/253954/dotcomlive_2/index_Layer8.m3u8
#link=http://cnn-i.akamaihd.net/hls/live/253954/dotcomlive_2/master.m3u8
use_cookies="no"
chan_name="CNN Livestream 2" ;;
# 404) CPAC 2 Canada
404)
link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5028033728001
use_cookies="no"
chan_name="CPAC 2 Canada" ;;
##################### CNN ##########################
# 405) CNN America  
405)
#rnum=$( expr 1 + $RANDOM % 5 | awk '{print $1}' )
keyword="Live"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/results?search_query=CNN" | grep "watch?v=" |  grep "$keyword" | head -n "$rnum" | tail -n 1 | cut -d \= -f 5 | cut -d \" -f 1)" 
link=http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/master.m3u8
use_cookies="no"
chan_name="CNN Live" ;;  

# 406) CNN America  
406)
#rnum=$( expr 1 + $RANDOM % 5 | awk '{print $1}' )
keyword="Live"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/results?search_query=CNN" | grep "watch?v=" |  grep "$keyword" | head -n "$rnum" | tail -n 1 | cut -d \= -f 5 | cut -d \" -f 1)" 
link=http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/master.m3u8
use_cookies="no"
chan_name="CNN Live" ;;  
# 407) DVIDs TV
407) link=https://www.filmon.com/tv/dvids-tv
use_cookies="yes"
chan_name="DVIDs TV" ;;  
# 408)What America Thinks
408) link=https://www.filmon.com/tv/what-america-thinks
use_cookies="yes"
chan_name="What America Thinks" ;;  
# 409) NASA TV Public Education
409) 
keyword="NASA TV Public-Education"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NASA TV Education" ;; 
# 410) NASA TV Media
410) 
keyword="Media"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NASA TV Media" ;; 
# 411) C-SPAN 2 HD
411)
link="http://cspan2-lh.akamaihd.net/i/cspan2_1@304728/index_1000_av-p.m3u8?sd=10&rebase=on"
#link=http://cspan2nontve-lh.akamaihd.net/i/CSpan2NonTVE_1@312669/master.m3u8
use_cookies="no"
chan_name="C-SPAN 2 HD" ;;
# 412) C-SPAN 3 HD
412)
link="http://cspan3-lh.akamaihd.net/i/cspan3_1@304729/index_1000_av-p.m3u8?sd=10&rebase=on"
#link=http://cspan3nontve-lh.akamaihd.net/i/CSpan3NonTVE_1@312670/master.m3u8
use_cookies="no"
chan_name="C-SPAN 3 HD" ;;

# 413) Bloomberg Europe
413)
#link=https://www.bloomberg.com/live/europe
link=https://liveprodeuwest.global.ssl.fastly.net/btv/desktop/eu_live.m3u8
#link=https://cdn-videos.akamaized.net/btv/zixi/fastly/europe/live/master.m3u8
#link=http://mediaeuwest.akamaized.net/eu/EU1000kb_live.m3u8
use_cookies="no"
chan_name="Bloomberg Europe" ;;
# 414) Bloomberg Asia
414)
#link=https://www.bloomberg.com/live/asia
link=https://liveprodapnortheast.global.ssl.fastly.net/btv/desktop/ap_live.m3u8
use_cookies="no"
chan_name="Bloomberg Asia" ;;

# 415)

# 416) BYUTV International
416)
link=https://byubhls-i.akamaihd.net/hls/live/267282/byutvintport/master.m3u8
use_cookies="no"
chan_name="BYUTV International" ;;
#  417) Arirang Radio English 
417) 
keyword="Arirang"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Music180Arirang/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Arirang Radio English" ;;
# 418) HSN
418) 
keyword="Live Stream"
#link=http://hsn.mpl.miisolutions.net/hsn-live01/_definst_/smil:HSN1_ipad.smil/playlist.m3u8
#link=http://hsn.mpl.miisolutions.net:1935/hsn-live01/_definst_/mp4:468p500kB31/playlist.m3u8
link=https://www.youtube.com"$(curl "https://www.youtube.com/user/hsntv/videos?&view=2" | grep "$keyword" | awk ' BEGIN { RS= ":"}{ print}' | grep "watch?v=" | head -n 1 | cut -d \" -f 2)" 
use_cookies="no"
chan_name="Home Shopping Network HSN" ;;
# 419) HSN 2
419) 
keyword="HSN2"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCtliQPtWcZSgYkYS70vRrzg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="HSN2" ;;
# 420)  QVC 
420) 
keyword="QVC Live Stream"
link=http://qvclvp2.mmdlive.lldns.net/qvclvp2/9aa645c89c5447a8937537011e8f8d0d/manifest.m3u8
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/QVC/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="QVC English" ;;
# 421) The Shopping Channel TSC
421)
link=http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_3_av-p.m3u8
use_cookies="no"
chan_name="The Shopping Channel TSC" ;;
# 422)  CTV NEWS Canada
422)
#CTV NEWS HD
link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News18.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News17.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News16.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News15.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News15.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News14.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News13.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News12.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News11.m3u8
use_cookies="no"
chan_name="CTV News Canada" ;; 
# 423) CPAC 3 Senate Canada
423)
link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5028075832001
use_cookies="no"
chan_name="CPAC 2 Senate Canada" ;;
#################### TRANSIENT ######################################## 
# 424) RUPTLY
424) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/RuptlyTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="RUPTLY" ;;  
# 425) Made in Leeds
425)
link=http://www.dailymotion.com/video/x5eva58
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="Made in Leeds" ;;
# 426) Made in Tyne
426)
link=http://www.dailymotion.com/video/x5eva8m
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="Made in Tyne" ;;
# 427) Made in Cardiff
427)
link=http://www.dailymotion.com/video/x5ev9xg
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="Made in Cardiff" ;;
# 428) Saudi 2 TV
428)
keyword="Saudi 2"
link=https://www.filmon.com/tv/saudi-arabian-tv-2
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel2/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel2/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel2/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel2/3.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiChannel2/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="yes"
chan_name="Saudi 2 English" ;;   
# 429) Bloomberg Australia
429)
link=https://liveprodapnortheast.global.ssl.fastly.net/btv/desktop/aus_live.m3u8
use_cookies="no"
chan_name="Bloomberg Australia" ;;
# 430) Bloomberg US Politics
430)
link=https://liveproduseast.global.ssl.fastly.net/btv/desktop/us_politics.m3u8
use_cookies="no"
chan_name="Bloomberg US Politics" ;;
# 431) Bloomberg Live Event
431)
link=https://liveproduseast.global.ssl.fastly.net/btv/desktop/us_event.m3u8
use_cookies="no"
chan_name="Bloomberg US Live Event" ;;
# 432) Bloomberg EU Live Event
432)
link=https://liveprodeuwest.global.ssl.fastly.net/btv/desktop/eu_event.m3u8
use_cookies="no"
chan_name="Bloomberg EU Live Event" ;;
# 433) Bloomberg Asia Live Event
433)
link=https://liveprodapnortheast.global.ssl.fastly.net/btv/desktop/ap_event.m3u8
use_cookies="no"
chan_name="Bloomberg Asia Live Event" ;;
# 434)Juptier Broadcasting USA
434) link=http://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream/playlist.m3u8		
# link=rtmp://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream
# link=rtsp://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream
use_cookies="no"
chan_name="Jupiter Broadcasting USA" ;;
# 435) Weather Network Canada
435) 
link="https://players.brightcove.net/1942203455001/SkHslaO1M_default/index.html?videoId=5536901934001"
use_cookies="no"
chan_name="Weather Network CA";;


######################## PODCAST ###########################################
# 437) PBS NewsHour Video
437) 
keyword="PBS NewsHour"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/PBSNewsHour/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="PBS NewsHour Video" ;;   
# 438)  CBC The National
438) 
keyword="The National"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CBCTheNational/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 2 | tail -n 1| cut -d = -f 12 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC The National" ;; 
# 439) AP Top Stories
439) 
keyword="Top"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/AssociatedPress/videos" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="AP Top Stories" ;;    
# 440) Democracy Now Headlines 
440) 
keyword="Headlines"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/democracynow/videos" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Democracy Now Headlines" ;;   

###############################   SPORTS   ######################################################
# 441) MLB Network
441)
link=http://mlblive-akc.mlb.com/ls01/mlbam/mlb_network/NETWORK_LINEAR_1/master_wired.m3u8
use_cookies="no"
chan_name="MLB Network" ;;
# 442) 106.7 The Fan
442)
link=http://cbslocalhls-i.akamaihd.net/hls/live/204776/WJFK-FM-IOS/wjfklive.m3u8
use_cookies="no"
chan_name="106.7 The Fan" ;;
# 443) 105.7 The Fan
443)
link=http://cbslocalhls-i.akamaihd.net/hls/live/219778/WJZFM-IOS/wjzfmlive.m3u8
use_cookies="no"
chan_name="105.7 The Fan" ;;
################### Entertainment #############################
# 444) Heart TV
444)
link=http://ooyalahd2-f.akamaihd.net/i/globalradio02_delivery@156522/master.m3u8
use_cookies="no"
chan_name="Heart TV" ;;
# 445) Capital TV
445)
link=http://ooyalahd2-f.akamaihd.net/i/globalradio01_delivery@156521/master.m3u8
use_cookies="no"
chan_name="Capital TV" ;;
# 446) California Music Channel
446)
link=http://cmctv.ios.internapcdn.net/cmctv_vitalstream_com/live_1/CMCUSA/CCURstream0.m3u8
use_cookies="no"
chan_name="California Music Channel" ;;
# 447) Music Choice Play HD
447)
link=http://edge.music-choice-play-chaina1.top.comcast.net/PlayMetadataInserter/play/playlist.m3u8
#link=http://edge.music-choice-play-chaina1.top.comcast.net/PlayMetadataInserter/play/chunklist.m3u8
use_cookies="no"
chan_name="Music Choice Play HD" ;;
# 448)538 TV NETHERLANDS
448)
link=http://538hls.lswcdn.triple-it.nl/content/538tv/538tv_1.m3u8
use_cookies="no"
chan_name="538 TV NETHERLANDS" ;;
# 449) О2 ТВ Russia
449)
link=http://hls.mycdn0633430096.cdnvideo.ru/mycdn0633430096/stream1_sd.sdp/playlist.m3u8
use_cookies="no"
chan_name="O!2 TB Russia" ;;
# 450) MTV AM Russia
450) 
#link=http://mtvam.ru/hlsam/playlist.m3u8
#BANDWIDTH=350000
#link=http://91.232.135.156/hlsam/low/playlist.m3u8
#BANDWIDTH=650000
link=http://91.232.135.156/hlsam/med/playlist.m3u8
#BANDWIDTH=950000
#link=http://91.232.135.156/hlsam/high/playlist.m3u8
#BANDWIDTH=1800000
#link=http://91.232.135.156/hlsam/lhigh/playlist.m3u8
#BANDWIDTH=3800000
#link=http://91.232.135.156/hlsam/hd/playlist.m3u8
use_cookies="no"
chan_name="MTV AM Russia" ;; 
# 451) DJING Animation HD 
451) 
link=http://www.djing.com/tv/a-05.m3u8
use_cookies="no"
chan_name="DJING Animation HD" ;;
# 452) DJING Classic HD 
452) 
link=http://www.djing.com/tv/i-05.m3u8
use_cookies="no"
chan_name="DJING Classic HD" ;;
# 453) DJING Dancefloor HD
453) 
link=http://www.djing.com/tv/d-05.m3u8
use_cookies="no"
chan_name="DJING Dancefloor HD" ;;
# 454)DJING Underground HD
454) 
link=http://www.djing.com/tv/u-05.m3u8
use_cookies="no"
chan_name="DJING Underground HD" ;;
# 455)M2O Music
455) 
link="http://m2otv-lh.akamaihd.net/i/m2oTv_1@186074/index_600_av-b.m3u8"
use_cookies="no"
chan_name="M2O Music" ;;
# 456) Virgin 1
456)
#link=http://wow01.105.net/live/virgin1/chunklist.m3u8   
link=http://wow01.105.net/live/virgin1/playlist.m3u8  
use_cookies="no"
chan_name="Virgin 1" ;;
# 457) Virgin Music 2
457)
link=rtmp://fms.105.net:1935/live/virgin2
use_cookies="no"
chan_name="Virgin Music 2" ;;
# 458) Clubbing TV
458) 
link=http://stream01.yamgo.com/iPhone/HLS_TS/mptslive/clubbingtv-mobile.3gp.m3u8  
use_cookies="no"
chan_name="Clubbing TV" ;;  
# 459) Radio Monte Carlo RMC
459)
link=rtmp://fms.105.net:1935/live/rmc1
use_cookies="no"
chan_name="Radio Monte Carlo" ;; 
# 460) KPOP IDOL
460) 
keyword="KPOP" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/user/imbcevery1/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KPOP IDOL" ;;
#################### REALITY / LIVE ACTION #########################
#  461) Adult Swim 
461) 
link=http://adultswimhls-i.akamaihd.net/hls/live/238460/adultswim/main/1/master.m3u8
use_cookies="no"
chan_name="Adult Swim" ;;
# 462) Insight TV
462)
link=http://ooyalahd2-f.akamaihd.net/i/intv02_delivery@346464/master.m3u8
use_cookies="no"
chan_name="Insight TV" ;;
# 463) Yes TV
463)
link=http://hlslive.lcdn.une.net.co/v1/AUTH_HLSLIVE/YES/tu1_1.m3u8
use_cookies="no"
chan_name="Yes TV" ;;
# 464) Smile of a Child
464)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN04_delivery@186242/index_1164_av-b.m3u8
use_cookies="no"
chan_name="Smile of a Child" ;;
################################################################################
##################### ANIMATION ############################## 
# 465) PJ Masks
465) 
keyword="PJ" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/channel/UCY2jUnU118sVkdj2xafiJ0g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="PJ Masks" ;;
# 466) Talking Tom and Friends
466) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TalkingFriends/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Talking Tom and Friends" ;;
# 467) Talking Tom and Friends Minis
467) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TalkingTomCat/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Talking Tom Minis" ;;    
# 468) Fashion TV Europe
468)  
link=http://www.dailymotion.com/video/x3m6nld
use_cookies="no"
chan_name="Fashion TV Europe" ;; 
# 469) Fashion 1 Spain
469) 
link=http://www.dailymotion.com/video/x2t9nsf
use_cookies="no"
chan_name="Fashion 1 Spain" ;; 
# 470) Jasmin TV
470) 
link=http://109.71.162.112:1935/live/hd.jasminchannel.stream/PAZ_Chega_de_Guerras.m3u8 
use_cookies="no"
chan_name="Jasmin TV" ;;  
# 471) The Young Turks
471)
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TheYoungTurks/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TYT The Young Turks" ;; 
# 472) DMC Sports
472) 
keyword="SPORTS" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/channel/UCiR6nRlvEBWVHPsJRXiCyyg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DMC Sports" ;;
# 473) Pitchoun FR
473)
link=https://www.dailymotion.com/video/x5zaibr 
use_cookies="no"
chan_name="Pitchoun FR" ;;
# 474) NRJ Hits Francais
474)
link=http://5.196.138.6:1935/live/nrjbelgique/chunklist_w1339281553.m3u8   
use_cookies="no"
chan_name="NRJ Hits Francais" ;;
# 475) Steven Universe 
475)
link=https://live.ponies.fr/hls/sug-hd/sug.m3u8
use_cookies="no"
chan_name="Steven Universe" ;;
# 476) Nature Vision
476)
link=https://hlsdpi-cdn-as4.totalstream.net/dpilive/vidilliontv/vtv/ntrnaturevision/playlist.m3u8
use_cookies="no"
chan_name="Nature Vision" ;;
# 477) Pursuit Channel
477)
link=https://hlsdpi-cdn-as4.totalstream.net/dpilive/vidilliontv/vtv/pursuitlive/playlist.m3u8
use_cookies="no"
chan_name="Pursuit Channel" ;;
# 478) Music Vox TV Old's Cool
478)
link=http://stream.cdn.smcloud.net/vox-t/vox_720p/playlist.m3u8
use_cookies="no"
chan_name="Music Vox TV " ;;
# 479) H!T Music Channel
479)
link=http://1mstream.digicable.hu/hitmusic/hitmusic.m3u8
use_cookies="no"
chan_name="H!T Music Channel" ;;
# 480) Now Music TV
480)
link=http://live.aatw.simplestreamcdn.com/now/live.m3u8
use_cookies="no"
chan_name="Now Music TV" ;;

###################### BROKEN /OFFLINE #################################################
# 458) High Stakes Poker
# 458) link=https://www.twitch.tv/highstakespoke 
# use_cookies="no"
# chan_name="High Stakes Poker" ;; 
# 453) Olympic Channel HD
# 453)
# link=http://ocs-live.hls.adaptive.level3.net/ocs/channel01/NBC_OCS1_VIDEO_7_6064000.m3u8
# use_cookies="no"
# chan_name="Olympic Channel HD" ;;
# 454) NFL Now
# 454)
# link=http://svglive3-event.level3.nfl.com/nflent3/live/now/NFLNOW.m3u8
# use_cookies="no"
# chan_name="NFL Now" ;;
# 473) Heavy Metal Television
# 476)
# link=http://70.166.98.130:1935/hmtv/myStream/playlist.m3u8
# use_cookies="no"
# chan_name="Heavy Metal Television" ;;
# 477)Kiss TV
# 477)
# link=http://tst.es.flash.glb.ipercast.net/tst.es-live/live/playlist.m3u8
# use_cookies="no"
# chan_name="Kiss TV" ;;
# 478) Family Friendly Entertainment
# 478)
# link=http://54.225.64.228:1935/live/roku2/playlist.m3u8
# use_cookies="no"
# chan_name="Family Friendly Entertainment";;
# 479)
# 480)
# 463) 
#link=http://amd.cdn.turner.com/adultswim/big/streams/playlists/toonami.m3u8
# use_cookies="no"
# chan_name="Toonami" ;;
# London Live 
# 460)
# link=http://bcoveliveios-i.akamaihd.net/hls/live/217434/3083279840001/master_900.m3u8
# use_cookies="no"
# chan_name="London Live" ;;
# dult Swim Animated Marathon 
# 464) 
# link=http://amd.cdn.turner.com/adultswim/big/streams/playlists/animated-marathon.m3u8
# use_cookies="no"
# chan_name="Adult Swim Animated Marathon" ;;

#  Mello TV English Jamaica
# 470)  
#link=http://mellotvnew.tulix.tv/live/smil:mellotv.smil/chunklist_w1010732594_b1128000_sleng.m3u8
#use_cookies="no"
#chan_name="Mello TV English Jamaica" ;; 
########################  RELIGIOUS PROGRAMMING   ############################
# 481) Vatican Media 
481) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vatican/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Vatican Media" ;;
# 482) EWTN English
482) 
#keyword="17"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/EWTN/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409283781001
use_cookies="no"
chan_name="EWTN America" ;;
# 483) EWTN Ireland 
483) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409261120001
use_cookies="no"
chan_name="EWTN Ireland" ;;
# 484) EWTN Africa
484) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409267772001
use_cookies="no"
chan_name="EWTN Africa" ;;
# 485) EWTN Asia
485) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5405034951001
use_cookies="no"
chan_name="EWTN Asia" ;;
# 486) Salt and Light Television Canada
486)
link="https://livestream.5centscdn.com/slworld/d65ce2bdd03471fde0a1dc5e01d793bb.sdp/tracks-v1a1/index.m3u8"
use_cookies="no"
chan_name="Salt and Light Television Canada" ;;
# 487)Catholic TV (USA) 
487) 
link=http://catholictvhd-lh.akamaihd.net:80/i/ctvhd_1@88148/master.m3u8
# link=http://catholictvhd-lh.akamaihd.net:80/i/ctvhd_1@88148/index_1_av-p.m3u8 
use_cookies="no"
chan_name="Catholic TV (USA)" ;;
# 488) CTND Catholic Television Network Detroit  
488)
link="https://livestream.com/accounts/19963560/events/5721749"
use_cookies="no"
chan_name="CTND Catholic Television Network Detroit" ;;
# 489) Shalom Media Catholic USA 
489)
link="https://livestream.com/shalomworld/events/7359508"
use_cookies="no"
chan_name="Shalom Media Catholic USA" ;;
# 490) Shalom Media Catholic Australia
490)
link="https://livestream.com/shalomworld/events/7551704"
use_cookies="no"
chan_name="Shalom Media Catholic Auastralia" ;;
# 491) Shalom Media Catholic Europe
491)
link="https://livestream.com/accounts/25038049/events/7358643"
use_cookies="no"
chan_name="Shalom Media Catholic Europe" ;;
# 492) EWTN Spanish 
492) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409267805001
use_cookies="no"
chan_name="EWTN Espanol" ;; 
# 493)  EWTN German
493) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409283775001
use_cookies="no"
chan_name="EWTN Deutsch" ;;
# 494) KtO Catholique
494)
link=http://livehdkto-lh.akamaihd.net/i/LiveStream_1@178944/master.m3u8
use_cookies="no"
chan_name="KtO Catholique" ;;
# 495) Shalom Media Catholic America 
495)
link="https://livestream.com/shalomworld/events/7511845"
use_cookies="no"
chan_name="Shalom Media Catholic America"  ;;
# 496) Shalom Media Catholic India
496)
link="https://livestream.com/shalomworld/events/7483919"
use_cookies="no"
chan_name="Shalom Media Catholic India" ;;
# 497) CBN
497)
link=http://bcliveuniv-lh.akamaihd.net/i/iptv1_1@194050/master.m3u8
use_cookies="no"
chan_name="CBN" ;;
# 498)CBN News
498)
link=http://bcliveuniv-lh.akamaihd.net/i/news_1@194050/master.m3u8
use_cookies="no"
chan_name="CBN News" ;;
# 499)NRB Network
499)
link=http://uni6rtmp.tulix.tv/nrbnetwork/myStream.sdp/playlist.m3u8
use_cookies="no"
chan_name="NRB Network" ;;
# 500) The Church Channel
500)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_1728_av-p.m3u8
use_cookies="no"
chan_name="The Church Channel" ;;
# 501) TBN
501)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN01_delivery@186239/master.m3u8
use_cookies="no"
chan_name="TBN" ;;
# 502)GOD TV (USA) 
502) 
link=http://ooyalahd2-f.akamaihd.net/i/godtv01_delivery@17341/master.m3u8
use_cookies="no"
chan_name="GOD TV (USA)" ;;
# 503) Amazing Facts TV (Christian)
503) 
keyword="AFTV"
#link=http://amazingfacts.live-s.cdn.bitgravity.com/cdn-live/_definst_/amazingfacts/live/feed01/chunklist_w1921345467.m3u8
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/AmazingFacts/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Amzaing Facts TV (Christian)" ;;
# 504) It's Supernatural! Network (Christian)
504) 
keyword="Supernatural"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SidRoth/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="It's Supernatural! (Christian)" ;;
# 505) Shepherd's Chapel, Gravette Arkansas  
505) 
keyword="Chapel"
#link="https://livestream.com/accounts/14403440/events/4227022"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TheShepherdsChapel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Shepherd's Chapel, Gravette Arkansas" ;;
# 506) International House of Prayer (IHOP) (Christian)
506) 
keyword="Live"
#link="https://ihoplive-f.akamaihd.net/i/ihopkc_tprhd@142185/index_1000_av-p.m3u8?sd=6&set-segment-duration=quality&rebase=on"
link="https://ihoplive-f.akamaihd.net/i/ihopkc_tprhd@142185/index_2500_av-p.m3u8?sd=6&set-segment-duration=quality&rebase=on"
#link="https://ihoplive-f.akamaihd.net/i/ihopkc_tprhd@142185/index_4001_av-p.m3u8?sd=6&set-segment-duration=quality&rebase=on"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/IHOPkc/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="International House of Prayer (Christian)" ;;
# 507) Belivers Voice of Victory Network
507) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCvYVGf_JFME9dVe3WtljP1Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Belivers Voice of Victory Network" ;;
# 508) Three Angels BroadCasting
508) 
keyword="Three Angels"
#link=http://moiptvus-lh.akamaihd.net:80/i/3abnlive_1@328342/index_800_av-p.m3u8 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/3ABNVideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Three Angels Broadcasting Network" ;; 
# 509) 3ABN Latino
509)  
keyword="3ABN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/3abnlatino/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="3ABN Latino" ;; 
# 510) Salt and Light TV Portage Michigan
510) 
keyword="Salt"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCS1_M4LZ3o3gNmfKbZX6QGw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Salt and Light TV Portage Michigan" ;; 
# 511) LLBN TV
511) 
keyword="LLBN Christian TV Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/LLBNChristianTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="LLBN TV" ;; 
# 512) Hillsong Channel
512)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/master.m3u8
use_cookies="no"
chan_name="Hillsong Channel" ;;
# 513) St. Marys Coptic
513) 
keyword="Live Streaming"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHbwJUahgtOKHI3e-AHdZDg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="St. Marys Coptic" ;; 
# 514) Word of God Greek
514) 
keyword="Word"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/WordofGodGreece/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Word of God Greek" ;; 
# 515) Heaven TV
515) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCl4i7ZkqmgN2hQyRF4m2fWA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Heaven TV" ;; 
# 516) Powervision TV
516) 
keyword="POWERVISION"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCzxfpzSF7mz8j7bNIXyZWmA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Powervision TV" ;; 
# 517) KJV Audio
517) 
keyword="KJV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TheTwoPreachers/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KJV Audio Bible" ;; 
# 518) Harbor Light Radio
518) 
keyword="Harbour Light Radio Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCoGlUDLHffMYyJBD4j3zeDw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Harbor Light Radio" ;; 
# 519) JUCE TV
519)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN03_delivery@186241/index_1728_av-p.m3u8
use_cookies="no"
chan_name="JUCE TV" ;;
# 520) Temple Institute
520) 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/henryporter2/videos" | grep "Weekly Torah" | grep "watch?v=" |  head -n 1 | cut -d / -f 2 | cut -d \" -f 1 | cut -d = -f 2 )" 
use_cookies="no"
chan_name="Temple Institute" ;;
###################  MIXER    ###################
# 521) Vatican Media English
521) 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCxIsefyl9g9A5SGWA4FvGIA/videos" |  grep "$keyword" | grep "watch?v=" |  head -n 1 | cut -d / -f 2 | cut -d \" -f 1 | cut -d = -f 2 )" 
use_cookies="no"
chan_name="Vatican Media English" ;;
# 522)  DW Deutsch +     GEOregion blocked
522) 
link="http://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/master.m3u8" 
use_cookies="no"
chan_name="DW Deutsch +" ;;
# 523)Quran English Arabic
523) 
keyword="Quran Hidayah"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCCUeQpcsP49uq4_mjif8r7w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Quran English Arabic" ;; 
# 524) ABC 3 News Louisiana
524) 
link=http://ktbs-lh.akamaihd.net/i/KTBS_1069@111925/master.m3u8
use_cookies="no"
chan_name="ABC 3 News (Louisiana)" ;;
# 525) WPLG 10 News Miami
525) 
link=http://play-prod1.live.anvato.net/server/play/pns-wplg-dfp/master.m3u8
use_cookies="no"
chan_name="WPLG 10 News Miami" ;;
# 526) WJXT News 4 Jacksonville
526) 
link=http://play-prod1.live.anvato.net/server/play/pns-wjxt-dfp/master.m3u8
use_cookies="no"
chan_name="WJXT News 4 Jacksonville" ;;
# 527) NBC 6 South Florida (WTVJ-TV)
527)
link=http://wtvjlive-f.akamaihd.net/i/wtvja1_1@19309/master.m3u8
use_cookies="no"
chan_name="NBC 6 South Florida WTVJ";;
# 528) WBLZ Bangor Maine
528)
link=http://wlbz-lh.akamaihd.net/i/WLBZ_Live_1@27474/master.m3u8
use_cookies="no"
chan_name="WLBZ Bangor Maine" ;; 
# 529)TTB Network
529)
link=http://www.dailymotion.com/video/x14tgdi
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="TTB Network" ;;
# 530) Vatican Media Deutsch
530)  
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vaticande/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Vatican Media Deutsch" ;; 
# 531) Vatican Media Italiano
531)  
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vaticanit/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Vatican Media Italiano" ;; 
################ IRELAND ###############
# 532) Dail Eireann IE
532) 
link=https://oirlive.heanet.ie/dail/ngrp:dail.stream_all/chunklist_b1228000.m3u8   
#link=https://oirlive.heanet.ie/dail/ngrp:dail.stream_all/playlist.m3u8
#link=https://media.heanet.ie/oirlive/dail/ngrp:dail.stream_all/playlist.m3u8
use_cookies="no"
chan_name="Dail Eireann IE" ;; 
# 533) Senad Eireann IE
533) 
link=https://oirlive.heanet.ie/seanad/ngrp:seanad.stream_all/playlist.m3u8   
#link=https://media.heanet.ie/oirlive/seanad/ngrp:seanad.stream_all/playlist.m3u8
use_cookies="no"
chan_name="Senad Eireann IE" ;; 
# 534)# 540)Oireachtas Committee Room 1 
534) 
link=https://oirlive.heanet.ie/cr1/ngrp:cr1.stream_all/chunklist_b1228000.m3u8
use_cookies="no"
chan_name="Oireachtas Committee Room 1" ;; 
# 535)# 540)Oireachtas Committee Room 2 
535) 
link=https://oirlive.heanet.ie/cr2/ngrp:cr2.stream_all/chunklist_b1228000.m3u8
use_cookies="no"
chan_name="Oireachtas Committee Room 2" ;; 
# 536)# 540)Oireachtas Committee Room 3 
536) 
link=https://oirlive.heanet.ie/cr3/ngrp:cr3.stream_all/chunklist_b1228000.m3u8
use_cookies="no"
chan_name="Oireachtas Committee Room 3" ;; 
# 537)# 540)Oireachtas Committee Room 4 
537) 
link=https://oirlive.heanet.ie/cr4/ngrp:cr4.stream_all/chunklist_b1228000.m3u8
use_cookies="no"
chan_name="Oireachtas Committee Room 4" ;;

# 538)
# 539)
# 540)
# 541)

# 542) BSC 24 1
542) 
keyword="BSC24-第1"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/bousaishare/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="BSC 24 1" ;; 
# 543) BSC 24 2
543) 
keyword="BSC24-第2"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCeEkbpBLgTEHy9NP-JHnPYQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="BSC 24 2" ;; 
# 544) Earthquake 24  
544) 
keyword="地震監視・24時間LIVE" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCmw7DsSCQzRcRG6-SHE_ksg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Earthquake 24" ;; 
# 545) Arirang News 
545) 
keyword="Arirang TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/arirangnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Arirang News TV" ;; 
# 546) Arirang TV Korean 
546) 
keyword="Arirang TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/arirangkorean/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Arirang TV Korean" ;; 
# 547) OnTV Hong Kong
547) 
keyword="東網直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCZ79ABUb7OO4iMiNK2QPM7g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="OnTV Hong Kong";;
# 548) Planeta Channel 2 Russia
548)
link=http://wse.planeta-online.tv:1935/live/channel_2/chunklist.m3u8
use_cookies="no"
chan_name="TBTYP TV Planeta Channel 2 Russia" ;;
# 549) Planeta Channel 3 Russia
549)
link=http://wse.planeta-online.tv:1935/live/channel_3/chunklist.m3u8
use_cookies="no"
chan_name="Planeta Channel 3 Russia" ;;
## 550) 919 FM TV Trinidad 
550) 
keyword="919 fm"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCD-Z-JAX2s3mUgs0rOmZFKQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="919 FM TV Trinidad" ;; 
# 551) EBS European Commision
551)
link=https://ott.ec.streamcloud.be/live/disk1/EBS/hls_or/EBS-audio_AACL_qaa_66400_201=66400-video=800000.m3u8
use_cookies="no"
chan_name="EBS European Commision" ;;
# 552) EBS European Commision
552)
link=https://ott.ec.streamcloud.be/live/disk1/EBSplus/hls_or/EBSplus-audio_AACL_qaa_66400_401=66400-video=800000.m3u8
use_cookies="no"
chan_name="EBS Plus European Commision" ;;

# 553)

# 554) United Nations UN Trustship Chamber
554) 
keyword="LIVE"
#link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5689257377001
##Trustship Chamber
link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5701485575001
##ECOSOC 
#link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5701459952001
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/unitednations/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="United Nations UN Trustship Chamber" ;;  

# 555) United Nations UN ESOSOC Chamber
555) 
keyword="LIVE"
#link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5689257377001
##Trustship Chamber
link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5701485575001
##ECOSOC 
#link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5701459952001
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/unitednations/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="United Nations UN ESOSOC Chamber" ;;  

###################  MENU 3   #####################################
# 561) VIVE Venezuela
581) 
keyword="VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCg6uD_hL72AFeZuMJL5u07w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="VIVE Venezuela" ;;
# 562) Vatican Media
562)  
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vaticanes/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Vatican Media" ;; 
# 563) Televen 
563) 
keyword="Televen EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCcNva2dC9BR8QR_G02xDFqw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Televen Venezuela" ;;
# 564) Impacto USA 
564)
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/impactotv2/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Impacto USA" ;;
# 565) UCVTV CL  Universidad Católica de Valparaíso
565)  
keyword="UCVTV EN VIVO"
link="http://unlimited1-us.dps.live/ucvtv/ucvtv.smil/ucvtv/livestream2/chunks.m3u8?nimblesessionid=14582063"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/UCVTVONLINE/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="UCVTV Chile" ;;
# 566) UCVTV CL  Universidad Católica de Valparaíso
566)  
keyword="UCVTV EN VIVO"
link="http://unlimited1-us.dps.live/ucvtv2/ucvtv2.smil/ucvtv2/livestream2/chunks.m3u8?nimblesessionid=14583770"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/UCVTVONLINE/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="UCVTV 2 Chile" ;;


####################################
# 567) Noticiero Univision MX
567)  
keyword="Noticiero"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/UnivisionNoticias/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Noticiero Univision MX" ;;
# 568) Canal 2 Cablenet San Vicente Argentina  
568)
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6y6nCxdSnkIsQTbfO-AvBw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no" 
chan_name="Canal 2 CABLENET San Vicente Argentina" ;;
# 569)Canal 2 Telpintv Pinamar AR  
569)  
keyword="Telpin"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TelpinVideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Canal 2 Telpintv Pinamar AR" ;;  
# 570) Canal 8 Mar del Plata
570) 
keyword="Plata"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCY0QZk2M_ZZi95S-MN1Zndg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"  
chan_name="Canal 8 Mar del Plata Argentina" ;; 
# 571) Canal 11 de Salta Argentina
571)  
keyword="Salta"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCy-r-BQ5BQRU6rzGS73-WBQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Canal 11 de Salta Argentina" ;;  
# 572) UNITVE AR  Universidad Nacional de Villa Maria, Córdoba ***
572) 
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_NtgyVHyQJfy3YlM6XdQdw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="UNITVE Cordoba AR" ;;
################## PARAGUAY #####################################
# 573) ABC TV Paraguay   ****
573)  
keyword="ABC"
link=http://www.ustream.tv/channel/21235831
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/canalabctv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="ABC TV Paraguay" ;;
################# BOLIVIA #####################################
# 574) Abya Yala Bolivia  ****
574)  
keyword="Abya Yala"
link=https://www.ustream.tv/channel/23484517
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCYVYGzj8t64hFAz2T-udG5Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Abya Yala Bolivia" ;;
# 575) UFRO Vision Chile *****
575)  
keyword="UFRO"
linkl=https://mdstrm.com/share/live/580a80b827de0ae2086ea6d8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC5H9zdp-3M24xWWJunhLJmQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="UFRO Vision Chile" ;;  
# 576) CAMPO ABIERTO Santiago Chile
576) 
keyword="TRANSMISIÓN CAMPO ABIERTO TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCwcZwWgpdrF-JsOkquSD59w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CAMPO ABIERTO Santiago Chile" ;;
# 577) UNITV Universidad Nacional de General Sarmiento AR
577)  
keyword="Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCWCJwDsCdRn_pwHNpLwEJcw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="UNITV Universidad Nacional de General Sarmiento AR" ;;  
# 578) TelePacifico Colombia  ****
578) 
keyword="Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCpywwd47pfQSwBO8pXZwXrw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TelePacifico Colombia" ;; 
# 579) Venevision VE
579)  
keyword="Emisión"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/noticierovenevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Venevision VE" ;; 
# 580) Telediario AR  
580)  
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC1-SmZtkXTg2ufhLMpwiRIg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Telediario AR" ;;
# 581) TVeo Canal 41 Cordoba AR
581)  
keyword="Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC9kgE-365dvz6zJEUX1dFiw/?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="TVeo Canal 41 Cordoba AR" ;; 
# 582) PSN Tijuana Mexico
582) 
keyword="PSN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/psntv1/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="PSN Tijuana Mexico";; 
## 583) Senal de CNN en Espanol
583)
keyword="CNN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/cnnenespanolcom/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Senal de CNN en Espanol" ;; 
## 584) Paraguay Noticias
584)
link=https://livestream.com/accounts/25680986/events/7856569
use_cookies="no"
chan_name="Paraguay Noticias" ;; 
## 585) Canal Tr3ce
585) 
link=https://cdn.logicideas.media/canaltrece-live/smil:MNQW4.smil/chunklist_b1500000.m3u8
use_cookies="no"
chan_name="Canal Tr3ce CO" ;;
## 586) Cali TV
586) 
link=http://vbox.cehis.net/live-calitv/calitv1/chunklist_w1780377540.m3u8 
use_cookies="no"
chan_name="Cali TV CO" ;;
## 587) Canal 12 CO
587) 
link=http://edge.teveo.com.co/live/AeAAAgAJAAFFA1IAyADIVKgAAAAAAAAAAlqjj_e4Rz22AAAA/chunklist_w1858463102.m3u8 
use_cookies="no"
chan_name="Canal 12 CO" ;;
# 588) Imagen Radio Mexico
588) 
keyword="En Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ImagenNoticias/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Imagen Radio Mexico" ;;
# 589)Euronews Espanol
589)  
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewses/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Euronews Espanol" ;;  
# 590) Teleamazonas
590)  
keyword="Live"
link=https://livestream.com/accounts/1359588/Noticiero24Horas
use_cookies="no"
chan_name="Teleamazonas" ;;  
# 591)Azteca Uno MX
591)  
link=http://aztecalive-lh.akamaihd.net/i/0qm7cjvop_1@502476/index_3_av-p.m3u8?sd=10&rebase=on
use_cookies="no"
chan_name="Azteca Uno MX" ;;  
# 592)Azteca 7 MX
592)  
link=http://aztecalive-lh.akamaihd.net/i/0pq46e6vw_1@502477/index_3_av-p.m3u8?sd=10&rebase=on
use_cookies="no"
chan_name="Azteca 7 MX" ;;  
# 593)Mi Musica 
593)  
link=https://livestream.com/accounts/1858/events/1603527/videos/109671818
use_cookies="no"
chan_name="Mi Musica " ;;  
# 594)Colosal TV 1 
594)  
link=http://k3.usastreams.com:1935/colosaltv1/colosaltv1/chunklist_w516008458.m3u8
use_cookies="no"
chan_name="Colosal TV 1" ;;  

# Disney Channel German
# http://par-3.firstone.tv/hls/998955fe-b2ee-6cc8-279f-03def85d1f9f.m3u8

# Dorf TV Douselldorf AT
# link=https://stream.openplayout.org/hls/dorf_high/index.m3u8
# rtmp://dorf.openplayout.org/hls/dorf_high
# http://stream.openplayout.org/hls/dorf_mid/index.m3u8
# rtmp://dorf.openplayout.org/hls/dorf_mid
# https://dorftv.at/stream.openplayout.org/hls/dorf_low/index.m3u8
# rtmp://dorf.openplayout.org/hls/dorf_low

# ADR Alpha Live DE
# https://br-i.akamaihd.net/i/tafeln/br-fernsehen/br-fernsehen-tafel_,0,A,B,E,C,X,.mp4.csmil/index_2_av.m3u8?null=0

# Tele5 DE 
# http://par-3.firstone.tv/hls/1ab9c8ae-8e51-2730-9795-6a57e149ba01.m3u8

# QVC DE 
# http://llnw.live.qvc.simplestream.com/hera/remote/qvcde_primary_sdi7/2/prog_index.m3u8

# C31 AU
# https://0swcfsc-lh.akamaihd.net/i/C31Live_1@15200/master.m3u8

# West TV AU  Brightcove
# 5625915374001 default 5659898635001

# 3ABN Francais
#http://aos01.3abn.adaptive.level3.net/hls-live/mediaoppremux-fre_multi/_definst_/live/stream3.m3u8


######################## Portuguese #########################
# 601) Euronews Portugues
601)
keyword="euronews em"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewspt/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Euronews Portugues" ;;
################ BRAZIL   ################################
# 602) TV Assemblelia BR
602)
keyword="ao vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCIxlLEYzjWPLb_CXpc-e74w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="TV Assemblelia" ;;
# 603) TV Canaco Nova
603)
keyword="Ao Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tvcancaonova/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="TV Canaco Nova" ;;
# 604) TV Igreja Internacional de Graca
604)
keyword="ao vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_hwWljVyb_o3yzasx-bG2g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="TV Igreja Internacional de Graca" ;;
# 605) TV Ales Assembleia Legeslativa
605)
keyword="Ales"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/alescomunicacao/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="TV Ales Assembleia Legeslativa" ;;
# 606) TV Boas Nova
606)
keyword="Play"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/boasnovasoficial/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Boas Nova" ;;
# 607) Fundacao Nazzare de Communicaco
607)
keyword="VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/FNComunicacao/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Fundacao Nazzare de Communicaco" ;;
# 608) STF Brazil
608)  
keyword="TV JUSTIÇA – AO VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/STF/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="STF Brazil" ;;  
# 609) TV Estúdio Brasil
609)
link=http://stmv2.srvstm.com:1935/tvestudiobrasil/tvestudiobrasil/playlist.m3u8 
use_cookies="no"
chan_name="TV Estúdio Brasil" ;;
# 610) Rádio Justiça - Ao Vivo  
610)  
keyword="Rádio Justiça"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/STF/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Radio Justicia" ;;  
# 611) EXA FM 93.9
611)  
keyword="EXA FM 93.9"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCWWzGVZpJsQpFYGrMTGuZcg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="EXA FM 93.9" ;; 
# 612) RIT TV BR
612)  
keyword="RIT"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCA0bOG0NUfJ855eDtHSxOkw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="RIT TV BR" ;; 
# 613) Vatican Media
613)  
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCGYSq4b4DXmtK4jyq6r-FYg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Vatican Media" ;; 
# 614)EVTV Miami
614)  
keyword="EVTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/elvenezolanotv/videos?view=2&flow=grid" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="EVTV Miami" ;; 




#Milenio Mexico  ****
# #108)  
#keyword="MILENIO"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/MILENIO/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#use_cookies="no"
#chan_name="Milenio Mexico" ;; 
# 120) El Capitolio Venezulana
# 120) 
#keyword="EN VIVO"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCbSDz7_rVKXjZ9fRON16apQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"   
#use_cookies="no"
#chan_name="El Capitolio Venezulana" ;; 
# 604)CANAL SHOW DA FÉ  Portugese
# 604)
# link=http://nossatvhls02-lh.akamaihd.net:80/i/nossatv_hls@381916/index_600_av-p.m3u8 
# use_cookies="no"
# chan_name="CANAL SHOW DA FÉ Portugese" ;; 

#######################################################################################################

###################################### FRANCAIS EXTRA ##########################################

## 641) Crime District FR
641)
link=http://live-s102.abweb.com/liveabs102/ngrp:crimedistrict.stream_bis/playlist.m3u8   
use_cookies="no"
chan_name="CRIME DISTRICT Francais" ;;
# 642) ACTION Francais
642)
link=http://live-s101.abweb.com/liveabs101/ngrp:action.stream_bis/playlist.m3u8  
use_cookies="no"
chan_name="ACTION Francais" ;;
# 643) ANIMAUX Francais
643)
link=http://live-s102.abweb.com/liveabs102/ngrp:animaux.stream_bis/playlist.m3u8 
use_cookies="no"
chan_name="ANIMAUX Francais" ;;
# 644) Vatican Media  
644) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vaticanfr/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Vatican Media" ;;  
# 645) CNEWS France
645)
link=http://www.dailymotion.com/video/x3b68jn
# link=http://www.dailymotion.com/embed/video/x3b68jn
use_cookies="no"
#format=hls-1080
#format=hls-1080@60
#format=hls-720@60
# format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="CNEWS France" ;;
# 646) AB3 
646)
link=http://live-trl101.abweb.com/liveabtrl101/ngrp:ab3.stream_bis/playlist.m3u8  
use_cookies="no"
chan_name="AB3" ;;
# 647) Science et Vie 
647)
link=http://live-trl101.abweb.com/liveabtrl101/ngrp:scienceetvie.stream_bis/playlist.m3u8   
use_cookies="no"
chan_name="Science et Vie" ;;
# 648) POLAR Francais
648)
link=http://live-trl101.abweb.com/liveabtrl101/ngrp:cinepolar.stream_bis/playlist.m3u8  
use_cookies="no"
chan_name="POLAR Francais" ;;
# 649) RTL 9  
649)
link=http://live-trl01.abweb.com/livetrl01/ngrp:rtl9.stream_bis/playlist.m3u8  
use_cookies="no"
chan_name="RTL 9" ;;
# 650) Antena Centre BE
650)
link=http://vm109.imust.org:1935/live/livestream/HasBahCa.m3u8 
use_cookies="no"
chan_name="Antena Centre BE" ;;
## 651)QVC Francais
651) 
keyword="en direct"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCUgix0XhGdH0AThuPG-ALMA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="QVC Francais" ;;  
# 653) France O
653) 
link=https://www.filmon.com/tv/france-0
use_cookies="yes"
chan_name="France O" ;;
# 653)
# 654) #Tout L'Histoire
654)
link=http://live-s101.abweb.com/liveabs101/ngrp:toutelhistoire.stream_bis/playlist.m3u8  
use_cookies="no"
chan_name="Tout L'Histoire" ;;
# 655) M6
655)
link=http://144.217.253.140/M6/tracks-v1a1/index.m3u8  
use_cookies="no"
chan_name="M6" ;;
# 656) W9
656)
link=http://144.217.253.140/W9/index.m3u8 
use_cookies="no"
chan_name="W9" ;;
# 657) C-Star
657)
link=https://stream-07.dc3.dailymotion.com/41/dm/3/x5idxor/live-2.m3u8
use_cookies="no"
chan_name="C-Star" ;;
# 658) TLM Lyon Metro
658) 
keyword="TLM"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/telelyonmetropole/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
chan_name="TLM Television Lyon Metro" ;;
# 659)SYTRAL Rhone FR
659) 
keyword="DIRECT"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SytralTCL/videos?view=2&flow=grid" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
chan_name="SYTRAL Rhone FR" ;;
# 660) Bidtween La chaîne TV des Enchères FR
660)
link="https://livestream.com/accounts/25334545/events/7803598"
use_cookies="no"
chan_name="Bidtween La chaîne TV des Enchères FR" ;;
# 661) 
# 662) MABI TV Canada
662) 
keyword="en direct"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCC1LyPxWz4t2PGfIr2ETwPw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"  
chan_name="MABI TV Canada" ;;





################### BROKEN / OFFLINE ###################################
# 75) ICI RDI Canada
# 75)
# link="http://hdflash_1-lh.akamaihd.net/i/canrdi_1@95877/index_1200_av-p.m3u8?sd=10&rebase=on"
# link="http://hdflash_1-lh.akamaihd.net/i/canrdi_1@95877/index_400_av-p.m3u8?sd=10&rebase=on"
#link="http://hdflash_1-lh.akamaihd.net/i/canrdi_1@95877/index_800_av-p.m3u8?sd=10&rebase=on"
#link="http://hdflash_1-lh.akamaihd.net/i/canrdi_1@95877/index_1200_av-p.m3u8?sd=10&rebase=on"
#link="http://hdflash_1-lh.akamaihd.net/i/canrdi_1@95877/master.m3u8?sd=10&rebase=on"
#use_cookies="no"
#chan_name="ICI RDI Canada" ;;
# 61) Notele Tournai Belgium
# 61)
# link=rtmp://streaming06.axeweb.be/live/direct.stream
# use_cookies="no"
# chan_name="Notele Tournai Belgium" ;;   
################################################################################## 

#################################   COLUMN 4 ############################################

# 681) FOX News Channel Preview (No Audio)
681)  
link=https://fnurtmp-f.akamaihd.net/i/FNCPREV_1@143121/master.m3u8
use_cookies="no"
chan_name="FOX News Channel Preview Preview (No Audio)" ;; 
# 682) Fox News Talk
682)  
link=https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/master.m3u8
use_cookies="no"
chan_name="Fox News Talk" ;; 
# 683) STADIUM
683)
link=https://04476b7c682c4da8b8b4bfe23ef879c1.midas.us-east-1.amazonaws.com/v1/master/61a556f78e4547c8ab5c6297ea291d6350767ca2/Mux/hls/live/522512/mux_4/master.m3u8  
use_cookies="no"
chan_name="STADIUM" ;; 
# 684) NFL Now Live
684)
link=https://svglive3-event.level3.nfl.com/nflent3/live/nfl_now/NFLNOW.m3u8 
use_cookies="no"
chan_name="NFL Now Live" ;; 
# 685) RED BULL TV 
685)
link=https://dms.redbull.tv/v3/linear-borb/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6InBlcnNvbmFsX2NvbXB1dGVyIiwiY291bnRyeV9jb2RlIjoidXMiLCJleHBpcmVzIjoiMjAxNy0wOS0xNlQxNzo0NjowMy45NjM0NjI4NDJaIiwib3NfZmFtaWx5IjoiaHR0cCIsInJlbW90ZV9pcCI6IjEwLjE1Ny4xMTIuMTQ4IiwidWEiOiJNb3ppbGxhLzUuMCAoTWFjaW50b3NoOyBJbnRlbCBNYWMgT1MgWCAxMF8xMl81KSBBcHBsZVdlYktpdC82MDMuMi40IChLSFRNTCwgbGlrZSBHZWNrbykgVmVyc2lvbi8xMC4xLjEgU2FmYXJpLzYwMy4yLjQiLCJ1aWQiOiJkOGZiZWYzMC0yZDhhLTQwYTUtOGNjNy0wNzgxNGJhMTliNzMifQ.Q_38FNpW3so5yrA5FQt9qBuix3dTulKpb6uQ0dRjrtY/playlist.m3u8
use_cookies="no"
chan_name="RED BULL TV" ;; 
# 686) Olympics Channel
686)
link=https://live.olympicchannel.com/ocs/channel01b/master.m3u8
use_cookies="no"
chan_name="Olympics Channel" ;; 
# 687) Olympics Channel 2
687)
link=https://live.olympicchannel.com/ocs/channel02b/master.m3u8
use_cookies="no"
chan_name="Olympics Channel 2 " ;; 
# 688) Olympics Channel 3
688)
link=https://live.olympicchannel.com/ocs/channel03b/master.m3u8
use_cookies="no"
chan_name="Olympics Channel 3 " ;; 
# 689) Olympics Channel 4
689)
link=https://live.olympicchannel.com/ocs/channel04b/master.m3u8
use_cookies="no"
chan_name="Olympics Channel 4 " ;; 
# 690) Olympics Channel 5
690)
link=https://live.olympicchannel.com/ocs/channel05b/master.m3u8
use_cookies="no"
chan_name="Olympics Channel 5 " ;; 
# 691) NBC News Live Event
691)
link=https://nbcnews-lh.akamaihd.net/i/nbc_live11@183427/master.m3u8
use_cookies="no"
chan_name="NBC News Live Event" ;; 
# 692) Shepard Smith Breaking News
692)
link=http://fnurtmp-f.akamaihd.net/i/SHEPSMITH_1@459383/master.m3u8
use_cookies="no"
chan_name="Shepard Smith Breaking News" ;;  
# 693) WUSA9 Breaking News
693)
link=https://wusa-lh.akamaihd.net/i/WUSA_Breaking_1@98930/master.m3u8
use_cookies="no"
chan_name="WUSA9 Breaking News" ;; 
# 694) WCNC Breaking News audio
694)
link=http://wcnc-lh.akamaihd.net/i/WCNC_Breaking_1@195112/master.m3u8
use_cookies="no"
chan_name="WCNC Breaking News audio" ;; 
# 695) WCCB News Rising
695)
link=https://api.new.livestream.com/accounts/8522553/events/live/live.m3u8
use_cookies="no"
chan_name="WCCB News Rising" ;;  
# 696) UGA TV
696)
link=http://mmuga-lh.akamaihd.net/i/ctlcable_1@349875/master.m3u8
use_cookies="no"
chan_name="UGA TV" ;;   
# 697) TVW Washington State TV
697)
link=http://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:TVWAIR_all/master.m3u8
use_cookies="no"
chan_name="TVW Washington State TV" ;; 
# 698) TVW2 Washington State TV
698)
link=http://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:TVW2_all/master.m3u8
use_cookies="no"
chan_name="TVW2 Washington State TV" ;; 
# 699) Action News Now (KNVN)
699)
link=https://api.new.livestream.com/accounts/26511688/events/7954874/live.m3u8
use_cookies="no"
chan_name="Action News Now (KNVN)" ;; 
# 700) Anchorage Alaska ASD TV
700)
link=http://64.22.99.223/AnchorageSchoolsAKLIVE/_definst_/AnchorageSchoolsAKLIVE.stream/chunklist.m3u8
use_cookies="no"
chan_name="Anchorage Alaska ASD TV" ;; 
# 701) Atlanta Channel
701)
link=http://media4.tripsmarter.com:1935/LiveTV/ACVBHD/playlist.m3u8
use_cookies="no"
chan_name="Atlanta Channel" ;; 
# 702) Beach TV - 30A
702)
link=http://media4.tripsmarter.com:1935/LiveTV/DTVHD/playlist.m3u8
use_cookies="no"
chan_name="Beach TV - 30A" ;; 
# 703) Beach TV - Panama City
703)
link=http://media4.tripsmarter.com:1935/LiveTV/BTVHD/playlist.m3u8
use_cookies="no"
chan_name="Beach TV - Panama City" ;; 
# 704) Beach TV - Pawleys Island
704)
link=http://media4.tripsmarter.com:1935/LiveTV/MTVHD/playlist.m3u8
use_cookies="no"
chan_name="Beach TV - Pawleys Island" ;;
# 705) Bowie TV
705)
link=http://granicusliveus3-a.akamaihd.net/cityofbowie/G0466_001/playlist.m3u8
use_cookies="no"
chan_name="Bowie TV" ;;
# 706) Buffalo TV
706)
link=http://na-all15.secdn.net/pegstream3-live/play/c3e1e4c4-7f11-4a54-8b8f-c590a95b4ade/playlist.m3u8
use_cookies="no"
chan_name="Buffalo TV" ;;
# 707) Capital City Connection
707)
link=http://na-us-se13.secdn.net/pegstream3-live/play/5f0d9ca5-4e85-4c01-a426-9ec8d44c2c9c/playlist.m3u8
use_cookies="no"
chan_name="Capital City Connection" ;;
# 708) Daytona Beach TV
708)
link=http://oflash.dfw.swagit.com/live/daytonabeachfl/smil:std-4x3-1-a/chucklist.m3u8
use_cookies="no"
chan_name="Daytona Beach TV" ;;
# 709) District Knowledge Network
709)
link=http://video.oct.dc.gov/out/u/96_4.m3u8
use_cookies="no"
chan_name="District Knowledge Network" ;;
# 710) District of Columbia Network
710)
link=http://video.oct.dc.gov/out/u/DCN.m3u8
use_cookies="no"
chan_name="District of Columbia Network" ;;
# 711) Escambia TV
711)
link=http://58bfeaf58405a.streamlock.net/live/escambiacountyfl/smil:std-4x3-1-a/playlist.m3u8
use_cookies="no"
chan_name="Escambia TV" ;;
# 712) FiOS1 News New Jersey 
712)
link=https://cdnapisec.kaltura.com/p/424341/sp/42434100/playManifest/entryId/1_if6bcg01/format/applehttp/protocol/https/uiConfId/39790741/a.m3u8
use_cookies="no"
chan_name="FiOS1 News New Jersey" ;;
# 713) FiOS1 News Long Island
713)
link=https://cdnapisec.kaltura.com/p/424341/sp/42434100/playManifest/entryId/1_b159ee77/format/applehttp/protocol/https/uiConfId/39790741/a.m3u8
use_cookies="no"
chan_name="FiOS1 News Long Island" ;;
# 714) FiOS1 News Lower Hudson Valley
714)
link=https://cdnapisec.kaltura.com/p/424341/sp/42434100/playManifest/entryId/1_is35xshu/format/applehttp/protocol/https/uiConfId/39790741/a.m3u8
use_cookies="no"
chan_name="FiOS1 News Lower Hudson Valley" ;;
# 715) Fox 5 Washington DC (WTTG-TV)
715)
link=https://api.new.livestream.com/accounts/2363281/events/1763520/live.m3u8
use_cookies="no"
chan_name="Fox 5 Washington DC (WTTG-TV)" ;;
# 716) Garland TV
716)
link=http://oflash-alt.dfw.swagit.com/live/garlandtx/smil:hd-16x9-1-a/chunklist.m3u8
use_cookies="no"
chan_name="Garland TV" ;;
# 717) Greenbelt TV
717)
link=http://granicusliveus4-a.akamaihd.net/greenbeltmd/G0610_001/chunklist.m3u8
use_cookies="no"
chan_name="Greenbelt TV" ;;
# 718) House of Representatives
718)
link=http://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:HouseChannel_all/chucklist.m3u8
use_cookies="no"
chan_name="House of Representatives" ;;
# 719) KRBC-TV
719)
link=http://krbc-apple-live.hls.adaptive.level3.net/stream0/master.m3u8
use_cookies="no"
chan_name="KRBC-TV" ;;
# 720) KBVR TV
720)
link=http://klive-a.akamaihd.net/dc-0/live/hls/p/391241/e/0_bthpnu1j/sd/10000/t/YwqLo1YivB_aumq-LxAuWg/master.m3u8
use_cookies="no"
chan_name="KBVR TV" ;;
# 721) KTVB
721)
link=http://ktvb-lh.akamaihd.net/i/KTVB_Shows_1@60359/master.m3u8
use_cookies="no"
chan_name="KTVB" ;;
# 722) Key TV Florida
722)
link=http://media4.tripsmarter.com:1935/LiveTV/KTVHD/chunklist_w363623166.m3u8
use_cookies="no"
chan_name="Key TV Florida" ;;
# 723) KOB4 News Albacurqe NM
723)
link=https://api.new.livestream.com/accounts/10066184/events/3399986/live.m3u8
use_cookies="no"
chan_name="KOB4 News Albacurqe NM" ;;
# 724) KPNX Breaking 1
724)
link=https://b_kpnx-f.akamaihd.net/i/KPNXBreaking_1@398330/master.m3u8
use_cookies="no"
chan_name="KPNX Breaking 1" ;;
# 725) KXAN News Austin TX NBC
725)
link=https://api.new.livestream.com/accounts/1506296/events/1569171/live.m3u8
use_cookies="no"
chan_name="KXAN News Austin TX NBC" ;;
# 726) Laurel TV
726)
link=https://crimson.ebmcdn.net/laurel/smil:laurel.smil/chunklist.m3u8
use_cookies="no"
chan_name="Laurel TV" ;;
# 727) Miami TV
727)
link=http://oflash.dfw.swagit.com/live/miamibeachfl/smil:std-16x9-1-a/chunklist_w1459206316_b878000.m3u8
use_cookies="no"
chan_name="Miami TV" ;;
# 728) NBC Bay Area (KNTV-TV)
728)
link=https://kntvlive-f.akamaihd.net/i/kntvb2_1@15530/master.m3u8
use_cookies="no"
chan_name="NBC Bay Area (KNTV-TV)" ;;
# 729) NBC Bay Area Traffic Cam (KNTV-TV)
729)
link=https://kntvlive-f.akamaihd.net/i/kntvb1_1@15530/master.m3u8
use_cookies="no"
chan_name="NBC Bay Area Traffic Cam (KNTV-TV)" ;;
# 730) NBC2 News (KTUU-TV))
730)
link=httpx://api.new.livestream.com/accounts/7987479/events/2929660/live.m3u8
use_cookies="no"
chan_name="NBC2 News (KTUU-TV)" ;;
# 731) News2 (WCBD-TV)
731)
link=https://api.new.livestream.com/accounts/8360295/events/2976321/live.m3u8
use_cookies="no"
chan_name="News2 (WCBD-TV)" ;;
# 732) News4 (WRC-TV)
732)
link=https://wrclive-f.akamaihd.net/i/wrcb1_1@46880/master.m3u8
use_cookies="no"
chan_name="News4 (WRC-TV)" ;;
# 733)News4 White House Cam (WRC-TV)
733)
link=https://wrclive-f.akamaihd.net/i/wrcb2_1@46880/master.m3u8
use_cookies="no"
chan_name="News4 White House Cam (WRC-TV)" ;;
# 734)News5 WCYB
734)
link=https://api.new.livestream.com/accounts/8522497/events/3012727/live.m3u8
use_cookies="no"
chan_name="News5 WCYB" ;;
# 735)NewsWest 9 (KWES)
735)
link=https://api.new.livestream.com/accounts/16923548/events/4681078/live.m3u8
use_cookies="no"
chan_name="NewsWest 9 (KWES)" ;;
# 736)New Orleans TV
736)
link=http://media4.tripsmarter.com:1935/LiveTV/NOTVHD/playlist.m3u8
use_cookies="no"
chan_name="New Orleans TV" ;;
# 737)NBC4 New York News (WNBC-TV)
737)
link=https://wnbclive-f.akamaihd.net/i/wnbca1_1@13992/master.m3u8
use_cookies="no"
chan_name="NBC4 New York News (WNBC-TV)" ;;
# 738) NBC4 New York News (WNBC-TV) alt
738)
link=https://wnbclive-f.akamaihd.net/i/wnbca2_1@13992/master.m3u8
use_cookies="no"
chan_name="NBC4 New York News (WNBC-TV) alt" ;; 
# 739) NBC5 News (WMAQ-TV)
739)
link=https://wmaqlive-f.akamaihd.net/i/wmaqa1_1@22923/master.m3u8
use_cookies="no"
chan_name="NBC5 News (WMAQ-TV)" ;;
# 740) NBC 10 News (KTEN-TV)
740)
link=https://kten-lh.akamaihd.net/i/KTEN_1079@5589/master.m3u8
use_cookies="no"
chan_name="NBC 10 News (KTEN-TV)" ;;
# 741) NBC 12 News (WWBT-TV)
741)
link=https://api.new.livestream.com/accounts/11203782/events/3629264/live.m3u8
use_cookies="no"
chan_name="NBC 12 News (WWBT-TV)" ;;
# 742) NBC 29 (WVIR-TV)
742)
link=http://wvir-lh.akamaihd.net/i/WVIR_736@78303/master.m3u8?forceCacheClearSM=530806100000
use_cookies="no"
chan_name="NBC 29 (WVIR-TV)" ;;
# 743) NBC News Channel 13 (WNYT-TV)
743)
link=https://api.new.livestream.com/accounts/12240447/events/3818578/live.m3u8
use_cookies="no"
chan_name="NBC News Channel 13 (WNYT-TV)" ;;
# 744) NewsChannel 12 KTVZ
744)
link=https://api.new.livestream.com/accounts/19128364/events/5285531/live.m3u8
use_cookies="no"
chan_name="NewsChannel 12 KTVZ" ;;
# 745) NewsWest 9 KWES Washington DC USA
745)
link=https://api.new.livestream.com/accounts/2363281/events/1763520/live.m3u8
use_cookies="no"
chan_name="NewsWest 9 KWES Washington DC USA" ;;
# 746) Orange TV  // works behind tor
746)
link=http://otv3.ocfl.net:1936/OrangeTV/smil:OrangeTV.smil/playlist.m3u8
use_cookies="no"
chan_name="Orange TV" ;;
# 747) PGCPS
747)
link=http://reflect.live.pgcps.cablecast.tv/live/WIFI-696k-360p/WIFI-696k-360p.m3u8
use_cookies="no"
chan_name="PGCPS" ;;
# 748) RyeTV
748)
link=http://oflash.dfw.swagit.com/live/ryeny/smil:std-4x3-1-a/playlist.m3u8
use_cookies="no"
chan_name="RyeTV" ;;
# 749) Seattle Channel
749)
link=https://wowzaprod121-i.akamaihd.net/hls/live/266526/d2ea1f60/playlist.m3u8
use_cookies="no"
chan_name="Seattle Channel" ;;
# 750) Southeastern Channel
750)
link=http://147.174.13.196/live/WIFI-1296k-540p/WIFI-1296k-540p.m3u8
use_cookies="no"
chan_name="Southeastern Channel" ;;
# 751) Temple TV
751)
link=http://streaming.temple.edu/tutvlive/_definst_/mp4:play/chunklist.m3u8
use_cookies="no"
chan_name="Temple TV" ;;
# 752) Town of Vienna Community Network [HQ]
752)
link=https://granicusliveus2-a.akamaihd.net/vienna-va/G1359_003/playlist.m3u8
use_cookies="no"
chan_name="Town of Vienna Community Network [HQ]" ;;
# 753) TSTV
753)
link=http://tstv-stream.tsm.utexas.edu/hls/livestream_hi/index.m3u8
use_cookies="no"
chan_name="TSTV" ;;
# 754) Escambia TV
754)
link=http://58bfeaf58405a.streamlock.net/live/escambiacountyfl/smil:std-4x3-1-a/playlist.m3u8
use_cookies="no"
chan_name="Escambia TV" ;;
# 755) CBS Sports 
755) 
#link=http://cbssportsliveios-i.akamaihd.net/hls/live/200603/cbklive3/master-3500.m3u8
link="https://cbssportsdc-i.akamaihd.net/518856/dc_1/master.m3u8"
use_cookies="no"
chan_name="CBS Sports" ;;
# 756) WYCW Carolinas
756)
link="https://livestream.com/accounts/8366412/live"
use_cookies="no"
chan_name="WYCW Carolinas" ;;
# 757) FOX 10 News 
757)
link="https://livestream.com/accounts/1859803/live"
use_cookies="no"
chan_name="FOX 10 News" ;;


################################################ Live Stream #########################################################
# 761) Karbarla Satellite Channel IRAQ
761)
link="https://livestream.com/accounts/11436227/events/3998452"
use_cookies="no"
chan_name="Karbarla Satellite Channel IRAQ" ;;
# 762) PTN
762)
link="https://livestream.com/accounts/5901056/events/4455330"
use_cookies="no"
chan_name="PTN" ;;
# 763) Obieqtivi TV
763)
link="https://livestream.com/accounts/2064453/events/1886556"
use_cookies="no"
chan_name="Obieqtivi TV" ;;
# 764) Teleantioquia Espanol  Canal de televisión pública del Departamento de Antioquia.
764)
link="https://livestream.com/accounts/9427524/al-aire"
use_cookies="no"
chan_name="Teleantioquia" ;;
# 765) WIPR Puerto Rico
765)
link="https://livestream.com/accounts/16550960/events/8077197"
use_cookies="no"
chan_name="WIPR Puerto Rico" ;;
# 766) 
# 767) AMMAN TV Jordan
767)
link="https://livestream.com/accounts/3320102/events/7612516"
use_cookies="no"
chan_name="AMMAN TV Jordan" ;;
# 768) Safeer TV IRAQ
768)
link="https://livestream.com/accounts/11436227/events/7672592"
use_cookies="no"
chan_name="Safeer TV IRAQ" ;;
# 769) Al Quaran TV
769)
link="https://livestream.com/karbala-tv/events/7492110"
use_cookies="no"
chan_name="Al Quaran TV IRAQ" ;;
# 770) Suryoyo Sat Sweeden
770)
link="https://livestream.com/accounts/10187302/events/6785118"
use_cookies="no"
chan_name="Suryoyo Sat Sweeden" ;;
# 771) Cosmovision TV BO
771)
link="https://livestream.com/accounts/16628908/cosmovisionhd"
use_cookies="no"
chan_name="Cosmovision BO" ;;
# 772) Holiday & Cruise TV
772)
link="https://livestream.com/accounts/22779659/events/6788901"
use_cookies="no"
chan_name="Holiday & Cruise TV" ;;
# 773) Canal Acequia Mendoza AR
773)
link="https://livestream.com/accounts/6450028/events/5813077"
use_cookies="no"
chan_name="Canal Acequia Mendoza AR" ;;
# 774) MNN New York, USA
774)
link="https://livestream.com/accounts/6478976/events/2616018"
use_cookies="no"
chan_name="MNN New York, USA" ;;
# 775) GETV Chinese
775)
link="https://livestream.com/accounts/23191280/events/8122971"
use_cookies="no"
chan_name="GETV Chinese" ;;
# 776) Z1 Televizija Zagreb, Croatia 
776)
link="https://livestream.com/accounts/26764475/events/8122530"
use_cookies="no"
chan_name="Z1 Televizija Zagreb, Croatia " ;;
# 777) Vision Cruise AU
777)
link="https://livestream.com/accounts/22779659/events/8027429"
use_cookies="no"
chan_name="Vision Cruise AU" ;;
# 778) Vision Cruise UK
778)
link="https://livestream.com/accounts/22779659/events/8027222"
use_cookies="no"
chan_name="Vision Cruise UK" ;;
# 779) Smart Lifestyle TV Pheonix AZ USA
779)
link="https://livestream.com/accounts/6553551/events/7989257"
use_cookies="no"
chan_name="Smart Lifestyle TV Pheonix AZ USA" ;;
# 780)
# 781) WHLT USA 
781)
link="https://livestream.com/accounts/8383566/live"
use_cookies="no"
chan_name="WHLT USA" ;;
# 782) Medalhão Persa BR
782)
link="https://livestream.com/accounts/7533066/tvmedalhao"
use_cookies="no"
chan_name="Medalhão Persa BR" ;;
# 783) LRPATV CH25 New Hampshire USA
783)
link="https://livestream.com/accounts/3480937/channel25"
use_cookies="no"
chan_name="LRPATV CH25 New Hampshire USA" ;;
# 784) Santa Fe Media Network New Mexico USA
784)
link="https://livestream.com/accounts/13196214/events/5972197"
use_cookies="no"
chan_name="Santa Fe Media Network New Mexico USA" ;;
# 785) RIDE TV Fort Worth TX USA
785)
link="https://livestream.com/accounts/21743165/events/6446017"
use_cookies="no"
chan_name="RIDE TV Fort Worth TX USA" ;;
# 786) 
# 787) Gem Shopping Network USA
787)
link="https://livestream.com/accounts/3486453/events/7709515"
use_cookies="no"
chan_name="Gem Shopping Network USA" ;;
# 788) Tomix TV Wein AT
788)
link="https://livestream.com/accounts/12156095/events/3802250"
use_cookies="no"
chan_name="Tomix TV Wein AT" ;;
# 789) Radio 21 Nachreichten DE Germany 
789)
link="https://livestream.com/accounts/22300508/events/6675945"
use_cookies="no"
chan_name="Radio 21 Nachreichten DE" ;;
# 790) Rockland Radio TV
790)
link="https://livestream.com/accounts/22300522/events/6680139"
use_cookies="no"
chan_name="Rockland Radio TV" ;;
# 791) 102.3 NOW! TV Edmonton AB,CA
791)
link="https://livestream.com/accounts/4683311/events/3747538"
use_cookies="no"
chan_name="102.3 NOW! TV Edmonton AB,CA" ;;
# 792) La Mega Bogotá 90.9 FM CO
792)
link="https://livestream.com/accounts/13907141/lamegabogota"
use_cookies="no"
chan_name="La Mega Bogotá 90.9 FM CO" ;;
# 793) RTV Posavina TV Zagreb Croatia
793)
link="https://livestream.com/accounts/20748106/events/7596004"
use_cookies="no"
chan_name="RTV Posavina TV Zagreb Croatia" ;;
# 794) skynet MNTV Myanmar
794)
link="https://livestream.com/accounts/7228455/events/3875913"
use_cookies="no"
chan_name=" MNTV Myanmar" ;;
# 795) skynet Buddha Myanmar
795)
link="https://livestream.com/accounts/7228455/events/3875181"
use_cookies="no"
chan_name="Buddha Myanmar" ;;
# 796) skynet Up To Date Myanmar
796)
link="https://livestream.com/accounts/7228455/events/3875178"
use_cookies="no"
chan_name="skynet Up To Date Myanmar" ;;
# 797) skynet HLUTTAW Myanmar
797)
link="https://livestream.com/accounts/7228455/events/4442869"
use_cookies="no"
chan_name="skynet HLUTTAW Myanmar" ;;
# 798) Musig24 TV Switzerland Deutsche
798)
link="https://livestream.com/accounts/16598383/events/6923855"
use_cookies="no"
chan_name="musig24 TV Switzerland Deutsche" ;;
# 799)TourbusTV USA
799)
link="https://livestream.com/accounts/22843174/TourbusTV"
use_cookies="no"
chan_name="TourbusTV USA" ;;
# 800)Talenu TV TPA Online Portuguese
800)
link="https://livestream.com/accounts/1181452/events/5141181"
use_cookies="no"
chan_name="Talenu TV TPA Luanda Angola" ;;
# 801)ONE Malta MT
801)
link="https://livestream.com/accounts/18398100/ONELive"
use_cookies="no"
chan_name="ONE Malta MT" ;;
# 802)TV Miramar Mozambique Portuguese
802)
link="https://livestream.com/accounts/21076186/events/6180705"
use_cookies="no"
chan_name="TV Miramar Mozambique Portuguese" ;;
# 803)TV Zimbo Online Angola Portuguese
803)
link="https://livestream.com/accounts/19766999/events/5548210"
use_cookies="no"
chan_name="TV Zimbo Online Angola Portuguese" ;;
# 804)TV5 Argentina
804)
link="https://livestream.com/accounts/20819504/events/6036256"
use_cookies="no"
chan_name="TV5 Argentina" ;;
# 805)TV UNAM MX
805)
link="https://livestream.com/accounts/27177136/events/8157904"
use_cookies="no"
chan_name="TV UNAM MX" ;;
# 806)Ezekiel TV Channel
806)
link="https://livestream.com/accounts/19491040/events/6866917"
use_cookies="no"
chan_name="Ezekiel TV" ;;
# 807)Rede Super Belo Horizonte BR
807)
link="https://livestream.com/accounts/10205943/events/3429501"
use_cookies="no"
chan_name="Rede Super Belo Horizonte BR" ;;
# 808)KVZK TV CHANNEL 2 American SAMOA
808)
link="https://livestream.com/accounts/8956070/events/4561731"
use_cookies="no"
chan_name="KVZK TV CHANNEL 2 American SAMOA" ;;
# 809)Canal Telecafé CO
809)
link="https://livestream.com/accounts/1015476/events/7158511"
use_cookies="no"
chan_name="Canal Telecafé CO" ;;
# 810)Fiji One
810)
link="https://livestream.com/accounts/19514369/fijitvstream"
use_cookies="no"
chan_name="Fiji One" ;;
# 811)SescTV HD Sao Paulo BR
811)
link="https://livestream.com/accounts/16991778/NoAr"
use_cookies="no"
chan_name="SescTV HD Sao Paulo BR" ;;
# 812) MNN Channel 5 New York USA
812)
link="https://livestream.com/accounts/17251372/events/4846282"
use_cookies="no"
chan_name=" MNN Channel 5 New York USA" ;;
# 813)
# 814) EsteCanal TV 
814)
link="https://livestream.com/accounts/8817409/events/7051352"
use_cookies="no"
chan_name="EsteCanal TV" ;;
# 815) Italia channel
815)
link="https://livestream.com/accounts/277367/events/7379093"
use_cookies="no"
chan_name="Italia channel" ;;
# 816) Native Media Network Sante Fe New Mexico USA
816)
link="https://livestream.com/accounts/13196214/events/3994033"
use_cookies="no"
chan_name="Native Media Network Sante Fe New Mexico USA" ;;
# 817) Mediaon BergamoTV Italian
817)
link="https://livestream.com/accounts/245066/events/3063596"
use_cookies="no"
chan_name="Mediaon BergamoTV Italian" ;;
# 818) Lake Tahoe TV
818)
link="https://livestream.com/accounts/21822229/events/6450069"
use_cookies="no"
chan_name="Lake Tahoe TV" ;;
# 819) Cinevision Canal 19 Dominican Republic 
819)
link="https://livestream.com/accounts/9430235/canal19"
use_cookies="no"
chan_name="Cinevision Canal 19 Dominican Republic" ;;
# 820) Wisconsin Public Television The Wisconsin Channel
820)
link="https://livestream.com/accounts/13897710/events/4153577"
use_cookies="no"
chan_name="Cinevision Canal 19 Dominican Republic" ;;
# 821) Emmanuel TV
821)
link="https://livestream.com/accounts/23202872/events/7200883"
use_cookies="no"
chan_name="Emmanuel TV" ;;
# 822) Shalom World Australia
822)
link="https://livestream.com/accounts/25038049/events/7551704"
use_cookies="no"
chan_name="Shalom World Australia" ;;
# 823) WDIO Duluth Minnesota
823)
link="https://livestream.com/accounts/12241516/live"
use_cookies="no"
chan_name="WDIO Duluth Minnesota" ;;
# 824) KHNL Honolulu Hawaii News Now
824)
link="https://livestream.com/accounts/12139043/live"
use_cookies="no"
chan_name="KHNL Honolulu Hawaii News Now" ;;
# 825) news24.city Italy
825)
link="https://livestream.com/accounts/16586959/events/7803832"
use_cookies="no"
chan_name="news24.city Italy" ;;
# 826) WBNS Columbus OHIO USA
826)
link="https://livestream.com/accounts/18624165/live"
use_cookies="no"
chan_name="WBNS Columbus OHIO USA" ;;
# 827) WTTG Washington DC Fox 5 Washington DC USA
827)
link="https://livestream.com/accounts/2363281/live"
use_cookies="no"
chan_name="WTTG Washington DC Fox 5 Washington DC USA" ;;
# 828) WJBK FOX 2 Detroit Michigan USA 
828)
link="https://livestream.com/accounts/6396566/live"
use_cookies="no"
chan_name="WJBK FOX 2 Detroit Michigan USA" ;;
# 829) KSL NOW Salt Lake City Utah USA 
829)
link="https://livestream.com/accounts/22711876/live"
use_cookies="no"
chan_name="KSL NOW Salt Lake City Utah USA " ;;
# 830)  KSLA News 12 Shreveport Louisiana USA 
830)
link="https://livestream.com/KSLA/live"
use_cookies="no"
chan_name="KSLA News 12 Shreveport Louisianna USA  " ;;
# 831)  WSFA 12 Montgomory Alabama USA 
831)
link="https://livestream.com/accounts/11981705/live"
use_cookies="no"
chan_name="WSFA 12 Montgomory Alabama USA" ;;
# 832)  Fox 8 Cleveland Ohio USA 
832)
link="https://livestream.com/accounts/57501/live"
use_cookies="no"
chan_name="Fox 8 Cleveland Ohio USA" ;;
# 833) KELO Live Keloland USA 
833)
link="https://livestream.com/kelo/live"
use_cookies="no"
chan_name="KELO Live Keloland USA" ;;
# 834)HU16 Harding Sercy Arkansas  USA
834)
link="https://livestream.com/accounts/8522446/live"
use_cookies="no"
chan_name="HU16 Harding Sercy Arkansas  USA" ;;
# 835) KTVK 3TV Arizona USA
835)
link="https://livestream.com/accounts/12643960/live"
use_cookies="no"
chan_name="KTVK 3TV Arizona USA" ;;
# 836) FOX 26 News Houston USA
836)
link="https://livestream.com/accounts/6396012/live"
use_cookies="no"
chan_name="FOX 26 News Houston USA" ;;
# 837) WAFB 9 CBSN Baton Rouge Louisiana USA
837)
link="https://livestream.com/accounts/11595706/live"
use_cookies="no"
chan_name="WAFB 9 CBSN Baton Rouge Louisiana USA" ;;
# 838) WCSC Charleston South Carolina USA
838)
link="https://livestream.com/accounts/11016888/live"
use_cookies="no"
chan_name="WCSC Charleston South Carolina USA" ;;
# 839) WTXF FOX 29 News Philadelphia USA
839)
link="https://livestream.com/accounts/6370754/live"
use_cookies="no"
chan_name="WTXF FOX 29 News Philadelphia USA" ;;
# 840) WFLA NBC 8 Tampa Bay Florida USA
840)
link="https://livestream.com/accounts/6140981/live"
use_cookies="no"
chan_name="WFLA NBC 8 Tampa Bay Florida USA" ;;

#############################################     MENU 4      #################################################################
# 841)  WFIE NBC 14 USA
841)
link="https://livestream.com/accounts/11981465/live"
use_cookies="no"
chan_name="WFIE NBC 14 USA" ;;
# 842)  KOIN CBS 6 Portland Oregon USA
842)
link="https://livestream.com/accounts/1864610/live"
use_cookies="no"
chan_name="KOIN CBS 6 Portland Oregon USA" ;;
# 843)  WTVT / FOX 13 Tampa Bay USA
843)
link="https://livestream.com/accounts/6180769/live"
use_cookies="no"
chan_name="WTVT / FOX 13 Tampa Bay USA" ;;
# 844)  KUSI 24/7 San Diego California USA
844)
link="https://livestream.com/accounts/25082096/live"
use_cookies="no"
chan_name="KUSI 24/7 San Diego California USA" ;;
# 845)  Canal 2 Argentina
845)
link="https://livestream.com/accounts/679322/Canal2Jujuy"
use_cookies="no"
chan_name="Canal 2 Argentina" ;;
# 846)  Joe Pags Show
846)
link="https://livestream.com/accounts/26896512/events/8077273"
use_cookies="no"
chan_name="Joe Pags Show" ;;
# 847)  WBRC FOX6 News Mobil USA
847)
link="https://livestream.com/WBRC/live"
use_cookies="no"
chan_name="WBRC FOX6 News Mobil USA" ;;
# 848)  WNYW Fox 5 New York USA
848)
link="https://livestream.com/accounts/6372917/live"
use_cookies="no"
chan_name="WNYW Fox 5 New York USA" ;;
# 849) KMOV 4 St. Louis MO USA
849)
link="https://livestream.com/accounts/12654794/live"
use_cookies="no"
chan_name="KMOV 4 St. Louis MO USA" ;;
# 850) WFLD / Fox 32 Chicago USA
850)
link="https://livestream.com/accounts/6370732/live"
use_cookies="no"
chan_name="WFLD / Fox 32 Chicago USA" ;;
# 851) KHSL Action News NOW KHSL Live USA
851)
link="https://livestream.com/accounts/26511688/live"
use_cookies="no"
chan_name="KHSL Action News NOW KHSL Live USA" ;;
# 852) WVUE FOX 8 Batton Rouge LA USA
852)
link="https://livestream.com/accounts/10891792/live"
use_cookies="no"
chan_name=" WVUE FOX 8 Batton Rouge LA USA" ;;
# 853) KLTV 7 Tyler TX USA
853)
link="https://livestream.com/accounts/11816721/live"
use_cookies="no"
chan_name="KLTV 7 Tyler TX USA" ;;
# 854) K24 Nairobi Kenya
854)
link="https://livestream.com/accounts/17606245/events/4832042"
use_cookies="no"
chan_name="K24 Nairobi Kenya" ;;
# 855) KEYT ABC 3 Santa Barbara CA USA
855)
link="https://livestream.com/accounts/19285506/live"
use_cookies="no"
chan_name="KEYT ABC 3 Santa Barbara CA USA" ;;
# 856) ET Today Taiwan
856)
link="https://livestream.com/ETtoday/events/8184871"
use_cookies="no"
chan_name="ET Today Taiwan" ;;
# 857) WAKA CBS 8 ABC 32 ALABAMA 
857)
link="https://livestream.com/accounts/9486828/live"
use_cookies="no"
chan_name="WAKA CBS 8 ABC 32 ALABAMA " ;;
# 858) WJZY FOX 46 Charlotte NC
858)
link="https://livestream.com/accounts/6370805/live"
use_cookies="no"
chan_name="WJZY FOX 46 Charlotte NC" ;;
# 859) WCCB Charlotte CW NC
859)
link="https://livestream.com/accounts/8522553/live"
use_cookies="no"
chan_name="WCCB Charlotte CW NC" ;;
# 860) WCYB NBC 5 VA
860)
link="https://livestream.com/accounts/8522497/live"
use_cookies="no"
chan_name="WCYB NBC 5 VA" ;;
# 861) WYCW CW 62 Carolinas
861)
link="https://livestream.com/accounts/8366412/live"
use_cookies="no"
chan_name="WYCW CW 62 Carolinas" ;;
# 862) WNCT CBS 9 Greenville NC
862)
link="https://livestream.com/accounts/7601533/live"
use_cookies="no"
chan_name="WNCT CBS 9 Greenville NC" ;;
# 863) WJBF Augusta Georgia 
863)
link="https://livestream.com/accounts/7601347/live"
use_cookies="no"
chan_name="WJBF Augusta Georgia" ;;
# 864) KLFY News 10 Acadiana
864)
link="https://livestream.com/accounts/7520488/live"
use_cookies="no"
chan_name="KLFY News 10 Acadiana" ;;
# 865)
# 866) MNN Channel 1
866)
link="https://livestream.com/accounts/6480540/events/2616259"
use_cookies="no"
chan_name="MNN Channel 1" ;;
# 867) MNN Channel 4
867)
link="https://livestream.com/accounts/6478935/events/2616010"
use_cookies="no"
chan_name="MNN Channel 4" ;;
# 868) WWOR Secaucus
868)
link="https://livestream.com/accounts/6372957/live"
use_cookies="no"
chan_name="WWOR Secaucus" ;;
# 869) KSNT Weather Wichita Kansas
869)
link="https://livestream.com/accounts/1866369/live"
use_cookies="no"
chan_name="KSNT Weather Wichita Kansas" ;;
# 870) WANE Ft. Wayne Indiana
870)
link="https://livestream.com/accounts/1849716/live"
use_cookies="no"
chan_name="WANE Ft. Wayne Indiana" ;;
# 871) KTXS 12 ABC Abilene Texas 
871)
link="https://livestream.com/accounts/9960439/live"
use_cookies="no"
chan_name="KTXS 12 ABC Abilene TX" ;;
# 872) Island TV Live Broadcast Miami FL USA
872)
link="https://livestream.com/accounts/1420/Islandtvlive"
use_cookies="no"
chan_name="Island TV Live Broadcast Miami FL USA" ;;
# 873) KSNT Kansas OK USA
873)
link="https://livestream.com/accounts/1866369/live"
use_cookies="no"
chan_name="KSNT Kansas OK USA" ;;
# 874) Emisora Virtual Onda Libre Cali CO 
874)
link="https://livestream.com/accounts/2541970/events/5178171"
use_cookies="no"
chan_name="Emisora Virtual Onda Libre Cali CO " ;;
# 875) TV MONARCA Ciudad Hidalgo, Michoacán, Mexico
875)
link="https://livestream.com/accounts/17594956/events/5033533"
use_cookies="no"
chan_name="TV MONARCA Ciudad Hidalgo, Michoacán, Mexico" ;;
# 876) KMIZ ABC 17 Missouri
876)
link="https://livestream.com/accounts/18240993/live"
use_cookies="no"
chan_name="KMIZ ABC 17 Missouri" ;;
# 877) KFDA CBS 10 Amarillo TX USA
877)
link="https://livestream.com/accounts/17606146/live"
use_cookies="no"
chan_name="KFDA CBS 10 Amarillo TX USA" ;;
# 878) KZTV CBS 10 Corpus Christi TX USA 
878)
link="https://livestream.com/accounts/16030806/live"
use_cookies="no"
chan_name="KZTV CBS 10 Corpus Christi TX USA" ;;
# 879) City of Tampa Television FL, USA
879)
link="https://livestream.com/accounts/12251681/CTTV"
use_cookies="no"
chan_name="City of Tampa Television FL, USA" ;;
# 880)WMGT 41 NBC Macon Georgia USA
880)
link="https://livestream.com/accounts/15227391/live"
use_cookies="no"
chan_name="WMGT 41 NBC Macon Georgia USA" ;;
# 881) YTV America Live Korean LA CA USA
881)
link="https://livestream.com/accounts/15217951/events/4355473"
use_cookies="no"
chan_name="YTV America Live Korean LA CA USA" ;;
# 882) Polk County Channel 44 Bolivar Missouri USA
882)
link="https://livestream.com/accounts/15079831/Channel44"
use_cookies="no"
chan_name="Polk County Channel 44 Bolivar Missouri USA" ;;
# 883) WAND NBC 17 Decatur Illinois
883)
link="https://livestream.com/accounts/15004678/live"
use_cookies="no"
chan_name="WAND NBC 17 Decatur Illinois" ;;
# 884) KOAA NBC 5 Colorado Springs Colorado, USA
884)
link="https://livestream.com/accounts/13725886/live"
use_cookies="no"
chan_name="KOAA NBC 5 Colorado Springs Colorado, USA" ;;
# 885) Enid Television Network Oklahoma
885)
link="https://livestream.com/accounts/13638122/events/4063586"
use_cookies="no"
chan_name="Enid Television Network Oklahoma" ;;
# 886) ThinkTech Hawaii Honolulu USA
886)
link="https://livestream.com/accounts/12650986/events/3950350"
use_cookies="no"
chan_name="ThinkTech Hawaii Honolulu USA" ;;
# 887) WFLX FOX 29
887)
link="https://livestream.com/accounts/12755354/live"
use_cookies="no"
chan_name="WFLX FOX 29" ;;
# 888) WPS-TV Wichita Public Schools
888)
link="https://livestream.com/accounts/12013978/events/3835724"
use_cookies="no"
chan_name="WPS-TV Wichita Public Schools" ;;
# 889) BelqeesTV Yemen
889)
link="https://livestream.com/accounts/12233888/events/3819374"
use_cookies="no"
chan_name="BelqeesTV Yemen" ;;
# 890) KAAL ABC 6 Rochester Minnesota
890)
link="https://livestream.com/accounts/12240964/live"
use_cookies="no"
chan_name="KAAL ABC 6 Rochester Minnesota" ;;
# 891) KRCR ABC 7 Redding California USA
891)
link="https://livestream.com/accounts/10262876/events/3724366"
use_cookies="no"
chan_name="KRCR ABC 7 Redding California USA" ;;
# 892) KION CBS 5/46 Salinas California USA
892)
link="https://livestream.com/accounts/19128738/events/7300156"
use_cookies="no"
chan_name="KION CBS 5/46 Salinas California USA" ;;
# 893) KMVP 24/7 Phoenix Arizona Sports 98.7 FM 
893)
link="https://livestream.com/accounts/24089066/live"
use_cookies="no"
chan_name="KMVP 24/7 Phoenix Arizona Sports 98.7 FM " ;;
# 894) KTAR News Phoenix Arizona 
894)
link="https://livestream.com/accounts/24088937/live"
use_cookies="no"
chan_name="KTAR News Phoenix Arizona " ;;
# 895) Yuma Virtual TV Barrancabermeja CO
895)
link="https://livestream.com/accounts/17972814/events/6311476"
use_cookies="no"
chan_name="Yuma Virtual TV Barrancabermeja CO" ;;
# 896) WPSD-TV Paducah Kentucky 
896)
link="https://livestream.com/accounts/21317942/live"
use_cookies="no"
chan_name="WPSD-TV Paducah Kentucky" ;;
# 897) KVRR Fargo North Dakota  
897)
link="https://livestream.com/accounts/21298478/live"
use_cookies="no"
chan_name="KVRR Fargo North Dakota" ;;
# 898) KDLT Sioux Falls South Dakota
898)
link="https://livestream.com/accounts/21277277/live"
use_cookies="no"
chan_name="KDLT Sioux Falls South Dakota" ;;
# 899) GovTV Watertown, South Dakota
899)
link="https://livestream.com/accounts/21042766/events/6254925"
use_cookies="no"
chan_name="GovTV Watertown, South Dakota" ;;
# 900) KFDX NBC 3 Witchita Falls USA
900)
link="https://livestream.com/accounts/21184359/live"
use_cookies="no"
chan_name="KFDX NBC 3 Witchita Falls USA" ;;
# 901) Galveston County Gulf Freeway Cams Tour Houston Texas USA 
901)
link="https://livestream.com/accounts/21068106/events/6228235"
use_cookies="no"
chan_name="Galveston County Gulf Freeway Cams Tour Houston Texas USA" ;;
# 902) KQDS - FOX 21 Duluth Minnesota USA 
902)
link="https://livestream.com/accounts/21146230/live"
use_cookies="no"
chan_name="KQDS - FOX 21 Duluth Minnesota USA " ;;
# 903) KOLR CBS 10 Springfield Missouri
903)
link="https://livestream.com/accounts/21145355/live"
use_cookies="no"
chan_name="KOLR CBS 10 Springfield Missouri" ;;
# 904) WROC CBS 8 Rochester NY USA
904)
link="https://livestream.com/accounts/21078314/live"
use_cookies="no"
chan_name="WROC CBS 8 Rochester NY USA" ;;
# 905)WBRE NBC Wilkes Barre Pennslyvannia USA
905)
link="https://livestream.com/accounts/21077947/live"
use_cookies="no"
chan_name="WBRE NBC Wilkes Barre Pennslyvannia USA" ;;
# 906) Cumulus NYC 77 WABC New York USA
906)
link="https://livestream.com/cumulusnyc/live"
use_cookies="no"
chan_name="Cumulus NYC 77 WABC New York USA" ;;
# 907) WTVQ ABC 36 Lexington Kentucky USA
907)
link="https://livestream.com/accounts/19871819/live"
use_cookies="no"
chan_name="WTVQ ABC 36 Lexington Kentucky USA" ;;
# 908) Dominio Radio: En Vivo Mexico
908)
link="https://livestream.com/accounts/26841641/events/8163521"
use_cookies="no"
chan_name="Dominio Radio: En Vivo Mexico" ;;
# 909) TV RAIAR
909)
link="https://livestream.com/accounts/26069467/tv-raiar"
use_cookies="no"
chan_name="TV RAIAR" ;;
# 910) WFFT FOX 55 Indiana USA
910)
link="https://livestream.com/accounts/26511747/live"
use_cookies="no"
chan_name="WFFT FOX 55 Indiana USA" ;;
# 911) WAAY News ABC 31 Huntsville Alabama
911)
link="https://livestream.com/accounts/26511741/live"
use_cookies="no"
chan_name="WAAY News ABC 31 Huntsville Alabama" ;;
# 912) 50 News Versilia Viareggio Italy  
912)
link="https://livestream.com/accounts/25529830/events/7893732"
use_cookies="no"
chan_name="50 News Versilia Viareggio Italy" ;;
# 913) Iberia TV Live Georgia 
913)
link="https://livestream.com/accounts/19735751/events/7830877"
use_cookies="no"
chan_name="Iberia TV Georgia" ;;
# 914) 50 Canale Pisa Italy 
914)
link="https://livestream.com/accounts/19968830/events/7801416"
use_cookies="no"
chan_name="50 Canale Pisa Italy" ;;
# 915) St. Petersburg College SPC-TV 
915)
link="https://livestream.com/accounts/15226456/events/7703617"
use_cookies="no"
chan_name="St. Petersburg College SPC-TV " ;;
# 916) Señal UNTREF
916)
link="https://livestream.com/accounts/16129323/events/7659666"
use_cookies="no"
chan_name="Señal UNTREF" ;;
# 917) WWTV 9 & 10 News 24/7 Mt. Pleasent Michigan  
917)
link="https://livestream.com/accounts/25637691/live"
use_cookies="no"
chan_name="WWTV 9 & 10 News 24/7 Mt. Pleasent Michigan" ;;
# 918) WPHL TV ABC 6 Philladelphia
918)
link="https://livestream.com/accounts/25565610/live"
use_cookies="no"
chan_name="WPHL TV ABC 6 Philladelphia" ;;
# 919) WCCB Charlotte's CW NC
919)
link="https://livestream.com/accounts/8522553/live"
use_cookies="no"
chan_name=" WCCB Charlotte's CW NC" ;;
# 920) WCBD NBC 2 Charleston North Carolina 
920)
link="https://livestream.com/accounts/8360295/live"
use_cookies="no"
chan_name="WCBD NBC 2 Charleston NC" ;;
# 921) WSAV NBC 3 Savannah, Georgia
921)
link="https://livestream.com/accounts/7682273/live"
use_cookies="no"
chan_name="WSAV NBC 3 Savannah, Georgia" ;;
# 922) WSPA CBS 7 WSPA Spartanberg SC
922)
link="https://livestream.com/accounts/7592531/live"
use_cookies="no"
chan_name="WSPA CBS 7 WSPA Spartanberg SC" ;;
# 923) WCMH NBC 4 Columbus Ohio
923)
link="https://livestream.com/accounts/7338206/live"
use_cookies="no"
chan_name="WCMH NBC 4 Columbus Ohio" ;;
# 924) CBS 17 Rahliegh NC
924)
link="https://livestream.com/accounts/7158447/live"
use_cookies="no"
chan_name="CBS 17 Rahliegh NC" ;;
# 925) NewsChannel5+ Las Vegas, Nevada
925)
link="https://livestream.com/accounts/3827561/live"
use_cookies="no"
chan_name="NewsChannel5+ Las Vegas, Nevada" ;;
# 926) KSNW NBC 3 Witchita Kansas
926)
link="https://livestream.com/accounts/1866980/live"
use_cookies="no"
chan_name="KSNW NBC 3 Witchita Kansas" ;;
# 927) WPRI Fox 12 Providence New England 
927)
link="https://livestream.com/accounts/1864876/live"
use_cookies="no"
chan_name="WPRI Fox 12 Providence New England" ;;
# 928) WWAY News ABC CBS CW 3 Cape Fear Willmington NC 
928)
link="https://livestream.com/accounts/26965546/live"
use_cookies="no"
chan_name="WWAY News ABC CBS CW 3 Cape Fear Willmington NC" ;;
# 929) Atlanta Radio Korea AM790
929)
link="https://livestream.com/accounts/19465449/events/6357808"
use_cookies="no"
chan_name="Atlanta Radio Korea AM790" ;;
# 930) OsjeckaTV Zagreb Croatia 
930)
link="https://livestream.com/accounts/20748093/events/6049691"
use_cookies="no"
chan_name="OsjeckaTV Zagreb Croatia " ;;
# 931) KIFI ABC 8 Idaho Falls Idaho 
931)
link="https://livestream.com/accounts/18796284/Live"
use_cookies="no"
chan_name="KIFI ABC 8 Idaho Falls Idaho " ;;
# 932) News-Press NOW Fox 26 KNPN Saint Joseph Missouri 
932)
link="https://livestream.com/accounts/18241682/live"
use_cookies="no"
chan_name="News-Press NOW Fox 26 KNPN Saint Joseph Missouri" ;;
# 933)KAUZ CBS 6 Winters Texas 
933)
link="https://livestream.com/accounts/16991125/live"
use_cookies="no"
chan_name="KAUZ CBS 6 Winters Texas" ;;
# 934) KXXV ABC 25 Waco Texas 
934)
link="https://livestream.com/accounts/16936343/live"
use_cookies="no"
chan_name="KXXV ABC 25 Waco Texas" ;;
# 935) KATC Lafayette ABC 3 Louisiana 
935)
link="https://livestream.com/accounts/15228189/live"
use_cookies="no"
chan_name="KATC Lafayette ABC 3 Louisiana" ;;
# 936) WFLD Fox 32 Chicago IL
936)
link="https://livestream.com/accounts/6370732/events/4249677"
use_cookies="no"
chan_name="WFLD Fox 32 Chicago IL" ;;
# 937) KPLC NBC 7 Lake Charles Louisiana  
937)
link="https://livestream.com/accounts/11595658/live"
use_cookies="no"
chan_name="KPLC NBC 7 Lake Charles Louisiana" ;;
# 938) KOIN 6 Extras Portland Oregon
938)
link="https://livestream.com/accounts/1864610/events/3314050"
use_cookies="no"
chan_name="KOIN 6 Extras Portland Oregon" ;;
# 939) WCCB Charlotte's CW NC
939)
link="https://livestream.com/accounts/8522553/live"
use_cookies="no"
chan_name="WCCB Charlotte's CW NC" ;;
# 940) WDAM 7 Hattiesburg Mississippi USA
940)
link="https://livestream.com/accounts/11595552/live"
use_cookies="no"
chan_name="WDAM 7 Hattiesburg Mississippi USA" ;;
# 941) WLOX ABC 13  Mississippi USA
941)
link="https://livestream.com/accounts/11595500/live"
use_cookies="no"
chan_name="WLOX ABC 13  Mississippi USA" ;;
# 942) WTVM ABC 9 Columbus Georgia 
942)
link="https://livestream.com/accounts/11379799/live"
use_cookies="no"
chan_name="WTVM ABC 9 Columbus Georgia " ;;
# 943) SISTEMA MEIO NORTE DE COMUNICAÇÃO TV MEIO Teresina Brasil
943)
link="https://livestream.com/accounts/3332377/tvmeionortehd"
use_cookies="no"
chan_name="TV MEIO Teresina Brasil" ;;
# 944) WRBL News 365 CBS 3 Columbus, GA.  
944)
link="https://livestream.com/accounts/7942874/live"
use_cookies="no"
chan_name="WRBL News 365 CBS 3 Columbus, GA" ;;
# 945) WJHL CBS 11 Johnson City, New York 
945)
link="https://livestream.com/accounts/7264167/live"
use_cookies="no"
chan_name="WJHL CBS 11 Johnson City, New York" ;;
# 946) KCTV CBS 5 Kansas City Missouri  
946)
link="https://livestream.com/accounts/6370696/live"
use_cookies="no"
chan_name="KCTV CBS 5 Kansas City Missouri" ;;
# 947) WTHI 10 Terre Haute Indiana
947)
link="https://livestream.com/accounts/1866274/live"
use_cookies="no"
chan_name="WTHI 10 Terre Haute Indiana" ;;
# 948)WBBJ ABC 7 West Tennesee 
948)
link="https://livestream.com/accounts/27132443/live"
use_cookies="no"
chan_name="WBBJ ABC 7 West Tennesee" ;;
# 949) KTVZ 21 Bend Oregon 
949)
link="https://livestream.com/accounts/19128364/Live"
use_cookies="no"
chan_name="KTVZ 21 Bend Oregon" ;;
# 950) Nuevolaredo.tv Flujo de Puentes Internacionales nuevo laredo MX
950)
link="https://livestream.com/accounts/13480210/events/4837379"
use_cookies="no"
chan_name="Neuvo Larado TV MX" ;;
# 951) Sinart Digital Señal Canal 13 CR 
951)
link="https://livestream.com/accounts/1532727/events/8158158"
use_cookies="no"
chan_name="Sinart Digital Señal Canal 13 CR " ;;
# 952) KEZI ABC 9 Eugene, Oregon
952)
link="https://livestream.com/accounts/26511759/live"
use_cookies="no"
chan_name="KEZI ABC 9 Eugene, Oregon" ;;
# 953) news24.city Milan Italy 
953)
link="https://livestream.com/accounts/16586959/events/7803832"
use_cookies="no"
chan_name="news24.city Milan Italy " ;;
# 954) WDEF News CBS 12 Now Chattanooga Tennessee
954)
link="https://livestream.com/accounts/21596942/live"
use_cookies="no"
chan_name="WDEF News CBS 12 Now Chattanooga Tennesse " ;;
# 955) KCOY CBS 12 Santa Maria California USA 
955)
link="https://livestream.com/accounts/19128628/live"
use_cookies="no"
chan_name="KCOY CBS 12 Santa Maria California USA" ;;
# 956) WTOL CBS 11 Toledo Ohio 
956)
link="https://livestream.com/accounts/12003465/live"
use_cookies="no"
chan_name="WTOL CBS 11 Toledo Ohio" ;;
# 957) WIS NBC 10 Columbia South Carolina 
957)
link="https://livestream.com/accounts/11327981/live"
use_cookies="no"
chan_name="WIS NBC 10 Columbia South Carolina" ;;
# 958) WMC NBC 5 Memphis Tennessee 
958)
link="https://livestream.com/accounts/10894063/live"
use_cookies="no"
chan_name="WMC NBC 5 Memphis Tennessee" ;;
# 959) HTV10 Houma Louisiana 
959)
link="https://livestream.com/accounts/1362675/events/3147474"
use_cookies="no"
chan_name="HTV10 Houma Louisiana" ;;
# 960) WRIC ABC 8 Petersburg, Virginia
960)
link="https://livestream.com/accounts/7425298/live"
use_cookies="no"
chan_name="WRIC ABC 8 Petersburg, Virginia" ;;
# 961) Western Mass News Chicopee Massachusetts
961)
link="https://livestream.com/accounts/6140816/live"
use_cookies="no"
chan_name="Western Mass News Chicopee Massachusetts" ;;
# 962) KIMT 3 Mason City, Iowa
962)
link="https://livestream.com/accounts/1859647/live"
use_cookies="no"
chan_name="KIMT 3 Mason City, Iowa" ;;
# 963)KXAN NBC Austin Texas
963)
link="https://livestream.com/accounts/1506296/live"
use_cookies="no"
chan_name="KXAN NBC Austin Texas" ;;
# 964) WKRG CBS 5 Mobile, Alabama
964)
link="https://livestream.com/accounts/7546695/live"
use_cookies="no"
chan_name="WKRG CBS 5 Mobile, Alabama" ;;
# 965) Lex 18 Lexington Kentucky
965)
link="https://livestream.com/accounts/1493287/live"
use_cookies="no"
chan_name="Lex 18 Lexington Kentucky" ;;
# 966) WBNS 10 Breaking News Radar Columbus, Ohio
966)
link="https://livestream.com/accounts/26237278/events/8075621"
use_cookies="no"
chan_name="WBNS 10 Breaking News Radar Columbus, Ohio " ;;
# 967) WBNS 10 Breaking News Columbus, Ohio
967)
link="https://livestream.com/WBNSbreakingnews/live"
use_cookies="no"
chan_name="WBNS 10 Breaking News Columbus, Ohio " ;;
# 968) KYMA NBC 11 Yuma Arizona 
968)
link="https://livestream.com/accounts/20242841/live"
use_cookies="no"
chan_name="KYMA NBC 11 Yuma Arizona" ;;
# 969) WOIO CBS 19 Clevland Ohio 
969)
link="https://livestream.com/accounts/11017897/live"
use_cookies="no"
chan_name="WOIO CBS 19 Clevland Ohio" ;;
# 970) KESQ ABC 3 FOX 11 Palm Springs, California
970)
link="https://livestream.com/accounts/20847880/live"
use_cookies="no"
chan_name="KESQ ABC 3 FOX 11 Palm Springs, California" ;;
# 971) KRDO ABC 13 Colorado Springs Colorado 
971)
link="https://livestream.com/accounts/17592934/live"
use_cookies="no"
chan_name="KRDO ABC 13 Colorado Springs Colorado" ;;
# 972) Al-Fallujah Tv Channel IRAQ
972)
link="https://livestream.com/accounts/4671269/falluajh"
use_cookies="no"
chan_name="Al-Fallujah Tv Channel IRAQ" ;;
# 973) WFMZ 69 Allen Town Pennslyvania 
973)
link="https://livestream.com/accounts/14384745/live"
use_cookies="no"
chan_name="WFMZ 69 Allen Town Pennslyvania" ;;
# 974) WTOC 11 Savannah, Georgia
974)
link="https://livestream.com/accounts/11006691/live"
use_cookies="no"
chan_name="WTOC 11 Savannah, Georgia" ;;
# 975) WGCL CBS46 Atlanta Georgia
975)
link="https://livestream.com/accounts/6140931/live"
use_cookies="no"
chan_name="WGCL CBS46 Atlanta Georgia" ;;
# 976) KQTV 2 St. Joseph, Missouri
976)
link="https://livestream.com/accounts/26511737/live"
use_cookies="no"
chan_name="KQTV 2 St. Joseph, Missouri" ;;
# 977) CGTN America Live
977)
link="https://livestream.com/accounts/7082210/livenews"
use_cookies="no"
chan_name="CGTN America Live" ;;
# 978) KVIA ABC-7 El Paso Texas 
978)
link="https://livestream.com/accounts/18241891/live"
use_cookies="no"
chan_name="KVIA ABC-7 El Paso Texas" ;;
# 979)  KCBD NBC 11 Lubbock, Texas
979)
link="https://livestream.com/accounts/11816946/live"
use_cookies="no"
chan_name="KCBD NBC 11 Lubbock, Texas" ;;
# 980) WALB NBC 10 Albany Southwestern Georgia
980)
link="https://livestream.com/accounts/11279058/live"
use_cookies="no"
chan_name="WALB NBC 10 Albany Southwestern Georgia" ;;
# 981) KFVE 9 Honolulu Hawaii
981)
link="https://livestream.com/accounts/14598737/live"
use_cookies="no"
chan_name="KFVE Honolulu Hawaii" ;;
# 982) WWBT NBC 12 Richmond Virginia 
982)
link="https://livestream.com/accounts/11203782/live"
use_cookies="no"
chan_name="WWBT NBC 12 Richmond Virginia" ;;
# 983) WJTV CBS 12 Jackson Mississippi
983)
link="https://livestream.com/accounts/8374496/live"
use_cookies="no"
chan_name="WJTV CBS 12 Jackson Mississippi" ;;
# 984) WWLP 22 Springfield Massachusetts
984)
link="https://livestream.com/accounts/1866220/live"
use_cookies="no"
chan_name="WWLP 22 Springfield Massachusetts" ;;
# 985) CBS 42 Birmingham Alabama 
985)
link="https://livestream.com/accounts/1848160/live"
use_cookies="no"
chan_name="CBS 42 Birmingham Alabama" ;;
# 986) WNYT NBC 13 Upper Sandusky, Ohio
986)
link="https://livestream.com/accounts/12240447/live"
use_cookies="no"
chan_name="WNYT NBC 13 Upper Sandusky, Ohio" ;;
# 987) TVDIÁRIO 145 Mexico 
987)
link="https://livestream.com/accounts/7328757/events/7373344"
use_cookies="no"
chan_name="TVDIÁRIO 145 Mexico" ;;
# 988) KEYT ABC 3 Santa Barbara California 
988)
link="https://livestream.com/accounts/19285506/live"
use_cookies="no"
chan_name="KEYT ABC 3 Santa Barbara California" ;;
# 989) WLBT FOX 40 Jackson Mississippi 
989)
link="https://livestream.com/accounts/11595602/live"
use_cookies="no"
chan_name="WLBT FOX 40 Jackson Mississippi" ;;
# 990) WSMV NBC 4 Nashville Tennessee
990)
link="https://livestream.com/accounts/6396556/LIVE"
use_cookies="no"
chan_name="WSMV NBC 4 Nashville Tennessee" ;;
# 991) DayTraderRockStar Show New York City New York 
991)
link="https://livestream.com/accounts/4878/events/2540723"
use_cookies="no"
chan_name="DayTraderRockStar Show New York City" ;;
# 992) WALA FOX10 News 24/7 Mobile, Alabama
992)
link="https://livestream.com/accounts/1859803/live"
use_cookies="no"
chan_name="WALA FOX10 News 24/7 Mobile, Alabama" ;;
# 993) KMOV CBS 4 St. Louis, Missouri
993)
link="https://livestream.com/accounts/12654794/live"
use_cookies="no"
chan_name="UNKNOWN" ;;
# 994) Lex & Terry Lufkin Texas 
994)
link="https://livestream.com/accounts/16950775/live"
use_cookies="no"
chan_name="Lex & Terry Lufkin Texas" ;;
# 995) KVOA NBC 4 Tuscon Arizona
995)
link="https://livestream.com/accounts/15512011/live"
use_cookies="no"
chan_name="KVOA NBC 4 Tuscon Arizona" ;;
# 996) Mike Malloy Show
996)
link="https://livestream.com/accounts/8522627/live"
use_cookies="no"
chan_name="Mike Malloy Show" ;;
# 997)KHSL CBS 12 Chico Redding California 
997)
link="https://livestream.com/accounts/26511688/live"
use_cookies="no"
chan_name="KHSL CBS 12 Chico Redding California" ;;
# 998) KSTP ABC 5 St. Paul, Minnesota
998)
link="https://livestream.com/accounts/12150160/live"
use_cookies="no"
chan_name="KSTP ABC 5 St. Paul, Minnesota" ;;
# 999) MNTV Myanmar 
999)
link="https://livestream.com/accounts/7228455/events/3875913"
use_cookies="no"
chan_name="MNTV Myanmar" ;;
# 1000) KSWO ABC 7 Winters Texas 
1000)
link="https://livestream.com/accounts/16991045/live"
use_cookies="no"
chan_name="KSWO ABC 7 Winters Texas" ;;
# 1001) WBTV CBS 3 Charlotte, North Carolina
1001)
link="https://livestream.com/accounts/10950088/live"
use_cookies="no"
chan_name="WBTV CBS 3 Charlotte, North Carolina" ;;
# 1002) KPHO CBS 5 Pheonix Arizona 
1002)
link="https://livestream.com/accounts/6907826/LIVE"
use_cookies="no"
chan_name="KPHO CBS 5 Pheonix Arizona " ;;
# 1003)  WDIO ABC 10/13 Duluth Minnesota 
1003)
link="https://livestream.com/accounts/12241516/live"
use_cookies="no"
chan_name="WDIO ABC 10/13 Duluth Minnesota " ;;
# 1004) KMSP FOX 9 Minneapolis Minnesota 
1004)
link="https://livestream.com/accounts/6396280/live"
use_cookies="no"
chan_name="KMSP FOX 9 Minneapolis Minnesota" ;;
# 1005) KSBY NBC 6 Santa Barbara California 
1005)
link="https://livestream.com/accounts/15512095/live"
use_cookies="no"
chan_name="KSBY NBC 6 Santa Barbara California" ;;
# 1006) KOLD 13 Tucson, Arizona
1006)
link="https://livestream.com/accounts/11042990/live"
use_cookies="no"
chan_name="KOLD 13 Tucson, Arizona" ;;
# 1007) KLTV ABC 7 Tyler, Texas
1007)
link="https://livestream.com/accounts/11816721/live"
use_cookies="no"
chan_name="KLTV ABC 7 Tyler, Texas" ;;
# 1008) WBRC FOX 6 Birmingham, Alabama
1008)
link="https://livestream.com/accounts/12446860/live"
use_cookies="no"
chan_name="WBRC FOX 6 Birmingham, Alabama" ;;
# 1009) Radio Radio TV Rome Italy 
1009)
link="https://livestream.com/accounts/11463451/tvlive"
use_cookies="no"
chan_name="Radio Radio TV Rome Italy" ;;
# 1010) PNC News First Newstalk K57 Fox 6 Guam 
1010)
link="https://livestream.com/accounts/10612724/newstalk57"
use_cookies="no"
chan_name="PNC News First Newstalk K57 Fox 6 Guam " ;;
# 1011) WTVT FOX 13 Tampa Bay Florida 
1011)
link="https://livestream.com/accounts/6180769/live"
use_cookies="no"
chan_name="WTVT FOX 13 Tampa Bay Florida" ;;
# 1012) WFLA NBC 8 Tampa, Florida
1012)
link="https://livestream.com/accounts/6140981/live"
use_cookies="no"
chan_name="WFLA NBC 8 Tampa, Florida" ;;
# 1013)WTNH 8 New Haven CT 
1013)
link="https://livestream.com/accounts/1864656/live"
use_cookies="no"
chan_name="WTNH 8 New Haven CT" ;;
# 1014)WMBF Myrtle Beach, South Carolina
1014)
link="https://livestream.com/accounts/11214123/live"
use_cookies="no"
chan_name="WMBF Myrtle Beach, South Carolina" ;;
# 1015) WSFA NBC 12 Montgomery Alabama 
1015)
link="https://livestream.com/accounts/11981705/live"
use_cookies="no"
chan_name="WSFA NBC 12 Montgomery Alabama" ;;
# 1016) WNYW Fox 5 New York
1016)
link="https://livestream.com/accounts/6372917/live"
use_cookies="no"
chan_name="WNYW Fox 5 New York" ;;
# 1017)KVVU FOX 5 Las Vegas Nevada  
1017)
link="https://livestream.com/accounts/6910894/Live"
use_cookies="no"
chan_name="KVVU FOX 5 Las Vegas Nevada " ;;
# 1018) KHON CBS 2 Ala Mona Honolulu Hawaii 
1018)
link="https://livestream.com/accounts/1858266/live"
use_cookies="no"
chan_name="KHON CBS 2 Ala Mona Honolulu Hawaii " ;;
# 1019)WFIE NBC 14 Evansville, Indiana
1019)
link="https://livestream.com/accounts/11981465/live"
use_cookies="no"
chan_name="WFIE NBC 14 Evansville, Indiana" ;;
# 1020) WTXF FOX 29 News Philadelphia
1020)
link="https://livestream.com/accounts/6370754/live"
use_cookies="no"
chan_name="WTXF FOX 29 News Philadelphia" ;;
# 1021) WFLD Fox 32 Chicago Illinois 
1021)
link="https://livestream.com/accounts/6370732/live"
use_cookies="no"
chan_name="WFLD Fox 32 Chicago Illinois" ;;
# 1022) KTVK 3 Pheonix Arizona
1022)
link="https://livestream.com/accounts/12643960/live"
use_cookies="no"
chan_name="KTVK 3 Pheonix Arizona" ;;
# 1023) KRIV FOX 26 Houston Texas 
1023)
link="https://livestream.com/accounts/6396012/live"
use_cookies="no"
chan_name="KRIV FOX 26 Houston Texas " ;;
# 1024) WVUE FOX 8 New Orleans Louisiana 
1024)
link="https://livestream.com/accounts/10891792/live"
use_cookies="no"
chan_name="WVUE FOX 8 New Orleans Louisiana" ;;
# 1025)KPTV FOX 12 Portland Oregon 
1025)
link="https://livestream.com/accounts/6908462/Live"
use_cookies="no"
chan_name="KPTV FOX 12 Portland Oregon" ;;
# 1026) KIRO Radio Seattle Washington 
1026)
link="https://livestream.com/accounts/21148570/live"
use_cookies="no"
chan_name="KIRO Radio Seattle Washington" ;;
# 1027) BoliviaTV La Paz Bolivia
1027)
link="https://livestream.com/accounts/10468276/boliviatv"
use_cookies="no"
chan_name="BoliviaTV La Paz Bolivia" ;;
# 1028) KUSI San Diego California
1028)
link="https://livestream.com/accounts/25082096/live"
use_cookies="no"
chan_name="KUSI NEWS San Diego California" ;;
# 1029) Fox 8 Cleveland Ohio
1029)
link="https://livestream.com/accounts/57501/live"
use_cookies="no"
chan_name="Fox 8 Cleveland Ohio" ;;
# 1030) KSLA News CBS 12 Shreveport, Louisiana
1030)
link="https://livestream.com/accounts/11816591/live"
use_cookies="no"
chan_name="KSLA News CBS 12 Shreveport, Louisiana" ;;
# 1031) MEDIAMAX NETWORK LIMITED K24 Nairobi Kenya 
1031)
link="https://livestream.com/accounts/17606245/events/4832042"
use_cookies="no"
chan_name="MEDIAMAX NETWORK LIMITED K24 Nairobi Kenya" ;;
# 1032) KELO CBS Sioux Falls, South Dakota
1032)
link="https://livestream.com/accounts/8522446/live"
use_cookies="no"
chan_name="KELO CBS Sioux Falls, South Dakota" ;;
# 1033) KSL NOW Salt Lake City Utah 
1033)
link="https://livestream.com/accounts/22711876/live"
use_cookies="no"
chan_name="KSL NOW Salt Lake City Utah" ;;
# 1034) skynet Up To Date Myanmar
1034)
link="https://livestream.com/accounts/7228455/events/3875178"
use_cookies="no"
chan_name="skynet Up To Date Myanmar" ;;
# 1035) WTTG Fox 5 Washington DC
1035)
link="https://livestream.com/accounts/2363281/live"
use_cookies="no"
chan_name="WTTG Fox 5 Washington DC" ;;
# 1036) WCSC CBS 5 Charleston South Carolina 
1036)
link="https://livestream.com/accounts/11016888/live"
use_cookies="no"
chan_name="WCSC CBS 5 Charleston South Carolina" ;;
# 1037) WBNS 10 Columbus Ohio
1037)
link="https://livestream.com/accounts/18624165/live"
use_cookies="no"
chan_name="WBNS 10 Columbus Ohio" ;;
# 1038) WJBK FOX 2 Detroit Michagan 
1038)
link="https://livestream.com/accounts/6396566/live"
use_cookies="no"
chan_name="WJBK FOX 2 Detroit Michagan" ;;
# 1039) WAFB CBS 9 Baton Rouge Louisiana 
1039)
link="https://livestream.com/accounts/11595706/live"
use_cookies="no"
chan_name="WAFB CBS 9 Baton Rouge Louisiana" ;;
# 1040) WFMZ 69 Traffic Allen Town Penslyvania 
1040)
link="https://livestream.com/accounts/14384745/traffic"
use_cookies="no"
chan_name="WFMZ 69 Traffic Allen Town Penslyvania " ;;
# 1041) GUATEVISION Guatemala
1041)
link="https://livestream.com/accounts/25697071/en-vivo"
use_cookies="no"
chan_name="GUATEVISION Guatemala" ;;
# 1042) KY3 Springfield Missouri 
1042)
link="https://livestream.com/accounts/4699618/live"
use_cookies="no"
chan_name="KY3 Springfield Missouri" ;;
# 1043) 710 ESPN Seattle Washington
1043)
link="https://livestream.com/accounts/21148436/live"
use_cookies="no"
chan_name="710 ESPN Seattle Washington" ;;
# 1044)  Iran Aryaee San Bernadino California 
1044)
link="https://livestream.com/accounts/11825802/events/3752117"
use_cookies="no"
chan_name="Iran Aryaee San Bernadino California" ;;
# 1045) DidgahNew TV Iranian 
1045)
link="https://livestream.com/accounts/27146356/events/8147101"
use_cookies="no"
chan_name="DidgahNew TV Iranian" ;;
# 1046) Onda Cádiz RTV Spain
1046)
link="https://livestream.com/accounts/22727797/directo"
use_cookies="no"
chan_name="Onda Cádiz RTV Spain" ;;
# 1047) NYXT Manhattan NYC New York USA
1047)
link="https://livestream.com/accounts/19770665/events/5522162"
use_cookies="no"
chan_name="NYXT Manhattan NYC New York USA" ;;
# 1048) King County TV Preston, Washington USA 
1048)
link="https://livestream.com/accounts/15175343/events/4485487"
use_cookies="no"
chan_name=" King County TV Preston, Washington USA " ;;
# 1049) Streaming Medios Públicos Señal Nacional
1049)
link="https://livestream.com/accounts/27228685/events/8175786"
use_cookies="no"
chan_name="Streaming Medios Públicos Señal Nacional" ;;
# 1050)Westerville.TV 543 Production Studio 
1050)
link="https://livestream.com/accounts/26666947/events/8163419"
use_cookies="no"
chan_name="Westerville.TV 543 Production Studio " ;;
# 1051) Kingdom Access Television Channel 192 LIVE
1051)
link="https://livestream.com/accounts/4209066/events/8159063"
use_cookies="no"
chan_name="Kingdom Access Television Channel 192 LIVE" ;;
# 1052) City of Las Vegas KCLV FOX 2 Nevada 
1052)
link="https://livestream.com/accounts/11449855/events/8026296"
use_cookies="no"
chan_name="City of Las Vegas KCLV FOX 2 Nevada" ;;
# 1053) Plaistow Access New Hampshire
1053)
link="https://livestream.com/accounts/11298895/meetings"
use_cookies="no"
chan_name="Plaistow Access New Hampshire" ;;
# 1054) City of Topeka City Kansas
1054)
link="https://livestream.com/accounts/25008807/events/7970645"
use_cookies="no"
chan_name="City of Topeka City Kansas" ;;
# 1055) Tele Bahia Santo Domingo ,Dominican Republic
1055)
link="https://livestream.com/accounts/18988261/events/7725211"
use_cookies="no"
chan_name="Tele Bahia Santo Domingo ,Dominican Republic" ;;
# 1056) Aryen TV Iran 
1056)
link="https://livestream.com/accounts/22902829/events/7609059"
use_cookies="no"
chan_name="Aryen TV Iran" ;;
# 1057) Shelby County Schools C19TV & 88.5FM Memphis Tennessee 
1057)
link="https://livestream.com/accounts/25133520/c19tv"
use_cookies="no"
chan_name="Shelby County Schools C19TV & 88.5FM Memphis Tennessee " ;;
# 1058) Provincetown Community TV Provincetown Government Meetings  Provincetown, Massachusetts
1058)
link="https://livestream.com/accounts/6011038/events/6712043"
use_cookies="no"
chan_name="Provincetown Community TV, Massachusetts" ;;
# 1059) Manhattan Neighborhood Network MNN-FSTV
1059)
link="https://livestream.com/accounts/17251237/events/6391580"
use_cookies="no"
chan_name="Manhattan Neighborhood Network MNN-FSTV" ;;
# 1060) Brunswick TV3 New Hampshire
1060)
link="https://livestream.com/accounts/13788599/events/6330198"
use_cookies="no"
chan_name="Brunswick TV3 New Hampshire" ;;
# 1061) Bermuda Government (CITV) Hamilton, Bermuda 
1061)
link="https://livestream.com/accounts/19270406/events/5372984"
use_cookies="no"
chan_name="Bermuda Government (CITV) Hamilton, Bermuda " ;;
# 1062) Minhaj TV Pakistan 
1062)
link="https://livestream.com/accounts/547271/MinhajTV"
use_cookies="no"
chan_name="Minhaj TV Pakistan" ;;
# 1063) GalaxyUniverseTV Freedom Solar TV Kersey, CO, USA
1063)
link="https://livestream.com/accounts/12141749/events/7685294"
use_cookies="no"
chan_name="Freedom Solar TV Kersey, CO, USA" ;;
# 1064) Shalom Media Catholic KIDS
1064)
link="https://livestream.com/shalomworld/events/7987357"
use_cookies="no"
chan_name="Shalom Media Catholic KIDS" ;;
# 1065) Faith Lutheran Church - Penfield, NY
1065)
link="https://livestream.com/accounts/4440983/events/6827954"
use_cookies="no"
chan_name="Faith Lutheran Church - Penfield, NY" ;;
# 1066)  Gott24.TV International 
1066)
link="https://livestream.com/accounts/1106752/events/6785217"
use_cookies="no"
chan_name="Gott24.TV International" ;;
# 1067) TV Fátima Paróquia de Fátima em Direto
1067)
link="https://livestream.com/accounts/22203883/events/6579475"
use_cookies="no"
chan_name="TV Fátima Paróquia de Fátima em Direto" ;;
# 1068) 
# 1069) Canal JesusTV Guatemala 
1069)
link="https://livestream.com/accounts/17608437/events/4834657"
use_cookies="no"
chan_name="Canal JesusTV Guatemala " ;;
# 1070) Whole Life Ministries SKMNetwork Augusta Georgia
1070)
link="https://livestream.com/accounts/16502349/SKMNetwork"
use_cookies="no"
chan_name="Whole Life Ministries SKMNetwork Augusta Georgia" ;;
# 1071) Second Presbyterian Church Sunday Worship Memphis Tennessee 
1071)
link="https://livestream.com/accounts/15713152/sunday-worship"
use_cookies="no"
chan_name="Second Presbyterian Church Sunday Worship Memphis Tennessee" ;;
# 1072) iTV Networks South Africa 
1072)
link="https://livestream.com/accounts/7079896/events/4406003"
use_cookies="no"
chan_name="iTV Networks South Africa" ;;
# 1073)Iglesia Advenimiento del Séptimo Día Advenimiento TV Dallas Texas
1073)
link="https://livestream.com/accounts/13655021/events/4355864"
use_cookies="no"
chan_name="Advenimiento TV Dallas Texas" ;;
# 1074) St. Catharine Church, Spring Lake, New Jersey 
1074)
link="https://livestream.com/accounts/11714562/events/3786245"
use_cookies="no"
chan_name="St. Catharine Church, Spring Lake, New Jersey " ;;
# 1075) Rede Gênesis Europa TV Gênesis Europa Lisbon Portugal
1075)
link="https://livestream.com/accounts/6602768/events/3378204"
use_cookies="no"
chan_name="TV Gênesis Europa Lisbon Portugal" ;;
# 1076) Dashmesh Culture Centre- Daily Broadcast Sikh Calgary Alberta Canada
1076)
link="https://livestream.com/accounts/472363/events/3109892"
use_cookies="no"
chan_name="Dashmesh Culture Centre- Daily Broadcast Sikh Calgary Alberta Canada" ;;
# 1077) Expande TV Puebla Mexico 
1077)
link="https://livestream.com/accounts/7277442/envivo"
use_cookies="no"
chan_name="Expande TV Puebla Mexico" ;;
# 1078) Tv Universal Centro de Ayuda Universal Mexico
1078)
link="https://livestream.com/accounts/4486152/oracionmedianoche"
use_cookies="no"
chan_name="Tv Universal Centro de Ayuda Universal Mexico" ;;
# 1079) Glory to God Ministries International Love of God Classics 
1079)
link="https://livestream.com/accounts/3240767/events/8008064"
use_cookies="no"
chan_name="Glory to God Ministries" ;;
# 1080) BethelTV Bethel Panamá
1080)
link="https://livestream.com/accounts/16567960/events/7963429"
use_cookies="no"
chan_name="BethelTV Bethel Panamá" ;;
# 1081) Poder de Dios TV La Paz Bolivia
1081)
link="https://livestream.com/accounts/25268891/TV"
use_cookies="no"
chan_name="Poder de Dios TV La Paz Bolivia" ;;
# 1082)  WYKE TV 47 Hormosassa Springs Florida
1082)
link="https://livestream.com/accounts/9261275/events/7602204"
use_cookies="no"
chan_name="WYKE TV 47 Hormosassa Springs Florida" ;;
# 1083) St. Helena Chapel
1083)
link="https://livestream.com/accounts/25372681/events/7581060"
use_cookies="no"
chan_name="St. Helena Chapel" ;;
# 1084) Luigi Pellegrini Parrocchia Santa Rita Via Reggio Italy 
1084)
link="https://livestream.com/accounts/25077919/diretta"
use_cookies="no"
chan_name="Luigi Pellegrini Parrocchia Santa Rita Via Reggio Italy " ;;
# 1085) St Patrick's Dumbarton
1085)
link="https://livestream.com/accounts/10499782/events/7601596"
use_cookies="no"
chan_name="St Patrick's Dumbarton" ;;
# 1086) Canal 27, El Canal de la Esperanza.
1086)
link="https://livestream.com/accounts/13639189/events/6356013"
use_cookies="no"
chan_name="Canal 27, El Canal de la Esperanza." ;;
# 1087) VTNTV VICTORY TELEVISION NETWORK KVTN KVTH KVTJ Little Rock Arkansas
1087)
link="https://livestream.com/accounts/15669040/events/4554297"
use_cookies="no"
chan_name="VTNTV VICTORY TELEVISION NETWORK KVTN KVTH KVTJ Little Rock Arkansas" ;;
# 1088) FGTV Frecuencias de Gloria Jacksonville Florida 
1088)
link="https://livestream.com/accounts/3107466/events/3858724"
use_cookies="no"
chan_name="FGTV Frecuencias de Gloria Jacksonville Florida" ;;
# 1089) MNN Channel 3 New York 
1089)
link="https://livestream.com/accounts/6312590/events/2611503"
use_cookies="no"
chan_name="MNN Channel 3 New York" ;;
# 1090) CGNTV America Korean Los Angeles California 
1090)
link="https://livestream.com/accounts/13207573/cgntv"
use_cookies="no"
chan_name="CGNTV America Korean Los Angeles California " ;;
# 1091) TMN WORD TV Into All the Earth 24/7/365
1091)
link="https://livestream.com/accounts/16242586/TMN"
use_cookies="no"
chan_name="TMN WORD TV Into All the Earth 24/7/365" ;;
# 1092) Parkside Radio Show / BROOKLYNSTATION.COM
1092)
link="https://livestream.com/knqradio/events/8191094"
use_cookies="no"
chan_name="Parkside Radio Show / BROOKLYNSTATION.COM" ;;
# 1093) skynet Buddha Myanmar 
1093)
link="https://livestream.com/accounts/7228455/events/3875181"
use_cookies="no"
chan_name="skynet Buddha Myanmar" ;;
# 1094) ABHPTV Daily Broadcast Vietnamese  An Bình Hạnh Phúc
1094)
link="https://livestream.com/accounts/13311218/events/7250967"
use_cookies="no"
chan_name="ABHPTV Daily Broadcast An Bình Hạnh Phúc Vietnamese " ;;
# 1095) FGTV Frequencies of Glory LIVE Jacksonville Florida 
1095)
link="https://livestream.com/accounts/3107466/events/3858711"
use_cookies="no"
chan_name="FGTV Frequencies of Glory LIVE Jacksonville Florida" ;;
# 1095) teleamiga TELEAMIGA INTERNACIONAL 
1095)
link="https://livestream.com/accounts/18971084/events/6841479"
use_cookies="no"
chan_name="TELEAMIGA INTERNACIONAL" ;;
# 1097) Sangat Television Birmingham England 
1097)
link="https://livestream.com/accounts/6986636/sangattv"
use_cookies="no"
chan_name="Sangat Television Birmingham England" ;;
# 1098) El Evangelio Eterno EEE Network en Los Angeles Canal 63.5
1098)
link="https://livestream.com/accounts/116136/EEENet"
use_cookies="no"
chan_name="El Evangelio Eterno EEE Network en Los Angeles Canal 63.5" ;;
# 1099) HJTV online Healing Jesus TV London England 
1099)
link="https://livestream.com/accounts/15754877/events/4470314"
use_cookies="no"
chan_name="HJTV online Healing Jesus TV London England" ;;
# 1100) ANB TV ANBSAT LIVE 
1100)
link="https://livestream.com/accounts/933317/events/2295471"
use_cookies="no"
chan_name="ANB TV ANBSAT LIVE" ;;
# 1101) Apocalypse Channel APTV Live Polaski Tennessse 
1101)
link="https://livestream.com/accounts/5057242/events/4312291"
use_cookies="no"
chan_name="Apocalypse Channel APTV Live Polaski Tennessse" ;;
# 1102) Sikh Channel Sikh Channel (Global Broadcast) Aston England 
1102)
link="https://livestream.com/accounts/5296919/live"
use_cookies="no"
chan_name="Sikh Channel Aston England" ;;
# 1103) Marytown Chapel Marytown Online Adoration Chapel Illinois
1103)
link="https://livestream.com/accounts/15529184/events/4408765"
use_cookies="no"
chan_name="Marytown Chapel Illinois" ;;
# 1104)  Enlacetv Espanol Irving Texas 
1104)
link="https://livestream.com/accounts/2675843/enlace"
use_cookies="no"
chan_name="Enlacetv Espanol Irving Texas" ;;
# 1105) VSiN - Vegas Stats & Information Network Las Vegas Nevada 
1105)
link="https://livestream.com/accounts/22774234/events/6897936"
use_cookies="no"
chan_name="VSiN - Vegas Stats & Information Network Las Vegas Nevada " ;;
# 1106) Guaranty Media Baton Rouge Louisiana 
1106)
link="https://livestream.com/accounts/25649901/live"
use_cookies="no"
chan_name="Guaranty Media Baton Rouge Louisiana" ;;
# 1107) ESPN 97.5 Houston Texas 
1107)
link="https://livestream.com/accounts/26800104/live"
use_cookies="no"
chan_name="ESPN 97.5 Houston Texas" ;;
# 1108) Udinews TV Udine Italy
1108)
link="https://livestream.com/accounts/11217196/Udinese"
use_cookies="no"
chan_name= "Udinews TV Udine Italy" ;;
# 1109) Pro Football Hall of Fame Hall of Fame Channel Stream
1109)
link="https://livestream.com/accounts/24957552/events/8006439"
use_cookies="no"
chan_name="Pro Football Hall of Fame" ;;
# 1110) Lance Hope RSL FEED
1110)
link="https://livestream.com/accounts/22999173/events/8078810"
use_cookies="no"
chan_name="Lance Hope RSL FEED" ;;
# 1111) DiTV Canale 89 Lucchese Channel Italy 
1111)
link="https://livestream.com/accounts/21477830/events/7298093"
use_cookies="no"
chan_name="DiTV Canale 89 Lucchese Channel Italy " ;;
# 1112)XBTV Rosecroft Raceway Live Maryland 
1112)
link="https://livestream.com/accounts/9869799/events/6772185"
use_cookies="no"
chan_name="XBTV Rosecroft Raceway Live Maryland" ;;
# 1113)  LIfeTOnicNET South Korea
1113)
link="https://livestream.com/accounts/10519356/events/6417270"
use_cookies="no"
chan_name="LIfeTOnicNET South Korea" ;;
# 1114) Park City Television PCTV Livestream Utah 
1114)
link="https://livestream.com/accounts/11728043/events/3779731"
use_cookies="no"
chan_name="Park City Television PCTV Livestream Utah" ;;
# 1115) BoliviaTV La Paz Bolivia
1115)
link="https://livestream.com/accounts/10468276/BtvDeportes"
use_cookies="no"
chan_name="BoliviaTV La Paz Bolivia" ;;
# 1116) Cosmovision TV Cosmovision HD
1116)
link="https://livestream.com/accounts/16628908/cosmovisionhd"
use_cookies="no"
chan_name="Cosmovision TV" ;;
# 1117) WHLT 12 Whitehall, Wisconsin
1117)
link="https://livestream.com/accounts/8383566/live"
use_cookies="no"
chan_name="WHLT 12 Whitehall, Wisconsin" ;;
# 1118) OUBN - Oakwood University Huntsville Alabama  
1118)
link="https://livestream.com/accounts/5329025/events/7079597"
use_cookies="no"
chan_name="OUBN - Oakwood University Huntsville Alabama " ;;
# 1119) Nasdaq Bell Ceremonies New York City 
1119)
link="https://livestream.com/accounts/888332/live"
use_cookies="no"
chan_name="Nasdaq Bell Ceremonies New York City" ;;
# 1120) AAA Guayama
1120)
link="https://livestream.com/accounts/3185486/guayama"
use_cookies="no"
chan_name="AAA Guayama" ;;
# 1121) AWCATV - Education/Government Channel Ashburnham 
1121)
link="https://livestream.com/accounts/22393363/events/6651528"
use_cookies="no"
chan_name="AWCATV - Education/Government Channel Ashburnham " ;;
# 1122) Branson Visitor TV Branson Misouri 
1122)
link="https://livestream.com/accounts/21384612/BVTV"
use_cookies="no"
chan_name="Branson Visitor TV Branson Misouri" ;;
# 1123) Politv Poli tv Bogota Colombia 
1123)
link="https://livestream.com/accounts/12256908/events/6185792"
use_cookies="no"
chan_name="Poli tv Bogota Colombia" ;;
# 1124) You Content 98 Live Belo Horizonte Brasil 
1124)
link="https://livestream.com/accounts/15418920/98livebh"
use_cookies="no"
chan_name="98 Live Belo Horizonte Brasil" ;;
# 1125)FHSU TIGER MEDIA NETWORK TMN TV Livestream Hays Kansas USA
1125)
link="https://livestream.com/accounts/11135493/events/5339279"
use_cookies="no"
chan_name="FHSU TIGER MEDIA NETWORK TMN TV Livestream Hays Kansas USA" ;;
# 1126) Telelibertà Piacenza Italy 
1126)
link="https://livestream.com/accounts/17114188/events/4902226"
use_cookies="no"
chan_name="Telelibertà Piacenza Italy" ;;
# 1127) MNN Channel 5 (HD) New York City New York, USA 
1127)
link="https://livestream.com/accounts/17251372/events/4846282"
use_cookies="no"
chan_name="MNN Channel 5 (HD) New York City" ;;
# 1128) WIVM TV39 WIVM Local TV Canton Ohio 
1128)
link="https://livestream.com/accounts/17488475/events/4802826"
use_cookies="no"
chan_name="WIVM TV39 WIVM Local TV Canton Ohio" ;;
# 1129) EPlusTV6 Jackson Tennessee 
1129)
link="https://livestream.com/accounts/726212/events/4481510"
use_cookies="no"
chan_name="EPlusTV6 Jackson Tennessee" ;;
# 1130) St. Cloud Times UTVS Minnesota 
1130)
link="https://livestream.com/accounts/11549400/UTVS"
use_cookies="no"
chan_name="St. Cloud Times UTVS Minnesota " ;;
# 1131) Milford TV - Milford, MA Massachusetts 
1131)
link="https://livestream.com/accounts/13918823/MilfordTV"
use_cookies="no"
chan_name="Milford TV - Milford, MA Massachusetts" ;;
# 1132) EKB- TV EKBTV Live Pikeville Kentucky 
1132)
link="https://livestream.com/accounts/6461963/events/4113877"
use_cookies="no"
chan_name="EKB- TV EKBTV Live Pikeville Kentucky" ;;
# 1133) Milford TV Educational Channel - Milford, MA
1133)
link="https://livestream.com/accounts/13568947/MilfordTVEducational"
use_cookies="no"
chan_name="Milford TV Educational Channel - Milford, MA" ;;
# 1134)Native Media Network - NDN1.com NMN Live Santa Fe New Mexico
1134)
link="https://livestream.com/accounts/13196214/events/3994033"
use_cookies="no"
chan_name="Native Media Network, Santa Fe New Mexico" ;;
# 1135) EUTV - Evangel University EUTV Channel Live Springfield Missouri
1135)
link="https://livestream.com/accounts/10735484/events/3837393"
use_cookies="no"
chan_name=" EUTV Evangelical University, Springfield Missouri" ;;
# 1136) rtm tv Arcevia Italy
1136)
link="https://livestream.com/accounts/10831729/events/3759913"
use_cookies="no"
chan_name="rtm tv Arcevia Italy" ;;
# 1137) UNTREF UN3 - Tu mirada no está sola Buenos Aires Argentina 
1137)
link="https://livestream.com/accounts/5198918/events/3229548"
use_cookies="no"
chan_name="UNTREF UN3 - Tu mirada no está sola Buenos Aires Argentina " ;;
# 1138) Asociación RUAV Univalle - Canal Universitario Cali Colombia
1138)
link="https://livestream.com/accounts/2541970/events/1932032"
use_cookies="no"
chan_name="Asociación RUAV Univalle - Canal Universitario Cali Colombia" ;;
# 1139) ONE TV NBC 112 LIVE Milan Italy 
1139)
link="https://livestream.com/accounts/1326279/events/8177442"
use_cookies="no"
chan_name="ONE TV NBC 112 LIVE Milan Italy" ;;
# 1140) Viet Sky TV Anaheim California
1140)
link="https://livestream.com/accounts/27136431/events/8142772"
use_cookies="no"
chan_name="Viet Sky TV Anaheim California" ;;
# 1141) Granbury Media Granbury, TX Tower Camera Live Stream 
1141)
link="https://livestream.com/accounts/13120617/TowerCamera"
use_cookies="no"
chan_name="Granbury Media Granbury, TX Tower Camera Live Stream" ;;
# 1142) ETSU New Construction Camera ETSU Fine Arts Classroom Building Johnson City Tennesse 
1142)
link="https://livestream.com/accounts/17402222/FineArts"
use_cookies="no"
chan_name="ETSU New Construction Camera ETSU Fine Arts Classroom Building Johnson City Tennesse" ;;
# 1143) WDFL 18 South Carolina, Alabama, Louisiana 
1143)
link="https://livestream.com/accounts/26473976/events/7937669"
use_cookies="no"
chan_name="WDFL 18 South Carolina, Alabama, Louisiana" ;;
# 1144) auftanken.tv Austria
1144)
link="https://livestream.com/accounts/26170820/events/7915290"
use_cookies="no"
chan_name="auftanken.tv Austria" ;;
# 1145) MCAET Salinas California 
1145)
link="https://livestream.com/accounts/7781243/events/7871771"
use_cookies="no"
chan_name="MCAET Salinas California" ;;
# 1146) Bidtween La chaîne TV des Enchères France 
1146)
link="https://livestream.com/accounts/25334545/events/7803598"
use_cookies="no"
chan_name="Bidtween La chaîne TV des Enchères France" ;;
# 1147) BlabTV
1147)
link="https://livestream.com/accounts/22779635/events/7675406"
use_cookies="no"
chan_name="BlabTV" ;;
# 1148) Essex County College Newark New Jersey 
1148)
link="https://livestream.com/accounts/5109696/events/7607762"
use_cookies="no"
chan_name="Essex County College Newark New Jersey" ;;
# 1149) CNPTV Live Caribbean Television.
1149)
link="https://livestream.com/accounts/22462981/Live"
use_cookies="no"
chan_name="CNPTV Live Caribbean Television." ;;
# 1150)  LOBO STATION
1150)
link="https://livestream.com/accounts/14558256/events/7412168"
use_cookies="no"
chan_name="LOBO STATION" ;;
# 1151) Mediatext Srl Italia channel
1151)
link="https://livestream.com/accounts/277367/events/7379093"
use_cookies="no"
chan_name="Italia channel" ;;
# 1152) Maricopa Colleges Television MCTV Live Feed 115 Phoenix Arizona
1152)
link="https://livestream.com/accounts/24714287/Live"
use_cookies="no"
chan_name="Maricopa Colleges Television MCTV Live Feed 115 Phoenix Arizona" ;;
# 1153)Enjoy St.Moritz CH Switzerland
1153)
link="https://livestream.com/accounts/2090099/events/7221364"
use_cookies="no"
chan_name="Enjoy St.Moritz CH Switzerland" ;;
# 1154)NRT Canal 4 monclova
1154)
link="https://livestream.com/accounts/24089527/events/7172314"
use_cookies="no"
chan_name="NRT Canal 4 monclova" ;;
# 1155) ortonvilletelevision
1155)
link="https://livestream.com/accounts/17285258/events/7143508"
use_cookies="no"
chan_name="ortonvilletelevision" ;;
# 1156) Este Canal Tv
1156)
link="https://livestream.com/accounts/8817409/events/7051352"
use_cookies="no"
chan_name="Este Canal Tv" ;;
# 1157) CharmTV Baltimore Maryland
1157)
link="https://livestream.com/accounts/13988426/events/4134572"
use_cookies="no"
chan_name="CharmTV Baltimore Maryland" ;;
# 1158) KVVB.TV CH.33 Victorville,California KVVB.TV | Ch 33.1 
1158)
link="https://livestream.com/accounts/9450048/events/3542162"
use_cookies="no"
chan_name="KVVB.TV CH.33 Victorville,CA" ;;
# 1159) TV Arcana Barkat TV
1159)
link="https://livestream.com/accounts/25119151/events/7597894"
use_cookies="no"
chan_name="TV Arcana Barkat TV" ;;
# 1160) WLTH AM 1370 Radio
1160)
link="https://livestream.com/accounts/26670176/events/8011646"
use_cookies="no"
chan_name="WLTH AM 1370 Radio" ;;
# 1161) KCOH TV Houston Texas 
1161)
link="https://livestream.com/accounts/12299560/events/3892224"
use_cookies="no"
chan_name="KCOH TV Houston Texas" ;;
# 1162) Lake Tahoe TV California
1162)
link="https://livestream.com/accounts/21822229/events/6450069"
use_cookies="no"
chan_name="Lake Tahoe TV California" ;;
# 1163) TV Arcana TV Arcana - 1
1163)
link="https://livestream.com/accounts/25119151/events/7392689"
use_cookies="no"
chan_name="TV Arcana - 1" ;;
# 1164) Mediaon BergamoTV Italy 
1164)
link="https://livestream.com/accounts/245066/events/3063596"
use_cookies="no"
chan_name="Mediaon BergamoTV Italy " ;;
# 1165) Ariana Live  
1165) 
link="https://livestream.com/accounts/9180830/events/6727975"
use_cookies="no"
chan_name="Ariana Live" ;;
# 1166) Canal Telecafé Bogota Colombia
1166)
link="https://livestream.com/accounts/1015476/events/7158511"
use_cookies="no"
chan_name="Canal Telecafé Bogota Colombia" ;;
# 1167)  SescTV Sao Paulo Brasil  
1167)
link="https://livestream.com/accounts/16991778/NoAr"
use_cookies="no"
chan_name="SescTV Sao Paulo Brasil" ;;
# 1168) KVZK TV CHANNEL 2 American Samoa 
1168)
link="https://livestream.com/accounts/8956070/events/4561731"
use_cookies="no"
chan_name="KVZK TV CHANNEL 2 American Samoa" ;;
# 1169) TVUNAM 20 Transmisión de la Dirección General de Televisión Universitaria
1169)
link="https://livestream.com/accounts/27177136/events/8157904"
use_cookies="no"
chan_name="TVUNAM 20" ;;
# 1170) Florida Gaming Sorteo
1170)
link="https://livestream.com/accounts/25552923/events/7909255"
use_cookies="no"
chan_name="Florida Gaming Sorteo" ;;
# 1171) Rede de Comunicação Miramar TV Miramar Brasil
1171)
link="https://livestream.com/accounts/21076186/events/6180705"
use_cookies="no"
chan_name="Rede de Comunicação Miramar TV Miramar Brasil" ;;
# 1172) Rede Super Belo Horizonte Brasil 
1172)
link="https://livestream.com/accounts/10205943/events/3429501"
use_cookies="no"
chan_name="Rede Super Belo Horizonte Brasil" ;;
# 1173) Kidd Kraddick Morning Show 
1173)
link="https://livestream.com/accounts/16936513/live"
use_cookies="no"
chan_name="Kidd Kraddick Morning Show " ;;
# 1174) Talenu TV Luanda Angola Portuguese  
1174)
link="https://livestream.com/accounts/1181452/events/5141181"
use_cookies="no"
chan_name="Talenu TV Luanda Angola Portuguese " ;;
# 1175) ONE Malta
1175)
link="https://livestream.com/accounts/18398100/ONELive"
use_cookies="no"
chan_name="ONE Malta" ;;
# 1176) Rover's Morning Glory RMG-TV Cleavland Ohio
1176)
link="https://livestream.com/accounts/242049/events/1978582"
use_cookies="no"
chan_name="Rover's Morning Glory RMG-TV Cleavland Ohio" ;;
# 1177) WFSB 3 Hartford Connecticut USA
1177)
link="https://livestream.com/accounts/6372985/live"
use_cookies="no"
chan_name="WFSB 3 Hartford Connecticut USA" ;;
# 1178) ICOinvestor.tv USA
1178)
link="https://livestream.com/accounts/26548600/events/8201689"
use_cookies="no"
chan_name="ICOinvestor.tv USA" ;;
# 1179) WISH 8 Indianapolis USA
1179)
link="https://livestream.com/accounts/1858612/live"
use_cookies="no"
chan_name="WISH 8 Indianapolis USA" ;; 
 



################### MENU 5 ########################################
###############    SPACE       ######################### 
# 1361) NASA ISS 1
1361) link=https://www.youtube.com/watch?v=ddFvjfvPnqk 
use_cookies="no"
chan_name="NASA ISS 1" ;;  
################## LOCATIONS #############################    
# 1362) Venice Italy Bridge Cam Live
1362) link=https://www.youtube.com/watch?v=vPbQcM4k1Ys 
use_cookies="no"
chan_name="Venice Italy Bridge Cam" ;;
# 1363) Jackson Hole Town Square
1363) 
keyword="Square"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCEpDjqeFIGTqHwk-uULx72Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Jackson Hole Town Square" ;;
# 1364) Jackson Hole Rustic Inn
1364) link=https://www.youtube.com/watch?v=KdvHzgcElx0 
use_cookies="no"
chan_name="Jackson Hole Rustic Inn" ;;
# 1365) Aosta Sarre Italy
1365)
keyword="Aosta Sarre Italy"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/camillimarco/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Aosta Sarre Italy" ;;
# 1366) Buenos Aires Four Seasons
1366)
keyword="Buenos"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCCkRwmztPEvut3gpsgmCmzw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Buenos Aires Four Seasons" ;;
# 1367) Netherlands Amsterdam
1367) 
keyword="amsterdam"
link=http://www.amsterdam-dam.com/webcam.html
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Amsterdam Netherlands" ;; 
# 1368) Shibua Japan Community Crosswalk 
1368) 
keyword="LIVE CAMERA"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/sibchtv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Shibua Japan Crosswalk" ;;
# 1369) Akiba Japan Live
1369) 
keyword="Akiba" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/GETNEWSJP/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Akiba Live" ;;
# 1370) Yahoo Weather Japan
1370) link=https://www.youtube.com/watch?v=QbQREKdxGhM
use_cookies="no"
chan_name="Yahoo Japan Bridge" ;;
# 1371) Yahoo Weather Steamy Mountains
1371)  link=https://www.youtube.com/watch?v=U83waNjv2bM
use_cookies="no"
chan_name="Yahoo Japan Steamy Mountain" ;;
# 1372) Naman Seoul Tower South Korea  
1372) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC90AkGrousC-CDBcCL8UaSg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Naman Seoul Tower South Korea" ;; 
# 1373) Shizuoka Bridge Japan
1373) link=https://www.youtube.com/watch?v=cdJthnaGO6c
use_cookies="no"
chan_name="Shizuoka Bridge Japan" ;;
# 1374) Yokohama Port Japan
856) link=https://www.youtube.com/watch?v=vE58KB1AoiA
use_cookies="no"
chan_name="Yokohama Port Japan" ;;
# 1375) Hokkido Weather Cams
1375) link=https://www.youtube.com/watch?v=ii_JukUbJG0
use_cookies="no"
chan_name="Hokkido Weather Cams" ;;     
# 1376) Mount Fuji Japan
1376) link=https://www.youtube.com/watch?v=iyzGqj_xRfc
use_cookies="no"
chan_name="Mount Fuji Japan" ;;     
# 1377) Netherlands Hart Beach
1377) 
keyword="hartbeach"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Hart Beach Netherlands" ;; 
# 1378)  Port du Quebec
1378) 
keyword="Port"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/portqc/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Port du Quebec" ;; 
# 1379) Durango Colorado USA
1379) 
keyword="Durango"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCJ3zGPGUiVTwcIDyEV3xwpw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Durango Colorado USA" ;; 
# 1380)Star Dot Cam 1
1380) 
keyword="Live Fish Tank"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 1 Fish Tank" ;;  
# 1381) Youing Japan Route 10
1381) 
keyword="Japan LIVE Camera" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/YOUINGmediacity/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Youing Japan Route 10" ;; 
# 1382) Star Dot Cam 4
1382) 
keyword="Taipei City #1/3"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 4 Taipei Taiwan" ;; 
# 1383) Star Dot Cam 5
1383) 
keyword="Taipei City #2/3"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 5 Taipei Taiwan" ;; 
# 1384) Star Dot Cam 6
1384) 
keyword="Taipei City #3/3"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 6 Taipei Taiwan" ;; 
# 1385) Fine Cine London 1
1385) 
keyword="LONDON PANORAMIC"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fine Cine London 1" ;; 
# 1386) Fine Cine London 2
1386) 
keyword="CITY TOUR"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fine Cine London 2" ;; 
# 1387) Fine Cine London 3
1387) 
keyword="FINE CINE™ LONDON LIVE™"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fine Cine London 3" ;; 
# 1388) Berlin Airport 
1388) 
keyword="LIVE: Berlin Skyline Airport"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/HausTwentyfourseven/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Berlin Airport" ;; 
# 1389) Port of Los Angeles  
1389) 
keyword="Port of Los Angeles Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ThePortofLosAngeles/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Port of Los Angeles" ;; 
# 1390)  ITS COM STUDIO Japan  
1390) 
keyword="iTSCOM STUDIO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCYt3d335w5qPi5vE62Mxy8g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ITS COM STUDIO" ;; 
# 1391)  China Shoreline 
1391) 
keyword="海洋博公園"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCgoVZ6IWOEcJdXiefd5nmcQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="China Shoreline" ;;

esac
}

######################### Function to check the menu status and deal with user input ###################################################
menu_status()
{
input=$1
if [ "$input" == "" ]
then
chan_state="return"
menstat="no"
elif [ "$input" == "q" ]
then
menstat="yes"
menu="q"
elif [ "$input" == "n" ]
then 
menstat="yes"
menu="n"
elif [ "$input" == "m" ]
then
menstat="yes"
menu="m"
elif [ "$input" == "ua-tor" ]
then
menstat="yes"
menu="$menu"
uastate="tor"
uamode="on"
elif [ "$input" == "ua-row1" ]
then
menstat="yes"
menu="$menu"
uastate="row1"
uamode="on"
elif [ "$input" == "ua-rand" ]
then
menstat="yes"
menu="$menu"
uastate="rand"
uamode="on"
elif [ "$input" == "ua-ranstr" ]
then
menstat="yes"
menu="$menu"
uastate="ranstr"
uamode="on"
elif [ "$input" == "ua-off" ]
then
menstat="yes"
menu="$menu"
uastate="off"
uamode="off"
elif [ "$input" == "+" ]
then
menstat="no"
chan_state="+"
elif [ "$input" == "]" ]
then
menstat="no"
chan_state="+"

elif [ "$input" == "++" ]
then
menstat="no"
chan_state="+"
elif [ "$input" == "+++" ]
then
menstat="no"
chan_state="+"
elif [ "$input" == "++++" ]
then
menstat="no"
chan_state="+"
elif [ "$input" == "-" ]
then
menstat="no"
chan_state="-"
elif [ "$input" == "[" ]
then
menstat="no"
chan_state="-"
elif [ "$input" == "--" ]
then
menstat="no"
chan_state="-"
elif [ "$input" -lt 1400 ]
then
menstat="no"
chan_state="numeric"
else
menstat="no"
chan_state="alpha"
fi
}

############################## Function for Channel Menu Switching, m,n,q channel matrix display
menu_switch()
{
input=$1
case "$input" in
q) echo "Type endtv to restart program. Bye."
exit "$?" ;;
s) 
men_num="$men_num"
channel_matrix_"$men_num"
menu="s"
echo "Please Select a Number corresponding to a Media Stream, press + or ] to increment, - or [ to decrement, n for the next menu, or q to quit:" ;;
m)
men_num=$(expr 0)
channel_matrix_"$men_num"
menu="s"
echo "Please Select a Number corresponding to a Media Stream, press + or ] to increment, - or [ to decrement, n for the next menu, or q to quit:" ;;
n) 
men_num=$(expr "$men_num" + 1)
men_num=$(expr "$men_num" % 5)
channel_matrix_"$men_num"
menu="s"
echo "Please Select a Number corresponding to a Media Stream, press + or ] to increment, - or [ to decrement, m for the main menu, n for the next menu, or q to quit:" ;;
esac
}

################################ Function to set the channel number 
set_channel()
{
chan_state=$1
if [ "$chan_state" == "+" ]
then
num=$(expr "$num" + 1 )
elif [ "$chan_state" == "-" ]
then
num=$(expr "$num" - 1 )
elif [ "$chan_state" == "return" ]
then
num="$num"
elif [ "$chan_state" == "numeric" ]
then 
num="$entry"
else 
num="$num"
fi
}

################################# Function to select the user agent
select_agent()
{
if [ "$uamode" == "on" ]
 then
   if [ "$uastate" == "rand" ]
   then 
    # pick a random user agent
    UA=$( grep -v "#" "$USERAGENTS" | shuf -n 1 ) 
   elif [ "$uastate" == "ranstr" ]
   then 
     # make a random string as the user agent 
     bytes="$( expr 12 + $(head -c 2 /dev/urandom | od -A n -i) % 48 | awk '{print $1}')"
     UA="$( head -c "$bytes" /dev/urandom | base64 -i | tr -d "\n=+-\/" | tr -s " " | awk '{print $1}')" 
   elif [ "$uastate" == "tor" ] 
   then
     UA="$UA_torbrowser" 
   elif [ "$uastate" == "row1" ] 
   then
     UA=$( grep -v "#" "$USERAGENTS" | head -n 1 )
   else 
     UA=""
   fi 
 fi
}


######################## FUNCTION FOR PLAYING MEDIA STREAM CHANNELS #############################
play_channel()
{
if [ "$menstat" == "no" ]
then
channel_select "$num"
echo "$chan_name Channel $num" 
  
  if [ "$uamode" == "on" ]
  then 
  echo "$UA"
   
    if [ "$use_cookies" == "yes" ]
    then
    echo "Fetching Cookie, Please Wait..."
    firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet curl -A "$UA" --cookie-jar "$cookie" --silent "$link"  >  /dev/null 2>&1
    firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --user-agent="$UA" --ytdl-format="$format" --no-resume-playback --cache="$cache_size" --fullscreen --loop-playlist=inf --stream-lavf-o=timeout=10000000 --cookies  --cookies-file "$cookie" "$link" 
    # clear the cookie
    echo " " > "$cookie"
    else
    firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --user-agent="$UA" --ytdl-format="$format" --no-resume-playback --loop-playlist=inf --cache="$cache_size" --fullscreen "$link" 
    fi
  else
   
    if [ "$use_cookies" == "yes" ]
    then
    echo "Fetching Cookie, Please Wait..."
    firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet curl --cookie-jar "$cookie" --silent "$link"  >  /dev/null 2>&1
    firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --ytdl-format="$format" --no-resume-playback --cache="$cache_size" --fullscreen --loop-playlist=inf --stream-lavf-o=timeout=10000000 --cookies  --cookies-file "$cookie" "$link" 
    # clear the cookie
    echo " " > "$cookie"
    else
    firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --ytdl-format="$format" --no-resume-playback --loop-playlist=inf --cache="$cache_size" --fullscreen "$link" 
    fi
     
  fi
clear
menu_switch "$menu"
echo "You were watching "$chan_name" on Channel "$num" "  
chan_state="normal"
format=""
read entry
else 
clear
menu_switch "$menu"
chan_state="normal"
menstat="no"
format=""
read entry
fi
}

### Some more commands to add 
# mpv --http-header-fields='Field1: value1','Field2: value2' 
# --tls-verify
# --referrer=<string>
# --cache-secs=<seconds>
# --cache-file-size=<kBytes>
# --cache-pause  --cache=<kBytes|yes|no|auto>
# https://mpv.io/manual/master/
################################################ MAIN PROGRAM #####################################################################

########################################### FIRST RUN  ####################################################################
clear

## select the user agent
select_agent

# initialize menu and channels
menu="s"
men_num=0
entry=1
num=1
format="best"

############## USER INPUT FIRST RUN  ###################################
##  If input is non empty display and select
if [ "$1" != "" ]
then
  echo "$1"
  # take channel input from command line
  entry="$1" 
elif [ "$1" == "" ]  # else redisplay the channel matrix at previous page and ask for user input
then
  channel_matrix_"$men_num"
  echo "Please Select a Number corresponding to a Media Live Stream:"
  read entry
  if [ "$entry" == "q" ]
  then 
   echo "Type endstream to open a new stream."
   exit "$?"
  elif [ "$entry" == "" ]
  then
   entry=1
   num=1
  fi
fi

### DECIDE WHAT THE USER INPUT IS
menu_status $entry

### Case to remove void input on channel +/- at first selection 
if [ "$chan_state" == "+" ]
then 
chan_state="return"
entry=1
num=1
elif [ "$chan_state" == "-" ]
then 
chan_state="return"
entry=1
num=1
fi

### Select the channel number to play
set_channel $chan_state
### Play the media stream
play_channel

############################# MENU LOOP  #######################################################3
## While loop to keep menu up after each stream
while [ "$entry" != q ]
do
  ## select the user agent
  select_agent
  ### Check the user input and decide what it is
  menu_status $entry
  ### Set the channel number 
  set_channel "$chan_state"
  #### Call function to play the channel
  play_channel
done
############################## END OF MENU LOOP #################################################

echo "Type endstream to open a new stream."

### Remove any existing cookies
if [ -e "$cookie" ]
then
rm "$cookie"
fi 

exit "$?"

############################################     END OF PROGRAM      ############################################################
 
  
