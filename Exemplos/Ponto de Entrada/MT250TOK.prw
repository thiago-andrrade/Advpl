#INCLUDE "PROTHEUS.CH"
#include "rwmake.ch"
#include "topconn.ch"
 
//=================================================================================
/*/{Protheus.doc} MT250TOK
Bloquear o Apontamento de Produção por um periodo determinado [MATA250]
 
@type       function
@author     Thiago.Andrrade
@since      04/10/2019
@version    1.0
 
/*/
//=================================================================================
 
User Function MT250TOK
    Local lRet  := .T.

    If DTOS(dDatabase) == "20191031"
        msgstop ("Apontamento de Produção Bloqueado até a finalização da Virada de Saldos do Estoque !")
        lRet  := .F.
    Endif
Return (lRet)
 
 
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
> Exemplo 2 - Bloquear Apontamento de Produto Acabado em um determinado Armazém
 
 
//=================================================================================
/*/{Protheus.doc} MT250TOK
Bloquear Apontamento de PA no 08 e 09
 
@type       function
@author     Thiago.Andrrade
@since      04/10/2019
@version    1.0
 
/*/
//=================================================================================
 
User Function MT250TOK 
     Local lRet  := .T.

     cTipo   := Posicione("SB1",1,FwxFilial("SB1")+M->D3_COD,"B1_TIPO")

     If cFilAnt == '02'
         If M->D3_LOCAL $ "08/09"
             If cTipo == "PA"
                 msgstop ("Não é permitido realizar o apontamento de PA no Armazém "+ M->D3_LOCAL +" !")
                 lRet  := .F.
             Endif
         Endif
     Endif
Return (lRet)

---
@Thiago.Andrrade
