<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ATUALIZAÇÃO</title>
    </head>
    <body>
        <h1>ATUALIZAÇÃO</h1>
        <%
            // Definir o driver de conexão com o banco.
                    // Class.forName("org.postgresql.Driver");
                    Class.forName("com.mysql.jdbc.Driver");
                    // Abrir conexão com o banco.
                    // Connection conexao = DriverManager.getConnection("jdbc:postgresql://127.0.0.1:5432/solicitacao_doc_bd", "solicitacao_usuario", "abc12345");
                    Connection conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/solicitacao_doc_bd?useLegacyDatetimeCode=false&serverTimezone=America/New_York", "solicitacao_usuario", "abc12345");
                       
                    // capitura o id do registro a a ser alterado
                    String id = request.getParameter("id");
                    // Executar o SQL de pesquisa.
                    PreparedStatement sql = conexao.prepareStatement("SELECT id, ra_aluno, nome_aluno, tipo_documento, situacao, data_ultima_atualizacao FROM solicitacoes WHERE id=" + id);
                    ResultSet resultado = sql.executeQuery();
                    while(resultado.next()){
        %>
        
        <p><span>ID: </span> <%= resultado.getString("id")%></p>
        <form action="index.jsp">            
            <input type="text" name="id" readonly="true" placeholder="Qual é o RA do aluno?"  value="<%= resultado.getString("id")%>" /><br />
            <input type="text" autofocus name="ra_aluno" placeholder="Qual é o RA do aluno?" value="<%= resultado.getString("ra_aluno")%>" /><br />
            <input type="text" name="nome_aluno" placeholder="Qual é o nome do aluno?" value="<%= resultado.getString("nome_aluno")%>" /><br />
            <input type="text" name="tipo_documento" placeholder="Qual é o tipo de documento?" value="<%= resultado.getString("tipo_documento")%>" /><br />
            <input type="submit" name="acao" value="atualizar" />
        </form>
        <%
            }
            // Fecha a conexão.
            conexao.close();
        %>
    </body>
</html>
