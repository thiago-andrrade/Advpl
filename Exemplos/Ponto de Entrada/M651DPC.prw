#Include "Protheus.ch"

//=================================================================================
/*/{Protheus.doc} M651DPC
Valida o duplo clique ao firmar OP

@type     function
@author   Thiago.Andrrade
@since    07/12/2018
@version  1.0
@return   .T. -> Permite Firmar OP
          .F. -> Não permite Firma OP
/*/
//=================================================================================

User Function M651DPC()

Local lRet := .T.
xcUsuario := Alltrim(cUSERNAME)

If cEmpAnt == '01'
  If !substr(xcUsuario,1,4) $ "PCP4/PCP5"
		MSGStop("Usuario sem permissão para Firmar OP!")		
    lRet   := .F. 
	Endif
Endif

Return(lRet)
