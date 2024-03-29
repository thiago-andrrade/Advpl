
#include "Totvs.ch"
#Include "Tbiconn.ch"

//=================================================================================
/*/{Protheus.doc} zApiDol
Api | Cotação do Dolar Ptax, Api Oficial do Banco Central
https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/documentacao
Api Dolar Ptax Banco Central x Advpl

@type       function
@author     Thiago.Andrrade
@since      04/03/2021
@version    1.1
/*/
//=================================================================================
User function zApiDol()   
    Local aHeader     := {}
    Local cDataPtx    := ''//MM-DD-AAAA
    Local oJsObj      := JsonObject():New()
    Local cJsonRt     := ''
    Local oRestClient := FWRest():New("https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata")

    //Cabeçalho
    aadd(aHeader,'User-Agent: Mozilla/4.0 (compatible; Protheus '+GetBuild()+')')
    aAdd(aHeader,'Content-Type: application/json; charset=utf-8')

    //Ajusta Padrão da Data para MM-DD-AAAA
    cDataPtx := Dtos(dDataBase-1)
    cDataPtx := SubStr(cDataPtx,5,2)+'-'+SubStr(cDataPtx,7,2)+'-'+SubStr(cDataPtx,1,4)
   
    //[GET] Consulta Dados na Api
    oRestClient:setPath("/CotacaoDolarDia(dataCotacao=@dataCotacao)?@dataCotacao='"+cDataPtx+"'&$format=json")
    If oRestClient:Get(aHeader)
        //Grava Retorno
        cJsonRt := oJsObj:FromJson(oRestClient:CRESULT)
        //Exibe Cotação
        If ValType(cJsonRt) == 'U'
            fViewCot(oJsObj)
        Endif
        //Limpa Objeto
        FreeObj(oJsObj)
    Endif
    
Return

//=================================================================================
/*/{Protheus.doc} fViewCot
Exibe Cotação

@author     Thiago.Andrrade
@since      04/03/2021
/*/
//=================================================================================
Static Function fViewCot(oJsObj)
    Local cMsg := ''

    cMsg += "<b>Data:</b> "+Dtoc(Stod(StrTran(SubStr(oJsObj["value"][1]["dataHoraCotacao"],1,10),'-','')))
    cMsg += " - "+SubStr(oJsObj["value"][1]["dataHoraCotacao"],12,5)+"h<br>"
    cMsg += "<b>Cotação de Compra:</b> "+cValToChar(oJsObj["value"][1]["cotacaoCompra"])+"<br>"
    cMsg += "<b>Cotação de Venda:</b> "+cValToChar(oJsObj["value"][1]["cotacaoVenda"])+"<br>"

    MsgInfo(cMsg,"Cotação Dolar Ptax")
Return


---
@Thiago.Andrrade
