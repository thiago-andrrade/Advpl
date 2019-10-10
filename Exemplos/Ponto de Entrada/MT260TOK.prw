#INCLUDE "RWMAKE.CH"
#INCLUDE 'protheus.ch'

//=================================================================================
/*/{Protheus.doc} MT260TOK
Bloqueio de Transf. Simples de PA no Armazem 08 e 09 	(MATA260)

@type		function
@author		Thiago.Andrrade
@since		01/10/2019
@version	1.0
@return		.T. Libera transferencia
/*/
//=================================================================================

User Function MT260TOK

Local lRet:= .T.

If cFilant == "02"
	If CLOCDEST $ "08/09"
		If SB1->B1_TIPO == "PA"
			msgstop ("Não é permitido realizar Transferência de PA no Armazém "+ CLOCDEST +"!") 
			lRet  := .F.
		Endif
	Endif
Endif

Return lRet

---
@Thiago.Andrrade
