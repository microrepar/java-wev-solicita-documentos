<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listagem de Solicitações de Documento</title>
        <style>
            .icone {
                width: 20px;
            }
        </style>
    </head>
    <body>
        <h1>Listagem de Solicitações de Documento</h1>
        <a href="inserir.jsp">NOVO</a>
        <form action="index.jsp">
            <input type="radio" name="filtro" checked value="nome_aluno">Nome
            <input type="radio" name="filtro"  value="tipo_documento">Tipo documento
            <input type="radio" name="filtro"  value="situacao">Situação
            <input type="text" name="valor" autofocus placeholder="Informe um filtro" /><input type="submit" name="acao" value="filtrar" />
        </form>
        <table border="1">
            <thead>
                <tr>
                    <th>id</th>
                    <th>RA</th>
                    <th>Nome do Aluno</th>
                    <th>Tipo de Documento</th>
                    <th>Situação</th>
                    <th>Data</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <%

                    // Definir o driver de conexão com o banco.
                    // Class.forName("org.postgresql.Driver");
                    Class.forName("com.mysql.jdbc.Driver");
                    // Abrir conexão com o banco.
                    // Connection conexao = DriverManager.getConnection("jdbc:postgresql://127.0.0.1:5432/solicitacao_doc_bd", "solicitacao_usuario", "abc12345");
                    Connection conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/solicitacao_doc_bd?useLegacyDatetimeCode=false&serverTimezone=America/New_York", "solicitacao_usuario", "abc12345");

                    // Verificar se foi recebida alguma ação.
                    // Se for ação de exclusão, exclui o registro do banco de dados.
                    if (null != request.getParameter("acao")) {
                        if (request.getParameter("acao").equals("excluir")) {
                            String id = request.getParameter("id");
                            PreparedStatement sql = conexao.prepareStatement("DELETE FROM solicitacoes WHERE id=" + id);
                            sql.executeUpdate();
                        } else if (request.getParameter("acao").equals("inserir")) {
                            PreparedStatement sql = conexao.prepareStatement("INSERT INTO solicitacoes(ra_aluno, nome_aluno, tipo_documento, situacao, data_solicitacao, data_ultima_atualizacao) VALUES(?,?,?,?,?,?)");
                            sql.setString(1, request.getParameter("ra_aluno"));
                            sql.setString(2, request.getParameter("nome_aluno"));
                            sql.setString(3, request.getParameter("tipo_documento"));
                            sql.setString(4, "Solicitado");
                            sql.setDate(5, new java.sql.Date(System.currentTimeMillis()));
                            sql.setDate(6, new java.sql.Date(System.currentTimeMillis()));
                            sql.executeUpdate();
                        } else if (request.getParameter("acao").equals("atualizar")) {
                            String id = request.getParameter("id");
                            String strAtualizar = "UPDATE solicitacoes SET ra_aluno = ?, nome_aluno = ?, tipo_documento = ? WHERE id = ?";
                            PreparedStatement sql = conexao.prepareStatement(strAtualizar);
                            sql.setString(1, request.getParameter("ra_aluno"));
                            sql.setString(2, request.getParameter("nome_aluno"));
                            sql.setString(3, request.getParameter("tipo_documento"));
                            sql.setString(4, id);
                            sql.executeUpdate();
                        } else if (request.getParameter("acao").equals("filtrar")) {
                            String filtro = request.getParameter("filtro");
                            String valor = request.getParameter("valor");
                            System.out.println(filtro);
                            System.out.println(valor);
                            PreparedStatement sql = conexao.prepareStatement("SELECT id, ra_aluno, nome_aluno, tipo_documento, situacao, data_ultima_atualizacao FROM solicitacoes  WHERE " + filtro + " LIKE '%" + valor + "%'");
                            //sql.setString(1, filtro);
                            //sql.setString(2, valor);
                            // Executar o SQL de pesquisa.
                            ResultSet resultado = sql.executeQuery();
                            while (resultado.next()) {
                %>
                <tr>
                    <td><%= resultado.getString("id")%></td>
                    <td><%= resultado.getString("ra_aluno")%></td>
                    <td><%= resultado.getString("nome_aluno")%></td>
                    <td><%= resultado.getString("tipo_documento")%></td>
                    <td><%= resultado.getString("situacao")%></td>
                    <td><%= resultado.getDate("data_ultima_atualizacao")%></td>
                    <td>
                        <a href="index.jsp?acao=excluir&id=<%= resultado.getString("id")%>"><img class="icone" src="lata_lixo.svg" alt="Imagem de uma lata de lixo"/></a>
                        <a href="atualizar.jsp?acao=atualizar&id=<%= resultado.getString("id")%>"><img class="icone" src="atualizar_icone.png" alt="Imagem de um lapis"/></a>
                    </td>
                </tr>
                <%
                        }//while
                    }

                    if (!request.getParameter("acao").equals("filtrar")) {
                        // Executar o SQL de pesquisa.
                        PreparedStatement sql = conexao.prepareStatement("SELECT id, ra_aluno, nome_aluno, tipo_documento, situacao, data_ultima_atualizacao FROM solicitacoes");
                        ResultSet resultado = sql.executeQuery();
                        while (resultado.next()) {
                %>
                <tr>
                    <td><%= resultado.getString("id")%></td>
                    <td><%= resultado.getString("ra_aluno")%></td>
                    <td><%= resultado.getString("nome_aluno")%></td>
                    <td><%= resultado.getString("tipo_documento")%></td>
                    <td><%= resultado.getString("situacao")%></td>
                    <td><%= resultado.getDate("data_ultima_atualizacao")%></td>
                    <td>
                        <a href="index.jsp?acao=excluir&id=<%= resultado.getString("id")%>"><img class="icone" src="lata_lixo.svg" alt="Imagem de uma lata de lixo"/></a>
                        <a href="atualizar.jsp?acao=atualizar&id=<%= resultado.getString("id")%>"><img class="icone" src="atualizar_icone.png" alt="Imagem de um lapis"/></a>
                    </td>
                </tr>
                <%
                        }//while
                    }
                } else { //if (null != request.getParameter("acao"))
                    // Executar o SQL de pesquisa.
                    PreparedStatement sql = conexao.prepareStatement("SELECT id, ra_aluno, nome_aluno, tipo_documento, situacao, data_ultima_atualizacao FROM solicitacoes");
                    ResultSet resultado = sql.executeQuery();
                    while (resultado.next()) {
                %>
                <tr>
                    <td><%= resultado.getString("id")%></td>
                    <td><%= resultado.getString("ra_aluno")%></td>
                    <td><%= resultado.getString("nome_aluno")%></td>
                    <td><%= resultado.getString("tipo_documento")%></td>
                    <td><%= resultado.getString("situacao")%></td>
                    <td><%= resultado.getDate("data_ultima_atualizacao")%></td>
                    <td>
                        <a href="index.jsp?acao=excluir&id=<%= resultado.getString("id")%>"><img class="icone" src="lata_lixo.svg" alt="Imagem de uma lata de lixo"/></a>
                        <a href="atualizar.jsp?acao=atualizar&id=<%= resultado.getString("id")%>"><img class="icone" src="atualizar_icone.png" alt="Imagem de um lapis"/></a>
                    </td>
                </tr>
                <%
                        }
                    }
                    // Fecha a conexão.
                    conexao.close();

                %>
            </tbody>
        </table>
    </body>
</html>
