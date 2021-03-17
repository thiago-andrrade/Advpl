//=================================================================================
/*/{Protheus.doc} zViaCep
[API.VIACEP] [GET] Conecta na Api gratuita da ViaCep para retornar dados de um Endereço
a partir do CEP. (Api CEP x Advpl)
Documentação: https://viacep.com.br/
Campos Disponiveis na API:  
BAIRRO, CEP, COMPLEMENTO, GIA, IBGE, LOCALIDADE, LOGRADOURO, UF, UNIDADE
 
Uso: Incluir/Atualizar CC2 quando necessário, Inserir Cod.Ibge Correto no Cliente
 
@author     Thiago.Andrrade
@since      24/07/2020
/*/
//=================================================================================
User Function zViaCep()
    Local aArea         := GetArea()
    Local aHeader       := {}
    Local cCep          := '03062010'
    Local cCodMun       := ''
    Local oRestClient   := FWRest():New("https://viacep.com.br/ws")
    Local oJsObj
 
    aadd(aHeader,'User-Agent: Mozilla/4.0 (compatible; Protheus '+GetBuild()+')')
    aAdd(aHeader,'Content-Type: application/json; charset=utf-8')
       
    ////////////////////////////////////////////////////////////////
    //[GET] Consulta Dados na Api
    oRestClient:setPath("/"+cCep+"/json/")
    If oRestClient:Get(aHeader)
        //Deserealiza o Json
        FWJsonDeserialize(oRestClient:CRESULT,@oJsObj)
 
        //Recebe Dados do Json
        cCodMun := SubStr(oJsObj:IBGE,3,5)
 
        /*oJsObj:BAIRRO
        oJsObj:CEP
        oJsObj:COMPLEMENTO
        oJsObj:GIA
        oJsObj:IBGE
        oJsObj:LOCALIDADE
        oJsObj:LOGRADOURO
        oJsObj:UF
        oJsObj:UNIDADE*/
 
        FreeObj(oJsObj)
    Else
        ConOut("Erro Api ViaCep: "+oRestClient:GetLastError())
    Endif
 
    RestArea(aArea)
Return

---
@Thiago.Andrrade
