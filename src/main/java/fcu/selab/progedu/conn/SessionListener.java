package fcu.selab.progedu.conn;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SessionListener implements HttpSessionListener {

  private SessionContext sessionContext = SessionContext.getInstance(); 

  /**created the session
   * 
   */
  
  public void sessionCreated(HttpSessionEvent se) {
    HttpSession session = se.getSession();
    sessionContext.addSession(session);
  }
  /** destroyed the session
   * 
   */ 
  
  public void sessionDestroyed(HttpSessionEvent se) {
    HttpSession session = se.getSession();
    sessionContext.delSession(session);
    System.out.println("Sesstion DEL");
  }
  
}
