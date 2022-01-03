*** Settings ***

Resource                              ../desafioQA/Settings.robot

*** Variables ***
${browser}                            firefox
${url}                                https://www.serasa.com.br/cadastrar?product=portal&redirectUrl=%2Farea-cliente%2F
${field_cpf}                          id=cpf
${field_nome}                         id=name
${field_data}                         id=birthDate
${field_email}                        id=email
${field_senha}                        id=password
${check_termos}                       xpath=//*[@id="sign_up_form"]/div[7]/label/span
${button_criarConta}                  xpath=//*[@id="sign_up_form"]/div[8]/input
${mensagem_cpf}                       Você precisa informar um CPF válido.
${mensagem_nome}                      Você precisa informar um nome válido.
${mensagem_dt_nascimento}             Você precisa ter mais de 18 anos.
${mensagem_email}                     Você precisa informar um e-mail válido.
${mensagem_senha}                     Sua senha não pode conter: seu nome, sobrenome, cpf, números sequenciais ou menos de 8 caracteres.
${mensagem_contaCriada}               Alguma informação parece estar incorreta. Verifique se você preencheu todos os campos corretamente.

*** Keywords ***
   [Documentation]                   SETUP E TEARDOWN 
Abrir navegador
   Open Browser                       about:blank     ${browser}                    

Fechar navegador
   Close Browser

   [Documentation]                      AÇÕES DENTRO DA SUÍTE
Dado que estou na pagina de cadastro do site
   Maximize Browser Window
   Go To                              ${url}
   Title Should Be                    Criar conta - Serasa

Quando submeto o cadastro de um usuário com CPF, nome completo, data de nascimento, e-mail e senha
   ${cpf}                             FakerLibrary.cpf 
   Input Text                         ${field_cpf}          ${cpf} 

   ${primeiro_nome}                   FakerLibrary.first_name
   ${segundo_nome}                    FakerLibrary.last_name
   Input Text                         ${field_nome}         ${primeiro_nome} ${segundo_nome}
                                                
   ${ano}                             Evaluate  random.randint(1950,2003)  random
   ${data}                            FakerLibrary.date     %d%m  None 

   Input Text                         ${field_data}         ${data}${ano}

   ${email}                           FakerLibrary.free_email
   Input Text                         ${field_email}        ${email}

   ${senha}                           FakerLibrary.password 
   Input Text                         ${field_senha}        ${senha}

Quando submeto o cadastro de um usuário com CPF que não esteja conforme é solicitado
   ${cpf}                             Generate Random String
   Input Text                         ${field_cpf}          ${cpf}
   Press Keys                         ${field_cpf}          TAB

Quando submeto o cadastro de um usuário com apenas o primeiro nome
   ${primeiro_nome}                   FakerLibrary.first_name
   Input Text                         ${field_nome}         ${primeiro_nome}
   Press Keys                         ${field_nome}         TAB

Quando submeto o cadastro de um usuário com a data de nascimento menor que 18 anos
   ${data}                            FakerLibrary.date     %d%m    None 
   Input Text                         ${field_data}         ${data}2004
   Press Keys                         ${field_data}         TAB

Quando submeto o cadastro de um usuário com o E-mail fora dos requitos que é solicitado 
   ${email}                           FakerLibrary.first_name
   Input Text                         ${field_email}        ${email}.com
   Press Keys                         ${field_email}        TAB

Quando submeto o cadastro de um usuário com senha que não atende os requisitos minimos de segurança 
   ${senha}                           FakerLibrary.Building_number
   Input Text                         ${field_senha}        ${senha}
   Press Keys                         ${field_senha}        TAB

E devo clicar no checkbox "Declaro que li e aceito os Termos"
   Click Element                      ${check_termos}

E o botão "Criar Conta Grátis" será habilitado
   Click Element                      ${button_criarConta}
                                 
   [Documentation]                    RESULTADOS ESPERADOS
Então devo visualizar a mensagem "Alguma informação parece estar incorreta. Verifique se você preencheu todos os campos corretamente."
   Wait Until Page Contains           ${mensagem_contaCriada}
   Page Should Contain                ${mensagem_contaCriada}

Então devo visualizar a mensagem "Sua senha não pode conter: seu nome, sobrenome, cpf, números sequenciais ou menos de 8 caracteres."
   Wait Until Page Contains           ${mensagem_senha}
   Page Should Contain                ${mensagem_senha}

Então devo visualizar a mensagem "Você precisa informar um e-mail válido."
   Wait Until Page Contains           ${mensagem_email}
   Page Should Contain                ${mensagem_email}

Então devo visualizar a mensagem "Você precisa ter mais de 18 anos."
   Wait Until Page Contains           ${mensagem_dt_nascimento}
   Page Should Contain                ${mensagem_dt_nascimento}

Então devo visualizar a mensagem "Você precisa informar um nome válido."
   Wait Until Page Contains           ${mensagem_nome}
   Page Should Contain                ${mensagem_nome} 

Então devo visualizar a mensagem "Você precisa informar um CPF válido."
   Wait Until Page Contains           ${mensagem_cpf}
   Page Should Contain                ${mensagem_cpf}



