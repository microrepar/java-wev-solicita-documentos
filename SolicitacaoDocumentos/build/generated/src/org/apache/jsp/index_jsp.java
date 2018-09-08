package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.DriverManager;
import java.sql.Connection;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Listagem de Solicitações de Documento</title>\n");
      out.write("        <style>\n");
      out.write("            .icone_excluir {\n");
      out.write("                width: 20px;\n");
      out.write("            }\n");
      out.write("        </style>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <h1>Listagem de Solicitações de Documento</h1>\n");
      out.write("        <a href=\"inserir.jsp\">NOVO</a>\n");
      out.write("        <form action=\"index.jsp\">\n");
      out.write("            <input type=\"text\" name=\"filtrar\" placeholder=\"Informe um filtro\" /><input type=\"submit\" name=\"pesquisar\" value=\"Pesquisar\" />\n");
      out.write("        </form>\n");
      out.write("        <table border=\"1\">\n");
      out.write("            <thead>\n");
      out.write("                <tr>\n");
      out.write("                    <th>RA</th>\n");
      out.write("                    <th>Nome do Aluno</th>\n");
      out.write("                    <th>Tipo de Documento</th>\n");
      out.write("                    <th>Situação</th>\n");
      out.write("                    <th>Data</th>\n");
      out.write("                    <th>Excluir</th>\n");
      out.write("                </tr>\n");
      out.write("            </thead>\n");
      out.write("            <tbody>\n");
      out.write("                ");


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
                        }
                    }

                    // Executar o SQL de pesquisa.
                    PreparedStatement sql = conexao.prepareStatement("SELECT id, ra_aluno, nome_aluno, tipo_documento, situacao, data_ultima_atualizacao FROM solicitacoes");
                    ResultSet resultado = sql.executeQuery();
                    while (resultado.next()) {
                
      out.write("\n");
      out.write("                <tr>\n");
      out.write("                    <td>");
      out.print( resultado.getString("ra_aluno"));
      out.write("</td>\n");
      out.write("                    <td>");
      out.print( resultado.getString("nome_aluno"));
      out.write("</td>\n");
      out.write("                    <td>");
      out.print( resultado.getString("tipo_documento"));
      out.write("</td>\n");
      out.write("                    <td>");
      out.print( resultado.getString("situacao"));
      out.write("</td>\n");
      out.write("                    <td>");
      out.print( resultado.getDate("data_ultima_atualizacao"));
      out.write("</td>\n");
      out.write("                    <td><a href=\"index.jsp?acao=excluir&id=");
      out.print( resultado.getString("id"));
      out.write("\"><img class=\"icone_excluir\" src=\"lata_lixo.svg\" alt=\"Imagem de uma lata de lixo\"/></a></td>\n");
      out.write("                </tr>\n");
      out.write("                ");

                    }

                    // Fecha a conexão.
                    conexao.close();

                
      out.write("\n");
      out.write("            </tbody>\n");
      out.write("        </table>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
