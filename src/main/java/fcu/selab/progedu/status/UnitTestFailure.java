package fcu.selab.progedu.status;

public class UnitTestFailure implements Status {
  @Override
  public String getConsole(String consoleText) {
    String consoleTest = "";
    String startStr = "-------------------------------------------------------\n T E S T S";
    String goal = "Tests run:";
    int endStr = consoleText.indexOf(goal, consoleText.indexOf(goal) + goal.length());
    int end = consoleText.indexOf("\n", endStr);
    consoleTest = consoleText.substring(consoleText.indexOf(startStr) - 1, end);

    char errors = consoleTest.charAt(consoleTest.length() - 13);
    char failures = consoleTest.charAt(consoleTest.length() - 24);

    if (errors == '0' && failures == '0')
      return consoleTest;

    return "";
  }

}
