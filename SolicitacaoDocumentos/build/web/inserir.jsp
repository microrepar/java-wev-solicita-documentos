<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nova Solicitação</title>
    </head>
    <body>
        <h1>Nova Solicitação</h1>
        <form action="index.jsp">           
            <input type="text" autofocus name="ra_aluno" placeholder="Qual é o RA do aluno?" /><br />
            <input type="text" name="nome_aluno" placeholder="Qual é o nome do aluno?" /><br />
            <input type="text" name="tipo_documento" placeholder="Qual é o tipo de documento?" /><br />
            <input type="submit" name="acao" value="inserir" />
        </form>
    </body>
</html>
