package fcu.selab.progedu.status;

public class UnitTestFailure implements Status {
  @Override
  public String getConsole(String consoleText) {
    String Tests = "";
    String unitTest = "";
    String startStr = "-------------------------------------------------------\r\n" + " T E S T S";
    String goal = "Tests run:";
    int endStr = consoleText.indexOf(goal, consoleText.indexOf(goal) + goal.length());
    int end = consoleText.indexOf("\n", endStr);
    Tests = consoleText.substring(endStr, end);

    String errorsStr = "Errors:";
    String failuresStr = "Failures:";

    int errors_goal = Tests.indexOf(errorsStr) + errorsStr.length();
    int failures_goal = Tests.indexOf(failuresStr) + failuresStr.length();

    String errors = Tests.substring(errors_goal, Tests.indexOf(",", errors_goal)).trim();
    String failures = Tests.substring(failures_goal, Tests.indexOf(",", failures_goal)).trim();

    if (errors.equals("0") && failures.equals("0"))
      return "";

    unitTest = consoleText.substring(consoleText.indexOf(startStr), end);
    System.out.println(unitTest);
    return unitTest;
  }

}
