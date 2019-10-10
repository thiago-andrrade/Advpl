> Exemplo 1 - Inserir Mensagem na tela de Login do Protheus

#include "rwmake.ch"
#include "protheus.ch"   
#include 'parmtype.ch'
#include 'vkey.ch'
#INCLUDE "TOTVS.CH"

//---------------------------------------------------------------------------------
/*/{Protheus.doc} AfterLogin
Inserir Mensagem na tela de Login do Protheus

@type     function
@author		Thiago.Andrrade
@since		07/05/2019
@version	1.0
/*/
//---------------------------------------------------------------------------------


User Function AfterLogin

	Msginfo("Você se conectou na base TESTE, tudo que inserir nesta base NÃO será enviado para base Oficial!")

Return

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

> Exemplo 2 - Validar Conexão e Permitir login de acordo com uma Variável

#include "rwmake.ch"
#include "protheus.ch"   
#include 'parmtype.ch'
#include 'vkey.ch'
#INCLUDE "TOTVS.CH"

//---------------------------------------------------------------------------------
/*/{Protheus.doc} AfterLogin
Validar Conexão e Permitir login de acordo com uma Variável

@type     function
@author		Thiago.Andrrade
@since		07/05/2019
@version	1.0
@Obs		Impedir Login de Vendedor Desativado no meio tempo existente entre a
        comunicação interna e o bloqueio real do login no Configurador
/*/
//---------------------------------------------------------------------------------


User Function AfterLogin

Local cTipo := Posicione("SA3",1,FwxFilial("SA3")+ALLTRIM(CUSERNAME),"A3_TIPO")	
	
	If substr(CUSERNAME,1,1) == '0'
		If cTipo == "D"
			Final("Atenção", "Vendedor DESATIVADO !")
		Endif
	Endif

Return

---
@Thiago.Andrrade
