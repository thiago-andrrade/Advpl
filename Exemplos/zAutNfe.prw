//Bibliotecas
#Include "Totvs.ch"
#include "tbiconn.ch"

//=================================================================================
/*/{Protheus.doc} zAutNfe
Realiza a chamada da Transmissão + Monitoramento automática da NFE
    ________  __________________              _
   /_   _/ /_/ / /  \ \   _   _ \	        /  \
	/ / /  _  / / /\ \ \_\ \ \_\ \    _    / /\ \
   /_/ /_/ /_/_/_/  \_\_____\_____\  \_\  /_/  \_\
@type		function
@author		Thiago.Andrrade
@since		02/12/2024
@version	12.1.2310
@obs		    1 - O objetivo desta função é economizar licença, configurando os 2 jobs x Empresas
            desta forma teremos 6 processamentos consumindo apenas 1 licença.
            Este programa irá chamar as rotinas padrões (autoNfeTrans + autoNfeMon).
            2 - Transmissão de ENTRADAS desativada dentro do p.e FISVALNFE
@see        https://centraldeatendimento.totvs.com/hc/pt-br/articles/360029358971-Cross-Segmentos-Backoffice-Protheus-Doc-Eletr%C3%B4nicos-NF-e-AUTONFE-Transmiss%C3%A3o-Monitoramento-e-Cancelamento-Autom%C3%A1ticos
/*/
//=================================================================================
 User Function zAutNfe()
    Local cFunBkp := FunName()
    Local aArea   := FwGetArea()

    //Processa Empresa 01 - Filial 01
    fProcessa("01","01","1  ")

    //Processa Empresa 01 - Filial 02
    fProcessa("01","02","1  ")

    //Processa Empresa 02 - Filial 01
    fProcessa("02","01","1  ")

    //Restaura
    SetFunName(cFunBkp)
    FwRestArea(aArea)
Return

//=================================================================================
/*/ zAutNfe
Realiza processamento

/*/
//=================================================================================
Static Function fProcessa(cEmpProc,cFilProc,cSerProc)
    Local cBkpMv1 := ''
    Local cBkpMv2 := ''

    //Prepara ambiente
    PREPARE ENVIRONMENT EMPRESA cEmpProc FILIAL cFilProc FUNNAME "zAutNfe" Modulo "SIGAFAT" 
    CONOUT('ZAUTONFE-PREPAROU-'+dtos(dDataBase)+'-'+time()+'-EMPRESA:'+cEmpProc+cFilProc)

    //Base para programas
    cBkpMv1  := MV_PAR01
    cBkpMv2  := MV_PAR02

    MV_PAR01 := cSerProc//Série
    MV_PAR02 := 0       //Threads

    //Realiza Transmissão - Rotina Padrão
    SetFunName("autoNfeTrans")
    autoNfeTrans()
    Sleep(10000)//Pausa por 10 segundos antes de monitorar, para garantir que irá obter o retorno

    //Realiza Monitoramento - Rotina Padrão
    SetFunName("autoNfeMon")
    autoNfeMon()

    //Restaura
    MV_PAR01 := cBkpMv1
    MV_PAR02 := cBkpMv2

    RESET ENVIRONMENT
    CONOUT('ZAUTONFE-FINALIZOU-'+dtos(dDataBase)+'-'+time()+'-EMPRESA:'+cEmpProc+cFilProc)
Return
