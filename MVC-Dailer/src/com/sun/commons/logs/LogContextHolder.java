package com.sun.commons.logs;

public class LogContextHolder
{
  private static final ThreadLocal<LogContext> logContextHolder = new InheritableThreadLocal();

  public static void clearLogContext()
  {
    setLogContext(null);
    logContextHolder.remove();
  }

  public static void setLogContext(LogContext logContext) {
    logContextHolder.set(logContext);
  }

  public static LogContext getLogContext() {
    return ((LogContext)logContextHolder.get());
  }
}
