#include "protheus.ch"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

//=================================================================================
/*/{Protheus.doc} MT440AT
Regra para Impedir a Liberação do Pedido para Vendedor Desativado

@type     function
@author		Thiago.Andrrade
@since		07/10/2019 
@version	1.0
/*/
//=================================================================================

User Function MT440AT()

Local _lRet	:= .T.

cTipo := Posicione("SA3",1,FwxFilial("SA3")+ALLTRIM(M->C5_VEND1),"A3_TIPO")

If cEmpAnt == "01"
	If cTipo == "D"
		MsgStop("Vendedor "+M->C5_VEND1+" Desativado! Ajuste o cadastro antes de prosseguir!")
		_lRet	:= .F.
	Endif
Endif

Return _lRet

---
@Thiago.Andrrade
