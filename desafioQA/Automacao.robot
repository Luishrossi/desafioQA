*** Settings ***
# Documentation      Sendo um usuario visitante do Serasa
# ...                Quero fazer o cadastro 
# ...                Para que possa realizar consultas de Score

Resource                                ../desafioQA/Settings.robot
Test Setup                              Abrir navegador
Test Teardown                           Fechar navegador

*** Test Cases ***
Cenario 1 - Realizar cadastro com CPF inválido
    Dado que estou na pagina de cadastro do site
    Quando submeto o cadastro de um usuário com CPF que não esteja conforme é solicitado 
    Então devo visualizar a mensagem "Você precisa informar um CPF válido." 

Cenario 2 - Realizar cadastro com nome inváldo
    Dado que estou na pagina de cadastro do site
    Quando submeto o cadastro de um usuário com apenas o primeiro nome
    Então devo visualizar a mensagem "Você precisa informar um nome válido."

Cenario 3 - Realizar cadastro tendo menos de 18 anos
    Dado que estou na pagina de cadastro do site
    Quando submeto o cadastro de um usuário com a data de nascimento menor que 18 anos 
    Então devo visualizar a mensagem "Você precisa ter mais de 18 anos."

Cenario 4 - Realizar cadastro com E-mail inválido 
    Dado que estou na pagina de cadastro do site  
    Quando submeto o cadastro de um usuário com o E-mail fora dos requitos que é solicitado 
    Então devo visualizar a mensagem "Você precisa informar um e-mail válido."

Cenario 5 - Realizar cadastros com a senha inválida
    Dado que estou na pagina de cadastro do site
    Quando submeto o cadastro de um usuário com senha que não atende os requisitos minimos de segurança 
    Então devo visualizar a mensagem "Sua senha não pode conter: seu nome, sobrenome, cpf, números sequenciais ou menos de 8 caracteres."

Cenario 6 - Realizar cadastro com todos os campos preenchidos corretamente
    Dado que estou na pagina de cadastro do site
    Quando submeto o cadastro de um usuário com CPF, nome completo, data de nascimento, e-mail e senha
    E devo clicar no checkbox "Declaro que li e aceito os Termos"
    E o botão "Criar Conta Grátis" será habilitado   
    Então devo visualizar a mensagem "Alguma informação parece estar incorreta. Verifique se você preencheu todos os campos corretamente."


