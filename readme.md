Documentação Sistema Banco

Informações de uso:

1. Criar uma nova conta
Antes de iniciar o uso do sistema bancário é necessário selecionar a opção (2) "Quero me tornar cliente", localizada no menu inicial.
Informe os dados solicitados, como nome completo do titular, CPF, Logradouro, Número, Bairro, Cidade, Estado, País, Cep, DDD, Telefone de contato.

2. Criação de Conta no Banco
Após finalizar o cadastro do novo cliente, o sistema vai realizar a criação da nova gerando automaticamente seu número e infrormando na tela.
Esse número é intransferível e deve ser guardado com cuidado, pois apenas com ele o novo úsuario consiguirá acessar o sistema do banco.

3. Acessar uma conta existente
Para acessar uma conta existente, selecione a opção (1) "Já sou cliente" no menu inicial.

4. Consultar saldo
Após acessar a conta para realizar a consulta do saldo, selecione a opção (1) "Consultar saldo" no menu principal.
Seu saldo atualizado será informado na tela.

5. Realizar depósito
Após acessar a conta para realizar um depósito, selecione a opção (2) "Depósito" no menu principal, informe o valor a ser depositado e o número do Destinatário.
O sistema realizará automaticamente a consulta do seu saldo e caso o valor informado esteja disponivel na conta. A confirmação do depósito realizado é informada na tela.

6. Realizar saque
Após acessar a conta para realizar um saque, selecione a opção (3) "Saque" no menu principal, informe o valor a ser retirado e o *número da conta.
O sistema realizará automaticamente a consulta do seu saldo e caso o valor informado esteja disponivel na conta ou o cliente possuir limite. A confirmação do saque realizado é informada na tela.
Caso seja necessário utilizar o limite do cheque especial, o saldo devedor é informado na tela.

7. Realizar transferência
Após acessar a conta para realizar uma transferência, selecione a opção (4) "Transferência" no menu principal, informe o tipo de transferência que será realizada (PIX ou TED) o valor a ser transferido,
o número do Destinatário e o *número da conta que será retirado.
O sistema realizará automaticamente a verificação se a conta de destino é válida (se está cadastrada no banco) e a consulta do seu saldo e caso o valor informado esteja disponivel na conta ou o cliente possuir limite.
A confirmação da transferência realizada é informada na tela.
Caso seja necessário utilizar o limite do cheque especial, o saldo devedor é informado na tela.
Em transfêrencias (TED) realizadas para contas de diferentes titularidade, será realizado a cobrança de 1% de juros referente ao valor da transação.

8. Consulta de extrato
Após acessar a conta para realizar uma consulta de extrato, selecione a opção (5) "Extrato Bancário" no menu principal. Será exibido na tela o tipo da transação,
origem, destino, valor e data das ultimas transações realizadas da conta.

9. Acessar o menu inicial
Após acessar a conta para acessar o menu inicial, selecione a opção (6) "Para voltar ao menu inicial" no menu principal.

10. Encerrar a sessão
Para encerrar a sessão, selecione a opção (3) "Sair" no menu inicial.

Estrutura do Projeto
main.rb: Arquivo principal da aplicação que contém o loop do menu e a interação com o usuário.
account.rb: Classe responsável por representar uma conta bancária.
database.rb: Classe que gerencia a conexão com o banco de dados.
migrations/: Pasta que contém as migrações do banco de dados.
models/: Pasta que contém os modelos de dados utilizados na aplicação.

Considerações Finais
O Sistema de Conta de Banco feito é uma aplicação simples e pode ser expandida com novos recursos.
Caso haja dúvidas ou problemas, entre em contato.