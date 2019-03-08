package fcu.selab.progedu.conn;

import java.io.IOException;
import java.io.Writer;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.gitlab.api.models.GitlabSession;

import fcu.selab.progedu.config.GitlabConfig;
import fcu.selab.progedu.exception.LoadConfigFailureException;

/**
 * Servlet implementation class AfterEnter
 */
public class LoginTest extends HttpServlet {
  private static final long serialVersionUID = 1L;
  private static final String USER_NAME = "username";
  private static final String PRIVATE_TOKEN = "private_token";
  GitlabConfig gitData = GitlabConfig.getInstance();
  private Conn conn = Conn.getInstance();
  boolean isEnter = true;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public LoginTest() {
    super();
  }

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    doPost(request, response);
  }

  /**
   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    final HttpSession session = request.getSession();
    String username = request.getParameter(USER_NAME);
    String password = request.getParameter("password");

    Writer wf = response.getWriter();
    if ( username.equals("root") && password.equals("zxcv1234") ) {
      wf.write("s");
    } else {
      wf.write("f");
    }
    Cookie cookie = new Cookie("SESSTIONID", session.getId());
    response.addCookie(cookie);
  }

  /**
   * Check if username and password is correct
   * 
   * @param username User name
   * @param password User password
   * @return private token
   */
  public String checkEnter(String username, String password) {
    String privateToken = null;
    GitlabSession gitSession = conn.getSession(username, password);
    if (gitSession != null) {
      isEnter = true;
      privateToken = gitSession.getPrivateToken();
      System.out.println("token : " + gitSession.getPrivateToken());
    } else {
      isEnter = false;
      privateToken = "Unauthorized";
      System.out.println("token : Unauthorized");
      Logger.getLogger(AfterEnter.class.getName()).log(Level.INFO,
          username + ", " + password + ", token : Unauthorized");
    }
    return privateToken;
  }

  /**
   * After check, send redirect
   * 
   * @param response     HttpServletResponse
   * @param privateToken Check return private token
   */
  public void sendRedirect(HttpServletResponse response, HttpSession session, String privateToken,
      String username) {
    try {
      if (isEnter) {
        if (privateToken.equals(gitData.getGitlabApiToken())) {
          session.setAttribute("page", "dashboard.jsp");
          session.setAttribute(USER_NAME, username);
          response.sendRedirect("dashboard.jsp");
        } else {
          session.setAttribute("page", "studentDashboard.jsp");
          session.setAttribute(PRIVATE_TOKEN, privateToken);
          Cookie cookie = new Cookie(PRIVATE_TOKEN, privateToken);
          response.addCookie(cookie);
          session.setAttribute(USER_NAME, username);
          response.sendRedirect("studentDashboard.jsp");
        }
      } else {
        session.setAttribute("enterError", "Enter Error");
        session.setAttribute(PRIVATE_TOKEN, privateToken);
        response.sendRedirect("index.jsp");
      }
    } catch (LoadConfigFailureException | IOException e) {
      e.printStackTrace();
    }
  }

}
