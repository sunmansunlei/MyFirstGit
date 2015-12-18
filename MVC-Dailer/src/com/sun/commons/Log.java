package com.sun.commons;


import com.sun.commons.logs.BssLoggerWrapper;
import com.sun.commons.logs.LogContext;
import com.sun.commons.logs.LogContextHolder;


public class Log
{
  private BssLoggerWrapper log;
  private static final String defaultLogName = "com.linkage.bss.commons.util.Log";

  private Log(String name)
  {
    this.log = new BssLoggerWrapper(name);
  }

  public static Log getLog(String name)
  {
    String s = name;
    if (s == null)
      s = "com.linkage.bss.commons.util.Log";
    return new Log(s);
  }

  public static Log getLog(Class clazz)
  {
    String s = "com.linkage.bss.commons.util.Log";
    if (clazz != null)
      s = clazz.getName();
    return getLog(s);
  }

  private static LogModel getLogModel()
  {
    LogModel model = LogModel.RunTimeClose;
    LogContext logContext = LogContextHolder.getLogContext();
    if (logContext != null)
      if (logContext.getLogSwitch())
        model = LogModel.RunTimeOpen;
      else
        model = LogModel.RunTimeClose;

    else
      model = LogModel.Develop;

    return model;
  }

  private static boolean isLogOpen(LogModel model)
  {
    return ((model == LogModel.RunTimeOpen) || (model == LogModel.Develop));
  }

  private static boolean isLogOpen()
  {
    return isLogOpen(getLogModel());
  }

  private static String buildLogContextInfo()
  {
    long threadId = Thread.currentThread().getId();
    String staff = null;
    LogContext logContext = LogContextHolder.getLogContext();
    if (logContext != null)
      staff = logContext.getStaff();

    StringBuilder sb = new StringBuilder();
    sb.append("BSS_LOGGER:threadId=");
    sb.append(threadId);
    sb.append(",staff=");
    sb.append(staff);
    sb.append(",info=");
    return sb.toString();
  }

  public void debug(String message, Object[] args)
  {
    LogModel model;
    try
    {
      model = getLogModel();
      if (!(isLogOpen(model))) return;
      if (model == LogModel.RunTimeOpen) {
        this.log.debug(buildLogContextInfo() + message, args); return;
      }
      this.log.debug(message, args);
    }
    catch (Throwable e) {
      e.printStackTrace();
    }
  }

  public void info(String message, Object[] args)
  {
    LogModel model;
    try
    {
      model = getLogModel();
      if (!(isLogOpen(model))) return;
      if (model == LogModel.RunTimeOpen) {
        this.log.info(buildLogContextInfo() + message, args); return;
      }
      this.log.info(message, args);
    }
    catch (Throwable e) {
      e.printStackTrace();
    }
  }

  public void warn(String message, Object[] args)
  {
    LogModel model;
    try
    {
      model = getLogModel();
      if (!(isLogOpen(model))) return;
      if (model == LogModel.RunTimeOpen) {
        this.log.warn(buildLogContextInfo() + message, args); return;
      }
      this.log.warn(message, args);
    }
    catch (Throwable e) {
      e.printStackTrace();
    }
  }

  public void trace(String message, Object[] args)
  {
    LogModel model;
    try
    {
      model = getLogModel();
      if (!(isLogOpen(model))) return;
      if (model == LogModel.RunTimeOpen) {
        this.log.trace(buildLogContextInfo() + message, args); return;
      }
      this.log.trace(message, args);
    }
    catch (Throwable e) {
      e.printStackTrace();
    }
  }

  public void error(String message, Object[] args)
  {
    LogModel model;
    try
    {
      model = getLogModel();

      if (model == LogModel.RunTimeOpen) {
        this.log.error(buildLogContextInfo() + message, args); return;
      }
      this.log.error(message, args);
    }
    catch (Throwable e) {
      e.printStackTrace();
    }
  }

  public void error(String message, Throwable e)
  {
    LogModel model;
    try
    {
      model = getLogModel();

      if (model == LogModel.RunTimeOpen) {
        this.log.error(buildLogContextInfo() + message, e); return;
      }
      this.log.error(message, e);
    }
    catch (Throwable error) {
      error.printStackTrace();
    }
  }

  public boolean isDebugEnabled()
  {
    try
    {
      if (this.log == null)
        return false;

      return ((isLogOpen()) && (this.log.isDebugEnabled())); } catch (Throwable e) {
    }
    return false;
  }

  public boolean isErrorEnabled()
  {
    try
    {
      if (this.log == null) {
        return false;
      }

      return this.log.isErrorEnabled(); } catch (Throwable e) {
    }
    return false;
  }

  public boolean isInfoEnabled()
  {
    try
    {
      if (this.log == null)
        return false;
      return ((isLogOpen()) && (this.log.isInfoEnabled())); } catch (Throwable e) {
    }
    return false;
  }

  public boolean isTraceEnabled()
  {
    try
    {
      if (this.log == null)
        return false;
      return ((isLogOpen()) && (this.log.isTraceEnabled())); } catch (Throwable e) {
    }
    return false;
  }

  public boolean isWarnEnabled()
  {
    try
    {
      if (this.log == null)
        return false;
      return ((isLogOpen()) && (this.log.isWarnEnabled())); } catch (Throwable e) {
    }
    return false;
  }

  private static enum LogModel
  {
    RunTimeOpen, RunTimeClose, Develop;
  }
}