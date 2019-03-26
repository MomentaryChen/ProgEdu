package fcu.selab.progedu.conn;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

public class SessionContext {
  
  private static SessionContext instance ;
  private HashMap<String, HttpSession> sessionMap;
  
  private SessionContext() {
    sessionMap = new HashMap<String, HttpSession>();
  }
  
  /** only one SesstionContext .
   * 
   * @return instance 
   */
  public static SessionContext getInstance() {
    if (instance == null) {
      return new SessionContext();
    } else {
      return instance;
    }
  }
  
  /**add the session into the HashMap .
   * 
   * @param session is the new.
   */
  public synchronized void addSession(HttpSession session) {
    if (session != null) {
      sessionMap.put(session.getId(), session);
      System.out.println(session.getId());
    }
  }
  /**use the session id to get the session.
   * 
   * @param session is .
   */
  
  public synchronized HttpSession getSession(HttpSession session) {
    if (session != null) {
      return sessionMap.get(session.getId());
    } else {
      return null;
    }
  }
  /**delete the session from sessionMap.
   * 
   * @param session is been deleted.
   */
  
  public synchronized void delSession(HttpSession session) {
    if (session != null) {
      sessionMap.remove(session.getId());
    }
  }

}
