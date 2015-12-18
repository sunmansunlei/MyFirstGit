package com.sun.commons.logs;

import java.io.Serializable;

public class LogContext
  implements Serializable
{
  private static final long serialVersionUID = 1369925984L;
  private String staff;
  private boolean logSwitch;

  public LogContext(String staff, boolean logSwitch)
  {
    this.staff = staff;
    this.logSwitch = logSwitch; }

  public String getStaff() {
    return this.staff; }

  public void setStaff(String staff) {
    this.staff = staff;
  }

  public boolean getLogSwitch()
  {
    return this.logSwitch; }

  public void setLogSwitch(boolean logSwitch) {
    this.logSwitch = logSwitch;
  }
}
